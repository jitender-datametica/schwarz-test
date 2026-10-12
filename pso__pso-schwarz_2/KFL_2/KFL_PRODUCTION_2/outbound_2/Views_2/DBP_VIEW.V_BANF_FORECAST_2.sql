CREATE OR REPLACE VIEW kfl_production_dbp_view.v_banf_forecast_2 AS SELECT mandant_id,
 banf_beleg_id,
 banf_beleg_pos_id,
 gp_id,
 wup_id,
 nb_id,
 art_id,
 dat_plan,
 dat_bestell,
 forecast_menge_kolli,
 forecast_menge_einh_id,
 dat_lief_soll
FROM kfl_production_dbp_data.banf_forecast_2;