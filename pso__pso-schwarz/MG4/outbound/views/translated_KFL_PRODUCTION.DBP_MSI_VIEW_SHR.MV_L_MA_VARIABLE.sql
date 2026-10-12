CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_ma_variable (mandant_id, kjmo, buchungskreis_id,
def_vollzeit_stunden, kalendertage, shr_freigabe_fg) AS -- CROSS JOIN KFL_PRODUCTION.dbp_view.v_shr_kennzahlen v02

-- ON v01.mandant_id = v02.mandant_id
 -- AND v01.kjmo = v02.kjmo
 SELECT v01.mandant_id,
 v01.kjmo,
 v01.buchungskreis_id,
 v01.def_vollzeit_stunden,
  DATE_DIFF(v03.max_dat, v03.min_dat, DAY) + 1 AS kalendertage,
 v01.shr_freigabe_fg
FROM kfl_production_dbp_view.v_l_ma_variable AS v01
 INNER JOIN kfl_production_dbp_view.v_monat AS v03 ON v01.kjmo = v03.kjmo
GROUP BY v01.mandant_id,
 v01.kjmo,
 v01.buchungskreis_id,
 v01.def_vollzeit_stunden,
 v03.max_dat,
 v03.min_dat,
 v01.shr_freigabe_fg;