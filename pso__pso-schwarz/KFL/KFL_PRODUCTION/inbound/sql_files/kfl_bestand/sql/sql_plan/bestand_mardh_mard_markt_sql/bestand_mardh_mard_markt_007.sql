--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Possible parameter resolution issue
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.bestand_mardh_mard_tmp1
--(
--   art_id
--  ,mandant_id
--  ,wup_id
--  ,nb_id
--  ,lagerort_id
--  ,gjmo
--  ,dat
--)
--SELECT
--l.art_id
--,l.mandant_id
--,l.wup_id
--,l.nb_id
--,l.lagerort_id
--,CAST(TRIM(spkz.sap_buchungs_jahr)||CASE WHEN TRIM(spkz.buchungsperiode_id) <= 9 THEN CAST ('0'||TRIM(spkz.buchungsperiode_id) AS CHAR(2)) ELSE TRIM(spkz.buchungsperiode_id) END AS INTEGER) AS gjmo_
--,MAX(t.dat)
--FROM ${DWH_COMMON_DBX_LOAD}.bestand_mardh_mard_log l
--INNER JOIN ${DWH_COMMON_DBX_DATA}.tag t
--ON  l.dat <= t.dat
--AND t.akt_tag <= 0
--INNER JOIN ${DWH_COMMON_DBX_DATA}.sap_periode_kalender_zu spkz
--ON spkz.mandant_id = l.mandant_id
--AND spkz.kjmo = t.kjmo
--AND krk_id IN ($KRK_ID)
--AND buchungsperiode_id <=12
--
--WHERE l.mandant_id = 1 
--
--GROUP BY
--l.art_id
--,l.mandant_id
--,l.wup_id
--,l.nb_id
--,l.lagerort_id
--,gjmo_
--;
--
--Comment from validation checker
--error line 24 at position 0 unexpected 'ON'.
-- ^^^> ON spkz.mandant_id = l.mandant_id
--translated statement
INSERT INTO DBP_ETL.bestand_mardh_mard_tmp1
(
   art_id
  ,mandant_id
  ,wup_id
  ,nb_id
  ,lagerort_id
  ,gjmo
  ,dat
)
SELECT
l.art_id
,l.mandant_id
,l.wup_id
,l.nb_id
,l.lagerort_id
,CAST(TRIM(spkz.sap_buchungs_jahr)||CASE WHEN TRIM(spkz.buchungsperiode_id) <= 9 THEN CAST ('0'||TRIM(spkz.buchungsperiode_id) AS CHAR(2)) ELSE TRIM(spkz.buchungsperiode_id) END AS INTEGER) AS gjmo_
,MAX(t.dat)
FROM DBP_ETL.bestand_mardh_mard_log l
INNER JOIN DBP_DATA.tag t
ON  l.dat <= t.dat
AND t.akt_tag <= 0
INNER JOIN DBP_DATA.sap_periode_kalender_zu spkz
ON spkz.mandant_id = l.mandant_id
AND spkz.kjmo = t.kjmo
AND krk_id IN ($KRK_ID)
AND buchungsperiode_id <=12

WHERE l.mandant_id = 1 

GROUP BY
l.art_id
,l.mandant_id
,l.wup_id
,l.nb_id
,l.lagerort_id
,gjmo_
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.bestand_mardh_mard_tmp2
(
   art_id
  ,mandant_id
  ,wup_id
  ,nb_id
  ,gjmo
  ,lagerort_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_umlag_bme
  ,menge_lgbest_erp_qual_bme
  ,menge_lgbest_erp_nf_charge_bme
  ,menge_lgbest_erp_gesp_bme
  ,menge_lgbest_erp_ret_gesp_bme
)
SELECT
   art_id
  ,mandant_id
  ,wup_id
  ,nb_id
  ,gjmo
  ,lagerort_id
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_umlag_bme
  ,menge_lgbest_erp_qual_bme
  ,menge_lgbest_erp_nf_charge_bme
  ,menge_lgbest_erp_gesp_bme
  ,menge_lgbest_erp_ret_gesp_bme
FROM
( SELECT
     m.art_id
    ,m.mandant_id
    ,m.wup_id
    ,m.nb_id
    ,bmmt1.gjmo
    ,bmmt1.lagerort_id
    ,m.menge_lgbest_erp_frei_bme
    ,m.menge_lgbest_erp_qual_bme
/* Folgende Bestandsarten (-gruende) sind noch nicht implementiert, daher immer 0 */
    ,0.0                         AS menge_lgbest_erp_umlag_bme
    ,0.0                         AS menge_lgbest_erp_nf_charge_bme
    ,0.0                         AS menge_lgbest_erp_gesp_bme
    ,0.0                         AS menge_lgbest_erp_ret_gesp_bme
  FROM DBP_DATA.marktbestand_erp m
     INNER JOIN
       DBP_ETL.bestand_mardh_mard_tmp1 bmmt1
     ON  m.art_id     = bmmt1.art_id
     AND m.mandant_id = bmmt1.mandant_id
     AND m.wup_id     = bmmt1.wup_id
     AND m.nb_id      = bmmt1.nb_id
     AND m.dat        = bmmt1.dat
) tmp1
-- Nur Bestaende uebernehmen, die sich geändert haben, unveraenderte Bestaende ausfiltern
QUALIFY COUNT(*) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
                       ORDER BY gjmo ASC ROWS 1 PRECEDING) = 1
     OR SUM(menge_lgbest_erp_frei_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
                       ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_frei_bme
     OR SUM(menge_lgbest_erp_qual_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
                       ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_qual_bme
/* Folgende Bestandsarten (-gruende) sind noch nicht implementiert */
     OR SUM(menge_lgbest_erp_umlag_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
                       ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_umlag_bme
     OR SUM(menge_lgbest_erp_nf_charge_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
                       ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_nf_charge_bme
     OR SUM(menge_lgbest_erp_gesp_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
                       ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_gesp_bme
     OR SUM(menge_lgbest_erp_ret_gesp_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
                       ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_ret_gesp_bme

;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.bestand_mardh_mard_tmp3
--(
--   art_id
--  ,mandant_id
--  ,wup_id
--  ,nb_id
--  ,gjmo_ziel
--  ,gjmo_load
--  ,gjmo_bis_ziel
--  ,gjmo_bis_ziel_neu
--  ,gjmo_bis_neu
--  ,lagerort_id
--  ,mard_fg
--  ,menge_lgbest_erp_frei_bme
--  ,menge_lgbest_erp_umlag_bme
--  ,menge_lgbest_erp_qual_bme
--  ,menge_lgbest_erp_nf_charge_bme
--  ,menge_lgbest_erp_gesp_bme
--  ,menge_lgbest_erp_ret_gesp_bme
--)
--SELECT
--   m.art_id
--  ,m.mandant_id
--  ,m.wup_id
--  ,m.nb_id
--  ,m.gjmo             AS gjmo_ziel
--  ,tmp2.gjmo          AS gjmo_load
--  ,m.gjmo_bis         AS gjmo_bis_ziel
--  ,MIN (CASE WHEN m.gjmo = tmp2.gjmo
--             THEN 999999   -- Flag, dass nur Mengen upgedatet werden muessen; bewusst ungueltiger Monat!!
--             ELSE ADD_MONTHS(CAST( (tmp2.gjmo - 190000) *100 +1 AS DATE), -1) / 100 + 190000
--        END)     OVER (PARTITION BY m.art_id, m.mandant_id, m.wup_id, m.nb_id, m.lagerort_id)    AS gjmo_bis_ziel_neu
--  ,CASE WHEN COUNT(*) OVER (PARTITION BY m.art_id, m.mandant_id, m.wup_id, m.nb_id, m.lagerort_id
--                            ORDER BY gjmo_load DESC  ROWS 1 PRECEDING) = 1
--        THEN 999912
--        ELSE ADD_MONTHS(CAST( SUM ((gjmo_load - 190000) *100 +1 )
--                                   OVER (PARTITION BY m.art_id, m.mandant_id, m.wup_id, m.nb_id, m.lagerort_id
--                                         ORDER BY gjmo_load DESC  ROWS 1 PRECEDING)
--                             -  ((gjmo_load - 190000) *100 +1) AS DATE), -1) / 100 + 190000
--   END                AS gjmo_bis_neu
--  ,m.lagerort_id
--  ,m.mard_fg
--  ,tmp2.menge_lgbest_erp_frei_bme
--  ,tmp2.menge_lgbest_erp_umlag_bme
--  ,tmp2.menge_lgbest_erp_qual_bme
--  ,tmp2.menge_lgbest_erp_nf_charge_bme
--  ,tmp2.menge_lgbest_erp_gesp_bme
--  ,tmp2.menge_lgbest_erp_ret_gesp_bme
--FROM ${DWH_COMMON_DBX_DATA}.bestand_erp_monat m
--   INNER JOIN
--     ${DWH_COMMON_DBX_LOAD}.bestand_mardh_mard_tmp2 tmp2
--   ON  m.mandant_id  = tmp2.mandant_id
--   AND m.art_id      = tmp2.art_id
--   AND m.wup_id      = tmp2.wup_id
--   AND m.nb_id       = tmp2.nb_id
--   AND m.lagerort_id = tmp2.lagerort_id
--   AND tmp2.gjmo BETWEEN m.gjmo AND m.gjmo_bis
--   AND m.mard_fg     = 1
--   AND
--    (   m.menge_lgbest_erp_frei_bme      <> tmp2.menge_lgbest_erp_frei_bme
--     OR m.menge_lgbest_erp_umlag_bme     <> tmp2.menge_lgbest_erp_umlag_bme
--     OR m.menge_lgbest_erp_qual_bme      <> tmp2.menge_lgbest_erp_qual_bme
--     OR m.menge_lgbest_erp_nf_charge_bme <> tmp2.menge_lgbest_erp_nf_charge_bme
--     OR m.menge_lgbest_erp_gesp_bme      <> tmp2.menge_lgbest_erp_gesp_bme
--     OR m.menge_lgbest_erp_ret_gesp_bme  <> tmp2.menge_lgbest_erp_ret_gesp_bme
--    )
--;
--
--Comment from validation checker
--MESSAGE: SQL compilation error:
--invalid type [CAST(((TMP2.GJMO \- 190000) * 100) \+ 1 AS DATE)] for parameter 'TO_DATE'
--translated statement
INSERT INTO DBP_ETL.bestand_mardh_mard_tmp3
(
   art_id
  ,mandant_id
  ,wup_id
  ,nb_id
  ,gjmo_ziel
  ,gjmo_load
  ,gjmo_bis_ziel
  ,gjmo_bis_ziel_neu
  ,gjmo_bis_neu
  ,lagerort_id
  ,mard_fg
  ,menge_lgbest_erp_frei_bme
  ,menge_lgbest_erp_umlag_bme
  ,menge_lgbest_erp_qual_bme
  ,menge_lgbest_erp_nf_charge_bme
  ,menge_lgbest_erp_gesp_bme
  ,menge_lgbest_erp_ret_gesp_bme
)
SELECT
   m.art_id
  ,m.mandant_id
  ,m.wup_id
  ,m.nb_id
  ,m.gjmo             AS gjmo_ziel
  ,tmp2.gjmo          AS gjmo_load
  ,m.gjmo_bis         AS gjmo_bis_ziel
  ,MIN (CASE WHEN m.gjmo = tmp2.gjmo
             THEN 999999   -- Flag, dass nur Mengen upgedatet werden muessen; bewusst ungueltiger Monat!!
             ELSE to_number(to_char(ADD_MONTHS(TO_DATE(TO_CHAR(tmp2.gjmo) ,'YYYYMM'), -1)))
        END)     OVER (PARTITION BY m.art_id, m.mandant_id, m.wup_id, m.nb_id, m.lagerort_id)    AS gjmo_bis_ziel_neu
  ,CASE WHEN COUNT(*) OVER (PARTITION BY m.art_id, m.mandant_id, m.wup_id, m.nb_id, m.lagerort_id
                            ORDER BY gjmo_load DESC  ROWS 1 PRECEDING) = 1
        THEN 999912
        ELSE to_number(to_char(ADD_MONTHS(TO_DATE(TO_CHAR(LAG(gjmo_load,1) OVER (PARTITION BY m.art_id, m.mandant_id, m.wup_id, m.nb_id, m.lagerort_id
                                         ORDER BY gjmo_load DESC )  ),'YYYYMM'),-1)))
   END                AS gjmo_bis_neu
  ,m.lagerort_id
  ,m.mard_fg
  ,tmp2.menge_lgbest_erp_frei_bme
  ,tmp2.menge_lgbest_erp_umlag_bme
  ,tmp2.menge_lgbest_erp_qual_bme
  ,tmp2.menge_lgbest_erp_nf_charge_bme
  ,tmp2.menge_lgbest_erp_gesp_bme
  ,tmp2.menge_lgbest_erp_ret_gesp_bme
FROM DBP_DATA.bestand_erp_monat m
   INNER JOIN
     DBP_ETL.bestand_mardh_mard_tmp2 tmp2
   ON  m.mandant_id  = tmp2.mandant_id
   AND m.art_id      = tmp2.art_id
   AND m.wup_id      = tmp2.wup_id
   AND m.nb_id       = tmp2.nb_id
   AND m.lagerort_id = tmp2.lagerort_id
   AND tmp2.gjmo BETWEEN m.gjmo AND m.gjmo_bis
   AND m.mard_fg     = 1
   AND
    (   m.menge_lgbest_erp_frei_bme      <> tmp2.menge_lgbest_erp_frei_bme
     OR m.menge_lgbest_erp_umlag_bme     <> tmp2.menge_lgbest_erp_umlag_bme
     OR m.menge_lgbest_erp_qual_bme      <> tmp2.menge_lgbest_erp_qual_bme
     OR m.menge_lgbest_erp_nf_charge_bme <> tmp2.menge_lgbest_erp_nf_charge_bme
     OR m.menge_lgbest_erp_gesp_bme      <> tmp2.menge_lgbest_erp_gesp_bme
     OR m.menge_lgbest_erp_ret_gesp_bme  <> tmp2.menge_lgbest_erp_ret_gesp_bme
    )
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'ZIEL' does not exist or not authorized.
UPDATE DBP_DATA.bestand_erp_monat ziel,
SET menge_lgbest_erp_frei_bme      = tmp3.menge_lgbest_erp_frei_bme
   ,menge_lgbest_erp_umlag_bme     = tmp3.menge_lgbest_erp_umlag_bme
   ,menge_lgbest_erp_qual_bme      = tmp3.menge_lgbest_erp_qual_bme
   ,menge_lgbest_erp_nf_charge_bme = tmp3.menge_lgbest_erp_nf_charge_bme
   ,menge_lgbest_erp_gesp_bme      = tmp3.menge_lgbest_erp_gesp_bme
   ,menge_lgbest_erp_ret_gesp_bme  = tmp3.menge_lgbest_erp_ret_gesp_bme
FROM 
     DBP_ETL.bestand_mardh_mard_tmp3 tmp3

WHERE ziel.gjmo   = tmp3.gjmo_ziel
  AND ziel.gjmo   = tmp3.gjmo_load
  AND ziel.mandant_id = tmp3.mandant_id
  AND ziel.art_id     = tmp3.art_id
  AND ziel.wup_id     = tmp3.wup_id
  AND ziel.nb_id      = tmp3.nb_id
  AND ziel.lagerort_id = tmp3.lagerort_id
  AND ziel.mard_fg = 1
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'ZIEL' does not exist or not authorized.
UPDATE DBP_DATA.bestand_erp_monat ziel,

SET gjmo_bis = tmp3.gjmo_bis_ziel_neu
FROM 
(SELECT
     mandant_id
    ,art_id
    ,wup_id
    ,nb_id
    ,lagerort_id
    ,gjmo_ziel
    ,gjmo_bis_ziel_neu
 FROM DBP_ETL.bestand_mardh_mard_tmp3
 WHERE gjmo_bis_ziel_neu <> 999999
 GROUP BY 1,2,3,4,5,6,7
) tmp3 WHERE ziel.gjmo   = tmp3.gjmo_ziel
  AND ziel.mandant_id = tmp3.mandant_id
  AND ziel.art_id     = tmp3.art_id
  AND ziel.wup_id     = tmp3.wup_id
  AND ziel.nb_id      = tmp3.nb_id
  AND ziel.lagerort_id = tmp3.lagerort_id
  AND ziel.mard_fg = 1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.bestand_erp_monat
(
  art_id
 ,mandant_id
 ,wup_id
 ,nb_id
 ,gjmo
 ,gjmo_bis
 ,lagerort_id
 ,mard_fg
 ,menge_lgbest_erp_frei_bme
 ,menge_lgbest_erp_umlag_bme
 ,menge_lgbest_erp_qual_bme
 ,menge_lgbest_erp_nf_charge_bme
 ,menge_lgbest_erp_gesp_bme
 ,menge_lgbest_erp_ret_gesp_bme
)
SELECT
  art_id
 ,mandant_id
 ,wup_id
 ,nb_id
 ,gjmo_load
 ,gjmo_bis_neu
 ,lagerort_id
 ,mard_fg
 ,menge_lgbest_erp_frei_bme
 ,menge_lgbest_erp_umlag_bme
 ,menge_lgbest_erp_qual_bme
 ,menge_lgbest_erp_nf_charge_bme
 ,menge_lgbest_erp_gesp_bme
 ,menge_lgbest_erp_ret_gesp_bme

FROM DBP_ETL.bestand_mardh_mard_tmp3
WHERE gjmo_ziel <> gjmo_load
  AND gjmo_bis_ziel_neu <> 999999
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.BESTAND_MARDH_MARD_LOG' does not exist or not authorized.
DELETE FROM DBP_ETL.bestand_mardh_mard_log;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_log
--(
--   mandant_id
--  ,wup_id
--  ,nb_id
--  ,art_id
--  ,gjmo
--)
--SELECT
--   mandant_id
--  ,wup_id
--  ,nb_id
--  ,art_id
--  ,MIN(gjmo) _gjmo
--FROM
--(
-- SELECT
--   b.mandant_id
--  ,b.wup_id
--  ,b.nb_id
--  ,b.art_id
--  ,b.gjmo
-- FROM ${DWH_COMMON_DBX_LOAD}.bestand_mardh_mard_tmp1 b
--    INNER JOIN
--      ${DWH_COMMON_DBX_DATA}.monat m
--   ON  b.gjmo = m.gjmo
--   AND m.akt_mo BETWEEN ${VIS_MON_BEST_AKT_MO_VON} AND 0
-- WHERE b.nb_id = 0
--) tmp
--HAVING (mandant_id, wup_id, nb_id, art_id, _gjmo) NOT IN
--  (SELECT mandant_id, wup_id, nb_id, art_id, gjmo
--   FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_log
--  )
--GROUP BY 1,2,3,4
--
--WHERE mandant_id = 1 ---Versorgung KMO laeuft ueber AbInitio---
--
--;
--
--Comment from validation checker
--error line 26 at position 3 unexpected 'ON'.
--    ^^^> ON  b.gjmo = m.gjmo
--syntax error line 29 at position 0 unexpected ')'.
-- ^^^> ) tmp
--translated statement
INSERT INTO DBP_ETL.vis_monat_bestand_wg_log
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gjmo
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,MIN(gjmo) _gjmo
FROM
(
 SELECT
   b.mandant_id
  ,b.wup_id
  ,b.nb_id
  ,b.art_id
  ,b.gjmo
 FROM DBP_ETL.bestand_mardh_mard_tmp1 b
    INNER JOIN
      DBP_DATA.monat m
   ON  b.gjmo = m.gjmo
   AND m.akt_mo BETWEEN ${VIS_MON_BEST_AKT_MO_VON} AND 0
 WHERE b.nb_id = 0
) tmp
HAVING (mandant_id, wup_id, nb_id, art_id, _gjmo) NOT IN
  (SELECT mandant_id, wup_id, nb_id, art_id, gjmo
   FROM DBP_ETL.vis_monat_bestand_wg_log
  )
GROUP BY 1,2,3,4

WHERE mandant_id = 1 ---Versorgung KMO laeuft ueber AbInitio---

;

