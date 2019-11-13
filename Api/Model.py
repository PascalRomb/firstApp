from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


ma = Marshmallow()
db = SQLAlchemy()

#User
class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True) #autoincrement by default for the first int pk column
    session_id = db.Column(db.String(16),nullable=False, unique=True)
    firstname = db.Column(db.String(45), nullable=False)
    lastname = db.Column(db.String(45), nullable=False)
    email = db.Column(db.String(45), nullable=False, unique=True)
    username = db.Column(db.String(45), nullable=False, unique=True)
    password = db.Column(db.String(45),nullable=False)
    
    def __init__ (self, session_id, firstname, lastname, email, username, password):
        self.session_id = session_id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.username = username
        self.password = password

class UserSchema(ma.Schema):
    id = fields.Integer()
    session_id = fields.String()
    firstname = fields.String(required=True)
    lastname = fields.String(required=True)
    email = fields.String(required=True)
    username = fields.String(required=True)
    password = fields.String(required=True)