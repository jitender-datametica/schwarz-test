CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_artbew_wo_sum_2
 AS
WITH T_WUP_BEREINIGT AS (SELECT DISTINCT V01.kjwo_kl,
   V02.mandant_id,
   V02.wup_id,
    CASE
    WHEN V01.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V01
        .kjwo_kl_dat_bis < V02.dat_bis OR V02.umzugsfiliale_fg = 1)
    THEN 1
    ELSE 0
    END AS wup_bereinigt_fg_akt,
    CASE
    WHEN V04.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V04
        .kjwo_kl_dat_bis < V02.dat_bis OR V02.umzugsfiliale_fg = 1)
    THEN 1
    ELSE 0
    END AS wup_bereinigt_fg_vj_wo,
    CASE
    WHEN CAST(V01.dat AS STRING) LIKE '%-02-29'
    THEN CASE
     WHEN V04.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V04
         .kjwo_kl_dat_bis < V02.dat_bis OR V02.umzugsfiliale_fg = 1)
     THEN 1
     ELSE 0
     END
    WHEN V03.kjwo_kl_dat_von > DATE_ADD(COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung), INTERVAL 364 DAY) AND (V03
        .kjwo_kl_dat_bis < V02.dat_bis OR V02.umzugsfiliale_fg = 1)
    THEN 1
    ELSE 0
    END AS wup_bereinigt_fg_vj
  FROM kfl_production_dbp_view.v_tag_2 AS V01
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V01.dat >= COALESCE(V02.dat_eroeffnung_alt, V02.dat_eroeffnung)
   LEFT JOIN kfl_production_dbp_view.v_tag_2 AS V03 ON V01.dat = V03.dat_vj_kt
   LEFT JOIN kfl_production_dbp_view.v_tag_2 AS V04 ON V01.dat = V04.dat_vj
  WHERE V01.dat BETWEEN DATE '2019-01-01' AND (DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY))
   AND V02.nb_id = 0
   AND V02.mandant_id = 1) (SELECT V1.kjwo_kl,
   V1.art_id,
   COALESCE(V1.standard_aktion_id, V1.aktion_id, '0') AS aktion_id,
   V1.bewart_id,
   V1.bewart_det_id,
   V1.mandant_id,
   V1.wup_id,
   V1.nb_id,
   V1.gp_id,
    CASE
    WHEN V1.ean_kasse BETWEEN 100000 AND 999999
    THEN V1.ean_kasse * 10000000
    ELSE V1.ean_kasse
    END AS ean_kasse,
   V1.herst_id,
   CAST(V1.diff_ek_nettonetto_konz AS BIGNUMERIC) AS diff_ek_nn_ums_konz,
   CAST(V1.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC) AS diff_mwst_betrag_ums_konz,
   CAST(V1.diff_umsatz_netto_konz AS BIGNUMERIC) AS diff_netto_ums_konz,
   CAST(V1.ek_mep AS BIGNUMERIC) AS ek_mep_umsatz,
   CAST(V1.ek_nettonetto AS BIGNUMERIC) AS ek_nn_umsatz,
   CAST(V1.umsatz_mwst_betrag AS BIGNUMERIC) AS umsatz_mwst_betrag,
   CAST(V1.umsatz_netto AS BIGNUMERIC) AS umsatz_netto,
   CAST(V1.menge AS BIGNUMERIC) AS vk_menge,
   CAST(V1.diff_einstandspreis_konz AS BIGNUMERIC) AS diff_ek_kl_ums_konz,
   CAST(V1.einstandspreis AS BIGNUMERIC) AS ek_kl_umsatz,
   CAST(V1.diff_ek_brutto_konz AS BIGNUMERIC) AS diff_ek_brutto_ums_konz,
   CAST(V1.diff_ek_kal_basis_konz AS BIGNUMERIC) AS diff_ek_kbasis_ums_konz,
   CAST(V1.diff_ek_mep_konz AS BIGNUMERIC) AS diff_ek_mep_ums_konz,
   CAST(V1.diff_ek_netto_konz AS BIGNUMERIC) AS diff_ek_n_ums_konz,
   CAST(V1.diff_logkostenzuschlag_konz AS BIGNUMERIC) AS diff_logkostenzuschlag_konz,
   CAST(V1.ek_brutto AS BIGNUMERIC) AS ek_brutto_umsatz,
   CAST(V1.ek_kal_basis AS BIGNUMERIC) AS ek_kbasis_umsatz,
   CAST(V1.ek_netto AS BIGNUMERIC) AS ek_n_umsatz,
   CAST(V1.ek_netto_bnk AS BIGNUMERIC) AS ek_netto_bnk_umsatz,
   CAST(V1.ek_netto_bnk_sachk AS BIGNUMERIC) AS ek_netto_bnk_sachk_umsatz,
   CAST(V1.logkostenzuschlag AS BIGNUMERIC) AS logkostenzuschlag,
   CAST(V1.diff_ek_kal_basis_konz - V1.diff_logkostenzuschlag_konz AS BIGNUMERIC) AS diff_ek_nn2_ums_konz,
   CAST(V1.ek_kal_basis - V1.logkostenzuschlag AS BIGNUMERIC) AS ek_nn2_umsatz,
   v2.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
   v2.wup_bereinigt_fg_vj,
   v2.wup_bereinigt_fg_vj_wo,
   V1.aktionsart_liste_id,
   V1.aktion_typ_liste_id
  FROM kfl_production_dbp_view.v_artbew_wo_sum_2 AS V1
   LEFT JOIN T_WUP_BEREINIGT AS v2 ON V1.kjwo_kl = v2.kjwo_kl AND V1.mandant_id = v2.mandant_id AND V1.wup_id = v2.wup_id
     
  WHERE V1.mandant_id = 1);