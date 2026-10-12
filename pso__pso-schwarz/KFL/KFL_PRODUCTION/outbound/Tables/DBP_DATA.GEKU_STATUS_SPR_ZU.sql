--==============================================================
-- Table: geku_status_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_status_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_status_spr_zu (
geku_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='eindeutige ID des Ticketstatus (erledigt, eskaliert, in Arbeit, überfällig)'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
geku_status_bez STRING(60)
OPTIONS(description='Bezeichnung des Ticketstatus z.Bsp. (erledigt, eskaliert, in Arbeit, überfällig)'),
quelle_spr_id BIGNUMERIC(38,0)
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_status_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen des GEKU Ticketstatus');