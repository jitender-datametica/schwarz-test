CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_anlage_klasse_int_1 AS SELECT anlage_klasse_id,
 gesperrt_fg
FROM kfl_production_dbp_view.v_l_anlage_klasse_1
WHERE LENGTH(TRIM(COLLATE(anlage_klasse_id, ''), '0')) = 8
 AND ROUND(SAFE_CAST(anlage_klasse_id AS BIGNUMERIC), 0) IS NOT NULL
QUALIFY (ROW_NUMBER() OVER (PARTITION BY anlage_klasse_id ORDER BY mandant_id IS NULL, mandant_id)) = 1;