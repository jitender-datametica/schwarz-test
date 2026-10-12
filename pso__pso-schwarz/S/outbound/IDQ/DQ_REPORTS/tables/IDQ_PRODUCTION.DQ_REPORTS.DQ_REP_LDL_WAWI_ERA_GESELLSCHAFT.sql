CREATE OR REPLACE TABLE idq_production_dq_reports.dq_rep_ldl_wawi_era_gesellschaft (
country_id BIGNUMERIC(38,0),
calculation_time DATETIME,
land STRING(160),
gesellschaftsbezeichnung STRING(16777216),
client_id BIGNUMERIC(38,0),
gesellschaft BIGNUMERIC(38,0),
artikelnummer STRING(16777216),
artikelbezeichnung STRING(50),
uwg BIGNUMERIC(38,0),
artikelfamilie STRING(16777216),
artikelart STRING(50),
palletenfaktoren STRING(16777216),
relevanzkriterien STRING(16777216),
item_status STRING(16777216),
geaendert_am STRING(16777216),
kassensperre STRING(3)
);