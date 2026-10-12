CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TANKST_EIGEN_SPR_ZU_2 as
   -- AL 18.01.2012 Tankstelle Eigen, Fremd
   -- AL 07.02.2012 keine Tankstelle als -1 hinzugefügt
   SELECT
   CASE WHEN dat = current_date -2 THEN 1
   WHEN dat= current_date-1 THEN  0
   ELSE -1
   END tankstelle_eigen_fg, CASE WHEN dat = current_date -2 THEN 'Eigen'
   WHEN dat = current_date -1 THEN 'Fremd'
   --Es gibt keine Tankstelle
   ELSE '' END tankstelle_eigen_bez

   FROM dbp_view.v_tag_2
   WHERE dat between current_date -2 and current_date;