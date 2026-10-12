CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_int.tbl_mv_artbew_1 AS
WITH t_wup_bereinigt AS (
  SELECT
    v010.dat,
    v02.mandant_id,
    v02.wup_id,
    CASE
      WHEN v010.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
      AND (
        v010.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
      )
      THEN 1
      ELSE 0
    END AS wup_bereinigt_fg_akt,
    CASE
      WHEN v04.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
      AND (
        v04.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
      )
      THEN 1
      ELSE 0
    END AS wup_bereinigt_fg_vj_wo,
    CASE
      WHEN CAST(v010.dat AS STRING) LIKE '%-02-29'
      THEN CASE
        WHEN v04.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
        AND (
          v04.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
        )
        THEN 1
        ELSE 0
      END
      WHEN v03.kjwo_kl_dat_von > DATE_ADD(COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung), INTERVAL '364' DAY)
      AND (
        v03.kjwo_kl_dat_bis < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1, 2, 3, 4)
      )
      THEN 1
      ELSE 0
    END AS wup_bereinigt_fg_vj
  FROM kfl_production_dbp_view.v_tag_1 AS v010
  INNER JOIN kfl_production_dbp_view.v_wup_1 AS v02
    ON v010.dat >= COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung)
  LEFT JOIN kfl_production_dbp_view.v_tag_1 AS v03
    ON v010.dat = v03.dat_vj_kt
  LEFT JOIN kfl_production_dbp_view.v_tag_1 AS v04
    ON v010.dat = v04.dat_vj
  WHERE
    v010.dat BETWEEN CAST('2019-01-01' AS DATE) AND (
      DATE_ADD(CURRENT_DATE, INTERVAL '7' DAY)
    )
    AND v02.nb_id = 0
)
(
  SELECT
    v01.dat AS dat,
    v01.art_id AS art_id,
    v01.mandant_id AS mandant_id,
    COALESCE(v02.gp_id, -1) AS gp_id,
    v01.nb_id AS nb_id,
    v01.wup_id AS wup_id,
    0 AS bewart_id,
    0 AS bewart_det_id,
    0 AS bq_findung_id,
    0 AS bezugsweg_id,
    '' AS aktion_id,
    '' AS posten_id_per,
    '' AS posten_kz_per,
    'EUR' AS wrg_1,
    0 AS herst_id,
    v05.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
    v05.wup_bereinigt_fg_vj AS wup_bereinigt_fg_vj,
    v05.wup_bereinigt_fg_vj_wo AS wup_bereinigt_fg_vj_wo,
    0 AS mwst_id,
    0 AS umsatz_mwst_betrag,
    0 AS umsatz_netto,
    0 AS vk_menge,
    0 AS vk_menge_norm,
    0 AS ek_brutto_absatz,
    0 AS ek_netto_absatz,
    0 AS ek_nettobnk_absatz,
    0 AS ek_netto2_absatz,
    0 AS ek_netto3_absatz,
    0 AS ek_netto4_absatz,
    0 AS ek_netto4_absatz_einstandspreis,
    0 AS ek_gld_absatz,
    0 AS umsatz_mwst_betrag_af,
    0 AS umsatz_netto_af,
    0 AS vk_menge_af,
    0 AS vk_menge_af_norm,
    0 AS ek_brutto_absatz_af,
    0 AS ek_netto_absatz_af,
    0 AS ek_nettobnk_absatz_af,
    0 AS ek_netto2_absatz_af,
    0 AS ek_netto3_absatz_af,
    0 AS ek_netto4_absatz_af,
    0 AS ek_netto4_absatz_af_einstandspreis,
    0 AS ek_gld_absatz_af,
    0 AS umsatz_mwst_betrag_sa,
    0 AS umsatz_netto_sa,
    0 AS vk_menge_sa,
    0 AS vk_menge_sa_norm,
    0 AS ek_brutto_absatz_sa,
    0 AS ek_netto_absatz_sa,
    0 AS ek_nettobnk_absatz_sa,
    0 AS ek_netto2_absatz_sa,
    0 AS ek_netto3_absatz_sa,
    0 AS ek_netto4_absatz_sa,
    0 AS ek_netto4_absatz_sa_einstandspreis,
    0 AS ek_gld_absatz_sa,
    0 AS ean_kasse,
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
    CASE WHEN v01.wv_grund_id = 2 THEN v01.abschriftbetrag_netto ELSE 0 END AS pv_aktion_sa_loyalty,
    0 AS pv_aktion_sa_loyalty_bby,
    0 AS pv_aktion_sa_loyalty_kdn_bby,
    0 AS pv_aktion_sa_loyalty_kdp_bby,
    CASE WHEN v01.wv_grund_id = 0 THEN v01.abschriftbetrag_netto ELSE 0 END AS pv_aktion_sa_non_loyalty,
    0 AS pv_aktion_sa_non_loyalty_bby,
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54, 55)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END AS pv_bby_loyalty,
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (56, 57, 58)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (56, 57, 58, 59)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END AS pv_bby_non_loyalty,
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (60, 61, 62)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (60, 61, 62, 63)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END AS pv_kdn_bby_loyalty,
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (64, 65, 66)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (64, 65, 66, 67)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END AS pv_kdp_bby_loyalty,
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (59)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END AS pv_bonrabatt_bby_non_loyalty,
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (55, 63, 67)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END AS pv_bonrabatt_bby_loyalty,
    CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (59)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END + CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (55, 63, 67)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END AS pv_bonrabatt_bby,
    0 AS bonusbasis,
    0 AS bonusbasis_af,
    0 AS bonusbasis_sa,
    0 AS ek_mepol,
    0 AS ek_mepol_af,
    0 AS ek_mepol_sa,
    CASE WHEN v01.wv_grund_id = 2 THEN v01.abschriftbetrag_netto ELSE 0 END + 0 + 0 + 0 + CASE WHEN v01.wv_grund_id = 0 THEN v01.abschriftbetrag_netto ELSE 0 END + CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (52, 53, 54, 55)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END + CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (56, 57, 58)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (56, 57, 58, 59)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END + CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (60, 61, 62)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (60, 61, 62, 63)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END + CASE
      WHEN v01.dat >= CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (64, 65, 66)
      OR v01.dat < CAST('2022-04-01' AS DATE)
      AND v01.wv_grund_id IN (64, 65, 66, 67)
      THEN v01.abschriftbetrag_netto
      ELSE 0
    END + (
      CASE
        WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (59)
        THEN v01.abschriftbetrag_netto
        ELSE 0
      END + CASE
        WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (55, 63, 67)
        THEN v01.abschriftbetrag_netto
        ELSE 0
      END
    ) AS werbeabschrift_pv,
    CASE WHEN v01.wv_grund_id IN (48, 49) THEN v01.abschriftbetrag_netto ELSE NULL END AS werbeabschrift_werbenachvermarktung_manuell,
    CASE
      WHEN v01.wv_grund_id IN (20, 21, 23, 50, 70)
      THEN v01.abschriftbetrag_netto
      ELSE NULL
    END AS werbeabschrift_aktionsanpassung_filiale,
    v01.abschriftbetrag_netto - (
      CASE WHEN v01.wv_grund_id = 2 THEN v01.abschriftbetrag_netto ELSE 0 END + 0 + 0 + 0 + CASE WHEN v01.wv_grund_id = 0 THEN v01.abschriftbetrag_netto ELSE 0 END + CASE
        WHEN v01.dat >= CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (52, 53, 54)
        OR v01.dat < CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (52, 53, 54, 55)
        THEN v01.abschriftbetrag_netto
        ELSE 0
      END + CASE
        WHEN v01.dat >= CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (56, 57, 58)
        OR v01.dat < CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (56, 57, 58, 59)
        THEN v01.abschriftbetrag_netto
        ELSE 0
      END + CASE
        WHEN v01.dat >= CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (60, 61, 62)
        OR v01.dat < CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (60, 61, 62, 63)
        THEN v01.abschriftbetrag_netto
        ELSE 0
      END + CASE
        WHEN v01.dat >= CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (64, 65, 66)
        OR v01.dat < CAST('2022-04-01' AS DATE)
        AND v01.wv_grund_id IN (64, 65, 66, 67)
        THEN v01.abschriftbetrag_netto
        ELSE 0
      END + (
        CASE
          WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (59)
          THEN v01.abschriftbetrag_netto
          ELSE 0
        END + CASE
          WHEN v01.dat >= CAST('2022-04-01' AS DATE) AND v01.wv_grund_id IN (55, 63, 67)
          THEN v01.abschriftbetrag_netto
          ELSE 0
        END
      ) + CASE WHEN v01.wv_grund_id IN (48, 49) THEN v01.abschriftbetrag_netto ELSE NULL END + CASE
        WHEN v01.wv_grund_id IN (20, 21, 23, 50, 70)
        THEN v01.abschriftbetrag_netto
        ELSE NULL
      END
    ) AS werbeabschrift_rest
  FROM kfl_production_dbp_view.v_marktabschriften_1 AS v01
  LEFT JOIN (
    SELECT
      art_id,
      gp_id,
      wup_id,
      dat_von,
      dat_bis
    FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_1
    WHERE
      mandant_id = 1
  ) AS v02
    ON v01.art_id = v02.art_id
    AND v01.wup_id = v02.wup_id
    AND v01.dat BETWEEN v02.dat_von AND v02.dat_bis
  LEFT JOIN t_wup_bereinigt AS v05
    ON v01.dat = v05.dat AND v01.mandant_id = v05.mandant_id AND v01.wup_id = v05.wup_id
  WHERE
    v01.mandant_id = 1 AND v01.abschriftart_id = -1
);
