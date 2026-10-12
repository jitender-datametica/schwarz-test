CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_MAT_KJMO_1
AS

   SELECT
   v01.kjmo, v01.kjmo_vj, v01.akt_mo

   FROM dbp_view.v_monat_1  v01
   WHERE v01.akt_mo BETWEEN -120 AND 0;