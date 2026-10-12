CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_prognose_fur (mandant_id, wup_id, nb_id, art_id, dat,
dat_prognoselauf, diagnose_id, prognose_bez, kjwo, kjmo, prognose_kennzeichen_fur, prognose_horizont_fur,
menge_prognose_sa_fur, menge_prognose_af_fur, menge_prognose_fur, menge_prognose_max_fur, vk_menge_fur, vk_menge_fur_opa
, vk_menge_sa_fur, vk_menge_af_fur, abs_diff_fur, abs_diff_sa_fur, abs_diff_af_fur) AS SELECT P_FUR.mandant_id,
 V05.aktuell_wup_id AS wup_id,
 P_FUR.nb_id,
 P_FUR.art_id,
 P_FUR.dat,
  CASE
  WHEN P_FUR.dat <= CURRENT_DATE
  THEN DATE_SUB(P_FUR.dat, INTERVAL 1 DAY)
  ELSE CURRENT_DATE
  END AS dat_prognoselauf,
 '    ' AS diagnose_id,
 'LEGACY_ATTR_DO_NOT_USE' AS prognose_bez,
 T.kjwo,
 T.kjmo,
  CASE
  WHEN P_FUR.menge_prognose_aktion > 0
  THEN 'SA'
  ELSE 'AF'
  END AS prognose_kennzeichen_fur,
 P_FUR.prognose_horizont AS prognose_horizont_fur,
 P_FUR.menge_prognose_aktion AS menge_prognose_sa_fur,
  CASE
  WHEN P_FUR.menge_prognose_aktion > 0
  THEN 0
  ELSE P_FUR.menge_prognose
  END AS menge_prognose_af_fur,
  CASE
  WHEN P_FUR.menge_prognose_aktion > 0
  THEN P_FUR.menge_prognose_aktion
  ELSE P_FUR.menge_prognose
  END AS menge_prognose_fur,
 P_FUR.menge_prognose_max AS menge_prognose_max_fur,
 COALESCE(artbew.vk_menge, 0) AS vk_menge_fur,
  COALESCE(artbew.vk_menge, 0) - COALESCE(CASE
    WHEN artbew.mandant_id = 1
    THEN absch_de.menge_preisabschriften
    ELSE absch_kmo.menge_preisabschriften
    END, 0) AS vk_menge_fur_opa,
 COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_fur,
 COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_fur,
 ABS(CASE
    WHEN P_FUR.menge_prognose_aktion > 0
    THEN P_FUR.menge_prognose_aktion
    ELSE P_FUR.menge_prognose
    END - COALESCE(artbew.vk_menge, 0)) AS abs_diff_fur,
 ABS(P_FUR.menge_prognose_aktion - COALESCE(artbew.vk_menge_sa, 0)) AS abs_diff_sa_fur,
 ABS(CASE
    WHEN P_FUR.menge_prognose_aktion > 0
    THEN 0
    ELSE P_FUR.menge_prognose
    END - COALESCE(artbew.vk_menge_af, 0)) AS abs_diff_af_fur
FROM kfl_production_dbp_view.v_fur_prognose AS P_FUR
 LEFT JOIN (SELECT dat,
   art_id,
   mandant_id,
   nb_id,
   wup_id,
   SUM(menge) AS vk_menge,
   SUM(CASE
     WHEN bewart_id = 1002
     THEN menge
     ELSE NULL
     END) AS vk_menge_sa,
   SUM(CASE
     WHEN bewart_id = 1001
     THEN menge
     ELSE NULL
     END) AS vk_menge_af
  FROM kfl_production_dbp_view.v_artbew AS V01
  GROUP BY dat,
   art_id,
   mandant_id,
   nb_id,
   wup_id) AS artbew ON P_FUR.mandant_id = artbew.mandant_id AND P_FUR.wup_id = artbew.wup_id AND P_FUR.dat = artbew.dat
     AND P_FUR.art_id = artbew.art_id
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON P_FUR.mandant_id = V05.mandant_id AND P_FUR.wup_id = V05.wup_id AND
   (V05.nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   art_id,
   dat,
   SUM(CASE
     WHEN abschrift_menge_einh_id = 'G'
     THEN menge_abschrift / 1000
     ELSE menge_abschrift
     END) AS menge_preisabschriften
  FROM kfl_production_dbp_view.v_marktabschriften AS V01
  WHERE mandant_id = 1
   AND abschriftart_id IN (5, 7)
  GROUP BY mandant_id,
   wup_id,
   art_id,
   dat) AS absch_de ON P_FUR.mandant_id = absch_de.mandant_id AND P_FUR.wup_id = absch_de.wup_id AND P_FUR.art_id =
    absch_de.art_id AND P_FUR.dat = absch_de.dat
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   art_id,
   dat_umbew AS dat,
   SUM(menge_erf) AS menge_preisabschriften
  FROM kfl_production_dbp_view.v_art_umbewertung AS ABSCH
  WHERE mandant_id = 6 AND preis_aend_grund_id = 2
   OR mandant_id IN (2, 4, 5, 7, 8) AND preis_aend_grund_id = 7
   OR mandant_id = 3 AND preis_aend_grund_id = 11
  GROUP BY mandant_id,
   wup_id,
   art_id,
   dat) AS absch_kmo ON P_FUR.mandant_id = absch_kmo.mandant_id AND P_FUR.wup_id = absch_kmo.wup_id AND P_FUR.art_id =
    absch_kmo.art_id AND P_FUR.dat = absch_kmo.dat
 INNER JOIN kfl_production_dbp_view.v_tag AS T ON P_FUR.dat = T.dat;