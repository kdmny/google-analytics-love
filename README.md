ga-love
====================
A tool for generating click event tracking & cohorts using google analytics.


Installation Gemspec
------------
	gem 'ga-love'
	
Create config/google_analytics.yml

    development:
      google_analytics_stream_id: <YOUR STREAM ACCOUNT ID>
      google_analytics_id: <YOUR CLEAN ACCOUNT ID>
    
    test:
      ...
  
    production:
      ...

Create config/initializers/app_config.rb

    AppConfig = YAML.load_file(Rails.root.join('config', 'google_analytics.yml'))

    # Override config options by correct environment
    env_options = AppConfig.delete(Rails.env)

    AppConfig.merge!(env_options) unless env_options.nil?

Include in your layout

      = render(:partial => "ga-love/index")

Sample Use
------------------
Clicks are tracked to `<YOUR STREAM ACCOUNT>` and pageviews are logged to `<YOUR CLEAN ACCOUNT>`. The following
elements are tracked by default:

  * .pinit
  * a
  * input[type=submit]
  * input[type=button] 
  * button

You can add custom data to each click event by setting the @ga_url URI param in your controller.  This example logs data that would be useful in making a cohort analysis.

    class ApplicationController < ActionController::Base
      ...
      before_filter :ga_stuff
      ...
      def ga_stuff
        @ga_url = URI.parse(request.fullpath)
        @ga_url.query ||= ""
        session[:session_id] ||= nil #force the session to have a value  
        @ga_user = {:session_id => request.session_options[:id]}
        if user_signed_in?
          @ga_user.merge!( {
            :id => current_user.id,
            :signed_up_at => current_user.created_at.strftime("%-d-%-m-%Y"),
            :login_count => current_user.login_count
          })
        end
        @ga_url.query += "&#{@ga_user.to_query}"    
      end
      ...
    end

To Do
------------------

  * remove .pinit
  * offer a way to add classes/elements


Submitting an Issue
-------------------
We use the [GitHub issue tracker](http://github.com/kdmny/ga-love/issues) to track bugs and
features. Before submitting a bug report or feature request, check to make sure it hasn't already
been submitted. You can indicate support for an existing issuse by voting it up. When submitting a
bug report, please include a [Gist](http://gist.github.com/) that includes a stack trace and any
details that may be necessary to reproduce the bug, including your gem version, Ruby version, and
operating system. Ideally, a bug report should include a pull request with failing specs.


Submitting a Pull Request
-------------------------
1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Add documentation for your feature or bug fix.
5. Run <tt>rake doc:yard</tt>. If your changes are not 100% documented, go back to step 4.
6. Add specs for your feature or bug fix.
7. Run <tt>rake spec</tt>. If your changes are not 100% covered, go back to step 6.
8. Commit and push your changes.
9. Submit a pull request. Please do not include changes to the gemspec, version, or history file. (If you want to create your own version for some reason, please do so in a separate commit.)


Copyright
---------
Copyright (c) 2013 K$.
See [LICENSE](https://github.com/kdmny/ga-love/blob/master/LICENSE.md) for details.
