CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_hierarchie_zu_per_2 AS SELECT ma_id,
 ma_mutter_id,
 dat_von,
 dat_bis,
 mandant_id,
 wup_id,
 ma_hierarchie_ebene_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ma_hierarchie_zu_per_2;