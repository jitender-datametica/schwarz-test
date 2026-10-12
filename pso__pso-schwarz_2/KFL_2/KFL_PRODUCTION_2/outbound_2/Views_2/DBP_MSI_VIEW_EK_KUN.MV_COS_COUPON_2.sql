CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_cos_coupon_2 (mandant_id, bonuskauf_id, kampagnen_id,
coupon_typ, aktions_typ, dat_update, campaign, bonuskauf_partner_fg, bonuskauf_anbieter_name,
bonuskauf_code_generierung_typ_id, bonuskauf_code_typ_id, bonuskauf_vorteilsregeln_txt, bonuskauf_konditionen_txt,
datzeit_bis_extern_einloesung, datzeit_von_extern_einloesung, ausgespielter_kanal, anz_punkte_zu_zahlend,
anz_aktivierungen_kaufbar, anz_aktivierungen_nicht_kaufbar, anz_aktivierungen, anz_einloesungen_kaufbar,
anz_einloesungen_nicht_kaufbar, anz_einloesungen) AS SELECT mandant_id,
 bonuskauf_id,
 MAX(kampagnen_id) OVER (PARTITION BY CAST(mandant_id AS STRING), bonuskauf_id RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS kampagnen_id_0,
 coupon_typ,
 aktions_typ,
 dat_update,
 campaign,
 bonuskauf_partner_fg,
 bonuskauf_anbieter_name,
 bonuskauf_code_generierung_typ_id,
 bonuskauf_code_typ_id,
 bonuskauf_vorteilsregeln_txt,
 bonuskauf_konditionen_txt,
 datzeit_bis_extern_einloesung,
 datzeit_von_extern_einloesung,
 ausgespielter_kanal,
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
   MAX(v01.kampagnen_id) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), v01.bonuskauf_id RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS kampagnen_id,
   v01.coupon_typ,
   v01.aktions_typ,
   v01.dat_update,
   COUNT(v01.campaign) OVER (PARTITION BY CAST(v01.mandant_id AS STRING), v01.bonuskauf_id RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS campaign,
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
  FROM (SELECT V01.mandant_id,
     V01.bonuskauf_id,
     MAX(CASE
       WHEN V02.kampagnen_id = 'default'
       THEN NULL
       ELSE V02.kampagnen_id
       END) AS kampagnen_id,
      CASE
      WHEN V01.bonuskauf_partner_fg = 1
      THEN 'Partner'
      WHEN V01.nur_marktplatz_fg = 1
      THEN 'Marktplatz'
      WHEN V01.bonuskauf_smp_fg = 1
      THEN 'SMP'
      ELSE 'Coupon'
      END AS coupon_typ,
      CASE
      WHEN V01.gamification_fg = 1
      THEN 'Gamification'
      WHEN V02.checkout_fg = 1
      THEN 'Checkout'
      WHEN V01.kauf_mit_punkte_fg = 1
      THEN 'Kaufbar'
      WHEN V01.bonuskauf_promotionstyp IN ('ZAI', 'ZAIR', 'ZAIM')
      THEN 'Reco'
      ELSE 'Normal'
      END AS aktions_typ,
     DATE(V02.dat_update) AS dat_update,
      CASE
      WHEN (V01.bonuskauf_promotionstyp IN ('ZAI', 'ZAIR', 'ZAIM') OR V02.kampagnen_id IS NOT NULL OR V01.aktiv_loyalty_gesamt_fg
             = 0 OR V01.bonuskauf_partner_fg = 1) AND V02.kampagnen_id <> 'default' OR V01.gamification_fg = 1
      THEN V02.crm_kunde_id
      ELSE NULL
      END AS campaign,
     V01.bonuskauf_partner_fg,
     V01.bonuskauf_anbieter_name,
     V01.bonuskauf_code_generierung_typ_id,
     V01.bonuskauf_code_typ_id,
     V01.bonuskauf_vorteilsregeln_txt,
     V01.bonuskauf_konditionen_txt,
     DATE(V01.datzeit_bis_extern_einloesung) AS datzeit_bis_extern_einloesung,
     DATE(V01.datzeit_von_extern_einloesung) AS datzeit_von_extern_einloesung,
     V01.sichtbar_in_app_fg,
     V01.sichtbar_in_web_fg,
     V01.sichtbar_in_ssc_fg,
     V01.sichtbar_in_marktplatz_fg,
     V01.sichtbar_in_kampagne_fg,
     V02.crm_kunde_id,
      CASE
      WHEN V01.kauf_mit_punkte_fg = 1
      THEN V01.anz_punkte_zu_zahlend
      ELSE NULL
      END AS anz_punkte_zu_zahlend
    FROM kfl_production_dbp_view.v_cos_bonuskauf_2 AS V01
     INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.bonuskauf_id
        = V02.bonuskauf_id
    GROUP BY V01.mandant_id,
     V01.bonuskauf_id,
     V02.kampagnen_id,
     coupon_typ,
     aktions_typ,
     V02.dat_update,
     V01.gamification_fg,
     V01.kauf_mit_punkte_fg,
     V01.bonuskauf_promotionstyp,
     V01.aktiv_loyalty_gesamt_fg,
     V01.bonuskauf_partner_fg,
     V01.bonuskauf_anbieter_name,
     V01.bonuskauf_code_generierung_typ_id,
     V01.bonuskauf_code_typ_id,
     V01.bonuskauf_vorteilsregeln_txt,
     V01.bonuskauf_konditionen_txt,
     V01.datzeit_bis_extern_einloesung,
     V01.datzeit_von_extern_einloesung,
     V01.sichtbar_in_app_fg,
     V01.sichtbar_in_web_fg,
     V01.sichtbar_in_ssc_fg,
     V01.sichtbar_in_marktplatz_fg,
     V01.sichtbar_in_kampagne_fg,
     V02.crm_kunde_id,
     V01.anz_punkte_zu_zahlend) AS v01
   LEFT JOIN (SELECT A.mandant_id,
     A.bonuskauf_id,
     A.crm_kunde_id,
     DATE(A.dat_update) AS dat_update,
     COUNT(*) AS anz_aktivierungen_kaufbar
    FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS A
     INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS B ON A.mandant_id = B.mandant_id AND A.bonuskauf_id = B.bonuskauf_id
       
    WHERE A.kauf_status_nr IN (1, 3)
     AND B.kauf_mit_punkte_fg = 1
     AND (A.mandant_id, A.crm_kunde_id, A.kauf_id, A.bonuskauf_id, A.dat_update) IN (SELECT (A0.mandant_id, A0.crm_kunde_id
         , A0.kauf_id, A0.bonuskauf_id, MIN(A0.dat_update))
       FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS A0
        INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS B0 ON A0.mandant_id = B0.mandant_id AND A0.bonuskauf_id =
          B0.bonuskauf_id
       WHERE A0.kauf_status_nr IN (1, 3)
        AND B0.kauf_mit_punkte_fg = 1
       GROUP BY A0.mandant_id,
        A0.crm_kunde_id,
        A0.kauf_id,
        A0.bonuskauf_id)
    GROUP BY A.mandant_id,
     A.bonuskauf_id,
     A.crm_kunde_id,
     dat_update) AS v03 ON v01.mandant_id = v03.mandant_id AND v01.bonuskauf_id = v03.bonuskauf_id AND v01.dat_update =
      v03.dat_update AND v01.crm_kunde_id = v03.crm_kunde_id
   LEFT JOIN (SELECT mandant_id,
     bonuskauf_id,
     crm_kunde_id,
     dat_update,
     COUNT(*) AS anz_aktivierungen_nicht_kaufbar
    FROM (SELECT A1.mandant_id,
       A1.bonuskauf_id,
       A1.crm_kunde_id,
       DATE(A1.dat_update) AS dat_update,
       COUNT(*) AS anz_aktivierungen_nicht_kaufbar
      FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS A1
       INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS B1 ON A1.mandant_id = B1.mandant_id AND A1.bonuskauf_id =
         B1.bonuskauf_id
      WHERE A1.status_aktiv_nr = 1
       AND B1.kauf_mit_punkte_fg = 0
       AND (A1.mandant_id, A1.crm_kunde_id, A1.bonuskauf_id, A1.dat_update, A1.datzeit_status_aktivierung) IN (SELECT (A2
           .mandant_id, A2.crm_kunde_id, A2.bonuskauf_id, MAX(A2.dat_update), MAX(A2.datzeit_status_aktivierung))
         FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS A2
          INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS B2 ON A2.mandant_id = B2.mandant_id AND A2.bonuskauf_id
            = B2.bonuskauf_id
         WHERE A2.status_aktiv_nr = 1
          AND B2.kauf_mit_punkte_fg = 0
         GROUP BY A2.mandant_id,
          A2.crm_kunde_id,
          A2.bonuskauf_id)
      GROUP BY A1.mandant_id,
       A1.bonuskauf_id,
       A1.crm_kunde_id,
       dat_update) AS v04
    GROUP BY mandant_id,
     bonuskauf_id,
     crm_kunde_id,
     dat_update) AS v101 ON v01.mandant_id = v101.mandant_id AND v01.bonuskauf_id = v101.bonuskauf_id AND v01.dat_update
       = v101.dat_update AND v01.crm_kunde_id = v101.crm_kunde_id
   LEFT JOIN (SELECT A3.mandant_id,
     A3.bonuskauf_id,
     A3.crm_kunde_id,
     DATE(A3.dat_update) AS dat_update,
     COUNT(*) AS anz_einloesungen_kaufbar
    FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS A3
     INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS B3 ON A3.mandant_id = B3.mandant_id AND A3.bonuskauf_id = B3
       .bonuskauf_id
    WHERE A3.kauf_status_nr = 3
     AND B3.kauf_mit_punkte_fg = 1
     AND (A3.mandant_id, A3.crm_kunde_id, A3.kauf_id, A3.bonuskauf_id, A3.dat_update) IN (SELECT (A4.mandant_id, A4.crm_kunde_id
         , A4.kauf_id, A4.bonuskauf_id, MIN(A4.dat_update))
       FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS A4
        INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS B4 ON A4.mandant_id = B4.mandant_id AND A4.bonuskauf_id =
          B4.bonuskauf_id
       WHERE A4.kauf_status_nr = 3
        AND B4.kauf_mit_punkte_fg = 1
       GROUP BY A4.mandant_id,
        A4.crm_kunde_id,
        A4.kauf_id,
        A4.bonuskauf_id)
    GROUP BY A3.mandant_id,
     A3.bonuskauf_id,
     A3.crm_kunde_id,
     dat_update) AS v05 ON v01.mandant_id = v05.mandant_id AND v01.bonuskauf_id = v05.bonuskauf_id AND v01.dat_update =
      v05.dat_update AND v01.crm_kunde_id = v05.crm_kunde_id
   LEFT JOIN (SELECT A5.mandant_id,
     A5.bonuskauf_id,
     A5.crm_kunde_id,
     DATE(A5.dat_update) AS dat_update,
     SUM(CASE
       WHEN A5.anz_einloesung = - 1
       THEN 0
       ELSE A5.anz_einloesung
       END) AS anz_einloesungen_nicht_kaufbar
    FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS A5
     INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS B5 ON A5.mandant_id = B5.mandant_id AND A5.bonuskauf_id = B5
       .bonuskauf_id
    WHERE B5.kauf_mit_punkte_fg = 0
     AND (A5.mandant_id, A5.crm_kunde_id, A5.bonuskauf_id, A5.dat_update) IN (SELECT (A6.mandant_id, A6.crm_kunde_id, A6
         .bonuskauf_id, MAX(A6.dat_update))
       FROM kfl_production_dbp_view.v_cos_bonuskauf_kunde_zu_2 AS A6
        INNER JOIN kfl_production_dbp_view.v_cos_bonuskauf_2 AS B6 ON A6.mandant_id = B6.mandant_id AND A6.bonuskauf_id =
          B6.bonuskauf_id
       WHERE B6.kauf_mit_punkte_fg = 0
       GROUP BY A6.mandant_id,
        A6.crm_kunde_id,
        A6.bonuskauf_id)
    GROUP BY A5.mandant_id,
     A5.bonuskauf_id,
     A5.crm_kunde_id,
     dat_update) AS v06 ON v01.mandant_id = v06.mandant_id AND v01.bonuskauf_id = v06.bonuskauf_id AND v01.dat_update =
      v06.dat_update AND v01.crm_kunde_id = v06.crm_kunde_id
  GROUP BY v01.mandant_id,
   v01.crm_kunde_id,
   v01.bonuskauf_id,
   v01.kampagnen_id,
   v01.coupon_typ,
   v01.aktions_typ,
   v01.dat_update,
   v01.campaign,
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
