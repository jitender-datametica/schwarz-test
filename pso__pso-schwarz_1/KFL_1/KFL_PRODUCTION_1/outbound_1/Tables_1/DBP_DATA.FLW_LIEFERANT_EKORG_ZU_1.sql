--==============================================================
-- Table: flw_lieferant_ekorg_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lieferant_ekorg_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_lieferant_ekorg_zu_1 (
flw_lief_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Einkaufsorganisation aus ekorg'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_lief_id, einkaufsorganisation_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Zuordnung Lieferant zu Einkaufsorganisation aus lfm1_1');