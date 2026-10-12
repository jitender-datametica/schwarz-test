--==============================================================
-- Table: dif_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: dif_typ_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:16 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.dif_typ_spr_zu_1 (
dif_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DIF Typ (Mult., Add., Abs.)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprach-ID'),
dif_typ_bez STRING(40) OPTIONS(description='DIF Typ Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dif_typ_id, spr_id) NOT ENFORCED
) OPTIONS(description='DIF Typ Bezeichnung');