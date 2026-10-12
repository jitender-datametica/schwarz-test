--==============================================================
-- Table: in_art_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_art_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_art_spr_zu (
in_art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige Kennzeichnung der Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
art_bez STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Materialkurztext. Quelle ist makt.maktx'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (in_art_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='BIS - Artikeltexte aus makt');