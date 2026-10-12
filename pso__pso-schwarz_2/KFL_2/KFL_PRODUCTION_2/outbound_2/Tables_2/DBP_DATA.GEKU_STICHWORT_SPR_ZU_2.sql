--==============================================================
-- Table: geku_stichwort_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_stichwort_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_stichwort_spr_zu_2 (
geku_stichwort_uid INTEGER NOT NULL OPTIONS(description='eindeutige ID des Stichworts aus dem GEKU-System'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
geku_stichwort_bez STRING(255) COLLATE 'und:ci' OPTIONS(description='Sprachabhängige Bezeichnung des MZK-Stichworts'),
quelle_spr_id BIGNUMERIC(38,0)
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_stichwort_uid, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU -Sprachabhängiger Text  des GEKU - MZK-Stichworts');