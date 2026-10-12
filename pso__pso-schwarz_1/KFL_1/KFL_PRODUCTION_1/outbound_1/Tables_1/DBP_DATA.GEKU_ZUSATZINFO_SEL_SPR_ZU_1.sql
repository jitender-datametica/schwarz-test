--==============================================================
-- Table: geku_zusatzinfo_sel_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_zusatzinfo_sel_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_zusatzinfo_sel_spr_zu_1 (
zusatzinfo_sel_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID einer Zusatzinfo-Selektion'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
zusatzinfo_sel_bez STRING(255) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Zusatzinfo Selektion, z.Bsp. verdorben (Wurst)'),
quelle_spr_id BIGNUMERIC(38,0)
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (zusatzinfo_sel_id, spr_id) NOT ENFORCED
)
OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der GEKU-Zusatzinfo-Selektionen aus s1_dwh_case_add_info_out');