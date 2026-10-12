CREATE OR REPLACE TABLE idq_production_eks.supplier_loc_use (
supplierno INTEGER,
locationid INTEGER,
cr_loc_flag INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);