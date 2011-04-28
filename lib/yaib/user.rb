module YAIB
    class User < YAIB::Respond
        attr_accessor :nick, :channel
        
        def initialize(nick, bot)
            @nick = nick
            @bot = bot
        end
    end
end