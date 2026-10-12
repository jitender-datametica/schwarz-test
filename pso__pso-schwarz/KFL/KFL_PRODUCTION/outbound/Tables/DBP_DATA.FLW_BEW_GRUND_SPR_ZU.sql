--==============================================================
-- Table: flw_bew_grund_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_bew_grund_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_bew_grund_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
flw_bew_grund_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Grund der Bewegung (PDAO) aus SAP Quelle T157E.GRUND (Ursprung /SPDGS/PDAOE1.ZZGRUND)'),
lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Laber Bewegungsart aus SAP Quelle T157E.BWART'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
flw_bew_grund_bez STRING(20) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung der Bewegung aus SAP Quelle T157E.GRTXT'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_bew_grund_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Texttabelle: Grund der Bewegung aus SAP P21 T157E');