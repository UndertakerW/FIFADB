from app import db

# book_card=db.Table('book_card',
#                    db.Column('book_number',db.String(20),db.ForeignKey('book.number'),primary_key=True),
#                    db.Column('card_number',db.String(20),db.ForeignKey('card.number'),primary_key=True)
#                    )
class Player(db.Model):
    __tablename__='player'
    player_id=db.Column(db.Integer,primary_key=True)
    season=db.Column(db.String(5),primary_key=True)
    player_name=db.Column(db.String(255))
    player_short_name=db.Column(db.String(255))
    nationality=db.Column(db.String(255))
    height=db.Column(db.Integer)
    weight=db.Column(db.Integer)
    club_id=db.Column(db.String(10))
    loaned_from=db.Column(db.String(255))
    wage_eur=db.Column(db.Integer)
    value_eur=db.Column(db.Integer)
    release_clause=db.Column(db.Integer)
    contract_valid_until=db.Column(db.String(5))
    team_number=db.Column(db.Integer)
    overall=db.Column(db.Integer)
    potential=db.Column(db.Integer)
    preferred_foot=db.Column(db.String(5))
    weak_foot_rating=db.Column(db.Integer)
    skill_moves_rating=db.Column(db.Integer)
    # card = db.relationship('Card', secondary=book_card,backref='borrowed_book')

class League(db.Model):
    __tablename__="league"
    league_id= db.Column(db.Integer,primary_key=True)
    season= db.Column(db.String(5),primary_key=True)
    league_name= db.Column(db.String(255))
    tier = db.Column(db.Integer)
    country_name = db.Column(db.String(5),nullable=False)

class Club(db.Model):
    __tablename__="club"
    club_id= db.Column(db.Integer,primary_key=True)
    season= db.Column(db.String(5),primary_key=True)
    club_name=db.Column(db.Integer)
    league_id= db.Column(db.String(255))

# class General_player(db.Model):
#     __tablename__="general_player"
#     player_id= db.Column(db.Integer,primary_key=True)
#     season= db.Column(db.String(5),primary_key=True)
#     pace= db.Column(db.Integer)
#     shooting = db.Column(db.Integer)
#     passing = db.Column(db.Integer)
#     dribbling = db.Column(db.Integer)
#     defending = db.Column(db.Integer)
#     physic = db.Column(db.Integer)

# class Goalkeeper(db.Model):
#     __tablename__="goalkeeper"
#     player_id= db.Column(db.Integer,primary_key=True)
#     gk_diving= db.Column(db.Integer,primary_key=True)
#     gk_handling = db.Column(db.Integer)
#     gk_kicking = db.Column(db.Integer)
#     gk_reflexes = db.Column(db.Integer)
#     gk_speed = db.Column(db.Integer)
#     gk_positioning = db.Column(db.Integer)

# class Positions(db.Model):
#     __tablename__="positions"
#     position_name=db.Column(db.String(5),primary_key=True)

# class Player_best_position(db.Model):
#     __tablename__="player_best_position"
#     player_id=db.Column(db.Integer,primary_key=True)
#     season=db.Column(db.String(5),primary_key=True)
#     postion_name=db.Column(db.String(10),primary_key=True)
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