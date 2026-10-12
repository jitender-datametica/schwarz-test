CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_kjmo_spr_zu (spr_id, mo_bez, kjmo, kj, gj, gjmo, mo_bez_lang)
AS SELECT spr_id,
 kjmo_bez AS mo_bez,
 kjmo,
 ROUND(CAST(SUBSTR(SUBSTR(CAST(kjmo AS STRING), 1, 10), 2, 8) AS BIGNUMERIC), 0) AS kj,
 ROUND(CAST(SUBSTR(SUBSTR(CAST(gjmo AS STRING), 1, 10), 2, 8) AS BIGNUMERIC), 0) AS gj,
 gjmo,
 CAST(kjmo_bez_lang AS STRING) AS kjmo_bez_lang
FROM kfl_production_dbp_view.v_kjmo_spr_zu
WHERE spr_id = 22
 AND kjmo >= 200201;