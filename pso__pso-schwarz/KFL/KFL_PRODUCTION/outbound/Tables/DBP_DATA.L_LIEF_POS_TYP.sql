--==============================================================
-- Table: l_lief_pos_typ
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lief_pos_typ
   generated from Powerdesigner on Mittwoch, 21. April 2021 16:58:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lief_pos_typ (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lief_pos_typ_id STRING(4) NOT NULL OPTIONS(description='Positionstyp Lieferung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lookup Verrechnungsart');