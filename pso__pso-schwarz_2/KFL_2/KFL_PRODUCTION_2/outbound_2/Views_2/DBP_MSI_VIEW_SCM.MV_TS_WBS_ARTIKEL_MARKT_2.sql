CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_wbs_artikel_markt_2 (mandant_id, wup_id, nb_id,
ausliefergruppe_id, kjwo, kjwo_ww, angebot_id, aktion_id, bonuskauf_promotionstyp, dat_ab, dat_bis, anz_tage_werbung,
art_id, wup_id_vz, gp_id, nb_id_vz, mandant_id_vz, gk_fg, top_gk_fg, max_kapa_fg, fixmenge_wfl_bme,
faktor_rest_von_normalbestand, faktor_max_kapa_endbestand, menge_mindestplatzierung_bme, adjustment_id,
dat_letzte_nachversorgung, nachversorgung_schwellwert_pal_abrundung_proz, nachversorgung_schwellwert_pal_aufrundung_proz
) AS WITH ANGEBOT_ARTIKEL AS (SELECT DISTINCT AW.mandant_id,
   AW.wup_id,
   AW.nb_id,
   AGW.mandant_id AS mandant_id_vz,
    CASE
    WHEN LENGTH(CAST(ABS(AGW.gp_id) AS STRING)) <= 4
    THEN AGW.gp_id
    ELSE -9
    END AS wup_id_vz,
    CASE
    WHEN AGW.auslieferungsgruppe_id = 'VEN'
    THEN A_GP.gp_id
    ELSE AGW.gp_id
    END AS gp_id,
   -111 AS nb_id_vz,
    CASE
    WHEN A_GP.bezugsweg_id = 1
    THEN 'VEN'
    ELSE COALESCE(AUS_ART.auslieferungsgruppe_id, COALESCE(AUS_WG_1.auslieferungsgruppe_id, AUS_WG_2.auslieferungsgruppe_id
      ))
    END AS ausliefergruppe_id,
   T.kjwo,
   WW.kjwo_ww,
   AW.angebot_nr AS angebot_id,
   A.aktion_id,
   A.angebot_typ_cd AS bonuskauf_promotionstyp,
   AW.art_id,
   A.dat_angebot_gueltig_von AS dat_von,
   A.dat_angebot_gueltig_bis AS dat_bis,
    DATE_DIFF(A.dat_angebot_gueltig_bis, A.dat_angebot_gueltig_von, DAY) + 1 AS anz_tage_werbung,
   AA.gondelkopf_fg AS gk_fg,
   AA.topartikel_fg AS top_gk_fg,
   AA.mindestmenge_bme AS menge_mindestplatzierung_bme
  FROM kfl_production_dbp_view.v_angebot_art_wup_zu_2 AS AW
   INNER JOIN kfl_production_dbp_view.v_angebot_2 AS A ON AW.angebot_nr = A.angebot_nr AND AW.mandant_id = A.mandant_id
    AND A.angebot_geloescht_fg = 0
   INNER JOIN kfl_production_dbp_view.v_werbewoche_kl_2 AS WW ON A.mandant_id = WW.mandant_id AND A.dat_angebot_gueltig_von
      = WW.dat
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS T ON A.dat_angebot_gueltig_von = T.dat
   INNER JOIN kfl_production_dbp_view.v_art_gp_wup_dts_zu_per_2 AS AGW ON CASE
         WHEN AW.mandant_id = 4
         THEN 7
         ELSE AW.mandant_id
         END = AGW.mandant_id AND AW.art_id = AGW.art_id AND AW.wup_id = AGW.wup_id AND AW.nb_id = COALESCE(AGW.nb_id, 0
       ) AND AGW.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_2 AS AV_P ON AW.art_id = AV_P.art_id AND AW.mandant_id =
      AV_P.mandant_id AND AV_P.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_2 AS A_GP ON AW.art_id = A_GP.art_id AND AW.mandant_id = A_GP.mandant_id
         AND AW.wup_id = A_GP.wup_id AND AW.nb_id = A_GP.nb_id AND A_GP.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS A_WG ON AW.art_id = A_WG.art_id AND AW.mandant_id = A_WG.mandant_id
        AND A_WG.dat_bis = DATE '9999-12-31' AND A_WG.arthiertyp_id = 2
   LEFT JOIN kfl_production_dbp_view.v_wg_auslieferungsgruppe_per_2 AS AUS_WG_1 ON A_WG.wg_id = AUS_WG_1.wg_id AND A_WG.mandant_id
        = AUS_WG_1.mandant_id AND AUS_WG_1.dat_bis = DATE '9999-12-31' AND AV_P.sortimentslistenart_id = AUS_WG_1.sortimentslistenart_id
     
   LEFT JOIN kfl_production_dbp_view.v_wg_auslieferungsgruppe_per_2 AS AUS_WG_2 ON A_WG.wg_id = AUS_WG_2.wg_id AND A_WG.mandant_id
        = AUS_WG_2.mandant_id AND AUS_WG_2.dat_bis = DATE '9999-12-31' AND AUS_WG_2.sortimentslistenart_id = ''
   LEFT JOIN kfl_production_dbp_view.v_art_auslieferungsgruppe_per_2 AS AUS_ART ON AW.art_id = AUS_ART.art_id AND AW.mandant_id
       = AUS_ART.mandant_id AND AUS_ART.dat_bis = DATE '9999-12-31'
   LEFT JOIN (SELECT mandant_id,
     angebot_nr,
     MAX(CASE
       WHEN angebot_attribut_id = 42
       THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
       ELSE NULL
       END) AS mindestmenge_bme,
     MAX(CASE
       WHEN angebot_attribut_id = 49
       THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
       ELSE NULL
       END) AS gondelkopf_fg,
     MAX(CASE
       WHEN angebot_attribut_id = 46
       THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
       ELSE NULL
       END) AS topartikel_fg
    FROM kfl_production_dbp_view.v_angebot_attribut_zu_2
    WHERE angebot_attribut_id BETWEEN 40 AND 53
    GROUP BY mandant_id,
     angebot_nr) AS AA ON AW.angebot_nr = AA.angebot_nr AND AW.mandant_id = AA.mandant_id
  WHERE AGW.loesch_fg = 0
   AND EXISTS (SELECT 1
    FROM kfl_production_dbp_view.v_art_list_wup_zu_per_2 AS V02
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
   AND AW.art_id NOT IN (0, -1)), DAT_EINGREZUNG AS (SELECT mandant_id,
   art_id,
   dat_ab,
   dat_bis,
   MAX(dat_beladung) AS max_dat_beladung
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_2
  GROUP BY mandant_id,
   art_id,
   dat_ab,
   dat_bis) (SELECT v00.mandant_id,
   v00.wup_id,
   v00.nb_id,
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
   v00.wup_id_vz,
   v00.gp_id,
   v00.nb_id_vz,
   v00.mandant_id_vz,
   v00.gk_fg,
   v00.top_gk_fg,
   MAX(COALESCE(COALESCE(V01.max_kapa_fg, V020.max_kapa_fg), 0)) AS max_kapa_fg,
   MAX(V01.fixmenge_wfl_bme) AS fixmenge_wfl_bme,
   MAX(V01.rest_von_normalbestand_proz) AS faktor_rest_von_normalbestand,
   MAX(V01.max_kapa_endbestand_proz) AS faktor_max_kapa_endbestand,
   MAX(V01.menge_mindestplatzierung_bme) AS menge_mindestplatzierung_bme,
   MAX(COALESCE(COALESCE(COALESCE(COALESCE(COALESCE(COALESCE(COALESCE(V01.adjustment_id, V020.adjustment_id), v001.adjustment_id
          ), WG.adjustment_id), WG_ST.adjustment_id), WG_STD.adjustment_id), WG_STD_ST.adjustment_id), 0)) AS
   adjustment_id,
   MAX(COALESCE(V01.dat_letzte_nachversorgung, V020.dat_letzte_nachversorgung)) AS dat_letzte_nachversorgung,
   MAX(COALESCE(V01.nachversorgung_schwellwert_pal_abrundung_proz, V020.nachversorgung_schwellwert_pal_abrundung_proz))
   AS nachversorgung_schwellwert_pal_abrundung_proz,
   MAX(COALESCE(V01.nachversorgung_schwellwert_pal_aufrundung_proz, V020.nachversorgung_schwellwert_pal_aufrundung_proz
     )) AS nachversorgung_schwellwert_pal_aufrundung_proz
  FROM ANGEBOT_ARTIKEL AS v00
   LEFT JOIN (SELECT t12.mandant_id,
     t12.art_id,
     t12.dat_ab,
     t12.dat_bis,
     t12.aktion_id,
     t12.ausliefergruppe_id,
     t12.gp_id_,
     t12.b7,
     t12.estimation_id,
     t12.adjustment_id
    FROM (SELECT V001.mandant_id,
       V001.art_id,
       V001.dat_ab,
       V001.dat_bis,
       V001.aktion_id,
       V001.ausliefergruppe_id,
        CASE
        WHEN V001.ausliefergruppe_id = 'VEN'
        THEN V001.gp_id
        ELSE V001.wup_id_vz
        END AS gp_id_,
       CAST(V001.offer_id AS STRING) AS b7,
       MAX(V001.estimation_id) AS estimation_id,
       MAX(V001.adjustment_id) AS adjustment_id
      FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_2 AS V001
       INNER JOIN DAT_EINGREZUNG AS v99 ON V001.mandant_id = v99.mandant_id AND V001.dat_beladung = v99.max_dat_beladung
             AND V001.art_id = v99.art_id AND V001.dat_ab = v99.dat_ab AND V001.dat_bis = v99.dat_bis
      GROUP BY V001.mandant_id,
       V001.art_id,
       V001.dat_ab,
       V001.dat_bis,
       V001.aktion_id,
       V001.ausliefergruppe_id,
       gp_id_,
       b7) AS t12) AS v001 ON v00.mandant_id = v001.mandant_id AND v00.ausliefergruppe_id = v001.ausliefergruppe_id AND
        v00.dat_von = v001.dat_ab AND v00.dat_bis = v001.dat_bis AND v00.art_id = v001.art_id AND v00.gp_id = v001.gp_id_
     
   LEFT JOIN kfl_production_dbp_data.ts_wbs_art_aktion_markt_2 AS V01 ON v00.mandant_id = V01.mandant_id AND v00.dat_von =
          V01.dat_von AND v00.dat_bis = V01.dat_bis AND v00.angebot_id = V01.angebot_nr AND v00.art_id = V01.art_id AND
      v00.wup_id = V01.wup_id AND v00.nb_id = V01.nb_id
   LEFT JOIN kfl_production_dbp_data.ts_wbs_artikel_vz_2 AS V020 ON v00.mandant_id_vz = V020.mandant_id_vz AND v00.kjwo =
       V020.kjwo AND v00.angebot_id = V020.angebot_nr AND v00.art_id = V020.art_id
   INNER JOIN kfl_production_dbp_view.v_werbewoche_kl_2 AS WW0 ON v00.mandant_id = WW0.mandant_id AND v00.dat_von = WW0.dat
     
   INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS WG_ZU ON v00.mandant_id = WG_ZU.mandant_id AND v00.art_id =
       WG_ZU.art_id AND WG_ZU.arthiertyp_id = 2 AND WG_ZU.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_warengruppe_2 AS WG ON WG_ZU.mandant_id = WG.mandant_id AND WG_ZU.wg_id =
       WG.wg_id AND v00.kjwo = WG.kjwo AND v00.bonuskauf_promotionstyp = WG.bonuskauf_promotionstyp
   LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_warengruppe_standard_2 AS WG_STD ON WG_ZU.mandant_id = WG_STD.mandant_id
     AND WG_ZU.wg_id = WG_STD.wg_id AND v00.bonuskauf_promotionstyp = WG_STD.bonuskauf_promotionstyp
   LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_warengruppe_2 AS WG_ST ON WG_ZU.mandant_id = WG_ST.mandant_id AND WG_ZU.wg_id
        = WG_ST.wg_id AND v00.kjwo = WG_ST.kjwo AND WG_ST.bonuskauf_promotionstyp = '-1'
   LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_warengruppe_standard_2 AS WG_STD_ST ON WG_ZU.mandant_id = WG_STD_ST.mandant_id
       AND WG_ZU.wg_id = WG_STD_ST.wg_id AND WG_STD_ST.bonuskauf_promotionstyp = '-1'
  GROUP BY v00.mandant_id,
   v00.wup_id,
   v00.nb_id,
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
   v00.gk_fg,
   v00.top_gk_fg);