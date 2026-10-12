CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_monat_spr_zu_ro_2 (mo_id, kj_kurz, mo_bez, mo_kbez, mo_kj_bez,
kjmo, kj, mo_bez_lang) AS SELECT V01.mo_id,
 SUBSTR(SUBSTR(CAST(V02.kj AS STRING), 1, 4), 3, 2) AS kj_kurz,
 CAST(V01.mo_bez AS STRING) AS mo_bez,
  SUBSTR(V01.mo_bez, 1, 3) || '.' AS mo_kbez,
    SUBSTR(V01.mo_bez, 1, 3) || '.' || ' ' || SUBSTR(SUBSTR(CAST(V02.kj AS STRING), 1, 4), 3, 2) AS mo_kj_bez,
 V02.kjmo,
 V02.kj,
   TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39)) AS mo_bez_lang
FROM kfl_production_dbp_view.v_monat_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_2 AS V02 ON V01.mo_id = V02.mo_kj
WHERE V02.kjmo >= 201001
 AND V01.spr_id = 95;