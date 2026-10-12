CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_wug_2 (mandant_id, arthiertyp_id, wg_id, wug_id, wgi_id) AS
SELECT mandant_id,
 arthiertyp_id,
 wg_id,
 wug_id,
   CASE
   WHEN wg_id < 0
   THEN '-' || SUBSTR(CAST(wg_id AS STRING), 1, 3)
   ELSE SUBSTR(CAST(wg_id AS STRING), 1, 3)
   END || CASE
   WHEN wug_id < 0
   THEN '-' || SUBSTR(CAST(wug_id AS STRING), 1, 3)
   ELSE SUBSTR(CAST(wug_id AS STRING), 1, 3)
   END AS wgi_id
FROM kfl_production_dbp_view.v_wug_2 AS V01
WHERE arthiertyp_id = 2;