CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_facility_mng_kpi_dossier_2 (USERID STRING) AS SELECT iw.mandant_id,
 iw.wup_id,
 iw.werk_id,
 T.dat AS dat_buch,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez IN ('HRL Food / NF', 'HRL Food/NF') AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND
        ist_kost.soll_haben_kz = 'S' AND ist_kost.auftragsart_id IN ('CS56', 'CS55', 'CS57') AND betrag.betrag >= 0 AND
     COALESCE(in_auf_rm.storno_fg, 0) = 0
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_hrl_food,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez IN ('HRL Food / NF', 'HRL Food/NF') AND ist_kost.soll_haben_kz = 'S' AND ist_kost.auftragsart_id
      IN ('CS37', 'CS47', 'CS57', 'CS77')
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_hrl_food_fremd,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez = 'HRL Tiko' AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND ist_kost.soll_haben_kz = 'S'
         AND ist_kost.auftragsart_id IN ('CS56', 'CS55', 'CS57') AND betrag.betrag >= 0 AND COALESCE(in_auf_rm.storno_fg
      , 0) = 0
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_hrl_tiko,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez = 'HRL Tiko' AND ist_kost.soll_haben_kz = 'S' AND ist_kost.auftragsart_id IN ('CS37',
      'CS47', 'CS57', 'CS77')
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_hrl_tiko_fremd,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez IN ('AHL Food / NF', 'AHL Food/NF') AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND
        ist_kost.soll_haben_kz = 'S' AND ist_kost.auftragsart_id IN ('CS56', 'CS55', 'CS57') AND betrag.betrag >= 0 AND
     COALESCE(in_auf_rm.storno_fg, 0) = 0
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_ahl_food,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez IN ('AHL Food / NF', 'AHL Food/NF') AND ist_kost.soll_haben_kz = 'S' AND ist_kost.auftragsart_id
      IN ('CS37', 'CS47', 'CS57', 'CS77')
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_ahl_food_fremd,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez IN ('AKL Food / NF', 'AKL Food/NF') AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND
        ist_kost.soll_haben_kz = 'S' AND ist_kost.auftragsart_id IN ('CS56', 'CS55', 'CS57') AND betrag.betrag >= 0 AND
     COALESCE(in_auf_rm.storno_fg, 0) = 0
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_akl_food,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez IN ('AKL Food / NF', 'AKL Food/NF') AND ist_kost.soll_haben_kz = 'S' AND ist_kost.auftragsart_id
      IN ('CS37', 'CS47', 'CS57', 'CS77')
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_akl_food_fremd,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez IN ('AKA Food / NF', 'AKA Food/NF') AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND
        ist_kost.soll_haben_kz = 'S' AND ist_kost.auftragsart_id IN ('CS56', 'CS55', 'CS57') AND betrag.betrag >= 0 AND
     COALESCE(in_auf_rm.storno_fg, 0) = 0
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_aka_food,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez IN ('AKA Food / NF', 'AKA Food/NF') AND ist_kost.soll_haben_kz = 'S' AND ist_kost.auftragsart_id
      IN ('CS37', 'CS47', 'CS57', 'CS77')
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_aka_food_fremd,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez = 'AKL Frische' AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND ist_kost.soll_haben_kz =
        'S' AND ist_kost.auftragsart_id IN ('CS56', 'CS55', 'CS57') AND betrag.betrag >= 0 AND COALESCE(in_auf_rm.storno_fg
      , 0) = 0
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_akl_frische,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez = 'AKL Frische' AND ist_kost.soll_haben_kz = 'S' AND ist_kost.auftragsart_id IN ('CS37',
      'CS47', 'CS57', 'CS77')
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_akl_frische_fremd,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez = 'AKA O&G' AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND ist_kost.soll_haben_kz = 'S'
      AND ist_kost.auftragsart_id IN ('CS56', 'CS55', 'CS57') AND betrag.betrag >= 0 AND COALESCE(in_auf_rm.storno_fg, 0
      ) = 0
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_aka_og,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez = 'AKA O&G' AND ist_kost.soll_haben_kz = 'S' AND ist_kost.auftragsart_id IN ('CS37', 'CS47'
      , 'CS57', 'CS77')
   THEN CASE
    WHEN M_WRG.wrg_typ_id = 0
    THEN ist_kost.betrag * KURS.umrechnungskurs
    ELSE ist_kost.betrag
    END
   ELSE NULL
   END) AS instandhaltungskosten_aka_og_fremd,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez IN ('HRL Food / NF', 'HRL Food/NF') AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND
       ist_kost.soll_haben_kz = 'S' AND ist_kost.co_leistungsart_id IN ('INST01', 'INST02', 'INST03', 'INST04', 'INST05'
       , 'INST06', 'INST07', 'INST08', 'INST09', 'INST10', 'INST70', 'INST71', 'INST72', 'INST73', 'INST74', 'INST75',
       'INST76', 'INST88') AND ist_kost.auftragsart_id IN ('CS36', 'CS46', 'CS56', 'CS76', 'CS34', 'CS35', 'CS44',
      'CS45', 'CS54', 'CS55')
   THEN ist_kost.menge
   ELSE NULL
   END) AS instandhaltung_stunden_hrl_food,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez = 'HRL Tiko' AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND ist_kost.soll_haben_kz = 'S'
        AND ist_kost.co_leistungsart_id IN ('INST01', 'INST02', 'INST03', 'INST04', 'INST05', 'INST06', 'INST07',
       'INST08', 'INST09', 'INST10', 'INST70', 'INST71', 'INST72', 'INST73', 'INST74', 'INST75', 'INST76', 'INST88') AND
     ist_kost.auftragsart_id IN ('CS36', 'CS46', 'CS56', 'CS76', 'CS34', 'CS35', 'CS44', 'CS45', 'CS54', 'CS55')
   THEN ist_kost.menge
   ELSE NULL
   END) AS instandhaltung_stunden_hrl_tiko,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez IN ('AHL Food / NF', 'AHL Food/NF') AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND
       ist_kost.soll_haben_kz = 'S' AND ist_kost.co_leistungsart_id IN ('INST01', 'INST02', 'INST03', 'INST04', 'INST05'
       , 'INST06', 'INST07', 'INST08', 'INST09', 'INST10', 'INST70', 'INST71', 'INST72', 'INST73', 'INST74', 'INST75',
       'INST76', 'INST88') AND ist_kost.auftragsart_id IN ('CS36', 'CS46', 'CS56', 'CS76', 'CS34', 'CS35', 'CS44',
      'CS45', 'CS54', 'CS55')
   THEN ist_kost.menge
   ELSE NULL
   END) AS instandhaltung_stunden_ahl_food,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez IN ('AKL Food / NF', 'AKL Food/NF') AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND
       ist_kost.soll_haben_kz = 'S' AND ist_kost.co_leistungsart_id IN ('INST01', 'INST02', 'INST03', 'INST04', 'INST05'
       , 'INST06', 'INST07', 'INST08', 'INST09', 'INST10', 'INST70', 'INST71', 'INST72', 'INST73', 'INST74', 'INST75',
       'INST76', 'INST88') AND ist_kost.auftragsart_id IN ('CS36', 'CS46', 'CS56', 'CS76', 'CS34', 'CS35', 'CS44',
      'CS45', 'CS54', 'CS55')
   THEN ist_kost.menge
   ELSE NULL
   END) AS instandhaltung_stunden_akl_food,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez IN ('AKA Food / NF', 'AKA Food/NF') AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND
       ist_kost.soll_haben_kz = 'S' AND ist_kost.co_leistungsart_id IN ('INST01', 'INST02', 'INST03', 'INST04', 'INST05'
       , 'INST06', 'INST07', 'INST08', 'INST09', 'INST10', 'INST70', 'INST71', 'INST72', 'INST73', 'INST74', 'INST75',
       'INST76', 'INST88') AND ist_kost.auftragsart_id IN ('CS36', 'CS46', 'CS56', 'CS76', 'CS34', 'CS35', 'CS44',
      'CS45', 'CS54', 'CS55')
   THEN ist_kost.menge
   ELSE NULL
   END) AS instandhaltung_stunden_aka_food,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez = 'AKL Frische' AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND ist_kost.soll_haben_kz =
       'S' AND ist_kost.co_leistungsart_id IN ('INST01', 'INST02', 'INST03', 'INST04', 'INST05', 'INST06', 'INST07',
       'INST08', 'INST09', 'INST10', 'INST70', 'INST71', 'INST72', 'INST73', 'INST74', 'INST75', 'INST76', 'INST88') AND
     ist_kost.auftragsart_id IN ('CS36', 'CS46', 'CS56', 'CS76', 'CS34', 'CS35', 'CS44', 'CS45', 'CS54', 'CS55')
   THEN ist_kost.menge
   ELSE NULL
   END) AS instandhaltung_stunden_akl_frische,
 SUM(CASE
   WHEN TP_O_INFO.anlage_bez = 'AKA O&G' AND ist_kost.nebenkontierungsart_id <> 'OCCT' AND ist_kost.soll_haben_kz = 'S'
     AND ist_kost.co_leistungsart_id IN ('INST01', 'INST02', 'INST03', 'INST04', 'INST05', 'INST06', 'INST07', 'INST08'
       , 'INST09', 'INST10', 'INST70', 'INST71', 'INST72', 'INST73', 'INST74', 'INST75', 'INST76', 'INST88') AND
     ist_kost.auftragsart_id IN ('CS36', 'CS46', 'CS56', 'CS76', 'CS34', 'CS35', 'CS44', 'CS45', 'CS54', 'CS55')
   THEN ist_kost.menge
   ELSE NULL
   END) AS instandhaltung_stunden_aka_og,
  MAX(COALESCE(tr_auf.hrl_anz_paletten_we, 0)) + MAX(COALESCE(lag_we.hrl_anz_paletten_we_ewm, 0)) AS
 hrl_anzahl_paletten_we_both,
  MAX(COALESCE(lag_we.ahl_anz_paletten_we_ewm, 0)) + MAX(COALESCE(tr_auf.ahl_anz_paletten_we, 0)) AS
 ahl_anzahl_paletten_we_both,
  MAX(COALESCE(bl_wg_wup.akl_menge_lief_ist_kolli, 0)) + MAX(COALESCE(bl_wa_hu_sum.akl_menge_lief_ist_kolli_ewm, 0)) AS
 akl_menge_lief_ist_kolli_both,
 MAX(bl_wa_hu_sum.aka_food_menge_lief_ist_kolli_ewm) AS aka_food_menge_lief_ist_kolli_both,
  MAX(COALESCE(lag.akl_anz_kolli_wa, 0)) + MAX(COALESCE(tr_auf.akl_anz_kolli_wa, 0)) AS frische_akl_anz_kolli_wa_both,
  MAX(COALESCE(bl_wa_hu_sum.aka_menge_lief_ist_kolli, 0)) + MAX(COALESCE(bl_wg_wup.aka_menge_lief_ist_kolli, 0)) AS
 aka_menge_lief_ist_kolli_both,
  MAX(COALESCE(lag_we.hrl_tiko_anz_paletten_we_ewm, 0)) + MAX(COALESCE(tr_auf.hrl_tiko_anz_paletten_we, 0)) AS
 hrl_tiko_anzahl_paletten_we_both
FROM (SELECT DISTINCT w.mandant_id,
   w.wup_id,
   TPP.werk_instandhaltung_plan AS in_werk_nr,
   W_ID.werk_id,
   w.lagernummer_id_ewm
  FROM kfl_production_dbp_data.techn_platz_per_2 AS TPP
   INNER JOIN (SELECT mandant_id,
     wup_id,
     MAX(CASE
       WHEN ewm_fg = 1
       THEN lagernummer_id
       ELSE NULL
       END) AS lagernummer_id_ewm
    FROM kfl_production_dbp_data.l_lagernummer_2
    GROUP BY mandant_id,
     wup_id) AS w ON TPP.mandant_id = w.mandant_id AND TPP.wup_id = w.wup_id
   INNER JOIN kfl_production_dbp_view.v_in_werk_2 AS W_ID ON TPP.werk_instandhaltung_plan = W_ID.werk_nr AND TPP.mandant_id
      = W_ID.mandant_id
  WHERE TPP.dat_bis >= DATE_SUB(CURRENT_DATE, INTERVAL 730 DAY)
   AND TPP.nb_id = -111
   AND TPP.techn_platz_typ_id IN ('3', '4', '5', '7')
   AND ROUND(SAFE_CAST(TPP.werk_instandhaltung_plan AS BIGNUMERIC), 0) IS NULL
   AND TPP.werk_instandhaltung_plan IS NOT NULL
   AND ROUND(SAFE_CAST(RIGHT(TPP.werk_instandhaltung_plan, 2) AS BIGNUMERIC), 0) >= 60
   AND TPP.wup_id <> 6921
  ORDER BY 1 NULLS LAST,
   2 NULLS LAST,
   3 NULLS LAST) AS iw
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS T ON EXTRACT(YEAR FROM T.dat) BETWEEN EXTRACT(YEAR FROM CURRENT_TIMESTAMP()
     ) - 2 AND (EXTRACT(YEAR FROM CURRENT_TIMESTAMP())) AND LEFT(iw.in_werk_nr, 2) IN ('DE', 'CZ', 'PL', 'SK', 'HR',
    'RO', 'BG')
 LEFT JOIN (SELECT T1.nebenkontierungsart_id,
   T1.soll_haben_kz,
   T1.dat_buch,
   T1.mandant_id,
   T1.auftrag_id,
   T1.wrg_id,
   T1.co_leistungsart_id,
   T1.betrag,
   T1.menge,
   T2.werk_id,
   T2.auftragsart_id
  FROM kfl_production_dbp_view.v_ist_kosten_det_2 AS T1_2
   INNER JOIN kfl_production_dbp_view.v_in_auftrag_2 AS T2 ON T1.mandant_id = T2.mandant_id AND T1.auftrag_id = T2.auftrag_id
     ) AS ist_kost ON T.dat = ist_kost.dat_buch AND iw.mandant_id = ist_kost.mandant_id AND iw.werk_id = ist_kost.werk_id
   
 LEFT JOIN (SELECT mandant_id,
   auftrag_id,
   dat_buch,
   SUM(betrag) AS betrag
  FROM kfl_production_dbp_view.v_ist_kosten_det_2
  WHERE nebenkontierungsart_id <> 'OCCT'
   AND soll_haben_kz = 'S'
   AND EXTRACT(YEAR FROM dat_buch) BETWEEN EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2 AND (EXTRACT(YEAR FROM
      CURRENT_TIMESTAMP()))
  GROUP BY mandant_id,
   auftrag_id,
   dat_buch) AS betrag ON ist_kost.mandant_id = betrag.mandant_id AND ist_kost.auftrag_id = betrag.auftrag_id AND
   ist_kost.dat_buch = betrag.dat_buch
 LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_2 AS KURS_2 ON ist_kost.wrg_id = KURS.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS M_WRG ON iw.mandant_id = M_WRG.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS AKT_USER ON M_WRG.wrg_typ_id = AKT_USER.wrg_typ_id
  
 LEFT JOIN (SELECT DISTINCT auftrag_id,
   mandant_id,
   storno_fg,
   dat_buch
  FROM kfl_production_dbp_view.v_in_auftrag_rm_2
  WHERE EXTRACT(YEAR FROM dat_buch) BETWEEN EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2 AND (EXTRACT(YEAR FROM
      CURRENT_TIMESTAMP()))) AS in_auf_rm ON ist_kost.auftrag_id = in_auf_rm.auftrag_id AND ist_kost.mandant_id =
    in_auf_rm.mandant_id AND ist_kost.dat_buch = in_auf_rm.dat_buch
 LEFT JOIN kfl_production_dbp_view.v_in_instandhaltung_objekt_qual_2 AS IN_OBJ_Q ON ist_kost.auftrag_id = IN_OBJ_Q.auftrag_id
    AND ist_kost.mandant_id = IN_OBJ_Q.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_log.v_ts_tp_objekt_info_2 AS TP_O_INFO ON IN_OBJ_Q.tp_objekt_id = TP_O_INFO.tp_objekt_id
    AND IN_OBJ_Q.mandant_id = TP_O_INFO.mandant_id
 LEFT JOIN (SELECT TR_DET.wup_id,
   TR_DET.mandant_id,
   TR_DET.dat_quittierung,
   SUM(CASE
     WHEN TR_DET.von_lagertyp_id = 'IP1' AND TR_DET.nach_lagertyp_id IN ('H01', 'HEB', 'HEP') AND CAST(SORT.artikelsortiment_id AS FLOAT64)
       = 1
     THEN 1
     ELSE 0
     END) AS hrl_anz_paletten_we,
   SUM(CASE
     WHEN TR_DET.von_lagertyp_id = 'BF1' AND TR_DET.nach_lagertyp_id IN ('IHL')
     THEN 1
     ELSE 0
     END) AS ahl_anz_paletten_we,
   SUM(CASE
     WHEN TR_DET.von_lagertyp_id = 'IP1' AND TR_DET.nach_lagertyp_id IN ('H01', 'HEB', 'HEP') AND CAST(SORT.artikelsortiment_id AS FLOAT64)
       = 4
     THEN 1
     ELSE 0
     END) AS hrl_tiko_anz_paletten_we,
   SUM(CASE
     WHEN TR_DET.von_lagertyp_id = 'G08' AND TR_DET.nach_lagertyp_id = '916'
     THEN TR_DET.menge_transportauftrag_kolli
     ELSE 0
     END) AS akl_anz_kolli_wa,
   SUM(CASE
     WHEN TR_DET.von_lagertyp_id = 'UP1' AND TR_DET.nach_lagertyp_id = 'IT1'
     THEN TR_DET.menge_transportauftrag_kolli
     ELSE 0
     END) AS hrl_tiko_anz_kolli_we
  FROM kfl_production_dbp_view.v_transportauftrag_det_2 AS TR_DET
   INNER JOIN kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm_2 AS SORT ON TR_DET.mandant_id = SORT.mandant_id
        AND TR_DET.wup_id = SORT.wup_id AND TR_DET.lagernummer_id = SORT.lagernummer_id AND TR_DET.nb_id = SORT.nb_id
  WHERE EXTRACT(YEAR FROM TR_DET.dat_quittierung) BETWEEN EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2 AND (EXTRACT(YEAR
      FROM CURRENT_TIMESTAMP()))
  GROUP BY TR_DET.wup_id,
   TR_DET.mandant_id,
   TR_DET.dat_quittierung) AS tr_auf ON iw.wup_id = tr_auf.wup_id AND iw.mandant_id = tr_auf.mandant_id AND T.dat =
   tr_auf.dat_quittierung
 LEFT JOIN (SELECT ORDIM_C.lagernummer_id,
   ORDIM_C.mandant_id,
   DATE(ORDIM_C.datzeit_we) AS dat_we,
   SUM(CASE
     WHEN ORDIM_C.lagerprozessart_id IN ('0E01', '0E02', '0E03') AND ORDIM_C.status_id = 'C' AND CAST(CASE
          WHEN ROLLB.lageraufgabe_id IS NOT NULL
          THEN 1
          ELSE 0
          END AS STRING) = '0' AND ORDIM_C.lagertyp_id_nach IN ('1IHP', '5IHP')
     THEN 1
     ELSE 0
     END) AS hrl_anz_paletten_we_ewm,
   SUM(CASE
     WHEN ORDIM_C.lagerprozessart_id IN ('0E01', '0E02', '0E03') AND ORDIM_C.status_id = 'C' AND CAST(CASE
          WHEN ROLLB.lageraufgabe_id IS NOT NULL
          THEN 1
          ELSE 0
          END AS STRING) = '0' AND ORDIM_C.lagertyp_id_nach IN ('4IHP', '4IAP')
     THEN 1
     ELSE 0
     END) AS hrl_tiko_anz_paletten_we_ewm,
   SUM(CASE
     WHEN ORDIM_C.lagerprozessart_id IN ('0E01', '0E02', '0E03') AND ORDIM_C.status_id = 'C' AND CAST(CASE
          WHEN ROLLB.lageraufgabe_id IS NOT NULL
          THEN 1
          ELSE 0
          END AS STRING) = '0' AND ORDIM_C.lagertyp_id_nach IN ('1ILP')
     THEN 1
     ELSE 0
     END) AS ahl_anz_paletten_we_ewm
  FROM kfl_production_dbp_view.v_lageraufgabe_2 AS ORDIM_C
   LEFT JOIN kfl_production_dbp_view.v_lageraufgabe_2 AS ROLLB ON ORDIM_C.mandant_id = ROLLB.mandant_id AND ORDIM_C.handling_unit_guid_nach
         = ROLLB.handling_unit_guid_nach AND ROLLB.lagerprozessart_id = '0E01' AND ROLLB.lagerprozesstyp_id = '5' AND
     ROLLB.status_id = 'A'
  WHERE EXTRACT(YEAR FROM ORDIM_C.datzeit_we) BETWEEN EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2 AND (EXTRACT(YEAR FROM
      CURRENT_TIMESTAMP()))
  GROUP BY ORDIM_C.lagernummer_id,
   ORDIM_C.mandant_id,
   dat_we) AS lag_we ON iw.lagernummer_id_ewm = lag_we.lagernummer_id AND iw.mandant_id = lag_we.mandant_id AND T.dat =
   lag_we.dat_we
 LEFT JOIN (SELECT lagernummer_id,
   mandant_id,
   DATE(datzeit_quittierung) AS dat_quittierung,
   SUM(menge_kolli) AS akl_anz_kolli_wa
  FROM kfl_production_dbp_view.v_lageraufgabe_2 AS ORDIM_C
  WHERE lagertyp_id_von = '3GAB'
   AND EXTRACT(YEAR FROM datzeit_quittierung) BETWEEN EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2 AND (EXTRACT(YEAR FROM
      CURRENT_TIMESTAMP()))
  GROUP BY lagernummer_id,
   mandant_id,
   dat_quittierung) AS lag ON iw.lagernummer_id_ewm = lag.lagernummer_id AND iw.mandant_id = lag.mandant_id AND T.dat =
   lag.dat_quittierung
 LEFT JOIN (SELECT BL_WG_WUP.wup_id,
   BL_WG_WUP.mandant_id,
   BL_WG_WUP.dat_lief_soll,
   SUM(CASE
     WHEN BL_WG_WUP.lief_pal_typ_id = '7' AND BL_WG_WUP.lief_typ_id IN ('YM', 'YU', 'YNOT', 'NL', 'ZLFI', 'ZLCC')
     THEN BL_WG_WUP.menge_lief_ist_kolli
     ELSE 0
     END) AS akl_menge_lief_ist_kolli,
   SUM(CASE
     WHEN BL_WG_WUP.lief_pal_typ_id = '8' AND BL_WG_WUP.lief_typ_id IN ('YM', 'YU', 'YNOT', 'NL', 'ZLFI', 'ZLCC')
     THEN BL_WG_WUP.menge_lief_ist_kolli
     ELSE 0
     END) AS aka_menge_lief_ist_kolli
  FROM kfl_production_dbp_view.v_besch_lief_wg_wup_2 AS BL_WG_WUP
   LEFT JOIN kfl_production_dbp_msi_data.ts_lagerort_ewm_dat_2 AS V06 ON BL_WG_WUP.mandant_id = V06.mandant_id AND
      BL_WG_WUP.wup_id = V06.wup_id AND BL_WG_WUP.lagerort_id = V06.lagerort_id
  WHERE (V06.mandant_id IS NULL OR BL_WG_WUP.dat_lief_soll < V06.dat)
   AND EXTRACT(YEAR FROM BL_WG_WUP.dat_lief_soll) BETWEEN EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2 AND (EXTRACT(YEAR
      FROM CURRENT_TIMESTAMP()))
  GROUP BY BL_WG_WUP.wup_id,
   BL_WG_WUP.mandant_id,
   BL_WG_WUP.dat_lief_soll) AS bl_wg_wup ON iw.wup_id = bl_wg_wup.wup_id AND iw.mandant_id = bl_wg_wup.mandant_id AND T
   .dat = bl_wg_wup.dat_lief_soll
 LEFT JOIN (SELECT BL_WA_HU_SUM.wup_id,
   BL_WA_HU_SUM.mandant_id,
   BL_WA_HU_SUM.dat_lief_soll,
   SUM(CASE
     WHEN BL_WA_HU_SUM.lief_pal_typ_id = '7' AND BL_WA_HU_SUM.lief_typ_id IN ('YM', 'YU', 'YNOT', 'NL', 'ZLFI', 'ZLCC')
     THEN BL_WA_HU_SUM.menge_lief_ist_kolli
     ELSE 0
     END) AS akl_menge_lief_ist_kolli_ewm,
   SUM(CASE
     WHEN BL_WA_HU_SUM.lief_pal_typ_id = 'J' AND BL_WA_HU_SUM.lief_typ_id IN ('YM', 'YU', 'YNOT', 'NL', 'ZLFI', 'ZLCC')
     THEN BL_WA_HU_SUM.menge_lief_ist_kolli
     ELSE 0
     END) AS aka_food_menge_lief_ist_kolli_ewm,
   SUM(CASE
     WHEN BL_WA_HU_SUM.lief_pal_typ_id = '8' AND BL_WA_HU_SUM.lief_typ_id IN ('YM', 'YU', 'YNOT', 'NL', 'ZLFI', 'ZLCC')
     THEN BL_WA_HU_SUM.menge_lief_ist_kolli
     ELSE 0
     END) AS aka_menge_lief_ist_kolli
  FROM kfl_production_dbp_view.v_besch_lief_wa_hu_sum_2 AS BL_WA_HU_SUM
   LEFT JOIN kfl_production_dbp_msi_data.ts_lagerort_ewm_dat_2 AS V060 ON BL_WA_HU_SUM.mandant_id = V060.mandant_id AND
      BL_WA_HU_SUM.wup_id = V060.wup_id AND BL_WA_HU_SUM.lagerort_id = V060.lagerort_id
  WHERE (V060.mandant_id IS NOT NULL OR BL_WA_HU_SUM.dat_lief_soll >= V060.dat)
   AND EXTRACT(YEAR FROM BL_WA_HU_SUM.dat_lief_soll) BETWEEN EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2 AND (EXTRACT(YEAR
      FROM CURRENT_TIMESTAMP()))
  GROUP BY BL_WA_HU_SUM.wup_id,
   BL_WA_HU_SUM.mandant_id,
   BL_WA_HU_SUM.dat_lief_soll) AS bl_wa_hu_sum ON iw.wup_id = bl_wa_hu_sum.wup_id AND iw.mandant_id = bl_wa_hu_sum.mandant_id
     AND T.dat = bl_wa_hu_sum.dat_lief_soll
GROUP BY iw.mandant_id,
 iw.wup_id,
 iw.werk_id,
 dat_buch;
