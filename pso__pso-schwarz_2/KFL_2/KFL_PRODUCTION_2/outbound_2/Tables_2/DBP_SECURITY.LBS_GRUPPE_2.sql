--==============================================================
-- Table: lbs_gruppe_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_gruppe_2
   generated from Powerdesigner on Montag, 5. August 2024 10:11:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.lbs_gruppe_2 (
lbs_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der lbs-einkäufergruppe. gruppe_2 bündelt eine_2 oder mehrere zeks gem. pflege aus dem kfl-ek fachbereich'),
lbs_gruppe_bez STRING(300) NOT NULL OPTIONS(description='Name der LBS-Einkäufergruppe.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (lbs_gruppe_id) NOT ENFORCED
) OPTIONS(description='Securitytabelle, Fachbereich pflegt LBS Einkäufergruppen.');