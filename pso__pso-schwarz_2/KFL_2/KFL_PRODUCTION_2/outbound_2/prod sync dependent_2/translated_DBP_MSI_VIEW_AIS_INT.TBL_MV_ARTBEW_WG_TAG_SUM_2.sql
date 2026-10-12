CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_int.tbl_mv_artbew_wg_tag_sum_2
 AS
WITH T_WUP_BEREINIGT AS (SELECT V010.dat,
   V020.mandant_id,
   V020.wup_id,
    CASE
    WHEN V010.kjwo_kl_dat_von > DATE_ADD(COALESCE(V020.dat_eroeffnung_alt, V020.dat_eroeffnung), INTERVAL 364 DAY) AND (V010
        .kjwo_kl_dat_bis < V020.dat_bis OR V020.wup_aenderung_grund_id IN (1, 2, 3, 4))
    THEN 1
    ELSE 0
    END AS wup_bereinigt_fg_akt,
    CASE
    WHEN V04.kjwo_kl_dat_von > DATE_ADD(COALESCE(V020.dat_eroeffnung_alt, V020.dat_eroeffnung), INTERVAL 364 DAY) AND (V04
        .kjwo_kl_dat_bis < V020.dat_bis OR V020.wup_aenderung_grund_id IN (1, 2, 3, 4))
    THEN 1
    ELSE 0
    END AS wup_bereinigt_fg_vj_wo,
    CASE
    WHEN CAST(V010.dat AS STRING) LIKE '%-02-29'
    THEN CASE
     WHEN V04.kjwo_kl_dat_von > DATE_ADD(COALESCE(V020.dat_eroeffnung_alt, V020.dat_eroeffnung), INTERVAL 364 DAY) AND (V04
         .kjwo_kl_dat_bis < V020.dat_bis OR V020.wup_aenderung_grund_id IN (1, 2, 3, 4))
     THEN 1
     ELSE 0
     END
    WHEN V03.kjwo_kl_dat_von > DATE_ADD(COALESCE(V020.dat_eroeffnung_alt, V020.dat_eroeffnung), INTERVAL 364 DAY) AND (V03
        .kjwo_kl_dat_bis < V020.dat_bis OR V020.wup_aenderung_grund_id IN (1, 2, 3, 4))
    THEN 1
    ELSE 0
    END AS wup_bereinigt_fg_vj
  FROM kfl_production_dbp_view.v_tag_2 AS V010
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS V020 ON V010.dat >= COALESCE(V020.dat_eroeffnung_alt, V020.dat_eroeffnung
     )
   LEFT JOIN kfl_production_dbp_view.v_tag_2 AS V03 ON V010.dat = V03.dat_vj_kt
   LEFT JOIN kfl_production_dbp_view.v_tag_2 AS V04 ON V010.dat = V04.dat_vj
  WHERE V010.dat BETWEEN DATE '2019-01-01' AND (DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY))
   AND (V020.nb_id = 0 AND V020.mandant_id <> 1 OR V020.mandant_id >= 2 AND V020.wup_id = 0)) (SELECT V01.dat,
   V02.wg_id,
   V02.arthiertyp_id,
   V01.mandant_id,
   V01.nb_id,
   V01.wup_id,
   CAST(0 AS INTEGER) AS bewart_id,
   CAST(0 AS INTEGER) AS bewart_det_id,
   v03.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
   v03.wup_bereinigt_fg_vj,
   v03.wup_bereinigt_fg_vj_wo,
   CAST('' AS STRING) AS posten_id,
   CAST('' AS STRING) AS posten_kz,
   CAST(0 AS NUMERIC) AS umsatz_mwst_betrag,
   CAST(0 AS NUMERIC) AS umsatz_netto,
   CAST(0 AS NUMERIC) AS vk_menge,
   CAST(0 AS NUMERIC) AS ek_brutto_absatz,
   CAST(0 AS NUMERIC) AS ek_netto_absatz,
   CAST(0 AS NUMERIC) AS ek_nettobnk_absatz,
   CAST(0 AS NUMERIC) AS ek_netto2_absatz,
   CAST(0 AS NUMERIC) AS ek_netto3_absatz,
   CAST(0 AS NUMERIC) AS ek_netto4_absatz,
   CAST(0 AS NUMERIC) AS ek_netto4_absatz_einstandspreis,
   CAST(0 AS NUMERIC) AS umsatz_mwst_betrag_af,
   CAST(0 AS NUMERIC) AS umsatz_netto_af,
   CAST(0 AS NUMERIC) AS vk_menge_af,
   CAST(0 AS NUMERIC) AS ek_brutto_absatz_af,
   CAST(0 AS NUMERIC) AS ek_netto_absatz_af,
   CAST(0 AS NUMERIC) AS ek_nettobnk_absatz_af,
   CAST(0 AS NUMERIC) AS ek_netto2_absatz_af,
   CAST(0 AS NUMERIC) AS ek_netto3_absatz_af,
   CAST(0 AS NUMERIC) AS ek_netto4_absatz_af,
   CAST(0 AS NUMERIC) AS ek_netto4_absatz_af_einstandspreis,
   CAST(0 AS NUMERIC) AS umsatz_mwst_betrag_sa,
   CAST(0 AS NUMERIC) AS umsatz_netto_sa,
   CAST(0 AS NUMERIC) AS vk_menge_sa,
   CAST(0 AS NUMERIC) AS ek_brutto_absatz_sa,
   CAST(0 AS NUMERIC) AS ek_netto_absatz_sa,
   CAST(0 AS NUMERIC) AS ek_nettobnk_absatz_sa,
   CAST(0 AS NUMERIC) AS ek_netto2_absatz_sa,
   CAST(0 AS NUMERIC) AS ek_netto3_absatz_sa,
   CAST(0 AS NUMERIC) AS ek_netto4_absatz_sa,
   CAST(0 AS NUMERIC) AS ek_netto4_absatz_sa_einstandspreis,
   CAST(0 AS NUMERIC) AS logkostenzuschlag,
   CAST(0 AS NUMERIC) AS umsatz_af_non_loyalty,
   CAST(0 AS NUMERIC) AS umsatz_af_loyalty,
   CAST(0 AS NUMERIC) AS umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
   CAST(0 AS NUMERIC) AS umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
   CAST(0 AS NUMERIC) AS umsatz_af_exkl_schwarz_media_u_bonrabatt_bby,
   CAST(0 AS NUMERIC) AS umsatz_af_loyalty_schwarz_media,
   CAST(0 AS NUMERIC) AS umsatz_sa_non_loyalty,
   CAST(0 AS NUMERIC) AS umsatz_sa_loyalty,
   CAST(0 AS NUMERIC) AS umsatz_bby_non_loyalty,
   CAST(0 AS NUMERIC) AS umsatz_bby_loyalty,
   CAST(0 AS NUMERIC) AS umsatz_kdn_bby_loyalty,
   CAST(0 AS NUMERIC) AS umsatz_kdp_bby_loyalty,
   CAST(0 AS NUMERIC) AS umsatz_bonrabatt_bby_non_loyalty,
   CAST(0 AS NUMERIC) AS umsatz_bonrabatt_bby_loyalty,
   CAST(0 AS NUMERIC) AS umsatz_bonrabatt_bby,
   CAST(0 AS NUMERIC) AS vk_menge_af_non_loyalty,
   CAST(0 AS NUMERIC) AS vk_menge_af_loyalty,
   CAST(0 AS NUMERIC) AS vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
   CAST(0 AS NUMERIC) AS vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
   CAST(0 AS NUMERIC) AS vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
   CAST(0 AS NUMERIC) AS vk_menge_af_loyalty_schwarz_media,
   CAST(0 AS NUMERIC) AS vk_menge_sa_non_loyalty,
   CAST(0 AS NUMERIC) AS vk_menge_sa_loyalty,
   CAST(0 AS NUMERIC) AS vk_menge_bby_non_loyalty,
   CAST(0 AS NUMERIC) AS vk_menge_bby_loyalty,
   CAST(0 AS NUMERIC) AS vk_menge_kdn_bby_loyalty,
   CAST(0 AS NUMERIC) AS vk_menge_kdp_bby_loyalty,
   CAST(0 AS NUMERIC) AS vk_menge_bonrabatt_bby_non_loyalty,
   CAST(0 AS NUMERIC) AS vk_menge_bonrabatt_bby_loyalty,
   CAST(0 AS NUMERIC) AS vk_menge_bonrabatt_bby,
   CAST(0 AS NUMERIC) AS ek_gld_absatz,
   CAST(0 AS NUMERIC) AS ek_gld_absatz_af,
   CAST(0 AS NUMERIC) AS ek_gld_absatz_sa,
   CAST(0 AS NUMERIC) AS ek_mepol,
   CAST(0 AS NUMERIC) AS ek_mepol_af,
   CAST(0 AS NUMERIC) AS ek_mepol_sa,
   CAST(0 AS NUMERIC) AS bonusbasis,
   CAST(0 AS NUMERIC) AS bonusbasis_af,
   CAST(0 AS NUMERIC) AS bonusbasis_sa,
   SUM(CASE
     WHEN V01.wv_grund_id = 2
     THEN V01.abschriftbetrag_netto
     ELSE 0
     END) AS pv_aktion_sa_loyalty,
   CAST(0 AS NUMERIC) AS pv_aktion_sa_loyalty_bby,
   CAST(0 AS NUMERIC) AS pv_aktion_sa_loyalty_kdn_bby,
   CAST(0 AS NUMERIC) AS pv_aktion_sa_loyalty_kdp_bby,
   SUM(CASE
     WHEN V01.wv_grund_id = 0
     THEN V01.abschriftbetrag_netto
     ELSE 0
     END) AS pv_aktion_sa_non_loyalty,
   CAST(0 AS NUMERIC) AS pv_aktion_sa_non_loyalty_bby,
   SUM(CASE
     WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54) OR V01.dat < DATE '2022-04-01' AND V01.wv_grund_id
         IN (52, 53, 54, 55)
     THEN V01.abschriftbetrag_netto
     ELSE 0
     END) AS pv_bby_loyalty,
   SUM(CASE
     WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58) OR V01.dat < DATE '2022-04-01' AND V01.wv_grund_id
         IN (56, 57, 58, 59)
     THEN V01.abschriftbetrag_netto
     ELSE 0
     END) AS pv_bby_non_loyalty,
   SUM(CASE
     WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62) OR V01.dat < DATE '2022-04-01' AND V01.wv_grund_id
         IN (60, 61, 62, 63)
     THEN V01.abschriftbetrag_netto
     ELSE 0
     END) AS pv_kdn_bby_loyalty,
   SUM(CASE
     WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 73, 74, 75) OR V01.dat < DATE '2022-04-01'
       AND V01.wv_grund_id IN (64, 65, 66, 67)
     THEN V01.abschriftbetrag_netto
     ELSE 0
     END) AS pv_kdp_bby_loyalty,
   SUM(CASE
     WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (59)
     THEN V01.abschriftbetrag_netto
     ELSE 0
     END) AS pv_bonrabatt_bby_non_loyalty,
   SUM(CASE
     WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (55, 63, 67, 76)
     THEN V01.abschriftbetrag_netto
     ELSE 0
     END) AS pv_bonrabatt_bby_loyalty,
    SUM(CASE
      WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (59)
      THEN V01.abschriftbetrag_netto
      ELSE 0
      END) + SUM(CASE
      WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (55, 63, 67, 76)
      THEN V01.abschriftbetrag_netto
      ELSE 0
      END) AS pv_bonrabatt_bby,
            SUM(CASE
              WHEN V01.wv_grund_id = 2
              THEN V01.abschriftbetrag_netto
              ELSE 0
              END) + 0 + 0 + 0 + SUM(CASE
           WHEN V01.wv_grund_id = 0
           THEN V01.abschriftbetrag_netto
           ELSE 0
           END) + SUM(CASE
          WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54) OR V01.dat < DATE '2022-04-01' AND V01.wv_grund_id
              IN (52, 53, 54, 55)
          THEN V01.abschriftbetrag_netto
          ELSE 0
          END) + SUM(CASE
         WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58) OR V01.dat < DATE '2022-04-01' AND V01.wv_grund_id
             IN (56, 57, 58, 59)
         THEN V01.abschriftbetrag_netto
         ELSE 0
         END) + SUM(CASE
        WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62) OR V01.dat < DATE '2022-04-01' AND V01.wv_grund_id
            IN (60, 61, 62, 63)
        THEN V01.abschriftbetrag_netto
        ELSE 0
        END) + SUM(CASE
       WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 73, 74, 75) OR V01.dat < DATE '2022-04-01'
         AND V01.wv_grund_id IN (64, 65, 66, 67)
       THEN V01.abschriftbetrag_netto
       ELSE 0
       END) + (SUM(CASE
        WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (59)
        THEN V01.abschriftbetrag_netto
        ELSE 0
        END) + SUM(CASE
        WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (55, 63, 67, 76)
        THEN V01.abschriftbetrag_netto
        ELSE 0
        END)) AS werbeabschrift_pv,
   SUM(CASE
     WHEN V01.wv_grund_id IN (48, 49)
     THEN V01.abschriftbetrag_netto
     ELSE NULL
     END) AS werbeabschrift_werbenachvermarktung_manuell,
   SUM(CASE
     WHEN V01.wv_grund_id IN (20, 21, 23, 50, 70)
     THEN V01.abschriftbetrag_netto
     ELSE NULL
     END) AS werbeabschrift_aktionsanpassung_filiale,
    SUM(V01.abschriftbetrag_netto) - (SUM(CASE
                  WHEN V01.wv_grund_id = 2
                  THEN V01.abschriftbetrag_netto
                  ELSE 0
                  END) + 0 + 0 + 0 + SUM(CASE
               WHEN V01.wv_grund_id = 0
               THEN V01.abschriftbetrag_netto
               ELSE 0
               END) + SUM(CASE
              WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54) OR V01.dat < DATE '2022-04-01' AND
                 V01.wv_grund_id IN (52, 53, 54, 55)
              THEN V01.abschriftbetrag_netto
              ELSE 0
              END) + SUM(CASE
             WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58) OR V01.dat < DATE '2022-04-01' AND
                V01.wv_grund_id IN (56, 57, 58, 59)
             THEN V01.abschriftbetrag_netto
             ELSE 0
             END) + SUM(CASE
            WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62) OR V01.dat < DATE '2022-04-01' AND V01
               .wv_grund_id IN (60, 61, 62, 63)
            THEN V01.abschriftbetrag_netto
            ELSE 0
            END) + SUM(CASE
           WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 73, 74, 75) OR V01.dat <
              DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 67)
           THEN V01.abschriftbetrag_netto
           ELSE 0
           END) + (SUM(CASE
            WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (59)
            THEN V01.abschriftbetrag_netto
            ELSE 0
            END) + SUM(CASE
            WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (55, 63, 67, 76)
            THEN V01.abschriftbetrag_netto
            ELSE 0
            END)) + SUM(CASE
         WHEN V01.wv_grund_id IN (48, 49)
         THEN V01.abschriftbetrag_netto
         ELSE NULL
         END) + SUM(CASE
        WHEN V01.wv_grund_id IN (20, 21, 23, 50, 70)
        THEN V01.abschriftbetrag_netto
        ELSE NULL
        END)) AS werbeabschrift_rest,
   CAST('' AS STRING) AS aktionsart_liste_id,
   MAX(CASE
     WHEN V01.wv_grund_id IN (60, 61, 62, 63) AND V01.abschriftart_id = -1
     THEN 'KDN'
     WHEN V01.wv_grund_id IN (64, 65, 66, 67) AND V01.abschriftart_id = -1
     THEN 'KDP'
     WHEN V01.wv_grund_id IN (73, 74, 75, 76) AND V01.abschriftart_id = -1
     THEN 'KDX'
     ELSE ''
     END) AS aktion_typ_liste_id
  FROM kfl_production_dbp_data.marktabschriften_2 AS V01
   INNER JOIN kfl_production_dbp_data.art_wg_zu_per_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id = V02.art_id
     
   LEFT JOIN T_WUP_BEREINIGT AS v03 ON V01.dat = v03.dat AND V01.mandant_id = v03.mandant_id AND V01.wup_id = v03.wup_id
     
  WHERE V01.mandant_id = 1
   AND V02.arthiertyp_id = 2
   AND V02.dat_bis = DATE '9999-12-31'
   AND V01.abschriftart_id = -1
  GROUP BY V01.dat,
   V02.wg_id,
   V02.arthiertyp_id,
   V01.mandant_id,
   V01.nb_id,
   V01.wup_id,
   wup_bereinigt_fg,
   v03.wup_bereinigt_fg_vj,
   v03.wup_bereinigt_fg_vj_wo);
/*  */