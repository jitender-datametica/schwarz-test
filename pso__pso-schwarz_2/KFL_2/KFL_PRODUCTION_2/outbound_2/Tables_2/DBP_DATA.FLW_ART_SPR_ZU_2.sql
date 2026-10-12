--==============================================================
-- Table: flw_art_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_spr_zu_2 (
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige Kennzeichnung der Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_bez STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Materialkurztext. Quelle ist makt.maktx'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Artikeltexte aus makt_2');