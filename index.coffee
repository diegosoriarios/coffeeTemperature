request = require('request')
readline = require('readline')
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0'

cidade = ''
pais = ''

rl = readline.createInterface(
    input: process.stdin
    output: process.stdout)
rl.question 'Qual cidade ', (answer) ->
    cidade = answer.toLowerCase()
    fetchingData(cidade)
    rl.close()
    return

fetchingData = (cidade, pais) ->
    url = "https://api.openweathermap.org/data/2.5/forecast?q=#{cidade},br&lang=pt&units=metric&mode=json&appid=5325907441644570670df6cdec3acd5a"
    request url, (err, response, body) ->
        if err
            console.log 'error:', err
        else
            weather = JSON.parse(body)
            console.log "#{cidade}-BR"
            console.log "Temp: #{weather.list[0].main.temp} | Clima: #{weather.list[0].weather[0].description}"
        return