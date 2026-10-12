--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.ART_PM_VW_ZU_PER_1 
WHERE vk_brutto is NULL
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM DBP_DATA.art_pm_vw_zu_per_1 t2
WHERE EXISTS (SELECT * 
              FROM (SELECT t1.mandant_id,
                           t1.art_id,
                           t1.vw_id,
                           t1.dat_von,
                           t1.pm_id,
                           t1.preistyp_id
	FROM ${TEMP_TABLE} /*DBP_ETL.art_pm_vw_zu_per_temp*/ t1_1   
	GROUP BY 1,2,3,4,5,6) dt1
              WHERE dt1.mandant_id = t2.mandant_id AND 
                    dt1.art_id = t2.art_id AND 
                    dt1.vw_id = t2.vw_id AND 
                    dt1.pm_id = t2.pm_id AND 
                    dt1.preistyp_id = t2.preistyp_id AND 
                    dt1.dat_von <= t2.dat_von)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_DATA.art_pm_vw_zu_per_1 
SET dat_bis = (dat_von_) -1

FROM (SELECT t1.mandant_id AS mandant_id_,
                                                    t1.art_id AS art_id_,
                                                    t1.vw_id AS vw_id_,
                                                    MIN(t1.dat_von) AS dat_von_,
                                                    t1.pm_id AS pm_id_,
                                                    t1.preistyp_id AS preistyp_id_
                                             FROM ${TEMP_TABLE} /*DBP_ETL.art_pm_vw_zu_per_temp*/ t1_1 
                                             GROUP BY 1,2,3,5,6)t1_1
 WHERE mandant_id  = mandant_id_
  AND art_id      = art_id_
  AND vw_id       = vw_id_
  AND pm_id       = pm_id_
  AND preistyp_id = preistyp_id_
  AND dat_bis    >= dat_von_
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.art_pm_vw_zu_per_1 (mandant_id,
                                             art_id,
                                             vw_id,
                                             dat_von,
                                             dat_bis,
                                             pm_id,
                                             preistyp_id,
                                             vk_brutto,
                                             wrg_id)
SELECT t1.mandant_id,
       t1.art_id,
       t1.vw_id,
       t1.dat_von,
       t1.dat_bis,
       t1.pm_id,
       t1.preistyp_id,
       t1.vk_brutto,
       t1.wrg_id
FROM ${TEMP_TABLE} /*DBP_ETL.art_pm_vw_zu_per_temp*/ t1_1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_DATA.art_pm_vw_zu_per_1 (art_id
--	                              ,pm_id
--	                              ,vw_id
--	                              ,mandant_id
--	                              ,preistyp_id
--	                              ,dat_bis
--	                              ,dat_von
--	                              ,vk_brutto)
--SELECT a.art_id
--      ,c.wtag_id AS pm_id
--      ,6 AS vw_id
--      ,1 AS mandant_id
--      ,0 AS preistyp_id
--      ,CAST(80991231 AS DATE) AS dat_bis
--      ,CAST(1160925 AS DATE) AS dat_von
--      ,NULL AS vk_brutto
--FROM DBX_DATA.art_1 a
--JOIN DBX_DATA.art_wg_zu_per_1 b
--  ON a.mandant_id = b.mandant_id AND
--     a.art_id = b.art_id AND
--     b.arthiertyp_id = 2 AND
--     b.dat_bis = 80991231 AND
--     b.wg_id NOT IN (1,2,3,5,9,10,12,13,19)
--JOIN (SELECT wtag_id
--      FROM DBX_DATA.tag_1
--      WHERE wtag_id BETWEEN 1 AND 4
--      GROUP BY 1) c
--  ON 1 = 1
--WHERE a.mandant_id = 1 AND
--      a.art_id NOT IN (SELECT art_id
--                       FROM DBX_DATA.art_pm_vw_zu_per_1
--                       WHERE dat_bis >= 1160925 AND
--                             mandant_id = 1 AND
--                             preistyp_id = 0 AND
--                             vw_id = 6) AND
--      a.dat_bis = 80991231
--;
--
--Comment from validation checker
--MESSAGE: SQL compilation error:
--Can not convert parameter '1160925' of type [NUMBER(7,0)] into expected type [DATE]
--translated statement
INSERT INTO DBP_DATA.art_pm_vw_zu_per_1 (art_id
	                              ,pm_id
	                              ,vw_id
	                              ,mandant_id
	                              ,preistyp_id
	                              ,dat_bis
	                              ,dat_von
	                              ,vk_brutto
	                              ,wrg_id)
SELECT a.art_id
      ,c.wtag_id AS pm_id
      ,6 AS vw_id
      ,1 AS mandant_id
      ,0 AS preistyp_id
      ,to_date('9999-12-31','YYYY-MM_1-DD') AS dat_bis
      --,CAST(1160925 AS DATE) AS dat_von
      --mfialkiewicz
      ,to_date('2016-09-25','YYYY-MM_1-DD') AS  dat_von
      ,NULL AS vk_brutto
      ,NULL AS wrg_id
FROM DBP_DATA.art_1 a
JOIN DBP_DATA.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD') AND
     b.wg_id NOT IN (1,2,3,5,9,10,12,13,19)
JOIN (SELECT wtag_id
      FROM DBP_DATA.tag_1
      WHERE wtag_id BETWEEN 1 AND 4
      GROUP BY 1) c
  ON 1 = 1
WHERE a.mandant_id = 1 AND
      a.art_id NOT IN (SELECT art_id
                       FROM DBP_DATA.art_pm_vw_zu_per_1
                       WHERE dat_bis >= to_date('2016-09-25','YYYY-MM_1-DD') AND
                             mandant_id = 1 AND
                             preistyp_id = 0 AND
                             vw_id = 6) AND
      a.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
;

--original statement
--INSERT INTO DBX_DATA.art_pm_vw_zu_per_1
--(
--	art_id
--	,pm_id
--	,vw_id
--	,mandant_id
--	,preistyp_id
--	,dat_bis
--	,dat_von
--	,vk_brutto
--)
--SELECT
--	art_id
--	,pm_id
--	,vw_id
--	,mandant_id
--	,preistyp_id
--	,dat_bis_fehlend as dat_bis
--	,dat_von_fehlend as dat_von
--	,NULL AS vk_brutto
--FROM
--	(
--	
--	SELECT
--			t1.*
--			,CASE WHEN (MSUM (CAST(t1.dat_von AS INTEGER), 2, t1.dat_von DESC ) - CAST(t1.dat_von AS INTEGER)) = 0
--			THEN CAST('99991231' AS DATE FORMAT 'YYYYMMDD')
--			ELSE CAST((MSUM (CAST(t1.dat_von AS INTEGER), 2, t1.dat_von DESC ) - CAST(t1.dat_von AS INTEGER)) AS DATE) -1
--			END AS dat_bis_fehlend
--			,CASE WHEN dat_bis=80991231 THEN NULL ELSE  dat_bis+1 END AS dat_von_fehlend
--	
--	FROM
--			DBX_DATA.art_pm_vw_zu_per_1 t1_1
--	WHERE
--		 	preistyp_id=0 AND
--                        mandant_id <> 1
--	GROUP BY
--		t1.art_id
--		,t1.pm_id
--		,t1.vw_id
--		,t1.mandant_id
--		,preistyp_id
--	)dt1
--WHERE
--	 dat_bis < dat_bis_fehlend  
--; 

--translated statement
INSERT INTO DBP_DATA.art_pm_vw_zu_per_1
(
	art_id
	,pm_id
	,vw_id
	,mandant_id
        ,wrg_id
	,preistyp_id
	,dat_bis
	,dat_von
	,vk_brutto
)
SELECT
	art_id
	,pm_id
	,vw_id
	,mandant_id
        ,wrg_id
	,preistyp_id
	,dat_bis_fehlend as dat_bis
	,dat_von_fehlend as dat_von
	,NULL AS vk_brutto
FROM
	(
	
	SELECT
			t1.*
			/*,CASE WHEN (MSUM (CAST(t1.dat_von AS INTEGER), 2, t1.dat_von DESC ) - CAST(t1.dat_von AS INTEGER)) = 0
			THEN CAST('99991231' AS DATE FORMAT 'YYYYMMDD')
			ELSE CAST((MSUM (CAST(t1.dat_von AS INTEGER), 2, t1.dat_von DESC ) - CAST(t1.dat_von AS INTEGER)) AS DATE) -1
			END AS dat_bis_fehlend*/
                        ,CASE
                           WHEN (SUM(to_number(to_char(t1.dat_von,'YYYYMMDD'))) OVER (PARTITION BY  t1.art_id
                                                                                                   ,t1.pm_id
                                                                                                   ,t1.vw_id
                                                                                                   ,t1.mandant_id
                                                                                                   ,preistyp_id ORDER BY t1.dat_von DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(t1.dat_von,'YYYYMMDD'))) = 0 
                           THEN TO_DATE('99991231','YYYYMMDD')
		                   ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(t1.dat_von,'YYYYMMDD'))) OVER (PARTITION BY t1.art_id
                                                                                                                                ,t1.pm_id
                                                                                                                                ,t1.vw_id
                                                                                                                                ,t1.mandant_id
                                                                                                                                ,preistyp_id
                        ORDER BY t1.dat_von DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(t1.dat_von,'YYYYMMDD')))),'YYYYMMDD'))
		        END AS dat_bis_fehlend
			,CASE WHEN dat_bis= to_date('9999-12-31','YYYY-MM_1-DD') THEN NULL ELSE  dat_bis+1 END AS dat_von_fehlend
	
	FROM
			DBP_DATA.art_pm_vw_zu_per_1 t1_1
	WHERE
		 	preistyp_id=0 AND
                        mandant_id <> 1
	/*GROUP BY
		t1.art_id
		,t1.pm_id
		,t1.vw_id
		,t1.mandant_id
		,preistyp_id*/
	)dt1
WHERE
	 dat_bis < dat_bis_fehlend  
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Modulo operator does not exist in Snowflake. Use MOD function instead.
INSERT INTO DBP_DATA.art_pm_vw_zu_per_1
(
 art_id
 ,vw_id
 ,pm_id
 ,mandant_id
 ,preistyp_id
 ,dat_von
 ,dat_bis
 ,vk_brutto
 ,wrg_id
)

SELECT 
  t1.art_id
  ,t2.vw_id AS  vw_id
  ,t4.pm_id AS  pm_id
  ,1 AS  mandant_id
  ,t3.preistyp_id AS  preistyp_id
  ,to_date('1900-01-01','YYYY-MM_1-DD') AS  dat_von
  ,to_date('9999-12-31','YYYY-MM_1-DD') AS  dat_bis
  ,NULL AS vk_brutto
  ,NULL AS wrg_id
FROM  DBP_DATA.art_1 t1_1 

INNER JOIN DBP_DATA.l_vw_1 t2
ON t1.mandant_id = t2.mandant_id
AND t2.vw_id IN (6) /*momentan sind in DE fuer die WG_ID not in (1,2,3,5,9,10,12,13,19) die Vertriebswege 1,2,3 relevant*/

INNER JOIN DBP_DATA.l_preistyp_1 t3
ON t1.mandant_id = t3.mandant_id 
AND t3.preistyp_id IN (0)  /*momentan sind in DE fuer die WG_ID not in (1,2,3,5,9,10,12,13,19) die Preistypen 0 reelevant*/

INNER JOIN DBP_DATA.pm_1 t4
ON t1.mandant_id = t4.mandant_id
AND t4.pm_id IN (1,2,3,4,5,6,7,8,9,10) /*momentan sind in DE fuer die WG_ID not in (1,2,3,5,9,10,12,13,19) die Preismodule 1,10 relevant*/

INNER JOIN DBP_DATA.art_wg_zu_per_1 t5
ON  t1.mandant_id=t5.mandant_id
AND t1.art_id=t5.art_id
AND t5.dat_bis= to_date('9999-12-31','YYYY-MM_1-DD')
AND t5.arthiertyp_id=2
 
INNER JOIN DBP_DATA.wg_per_1 t6
ON  t5.mandant_id=t6.mandant_id
AND t5.wg_id=t6.wg_id
AND t6.dat_bis= to_date('9999-12-31','YYYY-MM_1-DD')
AND t6.arthiertyp_id=2
 
WHERE t1.mandant_id = 1
AND t6.wg_id NOT IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_1 WHERE mandant_id = 1 and wg_filter_id = 18 AND arthiertyp_id = 2) /*fuer die betr. wg-en in de sollen lediglich die pm_id 1,10 un dpreistyp 0 geladen werden*/
AND  t1.mandant_id=1
AND t1.wg_art_fg=0
  
AND 
(t1.mandant_id
,t1.art_id
,t2.vw_id
,t4.pm_id
,t3.preistyp_id
)
  
NOT IN 
(
SELECT
t1.mandant_id
,t1.art_id
,t1.vw_id
,t1.pm_id
,t1.preistyp_id
FROM  DBP_DATA.art_pm_vw_zu_per_1  t1_1

INNER JOIN DBP_DATA.art_wg_zu_per_1 t5
ON  t1.mandant_id=t5.mandant_id
AND t1.art_id=t5.art_id
AND t5.dat_bis= to_date('9999-12-31','YYYY-MM_1-DD')
AND t5.arthiertyp_id=2

INNER JOIN DBP_DATA.wg_per_1 t6
ON  t5.mandant_id=t6.mandant_id
AND t5.wg_id=t6.wg_id
AND t6.dat_bis= to_date('9999-12-31','YYYY-MM_1-DD')
AND t6.arthiertyp_id=2

WHERE t1.mandant_id = 1 
AND t6.wg_id NOT IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_1 WHERE mandant_id = 1 and wg_filter_id = 18 AND arthiertyp_id = 2) /*fuer die betr. WG-en in DE sollen lediglich die pm_id 1,10 und preistyp 0 geladen werden*/
AND t1.pm_id IN (1,2,3,4,5,6,7,8,9,10) /*fuer die betr. WG-en in DE sind Preismodule 1,10 relevant*/
AND  t1.vw_id IN (6) /*fuer die betr. WG-en in DE sind nur die Vertriebswege 1,2,3*/
AND  t1.preistyp_id IN (0) /*fuer die betr. WG-en in DE sind nur die preistypen 0 reelevant*/
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Modulo operator does not exist in Snowflake. Use MOD function instead.
INSERT INTO DBP_DATA.art_pm_vw_zu_per_1
(
 art_id
 ,vw_id
 ,pm_id
 ,mandant_id
 ,preistyp_id
 ,dat_von
 ,dat_bis
 ,vk_brutto
 ,wrg_id
)

SELECT 
  t1.art_id
  ,t2.vw_id AS  vw_id
  ,t4.pm_id AS  pm_id
  ,1 AS  mandant_id
  ,t3.preistyp_id AS  preistyp_id
  ,to_date('1900-01-01','YYYY-MM_1-DD') AS  dat_von
  ,to_date('9999-12-31','YYYY-MM_1-DD') AS  dat_bis
  ,NULL AS vk_brutto
  ,NULL AS wrg_id
FROM  DBP_DATA.art_1 t1_1 

INNER JOIN DBP_DATA.l_vw_1 t2
ON t1.mandant_id = t2.mandant_id
AND t2.vw_id IN (6) /*momentan sind in DE fuer die WG_ID: 1,2,3,5,9,10,12,13,19 die Vertriebswege 1,2,3 relevant*/

INNER JOIN DBP_DATA.l_preistyp_1 t3
ON t1.mandant_id = t3.mandant_id 
AND t3.preistyp_id IN (0,1,2)  /*momentan sind in DE fuer die WG_ID: 1,2,3,5,9,10,12,13,19 die Preistypen 0,1,2 vorhanden und reelevant*/

INNER JOIN DBP_DATA.pm_1 t4
ON t1.mandant_id = t4.mandant_id
AND t4.pm_id IN (1,2,3,4,5,6,7,8,9,10) /*momentan sind in DE fuer die WG_ID: 1,2,3,5,9,10,12,13,19 die Preismodule 1-10 relevant*/

INNER JOIN DBP_DATA.art_wg_zu_per_1 t5
ON  t1.mandant_id=t5.mandant_id
AND t1.art_id=t5.art_id
AND t5.dat_bis= to_date('9999-12-31','YYYY-MM_1-DD')
AND t5.arthiertyp_id=2
 
INNER JOIN DBP_DATA.wg_per_1 t6
ON  t5.mandant_id=t6.mandant_id
AND t5.wg_id=t6.wg_id
AND t6.dat_bis= to_date('9999-12-31','YYYY-MM_1-DD')
AND t6.arthiertyp_id=2
 
WHERE t1.mandant_id = 1
AND t6.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_1 WHERE mandant_id = 1 and wg_filter_id = 18 AND arthiertyp_id = 2) /*alle Preisklassen und -arten sollen nur fuer die FLW - Warengruppen geladen werden*/
AND  t1.mandant_id=1
AND t1.wg_art_fg=0
  
AND 
(t1.mandant_id
,t1.art_id
,t2.vw_id
,t4.pm_id
,t3.preistyp_id
)
  
NOT IN 
(
SELECT
t1.mandant_id
,t1.art_id
,t1.vw_id
,t1.pm_id
,t1.preistyp_id
FROM  DBP_DATA.art_pm_vw_zu_per_1  t1_1

INNER JOIN DBP_DATA.art_wg_zu_per_1 t5
ON  t1.mandant_id=t5.mandant_id
AND t1.art_id=t5.art_id
AND t5.dat_bis= to_date('9999-12-31','YYYY-MM_1-DD')
AND t5.arthiertyp_id=2

INNER JOIN DBP_DATA.wg_per_1 t6
ON  t5.mandant_id=t6.mandant_id
AND t5.wg_id=t6.wg_id
AND t6.dat_bis= to_date('9999-12-31','YYYY-MM_1-DD')
AND t6.arthiertyp_id=2

WHERE t1.mandant_id = 1 
AND t6.wg_id IN (SELECT wg_id FROM DBP_DATA.wg_filter_zu_1 WHERE mandant_id = 1 and wg_filter_id = 18 AND arthiertyp_id = 2) /*fuer die betr. WG-en in DE sollen die pm_id 1,1,2,3,4,5,6,7,8,9,10 und preistyp 0,1,2 geladen werden*/
AND t1.pm_id IN (1,2,3,4,5,6,7,8,9,10) /*fuer die betr. WG-en in DE sind Preismodule 1,1,2,3,4,5,6,7,8,9,10 relevant*/
AND  t1.vw_id IN (6) /*fuer die betr. WG-en in DE sind nur die Vertriebswege 1,2,3 relevant*/
AND  t1.preistyp_id IN (0,1,2) /*fuer die betr. WG-en in DE sind nur die preistypen 0,1,2 reelevant*/
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_pm_vw_zu_per_1
(
	art_id
	,vw_id
	,pm_id
	,mandant_id
	,preistyp_id
	,dat_von
	,dat_bis
	,vk_brutto
        ,wrg_id 
)
SELECT
art_id,
10 AS  vw_id,
1 AS  pm_id,
t1.mandant_id AS  mandant_id,
0 AS  preistyp_id,
to_date('1900-01-01','YYYY-MM_1-DD') AS  dat_von,
to_date('9999-12-31','YYYY-MM_1-DD') AS  dat_bis,
NULL AS vk_brutto,
NULL AS wrg_id
FROM  DBP_DATA.art_1 t1_1
 WHERE mandant_id <> 1
 AND wg_art_fg=0
 AND art_id 
 NOT IN (SELECT art_id FROM  DBP_DATA.art_pm_vw_zu_per_1 WHERE mandant_id <> 1 AND pm_id=1 AND  vw_id=10  AND  preistyp_id=0)
 
UNION
SELECT
art_id,
10 AS  vw_id,
2 AS  pm_id,
t1.mandant_id AS  mandant_id,
0 AS  preistyp_id,
to_date('1900-01-01','YYYY-MM_1-DD') AS  dat_von,
to_date('9999-12-31','YYYY-MM_1-DD') AS  dat_bis,
NULL AS vk_brutto,
NULL AS wrg_id
FROM  DBP_DATA.art_1 t1_1
 WHERE mandant_id <> 1
 AND wg_art_fg=0
 AND art_id 
 NOT IN (SELECT art_id FROM  DBP_DATA.art_pm_vw_zu_per_1 WHERE mandant_id <> 1 AND pm_id=2 AND  vw_id=10  AND  preistyp_id=0)
 
UNION
SELECT
art_id,
10 AS  vw_id,
3 AS  pm_id,
t1.mandant_id AS  mandant_id,
0 AS  preistyp_id,
to_date('1900-01-01','YYYY-MM_1-DD') AS  dat_von,
to_date('9999-12-31','YYYY-MM_1-DD') AS  dat_bis,
NULL AS vk_brutto,
NULL AS wrg_id
FROM  DBP_DATA.art_1 t1_1
 WHERE mandant_id <> 1
 AND wg_art_fg=0
 AND art_id 
 NOT IN (SELECT art_id FROM  DBP_DATA.art_pm_vw_zu_per_1 WHERE mandant_id <> 1 AND pm_id=3 AND  vw_id=10  AND  preistyp_id=0)
 
UNION
SELECT
art_id,
10 AS  vw_id,
4 AS  pm_id,
t1.mandant_id AS  mandant_id,
0 AS  preistyp_id,
to_date('1900-01-01','YYYY-MM_1-DD') AS  dat_von,
to_date('9999-12-31','YYYY-MM_1-DD') AS  dat_bis,
NULL AS vk_brutto,
NULL AS wrg_id
FROM  DBP_DATA.art_1 t1_1
 WHERE mandant_id <> 1
 AND wg_art_fg=0
 AND art_id 
 NOT IN (SELECT art_id FROM  DBP_DATA.art_pm_vw_zu_per_1 WHERE mandant_id <> 1 AND pm_id=4 AND  vw_id=10  AND  preistyp_id=0)
 
UNION
SELECT
art_id,
10 AS  vw_id,
5 AS  pm_id,
t1.mandant_id AS  mandant_id,
0 AS  preistyp_id,
to_date('1900-01-01','YYYY-MM_1-DD') AS  dat_von,
to_date('9999-12-31','YYYY-MM_1-DD') AS  dat_bis,
NULL AS vk_brutto,
NULL AS wrg_id
FROM  DBP_DATA.art_1 t1_1
 WHERE mandant_id <> 1
 AND wg_art_fg=0
 AND art_id 
 NOT IN (SELECT art_id FROM  DBP_DATA.art_pm_vw_zu_per_1 WHERE mandant_id <> 1 AND pm_id=5 AND  vw_id=10  AND  preistyp_id=0)

;

-- 12.02.2026, -dbay-
--
-- Etwaige Duplikate killen. Scheint irgendwie erforderlich zu sein,
-- nach gut 15 Jahren? Strange!

-- 1. Erst einmal aufs Attribut DAT_BIS.

create or replace volatile table _dups_1 as (
select mandant_id,
       art_id,
       pm_id,
       vw_id,
       preistyp_id,
       dat_bis,
       min(vk_brutto) as min_vk_brutto,
       max(vk_brutto) as max_vk_brutto,
       count(*) as anz
from dbp_data.art_pm_vw_zu_per_1
group by all
having anz > 1
);

create or replace volatile table _fix_art_pm as (
select a.art_id,
       a.pm_id,
       a.vw_id,
       a.mandant_id,
       a.preistyp_id,
       a.dat_bis,
       min(a.dat_von) as dat_von,
       max(a.vk_brutto) as vk_brutto,
       max(a.td_insert) as td_insert,
       max(a.td_update) as td_update,
       max(a.wrg_id) as wrg_id
from dbp_data.art_pm_vw_zu_per_1 a
join _dups_1 b
  on a.mandant_id = b.mandant_id and
     a.pm_id = b.pm_id and
     a.vw_id = b.vw_id and
     a.art_id = b.art_id and
     a.preistyp_id = b.preistyp_id and
     a.dat_bis = b.dat_bis and
     a.vk_brutto = b.max_vk_brutto
group by all
);

delete from dbp_data.art_pm_vw_zu_per_1
where (mandant_id,art_id,pm_id,preistyp_id,vw_id,dat_bis) in (select mandant_id,art_id,pm_id,preistyp_id,vw_id,dat_bis from _dups_1)
;

insert into dbp_data.art_pm_vw_zu_per_1
select *
from _fix_art_pm
group by all
;

-- 2. Dann aufs Attribut DAT_BIS.

create or replace volatile table _dups_1 as (
select mandant_id,
       art_id,
       pm_id,
       vw_id,
       preistyp_id,
       dat_von,
       max(dat_bis) as max_dat_bis,
       min(vk_brutto) as min_vk_brutto,
       max(vk_brutto) as max_vk_brutto,
       count(*) as anz
from dbp_data.art_pm_vw_zu_per_1
group by all
having anz > 1
);

create or replace volatile table _fix_art_pm as (
select a.art_id,
       a.pm_id,
       a.vw_id,
       a.mandant_id,
       a.preistyp_id,
       a.dat_bis,
       min(a.dat_von) as dat_von,
       max(a.vk_brutto) as vk_brutto,
       max(a.td_insert) as td_insert,
       max(a.td_update) as td_update,
       max(a.wrg_id) as wrg_id
from dbp_data.art_pm_vw_zu_per_1 a
join _dups_1 b
  on a.mandant_id = b.mandant_id and
     a.pm_id = b.pm_id and
     a.vw_id = b.vw_id and
     a.art_id = b.art_id and
     a.preistyp_id = b.preistyp_id and
     a.dat_von = b.dat_von and
     a.dat_bis = b.max_dat_bis
group by all
);

delete from dbp_data.art_pm_vw_zu_per_1
where (mandant_id,art_id,pm_id,preistyp_id,vw_id,dat_von) in (select mandant_id,art_id,pm_id,preistyp_id,vw_id,dat_von from _dups_1)
;

insert into dbp_data.art_pm_vw_zu_per_1
select *
from _fix_art_pm
group by all
;

-- 3. Zum Abschluss die Pruefung auf Zeitreihen.
-- 
-- Erster Lauf.

create or replace volatile table _days as (
select dat
from dbp_data.tag_1
where dat between (select min(dat) from dbp_data.tag_1 where akt_kj = -1) and current_date
);

create or replace volatile table _dups_1 as (
select x.mandant_id,
       x.vw_id,
       x.art_id,
       x.preistyp_id,
       x.pm_id,
       x.min_dat_von,
       x.max_dat_von,
       x.min_dat_bis,
       x.max_dat_bis
from (select dat,
             art_id,
             pm_id,
             vw_id,
             mandant_id,
             preistyp_id,
             count(*),
             min(dat_von) as min_dat_von,
             max(dat_von) as max_dat_von,
             min(dat_bis) as min_dat_bis,
             max(dat_bis) as max_dat_bis
      from dbp_data.art_pm_vw_zu_per_1 a
      join _days b
        on 1 = 1
      where dat between dat_von and dat_bis
      group by all
      having count(*) > 1) x
group by all
);

create or replace volatile table _fix_art_pm as (
select a.art_id,
       a.pm_id,
       a.vw_id,
       a.mandant_id,
       a.preistyp_id,
       max(a.dat_bis) as dat_bis,
       min(a.dat_von) as dat_von,
       max(a.vk_brutto) as vk_brutto,
       max(a.td_insert) as td_insert,
       max(a.td_update) as td_update,
       max(a.wrg_id) as wrg_id
from dbp_data.art_pm_vw_zu_per_1 a
join _dups_1 b
  on a.mandant_id = b.mandant_id and
     a.pm_id = b.pm_id and
     a.vw_id = b.vw_id and
     a.art_id = b.art_id and
     a.preistyp_id = b.preistyp_id and
     a.dat_bis = b.max_dat_bis
group by all
);

delete from dbp_data.art_pm_vw_zu_per_1
where (mandant_id,vw_id,art_id,preistyp_id,pm_id,dat_bis) in (select mandant_id,vw_id,art_id,preistyp_id,pm_id,min_dat_bis from _dups_1)
;

insert into dbp_data.art_pm_vw_zu_per_1
select *
from _fix_art_pm
group by all
;

-- 3. Zum Abschluss die Pruefung auf Zeitreihen.
-- 
-- Zweiter Lauf.

create or replace volatile table _days as (
select dat
from dbp_data.tag_1
where dat between (select min(dat) from dbp_data.tag_1 where akt_kj = -1) and current_date
);

create or replace volatile table _dups_1 as (
select x.mandant_id,
       x.vw_id,
       x.art_id,
       x.preistyp_id,
       x.pm_id,
       x.min_dat_von,
       x.max_dat_von,
       x.min_dat_bis,
       x.max_dat_bis
from (select dat,
             art_id,
             pm_id,
             vw_id,
             mandant_id,
             preistyp_id,
             count(*),
             min(dat_von) as min_dat_von,
             max(dat_von) as max_dat_von,
             min(dat_bis) as min_dat_bis,
             max(dat_bis) as max_dat_bis
      from dbp_data.art_pm_vw_zu_per_1 a
      join _days b
        on 1 = 1
      where dat between dat_von and dat_bis
      group by all
      having count(*) > 1) x
group by all
);

create or replace volatile table _fix_art_pm as (
select a.art_id,
       a.pm_id,
       a.vw_id,
       a.mandant_id,
       a.preistyp_id,
       max(a.dat_bis) as dat_bis,
       min(a.dat_von) as dat_von,
       max(a.vk_brutto) as vk_brutto,
       max(a.td_insert) as td_insert,
       max(a.td_update) as td_update,
       max(a.wrg_id) as wrg_id
from dbp_data.art_pm_vw_zu_per_1 a
join _dups_1 b
  on a.mandant_id = b.mandant_id and
     a.pm_id = b.pm_id and
     a.vw_id = b.vw_id and
     a.art_id = b.art_id and
     a.preistyp_id = b.preistyp_id and
     a.dat_bis = b.max_dat_bis
group by all
);

delete from dbp_data.art_pm_vw_zu_per_1
where (mandant_id,vw_id,art_id,preistyp_id,pm_id,dat_bis) in (select mandant_id,vw_id,art_id,preistyp_id,pm_id,min_dat_bis from _dups_1)
;

insert into dbp_data.art_pm_vw_zu_per_1
select *
from _fix_art_pm
group by all
;
