CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_jahr_kj_vvt_2 AS SELECT SUBSTR(CAST('  ' || CAST(kj AS STRING) AS STRING)
  , 1, 6) AS kj,
 akt_kj,
 akt_kj_komplett
FROM kfl_production_dbp_msi_view_ek_int.mv_tag_2
GROUP BY kj,
 akt_kj,
 akt_kj_komplett;