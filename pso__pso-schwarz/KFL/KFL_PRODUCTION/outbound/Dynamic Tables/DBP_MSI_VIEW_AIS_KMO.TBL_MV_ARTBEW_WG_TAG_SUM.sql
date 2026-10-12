CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_kmo.tbl_mv_artbew_wg_tag_sum AS
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
  FROM kfl_production_dbp_view.v_tag AS v010
  INNER JOIN kfl_production_dbp_view.v_wup AS v02
    ON v010.dat >= COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung)
  LEFT JOIN kfl_production_dbp_view.v_tag AS v03
    ON v010.dat = v03.dat_vj_kt
  LEFT JOIN kfl_production_dbp_view.v_tag AS v04
    ON v010.dat = v04.dat_vj
  WHERE
    v010.dat BETWEEN CAST('2019-01-01' AS DATE) AND (
      DATE_ADD(CURRENT_DATE, INTERVAL '7' DAY)
    )
    AND v02.nb_id = 0
    AND v02.mandant_id <> 1
)
(
  SELECT
    v01.dat AS dat,
    v01.wg_id AS wg_id,
    v01.arthiertyp_id AS arthiertyp_id,
    v01.mandant_id AS mandant_id,
    v01.nb_id AS nb_id,
    v01.wup_id AS wup_id,
    v01.bewart_id AS bewart_id,
    v01.bewart_det_id AS bewart_det_id,
    v01.posten_id AS posten_id,
    v02.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
    v02.wup_bereinigt_fg_vj AS wup_bereinigt_fg_vj,
    v02.wup_bereinigt_fg_vj_wo AS wup_bereinigt_fg_vj_wo,
    CASE
      WHEN v01.bewart_id IN (1001, 1010)
      THEN CAST(v01.menge AS BIGNUMERIC)
      ELSE NULL
    END AS vk_menge_af,
    CASE WHEN v01.bewart_id = 1002 THEN CAST(v01.menge AS BIGNUMERIC) ELSE NULL END AS vk_menge_sa,
    v01.diff_einstandspreis_konz AS diff_einstandspreis_konz,
    v01.diff_ek_brutto_konz AS diff_ek_brutto_konz,
    v01.diff_ek_mep_konz AS diff_ek_mep_konz,
    v01.diff_ek_netto_bnk_konz AS diff_ek_netto_bnk_konz,
    v01.diff_ek_netto_konz AS diff_ek_netto_konz,
    v01.diff_ek_nettonetto_konz AS diff_ek_nettonetto_konz,
    v01.diff_umsatz_mwst_betrag_konz AS diff_umsatz_mwst_betrag_konz,
    v01.diff_umsatz_netto_konz AS diff_umsatz_netto_konz,
    v01.diff_ek_gld_konz AS diff_ek_gld_konz,
    v01.einstandspreis AS einstandspreis,
    v01.ek_brutto AS ek_brutto,
    v01.ek_mep AS ek_mep,
    v01.ek_netto AS ek_netto,
    v01.ek_netto_bnk AS ek_netto_bnk,
    v01.ek_nettonetto AS ek_nettonetto,
    v01.ek_gld AS ek_gld,
    v01.menge AS menge,
    v01.umsatz_mwst_betrag AS umsatz_mwst_betrag,
    v01.umsatz_netto AS umsatz_netto,
    CASE
      WHEN v01.bewart_det_id IN (100110, 100130)
      THEN CAST(v01.menge AS BIGNUMERIC)
      ELSE NULL
    END AS vk_menge_af_non_loyalty,
    CASE
      WHEN v01.bewart_det_id IN (100111, 100121, 100131)
      THEN CAST(v01.menge AS BIGNUMERIC)
      ELSE NULL
    END AS vk_menge_af_loyalty,
    CASE WHEN v01.bewart_det_id = 100111 THEN CAST(v01.menge AS BIGNUMERIC) ELSE 0 END AS vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
    CASE WHEN v01.bewart_det_id = 100110 THEN CAST(v01.menge AS BIGNUMERIC) ELSE 0 END AS vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
    CASE WHEN v01.bewart_det_id = 100111 THEN CAST(v01.menge AS BIGNUMERIC) ELSE 0 END + CASE WHEN v01.bewart_det_id = 100110 THEN CAST(v01.menge AS BIGNUMERIC) ELSE 0 END AS vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
    CASE
      WHEN v01.bewart_det_id = 100121
      THEN CAST(v01.menge AS BIGNUMERIC)
      ELSE NULL
    END AS vk_menge_af_loyalty_schwarz_media,
    CASE
      WHEN v01.bewart_det_id = 100210
      THEN CAST(v01.menge AS BIGNUMERIC)
      ELSE NULL
    END AS vk_menge_sa_non_loyalty,
    CASE
      WHEN v01.bewart_det_id = 100211
      THEN CAST(v01.menge AS BIGNUMERIC)
      ELSE NULL
    END AS vk_menge_sa_loyalty,
    CASE
      WHEN v01.bewart_det_id = 100220
      THEN CAST(v01.menge AS BIGNUMERIC)
      ELSE NULL
    END AS vk_menge_bby_non_loyalty,
    CASE
      WHEN v01.bewart_det_id = 100221
      THEN CAST(v01.menge AS BIGNUMERIC)
      ELSE NULL
    END AS vk_menge_bby_loyalty,
    CASE
      WHEN v01.bewart_det_id = 100231
      THEN CAST(v01.menge AS BIGNUMERIC)
      ELSE NULL
    END AS vk_menge_kdn_bby_loyalty,
    CASE
      WHEN v01.bewart_det_id = 100241
      THEN CAST(v01.menge AS BIGNUMERIC)
      ELSE NULL
    END AS vk_menge_kdp_bby_loyalty,
    CASE WHEN v01.bewart_det_id = 100130 THEN CAST(v01.menge AS BIGNUMERIC) ELSE 0 END AS vk_menge_bonrabatt_bby_non_loyalty,
    CASE WHEN v01.bewart_det_id = 100131 THEN CAST(v01.menge AS BIGNUMERIC) ELSE 0 END AS vk_menge_bonrabatt_bby_loyalty,
    CASE WHEN v01.bewart_det_id = 100130 THEN CAST(v01.menge AS BIGNUMERIC) ELSE 0 END + CASE WHEN v01.bewart_det_id = 100131 THEN CAST(v01.menge AS BIGNUMERIC) ELSE 0 END AS vk_menge_bonrabatt_bby,
    v01.bonusbasis AS bonusbasis,
    v01.bonusbasis_konz AS bonusbasis_konz,
    v01.ek_mep_vor_fwu AS ek_mep_vor_fwu,
    v01.ek_mep_vor_fwu_konz AS ek_mep_vor_fwu_konz,
    v01.ek_kal_basis AS ek_kal_basis,
    v01.diff_ek_kal_basis_konz AS diff_ek_kal_basis_konz,
    v01.pv_aktion AS pv_aktion,
    v01.pv_aktion_konz AS pv_aktion_konz,
    v01.pv_aktion_bby AS pv_aktion_bby,
    v01.pv_aktion_bby_konz AS pv_aktion_bby_konz,
    v01.pv_aktion_kdn_bby AS pv_aktion_kdn_bby,
    v01.pv_aktion_kdn_bby_konz AS pv_aktion_kdn_bby_konz,
    v01.pv_aktion_kdp_bby AS pv_aktion_kdp_bby,
    v01.pv_aktion_kdp_bby_konz AS pv_aktion_kdp_bby_konz,
    v01.pv_bby AS pv_bby,
    v01.pv_bby_konz AS pv_bby_konz,
    v01.pv_kdn_bby AS pv_kdn_bby,
    v01.pv_kdn_bby_konz AS pv_kdn_bby_konz,
    v01.pv_kdp_bby AS pv_kdp_bby,
    v01.pv_kdp_bby_konz AS pv_kdp_bby_konz,
    v01.pv_bonrabatt_bby AS pv_bonrabatt_bby,
    v01.pv_bonrabatt_bby_konz AS pv_bonrabatt_bby_konz,
    v01.umrechnungskurs_hist AS umrechnungskurs_hist
  FROM kfl_production_dbp_view.v_artbew_wg_tp2_sum AS v01
  LEFT JOIN t_wup_bereinigt AS v02
    ON v01.dat = v02.dat AND v01.mandant_id = v02.mandant_id AND v01.wup_id = v02.wup_id
  WHERE
    v01.mandant_id <> 1 AND v01.arthiertyp_id = 2
);
