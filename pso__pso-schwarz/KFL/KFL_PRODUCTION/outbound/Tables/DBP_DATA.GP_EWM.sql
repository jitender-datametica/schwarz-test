--==============================================================
-- Table: gp_ewm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_ewm
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:02:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gp_ewm (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
gp_ewm_id STRING(10) NOT NULL OPTIONS(description='Geschäftspartnernummer'),
gp_ewm_id_num BIGNUMERIC(38,0) OPTIONS(description='Geschäftspartnernummer (numerisch)'),
gp_ewm_typ_id STRING(1) OPTIONS(description='Geschäftspartnertyp'),
gp_ewm_grp_id STRING(4) OPTIONS(description='Geschäftspartnergruppierung'),
name_org_1 STRING(40) OPTIONS(description='Name 1 zum Geschäftspartner'),
name_org_2 STRING(40) OPTIONS(description='Name 2  zum Geschäftspartner'),
gp_ewm_guid STRING(32) OPTIONS(description='GUID eines Geschäftspartners'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagernummern');