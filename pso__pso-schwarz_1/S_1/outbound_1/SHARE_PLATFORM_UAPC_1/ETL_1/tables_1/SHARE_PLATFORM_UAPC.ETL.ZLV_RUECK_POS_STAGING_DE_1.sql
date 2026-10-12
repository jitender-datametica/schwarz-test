CREATE OR REPLACE TABLE share_platform_uapc_etl.zlv_rueck_pos_staging_de_1 (
mandant_id BIGNUMERIC(38,0),
mandt STRING(16777216),
tknum STRING(16777216),
markt STRING(16777216),
matnr STRING(16777216),
mblnr STRING(16777216),
mjahr FLOAT64,
lfnr FLOAT64,
werks STRING(16777216),
budat DATE,
menge NUMERIC(14,3),
stpla NUMERIC(14,2),
meins STRING(16777216),
w_turm BIGNUMERIC(38,0),
aetimestamp DATETIME
);