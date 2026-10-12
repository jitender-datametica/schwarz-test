CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_preistyp (preistyp_id, mandant_id, preistyp_bez
) AS SELECT V01.preistyp_id,
 V01.mandant_id,
 V01.preistyp_bez
FROM kfl_production_dbp_view.v_l_preistyp AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id;