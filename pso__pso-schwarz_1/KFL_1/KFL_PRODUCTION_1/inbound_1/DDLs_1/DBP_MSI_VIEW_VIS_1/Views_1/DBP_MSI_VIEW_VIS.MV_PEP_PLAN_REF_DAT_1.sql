CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PEP_PLAN_REF_DAT_1
(
dat_plan
,ref_dat_vj

)
AS
   select
   v01.dat, v02.ref_dat_vj


   from dbp_view.v_tag_1  v01
   LEFT OUTER JOIN dbp_msi_v_view.v_pep_plan_ref_dat_1 v02
   ON v01.dat = v02.dat_plan
   Where akt_mo > -4
   ;