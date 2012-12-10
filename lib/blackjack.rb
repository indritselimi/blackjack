Dir['lib/blackjack/*.rb'].each { |f| require "blackjack/#{File.basename(f, File.extname(f))}" }

module Blackjack

end