CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_ts_wbs_artikel_vz_1 (mandant_id, ausliefergruppe_id
, kjwo, kjwo_ww, angebot_id, aktion_id, bonuskauf_promotionstyp, dat_ab, dat_bis, anz_tage_werbung, art_id, wup_id_vz,
gp_id, nb_id_vz, mandant_id_vz, wup_count, max_kapa_fg_markt, clear_stock_id, clear_stock_bez, estimation_fg,
max_kapa_fg, adjustment_id, dat_letzte_nachversorgung, nachversorgung_schwellwert_pal_aufrundung_proz,
nachversorgung_schwellwert_pal_abrundung_proz, max_kapa_endbestand_proz, rest_von_normalbestand_proz) AS WITH
 ANGEBOT_ARTIKEL AS (SELECT AW.mandant_id,
   AGW.mandant_id AS mandant_id_vz,
    CASE
    WHEN LENGTH(CAST(ABS(AGW.gp_id) AS STRING)) <= 4
    THEN AGW.gp_id
    ELSE CAST(-9 AS BIGNUMERIC)
    END AS wup_id_vz,
    CASE
    WHEN AGW.auslieferungsgruppe_id = 'VEN'
    THEN A_GP.gp_id
    ELSE AGW.gp_id
    END AS gp_id,
   -111 AS nb_id_vz,
   AGW.auslieferungsgruppe_id AS ausliefergruppe_id,
   T.kjwo,
   WW.kjwo_ww,
   AW.angebot_nr AS angebot_id,
   A.aktion_id,
   A.angebot_typ_cd AS bonuskauf_promotionstyp,
   AW.art_id,
   A.dat_angebot_gueltig_von AS dat_von,
   A.dat_angebot_gueltig_bis AS dat_bis,
    DATE_DIFF(A.dat_angebot_gueltig_bis, A.dat_angebot_gueltig_von, DAY) + 1 AS anz_tage_werbung,
   COUNT(DISTINCT AW.wup_id) AS wup_count
  FROM kfl_production_dbp_view.v_angebot_art_wup_zu_1 AS AW
   INNER JOIN kfl_production_dbp_view.v_angebot_1 AS A ON AW.angebot_nr = A.angebot_nr AND AW.mandant_id = A.mandant_id
    AND A.angebot_geloescht_fg = 0
   INNER JOIN kfl_production_dbp_view.v_werbewoche_kl_1 AS WW ON A.mandant_id = WW.mandant_id AND A.dat_angebot_gueltig_von
      = WW.dat
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON A.dat_angebot_gueltig_von = T.dat
   INNER JOIN kfl_production_dbp_view.v_art_gp_wup_dts_zu_per_1 AS AGW ON CASE
         WHEN AW.mandant_id = 4
         THEN 7
         ELSE AW.mandant_id
         END = AGW.mandant_id AND AW.art_id = AGW.art_id AND AW.wup_id = AGW.wup_id AND AW.nb_id = COALESCE(AGW.nb_id, 0
       ) AND AGW.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS A_GP ON AW.art_id = A_GP.art_id AND AW.mandant_id = A_GP.mandant_id
         AND AW.wup_id = A_GP.wup_id AND AW.nb_id = A_GP.nb_id AND A_GP.dat_bis = DATE '9999-12-31'
  WHERE AGW.loesch_fg = 0
   AND EXISTS (SELECT 1
    FROM kfl_production_dbp_view.v_art_list_wup_zu_per_1 AS V02
    WHERE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN DATE_SUB(dat_von, INTERVAL 7 DAY) AND dat_bis
     AND AW.mandant_id = mandant_id
     AND AW.wup_id = wup_id
     AND AW.art_id = art_id)
   AND A.angebot_status_id IN (4, 6)
   AND A.transfer_status_id IN (0, 3, 5, 6)
   AND A.angebot_geloescht_fg IN (0)
   AND CASE
     WHEN AW.mandant_id = 7 AND A.angebot_typ_cd NOT IN ('ZAI', 'ZAIR', 'ZAIM') OR AW.mandant_id = 1 AND A.angebot_typ_cd
          NOT IN ('ZAI', 'ZAIR', 'ZAIM') OR A.angebot_typ_cd NOT IN ('0009', 'ZAI', 'ZAIR', 'ZAIM', '0010', 'ZB09',
        'ZB10')
     THEN 1
     ELSE 0
     END = 1
   AND AW.art_id NOT IN (0, -1)
  GROUP BY AW.mandant_id,
   mandant_id_vz,
   wup_id_vz,
   gp_id,
   nb_id_vz,
   ausliefergruppe_id,
   T.kjwo,
   WW.kjwo_ww,
   angebot_id,
   A.aktion_id,
   bonuskauf_promotionstyp,
   AW.art_id,
   dat_von,
   dat_bis,
   anz_tage_werbung), DAT_EINGREZUNG AS (SELECT mandant_id,
   art_id,
   dat_ab,
   dat_bis,
   MAX(dat_beladung) AS max_dat_beladung
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_1
  GROUP BY mandant_id,
   art_id,
   dat_ab,
   dat_bis) (SELECT v00.mandant_id,
   v00.ausliefergruppe_id,
   v00.kjwo,
   v00.kjwo_ww,
   COALESCE(CASE
     WHEN v00.angebot_id = ''
     THEN NULL
     ELSE v00.angebot_id
     END, 'n/a'),
   COALESCE(CASE
     WHEN v00.aktion_id = ''
     THEN NULL
     ELSE v00.aktion_id
     END, 'n/a'),
   v00.bonuskauf_promotionstyp,
   v00.dat_von,
   v00.dat_bis,
   v00.anz_tage_werbung,
   v00.art_id,
   COALESCE(v00.wup_id_vz, -9),
   v00.gp_id,
   v00.nb_id_vz,
   v00.mandant_id_vz,
   MAX(v00.wup_count) AS wup_count,
   COALESCE(CASE
     WHEN v01a.max_kapa_fg_markt >= 1
     THEN 1
     ELSE 0
     END, 0) AS max_kapa_fg_markt,
   MAX(COALESCE(V01.clear_stock_id, 0)) AS clear_stock_id,
   MAX(COALESCE(V10.clear_stock_bez, 'kein')) AS clear_stock_bez,
   MAX(COALESCE(COALESCE(COALESCE(COALESCE(V01.estimation_fg, v001.estimation_id), WG.estimation_fg), WG_STD.estimation_fg
      ), 0)) AS estimation_fg,
   MAX(COALESCE(V01.max_kapa_fg, 0)) AS max_kapa_fg,
   MAX(COALESCE(COALESCE(COALESCE(COALESCE(V01.adjustment_id, v001.adjustment_id), WG.adjustment_id), WG_STD.adjustment_id
      ), 0)) AS adjustment_id,
   MAX(V01.dat_letzte_nachversorgung) AS dat_letzte_nachversorgung,
   MAX(V01.nachversorgung_schwellwert_pal_aufrundung_proz) AS nachversorgung_schwellwert_pal_aufrundung_proz,
   MAX(V01.nachversorgung_schwellwert_pal_abrundung_proz) AS nachversorgung_schwellwert_pal_abrundung_proz,
   MAX(V01.max_kapa_endbestand_proz) AS max_kapa_endbestand_proz,
   MAX(V01.rest_von_normalbestand_proz) AS rest_von_normalbestand_pro
  FROM ANGEBOT_ARTIKEL AS v00
   LEFT JOIN (SELECT V001.mandant_id,
     V001.art_id,
     V001.dat_ab,
     V001.dat_bis,
     V001.ausliefergruppe_id,
      CASE
      WHEN V001.ausliefergruppe_id = 'VEN'
      THEN V001.gp_id
      ELSE V001.wup_id_vz
      END AS gp_id_,
     MAX(V001.estimation_id) AS estimation_id,
     MAX(V001.adjustment_id) AS adjustment_id
    FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_1 AS V001
     INNER JOIN DAT_EINGREZUNG AS v99 ON V001.mandant_id = v99.mandant_id AND V001.dat_beladung = v99.max_dat_beladung
        AND V001.art_id = v99.art_id AND V001.dat_ab = v99.dat_ab AND V001.dat_bis = v99.dat_bis
    GROUP BY V001.mandant_id,
     V001.art_id,
     V001.dat_ab,
     V001.dat_bis,
     V001.ausliefergruppe_id,
     gp_id_) AS v001 ON v00.mandant_id = v001.mandant_id AND v00.ausliefergruppe_id = v001.ausliefergruppe_id AND v00.dat_von
         = v001.dat_ab AND v00.dat_bis = v001.dat_bis AND v00.art_id = v001.art_id AND v00.gp_id = v001.gp_id_
   LEFT JOIN kfl_production_dbp_view.v_ts_wbs_artikel_vz_1 AS V01 ON v00.mandant_id = V01.mandant_id AND v00.ausliefergruppe_id
             = V01.ausliefergruppe_id AND v00.kjwo = V01.kjwo AND v00.angebot_id = V01.angebot_nr AND v00.art_id = V01.art_id
          AND v00.wup_id_vz = V01.wup_id_vz AND v00.nb_id_vz = V01.nb_id_vz AND v00.gp_id = V01.gp_id AND v00.mandant_id_vz
      = V01.mandant_id_vz
   INNER JOIN kfl_production_dbp_view.v_werbewoche_kl_1 AS WW0 ON v00.mandant_id = WW0.mandant_id AND v00.dat_von = WW0.dat
     
   LEFT JOIN kfl_production_dbp_view.v_l_clear_stock_1 AS V10 ON V01.clear_stock_id = V10.clear_stock_id AND V01.mandant_id
      = V10.mandant_id
   INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS WG_ZU ON v00.mandant_id = WG_ZU.mandant_id AND v00.art_id =
       WG_ZU.art_id AND WG_ZU.arthiertyp_id = 2 AND WG_ZU.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_warengruppe_1 AS WG ON WG_ZU.mandant_id = WG.mandant_id AND WG_ZU.wg_id =
      WG.wg_id AND v00.kjwo = WG.kjwo
   LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_warengruppe_standard_1 AS WG_STD ON WG_ZU.mandant_id = WG_STD.mandant_id
    AND WG_ZU.wg_id = WG_STD.wg_id
   LEFT JOIN (SELECT AM.mandant_id,
     AM.dat_von,
     AM.dat_bis,
     AM.angebot_nr,
     AM.aktion_id,
     AM.art_id,
      CASE
      WHEN SUM(CASE
           WHEN AM.max_kapa_fg <> COALESCE(A0.max_kapa_fg, 0)
           THEN 1
           ELSE 0
           END) + SUM(CASE
           WHEN AM.dat_letzte_nachversorgung <> A0.dat_letzte_nachversorgung
           THEN 1
           ELSE 0
           END) + SUM(CASE
          WHEN AM.adjustment_id <> COALESCE(A0.adjustment_id, 0)
          THEN 1
          ELSE 0
          END) = 0
      THEN 0
      ELSE 1
      END AS max_kapa_fg_markt
    FROM kfl_production_dbp_view.v_ts_wbs_art_aktion_markt_1 AS AM
     LEFT JOIN kfl_production_dbp_view.v_ts_wbs_artikel_vz_1 AS A0 ON AM.mandant_id = A0.mandant_id AND AM.angebot_nr = A0
         .angebot_nr AND AM.aktion_id = A0.aktion_id AND AM.art_id = A0.art_id
    GROUP BY AM.mandant_id,
     AM.dat_von,
     AM.dat_bis,
     AM.angebot_nr,
     AM.aktion_id,
     AM.art_id) AS v01a ON v00.mandant_id = v01a.mandant_id AND v00.dat_von = v01a.dat_von AND v00.dat_bis = v01a.dat_bis
         AND v00.angebot_id = v01a.angebot_nr AND v00.aktion_id = v01a.aktion_id AND v00.art_id = v01a.art_id
  GROUP BY v00.mandant_id,
   v00.ausliefergruppe_id,
   v00.kjwo,
   v00.kjwo_ww,
   v00.angebot_id,
   v00.aktion_id,
   v00.dat_von,
   v00.dat_bis,
   v00.anz_tage_werbung,
   v00.bonuskauf_promotionstyp,
   v00.art_id,
   v00.wup_id_vz,
   v00.gp_id,
   v00.nb_id_vz,
   v00.mandant_id_vz,
   v01a.max_kapa_fg_markt);