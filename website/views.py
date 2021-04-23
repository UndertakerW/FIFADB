from app.framework import login
from app import app
from app.admin import admin
from app.models import Admin,Website,Club,League,New_Player
from app import db
app.register_blueprint(admin, url_prefix='/admin')
app.register_blueprint(login, url_prefix='/')

if __name__ == '__main__':
    app.run(debug=True)
