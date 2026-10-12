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

#------------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabellen
#------------------------------------------------------------------------------
*/





DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ETL.KMO_ARTBEW_PAYBACK_TMP_1;


CREATE TABLE IF NOT EXISTS KFL_PRODUCTION_DBP_ETL.KMO_ARTBEW_PAYBACK_TMP_1 LIKE KFL_PRODUCTION_DBP_DATA.ARTBEW_1;

/*
#------------------------------------------------------------------------------
# 3.) Befuellung der Temp-Tabelle kmo_artbew_payback_tmp_1
#------------------------------------------------------------------------------
#  1010: Datenherkunft FI Payback 
#------------------------------------------------------------------------------
*/

INSERT INTO KFL_PRODUCTION_DBP_ETL.KMO_ARTBEW_PAYBACK_TMP_1 (MANDANT_ID, WUP_ID, NB_ID, DAT, BEWART_ID, GP_ID, ART_ID, AKTION_ID, PROMO_FG, EAN_KASSE, EINKAUFSORGANISATION_ID, HERST_ID, MWST_ID, MENGE, WRG_1, UMSATZ_NETTO, DIFF_UMSATZ_NETTO_KONZ, UMSATZ_MWST_BETRAG, DIFF_UMSATZ_MWST_BETRAG_KONZ, EK_BRUTTO, DIFF_EK_BRUTTO_KONZ, EK_NETTO, DIFF_EK_NETTO_KONZ, EK_NETTONETTO, DIFF_EK_NETTONETTO_KONZ, EK_KAL_BASIS, DIFF_EK_KAL_BASIS_KONZ, EK_MEP, DIFF_EK_MEP_KONZ, EINSTANDSPREIS, DIFF_EINSTANDSPREIS_KONZ, LOGKOSTENZUSCHLAG, DIFF_LOGKOSTENZUSCHLAG_KONZ, BEZUGSWEG_ID, EK_NETTO_BNK, DIFF_EK_NETTO_BNK_KONZ, EK_NETTO_BNK_SACHK, DIFF_EK_NETTO_BNK_SACHK_KONZ, POSTEN_ID, BQ_FINDUNG_ID, EK_GLD, DIFF_EK_GLD_KONZ)
  SELECT
      T1.MANDANT_ID,
      T1.WUP_ID,
      T1.NB_ID,
      T1.DAT_BUCH AS DAT,
      1010 AS BEWART_ID,
      -1 AS GP_ID,
      T1.ART_ID,
      '          ' AS AKTION_ID,
      0 AS PROMO_FG,
      0 AS EAN_KASSE,
      T3.EINKAUFSORGANISATION_ID,
      -1 AS HERST_ID,
      T4.MWST_ID,
      0 AS MENGE,
      T1.WRG_ID AS WRG_1,
      T1.BETRAG_FI_BELEG_SUM AS UMSATZ_NETTO,
      0 AS DIFF_UMSATZ_NETTO_KONZ,
      0 AS UMSATZ_MWST_BETRAG,
      0 AS DIFF_UMSATZ_MWST_BETRAG_KONZ,
      T5.ZERO_ENC AS EK_BRUTTO,
      T5.ZERO_ENC AS DIFF_EK_BRUTTO_KONZ,
      T5.ZERO_ENC AS EK_NETTO,
      T5.ZERO_ENC AS DIFF_EK_NETTO_KONZ,
      T5.ZERO_ENC AS EK_NETTONETTO,
      T5.ZERO_ENC AS DIFF_EK_NETTONETTO_KONZ,
      T5.ZERO_ENC AS EK_KAL_BASIS,
      T5.ZERO_ENC AS DIFF_EK_KAL_BASIS_KONZ,
      T5.ZERO_ENC AS EK_MEP,
      T5.ZERO_ENC AS DIFF_EK_MEP_KONZ,
      T5.ZERO_ENC AS EINSTANDSPREIS,
      T5.ZERO_ENC AS DIFF_EINSTANDSPREIS_KONZ,
      0 AS LOGKOSTENZUSCHLAG,
      0 AS DIFF_LOGKOSTENZUSCHLAG_KONZ,
      1 AS BEZUGSWEG_ID,
      T5.ZERO_ENC AS EK_NETTO_BNK,
      T5.ZERO_ENC AS DIFF_EK_NETTO_BNK_KONZ,
      T5.ZERO_ENC AS EK_NETTO_BNK_SACHK,
      T5.ZERO_ENC AS DIFF_EK_NETTO_BNK_SACHK_KONZ,
      substr(substr(CAST(0 as STRING), 1, 16777216), 1, 2) AS POSTEN_ID,
      25 AS BQ_FINDUNG_ID,
      0 AS EK_GLD,
      0 AS DIFF_EK_GLD_KONZ
    FROM
      KFL_PRODUCTION_DBP_ETL_PROCESS.IN_FI_BELEG_DET_AGG_PAYBACK_1 AS T1_1
      INNER JOIN KFL_PRODUCTION_DBP_DATA.L_EINKAUFSORGANISATION_1 AS T3 ON T1.MANDANT_ID = T3.MANDANT_ID
      INNER JOIN (
        SELECT
            MWST_PER.MANDANT_ID,
            max(MWST_PER.MWST_ID) AS MWST_ID
          FROM
            KFL_PRODUCTION_DBP_DATA.MWST_PER_1
          WHERE MWST_PER.DAT_BIS = PARSE_DATE('%Y%m%d', '99991231')
           AND MWST_PER.MWST = 0
          GROUP BY 1
      ) AS T4 ON T1.MANDANT_ID = T4.MANDANT_ID
      INNER JOIN (
        SELECT
            MANDANT.MANDANT_ID,
            0 AS ZERO_ENC
          FROM
            KFL_PRODUCTION_DBP_DATA.MANDANT_1
      ) AS T5 ON T1.MANDANT_ID = T5.MANDANT_ID
       AND (CAST(T1.VERARBEITET_FG as INT64)>> 2)&1 = 0
;

/*
#------------------------------------------------------------------------------
# 5.) Berechnung der Umsaetze in Euro Waehrung
#     (ACHTUNG: Berechnung mit Kurstyp 3 und nicht wie bei Artbew_1 mit Kurstyp 9)
#------------------------------------------------------------------------------
*/


UPDATE KFL_PRODUCTION_DBP_ETL.KMO_ARTBEW_PAYBACK_TMP_1 SET
 DIFF_UMSATZ_NETTO_KONZ = ROUND(CAST(KMO_ARTBEW_PAYBACK_TMP.UMSATZ_NETTO * K.UMRECHNUNGSKURS AS NUMERIC), 4) FROM
 KFL_PRODUCTION_DBP_DATA.KURS_1 AS K
WHERE KMO_ARTBEW_PAYBACK_TMP.WRG_1 = K.VON_WRG_ID AND KMO_ARTBEW_PAYBACK_TMP.DAT BETWEEN K.DAT_VON AND K.DAT_BIS AND K.NACH_WRG_ID
    = 'EUR' AND K.KURSTYP_ID = 9;


/*
#------------------------------------------------------------------------------
# 6.) Loeschen der bestehenden Daten aus der Zieltabelle artbew_1
#     
#------------------------------------------------------------------------------
*/

DELETE FROM KFL_PRODUCTION_DBP_DATA.ARTBEW_1
WHERE BEWART_ID = 1010 AND (MANDANT_ID, WUP_ID, NB_ID, DAT) IN (SELECT (MANDANT_ID, WUP_ID, NB_ID, DAT)
   FROM KFL_PRODUCTION_DBP_ETL.KMO_ARTBEW_PAYBACK_TMP_1);

/*
#------------------------------------------------------------------------------
# 7.) Befuellung der artbew_1
#------------------------------------------------------------------------------
*/

INSERT INTO KFL_PRODUCTION_DBP_DATA.ARTBEW_1 (MANDANT_ID, WUP_ID, BEWART_ID, GP_ID, NB_ID, ART_ID, DAT, AKTION_ID, PROMO_FG, EAN_KASSE, EINKAUFSORGANISATION_ID, HERST_ID, MWST_ID, MENGE, WRG_1, UMSATZ_NETTO, DIFF_UMSATZ_NETTO_KONZ, UMSATZ_MWST_BETRAG, DIFF_UMSATZ_MWST_BETRAG_KONZ, EK_BRUTTO, DIFF_EK_BRUTTO_KONZ, EK_NETTO, DIFF_EK_NETTO_KONZ, EK_NETTONETTO, DIFF_EK_NETTONETTO_KONZ, EK_KAL_BASIS, DIFF_EK_KAL_BASIS_KONZ, EK_MEP, DIFF_EK_MEP_KONZ, EINSTANDSPREIS, DIFF_EINSTANDSPREIS_KONZ, LOGKOSTENZUSCHLAG, DIFF_LOGKOSTENZUSCHLAG_KONZ, BEZUGSWEG_ID, EK_NETTO_BNK, DIFF_EK_NETTO_BNK_KONZ, EK_NETTO_BNK_SACHK, DIFF_EK_NETTO_BNK_SACHK_KONZ, POSTEN_ID, BQ_FINDUNG_ID, EK_GLD, DIFF_EK_GLD_KONZ)
  SELECT
      T.MANDANT_ID,
      T.WUP_ID,
      T.BEWART_ID,
      T.GP_ID,
      T.NB_ID,
      T.ART_ID,
      T.DAT,
      T.AKTION_ID,
      T.PROMO_FG,
      T.EAN_KASSE,
      T.EINKAUFSORGANISATION_ID,
      T.HERST_ID,
      T.MWST_ID,
      T.MENGE,
      T.WRG_1,
      T.UMSATZ_NETTO,
      T.DIFF_UMSATZ_NETTO_KONZ,
      T.UMSATZ_MWST_BETRAG,
      T.DIFF_UMSATZ_MWST_BETRAG_KONZ,
      T.EK_BRUTTO,
      T.DIFF_EK_BRUTTO_KONZ,
      T.EK_NETTO,
      T.DIFF_EK_NETTO_KONZ,
      T.EK_NETTONETTO,
      T.DIFF_EK_NETTONETTO_KONZ,
      T.EK_KAL_BASIS,
      T.DIFF_EK_KAL_BASIS_KONZ,
      T.EK_MEP,
      T.DIFF_EK_MEP_KONZ,
      T.EINSTANDSPREIS,
      T.DIFF_EINSTANDSPREIS_KONZ,
      T.LOGKOSTENZUSCHLAG,
      T.DIFF_LOGKOSTENZUSCHLAG_KONZ,
      T.BEZUGSWEG_ID,
      T.EK_NETTO_BNK,
      T.DIFF_EK_NETTO_BNK_KONZ,
      T.EK_NETTO_BNK_SACHK,
      T.DIFF_EK_NETTO_BNK_SACHK_KONZ,
      T.POSTEN_ID,
      T.BQ_FINDUNG_ID,
      T.EK_GLD,
      T.DIFF_EK_GLD_KONZ
    FROM
      KFL_PRODUCTION_DBP_ETL.KMO_ARTBEW_PAYBACK_TMP_1 T
;

UPDATE KFL_PRODUCTION_DBP_ETL_PROCESS.IN_FI_BELEG_DET_AGG_PAYBACK_1 AS target
SET
  VERARBEITET_FG = CAST(target.VERARBEITET_FG AS INT64) | (1 << 0)
WHERE EXISTS (
  SELECT 1
  FROM KFL_PRODUCTION_DBP_ETL.KMO_ARTBEW_PAYBACK_TMP_1 AS src
  WHERE target.MANDANT_ID = src.MANDANT_ID
    AND target.WUP_ID       = src.WUP_ID
    AND target.DAT_BUCH     = src.DAT
);

/*
#------------------------------------------------------------------------------
# 10.) Fullen der dbp_etl_process.artbew_agg_wt_1
#------------------------------------------------------------------------------
*/


INSERT INTO KFL_PRODUCTION_DBP_DATA.ARTBEW_AGG_WT_1 (MANDANT_ID, WUP_ID, NB_ID, DAT)
(SELECT MANDANT_ID,
  WUP_ID,
  NB_ID,
  DAT
 FROM KFL_PRODUCTION_DBP_ETL.KMO_ARTBEW_PAYBACK_TMP_1
 WHERE (MANDANT_ID, WUP_ID, NB_ID, DAT) NOT IN (SELECT (MANDANT_ID, WUP_ID, NB_ID, DAT)
    FROM KFL_PRODUCTION_DBP_DATA.ARTBEW_AGG_WT_1)
 GROUP BY MANDANT_ID,
  WUP_ID,
  NB_ID,
  DAT);

/*
#------------------------------------------------------------------------------
# 11.) Bteq beenden
#------------------------------------------------------------------------------
*/