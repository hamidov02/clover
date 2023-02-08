DROP TABLE IF EXISTS dbo.Role;
CREATE TABLE dbo.Role (
	ID serial PRIMARY KEY,
	name VARCHAR ( 29 ) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL
);

DROP TABLE IF EXISTS dbo.Image;
CREATE TABLE dbo.Image (
	ID serial PRIMARY KEY,
	path VARCHAR ( 56 ) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL
);

DROP TABLE IF EXISTS dbo.Address;
CREATE TABLE dbo.Address (
	ID serial PRIMARY KEY,
	Country VARCHAR ( 29 ) NOT NULL,
	City VARCHAR ( 29 ) NOT NULL,
	State VARCHAR ( 29 ),
	Street VARCHAR ( 29 ) NOT NULL,
	Street_Number INTEGER,
	Postcode VARCHAR ( 11 ) NOT NULL,
	Latitude VARCHAR ( 29 ) NOT NULL,
	Longtitude VARCHAR ( 29 ) NOT NULL,
	created_on TIMESTAMP NOT NULL
);

DROP TABLE IF EXISTS dbo.Card;
CREATE TABLE dbo.Card (
	ID serial PRIMARY KEY,
	card_number VARCHAR ( 56 ) NOT NULL,
	card_holder_name VARCHAR ( 56 ),
	expiration_year INTEGER NOT NULL,
	expiration_month INTEGER NOT NULL,
	created_on TIMESTAMP NOT NULL
);

DROP TABLE IF EXISTS dbo.Payment;
CREATE TABLE dbo.Payment (
	ID serial PRIMARY KEY,
	amount INTEGER NOT NULL,
	last_modified TIMESTAMP NOT NULL,
	created_on TIMESTAMP NOT NULL,
	payment_method VARCHAR (11), -- card/ cash
	status VARCHAR(20) NOT NULL -- Accepted/Rejected (maybe in progress)
);
	

DROP TABLE IF EXISTS dbo.User;
CREATE TABLE dbo.User (
	ID serial PRIMARY KEY,
	username VARCHAR ( 29 ) UNIQUE NOT NULL,
	full_name VARCHAR ( 56 ) NOT NULL,
	mobile_number VARCHAR ( 56 ) NOT NULL,
	email VARCHAR ( 56 ) NOT NULL,
	password_hash VARCHAR ( 56 ) NOT NULL,
	created_on TIMESTAMP NOT NULL,
	role_id INTEGER REFERENCES dbo.Role(ID),
	address_id INTEGER REFERENCES dbo.Address(ID)
);

DROP TABLE IF EXISTS dbo.Pitch;
CREATE TABLE dbo.Pitch (
	ID serial PRIMARY KEY,
	pitch_number VARCHAR(20) UNIQUE NOT NULL,
	sport_type VARCHAR(20) NOT NULL,
	price INTEGER DEFAULT 0,
	created_on TIMESTAMP NOT NULL,
	pitch_owner_id INTEGER REFERENCES dbo.User(ID),
	address_id INTEGER REFERENCES dbo.Image(ID)
);

DROP TABLE IF EXISTS dbo.Pitch_Activity;
CREATE TABLE dbo.Pitch_Activity (
	ID serial PRIMARY KEY,
	book_from Date NOT NULL,
	book_to Date NOT NULL,
	pitch_id INTEGER REFERENCES dbo.Pitch(ID)
);

DROP TABLE IF EXISTS dbo.Booking;
CREATE TABLE dbo.Booking (
	ID serial PRIMARY KEY,
	last_modified TIMESTAMP NOT NULL,
	created_on TIMESTAMP NOT NULL,
	status VARCHAR(20) NOT NULL, -- Accepted/Rejected (maybe in progress)
	pitch_activity_id INTEGER REFERENCES dbo.Pitch_Activity(ID),
	customer_id INTEGER REFERENCES dbo.User(ID),
	payment_id INTEGER REFERENCES dbo.Payment(ID)
);

DROP TABLE IF EXISTS dbo.Users_Cards;
CREATE TABLE dbo.Users_Cards (
	ID serial PRIMARY KEY,
	created_on TIMESTAMP NOT NULL,
	user_id INTEGER REFERENCES dbo.User(ID),
	card_id INTEGER REFERENCES dbo.Card(ID)
);














