CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_tp_merkmal_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_id BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_klasse_id BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_sap_id STRING(60) NOT NULL,
tp_merkmal_einheit STRING(3) NOT NULL,
tp_merkmal_datentyp STRING(4) NOT NULL,
tp_merkmal_feldlaenge BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_dezimalstellen BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_vorzeichen_fg BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_intervallwerte_fg BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_einzelwert_fg BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_mehrsprachig_fg BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_wrt_mehrsprachig_fg BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);