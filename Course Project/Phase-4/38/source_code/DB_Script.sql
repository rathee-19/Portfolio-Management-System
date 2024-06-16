drop database if exists PORTFOLIO_MANAGEMENT;
create database if not exists PORTFOLIO_MANAGEMENT;
use PORTFOLIO_MANAGEMENT;
set SQL_SAFE_UPDATES = 0;





-- creating all the tables
create table if not exists STOCKS(
StockID varchar(10) primary key,
Stock varchar(50) not null,
Price double not null,
Gain_Loss double,
Total_shares int not null,
Market_Cap double not null,
Book_value double not null,
P_to_E double not null);

create table if not exists MUTUALFUNDS(
MFID varchar(10) primary key,
Fund varchar(50) not null,
Price double not null,
Gain_Loss double,
Total_shares int not null,
Fund_Size double not null);

create table if not exists USERS(
PAN varchar(10) primary key,
FName varchar(20) not null,
LName varchar(20),
DoB date,
Contact varchar(10) not null,
EmailID varchar(30));



create table if not exists PORTFOLIOS(
FolioID varchar(10) primary key,
PAN varchar(10) not null,
Stock_Investments double,
MF_Investments double,
Net_Invested double,
Net_Gain_Loss double,
FOREIGN KEY (PAN) REFERENCES USERS(PAN) ON DELETE CASCADE);




create table if not exists HOLDINGS(
HoldingID varchar(10) primary key,
FolioID varchar(10) not null,
Holding_type varchar(25),
Net_Qty int not null,
Invested_total double not null,
Net_Gain_Loss double not null,
    FOREIGN KEY (FolioID) REFERENCES PORTFOLIOS(FolioID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS EQUITIES (
    HoldingID VARCHAR(10) PRIMARY KEY,
    StockID VARCHAR(10),
    MFID VARCHAR(10),
    FOREIGN KEY (HoldingID) REFERENCES HOLDINGS(HoldingID) ON DELETE CASCADE,
    FOREIGN KEY (StockID) REFERENCES STOCKS(StockID) ON DELETE SET NULL,
    FOREIGN KEY (MFID) REFERENCES MUTUALFUNDS(MFID) ON DELETE SET NULL
);




create table if not exists TRANSACTIONS(
TransID varchar(10) primary key,
FolioID varchar(10) not null,
HoldingID varchar(10) not null,
Type varchar(20),
Date date,
Qty_change int not null);

create table if not exists TAXES(
Type varchar(20) not null,
Percent float not null,
Amount float not null,
TransID varchar(10));









-- describing all these tables
desc STOCKS;
desc MUTUALFUNDS;
desc EQUITIES;
desc HOLDINGS;
desc TRANSACTIONS;
desc TAXES;
desc USERS;
desc PORTFOLIOS;








-- clearing all values from the table
delete from STOCKS;
delete from MUTUALFUNDS;
delete from EQUITIES;
delete from HOLDINGS;
delete from TRANSACTIONS;
delete from TAXES;
delete from USERS;
delete from PORTFOLIOS;




-- INSERTING VALUES INTO TABLES

-- Inserting values into STOCKS table
INSERT INTO STOCKS (StockID, Stock, Price, Gain_Loss, Total_shares, Market_Cap, Book_value, P_to_E)
VALUES
('RELIANCE', 'Reliance Industries', 25.00, 1.25, 2000, 50000.00, 5000.00, 25.00),
('HDFC', 'HDFC Bank', 15.00, 0.75, 1850, 27750.00, 2500.00, 15.00),
('TCS', 'Tata Consultancy Services', 35.00, 1.50, 1800, 63000.00, 16000.00, 35.00),
('GOOGL', 'Alphabet Inc.', 27.00, 1.20, 1900, 51300.00, 220.00, 28.50),
('FB', 'Meta Platforms, Inc.', 33.05, 2.54, 1750, 57838.00, 310.20, 22.10),
('NFLX', 'Netflix, Inc.', 52.08, 4.56, 1950, 101556.00, 480.75, 40.30),
('AAPL', 'Apple Inc.', 150.00, 5.25, 2000, 300000.00, 60000.00, 30.00),
('MSFT', 'Microsoft Corporation', 300.00, 12.75, 2000, 600000.00, 80000.00, 35.00),
('AMZN', 'Amazon.com Inc.', 3200.00, 500.00, 1300, 4160000.00, 200000.00, 40.00),
('JPM', 'JPMorgan Chase & Co.', 120.00, 6.54, 2800, 336000.00, 120000.00, 20.00),
('V', 'Visa Inc.', 250.00, 10.25, 1800, 450000.00, 75000.00, 28.00),
('BABA', 'Alibaba Group Holding Limited', 200.00, 8.00, 1900, 380000.00, 60000.00, 22.50),
('NVDA', 'NVIDIA Corporation', 800.00, 90.00, 1600, 1280000.00, 150000.00, 55.00),
('DIS', 'The Walt Disney Company', 150.00, 5.25, 2900, 435000.00, 60000.00, 30.00),
('CSCO', 'Cisco Systems Inc.', 55.00, 2.25, 4000, 220000.00, 100000.00, 18.50),
('IBM', 'International Business Machines Corporation', 120.00, 4.50, 3200, 384000.00, 180000.00, 20.00),
('ORCL', 'Oracle Corporation', 75.00, 3.20, 4100, 307500.00, 120000.00, 18.00),
('CRM', 'Salesforce.com Inc.', 280.00, 15.00, 1800, 504000.00, 110000.00, 25.50),
('PYPL', 'PayPal Holdings Inc.', 200.00, 9.25, 1800, 360000.00, 130000.00, 22.50),
('INTC', 'Intel Corporation', 50.00, 2.25, 6000, 300000.00, 150000.00, 15.00),
('UBER', 'Uber Technologies Inc.', 40.00, 2.00, 5000, 200000.00, 80000.00, 12.00),
('BA', 'The Boeing Company', 220.00, 11.20, 3500, 770000.00, 120000.00, 18.50),
('GS', 'The Goldman Sachs Group Inc.', 400.00, 22.50, 1800, 720000.00, 140000.00, 30.00),
('CAT', 'Caterpillar Inc.', 180.00, 8.00, 2000, 360000.00, 140000.00, 23.00),
('NKE', 'Nike Inc.', 170.00, 7.50, 2200, 374000.00, 180000.00, 25.00);

-- Inserting values into MUTUALFUNDS table
INSERT INTO MUTUALFUNDS (MFID, Fund, Price, Gain_Loss, Total_shares, Fund_Size)
VALUES
('CCC', 'CodeCraft Capital', 10.00, 0.50, 1500, 15000.00),
('PPP', 'PixelProfit Portfolio', 8.00, 0.40, 1300, 10400.00),
('BBF', 'BinaryBounty Fund', 12.00, 0.60, 1700, 20400.00),
('SSG', 'ScriptSure Growth', 9.00, 0.30, 1400, 12600.00),
('TTF', 'TechTonic Trend Fund', 11.00, 0.55, 1600, 17600.00),
('MCI', 'MF6CodeHarbor Investments', 8.50, 0.40, 1300, 11050.00),
('FIDELITY', 'Fidelity Magellan Fund', 100.00, 5.00, 2000, 200000.00),
('VANGUARD', 'Vanguard Total Stock Market Index Fund', 85.00, 4.20, 3000, 255000.00),
('BLACKROCK', 'BlackRock Global Allocation Fund', 120.00, 6.00, 2500, 300000.00),
('TROWEST', 'T. Rowe Price Global Technology Fund', 130.00, 7.50, 1900, 247000.00),
('JPMMF', 'JPMorgan Municipal Bond Fund', 75.00, 3.50, 1600, 120000.00),
('SSGA', 'State Street Global Advisors', 95.00, 4.75, 2500, 237500.00),
('PIMCO', 'PIMCO Total Return Fund', 110.00, 5.00, 2200, 242000.00),
('FRANKLIN', 'Franklin Templeton Investments', 80.00, 3.75, 3700, 296000.00),
('VANGUARD2', 'Vanguard 500 Index Fund', 90.00, 4.50, 2700, 243000.00),
('ALLIANZ', 'AllianzGI Convertible Fund', 105.00, 5.25, 2800, 294000.00),
('SCHWAB', 'Schwab S&P 500 Index Fund', 110.00, 4.75, 2800, 308000.00),
('FIDELITY2', 'Fidelity Contrafund', 140.00, 7.20, 1500, 210000.00),
('VANGUARD3', 'Vanguard Growth Index Fund', 125.00, 5.00, 2800, 350000.00),
('BLACKROCK2', 'BlackRock US Debt Index Fund', 95.00, 4.50, 2900, 275500.00),
('PIMCO2', 'PIMCO Income Fund', 100.00, 4.75, 2900, 290000.00),
('FIDELITY3', 'Fidelity Growth Company Fund', 135.00, 6.25, 2700, 364500.00),
('VANGUARD4', 'Vanguard Value Index Fund', 130.00, 6.00, 2900, 377000.00),
('TROWEST2', 'T. Rowe Price Blue Chip Growth Fund', 145.00, 7.50, 1500, 217500.00),
('PIMCO3', 'PIMCO Total Return Fund', 115.00, 5.00, 1550, 178250.00),
('FRANKLIN2', 'Franklin Growth Opportunities Fund', 130.00, 6.75, 1900, 247000.00);

-- Inserting values into TRANSACTIONS table
INSERT INTO TRANSACTIONS (TransID, FolioID, HoldingID, Type, Date, Qty_change)
VALUES
('T1', 'F1', 'H1', 'Buy', '2023-11-30', 20),
('T2', 'F1', 'H2', 'Sell', '2023-11-29', -10),
('T3', 'F2', 'H3', 'Buy', '2023-11-28', 15),
('T4', 'F3', 'H4', 'Buy', '2023-11-27', 15),
('T5', 'F5', 'H5', 'Sell', '2023-11-26', -5),
('T6', 'F5', 'H6', 'Buy', '2023-11-25', 20),
('T7', 'F7', 'H7', 'Buy', '2023-11-30', 20),
('T8', 'F7', 'H8', 'Sell', '2023-11-29', -10),
('T9', 'F8', 'H9', 'Buy', '2023-11-28', 15),
('T10', 'F9', 'H10', 'Buy', '2023-11-27', 15),
('T11', 'F10', 'H11', 'Sell', '2023-11-26', -5),
('T12', 'F11', 'H12', 'Buy', '2023-11-25', 20),
('T13', 'F11', 'H13', 'Sell', '2023-11-24', -10),
('T14', 'F12', 'H14', 'Buy', '2023-11-23', 12),
('T15', 'F12', 'H15', 'Buy', '2023-11-22', 8),
('T16', 'F13', 'H16', 'Sell', '2023-11-21', -15),
('T17', 'F14', 'H17', 'Buy', '2023-11-20', 15),
('T18', 'F14', 'H18', 'Sell', '2023-11-19', -8),
('T19', 'F15', 'H19', 'Buy', '2023-11-18', 12),
('T20', 'F16', 'H20', 'Buy', '2023-11-17', 20),
('T21', 'F17', 'H21', 'Sell', '2023-11-16', -10),
('T22', 'F17', 'H22', 'Buy', '2023-11-15', 18),
('T23', 'F18', 'H23', 'Sell', '2023-11-14', -12),
('T24', 'F18', 'H24', 'Buy', '2023-11-13', 16),
('T25', 'F19', 'H25', 'Buy', '2023-11-12', 15),
('T26', 'F19', 'H26', 'Sell', '2023-11-11', -8),
('T27', 'F1', 'H1', 'Sell', '2023-11-10', -5),
('T28', 'F2', 'H3', 'Buy', '2023-11-09', 10),
('T29', 'F3', 'H4', 'Sell', '2023-11-08', -10),
('T30', 'F5', 'H5', 'Buy', '2023-11-07', 8),
('T31', 'F5', 'H6', 'Sell', '2023-11-06', -15),
('T32', 'F7', 'H7', 'Sell', '2023-11-05', -8),
('T33', 'F7', 'H8', 'Buy', '2023-11-04', 12),
('T34', 'F8', 'H9', 'Sell', '2023-11-03', -7),
('T35', 'F9', 'H10', 'Buy', '2023-11-02', 9),
('T36', 'F10', 'H11', 'Sell', '2023-11-01', -11),
('T37', 'F11', 'H12', 'Buy', '2023-10-31', 14),
('T38', 'F11', 'H13', 'Sell', '2023-10-30', -6),
('T39', 'F12', 'H14', 'Buy', '2023-10-29', 7),
('T40', 'F12', 'H15', 'Sell', '2023-10-28', -9),
('T41', 'F13', 'H16', 'Buy', '2023-10-27', 10),
('T42', 'F14', 'H17', 'Sell', '2023-10-26', -12),
('T43', 'F14', 'H18', 'Buy', '2023-10-25', 13),
('T44', 'F15', 'H19', 'Sell', '2023-10-24', -5),
('T45', 'F16', 'H20', 'Buy', '2023-10-23', 6),
('T46', 'F17', 'H21', 'Sell', '2023-10-22', -15),
('T47', 'F17', 'H22', 'Buy', '2023-10-21', 11),
('T48', 'F18', 'H23', 'Sell', '2023-10-20', -8),
('T49', 'F18', 'H24', 'Buy', '2023-10-19', 9),
('T50', 'F19', 'H25', 'Sell', '2023-10-18', -10),
('T51', 'F19', 'H26', 'Buy', '2023-10-17', 12);

-- Inserting values into TAXES table
INSERT INTO TAXES (Type, Percent, Amount, TransID)
VALUES
('Capital Gain', 10.0, 50.00, 'T1'),
('Transaction Fee', 1.5, 18.75, 'T2'),
('Capital Gain', 8.0, 15.60, 'T3'),
('Capital Gain', 9.0, 36.450, 'T4'),
('Transaction Fee', 2.0, 13.00, 'T5'),
('Capital Gain', 7.5, 78.12, 'T6'),
('Capital Gain', 10.0, 240.00, 'T7'),
('Transaction Fee', 1.5, 21.00, 'T8'),
('Capital Gain', 8.0, 6.40, 'T9'),
('Capital Gain', 9.0, 10.20, 'T10'),
('Transaction Fee', 2.0, 11.50, 'T11'),
('Capital Gain', 7.5, 52.50, 'T12'),
('Transaction Fee', 1.0, 33.05, 'T13'),
('Capital Gain', 8.5, 76.50, 'T14'),
('Capital Gain', 7.0, 176.80, 'T15'),
('Transaction Fee', 1.8, 10.80, 'T16'),
('Capital Gain', 10.0, 225.00, 'T17'),
('Transaction Fee', 1.5, 12.00, 'T18'),
('Capital Gain', 8.0, 129.60, 'T19'),
('Capital Gain', 9.0, 540.00, 'T20'),
('Transaction Fee', 2.0, 21.00, 'T21'),
('Capital Gain', 7.5, 128.50, 'T22'),
('Transaction Fee', 1.0, 11.40, 'T23'),
('Capital Gain', 8.5, 122.40, 'T24'),
('Capital Gain', 7.0, 99.70, 'T25'),
('Transaction Fee', 1.8, 20.88, 'T26');


-- Inserting values into USERS table
INSERT INTO USERS (PAN, FName, LName, DoB, Contact, EmailID)
VALUES
('ABCP1234X', 'John', 'Doe', '1990-01-15', 1234567890, 'john.doe@email.com'),
('XYZQ5678Y', 'Jane', 'Smith', '1985-05-20', 9876543210, 'jane.smith@email.com'),
('LMNO7890Z', 'Michael', 'Johnson', '1988-08-12', 8765432109, 'michael.johnson@email.com'),
('QRST1234A', 'Samantha', 'Williams', '1995-03-05', 7654321098, 'samantha.williams@email.com'),
('AABB1122X', 'Alice', 'Johnson', '1992-02-18', 1122334455, 'alice.johnson@email.com'),
('BBCC3344Y', 'Robert', 'Smith', '1980-08-05', 2233445566, 'robert.smith@email.com'),
('CCDD5566Z', 'Emily', 'Brown', '1998-05-12', 3344556677, 'emily.brown@email.com'),
('DDEE7788A', 'Michael', 'Davis', '1989-12-25', 4455667788, 'michael.davis@email.com'),
('EEFF8899X', 'Olivia', 'Brown', '1993-03-22', 5566778899, 'olivia.brown@email.com'),
('FFGG0011Y', 'William', 'Garcia', '1987-10-15', 6677889900, 'william.garcia@email.com'),
('GGHH2233Z', 'Sophia', 'Martinez', '1999-07-01', 7788990011, 'sophia.martinez@email.com'),
('HHII4455A', 'James', 'Lopez', '1990-12-31', 8899001122, 'james.lopez@email.com');

-- Inserting values into PORTFOLIOS table
INSERT INTO PORTFOLIOS (FolioID, PAN, Stock_Investments, MF_Investments, Net_Invested, Net_Gain_Loss)
VALUES
('F1', 'ABCP1234X', 1250.00, 3750.00, 5000.00, 10.00),
('F2', 'XYZQ5678Y', 0.00, 3900.00, 3900.00, -2.00),
('F3', 'ABCP1234X', 1890.00, 0.00, 1890.00, 15.00),
('F4', 'LMNO7890Z', 0.00, 0.00, 0.00, 1.20),
('F5', 'QRST1234A', 0.00, 5854.00, 5854.00, -0.20),
('F6', 'LMNO7890Z', 0.00, 0.00, 0.00, 0.80),
('F7', 'AABB1122X', 0.00, 1020.00, 1020.00, 10.00),
('F8', 'BBCC3344Y', 0.00, 2550.00, 2550.00, -2.00),
('F9', 'AABB1122X', 1050.00, 0.00, 1050.00, 15.00),
('F10', 'CCDD5566Z', 0.00, 2875.00, 2875.00, 1.20),
('F11', 'DDEE7788A', 3072.00, 0.00, 3072.00, -0.20),
('F12', 'BBCC3344Y', 0.00, 10350.00, 10350.00, 0.80),
('F13', 'DDEE7788A', 3200.00, 0.00, 32000.00, 5.00),
('F14', 'EEFF8899X', 6000.00, 3500.00, 9500.00, 10.00),
('F15', 'FFGG0011Y', 0.00, 2700.00, 2700.00, -2.00),
('F16', 'EEFF8899X', 15000.00, 0.00, 15000.00, 15.00),
('F17', 'GGHH2233Z', 0.00, 11325.00, 11325.00, 1.20),
('F18', 'HHII4455A', 0.00, 7800.00, 7800.00, -0.20),
('F19', 'FFGG0011Y', 0.00, 10750.00, 10750.00, 0.80);

-- Inserting values into EQUITIES table

-- Inserting values into HOLDINGS table with modified holding_type
INSERT INTO HOLDINGS (HoldingID, FolioID, Holding_type, Net_Qty, Invested_total, Net_Gain_Loss)
VALUES
('H1', 'F1', 'Stock', 50, 1250, 1000.00),
('H2', 'F1', 'MF', 30, 3750, 500.00),
('H3', 'F2', 'MF', 30, 3900, 500.00),
('H4', 'F3', 'Stock', 70, 700, 1890.00),
('H5', 'F5', 'MF', 25, 3250, 300.00),
('H6', 'F5', 'Stock', 50, 2604, 750.00),
('H7', 'F7', 'MF', 50, 6000, 1000.00),
('H8', 'F7', 'MF', 30, 4200, 500.00),
('H9', 'F8', 'MF', 30, 2550, 500.00),
('H10', 'F9', 'Stock', 70, 1050, 800.00),
('H11', 'F10', 'MF', 25, 2875, 300.00),
('H12', 'F11', 'Stock', 50, 1750, 750.00),
('H13', 'F11', 'Stock', 40, 1322, 600.00),
('H14', 'F12', 'MF', 60, 4500, 900.00),
('H15', 'F12', 'MF', 45, 5850, 700.00),
('H16', 'F13', 'Stock', 80, 3200, 1000.00),
('H17', 'F14', 'Stock', 40, 6000, 800.00),
('H18', 'F14', 'MF', 35, 3500, 700.00),
('H19', 'F15', 'MF', 20, 2700, 400.00),
('H20', 'F16', 'Stock', 50, 15000, 600.00),
('H21', 'F17', 'MF', 45, 4725, 550.00),
('H22', 'F17', 'MF', 60, 6600, 800.00),
('H23', 'F18', 'MF', 30, 2850, 450.00),
('H24', 'F18', 'MF', 55, 4950, 750.00),
('H25', 'F19', 'MF', 75, 7125, 900.00),
('H26', 'F19', 'MF', 25, 3625, 400.00);

INSERT INTO EQUITIES (HoldingID, StockID, MFID)
VALUES
('H1', 'RELIANCE', NULL),
('H2', NULL, 'VANGUARD3'),
('H3', NULL, 'FRANKLIN2'),
('H4', 'GOOGL', NULL),
('H5', NULL, 'TROWEST'),
('H6', 'NFLX', NULL),
('H7', NULL, 'BLACKROCK'),
('H8', NULL, 'FIDELITY2'),
('H9', NULL, 'VANGUARD'),
('H10', 'HDFC', NULL),
('H11', NULL, 'PIMCO3'),
('H12', 'TCS', NULL),
('H13', 'FB', NULL),
('H14', NULL, 'JPMMF'),
('H15', NULL, 'VANGUARD4'),
('H16', 'UBER', NULL),
('H17', 'AAPL', NULL),
('H18', NULL, 'PIMCO2'),
('H19', NULL, 'FIDELITY3'),
('H20', 'MSFT', NULL),
('H21', NULL, 'ALLIANZ'),
('H22', NULL, 'SCHWAB'),
('H23', NULL, 'BLACKROCK2'),
('H24', NULL, 'VANGUARD2'),
('H25', NULL, 'SSGA'),
('H26', NULL, 'TROWEST2');

