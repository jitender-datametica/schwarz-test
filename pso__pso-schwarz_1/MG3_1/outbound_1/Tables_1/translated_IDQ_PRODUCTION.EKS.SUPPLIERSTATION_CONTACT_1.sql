CREATE OR REPLACE TABLE idq_production_eks.supplierstation_contact_1 (
supplstationcontactid INTEGER,
supplierstationid INTEGER,
contactid INTEGER,
hierarchyid INTEGER,
datefrom STRING(40),
dateuntil STRING(40),
crdate STRING(40),
moddate STRING(40),
cruser STRING(35),
moduser STRING(35),
sap_id STRING(15),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);