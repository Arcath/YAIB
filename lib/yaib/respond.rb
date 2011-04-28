module YAIB
    class Respond
        def privmsg(s)
            @bot.irc.send("PRIVMSG #{@channel} :#{s}")
        end
        
        def action(s)
            @bot.irc.send("ACTION #{@channel} :#{s}")
        end
        
        def notice(s)
            @bot.irc.send("NOTICE #{@channel} :#{s}")
        end
    end
end