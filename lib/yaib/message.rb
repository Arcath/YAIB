module YAIB
    class Message
        attr_reader :message, :user, :channel
        
        def initialize(rawmsg, bot)
            @message, rawchan, rawuser = parse(rawmsg)
            if rawchan == bot.config.nick then
                @channel = bot.return_user rawuser, rawuser
                @user = @channel
            else
                @channel = bot.channels[rawchan]
                @user = bot.return_user rawuser, rawchan
            end
        end
        
        def parse(rawmsg)
            [rawmsg.scan(/.* PRIVMSG .*? \:(.*)/).join, rawmsg.scan(/.* PRIVMSG (.*?) \:.*/).join, rawmsg.split(/\!/)[0].sub(/^\:/,'')]
        end
        
        def privmsg(s)
            @channel.privmsg(s)
        end
    end
end