# FirstApp

FirstApp is my first app written in dart and python.
It uses Flutter(front-end) and flask(back-end) to connect to remote mySQL server.


## Installation

### Prerequisites
Remote mySQL server , you can import *database.sql* to try this App. 

mySQL driver: libmysqlclient-dev .

```bash
sudo apt install libmysqlclient-dev
```
### Flask
Use command line to clone, set-up and run API.
```bash
git clone https://github.com/PascalRomb/firstApp.git
cd path/to/folder/Api/
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```
### Flutter
Follow official [guide](https://flutter.dev/docs/get-started/install) to install and set-up Flutter.

## Usage
### Flask
Modify SQL_URI in path/to/folder/Api/config.py

```python
import os

values for your configuration

basedir = os.path.abspath(os.path.dirname(__file__))
SQLALCHEMY_ECHO = False
SQLALCHEMY_TRACK_MODIFICATIONS = True
# You need to replace the next values with the appropriate 
SQLALCHEMY_DATABASE_URI = "mysql://username:password@server/DbName"
```

Run API server
```bash
python run.py
```
### Flutter

Modify remote SQL url in path/to/folder/first_app/Utils/Connector.dart
```dart
 static var url = "http://192.168.1.37:5000/api"; //change this.
```

Run app
```bash
cd path/to/folder/first_api/
flutter run
```

## License
[Pasquale Rombolà](https://github.com/PascalRomb)