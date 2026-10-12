--==============================================================
-- Table: flw_art_vkorg_vw_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_vkorg_vw_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_vkorg_vw_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
flw_verkaufsorganisation_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Verkaufsorganisation aus vkorg'),
flw_vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebswegs aus vtweg'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
art_status_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Vertriebslinienspezifischer Materialstatus'),
verk_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Internationalen Maßeinheit aus msehi'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, flw_vw_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Artikel-Verkaufsorganisation-Vertriebsweg-Zuordnung aus SAP.MVKE');