for city in "Izmir" "Istanbul" "Los%20Angeles" "San%20Francisco" "Tashkent" "Singapore"; do
  geo=$(curl -s "https://geocoding-api.open-meteo.com/v1/search?name=$city" | jq '.results[0]')
  lat=$(echo "$geo" | jq -r '.latitude')
  lon=$(echo "$geo" | jq -r '.longitude')
  weather=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true")
  echo "$city: $(echo "$weather" | jq -r '.current_weather.temperature')°C, $(echo "$weather" | jq -r '.current_weather.windspeed') km/h wind"
done
