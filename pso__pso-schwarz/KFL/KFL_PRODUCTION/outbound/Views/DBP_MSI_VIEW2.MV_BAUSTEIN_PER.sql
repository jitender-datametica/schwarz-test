CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_baustein_per (baustein_id, mandant_id, spr_id, baustein_bez,
dat_von, dat_bis) AS SELECT baustein_id,
 mandant_id,
 spr_id,
 baustein_bez,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_baustein_per
WHERE mandant_id = 1;