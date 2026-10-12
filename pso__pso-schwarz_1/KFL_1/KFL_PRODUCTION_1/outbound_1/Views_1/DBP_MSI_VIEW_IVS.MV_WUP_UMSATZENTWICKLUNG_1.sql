CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_wup_umsatzentwicklung_1 AS SELECT WUP.mandant_id,
 MAND.mandant_kbez,
 WUP.wup_id,
 WUP.wup_standort,
 WUP.dat_eroeffnung,
 CAST(NULL AS BIGNUMERIC) AS umsatz_ea_eur,
 CAST(NULL AS BIGNUMERIC) AS umsatz_ea_land,
  CASE
  WHEN MAND.default_wrg <> 'EUR'
  THEN MAND.default_wrg
  ELSE NULL
  END AS wrg_bez,
 zeit.gj,
 kr.umsatz_eur,
 kr.umsatz_land,
 kr.umsatz_plan_eur,
 kr.umsatz_plan_land,
 kr.ergebnis_eur,
 kr.ergebnis_land,
 wc.anzahl_kunden,
 TRUNC(CAST(kr.umsatz_eur / CASE
     WHEN wc.anzahl_kunden = 0
     THEN NULL
     ELSE wc.anzahl_kunden
     END AS BIGNUMERIC)) AS umsatz_durchschnitt_eur,
 TRUNC(CAST(kr.umsatz_land / CASE
     WHEN wc.anzahl_kunden = 0
     THEN NULL
     ELSE wc.anzahl_kunden
     END AS BIGNUMERIC)) AS umsatz_durchschnitt_land,
 TRUNC(CAST(kr.umsatz_eur / CASE
     WHEN wp.verkaufsflaeche = 0
     THEN NULL
     ELSE wp.verkaufsflaeche
     END AS BIGNUMERIC)) AS flaeche_produktivitaet_eur,
 TRUNC(CAST(kr.umsatz_land / CASE
     WHEN wp.verkaufsflaeche = 0
     THEN NULL
     ELSE wp.verkaufsflaeche
     END AS BIGNUMERIC)) AS flaeche_produktivitaet_land,
  TRUNC(CAST(CAST(kr.ergebnis_eur AS BIGNUMERIC) / CASE
      WHEN CAST(kr.umsatz_eur AS BIGNUMERIC) = 0
      THEN NULL
      ELSE CAST(kr.umsatz_eur AS BIGNUMERIC)
      END AS BIGNUMERIC)) * 100.0 AS ergebnis_proz,
 wp.preiskategorie_food,
 wp.verkaufsflaeche,
 wp.verkaufs_ebene_bez AS verkaufsebenen,
 wp.parken_bez AS parken,
 wp.standort_typ_bez AS standorttyp,
 wp.lage_bez AS lage,
 wp.auflage_tip
FROM kfl_production_dbp_view.v_wup_1 AS WUP_1
 FULL JOIN (SELECT DISTINCT MAND0.mandant_id,
   ZEIT0.gj
  FROM kfl_production_dbp_view.v_monat_1 AS ZEIT0
   INNER JOIN kfl_production_dbp_view.v_mandant_1 AS MAND0 ON TRUE
  WHERE ZEIT0.akt_gj BETWEEN - 5 AND 0) AS zeit_1 ON WUP.mandant_id = zeit.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_mandant_1 AS MAND ON WUP.mandant_id = MAND.mandant_id
 LEFT JOIN (SELECT KR.mandant_id,
   PC.wup_id,
   ZEIT.gj,
   KR.wrg_id,
   CAST(SUM(CASE
      WHEN ka.report_pos = 'UMS' AND KR.plan_fg = 0
      THEN KR.kostenrechnung_betrag * K.umrechnungskurs
      ELSE NULL
      END) AS NUMERIC) AS umsatz_eur,
   CAST(SUM(CASE
      WHEN ka.report_pos = 'UMS' AND KR.plan_fg = 0
      THEN KR.kostenrechnung_betrag
      ELSE NULL
      END) AS NUMERIC) AS umsatz_land,
   CAST(SUM(CASE
      WHEN ka.report_pos = 'UMS' AND KR.plan_fg = 1
      THEN KR.kostenrechnung_betrag * K.umrechnungskurs
      ELSE NULL
      END) AS NUMERIC) AS umsatz_plan_eur,
   CAST(SUM(CASE
      WHEN ka.report_pos = 'UMS' AND KR.plan_fg = 1
      THEN KR.kostenrechnung_betrag
      ELSE NULL
      END) AS NUMERIC) AS umsatz_plan_land,
   CAST(SUM(CASE
      WHEN ka.report_pos = 'ERG' AND KR.plan_fg = 0
      THEN KR.kostenrechnung_betrag * K.umrechnungskurs
      ELSE NULL
      END) AS NUMERIC) AS ergebnis_eur,
   CAST(SUM(CASE
      WHEN ka.report_pos = 'ERG' AND KR.plan_fg = 0
      THEN KR.kostenrechnung_betrag
      ELSE NULL
      END) AS NUMERIC) AS ergebnis_land
  FROM kfl_production_dbp_view.v_kostenrechnung_1 AS KR
   INNER JOIN kfl_production_dbp_view.v_profit_center_1 AS PC ON KR.pc_id = PC.pc_id AND KR.mandant_id = PC.mandant_id
   INNER JOIN kfl_production_dbp_view.v_monat_1 AS ZEIT_1 ON ZEIT.kjmo = CASE
     WHEN MOD(KR.kj_ker_mo_id, 100) = 13
     THEN KR.kj_ker_mo_id + 89
     ELSE KR.kj_ker_mo_id
     END
   INNER JOIN kfl_production_dbp_view.v_kurs_1 AS K ON KR.wrg_id = K.von_wrg_id AND K.dat_bis = DATE '9999-12-31' AND K.kurstyp_id
      = 3
   INNER JOIN (SELECT ka_lv11 AS kostenart_id,
      SUBSTR('UMS', 1, 3) AS report_pos
     FROM kfl_production_dbp_msi_v_view.v_ka_ka_grp_denorm_1
     WHERE TRIM(ka_lv1) IN ('K0')
      OR TRIM(ka_lv2) IN ('K0')
      OR TRIM(ka_lv3) IN ('K0')
      OR TRIM(ka_lv4) IN ('K0')
      OR TRIM(ka_lv5) IN ('K0')
      OR TRIM(ka_lv6) IN ('K0')
      OR TRIM(ka_lv7) IN ('K0')
      OR TRIM(ka_lv8) IN ('K0')
      OR TRIM(ka_lv9) IN ('K0')
      OR TRIM(ka_lv10) IN ('K0')
      OR TRIM(ka_lv11) IN ('K0')
     UNION ALL
     SELECT ka_lv11 AS kostenart_id,
      SUBSTR('ERG', 1, 3) AS report_pos
     FROM kfl_production_dbp_msi_v_view.v_ka_ka_grp_denorm_1
     WHERE TRIM(ka_lv1) IN ('K1', 'K21', 'K22', 'K31', 'K32', 'K33', 'K41', 'K42', 'K43')
      OR TRIM(ka_lv2) IN ('K1', 'K21', 'K22', 'K31', 'K32', 'K33', 'K41', 'K42', 'K43')
      OR TRIM(ka_lv3) IN ('K1', 'K21', 'K22', 'K31', 'K32', 'K33', 'K41', 'K42', 'K43')
      OR TRIM(ka_lv4) IN ('K1', 'K21', 'K22', 'K31', 'K32', 'K33', 'K41', 'K42', 'K43')
      OR TRIM(ka_lv5) IN ('K1', 'K21', 'K22', 'K31', 'K32', 'K33', 'K41', 'K42', 'K43')
      OR TRIM(ka_lv6) IN ('K1', 'K21', 'K22', 'K31', 'K32', 'K33', 'K41', 'K42', 'K43')
      OR TRIM(ka_lv7) IN ('K1', 'K21', 'K22', 'K31', 'K32', 'K33', 'K41', 'K42', 'K43')
      OR TRIM(ka_lv8) IN ('K1', 'K21', 'K22', 'K31', 'K32', 'K33', 'K41', 'K42', 'K43')
      OR TRIM(ka_lv9) IN ('K1', 'K21', 'K22', 'K31', 'K32', 'K33', 'K41', 'K42', 'K43')
      OR TRIM(ka_lv10) IN ('K1', 'K21', 'K22', 'K31', 'K32', 'K33', 'K41', 'K42', 'K43')
      OR TRIM(ka_lv11) IN ('K1', 'K21', 'K22', 'K31', 'K32', 'K33', 'K41', 'K42', 'K43')) AS ka ON KR.kostenart_id = ka
    .kostenart_id
  WHERE ZEIT.akt_gj BETWEEN - 5 AND 0
   AND PC.nb_id = 0
  GROUP BY KR.mandant_id,
   PC.wup_id,
   ZEIT.gj,
   KR.wrg_id) AS kr ON WUP.mandant_id = kr.mandant_id AND WUP.wup_id = kr.wup_id AND zeit.gj = kr.gj
 LEFT JOIN (SELECT WP0.mandant_id,
   WP0.wup_id,
   WP0.kjmo,
   zeit0.gj,
   WP0.preiskategorie_food,
   WP0.verkaufsflaeche,
   WP0.verkaufs_ebene_bez,
   WP0.parken_bez,
   WP0_S.standort_typ_bez,
   WP0_L.lage_bez,
   WP0.auflage_tip
  FROM kfl_production_dbp_view.v_wup_per_1 AS WP0
   INNER JOIN (SELECT WP01.mandant_id,
     WP01.wup_id,
     ZEIT01.gj,
     MAX(WP01.kjmo) AS kjmo_max
    FROM kfl_production_dbp_view.v_wup_per_1 AS WP01
     INNER JOIN kfl_production_dbp_view.v_monat_1 AS ZEIT01 ON WP01.kjmo = ZEIT01.kjmo
    WHERE ZEIT01.akt_gj BETWEEN - 5 AND 0
    GROUP BY WP01.wup_id,
     WP01.mandant_id,
     ZEIT01.gj) AS zeit0 ON WP0.mandant_id = zeit0.mandant_id AND WP0.wup_id = zeit0.wup_id AND WP0.kjmo = zeit0.kjmo_max
     
   LEFT JOIN kfl_production_dbp_view.v_l_standort_typ_1 AS WP0_S ON WP0.standort_typ_id = WP0_S.standort_typ_id
   LEFT JOIN kfl_production_dbp_view.v_l_lage_1 AS WP0_L ON WP0.lage_id = WP0_L.lage_id
  WHERE WP0.nb_id = 0
   AND WP0.wrg_id = 'EUR') AS wp ON WUP.mandant_id = wp.mandant_id AND WUP.wup_id = wp.wup_id AND zeit.gj = wp.gj
 LEFT JOIN (SELECT WC0.mandant_id,
   WC0.wup_id,
   ZEIT00.gj,
   SUM(WC0.bonanzahl) AS anzahl_kunden
  FROM kfl_production_dbp_view.v_wupcal_mo_sum_1 AS WC0
   INNER JOIN kfl_production_dbp_view.v_monat_1 AS ZEIT00 ON WC0.kjmo = ZEIT00.kjmo
  WHERE WC0.nb_id = 0
   AND ZEIT00.akt_gj BETWEEN - 5 AND 0
  GROUP BY WC0.wup_id,
   WC0.mandant_id,
   ZEIT00.gj) AS wc ON WUP.mandant_id = wc.mandant_id AND WUP.wup_id = wc.wup_id AND zeit.gj = wc.gj
WHERE WUP.nb_id = 0
 AND WUP.dat_eroeffnung < DATE '2090-12-31';