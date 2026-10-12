CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_HWG_WG_ZU_PER
AS

   SELECT
   v01.hwg_id, v02.owg_id, v03.wg_id, v01.mandant_id, v01.dat_von, v01.dat_bis

   --hwg_id
   FROM
   dbp_view.v_hwg_per v01
   INNER JOIN dbp_view.v_owg_per v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.hwg_id = v01.hwg_id
   AND CURRENT_DATE BETWEEN v02.dat_von AND v02.dat_bis
   INNER JOIN dbp_view.v_wg_per v03
   ON v03.mandant_id = v02.mandant_id
   AND v03.owg_id = v02.owg_id
   AND CURRENT_DATE BETWEEN v03.dat_von AND v03.dat_bis

   WHERE CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;