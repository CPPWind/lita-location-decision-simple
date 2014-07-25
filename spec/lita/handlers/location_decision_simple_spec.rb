require "spec_helper"

describe Lita::Handlers::LocationDecisionSimple, lita_handler: true do
  it { routes_command("remember taco bell for lunch").to(:remember_location) }
  it { routes_command("remember taco bell in lunch").to(:remember_location) }
  it { routes_command("store taco bell for lunch").to(:remember_location) }
  it { routes_command("save taco bell in lunch").to(:remember_location) }

  it { routes_command("forget taco bell for lunch").to(:forget_location) }
  it { routes_command("wipe all in lunch").to(:forget_all_locations) }

  it { routes_command("list all for lunch?").to(:list_locations) }
  it { routes_command("pick from lunch?").to(:choose_location) }


  # it "checks the parser" do
  #   send_command "remember taco bell for lunch"
  #   expect(replies.last).to_not be_nil
  #   expect(replies.last).to eq("No cities match your search query")
  # end


  it "checks the system" do
    send_command "remember taco bell in lunch"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("I have added taco bell to the list of lunch locations.")

    send_command "list all in lunch"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("I know about the following lunch locations: taco bell")

    send_command "pick from lunch"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("I think you should go to taco bell for lunch.")

    send_command "wipe all in lunch"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("I have removed all lunch locations.")
  end

  it "checks a wipe all" do
    send_command "wipe all in lunch"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("No lunch locations have been added.")
  end

  it "checks a forget location" do
    send_command "forget taco bell in lunch"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("No lunch locations have been added.")
  end

  it "checks a pick from" do
    send_command "pick from lunch"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("No lunch locations have been added.")
  end

  it "ensures that can be forgotten" do
    send_command "remember taco bell for lunch"
    send_command "remember mcdonalds for lunch"

    send_command "list all for lunch"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("I know about the following lunch locations: taco bell, mcdonalds")

    send_command "forget taco bell for lunch"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("I have removed taco bell from the list of lunch locations.")

    send_command "list all from lunch"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("I know about the following lunch locations: mcdonalds")
  end
end
