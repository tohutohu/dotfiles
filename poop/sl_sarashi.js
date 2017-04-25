require('date-utils');
const option = require('./secret_twitter_token.js');
const twit = require('twit');
const client = new twit(option.twitter);

client.post('statuses/update', {status:'@to_hutohu がlsと間違えてslを実行しました \n' + new Date().toFormat('YYYY/MM/DD HH24時MI分SS秒')}, function(err, data, res) {
});
