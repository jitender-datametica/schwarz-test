CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_woche_1 (gjwo, gjwo_vj, kjwo, kjwo_vj, wo_dat_von, wo_dat_bis,
akt_wo, akt_wo_komplett, system_id) AS SELECT gjwo,
 gjwo_vj,
 kjwo,
 kjwo_vj,
 wo_dat_von,
 wo_dat_bis,
 akt_wo,
 akt_wo_komplett,
 7 AS system_id
FROM kfl_production_dbp_view.v_woche_1
WHERE kjwo >= 200501
 AND EXTRACT(YEAR FROM wo_dat_von) <= EXTRACT(YEAR FROM CURRENT_DATE);