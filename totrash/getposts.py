from flask import Flask, render_template, url_for, flash, redirect
from flask_sqlalchemy import SQLAlchemy
from forms import RegistrationForm, LoginForm

app.config['SECRET_KEY'] = 'cb1414668bb6f2a30c99cfb0e9c1441b'
