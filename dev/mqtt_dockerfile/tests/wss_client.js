const mqtt = require('mqtt');
 
const clientId = 'mqttws_' + Math.random().toString(16).substr(2, 8)
//const host = 'wss://itellyou.site/mqtt'
//const host = 'wss://itellyou.site'
const host = 'wss://mqtt2.66park.net/mqtt'
//const host = 'ws://125.74.48.239'
var options = {
    keepalive: 60,
    clientId: clientId,
    protocolId: 'MQTT',
    protocolVersion: 4,
    clean: true,
    reconnectPeriod: 1000,
    connectTimeout: 30 * 1000,
    will: {
        topic: 'WillMsg',
        payload: 'Connection Closed abnormally..!',
        qos: 0,
        retain: false
    },
    username: 'adminprod',
    //username: 'admin',
    password: 'w83R33d1',
    //password: '123456',
    rejectUnauthorized: false
}
 
var client = mqtt.connect(host, options)

client.on('error', function (err) {
    console.log(err)
    client.end()
})
 
client.on('connect', function () {
    console.log('client connected:' + clientId)
})
 
client.subscribe('topic', { qos: 0 })
 
client.publish('topic', 'wss connection demo...!', { qos: 0, retain: false })
 
client.on('message', function (topic, message, packet) {
    console.log('Received Message:' + message.toString() + '\nOn topic:= ' + topic)
})
 
client.on('close', function () {
    console.log(clientId + ' disconnected')
})

