request = require('request')
readline = require('readline')
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0'

cidade = ''
pais = ''

rl = readline.createInterface(
    input: process.stdin
    output: process.stdout)
rl.question 'Digite a cidade ', (answer) ->
    cidade = capitalizeFirstLetter(answer)
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
            console.log '[36m%s[0m', "#{cidade}-BR"
            console.log "Temp:", getColor(weather.list[0].main.temp), " #{weather.list[0].main.temp}",  "\x1b[0m", "| Clima: ", "\x1b[32m", "#{weather.list[0].weather[0].description}", "\x1b[0m"
        return

capitalizeFirstLetter = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1)
  return string

getColor = (temp) ->
    if temp < 10.0
        color = "\x1b[34m"
    else
        if temp < 20.0
            color = "\x1b[33m"
        else
            color = "\x1b[31m"
    return color