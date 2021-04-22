
from flask_wtf import Form
from wtforms import StringField, PasswordField, SubmitField, BooleanField, SelectField, SelectMultipleField
from wtforms.validators import DataRequired, Email, Length, EqualTo, Regexp


class LoginForm(Form):
    email = StringField('Administer ID', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Log in')
