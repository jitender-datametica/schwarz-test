
CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.tbl_mv_artbew_mo_sum_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT V04.kjmo,
 V01.art_id,
 V01.mandant_id,
 COALESCE(v02.gp_id, -1) AS gp_id,
 V01.nb_id,
 V01.wup_id,
 CAST(0 AS INTEGER) AS bewart_id,
 CAST(0 AS INTEGER) AS bewart_det_id,
 CAST('' AS STRING) AS posten_id_per,
 CAST('' AS STRING) AS posten_kz_per,
 CAST(0 AS INTEGER) AS umsatz_mwst_betrag,
 CAST(0 AS INTEGER) AS umsatz_netto,
 CAST(0 AS INTEGER) AS vk_menge,
 CAST(0 AS INTEGER) AS vk_menge_norm,
 CAST(0 AS INTEGER) AS ek_brutto_absatz,
 CAST(0 AS INTEGER) AS ek_netto_absatz,
 CAST(0 AS INTEGER) AS ek_nettobnk_absatz,
 CAST(0 AS INTEGER) AS ek_netto2_absatz,
 CAST(0 AS INTEGER) AS ek_netto3_absatz,
 CAST(0 AS INTEGER) AS ek_netto4_absatz,
 CAST(0 AS INTEGER) AS ek_netto4_absatz_einstandspreis,
 CAST(0 AS INTEGER) AS umsatz_mwst_betrag_af,
 CAST(0 AS INTEGER) AS umsatz_netto_af,
 CAST(0 AS INTEGER) AS vk_menge_af,
 CAST(0 AS INTEGER) AS vk_menge_af_norm,
 CAST(0 AS INTEGER) AS ek_brutto_absatz_af,
 CAST(0 AS INTEGER) AS ek_netto_absatz_af,
 CAST(0 AS INTEGER) AS ek_nettobnk_absatz_af,
 CAST(0 AS INTEGER) AS ek_netto2_absatz_af,
 CAST(0 AS INTEGER) AS ek_netto3_absatz_af,
 CAST(0 AS INTEGER) AS ek_netto4_absatz_af,
 CAST(0 AS INTEGER) AS ek_netto4_absatz_af_einstandspreis,
 CAST(0 AS INTEGER) AS umsatz_mwst_betrag_sa,
 CAST(0 AS INTEGER) AS umsatz_netto_sa,
 CAST(0 AS INTEGER) AS vk_menge_sa,
 CAST(0 AS INTEGER) AS vk_menge_sa_norm,
 CAST(0 AS INTEGER) AS ek_brutto_absatz_sa,
 CAST(0 AS INTEGER) AS ek_netto_absatz_sa,
 CAST(0 AS INTEGER) AS ek_nettobnk_absatz_sa,
 CAST(0 AS INTEGER) AS ek_netto2_absatz_sa,
 CAST(0 AS INTEGER) AS ek_netto3_absatz_sa,
 CAST(0 AS INTEGER) AS ek_netto4_absatz_sa,
 CAST(0 AS INTEGER) AS ek_netto4_absatz_sa_einstandspreis,
 CAST(0 AS INTEGER) AS logkostenzuschlag,
 CAST(0 AS INTEGER) AS umsatz_af_non_loyalty,
 CAST(0 AS INTEGER) AS umsatz_af_loyalty,
 CAST(0 AS INTEGER) AS umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
 CAST(0 AS INTEGER) AS umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
 CAST(0 AS INTEGER) AS umsatz_af_exkl_schwarz_media_u_bonrabatt_bby,
 CAST(0 AS INTEGER) AS umsatz_af_loyalty_schwarz_media,
 CAST(0 AS INTEGER) AS umsatz_sa_non_loyalty,
 CAST(0 AS INTEGER) AS umsatz_sa_loyalty,
 CAST(0 AS INTEGER) AS umsatz_bby_non_loyalty,
 CAST(0 AS INTEGER) AS umsatz_bby_loyalty,
 CAST(0 AS INTEGER) AS umsatz_kdn_bby_loyalty,
 CAST(0 AS INTEGER) AS umsatz_kdp_bby_loyalty,
 CAST(0 AS INTEGER) AS umsatz_bonrabatt_bby_non_loyalty,
 CAST(0 AS INTEGER) AS umsatz_bonrabatt_bby_loyalty,
 CAST(0 AS INTEGER) AS umsatz_bonrabatt_bby,
 CAST(0 AS INTEGER) AS vk_menge_af_non_loyalty,
 CAST(0 AS INTEGER) AS vk_menge_af_loyalty,
 CAST(0 AS INTEGER) AS vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
 CAST(0 AS INTEGER) AS vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
 CAST(0 AS INTEGER) AS vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
 CAST(0 AS INTEGER) AS vk_menge_af_loyalty_schwarz_media,
 CAST(0 AS INTEGER) AS vk_menge_sa_non_loyalty,
 CAST(0 AS INTEGER) AS vk_menge_sa_loyalty,
 CAST(0 AS INTEGER) AS vk_menge_bby_non_loyalty,
 CAST(0 AS INTEGER) AS vk_menge_bby_loyalty,
 CAST(0 AS INTEGER) AS vk_menge_kdn_bby_loyalty,
 CAST(0 AS INTEGER) AS vk_menge_kdp_bby_loyalty,
 CAST(0 AS INTEGER) AS vk_menge_bonrabatt_bby_non_loyalty,
 CAST(0 AS INTEGER) AS vk_menge_bonrabatt_bby_loyalty,
 CAST(0 AS INTEGER) AS vk_menge_bonrabatt_bby,
 CAST(0 AS INTEGER) AS ek_gld_absatz,
 CAST(0 AS INTEGER) AS ek_gld_absatz_af,
 CAST(0 AS INTEGER) AS ek_gld_absatz_sa,
 CAST(0 AS INTEGER) AS ek_mepol,
 CAST(0 AS INTEGER) AS ek_mepol_af,
 CAST(0 AS INTEGER) AS ek_mepol_sa,
 CAST(0 AS INTEGER) AS bonusbasis,
 CAST(0 AS INTEGER) AS bonusbasis_af,
 CAST(0 AS INTEGER) AS bonusbasis_sa,
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
   WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 73, 74, 75) OR V01.dat < DATE '2022-04-01' AND
      V01.wv_grund_id IN (64, 65, 66, 67)
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
            WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54) OR V01.dat < DATE '2022-04-01' AND V01
               .wv_grund_id IN (52, 53, 54, 55)
            THEN V01.abschriftbetrag_netto
            ELSE 0
            END) + SUM(CASE
           WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58) OR V01.dat < DATE '2022-04-01' AND V01
              .wv_grund_id IN (56, 57, 58, 59)
           THEN V01.abschriftbetrag_netto
           ELSE 0
           END) + SUM(CASE
          WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62) OR V01.dat < DATE '2022-04-01' AND V01.wv_grund_id
              IN (60, 61, 62, 63)
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
FROM dbp_data.marktabschriften_1 AS V01
 LEFT JOIN (SELECT art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis
  FROM dbp_data.art_gp_nm_zu_per_1
  WHERE mandant_id = 1) AS v02 ON V01.art_id = v02.art_id AND V01.wup_id = v02.wup_id AND V01.dat BETWEEN v02.dat_von
   AND v02.dat_bis
 INNER JOIN dbp_data.tag_1 AS V04 ON V01.dat = V04.dat
WHERE V01.mandant_id = 1
 AND V01.abschriftart_id = -1
GROUP BY V04.kjmo,
 V01.art_id,
 V01.mandant_id,
 v02.gp_id,
 V01.nb_id,
 V01.wup_id;


