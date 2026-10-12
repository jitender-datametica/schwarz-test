CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_WINDRICHTUNG_2 as
   SELECT
   v01.windrichtung_schema_id, v01.windrichtung_id
   FROM dbp_view.v_l_windrichtung_2 v01;