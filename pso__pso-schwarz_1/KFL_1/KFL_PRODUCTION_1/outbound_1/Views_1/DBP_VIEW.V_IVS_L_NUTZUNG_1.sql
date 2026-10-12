CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_l_nutzung_1 AS SELECT mandant_id,
 nutzung_id,
 nutzung_bez,
 spr_id
FROM kfl_production_dbp_data.ivs_l_nutzung_1;