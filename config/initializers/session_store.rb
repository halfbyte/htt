# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_htt_session',
  :secret      => '9cdaf76ac70db4395735ceadc476a42bfc03ff00f714b08e5217fb709b7bd99974b41bdb5d0d5849f4e2414904c73abdef6adfe296e66328c0ed92cab16363d0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
