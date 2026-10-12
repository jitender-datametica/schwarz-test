CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_leist_empfaenger_1 AS SELECT mandant_id,
 leist_empfaenger_sap_id,
 leist_empfaenger_gruppe_id,
 wup_id,
 nb_id,
 ext_ma_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_leist_empfaenger_1;