--==============================================================
-- Table: flw_art_kunde_vkorg_vw_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_kunde_vkorg_vw_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_kunde_vkorg_vw_zu (
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
flw_kunde_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierter Surrogate Key für die Kundennummer aus SAP'),
flw_verkaufsorganisation_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Verkaufsorganisation aus vkorg'),
flw_vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebswegs aus vtweg'),
mandant_id_kunde BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
flw_art_id_kunde BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, mandant_id, flw_kunde_id, flw_vw_id) NOT ENFORCED
)
OPTIONS(description='FLW - Zuordnung der Artikelnummern von Land zu Land (für Fertigerzeugnisse) aus der Quelltabelle knmt');