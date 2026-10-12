CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_monat_spr_zu_2 (mo_kj, mo_bez, kjmo, kj, mo_bez_lang) AS SELECT
 v01.mo_id AS mo_kj,
 CAST(v01.mo_bez AS STRING) AS mo_bez,
 v02.kjmo,
 v02.kj,
   TRIM(v01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(v02.kj AS STRING), 1, 10)) AS mo_bez_lang
FROM kfl_production_dbp_view.v_monat_spr_zu_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_monat_2 AS v02 ON v01.mo_id = v02.mo_kj
WHERE v02.kjmo >= 201001
 AND v01.spr_id = 22;