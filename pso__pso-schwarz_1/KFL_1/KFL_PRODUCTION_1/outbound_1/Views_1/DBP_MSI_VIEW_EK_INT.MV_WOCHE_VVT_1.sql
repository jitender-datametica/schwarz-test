CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_woche_vvt_1 AS SELECT gjwo,
 gjwo_vj,
 kjwo,
 kjwo_vj,
 wo_dat_von,
 wo_dat_bis,
 akt_wo,
 akt_wo_komplett,
  DATE_DIFF(wo_dat_von, DATE_SUB(CURRENT_DATE, INTERVAL MOD(DATE_DIFF(CURRENT_DATE, DATE('1990-01-01'), DAY), 7) DAY)
   ,DAY) / 7 AS akt_wo_kalendarisch
FROM kfl_production_dbp_msi_view_ek_int.mv_tag_1
GROUP BY gjwo,
 gjwo_vj,
 kjwo,
 kjwo_vj,
 wo_dat_von,
 wo_dat_bis,
 akt_wo,
 akt_wo_komplett,
 akt_wo_kalendarisch;