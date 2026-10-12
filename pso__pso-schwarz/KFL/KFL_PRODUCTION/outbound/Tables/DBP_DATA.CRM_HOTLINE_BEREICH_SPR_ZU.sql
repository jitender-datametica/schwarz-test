--==============================================================
-- Table: crm_hotline_bereich_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_hotline_bereich_spr_zu
   generated from Powerdesigner on Dienstag, 20. Mai 2025 16:10:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_hotline_bereich_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
crm_hotline_bereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Bereichs innerhalb der CRM-Hotline, an den der Anruf zugestellt wurde. Dieser Wert kategorisiert, welche Abteilung oder welches Team den Anruf entgegengenommen hat.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
crm_hotline_bereich_bez STRING(200) OPTIONS(description='Bezeichnung des Bereichs innerhalb der CRM-Hotline.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, crm_hotline_bereich_id, spr_id) NOT ENFORCED
)
OPTIONS(description='Diese Tabelle enthält die sprachabhängigen Bezeichnungen der CRM-Hotline-Bereiche. Sie wird manuell befüllt.');