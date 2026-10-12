CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artbew (art_id, bewart_id, bewart_det_id, dat,
diff_logkostenzuschlag_konz, diff_ek_brutto_ums_konz, diff_ek_kbasis_ums_konz, diff_ek_mep_ums_konz, diff_ek_n_ums_konz
, diff_ek_nn_ums_konz, diff_mwst_betrag_ums_konz, diff_netto_ums_konz, ek_brutto_umsatz, ek_kbasis_umsatz, ek_mep_umsatz
, ek_n_umsatz, ek_nn_umsatz, gp_id, herst_id, mandant_id, mwst_id, nb_id, umsatz_mwst_betrag, umsatz_netto, vk_menge,
wrg, wup_id, diff_ek_nn2_ums_konz, diff_ek_kl_ums_konz, ek_kl_umsatz, ek_nn2_umsatz, bezugsweg_id, logkostenzuschlag,
ek_netto_bnk_umsatz, ek_netto_bnk_sachk_umsatz, aktion_id, posten_id, posten_kz, posten_id_per, posten_kz_per, ean_kasse
, bq_findung_id, wup_bereinigt_fg, wup_bereinigt_fg_vj, wup_bereinigt_fg_vj_wo) AS WITH T_WUP_BEREINIGT AS (SELECT V01.dat
   ,
   V02.mandant_id,
   V02.wup_id,
    CASE
    WHEN V01.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V01
        .kjwo_kl_dat_bis < V02.dat_bis OR V02.wup_aenderung_grund_id IN (1, 2, 3, 4))
    THEN 1
    ELSE 0
    END AS wup_bereinigt_fg_akt,
    CASE
    WHEN V04.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V04
        .kjwo_kl_dat_bis < V02.dat_bis OR V02.wup_aenderung_grund_id IN (1, 2, 3, 4))
    THEN 1
    ELSE 0
    END AS wup_bereinigt_fg_vj_wo,
    CASE
    WHEN CAST(V01.dat AS STRING) LIKE '%-02-29'
    THEN CASE
     WHEN V04.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V04
         .kjwo_kl_dat_bis < V02.dat_bis OR V02.wup_aenderung_grund_id IN (1, 2, 3, 4))
     THEN 1
     ELSE 0
     END
    WHEN V03.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V03
        .kjwo_kl_dat_bis < V02.dat_bis OR V02.wup_aenderung_grund_id IN (1, 2, 3, 4))
    THEN 1
    ELSE 0
    END AS wup_bereinigt_fg_vj
  FROM kfl_production_dbp_view.v_tag AS V01
   INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.dat >= COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung)
   LEFT JOIN kfl_production_dbp_view.v_tag AS V03 ON V01.dat = V03.dat_vj_kt
   LEFT JOIN kfl_production_dbp_view.v_tag AS V04 ON V01.dat = V04.dat_vj
  WHERE V01.dat BETWEEN DATE '2019-01-01' AND (DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY))
   AND V02.nb_id = 0
   AND V02.mandant_id = 1) (SELECT V1.art_id,
   V1.bewart_id,
   V1.bewart_det_id,
   V1.dat,
   CAST(V1.diff_logkostenzuschlag_konz AS BIGNUMERIC),
   CAST(V1.diff_ek_brutto_konz AS BIGNUMERIC),
   CAST(V1.diff_ek_kal_basis_konz AS BIGNUMERIC),
   CAST(V1.diff_ek_mep_konz AS BIGNUMERIC),
   CAST(V1.diff_ek_netto_konz AS BIGNUMERIC),
   CAST(V1.diff_ek_nettonetto_konz AS BIGNUMERIC),
   CAST(V1.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC),
   CAST(V1.diff_umsatz_netto_konz AS BIGNUMERIC),
   CAST(V1.ek_brutto AS BIGNUMERIC),
   CAST(V1.ek_kal_basis AS BIGNUMERIC),
   CAST(V1.ek_mep AS BIGNUMERIC),
   CAST(V1.ek_netto AS BIGNUMERIC),
   CAST(V1.ek_nettonetto AS BIGNUMERIC),
   V1.gp_id,
   V1.herst_id,
   V1.mandant_id,
   V1.mwst_id,
   V1.nb_id,
   CAST(V1.umsatz_mwst_betrag AS BIGNUMERIC),
   CAST(V1.umsatz_netto AS BIGNUMERIC),
   CAST(V1.menge AS BIGNUMERIC),
   V1.wrg,
   V1.wup_id,
    V1.diff_ek_kal_basis_konz - V1.diff_logkostenzuschlag_konz AS diff_ek_nn2_ums_konz,
   CAST(V1.diff_einstandspreis_konz AS BIGNUMERIC),
   CAST(V1.einstandspreis AS BIGNUMERIC),
    V1.ek_kal_basis - V1.logkostenzuschlag AS ek_nn2_umsatz,
   V1.bezugsweg_id,
   CAST(V1.logkostenzuschlag AS BIGNUMERIC),
   CAST(V1.ek_netto_bnk AS BIGNUMERIC),
   CAST(V1.ek_netto_bnk_sachk AS BIGNUMERIC),
   COALESCE(V1.standard_aktion_id, V1.aktion_id, '0') AS aktion_id,
   SUBSTR(CASE
     WHEN V1.bewart_id = 1001 AND V1.posten_id NOT IN ('PN', 'PF', 'SP')
     THEN ''
     ELSE 'PN'
     END, 1, 2) AS posten_id_,
   SUBSTR(CASE
     WHEN V1.posten_id NOT IN ('PN', 'PF', 'SP')
     THEN 'SO'
     ELSE 'PN'
     END, 1, 2) AS posten_kz,
   SUBSTR(CASE
     WHEN V1.bewart_id = 1001 AND V2.posten_id NOT IN ('PN', 'PF', 'SP')
     THEN ''
     ELSE 'PN'
     END, 1, 2) AS posten_id_per,
   SUBSTR(CASE
     WHEN V2.posten_id NOT IN ('PN', 'PF', 'SP')
     THEN 'SO'
     ELSE 'PN'
     END, 1, 2) AS posten_kz_per,
    CASE
    WHEN V1.ean_kasse BETWEEN 100000 AND 999999
    THEN V1.ean_kasse * 10000000
    ELSE V1.ean_kasse
    END AS ean_kasse,
   V1.bq_findung_id,
   v3.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
   v3.wup_bereinigt_fg_vj,
   v3.wup_bereinigt_fg_vj_wo
  FROM kfl_production_dbp_view.v_artbew AS V1
   LEFT JOIN kfl_production_dbp_view.v_art_per AS V2 ON V1.art_id = V2.art_id AND V1.mandant_id = V2.mandant_id AND V1.dat
     BETWEEN DATE_SUB(V2.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V2.dat_bis, INTERVAL 1 DAY))
   LEFT JOIN T_WUP_BEREINIGT AS v3 ON V1.dat = v3.dat AND V1.mandant_id = v3.mandant_id AND V1.wup_id = v3.wup_id
  WHERE V1.mandant_id = 1);