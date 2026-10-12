CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_HWG_ZU_PER_1
AS

   SELECT
   v01.hwg_id, v01.mandant_id
   FROM dbp_view.v_hwg_per_1 v01

   WHERE CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;