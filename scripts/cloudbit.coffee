_DEVICE_ID = '243c200c0155'
_ACCESS_TOKEN = '15f353ee9555f322179d7ca7767b32aa03c1b50803d7e8a465ee0f32232c42ea'

module.exports = (robot) ->
  robot.respond /rotate camera to (.*)/i, (msg) ->
    voltageValue = msg.match[1]
    data = JSON.stringify
      percent: voltageValue
      duration_ms: -1 # 何ミリ秒信号を送るか

    robot.http("https://api-http.littlebitscloud.cc/devices/#{_DEVICE_ID}/output")
    .header('Authorization', "Bearer #{_ACCESS_TOKEN}")
    .header('Accept', 'application/vnd.littlebits.v2+json')
    .header('Content-Type', 'application/json')
    .post(data) (err, res, body) ->
      msg.send 'OK, rotate it to ' + voltageValue
      console.error err
      console.log body
