--==============================================================
-- Table: lbs_gruppe_zek_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_gruppe_zek_zu_1
   generated from Powerdesigner on Montag, 5. August 2024 10:15:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.lbs_gruppe_zek_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
lbs_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der LBS-Einkäufergruppe. Gruppe_1 bündelt eine_1 oder mehrere ZEKs gem. Pflege aus dem KFL-EK Fachbereich'),
zek_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
alle_zek_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Es signalisiert, dass dieser Gruppe_1 alle ZEK_1 eines Landes zugeteilt sind.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (lbs_gruppe_id, mandant_id, zek_id) NOT ENFORCED
)
OPTIONS(description='Securitytabelle, KFL EK Fachbereich teilt LBS Einkäufergruppen je Land_1 eine_1 oder mehrere ZEK_Ids zu.');