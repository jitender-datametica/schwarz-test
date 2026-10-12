CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_leergut_wup_tag_1 AS WITH ZEIT_1 AS (SELECT dat
  FROM kfl_production_dbp_msi_view_vis.mv_tag_1
  WHERE akt_gj BETWEEN -1 AND 0), WUP_1 AS (SELECT mandant_id,
   wup_id,
   aktuell_wup_id
  FROM kfl_production_dbp_data.wup_1 AS WUP_1), VIS AS (SELECT DISTINCT V.mandant_id,
   wup.aktuell_wup_id AS wup_id,
   V.dat,
   V.wrg_id
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_fakt_wup_1 AS V
   INNER JOIN ZEIT_1 AS t ON V.dat = t.dat
   INNER JOIN WUP_1 AS wup_1 ON V.mandant_id = wup.mandant_id AND V.wup_id = wup.wup_id
  WHERE V.mandant_id = 1), KRS AS (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_1 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_1 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')), AN AS (SELECT COALESCE(pfand.mandant_id, info.mandant_id) AS
   mandant_id,
   COALESCE(pfand.wup_id, info.wup_id) AS wup_id,
   COALESCE(pfand.dat, info.dat) AS dat,
   COALESCE(pfand.wrg_id, info.wrg_id) AS wrg_id,
   COALESCE(pfand.menge_automat_ew, 0) AS menge_automat_ew,
   COALESCE(pfand.betrag_brutto_automat_ew, 0) AS betrag_brutto_automat_ew,
   COALESCE(pfand.menge_automat_mw, 0) AS menge_automat_mw,
   COALESCE(pfand.betrag_brutto_automat_mw, 0) AS betrag_brutto_automat_mw,
   COALESCE(info.menge_info_ew, 0) AS menge_info_ew,
   COALESCE(info.betrag_brutto_info_ew, 0) AS betrag_brutto_info_ew,
   COALESCE(info.menge_info_mw, 0) AS menge_info_mw,
   COALESCE(info.betrag_brutto_info_mw, 0) AS betrag_brutto_info_mw
  FROM (SELECT EK.mandant_id,
     wup.aktuell_wup_id AS wup_id,
     EK.bon_dat AS dat,
     krs.nach_wrg_id AS wrg_id,
     SUM(CASE
       WHEN EP.plu_gruppe IN ('0000000000200', '0000000000400')
       THEN EP.menge
       ELSE 0
       END) AS menge_automat_ew,
     SUM(CASE
       WHEN EP.plu_gruppe IN ('0000000000200', '0000000000400')
       THEN EP.bon_zeilen_wert * krs.umrechnungskurs
       ELSE 0
       END) AS betrag_brutto_automat_ew,
     SUM(CASE
       WHEN EP.plu_gruppe IN ('0000000000100', '0000000000300')
       THEN EP.menge
       ELSE 0
       END) AS menge_automat_mw,
     SUM(CASE
       WHEN EP.plu_gruppe IN ('0000000000100', '0000000000300')
       THEN EP.bon_zeilen_wert * krs.umrechnungskurs
       ELSE 0
       END) AS betrag_brutto_automat_mw
    FROM kfl_production_dbp_v_ods.v_els_leergut_kopf_1 AS EK
     INNER JOIN kfl_production_dbp_v_ods.v_els_leergut_position_1 AS EP ON EK.mandant_id = EP.mandant_id AND EK.barcode_leergut
        = EP.barcode_leergut
     INNER JOIN KRS AS krs ON EK.wrg_id = krs.von_wrg_id
     INNER JOIN ZEIT_1 AS t ON EK.bon_dat = t.dat
     INNER JOIN WUP_1 AS wup_1 ON EK.mandant_id = wup.mandant_id AND EK.wup_id = wup.wup_id
    WHERE EK.mandant_id = 1
     AND EP.plu_gruppe IN ('0000000000100', '0000000000300', '0000000000200', '0000000000400')
    GROUP BY EK.mandant_id,
     wup_id,
     dat,
     wrg_id) AS pfand
   FULL JOIN (SELECT LEER.mandant_id,
     wup.aktuell_wup_id AS wup_id,
     LEER.bon_dat AS dat,
     krs.nach_wrg_id AS wrg_id,
     SUM(CASE
       WHEN LEER.ean_kasse IS NOT NULL AND LEER.umsatz_brutto / IF(LEER.menge = 0, NULL, LEER.menge) = -0.25
       THEN LEER.menge
       ELSE 0
       END) AS menge_info_ew,
     SUM(CASE
       WHEN LEER.ean_kasse IS NOT NULL AND LEER.umsatz_brutto / IF(LEER.menge = 0, NULL, LEER.menge) = -0.25
       THEN LEER.umsatz_brutto * krs.umrechnungskurs * -1
       ELSE 0
       END) AS betrag_brutto_info_ew,
     SUM(CASE
       WHEN LEER.ean_kasse IS NULL OR LEER.umsatz_brutto / IF(LEER.menge = 0, NULL, LEER.menge) <> -0.25
       THEN LEER.menge
       ELSE 0
       END) AS menge_info_mw,
     SUM(CASE
       WHEN LEER.ean_kasse IS NULL OR LEER.umsatz_brutto / IF(LEER.menge = 0, NULL, LEER.menge) <> -0.25
       THEN LEER.umsatz_brutto * krs.umrechnungskurs * -1
       ELSE 0
       END) AS betrag_brutto_info_mw
    FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_1 AS K
     INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_leergut_1 AS LEER ON K.bon_id = LEER.bon_id AND K.mandant_id = LEER.mandant_id
          AND K.bon_dat = LEER.bon_dat AND K.wup_id = LEER.wup_id
     INNER JOIN KRS AS krs ON K.wrg_id = krs.von_wrg_id
     INNER JOIN ZEIT_1 AS t ON LEER.bon_dat = t.dat
     INNER JOIN WUP_1 AS wup_1 ON LEER.mandant_id = wup.mandant_id AND LEER.wup_id = wup.wup_id
    WHERE K.mandant_id = 1
    GROUP BY LEER.mandant_id,
     wup_id,
     dat,
     wrg_id) AS info ON pfand.mandant_id = info.mandant_id AND pfand.wup_id = info.wup_id AND pfand.dat = info.dat AND
     pfand.wrg_id = info.wrg_id), WF AS (SELECT T1.mandant_id,
   wup.aktuell_wup_id AS wup_id,
   T1.dat_buch AS dat,
   krs.nach_wrg_id AS wrg_id,
   SUM(CASE
     WHEN T3.wg_id IN (980, 985) AND T3.wug_id = 500 AND T1.lager_bewart_id IN ('305', '306', '901') AND T1.auto_fg
       NOT IN ('L')
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_we_vz,
   SUM(CASE
     WHEN T3.wg_id IN (980, 985) AND T3.wug_id = 500 AND T1.lager_bewart_id IN ('305', '306', '901') AND T1.auto_fg
       NOT IN ('L')
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_we_vz,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (300, 400) OR T1.art_id = 980001200) AND T1.lager_bewart_id IN ('901',
         '905') AND T1.auto_fg NOT IN ('L')
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_dez_we,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (300, 400) OR T1.art_id = 980001200) AND T1.lager_bewart_id IN ('901',
         '905') AND T1.auto_fg NOT IN ('L')
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_dez_we,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (300, 400) OR T1.art_id = 980001200) AND (T1.lager_bewart_id IN ('915')
          AND t4.ref_beleg_id IS NULL OR T1.lager_bewart_id IN ('915', '916') AND t4.lager_bewart_id IN ('901', '905')
          AND t4.ref_beleg_id IS NOT NULL) AND T1.auto_fg NOT IN ('L')
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_dez_we_korr,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (300, 400) OR T1.art_id = 980001200) AND (T1.lager_bewart_id IN ('915')
          AND t4.ref_beleg_id IS NULL OR T1.lager_bewart_id IN ('915', '916') AND t4.lager_bewart_id IN ('901', '905')
          AND t4.ref_beleg_id IS NOT NULL) AND T1.auto_fg NOT IN ('L')
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_dez_we_korr,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (300, 400) OR T1.art_id = 980001200) AND T1.lager_bewart_id IN ('902',
         '906') AND T1.auto_fg NOT IN ('L')
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_dez_we_storno,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (300, 400) OR T1.art_id = 980001200) AND T1.lager_bewart_id IN ('902',
         '906') AND T1.auto_fg NOT IN ('L')
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_dez_we_storno,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (300, 400) OR T1.art_id = 980001200) AND T1.lager_bewart_id IN ('305',
         '306') AND T1.auto_fg NOT IN ('L', 'X')
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_dez_we_uml,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (300, 400) OR T1.art_id = 980001200) AND T1.lager_bewart_id IN ('305',
         '306') AND T1.auto_fg NOT IN ('L', 'X')
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_dez_we_uml,
   SUM(CASE
     WHEN T3.wg_id IN (980, 985) AND T3.wug_id IN (500) AND T1.lager_bewart_id IN ('301') AND T1.nb_id = 0 AND T1.auto_fg
        NOT IN ('L')
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_abholung_vz,
   SUM(CASE
     WHEN T3.wg_id IN (980, 985) AND T3.wug_id IN (500) AND T1.lager_bewart_id IN ('301') AND T1.nb_id = 0 AND T1.auto_fg
        NOT IN ('L')
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_abholung_vz,
   SUM(CASE
     WHEN T3.wg_id IN (980, 985) AND T3.wug_id IN (500) AND T1.lager_bewart_id IN ('303', '304') AND T1.auto_fg NOT IN ('L'
        , 'X')
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_umbuchung_abgang,
   SUM(CASE
     WHEN T3.wg_id IN (980, 985) AND T3.wug_id IN (500) AND T1.lager_bewart_id IN ('303', '304') AND T1.auto_fg NOT IN ('L'
        , 'X')
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_umbuchung_abgang,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (0, 100, 300, 400) OR T1.art_id = 980001200) AND (T1.lager_bewart_id IN ('907'
           , '912') AND T1.auto_fg NOT IN ('L') OR T1.lager_bewart_id IN ('303', '304') AND T1.auto_fg NOT IN ('L', 'X'
           ))
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_abholung_lief,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (0, 100, 300, 400) OR T1.art_id = 980001200) AND (T1.lager_bewart_id IN ('907'
           , '912') AND T1.auto_fg NOT IN ('L') OR T1.lager_bewart_id IN ('303', '304') AND T1.auto_fg NOT IN ('L', 'X'
           ))
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_abholung_lief,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (0, 100, 300, 400) OR T1.art_id = 980001200) AND (T1.lager_bewart_id IN ('916'
            ) AND t4.ref_beleg_id IS NULL OR T1.lager_bewart_id IN ('915', '916') AND t4.lager_bewart_id IN ('907',
             '912') AND t4.ref_beleg_id IS NOT NULL) AND T1.auto_fg NOT IN ('L')
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_abholung_lief_korr,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (0, 100, 300, 400) OR T1.art_id = 980001200) AND (T1.lager_bewart_id IN ('915'
            ) AND t4.ref_beleg_id IS NULL OR T1.lager_bewart_id IN ('915', '916') AND t4.lager_bewart_id IN ('907',
             '912') AND t4.ref_beleg_id IS NOT NULL) AND T1.auto_fg NOT IN ('L')
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_abholung_lief_korr,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (0, 100, 300, 400) OR T1.art_id = 980001200) AND T1.lager_bewart_id IN ('908'
         ) AND T1.auto_fg NOT IN ('L')
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_abholung_lief_storno,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (0, 100, 300, 400) OR T1.art_id = 980001200) AND T1.lager_bewart_id IN ('908'
         ) AND T1.auto_fg NOT IN ('L')
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_abholung_lief_storno,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (0, 300, 400) OR T1.art_id = 980001200) AND T1.lager_bewart_id IN ('157',
         'X65', 'Y65') AND T1.auto_fg NOT IN ('L')
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_abschschrift_fremd,
   SUM(CASE
     WHEN (T3.wg_id IN (980) AND T3.wug_id IN (0, 300, 400) OR T1.art_id = 980001200) AND T1.lager_bewart_id IN ('157',
         'X65', 'Y65') AND T1.auto_fg NOT IN ('L')
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_abschrift_fremd,
   SUM(CASE
     WHEN T3.wg_id IN (980) AND T3.wug_id IN (0, 300, 400) AND (T1.lager_bewart_id IN ('Y54') AND T1.auto_fg NOT IN ('L'
           ) OR T1.lager_bewart_id IN ('X54') AND T1.auto_fg IN (''))
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_abschrift_bruch,
   SUM(CASE
     WHEN T3.wg_id IN (980) AND T3.wug_id IN (0, 300, 400) AND (T1.lager_bewart_id IN ('Y54') AND T1.auto_fg NOT IN ('L'
           ) OR T1.lager_bewart_id IN ('X54') AND T1.auto_fg IN (''))
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_abschrift_bruch,
   SUM(CASE
     WHEN T1.art_id = 980101000 AND T1.lager_bewart_id IN ('Y65') AND T1.auto_fg NOT IN ('L')
     THEN T1.menge_lagerbew_bme
     ELSE 0
     END) AS menge_abschrift_entsorgungmod,
   SUM(CASE
     WHEN T1.art_id = 980101000 AND T1.lager_bewart_id IN ('Y65') AND T1.auto_fg NOT IN ('L')
     THEN T1.betrag_verkauf * krs.umrechnungskurs
     ELSE 0
     END) AS betrag_brutto_abschrift_entsorgungmod
  FROM kfl_production_dbp_data.lagerbew_det_1 AS T1_1
   INNER JOIN kfl_production_dbp_data.lagerbew_1 AS T2 ON T1.mandant_id = T2.mandant_id AND T1.lagerbew_beleg_id = T2.lagerbew_beleg_id
       AND T1.kj = T2.kj
   INNER JOIN kfl_production_dbp_data.art_wg_zu_per_1 AS T3 ON T1.art_id = T3.art_id AND T1.mandant_id = T3.mandant_id AND
      T3.arthiertyp_id = 2 AND T3.dat_bis = DATE '9999-12-31'
   LEFT JOIN (SELECT T4A.folge_beleg_id,
     T4A.folge_beleg_pos_id,
     T4A.mandant_id,
     T4A.wup_id,
     T4A.dat_buch,
     T4A.ref_beleg_id,
     T4B.lager_bewart_id
    FROM kfl_production_dbp_data.best_belegfluss_1 AS T4A
     INNER JOIN kfl_production_dbp_data.lagerbew_det_1 AS T4B ON T4A.ref_beleg_id = T4B.lagerbew_beleg_id AND T4A.ref_beleg_pos_id
           = T4B.lagerbew_beleg_pos_id AND T4A.mandant_id = T4B.mandant_id AND T4A.wup_id = T4B.wup_id AND T4A.kj = T4B
       .kj) AS t4 ON T1.lagerbew_beleg_id = t4.folge_beleg_id AND T1.lagerbew_beleg_pos_id = t4.folge_beleg_pos_id AND
       T1.mandant_id = t4.mandant_id AND T1.wup_id = t4.wup_id AND T1.dat_buch = t4.dat_buch
   INNER JOIN KRS AS krs ON T1.wrg_id = krs.von_wrg_id
   INNER JOIN ZEIT_1 AS t ON T1.dat_buch = t.dat
   INNER JOIN WUP_1 AS wup_1 ON T1.mandant_id = wup.mandant_id AND T1.wup_id = wup.wup_id
  WHERE T1.mandant_id = 1
   AND (T3.wg_id IN (980, 985) AND T3.wug_id IN (0, 100, 300, 400, 500) OR T1.art_id IN (980001200, 980101000))
   AND T1.lager_bewart_id IN ('157', '301', '303', '304', '305', '306', '901', '902', '905', '906', '907', '908', '912'
     , '915', '916', 'X54', 'X65', 'Y05', 'Y54', 'Y65')
  GROUP BY T1.mandant_id,
   wup_id,
   dat,
   wrg_id), ZU AS (SELECT K0.mandant_id,
   wup.aktuell_wup_id AS wup_id,
   K0.bon_dat AS dat,
   krs.nach_wrg_id AS wrg_id,
   SUM(K2.menge) AS menge_zufuehrung_info,
   SUM(K2.umsatz_brutto * krs.umrechnungskurs * -1) AS betrag_brutto_zufuehrung_info
  FROM kfl_production_dbp_ods.ods_bon_transaction_1 AS K0
   INNER JOIN kfl_production_dbp_ods.ods_bon_kopf_1 AS K1 ON K0.mandant_id = K1.mandant_id AND K0.bon_id = K1.bon_id AND
      K0.wup_id = K1.wup_id AND K0.bon_dat = K1.bon_dat
   INNER JOIN kfl_production_dbp_ods.ods_bon_verkauf_1 AS K2 ON K1.mandant_id = K2.mandant_id AND K1.bon_id = K2.bon_id
     AND K1.wup_id = K2.wup_id AND K1.bon_dat = K2.bon_dat
   INNER JOIN KRS AS krs ON K1.wrg_id = krs.von_wrg_id
   INNER JOIN ZEIT_1 AS t ON K0.bon_dat = t.dat
   INNER JOIN WUP_1 AS wup_1 ON K1.mandant_id = wup.mandant_id AND K0.wup_id = wup.wup_id
  WHERE K0.mandant_id = 1
   AND K1.turnover_fg = 0
   AND K0.transaction_name = 'EMPTY_CRATE'
   AND (K0.bon_id, K0.wup_id, K0.mandant_id) NOT IN (SELECT (bon_id, wup_id, mandant_id)
     FROM kfl_production_dbp_ods.ods_bon_storno_1)
  GROUP BY K0.mandant_id,
   wup_id,
   dat,
   wrg_id), EW AS (SELECT AB.mandant_id,
   wup.aktuell_wup_id AS wup_id,
   AB.dat,
   krs.nach_wrg_id AS wrg_id,
   SUM(AB.menge) AS menge_einloese_kasse,
   SUM((AB.umsatz_netto + AB.umsatz_mwst_betrag) * krs.umrechnungskurs * -1) AS betrag_brutto_einloese_kasse
  FROM kfl_production_dbp_data.artbew_1 AS AB
   INNER JOIN KRS AS krs ON AB.wrg_1 = krs.von_wrg_id
   INNER JOIN ZEIT_1 AS t ON AB.dat = t.dat
   INNER JOIN WUP_1 AS wup_1 ON AB.mandant_id = wup.mandant_id AND AB.wup_id = wup.wup_id
  WHERE AB.art_id IN (980054100, 980053300)
  GROUP BY AB.mandant_id,
   wup_id,
   AB.dat,
   wrg_id), EA AS (SELECT ABR.mandant_id,
   wup.aktuell_wup_id AS wup_id,
   ABR.dat_ruecknahme AS dat,
   'EUR' AS wrg_id,
   SUM(ABR.menge_einweg) AS menge_einweg_abrechnung,
   SUM(ABR.menge_einweg * 0.25) AS betrag_brutto_einweg_abrechnung
  FROM kfl_production_dbp_data.leergut_einweg_dat_abrechnung_1 AS ABR
   INNER JOIN ZEIT_1 AS t ON ABR.dat_ruecknahme = t.dat
   INNER JOIN WUP_1 AS wup_1 ON ABR.mandant_id = wup.mandant_id AND ABR.wup_id = wup.wup_id
  GROUP BY ABR.mandant_id,
   wup_id,
   dat,
   wrg_id), INVAUF AS (SELECT inv.mandant_id,
   inv.wup_id,
   t.dat,
   inv.wrg_id,
    CASE
    WHEN t.dat = inv.dat
    THEN inv.betrag_inventur
    ELSE 0
    END AS betrag_inventur,
   DENSE_RANK() OVER (PARTITION BY inv.mandant_id, inv.wup_id, inv.wrg_id ORDER BY inv.dat NULLS LAST) AS grp_inventur
  FROM (SELECT DISTINCT V0.mandant_id,
     wup.aktuell_wup_id AS wup_id,
     DATE_ADD(V0.dat, INTERVAL 1 DAY) AS dat,
     krs.nach_wrg_id AS wrg_id,
      V0.betrag_leergut_inventur * krs.umrechnungskurs AS betrag_inventur,
     COALESCE(DATE_SUB(MAX(DATE_ADD(V0.dat, INTERVAL 1 DAY)) OVER (PARTITION BY V0.mandant_id, wup.aktuell_wup_id, V0.wrg_id
          ORDER BY V0.dat NULLS LAST ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), INTERVAL 1 DAY), DATE '9999-12-31') AS
     dat_follow
    FROM kfl_production_dbp_msi_data.ts_wup_dat_leergut_1 AS V0
     INNER JOIN WUP_1 AS wup_1 ON V0.mandant_id = wup.mandant_id AND V0.wup_id = wup.wup_id
     INNER JOIN KRS AS krs ON V0.wrg_id = krs.von_wrg_id
    WHERE V0.betrag_leergut_inventur <> 0) AS inv
   INNER JOIN ZEIT_1 AS t ON TRUE
  WHERE t.dat BETWEEN inv.dat AND inv.dat_follow), INVBET AS (SELECT V1.mandant_id,
   wup.aktuell_wup_id AS wup_id,
   V1.dat,
   krs.nach_wrg_id AS wrg_id,
   SUM(V1.betrag_leergut_inventur * krs.umrechnungskurs) AS betrag_inventur
  FROM kfl_production_dbp_msi_data.ts_wup_dat_leergut_1 AS V1
   INNER JOIN WUP_1 AS wup_1 ON V1.mandant_id = wup.mandant_id AND V1.wup_id = wup.wup_id
   INNER JOIN KRS AS krs ON V1.wrg_id = krs.von_wrg_id
  WHERE V1.betrag_leergut_inventur <> 0
  GROUP BY V1.mandant_id,
   wup_id,
   V1.dat,
   wrg_id), ZAE AS (SELECT V2.mandant_id,
   wup.aktuell_wup_id AS wup_id,
   V2.dat,
   krs.nach_wrg_id AS wrg_id,
   SUM(V2.betrag_leergut_zaehlung * krs.umrechnungskurs) AS betrag_zaehlung
  FROM kfl_production_dbp_msi_data.ts_wup_dat_leergut_1 AS V2
   INNER JOIN WUP_1 AS wup_1 ON V2.mandant_id = wup.mandant_id AND V2.wup_id = wup.wup_id
   INNER JOIN KRS AS krs ON V2.wrg_id = krs.von_wrg_id
  WHERE V2.betrag_leergut_zaehlung <> 0
  GROUP BY V2.mandant_id,
   wup_id,
   V2.dat,
   wrg_id), INVZAEHL AS (SELECT auf.mandant_id,
   auf.wup_id,
   t.dat,
   auf.wrg_id,
    CASE
    WHEN t.dat = auf.dat
    THEN auf.betrag_invzaehl
    ELSE 0
    END AS betrag_invzaehl,
   DENSE_RANK() OVER (PARTITION BY auf.mandant_id, auf.wup_id, auf.wrg_id ORDER BY auf.dat NULLS LAST) AS grp_invzaehl
  FROM (SELECT DISTINCT V3.mandant_id,
     wup.aktuell_wup_id AS wup_id,
     DATE_ADD(V3.dat, INTERVAL 1 DAY) AS dat,
     krs.nach_wrg_id AS wrg_id,
      COALESCE(V3.betrag_leergut_inventur, V3.betrag_leergut_zaehlung) * krs.umrechnungskurs AS betrag_invzaehl,
     COALESCE(DATE_SUB(MAX(DATE_ADD(V3.dat, INTERVAL 1 DAY)) OVER (PARTITION BY V3.mandant_id, wup.aktuell_wup_id, V3.wrg_id
          ORDER BY V3.dat NULLS LAST ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), INTERVAL 1 DAY), DATE '9999-12-31') AS
     dat_follow
    FROM kfl_production_dbp_msi_data.ts_wup_dat_leergut_1 AS V3
     INNER JOIN WUP_1 AS wup_1 ON V3.mandant_id = wup.mandant_id AND V3.wup_id = wup.wup_id
     INNER JOIN KRS AS krs ON V3.wrg_id = krs.von_wrg_id
    WHERE V3.betrag_leergut_inventur <> 0
     OR V3.betrag_leergut_zaehlung <> 0) AS auf
   INNER JOIN ZEIT_1 AS t ON TRUE
  WHERE t.dat BETWEEN auf.dat AND auf.dat_follow) (SELECT t128.mandant_id,
   t128.wup_id,
   t128.dat,
   t128.wrg_id,
   t128.menge_automat_ew,
   t128.betrag_brutto_automat_ew,
   t128.menge_automat_mw,
   t128.betrag_brutto_automat_mw,
   t128.menge_info_ew,
   t128.betrag_brutto_info_ew,
   t128.menge_info_mw,
   t128.betrag_brutto_info_mw,
   t128.menge_we_vz,
   t128.betrag_brutto_we_vz,
   t128.menge_dez_we,
   t128.betrag_brutto_dez_we,
   t128.menge_dez_we_korr,
   t128.betrag_brutto_dez_we_korr,
   t128.menge_dez_we_storno,
   t128.betrag_brutto_dez_we_storno,
   t128.menge_dez_we_uml,
   t128.betrag_brutto_dez_we_uml,
   t128.menge_abholung_vz,
   t128.betrag_brutto_abholung_vz,
   t128.menge_umbuchung_abgang,
   t128.betrag_brutto_umbuchung_abgang,
   t128.menge_abholung_lief,
   t128.betrag_brutto_abholung_lief,
   t128.menge_abholung_lief_korr,
   t128.betrag_brutto_abholung_lief_korr,
   t128.menge_abholung_lief_storno,
   t128.betrag_brutto_abholung_lief_storno,
   t128.menge_abschschrift_fremd,
   t128.betrag_brutto_abschrift_fremd,
   t128.menge_abschrift_bruch,
   t128.betrag_brutto_abschrift_bruch,
   t128.menge_abschrift_entsorgungmod,
   t128.betrag_brutto_abschrift_entsorgungmod,
   t128.menge_zufuehrung_info,
   t128.betrag_brutto_zufuehrung_info,
   t128.menge_einloese_kasse,
   t128.betrag_brutto_einloese_kasse,
   t128.menge_einweg_abrechnung,
   t128.betrag_brutto_einweg_abrechnung,
   t128.betrag_brutto_zugang,
   t128.betrag_brutto_abgang,
    t128.betrag_brutto_zugang + t128.betrag_brutto_abgang AS betrag_brutto_veraenderung,
   t128.betrag_inventur,
   t128.grp_inventur,
   IF(t128.grp_inventur IS NULL, NULL, t128.betrag_inventur_auf + (t128.betrag_brutto_zugang + t128.betrag_brutto_abgang
       )) AS kombi_inv,
   SUM(IF(t128.grp_inventur IS NULL, NULL, t128.betrag_inventur_auf + (t128.betrag_brutto_zugang + t128.betrag_brutto_abgang
        ))) OVER (PARTITION BY t128.mandant_id, t128.wup_id, t128.wrg_id, t128.grp_inventur ORDER BY t128.dat NULLS LAST
      RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS betrag_inventur_auf,
   t128.betrag_zaehlung,
   t128.grp_invzaehl,
   IF(t128.grp_invzaehl IS NULL, NULL, t128.betrag_invzaehl + (t128.betrag_brutto_zugang + t128.betrag_brutto_abgang))
   AS kombi_invzaehl,
   SUM(IF(t128.grp_invzaehl IS NULL, NULL, t128.betrag_invzaehl + (t128.betrag_brutto_zugang + t128.betrag_brutto_abgang
        ))) OVER (PARTITION BY t128.mandant_id, t128.wup_id, t128.wrg_id, t128.grp_invzaehl ORDER BY t128.dat NULLS LAST
      RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS betrag_invzaehl_auf
  FROM (SELECT t5.mandant_id,
     t5.wup_id,
     t5.dat,
     t5.wrg_id,
     COALESCE(t29.menge_automat_ew, 0) AS menge_automat_ew,
     COALESCE(t29.betrag_brutto_automat_ew, 0) AS betrag_brutto_automat_ew,
     COALESCE(t29.menge_automat_mw, 0) AS menge_automat_mw,
     COALESCE(t29.betrag_brutto_automat_mw, 0) AS betrag_brutto_automat_mw,
     COALESCE(t29.menge_info_ew, 0) AS menge_info_ew,
     COALESCE(t29.betrag_brutto_info_ew, 0) AS betrag_brutto_info_ew,
     COALESCE(t29.menge_info_mw, 0) AS menge_info_mw,
     COALESCE(t29.betrag_brutto_info_mw, 0) AS betrag_brutto_info_mw,
     COALESCE(t43.menge_we_vz, 0) AS menge_we_vz,
     COALESCE(t43.betrag_brutto_we_vz, 0) AS betrag_brutto_we_vz,
     COALESCE(t43.menge_dez_we, 0) AS menge_dez_we,
     COALESCE(t43.betrag_brutto_dez_we, 0) AS betrag_brutto_dez_we,
     COALESCE(t43.menge_dez_we_korr, 0) AS menge_dez_we_korr,
     COALESCE(t43.betrag_brutto_dez_we_korr, 0) AS betrag_brutto_dez_we_korr,
     COALESCE(t43.menge_dez_we_storno, 0) AS menge_dez_we_storno,
     COALESCE(t43.betrag_brutto_dez_we_storno, 0) AS betrag_brutto_dez_we_storno,
     COALESCE(t43.menge_dez_we_uml, 0) AS menge_dez_we_uml,
     COALESCE(t43.betrag_brutto_dez_we_uml, 0) AS betrag_brutto_dez_we_uml,
     COALESCE(t43.menge_abholung_vz, 0) AS menge_abholung_vz,
     COALESCE(t43.betrag_brutto_abholung_vz, 0) AS betrag_brutto_abholung_vz,
     COALESCE(t43.menge_umbuchung_abgang, 0) AS menge_umbuchung_abgang,
     COALESCE(t43.betrag_brutto_umbuchung_abgang, 0) AS betrag_brutto_umbuchung_abgang,
     COALESCE(t43.menge_abholung_lief, 0) AS menge_abholung_lief,
     COALESCE(t43.betrag_brutto_abholung_lief, 0) AS betrag_brutto_abholung_lief,
     COALESCE(t43.menge_abholung_lief_korr, 0) AS menge_abholung_lief_korr,
     COALESCE(t43.betrag_brutto_abholung_lief_korr, 0) AS betrag_brutto_abholung_lief_korr,
     COALESCE(t43.menge_abholung_lief_storno, 0) AS menge_abholung_lief_storno,
     COALESCE(t43.betrag_brutto_abholung_lief_storno, 0) AS betrag_brutto_abholung_lief_storno,
     COALESCE(t43.menge_abschschrift_fremd, 0) AS menge_abschschrift_fremd,
     COALESCE(t43.betrag_brutto_abschrift_fremd, 0) AS betrag_brutto_abschrift_fremd,
     COALESCE(t43.menge_abschrift_bruch, 0) AS menge_abschrift_bruch,
     COALESCE(t43.betrag_brutto_abschrift_bruch, 0) AS betrag_brutto_abschrift_bruch,
     COALESCE(t43.menge_abschrift_entsorgungmod, 0) AS menge_abschrift_entsorgungmod,
     COALESCE(t43.betrag_brutto_abschrift_entsorgungmod, 0) AS betrag_brutto_abschrift_entsorgungmod,
     COALESCE(t57.menge_zufuehrung_info, 0) AS menge_zufuehrung_info,
     COALESCE(t57.betrag_brutto_zufuehrung_info, 0) AS betrag_brutto_zufuehrung_info,
     COALESCE(t70.menge_einloese_kasse, 0) AS menge_einloese_kasse,
     COALESCE(t70.betrag_brutto_einloese_kasse, 0) AS betrag_brutto_einloese_kasse,
     COALESCE(t77.menge_einweg_abrechnung, 0) AS menge_einweg_abrechnung,
     COALESCE(t77.betrag_brutto_einweg_abrechnung, 0) AS betrag_brutto_einweg_abrechnung,
           COALESCE(t29.betrag_brutto_automat_mw, 0) + COALESCE(t29.betrag_brutto_info_mw, 0) + COALESCE(t43.betrag_brutto_dez_we
           , 0) + COALESCE(t43.betrag_brutto_dez_we_korr, 0) + COALESCE(t43.betrag_brutto_dez_we_storno, 0) + COALESCE(t43
        .betrag_brutto_dez_we_uml, 0) + COALESCE(t57.betrag_brutto_zufuehrung_info, 0) AS betrag_brutto_zugang,
          COALESCE(t43.betrag_brutto_abholung_vz, 0) + COALESCE(t43.betrag_brutto_umbuchung_abgang, 0) + COALESCE(t43.betrag_brutto_abholung_lief
          , 0) + COALESCE(t43.betrag_brutto_abholung_lief_korr, 0) + COALESCE(t43.betrag_brutto_abschrift_fremd, 0) +
      COALESCE(t43.betrag_brutto_abschrift_bruch, 0) AS betrag_brutto_abgang,
     COALESCE(t102.betrag_inventur, 0) AS betrag_inventur,
     COALESCE(t91.betrag_inventur, 0) AS betrag_inventur_auf,
     t91.grp_inventur,
     COALESCE(t113.betrag_zaehlung, 0) AS betrag_zaehlung,
     COALESCE(t127.betrag_invzaehl, 0) AS betrag_invzaehl,
     t127.grp_invzaehl
    FROM VIS AS t5
     LEFT JOIN AN AS t29 ON t5.mandant_id = t29.mandant_id AND t5.wup_id = t29.wup_id AND t5.dat = t29.dat AND t5.wrg_id
        = t29.wrg_id
     LEFT JOIN WF AS t43 ON t5.mandant_id = t43.mandant_id AND t5.wup_id = t43.wup_id AND t5.dat = t43.dat AND t5.wrg_id
        = t43.wrg_id
     LEFT JOIN ZU AS t57 ON t5.mandant_id = t57.mandant_id AND t5.wup_id = t57.wup_id AND t5.dat = t57.dat AND t5.wrg_id
        = t57.wrg_id
     LEFT JOIN EW AS t70 ON t5.mandant_id = t70.mandant_id AND t5.wup_id = t70.wup_id AND t5.dat = t70.dat AND t5.wrg_id
        = t70.wrg_id
     LEFT JOIN EA AS t77 ON t5.mandant_id = t77.mandant_id AND t5.wup_id = t77.wup_id AND t5.dat = t77.dat AND t5.wrg_id
        = t77.wrg_id
     LEFT JOIN INVAUF AS t91 ON t5.mandant_id = t91.mandant_id AND t5.wup_id = t91.wup_id AND t5.dat = t91.dat AND t5.wrg_id
        = t91.wrg_id
     LEFT JOIN INVBET AS t102 ON t5.mandant_id = t102.mandant_id AND t5.wup_id = t102.wup_id AND t5.dat = t102.dat AND
       t5.wrg_id = t102.wrg_id
     LEFT JOIN ZAE AS t113 ON t5.mandant_id = t113.mandant_id AND t5.wup_id = t113.wup_id AND t5.dat = t113.dat AND t5.wrg_id
        = t113.wrg_id
     LEFT JOIN INVZAEHL AS t127 ON t5.mandant_id = t127.mandant_id AND t5.wup_id = t127.wup_id AND t5.dat = t127.dat AND
       t5.wrg_id = t127.wrg_id) AS t128);