require 'yaib/version'
require 'yaib/irc'
require 'yaib/config'
require 'yaib/bot'
require 'yaib/respond'
require 'yaib/channel'
require 'yaib/message'
require 'yaib/string'
require 'yaib/responder'
require 'yaib/user'
require 'logger'

module YAIB
    def self.construct
        @config = Config.new
        yield @config
        @config.log.info("Creating Bot")
        @bot = Bot.new(@config)
    end
end