--==============================================================
-- Table: flw_schnitt_output_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnitt_output_det_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_schnitt_output_det_1 (
schnitt_id INTEGER NOT NULL OPTIONS(description='Eindeutige Nummer des Schnitts aus cutnr'),
sek_schl_typ_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Typ des Sekundärschlüssels aus sctyp'),
sek_schl_id INTEGER NOT NULL
OPTIONS(description='ID des Sekundärschlüssels aus sckey. Entspricht der Kalkulationsnummer materialwert_kalk_id aus flw_kalk_material_1'),
schnitt_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Position aus posnr'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
menge_schnitt NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Menge in KG aus menge'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
betrag_schnitt_output NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='material_gesamt_kosten'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (schnitt_id, sek_schl_id, schnitt_pos_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Schnitt Output-Positionen aus spmeat_cutp');