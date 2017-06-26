require 'net/http'
require 'json'
require 'uri'


puts "Please enter your api token"
puts "Create tokens here: https://api.slack.com/custom-integrations/legacy-tokens \n\n"
STDOUT.flush
# Add your API token from: https://api.slack.com/custom-integrations/legacy-tokens
# when asked at the prompt.
@token = gets.chomp


# Number of times you want to run the loop.  If you think you want to delete
# more than 100 files set the loop more than once.
N = 1

# Add the number of days you want to start from. Default is 30
NUMBER_OF_DAYS = 30

# Slack only allows up to 1000 count list per request.
# If you need more, set the N variable to loop more than once.
def list_files
  ts_to = (Time.now - NUMBER_OF_DAYS * 24 * 60 * 60).to_i # N days ago
  params = {
    token: @token,
    ts_to: ts_to,
    count: 1000
  }
  uri = URI.parse('https://slack.com/api/files.list')
  uri.query = URI.encode_www_form(params)
  response = Net::HTTP.get_response(uri)
  JSON.parse(response.body)['files']
end

def delete_files(file_ids)
  count = 0
  file_ids.each do |file_id|
    params = {
      token: @token,
      file: file_id
    }
    uri = URI.parse('https://slack.com/api/files.delete')
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    print "."
    count += 1
  end
  puts "\nDeleted #{count} Files"
end

p 'Deleting files...'
N.times do
  files = list_files
  file_ids = files.map { |f| f['id'] }
  delete_files(file_ids)
end
p 'Done!'
