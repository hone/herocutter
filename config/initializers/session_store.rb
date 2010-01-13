# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_herokutter_session',
  :secret      => '333811a610cf77fe3ddae4efb88edb2b55c418825cfc483623bc85e482144f36a6d24e12721c9b1ccf9238e676a617e66f6c2338e827e5c3a2c0b8832478c68d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
