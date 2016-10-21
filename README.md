# Miracle+6チーム

* グエン・ホアン・ミン　20122079 （リーダー）
* チャン・チュン・ヒエウ　20121699 （サブリーダー）
* グエン・クアン・ミン　20122084
* グエン・ティ・トゥ・チャン　20122594
* チャン・ディン・ザップ　20121609
* ホアン・タイン・ロン　20122003
* グエン・バオ・ゴック　20122160

# データベースを設定する
    # 1st terminal
    $ rails db:migrate:reset
    $ rails db:seed
    $ redis-cli
        > flushdb
        > exit

    # 2nd terminal
    $ redis-server

    # 1st terminal again
    $ bundle exec rake search_suggestions:index

# サーバーを起動する
    # Each in a different terminal
    $ redis-server
    $ bundle exec sidekiq
    $ rails server
