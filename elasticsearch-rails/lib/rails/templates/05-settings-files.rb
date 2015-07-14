#     $ rails new searchapp --skip --skip-bundle --template https://raw.githubusercontent.com/elastic/elasticsearch-rails/master/elasticsearch-rails/lib/rails/templates/05-settings-files.rb

# (See: 01-basic.rb, 02-pretty.rb, 03-expert.rb, 04-dsl.rb)



# ----- Recreate the index ------------------------------------------------------------------------

rake "environment elasticsearch:import:model CLASS='Article' BATCH=100 FORCE=y"

# ----- Print Git log -----------------------------------------------------------------------------

puts
say_status  "Git", "Details about the application:", :yellow
puts        '-'*80, ''

git tag: "settings-files"
git log: "--reverse --oneline HEAD...dsl"

# ----- Start the application ---------------------------------------------------------------------

unless ENV['RAILS_NO_SERVER_START']
  require 'net/http'
  if (begin; Net::HTTP.get(URI('http://localhost:3000')); rescue Errno::ECONNREFUSED; false; rescue Exception; true; end)
    puts        "\n"
    say_status  "ERROR", "Some other application is running on port 3000!\n", :red
    puts        '-'*80

    port = ask("Please provide free port:", :bold)
  else
    port = '3000'
  end

  puts  "", "="*80
  say_status  "DONE", "\e[1mStarting the application. Open http://localhost:#{port}\e[0m", :yellow
  puts  "="*80, ""

  run  "rails server --port=#{port}"
end
