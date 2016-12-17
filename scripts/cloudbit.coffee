_DEVICE_ID = process.env.DEVICE_ID
_ACCESS_TOKEN = process.env.ACCESS_TOKEN

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
