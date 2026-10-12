--==============================================================
-- Table: aad_paym_type_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_paym_type_spr_zu
   generated from Powerdesigner on Mittwoch, 10. Mai 2023 08:39:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_paym_type_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
kpos_zahlung_typ_id STRING(4) NOT NULL OPTIONS(description='KPOS Zahlung Typ id'),
kpos_zahlung_typ_bez STRING(50) OPTIONS(description='KPOS Zahlung typ Bezeichnung'),
paym_type_name STRING(100)
OPTIONS(description='The payment type for the combination of mandant_id and kpos_zahlung_typ_id'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, kpos_zahlung_typ_id) NOT ENFORCED
)
OPTIONS(description='Contains the translations of payment type (e.g. cash, ec) for each "mandant" and kpos_zahlung_typ_id');