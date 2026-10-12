CREATE OR REPLACE TABLE idq_production_eks.contractlink_interface_1 (
contractlinkid BIGNUMERIC(38,0),
crdate STRING(40),
moddate STRING(40),
cruser STRING(35),
moduser STRING(35),
ekmreleasedate STRING(40),
ekmpredate STRING(40),
ekmcreatedate STRING(40),
prereleasewawi_date STRING(40),
senddate_to_loc STRING(40),
ekmprecontractno STRING(20),
ekmcreatecontractno STRING(20),
prereleasewawi_user STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);