from flask import render_template, request, flash, make_response, url_for, redirect,Blueprint,session
from app import db
from app.models import Admin,Player,Club,League,New_Player
from io import BytesIO
from flask_mail import Mail, Message
from sqlalchemy import text
from app import mail
admin = Blueprint('admin', __name__)


@admin.route('/', methods=['GET','POST'])
def index():
    return render_template('manager_index.html')

@admin.route('/manager_issue',methods=['GET','POST'])
def issue():
    if 'identity' in session and session['identity']=='admin': #如果身份是管理员就通过
        pass
    else:#否则返回用户界面
        flash('You are not a administer！','danger')
        return redirect(url_for('login.a'))
    if request.method == 'POST':
        player_id = request.form["player_id"]
        nationality = request.form["nationality"]
        season = request.form["season"]
        player_name=request.form['player_name']
        club_id=request.form['club_id']
        overall=request.form['overall']
        potential=request.form['potential']
        q_number=Player.query.filter_by(player_id=player_id).first()
        if(q_number):
            if(season==q_number.season):
                flash("Player exist！",'danger')
        else:
            try:
                new_player = New_Player(player_id=player_id,season=season,player_name=player_name,nationality=nationality,club_id=club_id,overall=overall,potential=potential)
                print(new_player)
                db.session.add(new_player)
                db.session.commit()
                flash('Player in waitinglist！','success')
            except Exception as e:
                print(e)
                flash("Player register Wrong！check again!!",'danger')
                db.session.rollback()
    return render_template("manager_issue.html")

@admin.route('/manager_query',methods=['GET','POST'])
def query():
    if request.method == 'POST':
        league_id = request.form["league"]
        id1 = request.form["id"]
        nationality = request.form["nationality"]
        season = request.form["season"]
        player_name=request.form['Fullname']
        team_number=request.form['team']
        overall=request.form['overall']
        potential=request.form['potential']
        club_idlist=Club.query.filter_by(
            league_id=league_id if league_id is not None else text("")
        ).all()
        Club_id=[]
        for i in club_idlist:
            if(i.club_id not in Club_id):
                Club_id.append(i.club_id)
        print(Club_id)
        results=Player.query.filter(
            Player.player_id.like('%'+id1+'%') if id1 is not None else text(""),
            Player.season.like(season) if season is not None else text(""),
            Player.club_id.in_(Club_id) if league_id is not None else text(""),
            Player.nationality.like('%'+nationality+'%') if nationality is not None else text(""),
            Player.player_name.like('%'+player_name+'%') if player_name is not None else text(""),
            Player.team_number.like('%'+team_number+'%') if team_number is not None else text(""),
            Player.overall.like('%'+overall+'%') if overall is not None else text(""),
            Player.potential.like('%'+potential+'%') if potential is not None else text("")
        ).all()
        # print(results)
        if(results):
            return render_template('results.html',results=results)
        else:
            flash('No such a player！','warning')
            return render_template('search.html')
    return render_template('search.html')

@admin.route('/league',methods=['GET','POST'])
def league():
    results=""
    if request.method=='POST':
        league_id=request.form['league_id']
        season=request.form['season']
        club_name=request.form['club_name']
        results=db.session.query(League.league_id, League.season, League.league_name, League.country_name, Club.club_name).filter(League.league_id.like(league_id) if league_id is not None else text(""),
        League.season.like('%'+season+'%') if season is not None else text(""),
        Club.season.like('%'+season+'%') if season is not None else text(""),
        Club.league_id.like('%'+league_id+'%') if season is not None else text(""),
        Club.club_name.like('%'+club_name+'%') if season is not None else text("")).all()
    return render_template('league.html',borrowed_book=results)

