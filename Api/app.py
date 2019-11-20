from flask import Blueprint
from flask_restful import Api
from resources.UserResource import UserResource
from resources.PostResource import PostResource


api_bp = Blueprint('api', __name__)
api = Api(api_bp)

# Route
api.add_resource(UserResource, '/user' , '/user/username=<username>', '/user/email=<email>')
api.add_resource(PostResource, '/post')