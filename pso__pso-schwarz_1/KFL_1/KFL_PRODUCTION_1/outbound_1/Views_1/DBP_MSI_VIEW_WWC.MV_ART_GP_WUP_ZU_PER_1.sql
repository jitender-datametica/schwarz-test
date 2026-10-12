CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_gp_wup_zu_per_1 (mandant_id, art_id, gp_id, wup_id, nb_id,
einkaufsorganisation_id, dat_von, dat_bis, dat_zeitraum, dat, ek_nettonetto, ek_netto, ek_brutto, ek_mep, einstandspreis
, logistikkostenzuschlag, ek_netto_bnk, bonusbasis, ek_mep_vor_fwu, bezugsnebenkosten, ek_netto_bnk_sachk, wrg_id,
letzter_tag_monat_flag) AS SELECT V01.mandant_id,
 V01.art_id,
 V01.gp_id,
 V01.wup_id,
 0 AS nb_id,
 V01.einkaufsorganisation_id,
 V01.dat_von,
 V01.dat_bis,
   CAST(V01.dat_von AS STRING) || ' - ' || CAST(V01.dat_bis AS STRING) AS dat_zeitraum,
 v02.dat,
 V01.ek_nettonetto,
 V01.ek_netto,
 V01.ek_brutto,
 V01.ek_mep,
 V01.einstandspreis,
 V01.logistikkostenzuschlag,
 V01.ek_netto_bnk,
 V01.bonusbasis,
 V01.ek_mep_vor_fwu,
 V01.bezugsnebenkosten,
 V01.ek_netto_bnk_sachk,
 V01.wrg_id,
  CASE
  WHEN LAST_DAY(v02.dat, MONTH) = v02.dat
  THEN 1
  ELSE 0
  END AS letzter_tag_monat_flag
FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_1 AS V01
 INNER JOIN (SELECT dat,
    kjmo,
    kjwo,
    kj,
    akt_kj
   FROM kfl_production_dbp_view.v_tag_1 AS V01
   WHERE akt_kj BETWEEN - 3 AND 2
   UNION ALL
   SELECT CAST('9999-12-31' AS DATE) AS dat,
    999912 AS kjmo,
    999952 AS kjwo,
    9999 AS kj,
    9999 AS akt_kj) AS v02 ON v02.dat BETWEEN V01.dat_von AND V01.dat_bis;