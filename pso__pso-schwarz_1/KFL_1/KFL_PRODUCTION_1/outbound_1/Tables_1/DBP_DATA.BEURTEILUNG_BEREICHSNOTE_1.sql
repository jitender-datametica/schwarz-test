--==============================================================
-- Table: beurteilung_bereichsnote_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: beurteilung_bereichsnote_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.beurteilung_bereichsnote_1 (
bereichsnote_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutiger Schlüssel für die Beurteilung_1 eines Bereiches eines Marktes (z.B. Ordnung und Sauberkeit).'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
beurteilung_bereich_id BIGNUMERIC(38,0)
OPTIONS(description='Eindeutiger Schlüssel für den Bereich eines Marktes (z.B. Ordnung und Sauberkeit).'),
beurteilung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutiger Schlüssel für die gesamte Beurteilung_1 eines Marktes. Es können mehrere Beurteilungen pro Markt und Tag_1 erfolgen.'),
note_bereich NUMERIC(9,2) OPTIONS(description='Schulnote für einen Bereich'),
eindruck_bereich STRING(50) COLLATE 'und:ci' OPTIONS(description='Textfeld für den Bereichseindruck'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bereichsnote_id) NOT ENFORCED
) OPTIONS(description='VIS - Schnellbeurteilung Bereichsnote');