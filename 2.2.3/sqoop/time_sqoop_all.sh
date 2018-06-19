sqoop job --meta-connect jdbc:hsqldb:hsql://localhost:16000/sqoop --create time_sqoop_all -- import --connect jdbc:mysql://localhost/CDW_SAPP --driver com.mysql.jdbc.Driver -m 1 --query "SELECT concat(YEAR, LPAD(MONTH,2,'0'), LPAD(DAY,2,'0')) AS TIMEID, DAY, MONTH, CASE WHEN MONTH<=3 THEN 'First' WHEN MONTH>3&&MONTH<=6 THEN 'Second' WHEN MONTH>6&&MONTH<=9 THEN 'Third' WHEN MONTH>9&&MONTH<=12 THEN 'Fourth' ELSE 'missing quarter' END AS QUARTER, YEAR  FROM CDW_SAPP_CREDITCARD WHERE \$CONDITIONS" --delete-target-dir --target-dir /Credit_Card_System/CDW_SAPP_D_TIME
