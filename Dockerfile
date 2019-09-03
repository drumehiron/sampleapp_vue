FROM ruby:2.6.4

# railsコンソール中で日本語入力するための設定 <- NEW
ENV LANG C.UTF-8

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
# /var/lib/apt/lists配下のキャッシュを削除し容量を小さくする <- NEW
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
RUN mkdir /sampleapp
ENV APP_ROOT /sampleapp
WORKDIR $APP_ROOT

# gemfileを追加する
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# gemfileのinstall
RUN bundle install
ADD . $APP_ROOT