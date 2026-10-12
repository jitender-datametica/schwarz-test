CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_anlage_klasse_int_spr_zu_ro_1 AS SELECT anlage_klasse_id,
 anlage_klasse_bez_kurz,
 anlage_klasse_bez
FROM kfl_production_dbp_view.v_anlage_klasse_spr_zu_1
WHERE spr_id = 95
 AND anlage_klasse_bez_kurz <> 'inaktiv'
 AND LENGTH(TRIM(COLLATE(anlage_klasse_id, ''), '0')) = 8
 AND ROUND(SAFE_CAST(anlage_klasse_id AS BIGNUMERIC), 0) IS NOT NULL
QUALIFY (ROW_NUMBER() OVER (PARTITION BY anlage_klasse_id ORDER BY mandant_id IS NULL, mandant_id)) = 1;