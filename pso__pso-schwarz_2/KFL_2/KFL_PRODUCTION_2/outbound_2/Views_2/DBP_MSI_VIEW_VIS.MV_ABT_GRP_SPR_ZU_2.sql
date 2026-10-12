CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_abt_grp_spr_zu_2 AS SELECT mandant_id,
 abt_grp_id,
 abt_grp_bez,
 spr_id
FROM kfl_production_dbp_view.v_abt_grp_spr_zu_2 AS V01
WHERE spr_id = 22;