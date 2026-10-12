--==============================================================
-- Table: flw_l_belegtyp_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_belegtyp_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_belegtyp_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
flw_beleg_typ_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Belegtyp, z.Bsp. WE, WA aus belty'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='Abbildung der FLW-Beleg-Typ-ID als eine_1 Loockup Tabelle.');