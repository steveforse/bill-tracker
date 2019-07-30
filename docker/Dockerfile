# Image: bill-tracker
FROM steveforse/base-rails:6.0.0.rc2

USER root


#######################
# INSTALL APPLICATION #
#######################
USER ruby-user
WORKDIR /home/ruby-user/

# Clone repo
RUN git clone https://github.com/steveforse/bill-tracker.git
WORKDIR /home/ruby-user/bill-tracker

#####################
# READY APPLICATION #
#####################
USER ruby-user

# Setup application
RUN bundle install

# Docker image generates its own master key
RUN rm config/credentials.yml.enc
RUN EDITOR=nano rails credentials:edit

# Finish configuring application
RUN RAILS_ENV=production NODE_ENV=production bundle exec rake assets:precompile
RUN RAILS_ENV=production bundle exec rake db:setup

# Configure Nginx
COPY files/nginx.conf /etc/nginx/sites-enabled/default

# Configure entrypoint
USER root
COPY files/docker-entrypoint.sh /docker-entrypoint.sh
RUN chown ruby-user:ruby-user /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

USER ruby-user
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD bundle exec rails server -e production
