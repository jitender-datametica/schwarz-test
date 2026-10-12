CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_hierarchie_ma_zu_per AS SELECT mandant_id,
 ma_hierarchie_id,
 dat_von,
 ma_hierarchie_typ_id,
 ma_id,
 ma_funktion_id,
 dat_bis
FROM kfl_production_dbp_data.ma_hierarchie_ma_zu_per;