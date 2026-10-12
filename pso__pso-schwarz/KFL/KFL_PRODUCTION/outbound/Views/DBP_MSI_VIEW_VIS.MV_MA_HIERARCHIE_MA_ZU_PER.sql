CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ma_hierarchie_ma_zu_per AS SELECT mandant_id,
 ma_hierarchie_id,
 ma_hierarchie_typ_id,
 ma_id,
 ma_funktion_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_ma_hierarchie_ma_zu_per
WHERE dat_bis = DATE '9999-12-31';