require "lita"

module Lita
  module Handlers

    # Provides a location decision helper
    class LocationDecision < Handler

      route %r{^(?:remember|store|save)\s+(.+)\s+(?:in|for)\s+(.+)\s*$}i,
        :remember_location, command: true,
        help: {"remember <location> in <group>" => "store a location in a group"}

      route %r{^(?:wipe|erase|empty)\s+all\s+(?:in|for)\s+(.+)\s*$}i,
            :forget_all_locations, command: true,
            help: {"wipe all in <group>" => "wipe all locations in a group",}


      route %r{^(?:forget|del|delete|rm)\s+(.+)\s+(?:in|for)\s+(.+)\s*$}i,
        :forget_location, command: true,
        help: {"forget <location> in <group>" => "forget a location in a group"}


      route %r{^(?:list|show|ls)\s+(?:all\s+)?(?:in|for|from)\s+(.+)\s*$}i,
        :list_locations, command: true,
        help: { "list all for <group>" => "list all locations in a group",}


      route %r{^(?:pick|choose|rand|random|select)\s+(?:in|for|from)\s+(.+)\s*$}i,
        :choose_location, command: true,
        help: { "pick from <group>" => "randomly pick from all locations in a group"}


      def remember_location(response)
        location = response.matches[0][0]
        group = response.matches[0][1]

        if location == 'all'
          response.reply "can't store a location called \"all\""
          return true
        end

        locations = get_locations(group)

        locations = [] if locations.nil?

        locations << location

        update_locations group, locations

        response.reply "I have added #{location} to the list of #{group} locations."
      end

      def forget_location(response)
        location = response.matches[0][0]
        group = response.matches[0][1]

        locations = get_locations(group)

        if locations.nil?
          response.reply no_locations(group)
          return
        end

        locations.reject! {|item| item.downcase.eql?(location.downcase) }

        update_locations group, locations

        response.reply "I have removed #{location} from the list of #{group} locations."
      end

      def forget_all_locations(response)
        group = response.matches[0][0]
        locations = get_locations(group)
        if locations
          redis.del("location-decision:#{group}")
          response.reply "I have removed all #{group} locations."
        else
          response.reply no_locations(group)
        end

      end

      def list_locations(response)
        group = response.matches[0][0]

        locations = get_locations(group)

        if locations.nil?
          response.reply no_locations(group)
        else
          response.reply "I know about the following #{group} locations: #{locations.join(', ')}"
        end

      end

      def choose_location(response)
        group = response.matches[0][0]

        locations = get_locations(group)

        if locations.nil?
          response.reply no_locations(group)
        else
          location = locations.shuffle.first
          response.reply "I think you should go to #{location} for #{group}."
        end
      end

      private

      def no_locations(group)
        "No #{group} locations have been added."
      end

      def get_locations(group)
        return nil unless redis.exists("location-decision:#{group}")

        MultiJson.load(redis.get("location-decision:#{group}"))
      end

      def update_locations(group, locations)

        # Only compare them by lowercase
        locations.uniq! { |item| item.downcase }

        redis.set "location-decision:#{group}", MultiJson.dump(locations)
      end

    end

    Lita.register_handler(LocationDecision)
  end
end
