CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_woche (gjwo, gjwo_vj, kjwo, kjwo_vj, wo_dat_von, wo_dat_bis,
akt_wo, akt_wo_komplett, ww_bez) AS SELECT gjwo,
 gjwo_vj,
 kjwo,
 kjwo_vj,
 wo_dat_von,
 wo_dat_bis,
  akt_wo_komplett - 1 AS akt_wo,
 akt_wo_komplett,
  'WW' || CAST(kjwo AS STRING) AS ww_bez
FROM kfl_production_dbp_view.v_woche;