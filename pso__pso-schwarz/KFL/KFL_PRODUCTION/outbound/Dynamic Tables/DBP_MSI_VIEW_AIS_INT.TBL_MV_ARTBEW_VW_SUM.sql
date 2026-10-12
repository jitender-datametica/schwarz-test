CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.tbl_mv_artbew_vw_sum
OPTIONS(max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT V01.dat,
 V01.art_id,
 V01.mandant_id,
 COALESCE(v02.gp_id, -1) AS gp_id,
 CAST(0 AS BIGNUMERIC) AS herst_id,
 V03.vw_id,
 CAST(0 AS BIGNUMERIC) AS bewart_id,
 CAST(0 AS BIGNUMERIC) AS bezugsweg_id,
 CAST(0 AS BIGNUMERIC) AS ean_kasse,
 CAST(0 AS BIGNUMERIC) AS umsatz_mwst_betrag,
 CAST(0 AS BIGNUMERIC) AS umsatz_netto,
 CAST(0 AS BIGNUMERIC) AS vk_menge,
 CAST(0 AS BIGNUMERIC) AS vk_menge_norm,
 CAST(0 AS BIGNUMERIC) AS ek_netto2_absatz,
 CAST(0 AS BIGNUMERIC) AS ek_netto3_absatz,
 CAST(0 AS BIGNUMERIC) AS ek_netto4_absatz,
 CAST(0 AS BIGNUMERIC) AS umsatz_mwst_betrag_af,
 CAST(0 AS BIGNUMERIC) AS umsatz_netto_af,
 CAST(0 AS BIGNUMERIC) AS vk_menge_af,
 CAST(0 AS BIGNUMERIC) AS vk_menge_af_norm,
 CAST(0 AS BIGNUMERIC) AS ek_netto2_absatz_af,
 CAST(0 AS BIGNUMERIC) AS ek_netto3_absatz_af,
 CAST(0 AS BIGNUMERIC) AS ek_netto4_absatz_af,
 CAST(0 AS BIGNUMERIC) AS umsatz_mwst_betrag_sa,
 CAST(0 AS BIGNUMERIC) AS umsatz_netto_sa,
 CAST(0 AS BIGNUMERIC) AS vk_menge_sa,
 CAST(0 AS BIGNUMERIC) AS vk_menge_sa_norm,
 CAST(0 AS BIGNUMERIC) AS ek_netto2_absatz_sa,
 CAST(0 AS BIGNUMERIC) AS ek_netto3_absatz_sa,
 CAST(0 AS BIGNUMERIC) AS ek_netto4_absatz_sa,
 CAST(0 AS BIGNUMERIC) AS ek_brutto_absatz,
 CAST(0 AS BIGNUMERIC) AS ek_brutto_absatz_af,
 CAST(0 AS BIGNUMERIC) AS ek_brutto_absatz_sa,
 CAST(0 AS BIGNUMERIC) AS ek_gld_absatz,
 CAST(0 AS BIGNUMERIC) AS ek_gld_absatz_af,
 CAST(0 AS BIGNUMERIC) AS ek_gld_absatz_sa,
 CAST(0 AS BIGNUMERIC) AS ek_nettobnk_absatz,
 CAST(0 AS BIGNUMERIC) AS ek_nettobnk_absatz_af,
 CAST(0 AS BIGNUMERIC) AS ek_nettobnk_absatz_sa,
 CAST(0 AS BIGNUMERIC) AS ek_netto_absatz,
 CAST(0 AS BIGNUMERIC) AS ek_netto_absatz_af,
 CAST(0 AS BIGNUMERIC) AS ek_netto_absatz_sa,
 CAST(0 AS BIGNUMERIC) AS logkostenzuschlag,
 CAST(0 AS BIGNUMERIC) AS ek_mepol,
 CAST(0 AS BIGNUMERIC) AS ek_mepol_af,
 CAST(0 AS BIGNUMERIC) AS ek_mepol_sa,
 CAST(0 AS BIGNUMERIC) AS bonusbasis,
 CAST(0 AS BIGNUMERIC) AS bonusbasis_af,
 CAST(0 AS BIGNUMERIC) AS bonusbasis_sa,
 SUM(CASE
   WHEN V01.wv_grund_id = 2
   THEN V01.abschriftbetrag_netto
   ELSE 0
   END) AS pv_aktion_sa_loyalty,
 CAST(0 AS BIGNUMERIC) AS pv_aktion_sa_loyalty_bby,
 CAST(0 AS BIGNUMERIC) AS pv_aktion_sa_loyalty_kdn_bby,
 CAST(0 AS BIGNUMERIC) AS pv_aktion_sa_loyalty_kdp_bby,
 SUM(CASE
   WHEN V01.wv_grund_id = 0
   THEN V01.abschriftbetrag_netto
   ELSE 0
   END) AS pv_aktion_sa_non_loyalty,
 CAST(0 AS BIGNUMERIC) AS pv_aktion_sa_non_loyalty_bby,
 SUM(CASE
   WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54) OR V01.wv_grund_id IN (52, 53, 54, 55)
   THEN V01.abschriftbetrag_netto
   ELSE 0
   END) AS pv_bby_loyalty,
 SUM(CASE
   WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58) OR V01.wv_grund_id IN (56, 57, 58, 59)
   THEN V01.abschriftbetrag_netto
   ELSE 0
   END) AS pv_bby_non_loyalty,
 SUM(CASE
   WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62) OR V01.wv_grund_id IN (60, 61, 62, 63)
   THEN V01.abschriftbetrag_netto
   ELSE 0
   END) AS pv_kdn_bby_loyalty,
 SUM(CASE
   WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 73, 74, 75) OR V01.wv_grund_id IN (64, 65, 66,
      67)
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
        WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54) OR V01.wv_grund_id IN (52, 53, 54, 55)
        THEN V01.abschriftbetrag_netto
        ELSE 0
        END) + SUM(CASE
       WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58) OR V01.wv_grund_id IN (56, 57, 58, 59)
       THEN V01.abschriftbetrag_netto
       ELSE 0
       END) + SUM(CASE
      WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62) OR V01.wv_grund_id IN (60, 61, 62, 63)
      THEN V01.abschriftbetrag_netto
      ELSE 0
      END) + SUM(CASE
     WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 73, 74, 75) OR V01.wv_grund_id IN (64, 65, 66
        , 67)
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
            WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54) OR V01.wv_grund_id IN (52, 53, 54, 55
               )
            THEN V01.abschriftbetrag_netto
            ELSE 0
            END) + SUM(CASE
           WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58) OR V01.wv_grund_id IN (56, 57, 58, 59)
           THEN V01.abschriftbetrag_netto
           ELSE 0
           END) + SUM(CASE
          WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62) OR V01.wv_grund_id IN (60, 61, 62, 63)
          THEN V01.abschriftbetrag_netto
          ELSE 0
          END) + SUM(CASE
         WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 73, 74, 75) OR V01.wv_grund_id IN (64, 65
            , 66, 67)
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
      END)) AS werbeabschrift_rest
FROM kfl_production_dbp_data.marktabschriften AS V01
 LEFT JOIN (SELECT art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis
  FROM kfl_production_dbp_data.art_gp_nm_zu_per
  WHERE mandant_id = 1) AS v02 ON V01.art_id = v02.art_id AND V01.wup_id = v02.wup_id AND V01.dat BETWEEN v02.dat_von
   AND v02.dat_bis
 INNER JOIN kfl_production_dbp_data.wup AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wup_id = V03.wup_id AND V01.nb_id
    = V03.nb_id
WHERE V01.mandant_id = 1
 AND V01.abschriftart_id = -1
GROUP BY V01.dat,
 V01.art_id,
 V01.mandant_id,
 v02.gp_id,
 V03.vw_id;
