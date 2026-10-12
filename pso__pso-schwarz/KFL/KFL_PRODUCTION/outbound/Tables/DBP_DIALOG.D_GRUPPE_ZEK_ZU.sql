--==============================================================
-- Table: d_gruppe_zek_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: d_gruppe_zek_zu
   generated from Powerdesigner on Donnerstag, 7. September 2023 15:34:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_dialog.d_gruppe_zek_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
gruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID einer Usergruppe'),
zek_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
loesch_fg BIGNUMERIC(38,0) OPTIONS(description='Anforderung zur Löschung'),
alle_zek_fg BIGNUMERIC(38,0) OPTIONS(description='User dieser Gruppe werden allen zeks zugeordnet'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gruppe_id, zek_id) NOT ENFORCED
) OPTIONS(description='AIS KMO - Dialogtabelle zur Pflege von Usergruppen');