CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_monat_spr_zu_sk_1 (mo_id, kj_kurz, mo_bez, mo_kbez, mo_kj_bez,
kjmo, kj, mo_bez_lang) AS SELECT v01.mo_id,
 SUBSTR(SUBSTR(CAST(v02.kj AS STRING), 1, 4), 3, 2) AS kj_kurz,
 CAST(v01.mo_bez AS STRING) AS mo_bez,
  SUBSTR(v01.mo_bez, 1, 3) || '.' AS mo_kbez,
    SUBSTR(v01.mo_bez, 1, 3) || '.' || ' ' || SUBSTR(SUBSTR(CAST(v02.kj AS STRING), 1, 4), 3, 2) AS mo_kj_bez,
 v02.kjmo,
 v02.kj,
   TRIM(v01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(v02.kj AS STRING), 1, 10)) AS mo_bez_lang
FROM kfl_production_dbp_view.v_monat_spr_zu_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS v02 ON v01.mo_id = v02.mo_kj
WHERE v02.kjmo >= 201001
 AND v01.spr_id = 108;