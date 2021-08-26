from sqlalchemy import *
from sqlalchemy.orm import relationship, backref
from sqlalchemy.ext.declarative import declarative_base

Base= declarative_base()

class Users(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    username = Column(String(100), nullable=False)
    password = Column(String(255), nullable=False)
    firstname = Column(String(255), nullable=True)
    lastname = Column(String(255), nullable=True)
    email = Column(String(4096),nullable=False)
    about = Column(String(4096),nullable=True)
    photo = Column(BLOB)
    classID = Column(String(6), ForeignKey("classes.classID"))
    isAdmin = Column(Integer, nullable=False)
    userdst = relationship('UserDST', backref='user')
    log = relationship('Logs', backref='user')
    photos = relationship('Photos', backref='user')
    classes = relationship('Classes', backref='user')
    posts = relationship('Posts', backref='user')

class Classes(Base):
    __tablename__ = "classes"
    classID = Column(Integer, primary_key=True)
    classCode = Column(String(6))
    classAdminID = Column(Integer, ForeignKey("users.id"))
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
    logID = Column(Integer, primary_key=True)
    logContent = Column(String)
    logDateTime = Column(DateTime)

class Photos(Base):
    __tablename__ = "postphotos"
    userID = Column(Integer, ForeignKey("users.id"))
    postID = Column(Integer, ForeignKey("posts.postID"))
    postPhotoID = Column(Integer, primary_key=True)
    postPhoto = Column(BLOB)
    postDateTime = Column(DateTime)

class Posts(Base):
    __tablename__ = "posts"
    userID = Column(Integer, ForeignKey("users.id"))
    postID = Column(Integer, primary_key=True)
    postContent = Column(String(255))
    isPosted = Column(Boolean)
    photo = relationship("Photos",backref='posts')

class ScheduledAssignments(Base):
    __tablename__ = "scheduledassignments"
    assignmentID = Column(Integer, primary_key=True)
    eventID = Column(Integer, ForeignKey("event.eventID"))
    scheduledDateTime = Column(DateTime)
    returnDateTime = Column(DateTime)
    userdst = relationship("UserDST", backref='assignment')

class UserDST(Base):
    __tablename__ = "userdst"
    userID = Column(Integer, ForeignKey("users.id"))
    eventID = Column(Integer, ForeignKey("event.eventID"))
    userDSTID = Column(Integer, primary_key=True)
    DateTime = Column(DateTime)
    userDistance = Column(Integer)
    userTime = Column(Time)
    userSpeed = Column(Integer)
    isAssignment = Column(Integer)
    assignmentID = Column(Integer, ForeignKey("scheduledassignments.assignmentID"), nullable=True)
