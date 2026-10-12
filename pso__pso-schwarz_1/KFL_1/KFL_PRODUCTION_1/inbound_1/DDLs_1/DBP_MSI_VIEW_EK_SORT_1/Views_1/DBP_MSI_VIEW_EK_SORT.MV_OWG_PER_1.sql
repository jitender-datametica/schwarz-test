CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_OWG_PER_1
AS

   SELECT  DISTINCT
   v01.owg_id, v01.mandant_id, v01.dat_von, v01.dat_bis, v01.hwg_id

   FROM dbp_view.v_owg_per_1 v01
   JOIN dbp_view.v_wg_per_1 v02
   ON v01.mandant_id = v02.mandant_id AND v01.owg_id = v02.owg_id
   JOIN dbp_view.v_wg_filter_zu_1 v03
   ON v02.mandant_id = v03.mandant_id AND v02.wg_id = v03.wg_id

   WHERE CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;