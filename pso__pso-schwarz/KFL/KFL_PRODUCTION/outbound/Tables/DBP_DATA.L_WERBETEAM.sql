--==============================================================
-- Table: l_werbeteam
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbeteam
   generated from Powerdesigner on Freitag, 11. Oktober 2024 15:09:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_werbeteam (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
werbeteam_cd STRING(100) NOT NULL OPTIONS(description='Code des Werbeteams'),
werbebereich_cd STRING(100) OPTIONS(description='Code des Werbebereichs'),
werbeteam_bez STRING(100) OPTIONS(description='Werbeteam - Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werbeteam_cd) NOT ENFORCED
)
OPTIONS(description='Fachlich verantwortliche Personen (auch Planer genannt) die für eine Kategorie an Artikel die über die WGs identifziert werden, die Werbungen in Deutschland planen.             ');