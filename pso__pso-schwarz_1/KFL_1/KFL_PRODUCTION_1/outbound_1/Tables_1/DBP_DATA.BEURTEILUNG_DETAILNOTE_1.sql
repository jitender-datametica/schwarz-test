--==============================================================
-- Table: beurteilung_detailnote_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: beurteilung_detailnote_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.beurteilung_detailnote_1 (
detailnote_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutiger Schlüssel für die Beurteilung_1 eines Details eines Bereiches eines Marktes (z.B. Ordnung und Sauberkeit Parkplatz).'),
beurteilung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutiger Schlüssel für die gesamte Beurteilung_1 eines Marktes. Es können mehrere Beurteilungen pro Markt und Tag_1 erfolgen.'),
beurteilung_detail_id BIGNUMERIC(38,0)
OPTIONS(description='Eindeutiger Schlüssel für das Detail eines Bereiches eines Marktes (z.B. Ordnung und Sauberkeit Parkplatz).'),
note_detail NUMERIC(9,2) OPTIONS(description='Schulnote für das Detail eines Bereiches'),
eindruck_detail STRING(50) COLLATE 'und:ci' OPTIONS(description='Textfeld für den Detaileindruck'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (detailnote_id, beurteilung_id) NOT ENFORCED
) OPTIONS(description='VIS - Schnellbeurteilung Detailnote');