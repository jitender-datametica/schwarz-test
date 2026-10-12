CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_abt_grp_zu AS SELECT mandant_id,
 arthiertyp_id,
 abt_grp_id,
 abt_id
FROM kfl_production_dbp_view.v_abt_abt_grp_zu AS V01;