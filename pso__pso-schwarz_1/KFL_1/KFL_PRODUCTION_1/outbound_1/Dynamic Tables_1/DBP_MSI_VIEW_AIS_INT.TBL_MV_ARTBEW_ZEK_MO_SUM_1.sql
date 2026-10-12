CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.tbl_mv_artbew_zek_mo_sum_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v03.kjmo AS kjmo,
  v02.zek_id AS zek_id,
  v01.mandant_id AS mandant_id,
  v01.nb_id AS nb_id,
  v01.wup_id AS wup_id,
  0 AS bewart_id,
  0 AS bewart_det_id,
  '' AS posten_id_per,
  '' AS posten_kz_per,
  0 AS umsatz_mwst_betrag,
  0 AS umsatz_netto,
  0 AS vk_menge,
  0 AS ek_brutto_absatz,
  0 AS ek_netto_absatz,
  0 AS ek_nettobnk_absatz,
  0 AS ek_netto2_absatz,
  0 AS ek_netto3_absatz,
  0 AS ek_netto4_absatz,
  0 AS ek_netto4_absatz_einstandspreis,
  0 AS umsatz_mwst_betrag_af,
  0 AS umsatz_netto_af,
  0 AS vk_menge_af,
  0 AS ek_brutto_absatz_af,
  0 AS ek_netto_absatz_af,
  0 AS ek_nettobnk_absatz_af,
  0 AS ek_netto2_absatz_af,
  0 AS ek_netto3_absatz_af,
  0 AS ek_netto4_absatz_af,
  0 AS ek_netto4_absatz_af_einstandspreis,
  0 AS umsatz_mwst_betrag_sa,
  0 AS umsatz_netto_sa,
  0 AS vk_menge_sa,
  0 AS ek_brutto_absatz_sa,
  0 AS ek_netto_absatz_sa,
  0 AS ek_nettobnk_absatz_sa,
  0 AS ek_netto2_absatz_sa,
  0 AS ek_netto3_absatz_sa,
  0 AS ek_netto4_absatz_sa,
  0 AS ek_netto4_absatz_sa_einstandspreis,
  0 AS logkostenzuschlag,
  0 AS umsatz_af_non_loyalty,
  0 AS umsatz_af_loyalty,
  0 AS umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
  0 AS umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
  0 AS umsatz_af_exkl_schwarz_media_u_bonrabatt_bby,
  0 AS umsatz_af_loyalty_schwarz_media,
  0 AS umsatz_sa_non_loyalty,
  0 AS umsatz_sa_loyalty,
  0 AS umsatz_bby_non_loyalty,
  0 AS umsatz_bby_loyalty,
  0 AS umsatz_kdn_bby_loyalty,
  0 AS umsatz_kdp_bby_loyalty,
  0 AS umsatz_bonrabatt_bby_non_loyalty,
  0 AS umsatz_bonrabatt_bby_loyalty,
  0 AS umsatz_bonrabatt_bby,
  0 AS vk_menge_af_non_loyalty,
  0 AS vk_menge_af_loyalty,
  0 AS vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
  0 AS vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
  0 AS vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
  0 AS vk_menge_af_loyalty_schwarz_media,
  0 AS vk_menge_sa_non_loyalty,
  0 AS vk_menge_sa_loyalty,
  0 AS vk_menge_bby_non_loyalty,
  0 AS vk_menge_bby_loyalty,
  0 AS vk_menge_kdn_bby_loyalty,
  0 AS vk_menge_kdp_bby_loyalty,
  0 AS vk_menge_bonrabatt_bby_non_loyalty,
  0 AS vk_menge_bonrabatt_bby_loyalty,
  0 AS vk_menge_bonrabatt_bby,
  0 AS ek_gld_absatz,
  0 AS ek_gld_absatz_af,
  0 AS ek_gld_absatz_sa,
  0 AS ek_mepol,
  0 AS ek_mepol_af,
  0 AS ek_mepol_sa,
  0 AS bonusbasis,
  0 AS bonusbasis_af,
  0 AS bonusbasis_sa,
  SUM(CASE WHEN v01.wv_grund_id = 2 THEN v01.abschriftbetrag_netto ELSE 0 END) AS pv_aktion_sa_loyalty,
  0 AS pv_aktion_sa_loyalty_bby,
  0 AS pv_aktion_sa_loyalty_kdn_bby,
  0 AS pv_aktion_sa_loyalty_kdp_bby,
  SUM(CASE WHEN v01.wv_grund_id = 0 THEN v01.abschriftbetrag_netto ELSE 0 END) AS pv_aktion_sa_non_loyalty,
  0 AS pv_aktion_sa_non_loyalty_bby,
  SUM(
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54, 55)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END
  ) AS pv_bby_loyalty,
  SUM(
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54, 55)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END
  ) AS pv_bby_non_loyalty,
  SUM(
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54, 55)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END
  ) AS pv_kdn_bby_loyalty,
  SUM(
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54, 55)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END
  ) AS pv_kdp_bby_loyalty,
  SUM(
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (59)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END
  ) AS pv_bonrabatt_bby_non_loyalty,
  SUM(
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (59)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END
  ) AS pv_bonrabatt_bby_loyalty,
  SUM(
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (59)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END
  ) + SUM(
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (55, 63, 67)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END
  ) AS pv_bonrabatt_bby,
  SUM(CASE WHEN v01.wv_grund_id = 2 THEN v01.abschriftbetrag_netto ELSE 0 END) + 0 + 0 + 0 + SUM(CASE WHEN v01.wv_grund_id = 0 THEN v01.abschriftbetrag_netto ELSE 0 END) + SUM(
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54, 55)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END
  ) + SUM(
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (56, 57, 58)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (56, 57, 58, 59)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END
  ) + SUM(
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (60, 61, 62)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (60, 61, 62, 63)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END
  ) + SUM(
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (64, 65, 66)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (64, 65, 66, 67)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END
  ) + (
    SUM(
      CASE
        WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (59)
        THEN v01.abschriftbetrag_netto
        ELSE 0
      END
    ) + SUM(
      CASE
        WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (55, 63, 67)
        THEN v01.abschriftbetrag_netto
        ELSE 0
      END
    )
  ) AS werbeabschrift_pv,
  SUM(
    CASE WHEN v01.wv_grund_id IN (48, 49) THEN v01.abschriftbetrag_netto ELSE NULL END
  ) AS werbeabschrift_werbenachvermarktung_manuell,
  SUM(
    CASE WHEN v01.wv_grund_id IN (48, 49) THEN v01.abschriftbetrag_netto ELSE NULL END
  ) AS werbeabschrift_aktionsanpassung_filiale,
  SUM(v01.abschriftbetrag_netto) - (
    SUM(CASE WHEN v01.wv_grund_id = 2 THEN v01.abschriftbetrag_netto ELSE 0 END) + 0 + 0 + 0 + SUM(CASE WHEN v01.wv_grund_id = 0 THEN v01.abschriftbetrag_netto ELSE 0 END) + SUM(
      CASE
        WHEN v01.dat >= CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (52, 53, 54)
        OR v01.dat < CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (52, 53, 54, 55)
        THEN v01.abschriftbetrag_netto
        ELSE 0
      END
    ) + SUM(
      CASE
        WHEN v01.dat >= CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (56, 57, 58)
        OR v01.dat < CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (56, 57, 58, 59)
        THEN v01.abschriftbetrag_netto
        ELSE 0
      END
    ) + SUM(
      CASE
        WHEN v01.dat >= CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (60, 61, 62)
        OR v01.dat < CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (60, 61, 62, 63)
        THEN v01.abschriftbetrag_netto
        ELSE 0
      END
    ) + SUM(
      CASE
        WHEN v01.dat >= CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (64, 65, 66)
        OR v01.dat < CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (64, 65, 66, 67)
        THEN v01.abschriftbetrag_netto
        ELSE 0
      END
    ) + (
      SUM(
        CASE
          WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (59)
          THEN v01.abschriftbetrag_netto
          ELSE 0
        END
      ) + SUM(
        CASE
          WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (55, 63, 67)
          THEN v01.abschriftbetrag_netto
          ELSE 0
        END
      )
    ) + SUM(
      CASE WHEN v01.wv_grund_id IN (48, 49) THEN v01.abschriftbetrag_netto ELSE NULL END
    ) + SUM(
      CASE
        WHEN v01.wv_grund_id IN (20, 21, 23, 50, 70)
        THEN v01.abschriftbetrag_netto
        ELSE NULL
      END
    )
  ) AS werbeabschrift_rest
FROM kfl_production_dbp_view.v_marktabschriften_1 AS v01
INNER JOIN kfl_production_dbp_view.v_art_1 AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.art_id = v02.art_id
INNER JOIN kfl_production_dbp_view.v_tag_1 AS v03
  ON v01.dat = v03.dat
WHERE
  v01.mandant_id = 1 AND v01.abschriftart_id = -1
GROUP BY
  v03.kjmo,
  v02.zek_id,
  v01.mandant_id,
  v01.nb_id,
  v01.wup_id;
