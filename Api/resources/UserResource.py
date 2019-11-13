from flask import request
from flask_restful import Resource
from Model import db, User, UserSchema
import random
import string

users_schema = UserSchema(many=True)
user_schema = UserSchema()

class UserResource(Resource):
    def getRandomSession_id(self):
        session_id = ""
        for _ in range(16):
            session_id += (random.choice(string.digits + string.ascii_letters + string.punctuation))
        return session_id

    def get(self, userid=None):
        
        if userid:
            user = User.query.filter_by(id=userid).first()
            user = user_schema.dump(user).data
            return {'status': 'success', 'data' : user}, 200
        
        users = User.query.all()
        users = users_schema.dump(users).data
        return {'status': 'success', 'data' : users}, 200

    def post(self):
        
        json_data = request.get_json(force=True)
        if not json_data:
               return {'message': 'No input data provided'}, 400
        

        data, errors = user_schema.load(json_data)
        if errors:
            return errors, 422
            
        user = User.query.filter_by(username=data['username']).first()
        if user:
            return {'message': 'Username already exists'}, 400
        
        user = User.query.filter_by(email=data['email']).first()
        if user:
            return {'message': 'Email already exists'}, 400
        
        #create user
        user = User(
            session_id = self.getRandomSession_id(),
            firstname = data['firstname'],
            lastname = data['lastname'],
            email = data['email'],
            username = data['username'],
            password = data['password']
        )

        #add to db
        db.session.add(user)
        db.session.commit()

        result = user_schema.dump(user).data

        return { "status": 'success', 'data': result }, 201
    