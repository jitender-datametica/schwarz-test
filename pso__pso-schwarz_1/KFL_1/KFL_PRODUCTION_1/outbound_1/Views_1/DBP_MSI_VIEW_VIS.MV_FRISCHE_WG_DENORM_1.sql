CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_frische_wg_denorm_1 AS SELECT V01.mandant_id,
 V01.arthiertyp_id,
 V01.wg_id AS frische_wg_id,
 V02.wg_bez AS frische_wg_bez,
 V02.spr_id
FROM kfl_production_dbp_view.v_wg_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.arthiertyp_id = V02.arthiertyp_id
     AND V01.wg_id = V02.wg_id
WHERE V01.dat_bis = DATE '9999-12-31'
 AND V01.arthiertyp_id = 2
 AND V01.mandant_id = 1
 AND V02.spr_id = 22;