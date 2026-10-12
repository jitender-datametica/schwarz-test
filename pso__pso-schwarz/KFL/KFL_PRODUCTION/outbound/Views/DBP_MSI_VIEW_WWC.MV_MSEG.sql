CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_mseg (mandant_id, mblnr, mblnr_num, zeile, zeile_num,
mblnr_zeile, mjahr, bwart, art_id, grund, werks, nb_id, xauto, lgort, lifnr, ekorg, shkzg, soll_haben_vz, waers, ebeln,
ebelp, ebeln_ebelp, dmbtr, vkwrt, erfme, lgpla, kunnr, menge, lsmng, bpmng, erfmg, wempf, budat, smbln, smblp, sjahr,
sjahr_smbln_smblp, vkwra, mandant_id_kunde, mandant_id_empfaenger, exvkw, betrag_vk_netto_vz, betrag_verkauf_ist_netto,
exvkw_nt, vk_wert_nt, lbkum, salk3, bukrs, shkum, kostl, sakto, ummat, umlgo, matbf, parent_id, line_id, elikz, xruem,
exbwr, bnbtr, dmbum) AS SELECT a.mandant_id,
 a.mblnr,
 a.mblnr_num,
 a.zeile,
 a.zeile_num,
 a.mblnr_zeile,
 a.mjahr,
 a.bwart,
 a.art_id,
 a.grund,
 a.werks,
 a.nb_id,
 a.xauto,
 a.lgort,
 a.lifnr,
 a.ekorg,
 a.shkzg,
 a.soll_haben_vz,
 a.waers,
 a.ebeln,
 a.ebelp,
 a.ebeln_ebelp,
 a.dmbtr,
 a.vkwrt,
 a.erfme,
 a.lgpla,
 a.kunnr,
 a.menge,
 a.lsmng,
 a.bpmng,
 a.erfmg,
 a.wempf,
 a.budat,
 a.smbln,
 a.smblp,
 a.sjahr,
 a.sjahr_smbln_smblp,
 a.vkwra,
 a.mandant_id_kunde,
 a.mandant_id_empfaenger,
 a.exvkw,
 a.betrag_vk_netto_vz,
 a.betrag_verkauf_ist_netto,
 a.exvkw_nt,
 a.vk_wert_nt,
 a.lbkum,
 a.salk3,
 a.bukrs,
 a.shkum,
 a.kostl,
 a.sakto,
 a.ummat,
 a.umlgo,
 a.matbf,
 a.parent_id,
 a.line_id,
 a.elikz,
 a.xruem,
 a.exbwr,
 a.bnbtr,
 a.dmbum
FROM (SELECT V01.mandant_id,
   TRIM(CAST(V01.lagerbew_beleg_id AS STRING FORMAT '0000000000')) AS mblnr,
   V01.lagerbew_beleg_id AS mblnr_num,
   TRIM(CAST(V01.lagerbew_beleg_pos_id AS STRING FORMAT '0000')) AS zeile,
   V01.lagerbew_beleg_pos_id AS zeile_num,
     TRIM(CAST(V01.lagerbew_beleg_id AS STRING FORMAT '0000000000')) || ' ' || TRIM(CAST(V01.lagerbew_beleg_pos_id AS STRING FORMAT '0000')
     ) AS mblnr_zeile,
   V01.kj AS mjahr,
   V01.lager_bewart_id AS bwart,
   V01.art_id,
   SUBSTR(CAST(V01.grund_id AS STRING), 1, 10) AS grund,
   V01.wup_id AS werks,
   V01.nb_id,
   V01.auto_fg AS xauto,
   V01.lagerort_id AS lgort,
   V01.gp_id AS lifnr,
   V01.einkaufsorganisation_id AS ekorg,
   V01.soll_haben_kz AS shkzg,
    CASE
    WHEN V01.soll_haben_kz = 'H'
    THEN - 1
    ELSE 1
    END AS soll_haben_vz,
   V01.wrg_id AS waers,
   V01.best_beleg_id AS ebeln,
   V01.best_beleg_pos_id AS ebelp,
     TRIM(CAST(V01.best_beleg_id AS STRING FORMAT '0000000000')) || ' ' || TRIM(CAST(V01.best_beleg_pos_id AS STRING FORMAT '0000')
     ) AS ebeln_ebelp,
   V01.betrag_lagerbew AS dmbtr,
   V01.betrag_verkauf AS vkwrt,
   SUBSTR(CAST(V01.erfsngs_menge_einh_id AS STRING), 1, 3) AS erfme,
   V01.lagerplatz_id AS lgpla,
   V01.kunde_id AS kunnr,
   V01.menge_lagerbew_bme AS menge,
   V01.menge_lieferschein AS lsmng,
   V01.menge_lief AS bpmng,
   V01.menge_erf AS erfmg,
   V01.empfaenger_id AS wempf,
   V01.dat_buch AS budat,
   V01.lagerbew_beleg_storno_id AS smbln,
   V01.lagerbew_beleg_pos_storno_id AS smblp,
   V01.lagerbew_beleg_storno_kj AS sjahr,
       TRIM(CAST(V01.lagerbew_beleg_storno_kj AS STRING FORMAT '0000')) || ' ' || TRIM(CAST(V01.lagerbew_beleg_storno_id AS STRING FORMAT '0000000000')
       ) || ' ' || TRIM(CAST(V01.lagerbew_beleg_pos_storno_id AS STRING FORMAT '0000')) AS sjahr_smbln_smblp,
   V01.betrag_vk_netto AS vkwra,
   V01.mandant_id_kunde,
   V01.mandant_id_empfaenger,
   V01.betrag_verkauf_ist AS exvkw,
   V01.betrag_vk_netto_vz,
   V01.betrag_verkauf_ist_netto,
    CASE
    WHEN V01.betrag_verkauf_ist = V01.betrag_verkauf
    THEN V01.betrag_vk_netto
    ELSE V01.betrag_verkauf_ist_netto
    END AS exvkw_nt,
    CASE
    WHEN V01.lager_bewart_id IN ('251', '252') AND V01.betrag_verkauf_ist = V01.betrag_verkauf
    THEN V01.betrag_vk_netto
    WHEN V01.lager_bewart_id IN ('251', '252') AND V01.betrag_verkauf_ist <> V01.betrag_verkauf
    THEN V01.betrag_verkauf_ist_netto
    WHEN V01.lager_bewart_id NOT IN ('251', '252')
    THEN V01.betrag_vk_netto
    ELSE 0
    END AS vk_wert_nt,
   V02.menge_bestand_bme AS lbkum,
   V02.wert_bestand AS salk3,
   V02.buchungskreis_id AS bukrs,
   V02.shkum,
   V02.kostenstelle_id AS kostl,
   V02.sachkonto_id AS sakto,
   V02.art_id_empfaenger AS ummat,
   V02.lagerort_id_empfaenger AS umlgo,
   V02.art_id_bf AS matbf,
   V02.lagerbew_beleg_pos_mutter_id AS parent_id,
   V02.line_id,
    CASE
    WHEN V02.endlief_fg = 0
    THEN ''
    WHEN V02.endlief_fg = 1
    THEN 'X'
    ELSE CAST(V02.endlief_fg AS STRING)
    END AS elikz,
    CASE
    WHEN V02.xruem_fg = 0
    THEN ''
    WHEN V02.xruem_fg = 1
    THEN 'X'
    ELSE CAST(V02.xruem_fg AS STRING)
    END AS xruem,
   V02.betrag_exbwr AS exbwr,
   V02.betrag_bnk AS bnbtr,
   V02.betrag_umbewertung AS dmbum
  FROM kfl_production_dbp_view.v_lagerbew_det AS V01
   INNER JOIN kfl_production_dbp_view.v_lagerbew_det_wwc AS V02 ON V01.mandant_id = V02.mandant_id AND V01.lagerbew_beleg_id
         = V02.lagerbew_beleg_id AND V01.lagerbew_beleg_pos_id = V02.lagerbew_beleg_pos_id AND V01.kj = V02.kj AND V01.dat_buch
      = V02.dat_buch
   INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
            AND (V03.mandant_id NOT IN (1, 7) OR V03.mandant_id IN (1, 7) AND TRIM(CAST(V03.wg_id AS STRING FORMAT '000')
               ) || TRIM(CAST(V03.wug_id AS STRING FORMAT '000')) <> '969006') AND (V03.mandant_id <> 7 OR V03.mandant_id
             = 7 AND TRIM(CAST(V03.wg_id AS STRING FORMAT '000')) <> '980') AND V03.wg_id <> 961 AND (V03.mandant_id
         NOT IN (2, 3, 4, 5, 6, 7, 8) OR V03.mandant_id IN (2, 3, 4, 5, 6, 7, 8) AND TRIM(CAST(V03.wg_id AS STRING FORMAT '000')
            ) || TRIM(CAST(V03.wug_id AS STRING FORMAT '000')) NOT IN ('969001', '969002', '969003', '969004')) AND V03
      .arthiertyp_id = 2 AND V03.dat_bis = DATE '9999-12-31') AS a
 LEFT JOIN kfl_production_dbp_view.v_lagerbew_det_delta AS B ON a.mandant_id = B.mandant_id AND CAST(a.mblnr AS FLOAT64)
      = B.lagerbew_beleg_id AND CAST(a.zeile AS FLOAT64) = B.lagerbew_beleg_pos_id AND a.mjahr = B.kj AND a.budat = B.dat_buch
   
WHERE B.mandant_id IS NULL
UNION ALL
SELECT mandant_id,
 TRIM(CAST(lagerbew_beleg_id AS STRING FORMAT '0000000000')) AS mblnr,
 lagerbew_beleg_id AS mblnr_num,
 TRIM(CAST(lagerbew_beleg_pos_id AS STRING FORMAT '0000')) AS zeile,
 lagerbew_beleg_pos_id AS zeile_num,
   TRIM(CAST(lagerbew_beleg_id AS STRING FORMAT '0000000000')) || ' ' || TRIM(CAST(lagerbew_beleg_pos_id AS STRING FORMAT '0000')
   ) AS mblnr_zeile,
 kj AS mjahr,
 lager_bewart_id AS bwart,
 art_id,
 SUBSTR(CAST(grund_id AS STRING), 1, 10) AS grund,
 wup_id AS werks,
 nb_id,
 auto_fg AS xauto,
 lagerort_id AS lgort,
 gp_id AS lifnr,
 einkaufsorganisation_id AS ekorg,
 soll_haben_kz AS shkzg,
  CASE
  WHEN soll_haben_kz = 'H'
  THEN - 1
  ELSE 1
  END AS soll_haben_vz,
 wrg_id AS waers,
 best_beleg_id AS ebeln,
 best_beleg_pos_id AS ebelp,
   TRIM(CAST(best_beleg_id AS STRING FORMAT '0000000000')) || ' ' || TRIM(CAST(best_beleg_pos_id AS STRING FORMAT '0000')
   ) AS ebeln_ebelp,
 betrag_lagerbew AS dmbtr,
 betrag_verkauf AS vkwrt,
 SUBSTR(CAST(erfsngs_menge_einh_id AS STRING), 1, 3) AS erfme,
 lagerplatz_id AS lgpla,
 kunde_id AS kunnr,
 menge_lagerbew_bme AS menge,
 menge_lieferschein AS lsmng,
 menge_lief AS bpmng,
 menge_erf AS erfmg,
 empfaenger_id AS wempf,
 dat_buch AS budat,
 lagerbew_beleg_storno_id AS smbln,
 lagerbew_beleg_pos_storno_id AS smblp,
 lagerbew_beleg_storno_kj AS sjahr,
     CAST(lagerbew_beleg_storno_kj AS STRING FORMAT '0000') || ' ' || TRIM(CAST(lagerbew_beleg_storno_id AS STRING FORMAT '0000000000')
     ) || ' ' || TRIM(CAST(lagerbew_beleg_pos_storno_id AS STRING FORMAT '0000')) AS sjahr_smbln_smblp,
 betrag_vk_netto AS vkwra,
 mandant_id_kunde,
 mandant_id_empfaenger,
 betrag_verkauf_ist AS exvkw,
 betrag_vk_netto_vz,
 betrag_verkauf_ist_netto,
  CASE
  WHEN betrag_verkauf_ist = betrag_verkauf
  THEN betrag_vk_netto
  ELSE betrag_verkauf_ist_netto
  END AS exvkw_nt,
  CASE
  WHEN lager_bewart_id IN ('251', '252') AND betrag_verkauf_ist = betrag_verkauf
  THEN betrag_vk_netto
  WHEN lager_bewart_id IN ('251', '252') AND betrag_verkauf_ist <> betrag_verkauf
  THEN betrag_verkauf_ist_netto
  WHEN lager_bewart_id NOT IN ('251', '252')
  THEN betrag_vk_netto
  ELSE 0
  END AS vk_wert_nt,
 menge_bestand_bme AS lbkum,
 wert_bestand AS salk3,
 buchungskreis_id AS bukrs,
 shkum,
 kostenstelle_id AS kostl,
 sachkonto_id AS sakto,
 art_id_empfaenger AS ummat,
 lagerort_id_empfaenger AS umlgo,
 art_id_bf AS matbf,
 lagerbew_beleg_pos_mutter_id AS parent_id,
 line_id,
  CASE
  WHEN endlief_fg = 0
  THEN ''
  WHEN endlief_fg = 1
  THEN 'X'
  ELSE CAST(endlief_fg AS STRING)
  END AS elikz,
  CASE
  WHEN xruem_fg = 0
  THEN ''
  WHEN xruem_fg = 1
  THEN 'X'
  ELSE CAST(xruem_fg AS STRING)
  END AS xruem,
 betrag_exbwr AS exbwr,
 betrag_bnk AS bnbtr,
 betrag_umbewertung AS dmbum
FROM kfl_production_dbp_view.v_lagerbew_det_delta;