# executable
$: << File.expand_path(File.dirname(__FILE__) + '/models')
require "card"
require "player"
require "resource"
require "land"
require "tool"
require "bonus"
require "beast"
require "listener"
require "yarn_spinner"

player = Player.new
Listener.new(player)
