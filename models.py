from sqlalchemy import Column, Integer, String, ForeignKey, Table
from sqlalchemy.orm import relationship, backref
from sqlalchemy.ext.declarative import declarative_base

Base= declarative_base()

class Users(Base):
    __tablename__ = "users"
    adminid = Column(Integer, primary_key=True)
    username = Column(String(100))
    password = Column(String(255))
    firstname = Column(String(255))
    lastname = Column(String(255))
    email = Column(String(4096))
    about = Column(String(4096))
    photo =Column(blob)
    isAdmin = Column(Integer(1))

class Classes(Base):
    __tablename__ = "classes"
    classID = Column(Integer, primary_key=True)
    classCode = Column(String(6))
    classAdminID = Column(Integer)

class Classusers(Base):
    classID = Column(Integer)
    userID = Column(Integer)

class Events(Base):
    __tablename__ = "events"
    eventID = Column(Integer, primary_key=True)
    eventType = Column(String(100))
    eventDistance = Column(Integer)
    eventTime = Column(Time)

class logs(Base):
    __tablename__ = "logs"
    userID = Column(Integer)
    logID = Column(Integer)
    logContent = Column(string)
    logDateTime = Column(datetime)

class photos(Base):
    __tablename__ = "postphotos"
    userID = Column(Integer)
    postID = Column(Integer)
    postPhotoID = Column(Integer, primary_key=True)
    postPhoto = Column(blob)
    postDateTime = Column(datetime)

class posts(Base):
    __tablename__ = "posts"
    userID = Column(Integer)
    postID = Column(Integer, primary_key=True)
    postContent = Column(String(255))
    isPosted = Column(Integer(1))

class scheduledassignments(Base):
    assignmentID = Column(Integer)
    eventID = Column(Integer)
    scheduledDateTime = Column(datetime)
    returnDateTime = Column(datetime)

class userdst(Base):
    userID = Column(Integer)
    eventID = Column(Integer)
    userDSTID = Column(Integer, primary_key=True)
    datetime = Column(datetime)
    userDistance = Column(Integer)
    userTime = Column(time)
    userSpeed = Column(Integer)
    isAssignment = Column(tinyint)
