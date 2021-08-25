from sqlalchemy import Column, Integer, String, ForeignKey, Table
from sqlalchemy.orm import relationship, backref
from sqlalchemy.ext.declarative import declarative_base

Base= declarative_base()

class Users(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    username = Column(String(100))
    password = Column(String(255))
    firstname = Column(String(255))
    lastname = Column(String(255))
    email = Column(String(4096))
    about = Column(String(4096))
    photo = Column(blob)
    classID = Column(String(6), ForeignKey("classes.classID"))
    isAdmin = Column(Integer(1))
    userdst = relationship('UserDST', backref='user')
    log = relationship('Logs', backref='user')
    photos = relationship('Photos', backref='user')
    classes = relationship('Classes', backref='user')
    posts = relationship('Posts', backref='user')

class Classes(Base):
    __tablename__ = "classes"
    classID = Column(Integer, primary_key=True)
    classCode = Column(String(6))
    classAdminID = Column(Integer)
    user = relationship('Users', backref='class')

class Events(Base):
    __tablename__ = "events"
    eventID = Column(Integer, primary_key=True)
    eventType = Column(String(100))
    eventDistance = Column(Integer)
    eventTime = Column(Time)
    userdst = relationship("UserDST", backref='event')
    schass = relationship("ScheduledAssignments", backref='event')

class Logs(Base):
    __tablename__ = "logs"
    userID = Column(Integer, ForeignKey("users.id"))
    logID = Column(Integer)
    logContent = Column(string)
    logDateTime = Column(datetime)

class Photos(Base):
    __tablename__ = "postphotos"
    userID = Column(Integer, ForeignKey("users.id"))
    postID = Column(Integer, ForeignKey("posts.postID"))
    postPhotoID = Column(Integer, primary_key=True)
    postPhoto = Column(blob)
    postDateTime = Column(datetime)

class Posts(Base):
    __tablename__ = "posts"
    userID = Column(Integer, ForeignKey("users.id"))
    postID = Column(Integer, primary_key=True)
    postContent = Column(String(255))
    isPosted = Column(Integer(1))
    photo = relationship("Photos",backref='posts')

class ScheduledAssignments(Base):
    __tablename__ = "scheduledassignments"
    assignmentID = Column(Integer)
    eventID = Column(Integer, ForeignKey("event.eventID"))
    scheduledDateTime = Column(datetime)
    returnDateTime = Column(datetime)
    userdst = relationship("UserDST", backref='assignment')

class UserDST(Base):
    __tablename__ = "userdst"
    userID = Column(Integer, ForeignKey("users.id"))
    eventID = Column(Integer, ForeignKey("event.eventID"))
    userDSTID = Column(Integer, primary_key=True)
    datetime = Column(datetime)
    userDistance = Column(Integer)
    userTime = Column(time)
    userSpeed = Column(Integer)
    isAssignment = Column(tinyint)
    assignmentID = Column(Integer, ForeignKey("scheduledassignments.assignmentID"), nullable=True)
