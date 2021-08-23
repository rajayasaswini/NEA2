from flask import Flask
from flask import render_template
app = Flask(__name__)

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/signup', methods=['post', 'get'])
def signup():
    return render_template("signup.html")

@app.route('/login', methods=['post', 'get'])
def login():
    return render_template("login.html")

if __name__ == "__main__":
    app.run(debug=True)
