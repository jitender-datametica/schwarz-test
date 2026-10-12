CREATE OR REPLACE TABLE kfl_production_dbp_data.l_tp_merkmal_1 (
mandant_id INTEGER NOT NULL,
tp_merkmal_id INTEGER NOT NULL,
tp_merkmal_klasse_id INTEGER NOT NULL,
tp_merkmal_sap_id STRING(60) NOT NULL,
tp_merkmal_einheit STRING(3) NOT NULL,
tp_merkmal_datentyp STRING(4) NOT NULL,
tp_merkmal_feldlaenge INTEGER NOT NULL,
tp_merkmal_dezimalstellen INTEGER NOT NULL,
tp_merkmal_vorzeichen_fg INTEGER NOT NULL,
tp_merkmal_intervallwerte_fg INTEGER NOT NULL,
tp_merkmal_einzelwert_fg INTEGER NOT NULL,
tp_merkmal_mehrsprachig_fg INTEGER NOT NULL,
tp_merkmal_wrt_mehrsprachig_fg INTEGER NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);