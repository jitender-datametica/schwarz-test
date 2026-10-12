/* AW check 2021-05-10*/
DROP TABLE IF EXISTS DBP_ETL.artbew_wg_sum_tmp_2;

CREATE TABLE DBP_ETL.artbew_wg_sum_tmp_2
AS (SELECT TOP 0  * FROM DBP_DATA.artbew_wg_sum_2);

INSERT INTO DBP_ETL.artbew_wg_sum_tmp_2
(
mandant_id
, wup_id
, wg_id
, bewart_id
, dat
, nb_id
, arthiertyp_id
, umsatz_brutto
, umsatz_netto
, umsatz_wrg
, umsatz_brutto_konz
, umsatz_netto_konz
, kjmo
, menge
, quelle
)
SELECT 
  dt1.mandant_id
, dt1.wup_id 
, aws.wg_id
, aws.bewart_id
, dt1.dat_missing
, dt1.nb_id
, aws.arthiertyp_id
--, dt1.umsatz_prz
--, dt1.dat_source
--, wwzp.umsatz_prz
, (CASE WHEN wwzp.umsatz_prz = CAST(0 AS DECIMAL (9,2)) THEN 0 ELSE (aws.umsatz_brutto /  wwzp.umsatz_prz) END ) * dt1.umsatz_prz AS umsatz_brutto
, (CASE WHEN wwzp.umsatz_prz = 0.00 THEN 0 ELSE (aws.umsatz_netto /  wwzp.umsatz_prz) END ) * dt1.umsatz_prz AS umsatz_netto
, aws.umsatz_wrg
, (CASE WHEN wwzp.umsatz_prz = 0.00 THEN 0 ELSE (aws.umsatz_brutto_konz /  wwzp.umsatz_prz) END ) * dt1.umsatz_prz AS umsatz_brutto_konz
, (CASE WHEN wwzp.umsatz_prz = 0.00 THEN 0 ELSE (aws.umsatz_netto_konz /  wwzp.umsatz_prz) END ) * dt1.umsatz_prz AS umsatz_netto_konz
--, aws.kjmo
, --190000 + dt1.dat_missing/100
LEFT(to_char(dt1.dat_missing ,'YYYYMMDD'),6)
, (CASE WHEN wwzp.umsatz_prz = 0.00 THEN 0 ELSE (aws.menge /  wwzp.umsatz_prz) END ) * dt1.umsatz_prz AS menge
, '2'
FROM
(SELECT 
  w1.mandant_id
, w1.wup_id 
, w1.nb_id
, w1.dat AS dat_missing
, wwzp.umsatz_prz
, MAX(w2.dat) as dat_source
FROM DBP_DATA.wupcal_2 w1

INNER JOIN DBP_ETL.vis_mandant_2 vm
ON w1.mandant_id = vm.mandant_id

INNER JOIN DBP_DATA.wupcal_2 w2
ON w1.mandant_id = w2.mandant_id
AND w1.wup_id = w2.wup_id
AND w1.nb_id = w2.nb_id

INNER JOIN DBP_DATA.tag_2 t1_2
ON w1.dat = t1.dat
AND t1.dat < CURRENT_DATE
AND t1.dat > '2003-11-23'

INNER JOIN DBP_DATA.wup_wotag_zu_per_2 wwzp
ON w1.mandant_id  = wwzp.mandant_id
AND w1.wup_id     = wwzp.wup_id
AND w1.nb_id      = wwzp.nb_id
AND t1.wtag_id    = wwzp.wtag_id
WHERE 
    w2.datenlieferung_artbew_wg_sum = 1
AND w2.dat < w1.dat
AND w1.datenlieferung_artbew_wg_sum = 0
AND w1.offen = 1 
AND w1.nb_id IN (0)  
AND wwzp.dat_bis = to_date('99991231','YYYYMMDD')
GROUP BY 1,2,3,4,5) dt1

INNER JOIN DBP_DATA.tag_2 t2
ON dt1.dat_source   = t2.dat
AND t2.dat < CURRENT_DATE

INNER JOIN DBP_DATA.wup_wotag_zu_per_2 wwzp
ON dt1.mandant_id   = wwzp.mandant_id
AND dt1.wup_id      = wwzp.wup_id
AND dt1.nb_id       = wwzp.nb_id
AND t2.wtag_id      = wwzp.wtag_id
AND wwzp.dat_bis    = to_date('99991231','YYYYMMDD')

INNER JOIN DBP_DATA.artbew_wg_sum_2 aws
ON dt1.mandant_id   = aws.mandant_id
AND dt1.wup_id      = aws.wup_id
AND dt1.nb_id       = aws.nb_id
AND dt1.dat_source  = aws.dat
AND aws.bewart_id NOT IN (1005,1010)
AND aws.nb_id NOT IN (2,7)
;

DELETE FROM DBP_ETL.artbew_wg_sum_tmp_2
WHERE (mandant_id, wup_id, nb_id, dat) IN
(SELECT mandant_id, wup_id, nb_id, dat FROM DBP_DATA.artbew_wg_sum_2 WHERE bewart_id NOT IN (1005,1010) AND nb_id NOT IN (2,7));

UPDATE  DBP_DATA.wupcal_2
   SET  datenlieferung_artbew_wg_sum = 2,
        td_update= CURRENT_TIMESTAMP
 WHERE  (mandant_id, wup_id, nb_id, dat) IN
        (SELECT mandant_id, wup_id, nb_id, dat 
         FROM DBP_ETL.artbew_wg_sum_tmp_2
        );

INSERT INTO DBP_ETL_PROCESS.artbew_wg_sum_agg_wt_2
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
  DBP_ETL.artbew_wg_sum_tmp_2
GROUP BY 
  1,2,3,4,5,6
;

INSERT INTO DBP_DATA.artbew_wg_sum_2
(

mandant_id
, wup_id
, wg_id
, bewart_id
, dat
, nb_id
, arthiertyp_id
, umsatz_brutto
, umsatz_netto
, umsatz_wrg
, umsatz_brutto_konz
, umsatz_netto_konz
, kjmo
, menge
, quelle
)
SELECT
mandant_id
, wup_id
, wg_id
, bewart_id
, dat
, nb_id
, arthiertyp_id
, umsatz_brutto
, umsatz_netto
, umsatz_wrg
, umsatz_brutto_konz
, umsatz_netto_konz
, kjmo
, menge
, quelle
FROM DBP_ETL.artbew_wg_sum_tmp_2;

DROP TABLE IF EXISTS DBP_ETL.artbew_wg_sum_tmp2_2;

CREATE TABLE DBP_ETL.artbew_wg_sum_tmp2_2
AS (SELECT TOP 0  * FROM DBP_DATA.artbew_wg_sum_2);

INSERT INTO DBP_ETL.artbew_wg_sum_tmp2_2
( mandant_id
, wup_id
, wg_id
, bewart_id
, dat
, nb_id
, arthiertyp_id
, umsatz_brutto
, umsatz_netto
, umsatz_wrg
, umsatz_brutto_konz
, umsatz_netto_konz
, kjmo
, menge
, quelle
)
SELECT
  aws.mandant_id
, aws.wup_id
, aws.wg_id
, aws.bewart_id
, dt1.dat_missing
, aws.nb_id
, aws.arthiertyp_id
, aws.umsatz_brutto
, aws.umsatz_netto
, aws.umsatz_wrg
, aws.umsatz_brutto_konz
, aws.umsatz_netto_konz
, aws.kjmo
, aws.menge
, 2 /* Kopiert = Kalkuliert = 2 */
FROM DBP_DATA.artbew_wg_sum_2 aws
INNER JOIN
(
SELECT 
  w1.mandant_id
, w1.wup_id 
, w1.nb_id
, w1.dat AS dat_missing
, MAX(w2.dat) as dat_source
FROM DBP_DATA.wupcal_2 w1

INNER JOIN DBP_ETL.vis_mandant_2 vm
ON w1.mandant_id = vm.mandant_id

INNER JOIN DBP_DATA.wupcal_2 w2
ON w1.mandant_id = w2.mandant_id
AND w1.wup_id   = w2.wup_id
AND w1.nb_id    = w2.nb_id
--AND w1.dat > 1031123
AND w1.dat > '2003-11-23'
AND w1.dat < CURRENT_DATE
WHERE 
    w2.datenlieferung_artbew_wg_sum = 1
AND w2.dat < w1.dat
AND w1.datenlieferung_artbew_wg_sum = 0
AND w1.offen = 1
AND w1.nb_id IN (0)  
GROUP BY 1,2,3,4
) dt1
ON  dt1.mandant_id = aws.mandant_id
AND dt1.wup_id     = aws.wup_id
AND dt1.nb_id      = aws.nb_id
AND dt1.dat_source = aws.dat
AND aws.bewart_id NOT IN (1005,1010)
AND aws.nb_id NOT IN (2,7)
;

DELETE FROM DBP_ETL.artbew_wg_sum_tmp2_2
WHERE (mandant_id, wup_id, nb_id, dat) IN
(SELECT mandant_id, wup_id, nb_id, dat FROM DBP_DATA.artbew_wg_sum_2 WHERE bewart_id NOT IN (1005,1010) AND nb_id NOT IN (2,7));

UPDATE  DBP_DATA.wupcal_2
   SET  datenlieferung_artbew_wg_sum = 2,
        td_update= CURRENT_TIMESTAMP 
WHERE   (mandant_id, wup_id, nb_id, dat) IN
        (SELECT mandant_id, wup_id, nb_id, dat 
         FROM DBP_ETL.artbew_wg_sum_tmp2_2
        );

INSERT INTO DBP_ETL_PROCESS.artbew_wg_sum_agg_wt_2
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
  DBP_ETL.artbew_wg_sum_tmp2_2
GROUP BY 
  1,2,3,4,5,6
;

INSERT INTO DBP_DATA.artbew_wg_sum_2
(

mandant_id
, wup_id
, wg_id
, bewart_id
, dat
, nb_id
, arthiertyp_id
, umsatz_brutto
, umsatz_netto
, umsatz_wrg
, umsatz_brutto_konz
, umsatz_netto_konz
, kjmo
, menge
, quelle
)
SELECT
mandant_id
, wup_id
, wg_id
, bewart_id
, dat
, nb_id
, arthiertyp_id
, umsatz_brutto
, umsatz_netto
, umsatz_wrg
, umsatz_brutto_konz
, umsatz_netto_konz
, kjmo
, menge
, quelle
FROM DBP_ETL.artbew_wg_sum_tmp2_2;

DROP TABLE IF EXISTS DBP_ETL.wupcal_bonanzahl_tmp_2;

CREATE TABLE DBP_ETL.wupcal_bonanzahl_tmp_2
AS (SELECT TOP 0  * FROM DBP_DATA.wupcal_2);

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
 , TO_NUMBER((CASE WHEN wwzp.umsatz_prz = 0
       THEN 0
       ELSE dt1.source_bonanzahl / wwzp.umsatz_prz * dt1.umsatz_prz
  END) ) AS _bonanzahl
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

INNER JOIN DBP_ETL.vis_mandant_2 vm
ON w1.mandant_id = vm.mandant_id

INNER JOIN DBP_DATA.wupcal_2 w2
ON w1.mandant_id = w2.mandant_id
AND w1.wup_id    = w2.wup_id
AND w1.nb_id     = w2.nb_id
INNER JOIN DBP_DATA.tag_2 t1_2
ON w1.dat = t1.dat
AND t1.dat < CURRENT_DATE
--AND t1.dat > 1031123
AND t1.dat > '2003-11-23'
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
  AND wwzp.dat_bis = to_date('99991231','YYYYMMDD')
/*
QUALIFY CSUM(1, w2.dat desc) = 1
GROUP BY 1,2,3,4
*/
QUALIFY row_number() over (partition by w1.mandant_id,w1.wup_id,w1.nb_id,dat_missing order by w2.dat desc) = 1

) dt1
INNER JOIN DBP_DATA.tag_2 t2
ON dt1.dat_source = t2.dat
AND t2.dat < CURRENT_DATE
INNER JOIN DBP_DATA.wup_wotag_zu_per_2 wwzp
ON dt1.mandant_id = wwzp.mandant_id
AND dt1.wup_id    = wwzp.wup_id
AND dt1.nb_id     = wwzp.nb_id
AND t2.wtag_id    = wwzp.wtag_id
AND wwzp.dat_bis = to_date('99991231','YYYYMMDD')
;

DELETE FROM DBP_ETL.wupcal_bonanzahl_tmp_2
WHERE (mandant_id, wup_id, nb_id, dat) IN
(SELECT mandant_id, wup_id, nb_id, dat FROM DBP_DATA.wupcal_2
WHERE datenlieferung_bonanzahl = 1
AND bonanzahl <> 0
);

UPDATE DBP_DATA.wupcal_2

SET     bonanzahl = _bonanzahl,
        datenlieferung_bonanzahl = 2,
        td_update= CURRENT_TIMESTAMP

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

