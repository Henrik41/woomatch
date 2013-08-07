require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "577827953460.apps.googleusercontent.com", "VMLrbcNi0swUzWJ3DSAQAPT7", {:redirect_path => "/invites/gmail/contact_callback"}
  importer :yahoo, "dj0yJmk9YWpIRkVNU3ZLUzJLJmQ9WVdrOVZUZEtUV1pUTXpJbWNHbzlNVGM0TnpneU16ZzJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeD01OA--", "0eefef636ff7136f31aeb47dfb02014e3ba5c99e", {:callback_path => '/invites/yahoo/contact_callback'} 

	#check out the url for hotmail
	#http://msdn.microsoft.com/en-us/library/cc287659.aspx
	#https://manage.dev.live.com/Applications/ApiSettings/440d3a4c
	#http://isdk.dev.live.com/ISDK.aspx?category=scenarioGroup_hotmail&index=1
  importer :hotmail, "000000004C0FD30A", "ld9YjMn0Vn3cEVj5lNrcxoR8dgvpSXIG"
end