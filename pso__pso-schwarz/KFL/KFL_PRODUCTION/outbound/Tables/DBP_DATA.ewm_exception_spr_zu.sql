CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ewm_exception_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
ewm_exception_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Ausnahme-Code     '),
ewm_exception_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung von Ausnahme'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);