CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_HWG_PER_1 as
   SELECT DISTINCT
   v01.hwg_id, v01.abt_id, v01.arthiertyp_id
   FROM dbp_view.v_hwg_per_1 v01
   WHERE v01.arthiertyp_id=2
   AND v01.dat_bis = '9999-12-31';