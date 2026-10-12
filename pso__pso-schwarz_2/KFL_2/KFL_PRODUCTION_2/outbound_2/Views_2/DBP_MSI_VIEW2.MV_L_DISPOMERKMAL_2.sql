CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_dispomerkmal_2 (dispomerkmal, dispomerkmal_bez) AS SELECT
 dispomerkmal,
 dispomerkmal_bez
FROM kfl_production_dbp_view.v_dispomerkmal_spr_zu_2
WHERE mandant_id = 1;