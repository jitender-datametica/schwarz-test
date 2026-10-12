CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_l_kreistyp_2 (mandant_id, kreistyp_id, vz_prio_id)
AS SELECT mandant_id,
 kreistyp_id,
 vz_prio_id
FROM kfl_production_dbp_view.v_l_kreistyp_2 AS V01
UNION ALL
SELECT 1 AS mandant_id,
 '' AS kreistyp_id,
 0 AS vz_prio_id;