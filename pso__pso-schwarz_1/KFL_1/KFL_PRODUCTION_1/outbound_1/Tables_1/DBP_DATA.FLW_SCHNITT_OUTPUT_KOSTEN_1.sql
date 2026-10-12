--==============================================================
-- Table: flw_schnitt_output_kosten_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnitt_output_kosten_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_schnitt_output_kosten_1 (
schnitt_id INTEGER NOT NULL OPTIONS(description='Eindeutige Nummer des Schnitts aus cutnr'),
sek_schl_typ_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Typ des Sekundärschlüssels aus sctyp'),
sek_schl_id INTEGER NOT NULL
OPTIONS(description='ID des Sekundärschlüssels aus sckey. Entspricht der Kalkulationsnummer materialwert_kalk_id aus flw_kalk_material_1'),
schnitt_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Position aus posnr'),
kosten_block_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kostenblock aus costb'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
fertig_einzel_kosten_kg NUMERIC(18,4) NOT NULL OPTIONS(description='interne Var. Kosten (Preis) pro kg aus ivarp'),
fertig_einzel_kosten_gesamt NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='interne Var. Kosten (Wert)'),
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (schnitt_id, sek_schl_id, schnitt_pos_id, mandant_id) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='FLW - Schnitt-Position-Kosten aus cutpc');