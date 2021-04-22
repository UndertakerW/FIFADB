from app.framework import login
from app import app
from app.admin import admin
from app.models import Admin,Player,Club,League
# ,Player,Player_dob_info,Country,League,Club,General_player,Goalkeeper,Positions,Tag,Player_best_position,Player_positional_rating,Player_tag
from app import db
app.register_blueprint(admin, url_prefix='/admin')
app.register_blueprint(login, url_prefix='/')

if __name__ == '__main__':
    app.run(debug=True)
