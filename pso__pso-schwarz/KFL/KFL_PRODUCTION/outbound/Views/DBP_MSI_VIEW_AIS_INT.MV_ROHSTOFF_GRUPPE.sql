CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_rohstoff_gruppe (rohstoff_gruppe_typ_id,
rohstoff_gruppe_name, rohstoffkategorie, rohstoffsubkategorie, rohstoff_gruppe_kurz_name) AS SELECT
 rohstoff_gruppe_typ_id,
 rohstoff_gruppe_name,
  CASE
  WHEN rohstoff_gruppe_typ_id = 2
  THEN rohstoff_gruppe_name
  ELSE NULL
  END AS rohstoffkategorie,
  CASE
  WHEN rohstoff_gruppe_typ_id = 3
  THEN rohstoff_gruppe_name
  ELSE NULL
  END AS rohstoffsubkategorie,
 rohstoff_gruppe_kurz_name
FROM kfl_production_dbp_data.rohstoff_gruppe;