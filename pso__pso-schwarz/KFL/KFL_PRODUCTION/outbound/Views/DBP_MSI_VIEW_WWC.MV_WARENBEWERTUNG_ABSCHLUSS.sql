CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_warenbewertung_abschluss (wup_id, nb_id, mandant_id, system_id
, buchungskreis_id, dat_aenderung, art_id, gp_id, version_id, dat_von, dat_bis, gld, menge_bestand_bme, wert_bestand,
proz_inventurfort, betrag_inventurfort, inventurfort_wert_bestand, inventurfort_menge_bestand_bme, apm_art_fg, apm_wg,
proz_apm_art, proz_apm_korr, proz_apm_korr_art, proz_apm_hwg, proz_apm_hwg_pa, proz_apm_ja_pa, proz_apm_ges,
betrag_apm_art, betrag_apm_pa, apm_wert_bestand, ausg_wg_nwp, ek_34n, inf_value, ek_2n_1, nw_abwert, wnn_value,
ausg_wg_vfb, proz_abschlag, betrag_vk_netto_vp, betrag_vk_wert, betrag_abw_vf, betrag_gesamt, ausg_wg_rw, dat_erster_vk
, tage, umsatz_menge, menge_hr, kj_reichweite, menge_abverkauf_gm, proz_rw, rw_abschl, best_abw, umsatz_lw, abverkauf_fg
, cluster_reichweite, cluster_reichweite_order, sum_abw) AS SELECT V01.wup_id,
 V01.nb_id,
 V01.mandant_id,
 V01.system_id,
 V01.buchungskreis_id,
 V01.dat_aenderung,
 V01.art_id,
 V03.gp_id,
 V01.version_id,
 V01.dat_von,
 V01.dat_bis,
 V01.gld,
 V01.menge_bestand_bme,
 V01.wert_bestand,
 V01.proz_inventurfort,
 V01.betrag_inventurfort,
 V01.inventurfort_wert_bestand,
 V01.inventurfort_menge_bestand_bme,
 V01.apm_art_fg,
 V01.apm_wg,
 V01.proz_apm_art,
 V01.proz_apm_korr,
 V01.proz_apm_korr_art,
 V01.proz_apm_hwg,
 V01.proz_apm_hwg_pa,
 V01.proz_apm_ja_pa,
 V01.proz_apm_ges,
 V01.betrag_apm_art,
 V01.betrag_apm_pa,
 V01.apm_wert_bestand,
 V01.ausg_wg_nwp,
 V01.ek_34n,
 V01.inf_value,
 V01.ek_2n_1,
 V01.nw_abwert,
 V01.wnn_value,
 V01.ausg_wg_vfb,
 V01.proz_abschlag,
 V01.betrag_vk_netto_vp,
 V01.betrag_vk_wert,
 V01.betrag_abw_vf,
 V01.betrag_gesamt,
 V01.ausg_wg_rw,
 V01.dat_erster_vk,
 V01.tage,
 V01.umsatz_menge,
 V01.menge_hr,
 V01.kj_reichweite,
 V01.menge_abverkauf_gm,
 V01.proz_rw,
 V01.rw_abschl,
 V01.best_abw,
 V01.umsatz_lw,
 V01.abverkauf_fg,
  CASE
  WHEN V01.abverkauf_fg = '1'
  THEN 'Verk. = 0'
  WHEN V01.kj_reichweite < 0.083
  THEN 'Verk. < 1 M.'
  WHEN V01.kj_reichweite > 0 AND V01.kj_reichweite <= 0.5
  THEN '0 - 0.5'
  WHEN V01.kj_reichweite > 0.5 AND V01.kj_reichweite <= 1
  THEN '0.5 - 1'
  WHEN V01.kj_reichweite > 1 AND V01.kj_reichweite <= 2
  THEN '1 - 2'
  WHEN V01.kj_reichweite > 2 AND V01.kj_reichweite <= 3
  THEN '2 - 3'
  WHEN V01.kj_reichweite > 3 AND V01.kj_reichweite <= 4
  THEN '3 - 4'
  WHEN V01.kj_reichweite > 4 AND V01.kj_reichweite <= 5
  THEN '4 - 5'
  WHEN V01.kj_reichweite > 5 AND V01.kj_reichweite <= 6
  THEN '5 - 6'
  WHEN V01.kj_reichweite > 6 AND V01.kj_reichweite <= 7
  THEN '6 - 7'
  WHEN V01.kj_reichweite > 7 AND V01.kj_reichweite <= 8
  THEN '7 - 8'
  WHEN V01.kj_reichweite > 8 AND V01.kj_reichweite <= 9
  THEN '8 - 9'
  WHEN V01.kj_reichweite > 9
  THEN '> 9'
  ELSE NULL
  END AS cluster_reichweite,
  CASE
  WHEN V01.abverkauf_fg = '1'
  THEN 2
  WHEN V01.kj_reichweite < 0.083
  THEN 1
  WHEN V01.kj_reichweite > 0 AND V01.kj_reichweite <= 0.5
  THEN 3
  WHEN V01.kj_reichweite > 0.5 AND V01.kj_reichweite <= 1
  THEN 4
  WHEN V01.kj_reichweite > 1 AND V01.kj_reichweite <= 2
  THEN 5
  WHEN V01.kj_reichweite > 2 AND V01.kj_reichweite <= 3
  THEN 6
  WHEN V01.kj_reichweite > 3 AND V01.kj_reichweite <= 4
  THEN 7
  WHEN V01.kj_reichweite > 4 AND V01.kj_reichweite <= 5
  THEN 8
  WHEN V01.kj_reichweite > 5 AND V01.kj_reichweite <= 6
  THEN 9
  WHEN V01.kj_reichweite > 6 AND V01.kj_reichweite <= 7
  THEN 10
  WHEN V01.kj_reichweite > 7 AND V01.kj_reichweite <= 8
  THEN 11
  WHEN V01.kj_reichweite > 8 AND V01.kj_reichweite <= 9
  THEN 12
  WHEN V01.kj_reichweite > 9
  THEN 13
  ELSE NULL
  END AS cluster_reichweite_order,
 V01.sum_abw
FROM kfl_production_dbp_view.v_warenbewertung_abschluss AS V01
 LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS V03 ON V01.art_id = V03.art_id AND V01.wup_id = V03.wup_id AND
    V01.mandant_id = V03.mandant_id AND V01.dat_aenderung BETWEEN V03.dat_von AND V03.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
          AND (V02.mandant_id NOT IN (1, 7) OR V02.mandant_id IN (1, 7) AND TRIM(CAST(V02.wg_id AS STRING FORMAT '000')
             ) || TRIM(CAST(V02.wug_id AS STRING FORMAT '000')) <> '969006') AND (V02.mandant_id <> 7 OR V02.mandant_id
          = 7 AND TRIM(CAST(V02.wg_id AS STRING FORMAT '000')) <> '980') AND V02.wg_id <> 961 AND (V02.mandant_id NOT IN
        (2, 3, 4, 5, 6, 7, 8) OR V02.mandant_id IN (2, 3, 4, 5, 6, 7, 8) AND TRIM(CAST(V02.wg_id AS STRING FORMAT '000')
          ) || TRIM(CAST(V02.wug_id AS STRING FORMAT '000')) NOT IN ('969001', '969002', '969003', '969004')) AND V02.arthiertyp_id
     = 2 AND V02.dat_bis = DATE '9999-12-31';