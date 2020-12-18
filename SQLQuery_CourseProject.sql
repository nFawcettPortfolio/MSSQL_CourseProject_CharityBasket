/* 
This Query was used for a course project. All company names and persons are fictional. Any similarities are unintentional.
*/

USE CharityBasket;

CREATE TABLE Donors (
	donor_id INT PRIMARY KEY IDENTITY (1,1),
	last_name nvarchar(30),
	first_name nvarchar(30),
	street nvarchar(60),
	city nvarchar(30),
	state_abbr nvarchar(2),
	zipcode nvarchar(10),
	donation_total MONEY
);
CREATE TABLE Donation (
	donation_id INT PRIMARY KEY IDENTITY (1,1),
	amount MONEY NOT NULL,
	donor_id INT FOREIGN KEY REFERENCES Donors(donor_id),
	donation_date DATETIME,
	preferred_charity nvarchar(30)
);

CREATE TABLE Charity (
	charity_id INT PRIMARY KEY IDENTITY (1,1),
	charity_name nvarchar(30),
	street nvarchar(60),
	city nvarchar(30),
	state_abbr nvarchar(2),
	zipcode nvarchar(10),
	distribution_total MONEY
);
CREATE TABLE Charity_Distribution (
	distribution_id INT PRIMARY KEY IDENTITY (1,1),
	amount MONEY NOT NULL,
	charity_id INT FOREIGN KEY REFERENCES Charity(charity_id),
	distribution_date DATETIME
);
CREATE TABLE Basket (
	basket_id INT PRIMARY KEY IDENTITY (1,1),
	donation_id INT FOREIGN KEY REFERENCES Donors(donor_id),
	distribution_id INT FOREIGN KEY REFERENCES Charity(charity_id)
	);

ALTER TABLE Charity_Distribution ADD CONSTRAINT df_distribution_date DEFAULT GETDATE() FOR distribution_date;
ALTER TABLE Donation ADD CONSTRAINT df_donation_date DEFAULT GETDATE() FOR donation_date;

INSERT INTO Charity (charity_name, street, city, state_abbr, zipcode, distribution_total) VALUES ('Fosters Food Bank', '2010 Fake Name Street', 'Los Angeles', 'CA', '90210', 650.00);
INSERT INTO Charity (charity_name, street, city, state_abbr, zipcode, distribution_total) VALUES ('Great Responsibility Inc.', '315 West 23rd Street', 'Cleveland', 'OH', '44104', 725.00);
INSERT INTO Charity (charity_name, street, city, state_abbr, zipcode, distribution_total) VALUES ('America Medical Fund', '613 Short Beach Road', 'Panama City', 'FL', '32401', 1500.00);

INSERT INTO Charity_Distribution (amount, charity_id) VALUES (200.00, 1);
INSERT INTO Charity_Distribution (amount, charity_id) VALUES (100.00, 3);
INSERT INTO Charity_Distribution (amount, charity_id) VALUES (25.00, 2);

INSERT INTO Donors (last_name, first_name, street, city, state_abbr, zipcode, donation_total) VALUES ('Smith', 'John', '123 Main Street Road', 'Atlanta', 'GA', '30001', 800.00);
INSERT INTO Donors (last_name, first_name, street, city, state_abbr, zipcode, donation_total) VALUES ('Jones', 'Megan', '990 Green Meadows Way', 'Chicago', 'IL', '60018', 350.00);
INSERT INTO Donors (last_name, first_name, street, city, state_abbr, zipcode, donation_total) VALUES ('Michaels', 'Ben', '1320 Big Oak Boulevard', 'Los Angeles', 'CA', '90210', 675.00);

INSERT INTO Donation (amount, donor_id, preferred_charity) VALUES (200.00, 1, 'America Medical Fund');
INSERT INTO Donation (amount, donor_id, preferred_charity) VALUES (100.00, 2, NULL);
INSERT INTO Donation (amount, donor_id, preferred_charity) VALUES (25.00, 3, NULL);

INSERT INTO Basket (donation_id, distribution_id) VALUES (1, 2);
INSERT INTO Basket (donation_id, distribution_id) VALUES (2, 2);
INSERT INTO Basket (donation_id, distribution_id) VALUES (3, 3);


/* Select Statements for easy use*/
SELECT * FROM Charity_Distribution;
SELECT * FROM Donation;
SELECT * FROM Basket;

SELECT * FROM Donors;
SELECT * FROM Charity;

SELECT * FROM Charity_Distribution JOIN Charity ON Charity_Distribution.charity_id=Charity.charity_id;
SELECT * FROM Donation JOIN Donors ON Donors.donor_id=Donation.donor_id;