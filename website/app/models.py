from app import db


class League(db.Model):
    __tablename__="league"
    league_id= db.Column(db.Integer,primary_key=True)
    season= db.Column(db.String(5),primary_key=True)
    league_name= db.Column(db.String(255))
    tier = db.Column(db.Integer)
    country_region_name = db.Column(db.String(5),nullable=False)

class Club(db.Model):
    __tablename__="club"
    club_id= db.Column(db.Integer,primary_key=True)
    season= db.Column(db.String(5),primary_key=True)
    club_name=db.Column(db.Integer)
    league_id= db.Column(db.String(255))


class Website(db.Model):
    __tablename__="website"
    player_id=db.Column(db.Integer,primary_key=True)
    season=db.Column(db.String(5),primary_key=True)
    club_id=db.Column(db.Integer)
    player_name=db.Column(db.String(255))
    nationality=db.Column(db.String(255))
    club_name=db.Column(db.String(255))
    overall=db.Column(db.Integer)
    potential=db.Column(db.Integer)
    value_eur=db.Column(db.Integer)
    position_class=db.Column(db.String(10))

class New_Player(db.Model):
    __tablename__='new_player'
    player_id=db.Column(db.Integer,primary_key=True)
    season=db.Column(db.String(5),primary_key=True)
    player_name=db.Column(db.String(255))
    nationality=db.Column(db.String(255))
    club_id=db.Column(db.String(10))
    overall=db.Column(db.Integer)
    potential=db.Column(db.Integer)
    
class Admin(db.Model):
    ID=db.Column(db.String(10),primary_key=True)
    pwd=db.Column(db.String(20))
    name=db.Column(db.String(10))
    email=db.Column(db.String(20))