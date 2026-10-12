--==============================================================
-- Table: beurteilung_bereich_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: beurteilung_bereich_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.beurteilung_bereich_spr_zu_1 (
beurteilung_bereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutiger Schlüssel für den Bereich eines Marktes (z.B. Ordnung und Sauberkeit).'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer der Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
beurteilung_bereich_bez STRING(50) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung für den Bereich eines Marktes (z.B. Ordnung und Sauberkeit).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (beurteilung_bereich_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='VIS - Schnellbeurteilung Bereich Sprachzuordnung');