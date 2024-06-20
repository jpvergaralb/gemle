# Use the official Ruby image from the Docker Hub
FROM ruby:3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  node-gyp \
  python-is-python3

# Install Node.js and Yarn
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g yarn

# Set an environment variable where the Rails app is installed to inside of Docker image
ENV RAILS_ROOT /var/www/myapp
RUN mkdir -p $RAILS_ROOT

# Set working directory
WORKDIR $RAILS_ROOT

# Setting env up
ENV RAILS_ENV='production'
ENV RACK_ENV='production'

# Install Bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --without development test

# Copy the main application
COPY . .

# Precompile Rails assets
RUN bundle exec rake assets:precompile

# Expose port 3000 to the Docker host, so we can access it
EXPOSE 3000

# The default command that gets run will be to start the Rails server.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
