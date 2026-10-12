--==============================================================
-- Table: lbs_gruppe_zek_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_gruppe_zek_zu
   generated from Powerdesigner on Montag, 5. August 2024 10:15:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.lbs_gruppe_zek_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lbs_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der LBS-Einkäufergruppe. Gruppe bündelt eine oder mehrere ZEKs gem. Pflege aus dem KFL-EK Fachbereich'),
zek_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
alle_zek_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Es signalisiert, dass dieser Gruppe alle ZEK eines Landes zugeteilt sind.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (lbs_gruppe_id, mandant_id, zek_id) NOT ENFORCED
)
OPTIONS(description='Securitytabelle, KFL EK Fachbereich teilt LBS Einkäufergruppen je Land eine oder mehrere ZEK_Ids zu.');