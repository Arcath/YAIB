module YAIB
    class Channel < YAIB::Respond
        attr_accessor :name
        
        def initialize(channel, bot)
            @bot = bot
            @name = channel
            @channel = @name
            @bot.irc.join channel
        end
    end
end