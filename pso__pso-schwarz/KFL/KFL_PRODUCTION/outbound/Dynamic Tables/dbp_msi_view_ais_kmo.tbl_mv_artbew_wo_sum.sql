CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_kmo.tbl_mv_artbew_wo_sum AS
WITH t_wup_bereinigt AS (
  SELECT DISTINCT
    v010.kjwo_kl,
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
  FROM kfl_production_dbp_data.tag AS v010
  INNER JOIN kfl_production_dbp_data.wup AS v02
    ON v010.dat >= COALESCE(v02.dat_eroeffnung_alt, v02.dat_eroeffnung)
  LEFT JOIN kfl_production_dbp_data.tag AS v03
    ON v010.dat = v03.dat_vj_kt
  LEFT JOIN kfl_production_dbp_data.tag AS v04
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
    v01.kjwo_kl AS kjwo_kl,
    v01.art_id AS art_id,
    v01.mandant_id AS mandant_id,
    v01.gp_id AS gp_id,
    v01.herst_id AS herst_id,
    v01.nb_id AS nb_id,
    v01.wup_id AS wup_id,
    v01.bewart_id AS bewart_id,
    v01.bewart_det_id AS bewart_det_id,
    CAST(CASE
      WHEN v01.bewart_id = 1001 AND NOT v01.posten_id IN ('PN', 'PF', 'SP', '1')
      THEN 'SO'
      ELSE 'PN'
    END AS STRING) AS posten_id_per,
    SUBSTR(CASE WHEN NOT v01.posten_id IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END, 1, 2) AS posten_kz_per,
    v01.bezugsweg_id AS bezugsweg_id,
    v01.ean_kasse AS ean_kasse,
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
    v01.diff_ek_nettonetto_konz AS diff_ek_nettonetto_konz,
    v01.diff_umsatz_mwst_betrag_konz AS diff_umsatz_mwst_betrag_konz,
    v01.diff_umsatz_netto_konz AS diff_umsatz_netto_konz,
    v01.einstandspreis AS einstandspreis,
    v01.ek_nettonetto AS ek_nettonetto,
    v01.menge AS menge,
    v01.umsatz_mwst_betrag AS umsatz_mwst_betrag,
    v01.umsatz_netto AS umsatz_netto,
    v01.diff_ek_brutto_konz AS diff_ek_brutto_konz,
    v01.diff_ek_gld_konz AS diff_ek_gld_konz,
    v01.diff_ek_mep_konz AS diff_ek_mep_konz,
    v01.diff_ek_netto_bnk_konz AS diff_ek_netto_bnk_konz,
    v01.diff_ek_netto_konz AS diff_ek_netto_konz,
    v01.ek_brutto AS ek_brutto,
    v01.ek_gld AS ek_gld,
    v01.ek_netto AS ek_netto,
    v01.ek_netto_bnk AS ek_netto_bnk,
    v01.ek_mep AS ek_mep,
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
  FROM kfl_production_dbp_data.artbew_wo_sum AS v01
  LEFT JOIN t_wup_bereinigt AS v02
    ON v01.kjwo_kl = v02.kjwo_kl
    AND v01.mandant_id = v02.mandant_id
    AND v01.wup_id = v02.wup_id
  WHERE
    v01.mandant_id <> 1
    AND (
      v01.mandant_id <> 5 OR v01.art_id <> 206731500
    )
    AND (
      v01.mandant_id <> 2 OR v01.art_id <> 208124500
    )
    AND (
      v01.mandant_id <> 3 OR v01.art_id <> 208113690
    )
    AND (
      v01.mandant_id <> 6 OR v01.art_id <> 208131570
    )
    AND (
      NOT v01.mandant_id IN (4, 7) OR v01.art_id <> 208114740
    )
    AND (
      v01.mandant_id <> 8 OR v01.art_id <> 208131640
    )
);
