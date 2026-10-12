--==============================================================
-- Table: fipo_anlage
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_anlage
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_anlage (
fipo_anlage_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID einer Anlage'),
fipo_antwort_id BIGNUMERIC(38,0) OPTIONS(description='Eindeutige ID einer Antwort aus ant_id'),
fipo_anlage_content BYTES OPTIONS(description='Bild zu einer Anlage aus der Quelle ant_content'),
mime_type STRING(255) COLLATE 'und:ci'
OPTIONS(description='Der Internet Media Type der Anlage aus der Quelle anl_mime_type, z.Bsp. jpg'),
dat_bis DATE
OPTIONS(description='Änderungsdatum der Anlage aus dem Quellfeld anl_geaendert_am , soll im DWH als dat_bis erscheinen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_anlage_id) NOT ENFORCED
) OPTIONS(description='FIPO - Anlagen (Bilder) zu den Antworten aus der Quelltabelle Anlagen');