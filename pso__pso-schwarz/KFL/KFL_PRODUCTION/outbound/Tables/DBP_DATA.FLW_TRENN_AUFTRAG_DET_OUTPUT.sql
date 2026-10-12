--==============================================================
-- Table: flw_trenn_auftrag_det_output
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_trenn_auftrag_det_output
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_trenn_auftrag_det_output (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
auftrag_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Auftragsnummer aus aufnr'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
menge_ist_bme NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Menge Ist aus ismen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Trennprozess Positionen Output aus spmeat_copo');