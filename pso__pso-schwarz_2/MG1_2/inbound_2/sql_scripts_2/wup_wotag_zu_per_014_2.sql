--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE OR REPLACE TABLE DBP_ETL.wupcal_bonanzahl_tmp_2
AS (SELECT TOP 0  * FROM DBP_DATA.wupcal_2);


--translated statement
INSERT INTO DBP_ETL.wupcal_bonanzahl_tmp_2
(
   wup_id
 , mandant_id
 , nb_id
 , dat
 , offen
 , werbewoche
 , datenlieferung_artbew_wg_sum
 , bonanzahl
 , datenlieferung_bonanzahl
 , bonanzahl_misvier
 , datenlieferung_misvier
 , datenlieferung_artbew
 , datenlieferung_qbm_status
)

SELECT
   dt1.wup_id       AS _wup_id
 , dt1.mandant_id   AS _mandant_id
 , dt1.nb_id        AS _nb_id
 , dt1.dat_missing  AS _dat
 , 1                AS _offen
 , 0                AS _werbewoche
 , 0                AS _datenlieferung_artbew_wg_sum
 , CAST((CASE WHEN wwzp.umsatz_prz = 0
       THEN 0
       ELSE dt1.source_bonanzahl / wwzp.umsatz_prz * dt1.umsatz_prz
  END) AS INTEGER) AS _bonanzahl
 , 0 AS _datenlieferung_bonanzahl
 , 0 AS _bonanzahl_misvier
 , 0 AS _datenlieferung_misvier
 , 0 AS _datenlieferung_artbew
 , 0 AS _datenlieferung_qbm_status
FROM
(SELECT 
  w1.mandant_id
, w1.wup_id 
, w1.nb_id
, w1.dat       AS dat_missing
, w1.bonanzahl AS missing_bonanzahl
, w2.bonanzahl AS source_bonanzahl
, wwzp.umsatz_prz 
, w2.dat as dat_source
FROM DBP_DATA.wupcal_2 w1
INNER JOIN DBP_DATA.wupcal_2 w2
ON w1.mandant_id = w2.mandant_id
AND w1.wup_id    = w2.wup_id
AND w1.nb_id     = w2.nb_id
INNER JOIN DBP_DATA.tag_2 t1_2
ON w1.dat = t1.dat
AND t1.dat < CURRENT_DATE
AND t1.dat > to_date('2003-11-23','YYYY-MM_2-DD') --1031123
INNER JOIN DBP_DATA.wup_wotag_zu_per_2 wwzp
ON w1.mandant_id = wwzp.mandant_id
AND w1.wup_id    = wwzp.wup_id
AND w1.nb_id     = wwzp.nb_id
AND t1.wtag_id   = wwzp.wtag_id
WHERE w2.bonanzahl <> 0
  AND w2.dat < w1.dat
  AND w1.datenlieferung_bonanzahl IN (0,2)
  AND w1.offen = 1 
  AND w1.nb_id IN (0)
  AND wwzp.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
QUALIFY row_number() over (partition by w1.mandant_id, w1.wup_id , w1.nb_id, w1.dat order by w2.dat desc )=1
--QUALIFY CSUM(1, w2.dat desc) = 1
--GROUP BY 1,2,3,4
) dt1
INNER JOIN DBP_DATA.tag_2 t2
ON dt1.dat_source = t2.dat
AND t2.dat < CURRENT_DATE
INNER JOIN DBP_DATA.wup_wotag_zu_per_2 wwzp
ON dt1.mandant_id = wwzp.mandant_id
AND dt1.wup_id    = wwzp.wup_id
AND dt1.nb_id     = wwzp.nb_id
AND t2.wtag_id    = wwzp.wtag_id
AND wwzp.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.wupcal_bonanzahl_tmp_2
WHERE (mandant_id, wup_id, nb_id, dat) IN
(SELECT mandant_id, wup_id, nb_id, dat FROM DBP_DATA.wupcal_2
WHERE datenlieferung_bonanzahl = 1
AND bonanzahl <> 0
);

/*disabled SPEC0164039*/

-- Umsatzkalk. check

/*UPDATE DBP_DATA.wupcal_2

SET
      bonanzahl = _bonanzahl
    , datenlieferung_bonanzahl = 2

FROM
(
  SELECT
     mandant_id   AS _mandant_id
   , wup_id       AS _wup_id
   , nb_id        AS _nb_id 
   , dat          AS _dat
   , bonanzahl    AS _bonanzahl
  FROM DBP_ETL.wupcal_bonanzahl_tmp_2 k
)   
    ums_dt  WHERE mandant_id  = _mandant_id
  AND wup_id      = _wup_id 
  AND nb_id       = _nb_id 
  AND dat         = _dat  
  AND datenlieferung_bonanzahl IN (0,2)
;
*/


INSERT INTO DBP_ETL_PROCESS.kundenanz_agg_wt_2
(
  mandant_id
  ,wup_id
  ,nb_id
  ,dat
  ,calc_fg
  ,dat_lief
)
SELECT 
    mandant_id
  , wup_id
  , nb_id
  , dat
    , 1 as calc_fg
    , CURRENT_DATE as dat_lief
FROM 
  DBP_ETL.wupcal_bonanzahl_tmp_2
GROUP BY 
  1,2,3,4,5,6
;

