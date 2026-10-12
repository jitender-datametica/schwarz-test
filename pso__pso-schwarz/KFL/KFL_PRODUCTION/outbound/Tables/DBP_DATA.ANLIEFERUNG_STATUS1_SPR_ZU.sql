--==============================================================
-- Table: anlieferung_status1_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlieferung_status1_spr_zu
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.anlieferung_status1_spr_zu (
anlieferung_status1_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Erfassungsstatus (Wert zwischen 1 und 3)'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
anlieferung_status1_bez STRING(50) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des Erfassungsstatus, z.Bsp. "Fehlerfassung durch VZ"'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (anlieferung_status1_id, spr_id) NOT ENFORCED
)
OPTIONS(description='LIS - Sprachabhängige Bezeichnungen des Erfassungstatus einer Mercareon-Buchung. Keine SST, wird initial im DWH gepflegt');