CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_d_pep_plan_ref_dat_1 (dat_plan, ref_dat_vj, ref_dat_vj_man) AS
SELECT DISTINCT V00.dat AS dat_plan,
 V01.ref_dat_vj,
 V02.ref_dat_vj AS ref_dat_vj_man
FROM kfl_production_dbp_view.v_tag_1 AS V00
 LEFT JOIN kfl_production_dbp_dialog.d_pep_plan_ref_dat_1 AS V01 ON V00.dat = V01.dat_plan
 LEFT JOIN kfl_production_dbp_msi_v_view.v_pep_plan_ref_dat_1 AS V02 ON V00.dat = V02.dat_plan
WHERE V00.akt_mo > - 4;