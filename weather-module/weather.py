#!/usr/bin/env python3

import argparse
import requests

parser = argparse.ArgumentParser()
parser.add_argument(
    '-i',
    type=str,
    metavar='\tcityid: get your city id from the list at http://bulk.openweathermap.org/sample/',
    dest='city_id',
    default='498817'
)

parser.add_argument(
    '-z',
    type=str,
    metavar='\tzipcode: is used with country_code',
    dest='zip_code'
)
parser.add_argument(
    '-c',
    type=str,
    metavar='\tcountrycode(lowerCase): tr,us,uk...',
    dest='country_code'
)
parser.add_argument(
    '-a',
    type=str,
    metavar='\tget your appid from: https://openweathermap.org/appid',
    dest='app_id',
    default='ea249a8436d2ddf036c670a6d02f58a9'
)
parser.add_argument(
    '-t',
    '--units',
    type=str,
    metavar='\tOutput Type: Celcius, Fahrenheit, Kelvin',
    dest='units',
    default='metric'
)
parser.add_argument(
    '-l',
    type=str,
    metavar='\tOutput language',
    dest='lang_id',
    default='ru'
)
args = parser.parse_args()
city_id = args.city_id
app_id = args.app_id
zip_code = args.zip_code
country_code = args.country_code
units = args.units
lang_id = args.lang_id

def getWeatherByCityID(c_id, a_id=app_id):
    req = requests.get(f'http://api.openweathermap.org/data/2.5/'
                        f'weather?id={city_id}&appid={app_id}&units={units}'
                        f'&lang={lang_id}')
    return req.json()


if __name__ == "__main__":
    request = getWeatherByCityID(city_id)
    city = request['name']
    temp = int(request['main']['temp'])
    humidity = request['main']['humidity']
    weather = request['weather'][0]['description'].title()
    print(f'{weather}, {temp}°C')
