CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ma_1 AS SELECT ma_id,
 dat_von,
 mandant_id,
 sap_ma_id,
 ma_funktion_id,
 dat_bis,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_ma_1;