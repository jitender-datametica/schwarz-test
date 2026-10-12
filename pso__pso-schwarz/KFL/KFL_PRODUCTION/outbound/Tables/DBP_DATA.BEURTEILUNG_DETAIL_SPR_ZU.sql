--==============================================================
-- Table: beurteilung_detail_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: beurteilung_detail_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.beurteilung_detail_spr_zu (
beurteilung_detail_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutiger Schlüssel für das Detail eines Bereiches eines Marktes (z.B. Ordnung und Sauberkeit Parkplatz).'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer der Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
beurteilung_detail_bez STRING(50) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung für das Detail eines Bereiches eines Marktes (z.B. Ordnung und Sauberkeit Parkplatz).'),
beurteilung_bereich_bez STRING(50) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung für den Bereich eines Marktes (z.B. Ordnung und Sauberkeit).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (beurteilung_detail_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='VIS - Schnellbeurteilung Detail Sprachzuordnung');