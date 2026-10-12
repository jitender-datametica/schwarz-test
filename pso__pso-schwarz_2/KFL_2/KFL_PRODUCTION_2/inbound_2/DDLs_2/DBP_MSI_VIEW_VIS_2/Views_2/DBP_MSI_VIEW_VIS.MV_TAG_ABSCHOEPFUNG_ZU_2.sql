CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TAG_ABSCHOEPFUNG_ZU_2
AS
   SELECT
   v01.sort_id, v01.dat_von, v01.dat_bis, v02.dat
   FROM dbp_msi_view_vis.mv_tag_abschoepfung_2 v01

   JOIN dbp_view.v_tag_2 v02
   ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis;