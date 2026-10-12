--==============================================================
-- Table: in_l_wg
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_wg
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_wg (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
in_wg_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Warengruppe aus dem Industriesystem. Quelle ist matkl'),
in_wg_struktur_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige ID der Warengruppenstruktur.Aus dem SAP-Klassensystem'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookuptabelle der Industriesystem-Warengruppen aus t023t');