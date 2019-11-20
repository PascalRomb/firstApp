from flask import request
from flask_restful import Resource
from Model import db, Post, PostSchema


posts_schema = PostSchema(many=True)
post_schema = PostSchema()


class PostResource(Resource):
    
    def get(self):
        posts = Post.query.all()
        posts = posts_schema.dump(posts).data
        return {'status': 'success', 'data' : posts}, 200

    def post(self):
        json_data = request.get_json(force=True)
        if not json_data:
               return {'message': 'No input data provided'}, 400
        
        data, errors = post_schema.load(json_data)
        if errors:
            return errors, 422
            
        #create post
        post = Post(
            body = data['body'],
            id_user = data['id_user']
        )

        #add to db
        db.session.add(post)
        db.session.commit()

        result = post_schema.dump(post).data

        return { "status": 'success', 'data': result }, 201
    


    def put(self):
        
        json_data = request.get_json(force=True)
        if not json_data:
               return {'message': 'No input data provided'}, 400
        

        data, errors = post_schema.load(json_data)
        if errors:
            return errors, 422
            
        post = Post.query.filter_by(id=data["id"]).first()
        if(post == None): 
            return {'message': 'Post not exists'}, 204

        post.swipe += 1
        db.session.commit()
        
        result = post_schema.dump(post).data
        return { "status": 'success', 'data': result }, 200