--==============================================================
-- Table: l_gp_teilsortiment_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_gp_teilsortiment_1
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:11:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_gp_teilsortiment_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
gp_teilsortiment_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Teilsortiment aus SAP ltsnr'),
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
zahlungsziel_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Zahlungsziel  aus lfm2.zterm'),
zek_id STRING(3) NOT NULL OPTIONS(description='Einkäufergruppe aus lfm2.ekgrp'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gp_id, einkaufsorganisation_id) NOT ENFORCED
) OPTIONS(description='AIS_KMO- Lookup-Tabelle der Teilsortimente pro Lieferant aus den Quellen SAP wyt1t_1 und lfm2_1');