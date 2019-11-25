import json
import sqlalchemy
from sqlalchemy.ext.declarative import declarative_base
import boto3
import flask


SECRET_ID = 'DecryptorRDSPassword'
SECRET_INFO = 'SecretString'
USERNAME_SECRET = 'username'
PASSWORD_SECRET = 'password'
TABLE_NAME = 'passwords'
RDS_HOST = 'placeholder'


username = None
password = None


app = flask.Flask(__name__)
Base = declarative_base()


def to_json(inst, cls):
    d = dict()
    for c in cls.__table__.columns:
        v = getattr(inst, c.name)
        if v is None:
            d[c.name] = str()
        else:
            d[c.name] = v
    return d


class Password(Base):
    __tablename__ = TABLE_NAME
    id = sqlalchemy.Column(sqlalchemy.Integer, primary_key=True)
    plain = sqlalchemy.Column(sqlalchemy.String)
    hash = sqlalchemy.Column(sqlalchemy.String)
    decrypt = sqlalchemy.Column(sqlalchemy.String)

    @property
    def json(self):
        return to_json(self, self.__class__)


@app.route('/api/passwords')
def get_passwords():
    print('Processing: \'' + flask.request.url + '\'', flush=True)
    session = get_db_session()
    rows = session.query(Password).order_by(Password.id)
    return flask.jsonify([row.json for row in rows])


@app.route('/api/passwords/<id>')
def get_password(id):
    print('Processing: \'' + flask.request.url + '\'', flush=True)
    session = get_db_session()
    rows = session.query(Password).filter(Password.id == id).all()
    if len(rows) == 0:
        flask.abort(404)
    else:
        return flask.jsonify(rows[0].json)


@app.route('/api/health')
def health():
    print('Processing: \'' + flask.request.url + '\'', flush=True)
    return flask.jsonify({"success": True})


def get_db_session():
    get_db_credentials()
    dc = sqlalchemy.create_engine('postgresql://' + username + ':' + password + '@' + RDS_HOST + '/decryptor')
    Session = sqlalchemy.orm.sessionmaker(bind=dc)
    retval = Session()
    return retval


def get_db_credentials():
    global username
    global password
    if username is not None:
        return
    print('Retrieving DB credentials')

    sm_client = boto3.client('secretsmanager')
    secret = sm_client.get_secret_value(SecretId=SECRET_ID)
    secret_info = json.loads(secret[SECRET_INFO])
    username = secret_info[USERNAME_SECRET]
    password = secret_info[PASSWORD_SECRET]


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
