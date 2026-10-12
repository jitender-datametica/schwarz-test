CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_ma_variable_1 (mandant_id, kjmo, buchungskreis_id,
def_vollzeit_stunden, kalendertage, shr_freigabe_fg) AS SELECT V01.mandant_id,
 V01.kjmo,
 V01.buchungskreis_id,
 V01.def_vollzeit_stunden,
  DATE_DIFF(V03.max_dat, V03.min_dat, DAY) + 1 AS kalendertage,
 V01.shr_freigabe_fg
FROM kfl_production_dbp_view.v_l_ma_variable_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS V03 ON V01.kjmo = V03.kjmo
GROUP BY V01.mandant_id,
 V01.kjmo,
 V01.buchungskreis_id,
 V01.def_vollzeit_stunden,
 V03.max_dat,
 V03.min_dat,
 V01.shr_freigabe_fg;