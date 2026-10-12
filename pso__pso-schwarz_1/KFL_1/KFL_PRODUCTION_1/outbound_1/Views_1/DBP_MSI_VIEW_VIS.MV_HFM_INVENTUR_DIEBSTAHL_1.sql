CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hfm_inventur_diebstahl_1 AS SELECT sub01.mandant_id,
 sub01.nb_id,
 sub01.wup_id,
 sub01.wrg_id,
 sub01.wg_id,
 ZEIT0.gj,
 sub01.inv_fg,
 sub01.dat_inv,
 SUM(sub01.ums_netto) AS inv_ums_ges,
 SUM(sub01.ums_netto * sub01.inv_fg) AS inv_ums_bis_inv,
  SUM(sub01.ums_netto) - SUM(sub01.ums_netto * sub01.inv_fg) AS inv_ums_nach_inv,
 SUM(sub01.inv_diebstahl) AS inv_diebstahl_ges,
 SUM(sub01.inv_diebstahl * sub01.inv_fg) AS inv_diebstahl_bis_inv,
 SUM(sub01.inv_diebstahl * 0.00) AS inv_diebstahl_ohne_inv,
  SUM(sub01.inv_diebstahl) - SUM(sub01.inv_diebstahl * sub01.inv_fg) AS inv_diebstahl_nach_inv,
 SUM(sub01.inv_bestand_korrektur) AS inv_bestand_korrektur_ges,
 SUM(sub01.inv_bestand_korrektur * sub01.inv_fg) AS inv_bestand_korrektur_bis_inv,
 SUM(sub01.inv_bestand_korrektur * 0.00) AS inv_bestand_korrektur_ohne_inv,
  SUM(sub01.inv_bestand_korrektur) - SUM(sub01.inv_bestand_korrektur * sub01.inv_fg) AS inv_bestand_korrektur_nach_inv,
 SUM(sub01.ums_netto * sub01.akt_gj_fg) AS inv_ums_akt_gj,
 SUM(sub01.inv_diebstahl * sub01.akt_gj_fg) AS inv_diebstahl_akt_gj
FROM (SELECT vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.wg_id,
   vis.wrg_id,
   vis.dat,
   vis.ums_netto,
   COALESCE(mab.inv_diebstahl, 0) AS inv_diebstahl,
   COALESCE(mab.inv_bestand_korrektur, 0) AS inv_bestand_korrektur,
   COALESCE(hfm.dat_plan_zaehlung, DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) AS dat_inv,
   COALESCE(hfm.inventur_fg, 0) AS inv_fg,
   CAST(CASE
     WHEN vis.akt_gj = 0
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) AS akt_gj_fg
  FROM (SELECT VIS0.mandant_id,
      VIS0.nb_id,
      VIS0.wup_id,
      VIS0.wg_id,
      VIS0.wrg_id,
      VIS0.dat,
      VIS0.ums_netto,
      ZEIT.akt_gj
     FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_wg_1 AS VIS0
      INNER JOIN kfl_production_dbp_view.v_tag_1 AS ZEIT_1 ON VIS0.dat = ZEIT.dat AND ZEIT.akt_gj BETWEEN - 1 AND 0 AND ZEIT_1
        .akt_tag < 1
     UNION ALL
     SELECT VIS0.mandant_id,
      VIS0.nb_id,
      VIS0.wup_id,
      VIS0.wg_id,
      VIS0.wrg_id,
      DATE_SUB(VIS0.dat, INTERVAL 364 DAY),
      VIS0.ums_netto_wvj,
      ZEIT.akt_gj
     FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_wg_1 AS VIS0
      INNER JOIN kfl_production_dbp_view.v_tag_1 AS ZEIT_1 ON VIS0.dat = ZEIT.dat AND ZEIT.akt_gj = - 1) AS vis
   LEFT JOIN (SELECT MAB0.mandant_id,
      MAB0.nb_id,
      MAB0.wup_id,
      MAB0.wrg_id,
      AWG0.wg_id,
      MAB0.dat,
      CAST(SUM(CASE
         WHEN ABA0.abschriftart_int_id IN (190)
         THEN - 1 * MAB0.abschriftbetrag_netto
         ELSE 0
         END) AS NUMERIC) AS inv_diebstahl,
      CAST(SUM(CASE
         WHEN ABA0.abschriftart_int_id IN (343, 344) AND MAB0.positionsnummer_id <> 1
         THEN - 1 * MAB0.abschriftbetrag_netto
         ELSE 0
         END) AS NUMERIC) AS inv_bestand_korrektur
     FROM kfl_production_dbp_view.v_marktabschriften_1 AS MAB0
      INNER JOIN kfl_production_dbp_view.v_abschriftart_int_zu_1 AS ABA0 ON MAB0.abschriftart_id = ABA0.abschriftart_id
        AND MAB0.mandant_id = ABA0.mandant_id AND ABA0.abschriftart_int_id IN (190, 343, 344)
      INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS AWG0 ON MAB0.art_id = AWG0.art_id AND MAB0.mandant_id = AWG0
          .mandant_id AND AWG0.arthiertyp_id = 2 AND AWG0.dat_bis = DATE '9999-12-31'
     GROUP BY MAB0.mandant_id,
      MAB0.nb_id,
      MAB0.wup_id,
      MAB0.wrg_id,
      AWG0.wg_id,
      MAB0.dat
     UNION ALL
     SELECT MAB0.mandant_id,
      MAB0.nb_id,
      MAB0.wup_id,
      KURS0.nach_wrg_id,
      AWG0.wg_id,
      MAB0.dat,
      CAST(SUM(CASE
         WHEN ABA0.abschriftart_int_id IN (190)
         THEN - 1 * MAB0.abschriftbetrag_netto * KURS0.umrechnungskurs
         ELSE 0
         END) AS NUMERIC) AS inv_diebstahl,
      CAST(SUM(CASE
         WHEN ABA0.abschriftart_int_id IN (343, 344) AND MAB0.positionsnummer_id <> 1
         THEN - 1 * MAB0.abschriftbetrag_netto * KURS0.umrechnungskurs
         ELSE 0
         END) AS NUMERIC) AS inv_bestand_korrektur
     FROM kfl_production_dbp_view.v_marktabschriften_1 AS MAB0
      INNER JOIN kfl_production_dbp_view.v_abschriftart_int_zu_1 AS ABA0 ON MAB0.abschriftart_id = ABA0.abschriftart_id
        AND MAB0.mandant_id = ABA0.mandant_id AND ABA0.abschriftart_int_id IN (190, 343, 344)
      INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS AWG0 ON MAB0.art_id = AWG0.art_id AND MAB0.mandant_id = AWG0
          .mandant_id AND AWG0.arthiertyp_id = 2 AND AWG0.dat_bis = DATE '9999-12-31'
      INNER JOIN kfl_production_dbp_view.v_mandant_1 AS MAN0 ON MAB0.mandant_id = MAN0.mandant_id AND MAN0.default_wrg <>
        'EUR'
      INNER JOIN kfl_production_dbp_view.v_kurs_1 AS KURS0 ON MAB0.wrg_id = KURS0.von_wrg_id AND KURS0.kurstyp_id = 3 AND
        KURS0.dat_bis = DATE '9999-12-31'
     GROUP BY MAB0.mandant_id,
      MAB0.nb_id,
      MAB0.wup_id,
      KURS0.nach_wrg_id,
      AWG0.wg_id,
      MAB0.dat) AS mab ON vis.mandant_id = mab.mandant_id AND vis.wup_id = mab.wup_id AND vis.wg_id = mab.wg_id AND vis
      .wrg_id = mab.wrg_id AND vis.dat = mab.dat
   LEFT JOIN (SELECT mandant_id,
     nb_id,
     wup_id,
     wg_id,
     dat_plan_zaehlung,
     dat_vorletzte_zaehlung,
     1 AS inventur_fg
    FROM kfl_production_dbp_view.v_hfm_inventur_termin_wg_wup_zu_per_1 AS INV0
    WHERE inventurart_int_id <> 8) AS hfm ON vis.mandant_id = hfm.mandant_id AND vis.wup_id = hfm.wup_id AND vis.wg_id =
      hfm.wg_id AND vis.dat BETWEEN hfm.dat_vorletzte_zaehlung AND hfm.dat_plan_zaehlung) AS sub01
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS ZEIT0 ON sub01.dat_inv = ZEIT0.dat
GROUP BY sub01.mandant_id,
 sub01.nb_id,
 sub01.wup_id,
 sub01.wrg_id,
 sub01.wg_id,
 ZEIT0.gj,
 sub01.inv_fg,
 sub01.dat_inv;