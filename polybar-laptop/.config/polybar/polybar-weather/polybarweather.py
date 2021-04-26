'''Get weather condition from OpenWeather'''
#!/bin/python
import argparse
import sys
import requests

ids = {}
parser = argparse.ArgumentParser()
parser.add_argument(
    '-i',
    type=str,
    metavar='\tcityid: get your city id from the list at http://bulk.openweathermap.org/sample/',
    dest='city_id'
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
    dest='app_id'
)
parser.add_argument(
    '-t',
    type=str,
    metavar='\tOutput Type: Celcius, Fahrenheit, Kelvin',
    dest='o_type'
)
parser.add_argument(
    '-l',
    type=str,
    metavar='\tOutput language',
    dest='lang_id',
    default='en'
)
args = parser.parse_args()
city_id_ = args.city_id
app_id_ = args.app_id
zip_code_ = args.zip_code
country_code_ = args.country_code
o_type_ = args.o_type
lang_id = args.lang_id

def getWeatherByCityID(c_id, a_id=app_id_):
        req = requests.get(
            'http://api.openweathermap.org/data/2.5/weather?id=' + \
            city_id_ + '&appid=' + app_id_ + '&lang=' + lang_id)
        return req.json()

def getWeatherByZipCode(z_code, c_code, a_id=app_id_):
        req = requests.get('http://api.openweathermap.org/data/2.5/weather?zip=' + \
                         z_code + ',' + c_code + '&appid=' + app_id_ + \
                         '&lang=' + lang_id)
        return req.json()

def degreeType(temp, d_type):
        if d_type == 'Celcius':
                temp -= 273
                return str(temp) + '°C'
        if d_type == 'Kelvin':
                return str(temp) + '°K'
        if d_type == 'Fahrenheit':
                temp = ((temp - 273.15)*1.8) + 32.00
                return "{0:.1f}".format(temp) + '°F'

if __name__ == "__main__":
        if app_id_ is not None:
                if city_id_ is not None:
                        request = getWeatherByCityID(city_id_)
                elif zip_code_ is not None and country_code_ is not None:
                        request = getWeatherByZipCode(zip_code_, country_code_)
        city = request['name']
        temp = int(request['main']['temp'])
        humidity = request['main']['humidity']
        weather = request['weather'][0]['description'].title()
        if o_type_ is not None:
                print(weather + ' ' + degreeType(temp, o_type_))
        else:
                print(weather + ' ' + str(temp-273) + '°C')
