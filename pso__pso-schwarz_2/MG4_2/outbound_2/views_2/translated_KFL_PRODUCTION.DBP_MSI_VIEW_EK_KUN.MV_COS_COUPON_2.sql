-- AP0144054/SPEC0168968 Neudefinition Logik anz_aktivierungen + anz_einloesungen, campaign - ssch 30.05.2023

-- NEUE Definition SPEC0206979 anz_punkte_zu_zahlend / ssch1303 21.12.2023

-- NEU SPEC0206979 Aktionstyp / ssch1303 28.12.2023

-- Mit aufgenommen, da über dieses Feld die unten gemachte neue Berechnung auch auf dieser Ebene dazu gejoined wird

CREATE OR REPLACE VIEW dbp_msi_view_ek_kun.mv_cos_coupon_2 (mandant_id, bonuskauf_id, kampagnen_id, coupon_typ,
aktions_typ, dat_update, campaign, bonuskauf_partner_fg, bonuskauf_anbieter_name, bonuskauf_code_generierung_typ_id,
bonuskauf_code_typ_id, bonuskauf_vorteilsregeln_txt, bonuskauf_konditionen_txt, datzeit_bis_extern_einloesung,
datzeit_von_extern_einloesung, ausgespielter_kanal, anz_punkte_zu_zahlend, anz_aktivierungen_kaufbar,
anz_aktivierungen_nicht_kaufbar, anz_aktivierungen, anz_einloesungen_kaufbar, anz_einloesungen_nicht_kaufbar,
anz_einloesungen) AS -- NEU SPEC0155446 Partnercoupon / ssch1303 28.12.2023
 -- ENDE neue Ausprägungen Partnercoupon

-- NEUE Definition SPEC0206979 Coupontyp / ssch1303 28.12.2023
 -- NEU SPEC0206979 Aktionstyp / ssch1303 28.12.2023

/* Neue Logik Campaign */ -- NEU SPEC0155446 Partnercoupon / ssch1303 28.12.2023

/* Neue Logik Anzahl Aktivierungen kaufbare Coupons */ -- v03
 -- v04, v101
 -- v05
 -- v06

/* Info Bakos 02.08.2023 / Aufgrund neuer Datensaetze mit anz_einloesung = -1 erfolgt CASE Bedingung und CAST zu 0, da sonst falsche
Summierung / sschuecke 02.08.2023 */
SELECT mandant_id,
 bonuskauf_id,
 MAX(kampagnen_id) OVER (PARTITION BY mandant_id, bonuskauf_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS kampagnen_id_0,
 coupon_typ -- NEU SPEC0206979 Aktionstyp / ssch1303 28.12.2023
,
 aktions_typ,
 dat_update,
 campaign -- NEU SPEC0155446 Partnercoupon / ssch1303 28.12.2023
,
 bonuskauf_partner_fg,
 bonuskauf_anbieter_name,
 bonuskauf_code_generierung_typ_id,
 bonuskauf_code_typ_id,
 bonuskauf_vorteilsregeln_txt,
 bonuskauf_konditionen_txt,
 datzeit_bis_extern_einloesung,
 datzeit_von_extern_einloesung,
 ausgespielter_kanal -- ENDE neue Ausprägungen Partnercoupon
,
 anz_punkte_zu_zahlend,
 anz_aktivierungen_kaufbar,
 anz_aktivierungen_nicht_kaufbar,
 anz_aktivierungen,
 anz_einloesungen_kaufbar,
 anz_einloesungen_nicht_kaufbar,
 anz_einloesungen
FROM (SELECT v01.mandant_id,
   v01.crm_kunde_id,
   v01.bonuskauf_id,
   MAX(v01.kampagnen_id) OVER (PARTITION BY v01.mandant_id, v01.bonuskauf_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS kampagnen_id,
   v01.coupon_typ,
   v01.aktions_typ,
   v01.dat_update,
   COUNT(v01.campaign) OVER (PARTITION BY v01.mandant_id, v01.bonuskauf_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS campaign,
   v01.bonuskauf_partner_fg,
   v01.bonuskauf_anbieter_name,
   v01.bonuskauf_code_generierung_typ_id,
   v01.bonuskauf_code_typ_id,
   v01.bonuskauf_vorteilsregeln_txt,
   v01.bonuskauf_konditionen_txt,
   v01.datzeit_bis_extern_einloesung,
   v01.datzeit_von_extern_einloesung,
   RTRIM(CONCAT(CASE
          WHEN v01.sichtbar_in_app_fg = 1
          THEN 'App, '
          ELSE ''
          END || CASE
          WHEN v01.sichtbar_in_web_fg = 1
          THEN 'Web, '
          ELSE ''
          END || CASE
         WHEN v01.sichtbar_in_ssc_fg = 1
         THEN 'SSC, '
         ELSE ''
         END || CASE
        WHEN v01.sichtbar_in_marktplatz_fg = 1
        THEN 'Marktplatz, '
        ELSE ''
        END || CASE
       WHEN v01.sichtbar_in_kampagne_fg = 1
       THEN 'Kampagne_2'
       ELSE ''
       END), ', ') AS ausgespielter_kanal,
   v01.anz_punkte_zu_zahlend,
    COALESCE(v03.anz_aktivierungen_kaufbar, 0) + COALESCE(v101.anz_aktivierungen_nicht_kaufbar, 0) AS anz_aktivierungen
   ,
   v03.anz_aktivierungen_kaufbar,
   v101.anz_aktivierungen_nicht_kaufbar,
   v05.anz_einloesungen_kaufbar,
   v06.anz_einloesungen_nicht_kaufbar,
    COALESCE(v05.anz_einloesungen_kaufbar, 0) + COALESCE(v06.anz_einloesungen_nicht_kaufbar, 0) AS anz_einloesungen
  FROM (SELECT v01.mandant_id,
     v01.bonuskauf_id,
     MAX(CASE
       WHEN v02.kampagnen_id = 'default'
       THEN NULL
       ELSE v02.kampagnen_id
       END) AS kampagnen_id,
      CASE
      WHEN v01.bonuskauf_partner_fg = 1
      THEN 'Partner'
      WHEN v01.nur_marktplatz_fg = 1
      THEN 'Marktplatz'
      WHEN v01.bonuskauf_smp_fg = 1
      THEN 'SMP'
      ELSE 'Coupon'
      END AS coupon_typ,
      CASE
      WHEN v01.gamification_fg = 1
      THEN 'Gamification'
      WHEN v02.checkout_fg = 1
      THEN 'Checkout'
      WHEN v01.kauf_mit_punkte_fg = 1
      THEN 'Kaufbar'
      WHEN v01.bonuskauf_promotionstyp IN ('ZAI', 'ZAIR', 'ZAIM')
      THEN 'Reco'
      ELSE 'Normal'
      END AS aktions_typ,
     DATE(v02.dat_update) AS dat_update,
      CASE
      WHEN (v01.bonuskauf_promotionstyp IN ('ZAI', 'ZAIR', 'ZAIM') OR v02.kampagnen_id IS NOT NULL OR v01.aktiv_loyalty_gesamt_fg
             = 0 OR v01.bonuskauf_partner_fg = 1) AND v02.kampagnen_id <> 'default' OR v01.gamification_fg = 1
      THEN v02.crm_kunde_id
      ELSE NULL
      END AS campaign,
     v01.bonuskauf_partner_fg,
     v01.bonuskauf_anbieter_name,
     v01.bonuskauf_code_generierung_typ_id,
     v01.bonuskauf_code_typ_id,
     v01.bonuskauf_vorteilsregeln_txt,
     v01.bonuskauf_konditionen_txt,
     DATE(v01.datzeit_bis_extern_einloesung) AS datzeit_bis_extern_einloesung,
     DATE(v01.datzeit_von_extern_einloesung) AS datzeit_von_extern_einloesung,
     v01.sichtbar_in_app_fg,
     v01.sichtbar_in_web_fg,
     v01.sichtbar_in_ssc_fg,
     v01.sichtbar_in_marktplatz_fg,
     v01.sichtbar_in_kampagne_fg,
     v02.crm_kunde_id,
      CASE
      WHEN v01.kauf_mit_punkte_fg = 1
      THEN v01.anz_punkte_zu_zahlend
      ELSE NULL
      END AS anz_punkte_zu_zahlend
    FROM kfl_production_dbp_view.v_cos_bonuskauf_2 AS v01
     INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS v02 ON v01.mandant_id = v02.mandant_id AND v01.bonuskauf_id
        = v02.bonuskauf_id
    GROUP BY v01.mandant_id,
     v01.bonuskauf_id,
     v02.kampagnen_id,
     coupon_typ,
     aktions_typ,
     v02.dat_update,
     v01.gamification_fg,
     v01.kauf_mit_punkte_fg,
     v01.bonuskauf_promotionstyp,
     v01.aktiv_loyalty_gesamt_fg,
     v01.bonuskauf_partner_fg,
     v01.bonuskauf_anbieter_name,
     v01.bonuskauf_code_generierung_typ_id,
     v01.bonuskauf_code_typ_id,
     v01.bonuskauf_vorteilsregeln_txt,
     v01.bonuskauf_konditionen_txt,
     v01.datzeit_bis_extern_einloesung,
     v01.datzeit_von_extern_einloesung,
     v01.sichtbar_in_app_fg,
     v01.sichtbar_in_web_fg,
     v01.sichtbar_in_ssc_fg,
     v01.sichtbar_in_marktplatz_fg,
     v01.sichtbar_in_kampagne_fg,
     v02.crm_kunde_id,
     v01.anz_punkte_zu_zahlend) AS v01
   LEFT JOIN (SELECT a.mandant_id,
     a.bonuskauf_id,
     a.crm_kunde_id,
     DATE(a.dat_update) AS dat_update,
     COUNT(*) AS anz_aktivierungen_kaufbar
    FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS a
     INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS b ON a.mandant_id = b.mandant_id AND a.bonuskauf_id = b.bonuskauf_id
       
    WHERE a.kauf_status_nr IN (1, 3)
     AND b.kauf_mit_punkte_fg = 1
     AND (a.mandant_id, a.crm_kunde_id, a.kauf_id, a.bonuskauf_id, a.dat_update) IN (SELECT (a0.mandant_id, a0.crm_kunde_id
         , a0.kauf_id, a0.bonuskauf_id, MIN(a0.dat_update))
       FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS a0
        INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS b0 ON a0.mandant_id = b0.mandant_id AND a0.bonuskauf_id =
          b0.bonuskauf_id
       WHERE a0.kauf_status_nr IN (1, 3)
        AND b0.kauf_mit_punkte_fg = 1
       GROUP BY a0.mandant_id,
        a0.crm_kunde_id,
        a0.kauf_id,
        a0.bonuskauf_id)
    GROUP BY a.mandant_id,
     a.bonuskauf_id,
     a.crm_kunde_id,
     dat_update) AS v03 ON v01.mandant_id = v03.mandant_id AND v01.bonuskauf_id = v03.bonuskauf_id AND v01.dat_update =
      v03.dat_update AND v01.crm_kunde_id = v03.crm_kunde_id
     /* Neue Logik Anzahl Aktivierungen nicht kaufbare Coupons */
   LEFT JOIN (SELECT mandant_id,
     bonuskauf_id,
     crm_kunde_id,
     dat_update,
     COUNT(*) AS anz_aktivierungen_nicht_kaufbar
    FROM (SELECT a1.mandant_id,
       a1.bonuskauf_id,
       a1.crm_kunde_id,
       DATE(a1.dat_update) AS dat_update,
       COUNT(*) AS anz_aktivierungen_nicht_kaufbar
      FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS a1
       INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS b1 ON a1.mandant_id = b1.mandant_id AND a1.bonuskauf_id =
         b1.bonuskauf_id
      WHERE a1.status_aktiv_nr = 1
       AND b1.kauf_mit_punkte_fg = 0
       AND (a1.mandant_id, a1.crm_kunde_id, a1.bonuskauf_id, a1.dat_update, a1.datzeit_status_aktivierung) IN (SELECT (a2
           .mandant_id, a2.crm_kunde_id, a2.bonuskauf_id, MAX(a2.dat_update), MAX(a2.datzeit_status_aktivierung))
         FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS a2
          INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS b2 ON a2.mandant_id = b2.mandant_id AND a2.bonuskauf_id
            = b2.bonuskauf_id
         WHERE a2.status_aktiv_nr = 1
          AND b2.kauf_mit_punkte_fg = 0
         GROUP BY a2.mandant_id,
          a2.crm_kunde_id,
          a2.bonuskauf_id)
      GROUP BY a1.mandant_id,
       a1.bonuskauf_id,
       a1.crm_kunde_id,
       dat_update) AS v04
    GROUP BY mandant_id,
     bonuskauf_id,
     crm_kunde_id,
     dat_update) AS v101 ON v01.mandant_id = v101.mandant_id AND v01.bonuskauf_id = v101.bonuskauf_id AND v01.dat_update
       = v101.dat_update AND v01.crm_kunde_id = v101.crm_kunde_id /* Neue Logik Anzahl Einloesungen kaufbare Coupons */
   LEFT JOIN (SELECT a3.mandant_id,
     a3.bonuskauf_id,
     a3.crm_kunde_id,
     DATE(a3.dat_update) AS dat_update,
     COUNT(*) AS anz_einloesungen_kaufbar
    FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS a3
     INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS b3 ON a3.mandant_id = b3.mandant_id AND a3.bonuskauf_id = b3
       .bonuskauf_id
    WHERE a3.kauf_status_nr = 3
     AND b3.kauf_mit_punkte_fg = 1
     AND (a3.mandant_id, a3.crm_kunde_id, a3.kauf_id, a3.bonuskauf_id, a3.dat_update) IN (SELECT (a4.mandant_id, a4.crm_kunde_id
         , a4.kauf_id, a4.bonuskauf_id, MIN(a4.dat_update))
       FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS a4
        INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS b4 ON a4.mandant_id = b4.mandant_id AND a4.bonuskauf_id =
          b4.bonuskauf_id
       WHERE a4.kauf_status_nr = 3
        AND b4.kauf_mit_punkte_fg = 1
       GROUP BY a4.mandant_id,
        a4.crm_kunde_id,
        a4.kauf_id,
        a4.bonuskauf_id)
    GROUP BY a3.mandant_id,
     a3.bonuskauf_id,
     a3.crm_kunde_id,
     dat_update) AS v05 ON v01.mandant_id = v05.mandant_id AND v01.bonuskauf_id = v05.bonuskauf_id AND v01.dat_update =
      v05.dat_update AND v01.crm_kunde_id = v05.crm_kunde_id /* Neue Logik Anzahl Einloesungen nicht kaufbare Coupons */
     
   LEFT JOIN (SELECT a5.mandant_id,
     a5.bonuskauf_id,
     a5.crm_kunde_id,
     DATE(a5.dat_update) AS dat_update,
     SUM(CASE
       WHEN a5.anz_einloesung = - 1
       THEN 0
       ELSE a5.anz_einloesung
       END) AS anz_einloesungen_nicht_kaufbar
    FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS a5
     INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS b5 ON a5.mandant_id = b5.mandant_id AND a5.bonuskauf_id = b5
       .bonuskauf_id
    WHERE b5.kauf_mit_punkte_fg = 0
     AND (a5.mandant_id, a5.crm_kunde_id, a5.bonuskauf_id, a5.dat_update) IN (SELECT (a6.mandant_id, a6.crm_kunde_id, a6
         .bonuskauf_id, MAX(a6.dat_update))
       FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS a6
        INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS b6 ON a6.mandant_id = b6.mandant_id AND a6.bonuskauf_id =
          b6.bonuskauf_id
       WHERE b6.kauf_mit_punkte_fg = 0
       GROUP BY a6.mandant_id,
        a6.crm_kunde_id,
        a6.bonuskauf_id)
    GROUP BY a5.mandant_id,
     a5.bonuskauf_id,
     a5.crm_kunde_id,
     dat_update) AS v06 ON v01.mandant_id = v06.mandant_id AND v01.bonuskauf_id = v06.bonuskauf_id AND v01.dat_update =
      v06.dat_update AND v01.crm_kunde_id = v06.crm_kunde_id
  GROUP BY v01.mandant_id,
   v01.crm_kunde_id,
   v01.bonuskauf_id,
   kampagnen_id,
   v01.coupon_typ,
   v01.aktions_typ,
   v01.dat_update,
   campaign,
   v01.bonuskauf_partner_fg,
   v01.bonuskauf_anbieter_name,
   v01.bonuskauf_code_generierung_typ_id,
   v01.bonuskauf_code_typ_id,
   v01.bonuskauf_vorteilsregeln_txt,
   v01.bonuskauf_konditionen_txt,
   v01.datzeit_bis_extern_einloesung,
   v01.datzeit_von_extern_einloesung,
   ausgespielter_kanal,
   v01.anz_punkte_zu_zahlend,
   anz_aktivierungen,
   v03.anz_aktivierungen_kaufbar,
   v101.anz_aktivierungen_nicht_kaufbar,
   v05.anz_einloesungen_kaufbar,
   v06.anz_einloesungen_nicht_kaufbar,
   anz_einloesungen) AS t37;