DROP DATABASE IF EXISTS CDW_SAPP CASCADE;
CREATE DATABASE IF NOT EXISTS CDW_SAPP;
USE CDW_SAPP;

DROP TABLE IF exists CDW_SAPP_D_BRANCH;
CREATE EXTERNAL TABLE CDW_SAPP_D_BRANCH (
  BRANCH_CODE	  DECIMAL(9,0),
  BRANCH_NAME	  VARCHAR(25),
  BRANCH_STREET	VARCHAR(30),
  BRANCH_CITY	  VARCHAR(30),
  BRANCH_STATE	VARCHAR(30),
  BRANCH_ZIP	  DECIMAL(7,0),
  BRANCH_PHONE	VARCHAR(13),
  LAST_UPDATED	TIMESTAMP
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
STORED AS textfile
	LOCATION '/Credit_Card_System/CDW_SAPP_D_BRANCH';

DROP TABLE IF EXISTS CDW_SAPP_D_CUSTOMER;
CREATE TABLE CDW_SAPP_D_CUSTOMER (
CUST_SSN	DECIMAL(9,0), CUST_F_NAME	VARCHAR(40), CUST_M_NAME	VARCHAR(40),
CUST_L_NAME	VARCHAR(40), CUST_CC_NO	VARCHAR(16),
CUST_STREET	VARCHAR(38), CUST_CITY	VARCHAR(30), CUST_STATE	VARCHAR(30),
CUST_COUNTRY	VARCHAR(30), CUST_ZIP	DECIMAL(7,0),
CUST_PHONE	VARCHAR(8), CUST_EMAIL	VARCHAR(40), LAST_UPDATED TIMESTAMP
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
STORED AS textfile
	LOCATION '/Credit_Card_System/CDW_SAPP_D_CUSTOMER';

DROP TABLE IF exists CDW_SAPP_D_TIME;
CREATE EXTERNAL TABLE CDW_SAPP_D_TIME (
  TIMEID	           VARCHAR(8),
  DAY	               DECIMaL(2,0),
  MONTH	             DECIMaL(2,0),
  QUARTER	           VARCHAR(8),
  YEAR	             DECIMaL(4,0)
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
STORED AS textfile
	LOCATION '/Credit_Card_System/CDW_SAPP_D_TIME';

DROP TABLE IF exists CDW_SAPP_F_CREDIT_CARD;
CREATE EXTERNAL TABLE CDW_SAPP_F_CREDIT_CARD (
  TRANSACTION_ID	  DECIMAL(9,0),
  CUST_CC_NO	      VARCHAR(16),
  TIMEID 	          VARCHAR(8),
  CUST_SSN	        DECIMAL(9,0),
  BRANCH_CODE	      DECIMAL(10,0),
  TRANSACTION_TYPE	STRING,
  TRANSACTION_VALUE	DECIMAL(20,3)
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
STORED AS textfile
	LOCATION '/Credit_Card_System/CDW_SAPP_F_CREDIT_CARD';
