from flask import Flask, flash, redirect
from flask import render_template, url_for
from forms import RegistrationForm, LoginForm
app = Flask(__name__)

app.config['SECRET_KEY'] = 'cb1414668bb6f2a30c99cfb0e9c1441b'

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
