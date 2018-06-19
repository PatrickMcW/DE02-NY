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
