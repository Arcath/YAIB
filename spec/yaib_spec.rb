require 'lib/yaib.rb'

describe YAIB, "#construct" do
    it "Should take a block" do
        #YAIB::Bot.stubs!(:new).and_return(true)
        YAIB.construct do |c|
            c.nick = "Test"
            c.server = "irc.freenode.net"
        end
    end
end