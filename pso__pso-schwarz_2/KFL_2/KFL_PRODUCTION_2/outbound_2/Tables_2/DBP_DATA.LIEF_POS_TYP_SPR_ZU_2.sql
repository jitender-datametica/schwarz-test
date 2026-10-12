--==============================================================
-- Table: lief_pos_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lief_pos_typ_spr_zu_2
   generated from Powerdesigner on Mittwoch, 21. April 2021 17:02:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lief_pos_typ_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
lief_pos_typ_id STRING(4) NOT NULL OPTIONS(description='Positionstyp Lieferung'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprach-ID'),
lief_pos_typ_bez STRING(20) OPTIONS(description='Positionstyp Lieferung Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Verrechnungsart Bezeichnung');