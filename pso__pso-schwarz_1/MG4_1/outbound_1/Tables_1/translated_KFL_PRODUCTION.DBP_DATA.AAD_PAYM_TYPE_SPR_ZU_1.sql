CREATE OR REPLACE TABLE kfl_production_dbp_data.aad_paym_type_spr_zu_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land.'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
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
OPTIONS(description='Contains the translations of payment type (e.g. cash, ec) for each\"mandant_1\" and kpos_zahlung_typ_id');