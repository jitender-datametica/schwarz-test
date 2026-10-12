CREATE OR REPLACE TABLE idq_production_eks.itembrand (
itembrandid INTEGER,
itemid INTEGER,
contractpricevalidityid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
origincountryid INTEGER,
itemtypeid INTEGER,
brandid INTEGER,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);