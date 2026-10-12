CREATE OR REPLACE VIEW kfl_production_dbp_view.v_shopper_score_schwellwerte_1 AS SELECT mandant_id,
 abt_id,
 arthiertyp_id,
 dat_von,
 dat_bis,
 ertrag_uplift_schwellwert,
 wrg_id,
 kaeufer_uplift_schwellwert,
 td_insert,
 td_update
FROM kfl_production_dbp_data.shopper_score_schwellwerte_1;