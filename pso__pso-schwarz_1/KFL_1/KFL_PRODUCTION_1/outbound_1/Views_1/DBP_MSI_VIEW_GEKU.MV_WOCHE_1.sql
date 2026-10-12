CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_woche_1 (kjwo, gjwo, kjwo_vj, gjwo_vj, kjwo_vvj, gjwo_vvj,
akt_wo_kalendarisch, kj, gj, akt_wo, akt_wo_komplett, ww_bez) AS SELECT kjwo,
 gjwo,
 kjwo_vj,
 gjwo_vj,
  kjwo - 200 AS kjwo_vvj,
  gjwo - 200 AS gjwo_vvj,
 akt_wo_kalendarisch,
 TRUNC(CAST(kjwo / 100 AS BIGNUMERIC)) AS kj,
 TRUNC(CAST(gjwo / 100 AS BIGNUMERIC)) AS gj,
 akt_wo,
 akt_wo_komplett,
  'WW' || CAST(kjwo AS STRING) AS ww_bez
FROM kfl_production_dbp_view.v_woche_1
WHERE kjwo > 200152;