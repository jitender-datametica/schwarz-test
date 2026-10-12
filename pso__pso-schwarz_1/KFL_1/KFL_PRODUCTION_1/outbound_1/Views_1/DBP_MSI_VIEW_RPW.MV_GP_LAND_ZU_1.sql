CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_gp_land_zu_1 (land_id, land_bez, mandant_id, system_id) AS
SELECT A.land_id,
 B.land_bez,
 B.mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_gp_1 AS A
 LEFT JOIN kfl_production_dbp_view.v_land_1 AS B ON A.land_id = B.land_id AND A.mandant_id = B.mandant_id
WHERE A.mandant_id = 1
GROUP BY A.land_id,
 B.land_bez,
 B.mandant_id,
 system_id;