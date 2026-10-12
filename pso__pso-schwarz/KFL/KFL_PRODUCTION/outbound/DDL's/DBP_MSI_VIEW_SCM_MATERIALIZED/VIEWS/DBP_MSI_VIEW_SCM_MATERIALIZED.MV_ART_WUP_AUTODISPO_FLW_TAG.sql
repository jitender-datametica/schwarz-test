CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_wup_autodispo_flw_tag (mandant_id, wup_id,
wup_id_fleischwerk, nb_id, nb_id_vz, art_id, dat, kjwo, we_bearbeitungszeit, planlieferzeit, kdis, verkaufslistung_fg,
sa_af_fg, udf_prognose_menge_gesteuert, udf_prognose_menge_ungesteuert, udf_prognose_menge_gesteuert_af,
udf_prognose_menge_gesteuert_sa, udf_prognose_menge_ungesteuert_af, udf_prognose_menge_ungesteuert_sa,
fur_prognose_menge_ungesteuert, fur_prognose_menge_gesteuert, fur_prognose_menge_max, menge_abverkauf,
menge_abverkauf_af, menge_abverkauf_sa, abs_diff_fur_ungesteuert, abs_diff_fur_ungesteuert_af,
abs_diff_fur_ungesteuert_sa, abs_diff_fur_gesteuert, abs_diff_fur_gesteuert_af, abs_diff_fur_gesteuert_sa, ret_bestand,
fur_bestand, menge_we_offen, menge_bv, menge_ofc, nullbestand_fg, menge_totalabschriften, menge_preisabschriften,
kollifaktor, egalisierungsfaktor, menge_einh_id, servicelevel, optik, menge_we, temperatur_min, temperatur_max,
dauer_sonnenschein_perc, regenrisiko_perc, nullbestand_exc_fg) AS SELECT V01.mandant_id,
 V05.aktuell_wup_id AS wup_id,
 V01.wup_id AS wup_id_fleischwerk,
 V01.nb_id_kunde AS nb_id,
 V01.nb_id_lieferant AS nb_id_vz,
 V01.art_id,
 V01.dat,
 T01.kjwo,
 COALESCE(V01.we_bearbeitungszeit, -1) AS we_bearbeitungszeit,
 COALESCE(V01.planlieferzeit, -1) AS planlieferzeit,
 V01.kdis,
 V01.verkaufslistung_fg,
 V01.sa_af_fg,
 V01.udf_prognose_menge_gesteuert,
 V01.udf_prognose_menge_ungesteuert,
  CASE
  WHEN V01.sa_af_fg = 0
  THEN V01.udf_prognose_menge_gesteuert
  ELSE 0
  END AS udf_prognose_menge_gesteuert_af,
  CASE
  WHEN V01.sa_af_fg = 1
  THEN V01.udf_prognose_menge_gesteuert
  ELSE 0
  END AS udf_prognose_menge_gesteuert_sa,
  CASE
  WHEN V01.sa_af_fg = 0
  THEN V01.udf_prognose_menge_ungesteuert
  ELSE 0
  END AS udf_prognose_menge_ungesteuert_af,
  CASE
  WHEN V01.sa_af_fg = 1
  THEN V01.udf_prognose_menge_ungesteuert
  ELSE 0
  END AS udf_prognose_menge_ungesteuert_sa,
 V01.fur_prognose_menge_ungesteuert,
 V01.fur_prognose_menge_gesteuert,
 V01.fur_prognose_menge_max,
 V01.menge_abverkauf,
  CASE
  WHEN V01.sa_af_fg = 0
  THEN V01.menge_abverkauf
  ELSE 0
  END AS menge_abverkauf_af,
  CASE
  WHEN V01.sa_af_fg = 1
  THEN V01.menge_abverkauf
  ELSE 0
  END AS menge_abverkauf_sa,
 ABS(V01.menge_abverkauf - V01.fur_prognose_menge_ungesteuert) AS abs_diff_fur_ungesteuert,
  CASE
  WHEN V01.sa_af_fg = 0
  THEN ABS(V01.menge_abverkauf - V01.fur_prognose_menge_ungesteuert)
  ELSE NULL
  END AS abs_diff_fur_ungesteuert_af,
  CASE
  WHEN V01.sa_af_fg = 1
  THEN ABS(V01.menge_abverkauf - V01.fur_prognose_menge_ungesteuert)
  ELSE NULL
  END AS abs_diff_fur_ungesteuert_sa,
 ABS(V01.menge_abverkauf - V01.fur_prognose_menge_gesteuert) AS abs_diff_fur_gesteuert,
  CASE
  WHEN V01.sa_af_fg = 0
  THEN ABS(V01.menge_abverkauf - V01.fur_prognose_menge_gesteuert)
  ELSE NULL
  END AS abs_diff_fur_gesteuert_af,
  CASE
  WHEN V01.sa_af_fg = 1
  THEN ABS(V01.menge_abverkauf - V01.fur_prognose_menge_gesteuert)
  ELSE NULL
  END AS abs_diff_fur_gesteuert_sa,
 V01.ret_bestand,
 V01.fur_bestand,
 V01.menge_we_offen,
 V01.menge_bv,
 V01.menge_ofc,
 COALESCE(V01.nullbestand_fg, -1) AS nullbestand_fg,
 V01.menge_totalabschriften,
 V01.menge_preisabschriften,
 V01.kollifaktor,
 V01.egalisierungsfaktor,
 V01.menge_einh_id,
 V01.servicelevel,
 V01.optik,
 V01.menge_we,
 V02.temperatur_min,
 V02.temperatur_max,
 V02.dauer_sonnenschein AS dauer_sonnenschein_perc,
 v03.regenrisiko_perc,
 V01.nullbestand_exc_fg
FROM kfl_production_dbp_view.v_art_wup_autodispo_flw_tag AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON V01.mandant_id = V05.mandant_id AND V01.kunde_id = V05.wup_id AND
   V05.nb_id = 0
 INNER JOIN kfl_production_dbp_view.v_tag AS T01 ON V01.dat = T01.dat
 LEFT JOIN kfl_production_dbp_view.v_wup_wetter_tag AS V02 ON V01.mandant_id = V02.mandant_id AND V01.kunde_id = V02.wup_id
      AND V01.nb_id_kunde = V02.nb_id AND V01.dat = V02.dat
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   dat,
   AVG(CAST(regenrisiko AS NUMERIC)) AS regenrisiko_perc
  FROM kfl_production_dbp_view.v_wup_wetter_tag_stunde
  WHERE zeit_stunde IN (12, 18)
  GROUP BY mandant_id,
   wup_id,
   dat) AS v03 ON V01.mandant_id = v03.mandant_id AND V01.kunde_id = v03.wup_id AND V01.dat = v03.dat
 INNER JOIN (SELECT MAX(dat_bis) AS max_dat
  FROM kfl_production_dbp_view.v_aktion
  WHERE mandant_id = 1
   AND aktionsart_id = 'ZFL') AS zfl ON V01.mandant_id <> 1 OR V01.mandant_id = 1 AND V01.wup_id NOT BETWEEN 6912 AND
     6922 OR V01.dat <= zfl.max_dat;