from flask import Flask, flash, redirect, render_template, url_for
from forms import RegistrationForm, LoginForm
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, BooleanField
from wtforms.validators import DataRequired, Length, Email, EqualTo
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from sqlalchemy.sql import text

app = Flask(__name__)

# change to name of your database; add path if necessary
db_name = 'timeme.db'

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///timeme.db'

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True

app.config['SECRET_KEY'] = 'cb1414668bb6f2a30c99cfb0e9c1441b'

# this variable, db, will be used for all SQLAlchemy commands
db = SQLAlchemy(app)

class users(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String)
    password = db.Column(db.String)
    firstname = db.Column(db.String)
    lastname = db.Column(db.String)
    email = db.Column(db.String)
    about = db.Column(db.String)
    photo = db.Column(db.Blob)
    isAdmin = db.Column(db.tinyint)

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        flash(f'Account created for {form.username.data}!','success')
        return redirect(url_for('index'))
    return render_template("register.html", title="Register", form=form)

@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        if form.email.data == 'admin@mail.com' and form.password.data == 'password':
            flash('logged in', 'success')
            return redirect(url_for('admindash'))
        else:
            flash('login unsuccessful', 'danger')
    return render_template("login.html", title="Login", form=form)

@app.route('/admindashboard', methods=['GET', 'POST'])
def admindash():
    return render_template("admindash.html")

if __name__ == "__main__":
    app.run(debug=True)
