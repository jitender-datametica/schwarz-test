CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WINDRICHTUNG_MAP as
   SELECT
  windrichtung_schema_id_source, 
  windrichtung_id_source, 
  windrichtung_schema_id_dest,
  windrichtung_id_dest
   FROM dbp_view.v_windrichtung_map;