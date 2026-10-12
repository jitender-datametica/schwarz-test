CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_tp_merkmal_1 AS SELECT mandant_id,
 tp_merkmal_id,
 tp_merkmal_klasse_id,
 tp_merkmal_sap_id,
 tp_merkmal_einheit,
 tp_merkmal_datentyp,
 tp_merkmal_feldlaenge,
 tp_merkmal_dezimalstellen,
 tp_merkmal_vorzeichen_fg,
 tp_merkmal_intervallwerte_fg,
 tp_merkmal_einzelwert_fg,
 tp_merkmal_mehrsprachig_fg,
 tp_merkmal_wrt_mehrsprachig_fg
FROM kfl_production_dbp_data.l_tp_merkmal_1;