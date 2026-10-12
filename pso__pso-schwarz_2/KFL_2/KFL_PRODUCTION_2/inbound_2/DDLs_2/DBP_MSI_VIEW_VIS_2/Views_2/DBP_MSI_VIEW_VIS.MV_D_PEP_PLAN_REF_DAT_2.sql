CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_D_PEP_PLAN_REF_DAT_2
(
dat_plan
,ref_dat_vj
,ref_dat_vj_man
)
AS
   SELECT DISTINCT
   v00.dat, v01.ref_dat_vj, v02.ref_dat_vj

   FROM dbp_view.v_tag_2 v00
   LEFT OUTER JOIN dbp_dialog.d_pep_plan_ref_dat_2 v01
   ON       v00.dat = v01.dat_plan
   LEFT OUTER JOIN dbp_msi_v_view.v_pep_plan_ref_dat_2 v02
   ON       v00.dat = v02.dat_plan
   WHERE v00.akt_mo > -4;