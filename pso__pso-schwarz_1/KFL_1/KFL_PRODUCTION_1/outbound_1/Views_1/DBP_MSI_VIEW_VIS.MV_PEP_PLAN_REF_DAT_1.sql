CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_pep_plan_ref_dat_1 (dat_plan, ref_dat_vj) AS SELECT V01.dat AS
 dat_plan,
 V02.ref_dat_vj
FROM kfl_production_dbp_view.v_tag_1 AS V01
 LEFT JOIN kfl_production_dbp_msi_v_view.v_pep_plan_ref_dat_1 AS V02 ON V01.dat = V02.dat_plan
WHERE V01.akt_mo > - 4;