# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_eMusic_session',
  :secret      => '3c25ea8224b242040b875b5db05d25daf68fef82a4d6e09c7af8b838d0ba276f589d73efba1be5e2b7cfd8ff0114b86208d6a1b82740fa039661b5294afaa2be'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
