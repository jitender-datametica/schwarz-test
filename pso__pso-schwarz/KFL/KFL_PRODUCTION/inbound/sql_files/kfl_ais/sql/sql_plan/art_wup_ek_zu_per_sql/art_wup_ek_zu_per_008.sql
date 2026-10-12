--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_wup_gp_tmp2  (
   mandant_id BYTEINT NOT NULL
  ,wup_id INTEGER
  ,nb_id SMALLINT
  ,bezugsweg_id BYTEINT
  ,art_id INTEGER
  ,gp_id INTEGER
  ,einkaufsorganisation_id SMALLINT
  ,dat DATE NOT NULL
  ,ek_netto                 DECIMAL(18,4) 
  ,ek_netto_bnk             DECIMAL(18,4) 
  ,ek_mep                   DECIMAL(18,4) 
  ,einstandspreis           DECIMAL(18,4) 
  ,ek_nettonetto            DECIMAL(18,4) 
  ,komponentenmenge DECIMAL(9,4) NOT NULL DEFAULT 1.0000  ,wrg_id CHAR(3)
  ,dat_von DATE
  ,dat_bis DATE
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT dat_relevant FROM DBP_ETL.art_wup_ek_datum_relevant;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp
--(
--   mandant_id
--  ,wup_id
--  ,nb_id
--  ,bezugsweg_id
--  ,art_id
--  ,gp_id
--  ,einkaufsorganisation_id
--  ,dat
--  ,verarbeitet_fg
--)
--SELECT
--   ag.mandant_id
--  ,w.wup_id
--  ,w.nb_id
--  ,w.bezugsweg_id
--  ,ag.art_id
--  ,ag.gp_id
--  ,ag.einkaufsorganisation_id
--  ,dat_relevant
--  ,0 AS verarbeitet_fg
--FROM ${DWH_COMMON_DBX_DATA}.art_gp_zu_per ag
--
--INNER JOIN
--(
--  SELECT
--    gp_id, einkaufsorganisation_id
--  FROM ${DWH_COMMON_DBX_DATA}.gp
--  WHERE mandant_id = ${MID}
--  GROUP BY gp_id
--  QUALIFY CSUM(1, einkaufsorganisation_id asc) = 1
--) g
--ON ag.gp_id = g.gp_id
-- AND ag.einkaufsorganisation_id = g.einkaufsorganisation_id
--
--INNER JOIN ${DWH_COMMON_DBX_LOAD}.art_wup_ek_datum_relevant r
--ON 1 = 1
--
--INNER JOIN
--(
--  SELECT wup_id, nb_id, bezugsweg_id
--  FROM ${DWH_COMMON_DBX_DATA}.art_gp_wup_zu_per
--  WHERE mandant_id = ${MID}
--    AND nb_id IS NOT NULL
--    AND wup_id/100 = 69
--    AND ${DWH_COMMON_DBX_LOAD}.art_wup_ek_datum_relevant.dat_relevant
--      BETWEEN dat_von AND dat_bis
--  GROUP  BY 1,2,3
--  UNION
--  SELECT
--    -1 AS wup_id, -1 AS nb_id, 1 AS bezugsweg_id
--  FROM ${DWH_COMMON_DBX_LOAD}.art_wup_ek_datum_relevant
--) w
--ON 1 = 1
--
--WHERE r.dat_relevant BETWEEN ag.dat_von AND ag.dat_bis
--  AND ag.mandant_id = ${MID}
--;
--
--Comment from validation checker
--error line 32 at position 42 unexpected 'asc'.
--  QUALIFY CSUM(1, einkaufsorganisation_id  ^^^> asc) = 1
--translated statement
INSERT INTO DBP_ETL.art_wup_gp_tmp
(
   mandant_id
  ,wup_id
  ,nb_id
  ,bezugsweg_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,dat
  ,verarbeitet_fg
)
SELECT
   ag.mandant_id
  ,w.wup_id
  ,w.nb_id
  ,w.bezugsweg_id
  ,ag.art_id
  ,ag.gp_id
  ,ag.einkaufsorganisation_id
  ,dat_relevant
  ,0 AS verarbeitet_fg
FROM DBP_DATA.art_gp_zu_per ag

INNER JOIN
(
  SELECT
    gp_id, einkaufsorganisation_id
  FROM DBP_DATA.gp
  WHERE mandant_id = ${MID}
  GROUP BY gp_id
  QUALIFY CSUM(1, einkaufsorganisation_id asc) = 1
) g
ON ag.gp_id = g.gp_id
 AND ag.einkaufsorganisation_id = g.einkaufsorganisation_id

INNER JOIN DBP_ETL.art_wup_ek_datum_relevant r
ON 1 = 1

INNER JOIN
(
  SELECT wup_id, nb_id, bezugsweg_id
  FROM DBP_DATA.art_gp_wup_zu_per
  WHERE mandant_id = ${MID}
    AND nb_id IS NOT NULL
    AND wup_id/100 = 69
    AND DBP_ETL.art_wup_ek_datum_relevant.dat_relevant
      BETWEEN dat_von AND dat_bis
  GROUP  BY 1,2,3
  UNION
  SELECT
    -1 AS wup_id, -1 AS nb_id, 1 AS bezugsweg_id
  FROM DBP_ETL.art_wup_ek_datum_relevant
) w
ON 1 = 1

WHERE r.dat_relevant BETWEEN ag.dat_von AND ag.dat_bis
  AND ag.mandant_id = ${MID}
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.art_wup_gp_tmp where wup_id in (6911,6912,6914,6916);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2
--(
--   mandant_id
--  ,wup_id
--  ,nb_id
--  ,bezugsweg_id
--  ,art_id
--  ,gp_id
--  ,dat
--  ,ek_netto
--  ,ek_netto_bnk
--  ,ek_mep
--  ,einstandspreis
--  ,ek_nettonetto
--  ,komponentenmenge
--  ,wrg_id
--  ,dat_von
--  ,dat_bis
--)
--SELECT
--   tmp.mandant_id
--  ,tmp.wup_id
--  ,tmp.nb_id
--  ,tmp.bezugsweg_id
--  ,tmp.art_id
--  ,tmp.gp_id
--  ,tmp.dat
--  ,agw.ek_netto
--  ,agw.ek_netto_bnk
--  ,agw.ek_mep
--  ,agw.einstandspreis
--  ,agw.ek_nettonetto
--  ,COALESCE(agw.komponentenmenge, 1.0000)
--  ,COALESCE(agw.wrg_id, 'EUR')
--  ,agw.dat_von
--  ,80991231 AS dat_bis
--FROM ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp tmp
--
--/* dezentral, Lager = -1, richtiger GP, richtiges Datum */
--INNER JOIN
--(
--  SELECT
--     agw.art_id
--    ,agw.wup_id
--    ,agw.nb_id
--    ,agw.gp_id
--    ,agw.ek_netto
--    ,agw.ek_netto_bnk
--    ,agw.ek_mep
--    ,agw.einstandspreis
--    ,agw.ek_nettonetto
--    ,agw.komponentenmenge
--    ,agw.wrg_id
--    ,agw.dat_von
--    ,agw.dat_bis
--  FROM ${DWH_COMMON_DBX_DATA}.art_gp_wup_zu_per agw
--
--  INNER JOIN
--  (
--    SELECT
--      gp_id, einkaufsorganisation_id
--    FROM ${DWH_COMMON_DBX_DATA}.gp
--    WHERE mandant_id = ${MID}
--    GROUP BY gp_id
--    QUALIFY CSUM(1, einkaufsorganisation_id asc) = 1
--  ) g
--  ON agw.gp_id = g.gp_id
--   AND agw.einkaufsorganisation_id = g.einkaufsorganisation_id
--
--  WHERE agw.wup_id = -1                             /* wup = -1 bei dezentral */
--    AND agw.bezugsweg_id = 1                        /* dezentral */
--    AND CAST(${DWH_COMMON_PTY_DEC}(agw.ek_netto ${DWH_COMMON_PTY_KEY_DEC}) AS DECIMAL(18,4)) > 0 /* der ek_netto muss positiv sein */
--    AND agw.mandant_id = ${MID}
--) agw
--ON tmp.art_id = agw.art_id
--  AND tmp.gp_id = agw.gp_id                         /* richtier Lieferant */
--  AND tmp.dat BETWEEN agw.dat_von AND agw.dat_bis   /* richtiges Datum */
--  AND -1 = agw.wup_id                               /* wup = -1 bei dezentral */
--
--WHERE tmp.bezugsweg_id = 1
--;
--
--Comment from validation checker
--error line 65 at position 44 unexpected 'asc'.
--    QUALIFY CSUM(1, einkaufsorganisation_id  ^^^> asc) = 1
--syntax error line 67 at position 2 unexpected 'ON'.
--   ^^^> ON agw.gp_id = g.gp_id
--translated statement
INSERT INTO DBP_ETL.art_wup_gp_tmp2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,bezugsweg_id
  ,art_id
  ,gp_id
  ,dat
  ,ek_netto
  ,ek_netto_bnk
  ,ek_mep
  ,einstandspreis
  ,ek_nettonetto
  ,komponentenmenge
  ,wrg_id
  ,dat_von
  ,dat_bis
)
SELECT
   tmp.mandant_id
  ,tmp.wup_id
  ,tmp.nb_id
  ,tmp.bezugsweg_id
  ,tmp.art_id
  ,tmp.gp_id
  ,tmp.dat
  ,agw.ek_netto
  ,agw.ek_netto_bnk
  ,agw.ek_mep
  ,agw.einstandspreis
  ,agw.ek_nettonetto
  ,COALESCE(agw.komponentenmenge, 1.0000)
  ,COALESCE(agw.wrg_id, 'EUR')
  ,agw.dat_von
  , to_date('9999-12-31','YYYY-MM-DD') AS dat_bis
FROM DBP_ETL.art_wup_gp_tmp tmp

/* dezentral, Lager = -1, richtiger GP, richtiges Datum */
INNER JOIN
(
  SELECT
     agw.art_id
    ,agw.wup_id
    ,agw.nb_id
    ,agw.gp_id
    ,agw.ek_netto
    ,agw.ek_netto_bnk
    ,agw.ek_mep
    ,agw.einstandspreis
    ,agw.ek_nettonetto
    ,agw.komponentenmenge
    ,agw.wrg_id
    ,agw.dat_von
    ,agw.dat_bis
  FROM DBP_DATA.art_gp_wup_zu_per agw

  INNER JOIN
  (
    SELECT
      gp_id, einkaufsorganisation_id
    FROM DBP_DATA.gp
    WHERE mandant_id = ${MID}
    GROUP BY gp_id
    QUALIFY CSUM(1, einkaufsorganisation_id asc) = 1
  ) g
  ON agw.gp_id = g.gp_id
   AND agw.einkaufsorganisation_id = g.einkaufsorganisation_id

  WHERE agw.wup_id = -1                             /* wup = -1 bei dezentral */
    AND agw.bezugsweg_id = 1                        /* dezentral */
    AND CAST((agw.ek_netto ) AS DECIMAL(18,4)) > 0 /* der ek_netto muss positiv sein */
    AND agw.mandant_id = ${MID}
) agw
ON tmp.art_id = agw.art_id
  AND tmp.gp_id = agw.gp_id                         /* richtier Lieferant */
  AND tmp.dat BETWEEN agw.dat_von AND agw.dat_bis   /* richtiges Datum */
  AND -1 = agw.wup_id                               /* wup = -1 bei dezentral */

WHERE tmp.bezugsweg_id = 1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2
--(
--   mandant_id
--  ,wup_id
--  ,nb_id
--  ,bezugsweg_id
--  ,art_id
--  ,gp_id
--  ,dat
--  ,ek_netto
--  ,ek_netto_bnk
--  ,ek_mep
--  ,einstandspreis
--  ,ek_nettonetto
--  ,komponentenmenge
--  ,wrg_id
--  ,dat_von
--  ,dat_bis
--)
--SELECT
--   tmp.mandant_id
--  ,tmp.wup_id
--  ,tmp.nb_id
--  ,tmp.bezugsweg_id
--  ,tmp.art_id
--  ,tmp.gp_id
--  ,tmp.dat
--  ,agw.ek_netto
--  ,agw.ek_netto_bnk
--  ,agw.ek_mep
--  ,agw.einstandspreis
--  ,agw.ek_nettonetto
--  ,COALESCE(agw.komponentenmenge, 1.0000)
--  ,COALESCE(agw.wrg_id, 'EUR')
--  ,agw.dat_von
--  ,80991231 AS dat_bis
--FROM ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp tmp
--
--INNER JOIN ${DWH_COMMON_DBX_DATA}.art_wg_zu_per awz
--ON tmp.dat BETWEEN awz.dat_von AND awz.dat_bis
--  AND awz.art_id = tmp.art_id
--  AND awz.mandant_id = 1
--  AND awz.arthiertyp_id = 2
--  
--LEFT JOIN ${DWH_COMMON_DBX_DATA}.wg_filter_zu AS wgfz
--  ON wgfz.wg_id         = awz.wg_id
-- AND wgfz.mandant_id    = awz.mandant_id
-- AND wgfz.arthiertyp_id = awz.arthiertyp_id
-- AND wgfz.wg_filter_id  = 20
--
--/* zentral, Lager = 6906 oder 6907, richtiger GP, richtiges Datum */
--INNER JOIN
--(
--  SELECT
--     agw.art_id
--    ,agw.wup_id
--    ,agw.nb_id
--    ,agw.gp_id
--    ,agw.ek_netto
--    ,agw.ek_netto_bnk
--    ,agw.ek_mep
--    ,agw.einstandspreis
--    ,agw.ek_nettonetto
--    ,agw.komponentenmenge
--    ,agw.wrg_id
--    ,agw.dat_von
--    ,agw.dat_bis
--  FROM ${DWH_COMMON_DBX_DATA}.art_gp_wup_zu_per agw
--
--  INNER JOIN
--  (
--    SELECT
--      gp_id, einkaufsorganisation_id
--    FROM ${DWH_COMMON_DBX_DATA}.gp
--    WHERE mandant_id = ${MID}
--    GROUP BY gp_id
--    QUALIFY CSUM(1, einkaufsorganisation_id asc) = 1
--  ) g
--  ON agw.gp_id = g.gp_id
--   AND agw.einkaufsorganisation_id = g.einkaufsorganisation_id
--
--  WHERE agw.bezugsweg_id = 4                        /* zentral */
--    AND CAST(${DWH_COMMON_PTY_DEC}(agw.ek_netto ${DWH_COMMON_PTY_KEY_DEC}) AS DECIMAL(18,4)) > 0  /* der ek_netto muss positiv sein */
--    AND agw.mandant_id = ${MID}
--) agw
--ON tmp.art_id = agw.art_id
--  AND tmp.gp_id = agw.gp_id                         /* richtier Lieferant */
--  AND tmp.dat BETWEEN agw.dat_von AND agw.dat_bis   /* richtiges Datum */
--  AND CASE WHEN (tmp.wup_id/100 = 69)               /* bei VZ mit echter wup_id suchen*/
--           THEN tmp.wup_id
--           ELSE (CASE WHEN wgfz.wg_id IS NOT NULL   THEN 6907 /*Nonfood*/
--                      ELSE 6906 /*Food*/
--                 END)                               /* wup = 6906 oder 6907 bei zentral und markt */
--      END = agw.wup_id
--
--WHERE tmp.bezugsweg_id = 4
--
--;
--
--Comment from validation checker
--error line 77 at position 44 unexpected 'asc'.
--    QUALIFY CSUM(1, einkaufsorganisation_id  ^^^> asc) = 1
--syntax error line 79 at position 2 unexpected 'ON'.
--   ^^^> ON agw.gp_id = g.gp_id
--translated statement
INSERT INTO DBP_ETL.art_wup_gp_tmp2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,bezugsweg_id
  ,art_id
  ,gp_id
  ,dat
  ,ek_netto
  ,ek_netto_bnk
  ,ek_mep
  ,einstandspreis
  ,ek_nettonetto
  ,komponentenmenge
  ,wrg_id
  ,dat_von
  ,dat_bis
)
SELECT
   tmp.mandant_id
  ,tmp.wup_id
  ,tmp.nb_id
  ,tmp.bezugsweg_id
  ,tmp.art_id
  ,tmp.gp_id
  ,tmp.dat
  ,agw.ek_netto
  ,agw.ek_netto_bnk
  ,agw.ek_mep
  ,agw.einstandspreis
  ,agw.ek_nettonetto
  ,COALESCE(agw.komponentenmenge, 1.0000)
  ,COALESCE(agw.wrg_id, 'EUR')
  ,agw.dat_von
  , to_date('9999-12-31','YYYY-MM-DD') AS dat_bis
FROM DBP_ETL.art_wup_gp_tmp tmp

INNER JOIN DBP_DATA.art_wg_zu_per awz
ON tmp.dat BETWEEN awz.dat_von AND awz.dat_bis
  AND awz.art_id = tmp.art_id
  AND awz.mandant_id = 1
  AND awz.arthiertyp_id = 2
  
LEFT JOIN DBP_DATA.wg_filter_zu AS wgfz
  ON wgfz.wg_id         = awz.wg_id
 AND wgfz.mandant_id    = awz.mandant_id
 AND wgfz.arthiertyp_id = awz.arthiertyp_id
 AND wgfz.wg_filter_id  = 20

/* zentral, Lager = 6906 oder 6907, richtiger GP, richtiges Datum */
INNER JOIN
(
  SELECT
     agw.art_id
    ,agw.wup_id
    ,agw.nb_id
    ,agw.gp_id
    ,agw.ek_netto
    ,agw.ek_netto_bnk
    ,agw.ek_mep
    ,agw.einstandspreis
    ,agw.ek_nettonetto
    ,agw.komponentenmenge
    ,agw.wrg_id
    ,agw.dat_von
    ,agw.dat_bis
  FROM DBP_DATA.art_gp_wup_zu_per agw

  INNER JOIN
  (
    SELECT
      gp_id, einkaufsorganisation_id
    FROM DBP_DATA.gp
    WHERE mandant_id = ${MID}
    GROUP BY gp_id
    QUALIFY CSUM(1, einkaufsorganisation_id asc) = 1
  ) g
  ON agw.gp_id = g.gp_id
   AND agw.einkaufsorganisation_id = g.einkaufsorganisation_id

  WHERE agw.bezugsweg_id = 4                        /* zentral */
    AND CAST((agw.ek_netto ) AS DECIMAL(18,4)) > 0  /* der ek_netto muss positiv sein */
    AND agw.mandant_id = ${MID}
) agw
ON tmp.art_id = agw.art_id
  AND tmp.gp_id = agw.gp_id                         /* richtier Lieferant */
  AND tmp.dat BETWEEN agw.dat_von AND agw.dat_bis   /* richtiges Datum */
  AND CASE WHEN (tmp.wup_id/100 = 69)               /* bei VZ mit echter wup_id suchen*/
           THEN tmp.wup_id
           ELSE (CASE WHEN wgfz.wg_id IS NOT NULL   THEN 6907 /*Nonfood*/
                      ELSE 6906 /*Food*/
                 END)                               /* wup = 6906 oder 6907 bei zentral und markt */
      END = agw.wup_id

WHERE tmp.bezugsweg_id = 4

;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--UPDATE ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp
--SET verarbeitet_fg = 1
--
--WHERE ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp.mandant_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.mandant_id AND
--      ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp.wup_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.wup_id AND
--      ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp.nb_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.nb_id AND
--      ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp.bezugsweg_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.bezugsweg_id AND
--      ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp.art_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.art_id AND
--      ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp.gp_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.gp_id
--;
--
--Comment from validation checker
--error line 4 at position 42
--WHERE DBP_ETL.art_wup_gp_tmp.mandant_id =  ^^^> DBP_ETL.art_wup_gp_tmp2.mandant_id AND
--invalid identifier 'DBP_ETL.ART_WUP_GP_TMP2.MANDANT_ID'
--translated statement
UPDATE DBP_ETL.art_wup_gp_tmp
SET verarbeitet_fg = 1

WHERE DBP_ETL.art_wup_gp_tmp.mandant_id = DBP_ETL.art_wup_gp_tmp2.mandant_id AND
      DBP_ETL.art_wup_gp_tmp.wup_id = DBP_ETL.art_wup_gp_tmp2.wup_id AND
      DBP_ETL.art_wup_gp_tmp.nb_id = DBP_ETL.art_wup_gp_tmp2.nb_id AND
      DBP_ETL.art_wup_gp_tmp.bezugsweg_id = DBP_ETL.art_wup_gp_tmp2.bezugsweg_id AND
      DBP_ETL.art_wup_gp_tmp.art_id = DBP_ETL.art_wup_gp_tmp2.art_id AND
      DBP_ETL.art_wup_gp_tmp.gp_id = DBP_ETL.art_wup_gp_tmp2.gp_id
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2
--(
--   mandant_id
--  ,wup_id
--  ,nb_id
--  ,bezugsweg_id
--  ,art_id
--  ,gp_id
--  ,dat
--  ,ek_netto
--  ,ek_netto_bnk
--  ,ek_mep
--  ,einstandspreis
--  ,ek_nettonetto
--  ,komponentenmenge
--  ,wrg_id
--  ,dat_von
--  ,dat_bis
--)
--SELECT
--   tmp.mandant_id
--  ,tmp.wup_id
--  ,tmp.nb_id
--  ,tmp.bezugsweg_id
--  ,tmp.art_id
--  ,tmp.gp_id
--  ,tmp.dat
--  ,agw.ek_netto
--  ,agw.ek_netto_bnk
--  ,agw.ek_mep
--  ,agw.einstandspreis
--  ,agw.ek_nettonetto
--  ,COALESCE(agw.komponentenmenge, 1.0000)
--  ,COALESCE(agw.wrg_id, 'EUR')
--  ,agw.dat_von
--  ,80991231 AS dat_bis
--FROM ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp tmp
--
--/* dezentral, Lager = -1, richtiger GP, richtiges Datum */
--INNER JOIN
--(
--  SELECT
--     agw.art_id
--    ,agw.wup_id
--    ,agw.nb_id
--    ,agw.gp_id
--    ,agw.ek_netto
--    ,agw.ek_netto_bnk
--    ,agw.ek_mep
--    ,agw.einstandspreis
--    ,agw.ek_nettonetto
--    ,agw.komponentenmenge
--    ,agw.wrg_id
--    ,agw.dat_von
--    ,agw.dat_bis
--  FROM ${DWH_COMMON_DBX_DATA}.art_gp_wup_zu_per agw
--
--  INNER JOIN
--  (
--    SELECT
--      gp_id, einkaufsorganisation_id
--    FROM ${DWH_COMMON_DBX_DATA}.gp
--    WHERE mandant_id = ${MID}
--    GROUP BY gp_id
--    QUALIFY CSUM(1, einkaufsorganisation_id asc) = 1
--  ) g
--  ON agw.gp_id = g.gp_id
--   AND agw.einkaufsorganisation_id = g.einkaufsorganisation_id
--
--  WHERE agw.wup_id = -1                             /* wup = -1 bei dezentral */
--    AND agw.bezugsweg_id = 1                        /* dezentral */
--    AND CAST(${DWH_COMMON_PTY_DEC}(agw.ek_netto ${DWH_COMMON_PTY_KEY_DEC}) AS DECIMAL(18,4)) > 0  /* der ek_netto muss positiv sein */
--    AND agw.mandant_id = ${MID}
--) agw
--ON tmp.art_id = agw.art_id
--  AND tmp.gp_id = agw.gp_id                         /* richtier Lieferant */
--  AND tmp.dat BETWEEN agw.dat_von AND agw.dat_bis   /* richtiges Datum */
--  AND -1 = agw.wup_id                               /* wup = -1 bei dezentral */
--
--WHERE tmp.bezugsweg_id = 4
--  AND verarbeitet_fg = 0
--;
--
--Comment from validation checker
--error line 65 at position 44 unexpected 'asc'.
--    QUALIFY CSUM(1, einkaufsorganisation_id  ^^^> asc) = 1
--syntax error line 67 at position 2 unexpected 'ON'.
--   ^^^> ON agw.gp_id = g.gp_id
--translated statement
INSERT INTO DBP_ETL.art_wup_gp_tmp2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,bezugsweg_id
  ,art_id
  ,gp_id
  ,dat
  ,ek_netto
  ,ek_netto_bnk
  ,ek_mep
  ,einstandspreis
  ,ek_nettonetto
  ,komponentenmenge
  ,wrg_id
  ,dat_von
  ,dat_bis
)
SELECT
   tmp.mandant_id
  ,tmp.wup_id
  ,tmp.nb_id
  ,tmp.bezugsweg_id
  ,tmp.art_id
  ,tmp.gp_id
  ,tmp.dat
  ,agw.ek_netto
  ,agw.ek_netto_bnk
  ,agw.ek_mep
  ,agw.einstandspreis
  ,agw.ek_nettonetto
  ,COALESCE(agw.komponentenmenge, 1.0000)
  ,COALESCE(agw.wrg_id, 'EUR')
  ,agw.dat_von
  , to_date('9999-12-31','YYYY-MM-DD') AS dat_bis
FROM DBP_ETL.art_wup_gp_tmp tmp

/* dezentral, Lager = -1, richtiger GP, richtiges Datum */
INNER JOIN
(
  SELECT
     agw.art_id
    ,agw.wup_id
    ,agw.nb_id
    ,agw.gp_id
    ,agw.ek_netto
    ,agw.ek_netto_bnk
    ,agw.ek_mep
    ,agw.einstandspreis
    ,agw.ek_nettonetto
    ,agw.komponentenmenge
    ,agw.wrg_id
    ,agw.dat_von
    ,agw.dat_bis
  FROM DBP_DATA.art_gp_wup_zu_per agw

  INNER JOIN
  (
    SELECT
      gp_id, einkaufsorganisation_id
    FROM DBP_DATA.gp
    WHERE mandant_id = ${MID}
    GROUP BY gp_id
    QUALIFY CSUM(1, einkaufsorganisation_id asc) = 1
  ) g
  ON agw.gp_id = g.gp_id
   AND agw.einkaufsorganisation_id = g.einkaufsorganisation_id

  WHERE agw.wup_id = -1                             /* wup = -1 bei dezentral */
    AND agw.bezugsweg_id = 1                        /* dezentral */
    AND CAST((agw.ek_netto ) AS DECIMAL(18,4)) > 0  /* der ek_netto muss positiv sein */
    AND agw.mandant_id = ${MID}
) agw
ON tmp.art_id = agw.art_id
  AND tmp.gp_id = agw.gp_id                         /* richtier Lieferant */
  AND tmp.dat BETWEEN agw.dat_von AND agw.dat_bis   /* richtiges Datum */
  AND -1 = agw.wup_id                               /* wup = -1 bei dezentral */

WHERE tmp.bezugsweg_id = 4
  AND verarbeitet_fg = 0
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--UPDATE ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp
--SET verarbeitet_fg = 1
--WHERE ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp.mandant_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.mandant_id AND
--      ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp.wup_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.wup_id AND
--      ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp.nb_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.nb_id AND
--      ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp.bezugsweg_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.bezugsweg_id AND
--      ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp.art_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.art_id AND
--      ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp.gp_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.gp_id
--;
--
--Comment from validation checker
--error line 3 at position 42
--WHERE DBP_ETL.art_wup_gp_tmp.mandant_id =  ^^^> DBP_ETL.art_wup_gp_tmp2.mandant_id AND
--invalid identifier 'DBP_ETL.ART_WUP_GP_TMP2.MANDANT_ID'
--translated statement
UPDATE DBP_ETL.art_wup_gp_tmp
SET verarbeitet_fg = 1
WHERE DBP_ETL.art_wup_gp_tmp.mandant_id = DBP_ETL.art_wup_gp_tmp2.mandant_id AND
      DBP_ETL.art_wup_gp_tmp.wup_id = DBP_ETL.art_wup_gp_tmp2.wup_id AND
      DBP_ETL.art_wup_gp_tmp.nb_id = DBP_ETL.art_wup_gp_tmp2.nb_id AND
      DBP_ETL.art_wup_gp_tmp.bezugsweg_id = DBP_ETL.art_wup_gp_tmp2.bezugsweg_id AND
      DBP_ETL.art_wup_gp_tmp.art_id = DBP_ETL.art_wup_gp_tmp2.art_id AND
      DBP_ETL.art_wup_gp_tmp.gp_id = DBP_ETL.art_wup_gp_tmp2.gp_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.art_wup_gp_tmp2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,bezugsweg_id
  ,art_id
  ,gp_id
  ,dat
  ,ek_netto
  ,ek_netto_bnk
  ,ek_mep
  ,einstandspreis
  ,ek_nettonetto
  ,komponentenmenge
  ,wrg_id
  ,dat_von
  ,dat_bis
)
SELECT
   tmp.mandant_id
  ,tmp.wup_id
  ,tmp.nb_id
  ,tmp.bezugsweg_id
  ,tmp.art_id
  ,tmp.gp_id
  ,tmp.dat
  ,  (0.00  ) AS ek_netto
  ,  (0.00  ) AS ek_netto_bnk
  ,  (0.00  ) AS ek_mep
  ,  (0.00  ) AS einstandspreis
  ,  (0.00  ) AS ek_nettonetto
  ,1.0000 AS komponentenmenge
  ,'EUR' AS wrg_id
  ,tmp.dat AS dat_von
  , to_date('9999-12-31','YYYY-MM-DD') AS dat_bis
FROM DBP_ETL.art_wup_gp_tmp tmp
WHERE verarbeitet_fg = 0
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2
--WHERE ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.mandant_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.mandant_id
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.art_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.art_id
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.wup_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.wup_id
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.nb_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.nb_id
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.dat_von <= ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.dat_von
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.dat_bis = 80991231
--  AND ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.dat_bis = 80991231
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.ek_netto = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.ek_netto
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.ek_netto_bnk = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.ek_netto_bnk
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.ek_mep = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.ek_mep
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.einstandspreis = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.einstandspreis
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.ek_nettonetto = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.ek_nettonetto
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.komponentenmenge = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.komponentenmenge
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.wrg_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.wrg_id
--;
--
--Comment from validation checker
--error line 2 at position 6
--WHERE  ^^^> DBP_DATA.art_wup_ek_zu_per.mandant_id = DBP_ETL.art_wup_gp_tmp2.mandant_id
--invalid identifier 'DBP_DATA.ART_WUP_EK_ZU_PER.MANDANT_ID'
--translated statement
DELETE FROM DBP_ETL.art_wup_gp_tmp2
WHERE DBP_DATA.art_wup_ek_zu_per.mandant_id = DBP_ETL.art_wup_gp_tmp2.mandant_id
  AND DBP_DATA.art_wup_ek_zu_per.art_id = DBP_ETL.art_wup_gp_tmp2.art_id
  AND DBP_DATA.art_wup_ek_zu_per.wup_id = DBP_ETL.art_wup_gp_tmp2.wup_id
  AND DBP_DATA.art_wup_ek_zu_per.nb_id = DBP_ETL.art_wup_gp_tmp2.nb_id
  AND DBP_DATA.art_wup_ek_zu_per.dat_von <= DBP_ETL.art_wup_gp_tmp2.dat_von
  AND DBP_DATA.art_wup_ek_zu_per.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
  AND DBP_ETL.art_wup_gp_tmp2.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
  AND DBP_DATA.art_wup_ek_zu_per.ek_netto = DBP_ETL.art_wup_gp_tmp2.ek_netto
  AND DBP_DATA.art_wup_ek_zu_per.ek_netto_bnk = DBP_ETL.art_wup_gp_tmp2.ek_netto_bnk
  AND DBP_DATA.art_wup_ek_zu_per.ek_mep = DBP_ETL.art_wup_gp_tmp2.ek_mep
  AND DBP_DATA.art_wup_ek_zu_per.einstandspreis = DBP_ETL.art_wup_gp_tmp2.einstandspreis
  AND DBP_DATA.art_wup_ek_zu_per.ek_nettonetto = DBP_ETL.art_wup_gp_tmp2.ek_nettonetto
  AND DBP_DATA.art_wup_ek_zu_per.komponentenmenge = DBP_ETL.art_wup_gp_tmp2.komponentenmenge
  AND DBP_DATA.art_wup_ek_zu_per.wrg_id = DBP_ETL.art_wup_gp_tmp2.wrg_id
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per
--WHERE ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.mandant_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.mandant_id
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.art_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.art_id
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.wup_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.wup_id
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.nb_id = ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.nb_id
--  AND ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per.dat_von >= ${DWH_COMMON_DBX_LOAD}.art_wup_gp_tmp2.dat_von
--;
--
--Comment from validation checker
--error line 2 at position 46
--WHERE DBP_DATA.art_wup_ek_zu_per.mandant_id =  ^^^> DBP_ETL.art_wup_gp_tmp2.mandant_id
--invalid identifier 'DBP_ETL.ART_WUP_GP_TMP2.MANDANT_ID'
--translated statement
DELETE FROM DBP_DATA.art_wup_ek_zu_per
WHERE DBP_DATA.art_wup_ek_zu_per.mandant_id = DBP_ETL.art_wup_gp_tmp2.mandant_id
  AND DBP_DATA.art_wup_ek_zu_per.art_id = DBP_ETL.art_wup_gp_tmp2.art_id
  AND DBP_DATA.art_wup_ek_zu_per.wup_id = DBP_ETL.art_wup_gp_tmp2.wup_id
  AND DBP_DATA.art_wup_ek_zu_per.nb_id = DBP_ETL.art_wup_gp_tmp2.nb_id
  AND DBP_DATA.art_wup_ek_zu_per.dat_von >= DBP_ETL.art_wup_gp_tmp2.dat_von
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.art_wup_ek_zu_per

SET dat_bis = tmp.dat_von_ - 1
FROM
(
  SELECT
     mandant_id
    ,art_id
    ,wup_id
    ,nb_id
    ,dat_von AS dat_von_
  FROM DBP_ETL.art_wup_gp_tmp2
) AS tmp WHERE DBP_DATA.art_wup_ek_zu_per.mandant_id = tmp.mandant_id
  AND DBP_DATA.art_wup_ek_zu_per.art_id = tmp.art_id
  AND DBP_DATA.art_wup_ek_zu_per.wup_id = tmp.wup_id
  AND DBP_DATA.art_wup_ek_zu_per.nb_id = tmp.nb_id
  AND DBP_DATA.art_wup_ek_zu_per.dat_von < tmp.dat_von_
  AND DBP_DATA.art_wup_ek_zu_per.dat_bis >= tmp.dat_von_
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_wup_ek_zu_per
(
   mandant_id
  ,art_id
  ,wup_id
  ,nb_id
  ,dat_von
  ,dat_bis
  ,ek_netto
  ,ek_netto_bnk
  ,ek_mep
  ,einstandspreis
  ,ek_nettonetto
  ,komponentenmenge
  ,wrg_id
  ,kein_zekp_fg
)
SELECT
   mandant_id
  ,art_id
  ,wup_id
  ,nb_id
  ,dat_von
  ,dat_bis
  ,ek_netto
  ,ek_netto_bnk
  ,ek_mep
  ,einstandspreis
  ,ek_nettonetto
  ,komponentenmenge
  ,wrg_id
  ,0 AS kein_zekp_fg
FROM DBP_ETL.art_wup_gp_tmp2
;

