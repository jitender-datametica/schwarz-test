--==============================================================
-- Table: anlieferung_status2_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlieferung_status2_spr_zu
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.anlieferung_status2_spr_zu (
anlieferung_status2_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Pünktlichkeitsstatus (Wert zwischen 1 und 5)'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
anlieferung_status2_bez STRING(50) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des Pünktlichkeitsstatusz.Bsp. "Zeitfenster verfallen"'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (anlieferung_status2_id, spr_id) NOT ENFORCED
)
OPTIONS(description='LIS -Sprachabhängige Bezeichnungen des Pünktlichkeitsstatus einer Mercareon-Buchung. Keine SST, wird initial im DWH gepflegt');