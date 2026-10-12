/*
#------------------------------------------------------------------------------
# Skriptname   : kmo_wpuums_mis.btq
# Erstelldatum : 03.11.2008
#------------------------------------------------------------------------------
# Projekt   : TP1_MIS
# Kommentar : Erweiterung des Umsatzes umd Payback aus FI ( dbp_etl_process.in_fi_beleg_det_agg_payback_1 bzw. dbp_data.in_fi_beleg_det_1
# Quelle    : Tabelle dbp_etl.kmo_wpuums_1
# Ziel      : Tabelle dbp_etl_rfi.kmo_wpuums_1
#             Tabelle dbp_data.artbew_wg_sum_1
#------------------------------------------------------------------------------
# History:
#  26.06.2018  Armin Smoor      Ersterstellung ...

#------------------------------------------------------------------------------
# Processing Steps
# 1.) Logon auf der Datenbank
# 2.) Erzeugen der temporaeren Tabellen
# 3.) Befuellung der Temp-Tabelle kmo_wpuums_tmp_1
# 4.) Berechnung der Umsaetze in Euro Waehrung
# 5.) Loeschen der bestehenden Daten aus der Zieltabelle artbew_wg_sum_1
# 6.) Befuellung der artbew_wg_sum_1
# 7.) Fullen der dbp_etl_process.artbew_wg_sum_agg_wt_1
#------------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabellen
#------------------------------------------------------------------------------
*/




DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ETL.KMO_WPUUMS_PAYBACK_TMP_1;


CREATE TABLE IF NOT EXISTS KFL_PRODUCTION_DBP_ETL.KMO_WPUUMS_PAYBACK_TMP_1 LIKE KFL_PRODUCTION_DBP_DATA.ARTBEW_WG_SUM_1;

/*
#------------------------------------------------------------------------------
# 3.) Befuellung der Temp-Tabelle kmo_wpuums_tmp_1
#------------------------------------------------------------------------------
#  1010: Datenherkunft FI Payback 
#------------------------------------------------------------------------------
*/


INSERT INTO KFL_PRODUCTION_DBP_ETL.KMO_WPUUMS_PAYBACK_TMP_1 (MANDANT_ID, NB_ID, ARTHIERTYP_ID, WG_ID, DAT, WUP_ID, BEWART_ID, KJMO, UMSATZ_BRUTTO, UMSATZ_NETTO, UMSATZ_WRG, UMSATZ_BRUTTO_KONZ, UMSATZ_NETTO_KONZ, QUELLE, MENGE)
  SELECT
      T1.MANDANT_ID,
      T1.NB_ID,
      T2.ARTHIERTYP_ID,
      T2.WG_ID,
      T1.DAT_BUCH AS DAT,
      T1.WUP_ID,
      1010 AS BEWART_ID,        /*Payback aus FI*/
      --,t1.dat_buch /100 + 190000 as kjmo
      round(CAST(FORMAT_DATE('%Y%m', T1.DAT_BUCH) as BIGNUMERIC), 0) AS KJMO,
      T1.BETRAG_FI_BELEG_SUM AS UMSATZ_BRUTTO,
      T1.BETRAG_FI_BELEG_SUM AS UMSATZ_NETTO,
      T1.WRG_ID AS UMSATZ_WRG,
      T1.BETRAG_FI_BELEG_SUM AS UMSATZ_BRUTTO_KONZ,
      T1.BETRAG_FI_BELEG_SUM AS UMSATZ_NETTO_KONZ,
      10 AS QUELLE,         /*Payback aus FI*/
      0 AS MENGE
    FROM
      KFL_PRODUCTION_DBP_ETL_PROCESS.IN_FI_BELEG_DET_AGG_PAYBACK_1 AS T1_1
      INNER JOIN KFL_PRODUCTION_DBP_DATA.ART_WG_ZU_PER_1 AS T2 ON T1.MANDANT_ID = T2.MANDANT_ID
       AND T1.ART_ID = T2.ART_ID
       AND T2.DAT_BIS = PARSE_DATE('%Y%m%d', '99991231')
       AND T2.ARTHIERTYP_ID = 2
       AND (CAST(T1.VERARBEITET_FG as INT64)>> 1)&1 = 0
;

/*
#------------------------------------------------------------------------------
# 4.) Berechnung der Umsaetze in Euro Waehrung
#     (ACHTUNG: Berechnung mit Kurstyp 3 und nicht wie bei Artbew_1 mit Kurstyp 9)
#------------------------------------------------------------------------------
*/


UPDATE KFL_PRODUCTION_DBP_ETL.KMO_WPUUMS_PAYBACK_TMP_1 SET
 UMSATZ_BRUTTO_KONZ = ROUND(CAST(KMO_WPUUMS_PAYBACK_TMP.UMSATZ_BRUTTO * K.UMRECHNUNGSKURS AS NUMERIC), 4),
 UMSATZ_NETTO_KONZ = ROUND(CAST(KMO_WPUUMS_PAYBACK_TMP.UMSATZ_NETTO * K.UMRECHNUNGSKURS AS NUMERIC), 4) FROM
 KFL_PRODUCTION_DBP_DATA.KURS_1 AS K
WHERE KMO_WPUUMS_PAYBACK_TMP.UMSATZ_WRG = K.VON_WRG_ID AND KMO_WPUUMS_PAYBACK_TMP.DAT BETWEEN K.DAT_VON AND K.DAT_BIS
  AND K.NACH_WRG_ID = 'EUR' AND K.KURSTYP_ID = 3;


/*
#------------------------------------------------------------------------------
# 5.) Loeschen der bestehenden Daten aus der Zieltabelle artbew_wg_sum_1
#     
#------------------------------------------------------------------------------
*/

DELETE FROM KFL_PRODUCTION_DBP_DATA.ARTBEW_WG_SUM_1
WHERE BEWART_ID = 1010 AND (MANDANT_ID, WUP_ID, NB_ID, DAT) IN (SELECT (MANDANT_ID, WUP_ID, NB_ID, DAT)
    FROM KFL_PRODUCTION_DBP_ETL.KMO_WPUUMS_PAYBACK_TMP_1) AND QUELLE = 10   -- Daten in der Zieltabelle stammen aus der Payback aus FI
    ;


/*
#------------------------------------------------------------------------------
# 6.) Befuellung der artbew_wg_sum_1
#------------------------------------------------------------------------------
*/

INSERT INTO KFL_PRODUCTION_DBP_DATA.ARTBEW_WG_SUM_1 (MANDANT_ID, WUP_ID, WG_ID, BEWART_ID, DAT, NB_ID, ARTHIERTYP_ID, UMSATZ_BRUTTO, UMSATZ_NETTO, UMSATZ_WRG, UMSATZ_BRUTTO_KONZ, UMSATZ_NETTO_KONZ, KJMO, MENGE, QUELLE)
  SELECT
      KMO_WPUUMS_PAYBACK_TMP.MANDANT_ID,
      KMO_WPUUMS_PAYBACK_TMP.WUP_ID,
      KMO_WPUUMS_PAYBACK_TMP.WG_ID,
      KMO_WPUUMS_PAYBACK_TMP.BEWART_ID,
      KMO_WPUUMS_PAYBACK_TMP.DAT,
      KMO_WPUUMS_PAYBACK_TMP.NB_ID,
      KMO_WPUUMS_PAYBACK_TMP.ARTHIERTYP_ID,
      KMO_WPUUMS_PAYBACK_TMP.UMSATZ_BRUTTO,
      KMO_WPUUMS_PAYBACK_TMP.UMSATZ_NETTO,
      KMO_WPUUMS_PAYBACK_TMP.UMSATZ_WRG,
      KMO_WPUUMS_PAYBACK_TMP.UMSATZ_BRUTTO_KONZ,
      KMO_WPUUMS_PAYBACK_TMP.UMSATZ_NETTO_KONZ,
      KMO_WPUUMS_PAYBACK_TMP.KJMO,
      KMO_WPUUMS_PAYBACK_TMP.MENGE,
      KMO_WPUUMS_PAYBACK_TMP.QUELLE
    FROM
      KFL_PRODUCTION_DBP_ETL.KMO_WPUUMS_PAYBACK_TMP_1
;


UPDATE KFL_PRODUCTION_DBP_ETL_PROCESS.IN_FI_BELEG_DET_AGG_PAYBACK_1 AS t
SET
  VERARBEITET_FG = CAST(t.VERARBEITET_FG AS INT64) | (1 << 1)  -- artbew_wg_sum_1-verarbeitung
WHERE EXISTS (
  SELECT 1
  FROM KFL_PRODUCTION_DBP_ETL.KMO_WPUUMS_PAYBACK_TMP_1 AS s
  WHERE t.MANDANT_ID = s.MANDANT_ID
    AND t.WUP_ID       = s.WUP_ID
    AND t.DAT_BUCH     = s.DAT
);


/*
#------------------------------------------------------------------------------
# 7.) Fullen der dbp_etl_process.artbew_wg_sum_agg_wt_1
#------------------------------------------------------------------------------
*/

INSERT INTO KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_WG_SUM_AGG_WT_1 (MANDANT_ID, WUP_ID, NB_ID, DAT, CALC_FG, DAT_LIEF)
(SELECT MANDANT_ID,
  WUP_ID,
  NB_ID,
  DAT,
  0 AS CALC_FG,
  CURRENT_DATE AS DAT_LIEF
 FROM KFL_PRODUCTION_DBP_ETL.KMO_WPUUMS_PAYBACK_TMP_1
 WHERE (MANDANT_ID, WUP_ID, NB_ID, DAT) NOT IN (SELECT (MANDANT_ID, WUP_ID, NB_ID, DAT)
    FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ARTBEW_WG_SUM_AGG_WT_1)
 GROUP BY MANDANT_ID,
  WUP_ID,
  NB_ID,
  DAT,
  CALC_FG,
  DAT_LIEF);

/*
#------------------------------------------------------------------------------
# 11.) Bteq beenden
#------------------------------------------------------------------------------
*/