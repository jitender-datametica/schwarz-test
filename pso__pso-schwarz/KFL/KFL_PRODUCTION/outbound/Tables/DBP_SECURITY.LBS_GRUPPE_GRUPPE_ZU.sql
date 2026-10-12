--==============================================================
-- Table: lbs_gruppe_gruppe_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_gruppe_gruppe_zu
   generated from Powerdesigner on Montag, 5. August 2024 10:12:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.lbs_gruppe_gruppe_zu (
lbs_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der LBS-Einkäufergruppe. Gruppe bündelt eine oder mehrere ZEKs gem. Pflege aus dem KFL-EK Fachbereich'),
lbs_gruppe_parent_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='LBS-Einkäufergruppen können miteinander in Beziehung stehen.. "Parent_ID" ist die übergeordnete lbs_gruppe_id einer anderen LBS-Einkäufergruppe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (lbs_gruppe_id, lbs_gruppe_parent_id) NOT ENFORCED
)
OPTIONS(description='Securitytabelle, KFL EK Fachbereich pflegt die Beziehungen zwischen verschiedenen LBS Einkäufergruppen.');