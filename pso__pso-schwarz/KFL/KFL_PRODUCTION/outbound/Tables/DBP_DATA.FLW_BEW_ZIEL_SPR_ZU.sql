--==============================================================
-- Table: flw_bew_ziel_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_bew_ziel_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_bew_ziel_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
flw_ziel_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ziel (PDAO) aus SAP Quelle /SPDGS/PDAOE1.ZZFWZIEL'),
domaene_bez STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung einer Domäne aus SAP Quelle DD07T.DOMNAME'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
flw_ziel_bez STRING(60) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung Ziel (PDAO) aus SAP Quelle DD07T.DDTEXT'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_ziel_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Texte zu Domänenfestwerten aus SAP P21 DD07T');