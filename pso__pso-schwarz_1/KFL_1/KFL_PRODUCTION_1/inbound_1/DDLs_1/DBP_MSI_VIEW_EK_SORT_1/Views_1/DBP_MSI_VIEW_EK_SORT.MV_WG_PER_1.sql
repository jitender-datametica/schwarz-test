CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_WG_PER_1
AS

   SELECT
   v01.wg_id, v01.dat_von, v01.abt_id, v01.mandant_id, v01.dat_bis, v01.owg_id

   FROM dbp_view.v_wg_per_1 v01
   JOIN dbp_view.v_wg_filter_zu_1 v02
   ON v01.mandant_id = v02.mandant_id AND v01.wg_id = v02.wg_id
   WHERE  v01.dat_bis > CURRENT_DATE AND v02.wg_filter_id = 11;