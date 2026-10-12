CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_fur_prognose_artbew_1 (wup_id, nb_id, mandant_id, art_id, loesch_id
, kl_art_id, dat, kjwo, kjmo, kj, menge_prognose, menge_prognose_kolli, menge_prognose_bef, menge_prognose_bef_kolli,
menge_prognose_max, menge_prognose_max_kolli, menge_ofc, menge_ofc_kolli, vk_menge, vk_menge_af, vk_menge_sa,
diff_menge_af_prognose, gp_id, progn_groesser_fg, menge_af_groesser_fg) AS SELECT V01.wup_id,
 V01.nb_id,
 V01.mandant_id,
 V01.art_id,
 V04.loesch_id,
 V04.kl_art_id,
 V02.dat,
 V02.kjwo,
 V02.kjmo,
 V02.kj,
 MIN(CAST(V01.menge_prognose AS NUMERIC)) AS menge_prognose,
 MIN(ROUND(CAST(V01.menge_prognose * COALESCE(V07.umrech_faktor, 1) AS NUMERIC), 3)) AS menge_prognose_kolli,
 MIN(CAST(V01.menge_prognose_bef AS NUMERIC)) AS menge_prognose_bef,
 MIN(ROUND(CAST(V01.menge_prognose_bef * COALESCE(V07.umrech_faktor, 1) AS NUMERIC), 3)) AS menge_prognose_bef_kolli,
 MIN(CAST(V01.menge_prognose_max AS NUMERIC)) AS menge_prognose_max,
 MIN(ROUND(CAST(V01.menge_prognose_max * COALESCE(V07.umrech_faktor, 1) AS NUMERIC), 3)) AS menge_prognose_max_kolli,
 MIN(CAST(V01.menge_ofc AS NUMERIC)) AS menge_ofc,
 MIN(ROUND(CAST(V01.menge_ofc * COALESCE(V07.umrech_faktor, 1) AS NUMERIC), 3)) AS menge_ofc_kolli,
 SUM(CAST(V05.menge AS BIGNUMERIC)) AS menge,
 SUM(CASE
   WHEN V05.bewart_id = 1001
   THEN CAST(V05.menge AS BIGNUMERIC)
   ELSE NULL
   END) AS vk_menge_af,
 SUM(CASE
   WHEN V05.bewart_id = 1002
   THEN CAST(V05.menge AS BIGNUMERIC)
   ELSE NULL
   END) AS vk_menge_sa,
  CASE
  WHEN SUM(CASE
    WHEN V05.bewart_id = 1002
    THEN CAST(V05.menge AS BIGNUMERIC)
    ELSE NULL
    END) IS NOT NULL
  THEN NULL
  ELSE ABS(IFNULL(SUM(CASE
       WHEN V05.bewart_id = 1001
       THEN CAST(V05.menge AS BIGNUMERIC)
       ELSE NULL
       END), 0) - MIN(CAST(V01.menge_prognose AS NUMERIC)))
  END AS diff_menge_af_prognose,
 V03.gp_id,
 V01.progn_groesser_fg,
 V01.menge_af_groesser_fg
FROM kfl_production_dbp_view.v_fur_prognose_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON V01.dat = V02.dat
 INNER JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
      AND V01.wup_id = V03.wup_id AND V02.dat BETWEEN V03.dat_von AND V03.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_artbew_1 AS V05 ON V01.art_id = V05.art_id AND V01.mandant_id = V05.mandant_id AND
     V01.wup_id = V05.wup_id AND V01.nb_id = V05.nb_id AND V02.dat = V05.dat
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS V06 ON V04.mandant_id = V06.mandant_id AND V04.art_id =
    V06.art_id AND V06.dat_bis = PARSE_DATE('%F', '9999-12-31')
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_1 AS V07 ON V03.mandant_id = V07.mandant_id AND V03.art_id
     = V07.art_id AND V06.ausg_menge_einh_id = V07.altnv_menge_einh_id AND V07.dat_bis = PARSE_DATE('%F', '9999-12-31')
WHERE V01.mandant_id = 1
 AND V01.dispomerkmal IN ('10', '11', '12', '14')
 AND V01.listung_id = 1
 AND V01.kdis = 0
GROUP BY V01.wup_id,
 V01.nb_id,
 V01.mandant_id,
 V01.art_id,
 V04.loesch_id,
 V04.kl_art_id,
 V02.dat,
 V02.kjwo,
 V02.kjmo,
 V02.kj,
 V03.gp_id,
 V01.progn_groesser_fg,
 V01.menge_af_groesser_fg;