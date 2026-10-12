CREATE OR REPLACE TABLE idq_production_eks.supplierstation_contact_1 (
supplstationcontactid BIGNUMERIC(38,0),
supplierstationid BIGNUMERIC(38,0),
contactid BIGNUMERIC(38,0),
hierarchyid BIGNUMERIC(38,0),
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