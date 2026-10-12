CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_abt_spr_zu (mandant_id, abt_id, arthiertyp_id,
abt_bez) AS SELECT V01.mandant_id,
 V01.abt_id,
 V01.arthiertyp_id,
 V01.abt_bez
FROM kfl_production_dbp_view.v_abt_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id AND V01.arthiertyp_id = 2 AND
    V01.mandant_id IN (1, 2) AND V01.abt_id BETWEEN -3 AND 8;