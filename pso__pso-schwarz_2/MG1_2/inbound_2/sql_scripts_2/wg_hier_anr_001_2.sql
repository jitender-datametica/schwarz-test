CREATE OR REPLACE TABLE DBP_ETL.wg_per_tmp_2 LIKE DBP_DATA.wg_per_2;
CREATE OR REPLACE TABLE DBP_ETL.owg_per_tmp_2 LIKE DBP_DATA.owg_per_2;
CREATE OR REPLACE TABLE DBP_ETL.hwg_per_tmp_2 LIKE DBP_DATA.hwg_per_2;
CREATE OR REPLACE TABLE DBP_ETL.abt_per_tmp_2 LIKE DBP_DATA.abt_per_2;

CREATE OR REPLACE TABLE DBP_ETL.wg_per_init_2  (
      mandant_id BYTEINT,
      wg_id SMALLINT,
      owg_id SMALLINT,
      hwg_id SMALLINT,
      abt_id SMALLINT,
      dat_von DATE,
      dat_bis DATE)
;

INSERT INTO DBP_ETL.wg_per_init_2 (mandant_id,
                                 wg_id,
                                 owg_id,
                                 hwg_id,
                                 abt_id,
                                 dat_von,
                                 dat_bis)
SELECT wg.mandant_id
     , wg.wg_hierarchie_id AS wg_id 
     , owg.wg_hierarchie_id AS owg_id 
     , hwg.wg_hierarchie_id AS hwg_id
     , abt.wg_hierarchie_id AS abt_id
     , wg.dat_von
     , wg.dat_bis 
FROM DBP_DATA.wg_hierarchie_zu_per_2 wg

INNER JOIN DBP_DATA.wg_hierarchie_zu_per_2 owg
  ON owg.mandant_id = wg.mandant_id 
 AND owg.wg_hierarchie_id = wg.wg_hierarchie_mutter_id 
 AND owg.arthiertyp_id = wg.arthiertyp_id 
 AND owg.wg_hierarchie_ebene_id = 4 -- Oberwarengruppe
 AND owg.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')

INNER JOIN DBP_DATA.wg_hierarchie_zu_per_2 hwg
  ON owg.mandant_id = hwg.mandant_id 
 AND hwg.wg_hierarchie_id = owg.wg_hierarchie_mutter_id 
 AND owg.arthiertyp_id = hwg.arthiertyp_id 
 AND hwg.wg_hierarchie_ebene_id = 3 -- Hauptwarengruppe
 AND hwg.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')

INNER JOIN DBP_DATA.wg_hierarchie_zu_per_2 abt_2
  ON abt.mandant_id = hwg.mandant_id 
 AND abt.wg_hierarchie_id = hwg.wg_hierarchie_mutter_id 
 AND abt.arthiertyp_id = hwg.arthiertyp_id 
 AND abt.wg_hierarchie_ebene_id = 2 -- Abteilung
 AND abt.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')

WHERE wg.arthiertyp_id = 10
  AND wg.wg_hierarchie_ebene_id = 5  -- Warengruppe
  AND wg.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
;

INSERT INTO DBP_ETL.wg_per_tmp_2 (mandant_id
                               ,wg_id
                               ,arthiertyp_id
                               ,abt_id
                               ,lead_mwst_id
                               ,dat_von
                               ,dat_bis
                               ,owg_id)
SELECT a.mandant_id
      ,a.wg_id
      ,2 AS arthiertyp_id
      ,a.abt_id
      ,COALESCE(l.lead_mwst_id, 0) AS lead_mwst_id
      ,a.dat_von
      ,a.dat_bis
      ,a.owg_id
FROM DBP_ETL.wg_per_init_2 a
LEFT OUTER JOIN 
(
  -- Ermittlung Lead Mwst ID 
  -- Falls Anzahl fuer verschiedenen MWST Saetze identisch, 
  -- dann wird die maximale MWST genommen.
  SELECT
     a.mandant_id
    ,w.wg_id
    ,a.mwst_id AS lead_mwst_id
    ,COUNT(*) AS zaehler_mwst
    ,RANK() OVER 
     (
       PARTITION BY a.mandant_id, w.wg_id 
       ORDER BY zaehler_mwst DESC, lead_mwst_id DESC
     ) AS ranking
  FROM DBP_DATA.art_2 a

  JOIN DBP_DATA.art_wg_zu_per_2 w
    ON a.mandant_id = w.mandant_id
   AND a.art_id = w.art_id
   AND CURRENT_DATE BETWEEN w.dat_von AND w.dat_bis
   AND w.arthiertyp_id = 2
  GROUP BY 1,2,3
  QUALIFY ranking = 1) l
ON a.mandant_id = l.mandant_id 
  AND a.wg_id = l.wg_id 
;

INSERT INTO DBP_ETL.owg_per_tmp_2 (owg_id
                                ,arthiertyp_id
                                ,mandant_id
                                ,dat_von
                                ,dat_bis
                                ,hwg_id
                                ,hr_objekt_bereich_id
                                ,hr_objekt_bereich_id_de)
SELECT a.owg_id
      ,2 AS arthiertyp_id
      ,a.mandant_id
      ,a.dat_von
      ,a.dat_bis
      ,a.hwg_id
      ,-1 as hr_objekt_bereich_id
      ,-1 as hr_objekt_bereich_id_de
FROM DBP_ETL.wg_per_init_2 a
group by 1,2,3,4,5,6,7,8
;

INSERT INTO DBP_ETL.hwg_per_tmp_2 (hwg_id
                                ,arthiertyp_id
                                ,mandant_id
                                ,dat_von
                                ,dat_bis
                                ,abt_id
                                ,hr_objekt_bereich_id
                                ,hr_objekt_bereich_id_de)
SELECT a.hwg_id
      ,2 AS arthiertyp_id
      ,a.mandant_id
      ,a.dat_von
      ,a.dat_bis
      ,a.abt_id
      ,-1 as hr_objekt_bereich_id
      ,-1 as hr_objekt_bereich_id_de
FROM DBP_ETL.wg_per_init_2 a
group by 1,2,3,4,5,6,7,8
;

INSERT INTO DBP_ETL.abt_per_tmp_2 (abt_id
                                ,arthiertyp_id
                                ,mandant_id
                                ,dat_von
                                ,dat_bis)
SELECT a.hwg_id
      ,2 AS arthiertyp_id
      ,a.mandant_id
      ,a.dat_von
      ,a.dat_bis
FROM DBP_ETL.wg_per_init_2 a
group by 1,2,3,4,5
;

delete from DBP_ETL.wg_per_tmp_2
where wg_id = 961
;

-- WG_PER_2 --

DELETE FROM DBP_ETL.wg_per_tmp_2 t using DBP_DATA.wg_per_2
WHERE t.mandant_id    = DBP_DATA.wg_per.mandant_id
  AND t.wg_id         = DBP_DATA.wg_per.wg_id
  AND t.arthiertyp_id = DBP_DATA.wg_per.arthiertyp_id 
  AND t.dat_von       < DBP_DATA.wg_per.dat_von
;

DELETE FROM DBP_DATA.wg_per_2 p using DBP_ETL.wg_per_tmp_2
WHERE p.mandant_id    = DBP_ETL.wg_per_tmp.mandant_id
  AND p.wg_id         = DBP_ETL.wg_per_tmp.wg_id
  AND p.arthiertyp_id = DBP_ETL.wg_per_tmp.arthiertyp_id
  AND p.dat_von       = DBP_ETL.wg_per_tmp.dat_von
  AND CASE
        WHEN COALESCE(p.abt_id, 0) <> COALESCE(DBP_ETL.wg_per_tmp.abt_id, 0) OR 
             COALESCE(p.lead_mwst_id, 0) <> COALESCE(DBP_ETL.wg_per_tmp.lead_mwst_id, 0) OR 
             COALESCE(p.owg_id, 0) <> COALESCE(DBP_ETL.wg_per_tmp.owg_id, 0)
        THEN 1 
        ELSE 0
      END = 1
;

INSERT INTO DBP_DATA.wg_per_2
(
   mandant_id
  ,wg_id
  ,arthiertyp_id
  ,abt_id
  ,lead_mwst_id
  ,dat_von
  ,dat_bis
  ,owg_id
)
SELECT
   t.mandant_id
  ,t.wg_id
  ,t.arthiertyp_id
  ,t.abt_id
  ,t.lead_mwst_id
  ,t.dat_von
  ,t.dat_bis
  ,t.owg_id
FROM DBP_ETL.wg_per_tmp_2 t

LEFT OUTER JOIN DBP_DATA.wg_per_2 p
ON t.mandant_id = p.mandant_id
  AND t.wg_id = p.wg_id
  AND t.arthiertyp_id = p.arthiertyp_id 
  AND p.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')

WHERE p.mandant_id IS NULL /*neuer Fachschluessel*/
  OR /*Update*/
  (
    CASE WHEN p.mandant_id IS NOT NULL
      AND 
      (
           COALESCE(t.abt_id, 0)       <> COALESCE(p.abt_id, 0)
        OR COALESCE(t.lead_mwst_id, 0) <> COALESCE(p.lead_mwst_id, 0)
        OR COALESCE(t.owg_id, 0)       <> COALESCE(p.owg_id, 0)
      )
      THEN 1 ELSE 0
    END
  ) = 1
;

UPDATE DBP_DATA.wg_per_2
SET dat_bis = dat_bis_

FROM
(
  SELECT
     mandant_id
    ,wg_id
    ,arthiertyp_id 
    ,dat_von
    ,CASE
	    WHEN (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, wg_id, arthiertyp_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD'))) = 0 THEN TO_DATE('9999-12-31','YYYY-MM_2-DD')
	    ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, wg_id, arthiertyp_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD')))),'YYYYMMDD'))
	END AS DAT_BIS_
  FROM DBP_DATA.wg_per_2 
  WHERE arthiertyp_id = 2 AND
        owg_id <> -1) dt
WHERE DBP_DATA.wg_per.mandant_id    = dt.mandant_id
  AND DBP_DATA.wg_per.wg_id         = dt.wg_id
  AND DBP_DATA.wg_per.arthiertyp_id = dt.arthiertyp_id 
  AND DBP_DATA.wg_per.dat_von       = dt.dat_von
  AND DBP_DATA.wg_per.dat_bis      <> dt.dat_bis_
;

-- OWG_PER_2 --

DELETE FROM DBP_ETL.owg_per_tmp_2 t using DBP_DATA.owg_per_2
WHERE t.mandant_id    = DBP_DATA.owg_per.mandant_id
  AND t.owg_id        = DBP_DATA.owg_per.owg_id
  AND t.arthiertyp_id = DBP_DATA.owg_per.arthiertyp_id 
  AND t.dat_von       < DBP_DATA.owg_per.dat_von
;

INSERT INTO DBP_DATA.owg_per_2 (mandant_id
                             ,owg_id
                             ,arthiertyp_id
                             ,dat_von
                             ,dat_bis
                             ,hwg_id
                             ,hr_objekt_bereich_id
                             ,hr_objekt_bereich_id_de)
SELECT t.mandant_id
      ,t.owg_id
      ,t.arthiertyp_id
      ,current_date as dat_von
      ,t.dat_bis
      ,t.hwg_id
      ,t.hr_objekt_bereich_id
      ,t.hr_objekt_bereich_id_de
FROM DBP_ETL.owg_per_tmp_2 t

LEFT JOIN DBP_DATA.owg_per_2 p
  ON t.mandant_id = p.mandant_id AND 
     t.owg_id = p.owg_id AND 
     t.arthiertyp_id = p.arthiertyp_id AND 
     p.dat_bis = '9999-12-31'

WHERE p.mandant_id IS NULL OR
      CASE 
        WHEN p.mandant_id IS NOT NULL AND 
             COALESCE(t.hwg_id, 0) <> COALESCE(p.hwg_id, 0)
        THEN 1 
        ELSE 0
      END = 1
;

UPDATE DBP_DATA.owg_per_2 FROM (SELECT mandant_id
                                    ,owg_id
                                    ,arthiertyp_id 
                                    ,dat_von
                                    ,CASE
                                       WHEN (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id,owg_id,arthiertyp_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD'))) = 0 THEN TO_DATE('9999-12-31','YYYY-MM_2-DD')
	                                   ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id,owg_id,arthiertyp_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD')))),'YYYYMMDD'))
	                                 END AS DAT_BIS_
                              FROM DBP_DATA.owg_per_2
                              where arthiertyp_id = 2 and
                                    hwg_id <> -1) dt
SET dat_bis = dat_bis_

WHERE DBP_DATA.owg_per.mandant_id = dt.mandant_id
  AND DBP_DATA.owg_per.owg_id = dt.owg_id
  AND DBP_DATA.owg_per.arthiertyp_id = dt.arthiertyp_id 
  AND DBP_DATA.owg_per.dat_von = dt.dat_von
  AND DBP_DATA.owg_per.dat_bis <> dt.dat_bis_
;

-- HWG_PER_2 --

DELETE FROM DBP_ETL.hwg_per_tmp_2 t using DBP_DATA.hwg_per_2
WHERE t.mandant_id    = DBP_DATA.hwg_per.mandant_id
  AND t.hwg_id        = DBP_DATA.hwg_per.hwg_id
  AND t.arthiertyp_id = DBP_DATA.hwg_per.arthiertyp_id 
  AND t.dat_von       < DBP_DATA.hwg_per.dat_von
;

INSERT INTO DBP_DATA.hwg_per_2 (mandant_id
                             ,hwg_id
                             ,arthiertyp_id
                             ,dat_von
                             ,dat_bis
                             ,abt_id
                             ,hr_objekt_bereich_id
                             ,hr_objekt_bereich_id_de)
SELECT t.mandant_id
      ,t.hwg_id
      ,t.arthiertyp_id
      ,current_date as dat_von
      ,t.dat_bis
      ,t.abt_id
      ,t.hr_objekt_bereich_id
      ,t.hr_objekt_bereich_id_de
FROM DBP_ETL.hwg_per_tmp_2 t

LEFT JOIN DBP_DATA.hwg_per_2 p
  ON t.mandant_id = p.mandant_id AND 
     t.hwg_id = p.hwg_id AND 
     t.arthiertyp_id = p.arthiertyp_id AND 
     p.dat_bis = '9999-12-31'

WHERE p.mandant_id IS NULL OR
      CASE 
        WHEN p.mandant_id IS NOT NULL AND 
             COALESCE(t.abt_id, 0) <> COALESCE(p.abt_id, 0)
        THEN 1 
        ELSE 0
      END = 1
;

UPDATE DBP_DATA.hwg_per_2 FROM (SELECT mandant_id
                                    ,hwg_id
                                    ,arthiertyp_id 
                                    ,dat_von
                                    ,CASE
                                       WHEN (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id,hwg_id,arthiertyp_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD'))) = 0 THEN TO_DATE('9999-12-31','YYYY-MM_2-DD')
	                                   ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id,hwg_id,arthiertyp_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD')))),'YYYYMMDD'))
	                                 END AS DAT_BIS_
                              FROM DBP_DATA.hwg_per_2
                              where arthiertyp_id = 2 and
                                    abt_id <> -1) dt
SET dat_bis = dat_bis_

WHERE DBP_DATA.hwg_per.mandant_id = dt.mandant_id
  AND DBP_DATA.hwg_per.hwg_id = dt.hwg_id
  AND DBP_DATA.hwg_per.arthiertyp_id = dt.arthiertyp_id 
  AND DBP_DATA.hwg_per.dat_von = dt.dat_von
  AND DBP_DATA.hwg_per.dat_bis <> dt.dat_bis_
;

INSERT INTO DBP_DATA.abt_2 (mandant_id
                         ,abt_id
                         ,arthiertyp_id)
SELECT mandant_id
      ,wg_hierarchie_id AS abt_id 
      ,2 AS arthiertyp_id
FROM DBP_DATA.wg_hierarchie_zu_per_2
WHERE arthiertyp_id = 6
  AND wg_hierarchie_ebene_id = 2 /*Abteilung*/ 
  AND dat_bis = to_date('9999-12-31','YYYY-MM_2-DD') 
  AND wg_hierarchie_id >= 0
  AND (mandant_id, abt_id, 2) NOT IN (SELECT mandant_id,abt_id,arthiertyp_id FROM DBP_DATA.abt_2 WHERE arthiertyp_id = 2)
;

DELETE FROM DBP_DATA.abt_spr_zu_2
WHERE (mandant_id, abt_id, arthiertyp_id, spr_id) IN (SELECT a.mandant_id,a.wg_hierarchie_id AS abt_id,2 AS arthiertyp_id,a.spr_id
                                                      FROM DBP_DATA.wg_hierarchie_spr_zu_2 a
                                                      JOIN DBP_DATA.abt_2 b
                                                        ON a.mandant_id = b.mandant_id AND
                                                           a.wg_hierarchie_id = b.abt_id
                                                      WHERE a.arthiertyp_id = 10 
                                                        AND a.wg_hierarchie_ebene_id = 2 /*Abteilung*/ 
                                                        AND a.wg_hierarchie_id >= 0)
;

INSERT INTO DBP_DATA.abt_spr_zu_2 (mandant_id
                                ,abt_id
                                ,arthiertyp_id
                                ,spr_id
                                ,abt_bez)
SELECT a.mandant_id
      ,a.wg_hierarchie_id AS abt_id
      ,2 AS arthiertyp_id 
      ,a.spr_id
      ,a.wg_hierarchie_bez 
FROM DBP_DATA.wg_hierarchie_spr_zu_2 a
JOIN DBP_DATA.abt_2 b
  ON a.mandant_id = b.mandant_id AND
     a.wg_hierarchie_id = b.abt_id
WHERE a.arthiertyp_id = 10 
  AND a.wg_hierarchie_ebene_id = 2 /*Abteilung*/ 
  AND a.wg_hierarchie_id >= 0
;

UPDATE DBP_DATA.abt_spr_zu_2
   SET abt_bez = s.RO_abt_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.abt_id        as abt_id, 
                a.spr_id        as SPR_ID,
                a.arthiertyp_id as arthiertyp_id,
                b.abt_bez       as RO_abt_bez
          FROM  DBP_DATA.abt_spr_zu_2 a
         INNER  JOIN DBP_DATA.abt_spr_zu_2 b
            ON  a.abt_id=b.abt_id 
           AND  a.arthiertyp_id = b.arthiertyp_id
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.abt_bez <>b.abt_bez
         GROUP  BY 1,2,3,4
) s
WHERE abt_spr_zu.mandant_id =4 
  AND abt_spr_zu.abt_id = s.abt_id
  AND abt_spr_zu.arthiertyp_id = s.arthiertyp_id
  AND abt_spr_zu.spr_id = s.SPR_ID
  AND abt_spr_zu.abt_bez <> s.RO_abt_bez
;

DELETE FROM DBP_DATA.hwg_spr_zu_2
WHERE (mandant_id, hwg_id, arthiertyp_id, spr_id) IN (SELECT a.mandant_id,a.wg_hierarchie_id AS hwg_id,2 AS arthiertyp_id,a.spr_id
                                                      FROM DBP_DATA.wg_hierarchie_spr_zu_2 a
                                                      JOIN DBP_DATA.hwg_per_2 b
                                                        ON a.mandant_id = b.mandant_id AND
                                                           a.wg_hierarchie_id = b.hwg_id AND
                                                           b.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
                                                      WHERE a.arthiertyp_id = 10 
                                                        AND a.wg_hierarchie_ebene_id = 3 /*HWG*/ 
                                                        AND a.wg_hierarchie_id >= 0)
;

INSERT INTO DBP_DATA.hwg_spr_zu_2 (mandant_id,
                                 hwg_id,
                                 arthiertyp_id,
                                 spr_id,
                                 hwg_bez)
SELECT a.mandant_id
      ,a.wg_hierarchie_id AS wg_id
      ,2 AS arthiertyp_id 
      ,a.spr_id
      ,a.wg_hierarchie_bez AS hwg_bez
FROM DBP_DATA.wg_hierarchie_spr_zu_2 a
JOIN DBP_DATA.hwg_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.wg_hierarchie_id = b.hwg_id AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
WHERE a.arthiertyp_id = 10
  AND a.wg_hierarchie_ebene_id = 3 /*HWG*/ 
  AND a.wg_hierarchie_id >= 0
;

UPDATE DBP_DATA.hwg_spr_zu_2
   SET hwg_bez = s.RO_hwg_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.hwg_id        as hwg_id, 
                a.spr_id        as SPR_ID,
                a.arthiertyp_id as arthiertyp_id,
                b.hwg_bez       as RO_hwg_bez
          FROM  DBP_DATA.hwg_spr_zu_2 a
         INNER  JOIN DBP_DATA.hwg_spr_zu_2 b
            ON  a.hwg_id=b.hwg_id 
           AND  a.arthiertyp_id = b.arthiertyp_id
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.hwg_bez <>b.hwg_bez
         GROUP  BY 1,2,3,4
) s
WHERE hwg_spr_zu.mandant_id =4 
  AND hwg_spr_zu.hwg_id = s.hwg_id
  AND hwg_spr_zu.arthiertyp_id = s.arthiertyp_id
  AND hwg_spr_zu.spr_id = s.SPR_ID
  AND hwg_spr_zu.hwg_bez <> s.RO_hwg_bez
;
DELETE FROM DBP_DATA.owg_spr_zu_2
WHERE (mandant_id, owg_id, arthiertyp_id, spr_id) IN (SELECT a.mandant_id,a.wg_hierarchie_id AS owg_id,2 AS arthiertyp_id ,a.spr_id
                                                      FROM DBP_DATA.wg_hierarchie_spr_zu_2 a
                                                      JOIN DBP_DATA.owg_per_2 b
                                                        ON a.mandant_id = b.mandant_id AND
                                                           a.wg_hierarchie_id = b.owg_id AND
                                                           b.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
                                                      WHERE a.arthiertyp_id = 10 
                                                        AND a.wg_hierarchie_ebene_id = 4 /*OWG*/ 
                                                        AND a.wg_hierarchie_id >= 0)
;

INSERT INTO DBP_DATA.owg_spr_zu_2 (mandant_id,
                                 owg_id,
                                 arthiertyp_id,
                                 spr_id,
                                 owg_bez)
SELECT a.mandant_id
      ,a.wg_hierarchie_id AS owg_id
      ,2 AS arthiertyp_id 
      ,a.spr_id
      ,a.wg_hierarchie_bez AS owg_bez
FROM DBP_DATA.wg_hierarchie_spr_zu_2 a
JOIN DBP_DATA.owg_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.wg_hierarchie_id = b.owg_id AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
WHERE a.arthiertyp_id = 10
  AND a.wg_hierarchie_ebene_id = 4 /*OWG*/ 
  AND a.wg_hierarchie_id >= 0
;

UPDATE DBP_DATA.owg_spr_zu_2
   SET owg_bez = s.RO_owg_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.owg_id        as owg_id, 
                a.spr_id        as SPR_ID,
                a.arthiertyp_id as arthiertyp_id,
                b.owg_bez       as RO_owg_bez
          FROM  DBP_DATA.owg_spr_zu_2 a
         INNER  JOIN DBP_DATA.owg_spr_zu_2 b
            ON  a.owg_id=b.owg_id 
           AND  a.arthiertyp_id = b.arthiertyp_id
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.owg_bez <>b.owg_bez
         GROUP  BY 1,2,3,4
) s
WHERE owg_spr_zu.mandant_id =4 
  AND owg_spr_zu.owg_id = s.owg_id
  AND owg_spr_zu.arthiertyp_id = s.arthiertyp_id
  AND owg_spr_zu.spr_id = s.SPR_ID
  AND owg_spr_zu.owg_bez <> s.RO_owg_bez
;

DELETE FROM DBP_DATA.wg_spr_zu_2
WHERE (mandant_id, wg_id, arthiertyp_id, spr_id) IN (SELECT mandant_id,wg_hierarchie_id AS wg_id,2 AS arthiertyp_id,spr_id
                                                     FROM DBP_DATA.wg_hierarchie_spr_zu_2 
                                                     WHERE arthiertyp_id = 10 
                                                       AND wg_hierarchie_ebene_id = 5 /*Warengruppe*/ 
                                                       AND wg_hierarchie_id >= 0)
;

INSERT INTO DBP_DATA.wg_spr_zu_2 (mandant_id
                               ,wg_id
                               ,arthiertyp_id
                               ,spr_id
                               ,wg_bez)
SELECT a.mandant_id
      ,a.wg_hierarchie_id AS wg_id
      ,2 AS arthiertyp_id 
      ,a.spr_id
      ,a.wg_hierarchie_bez AS wg_bez
FROM DBP_DATA.wg_hierarchie_spr_zu_2 a
JOIN DBP_DATA.wg_per_2 b
  ON a.mandant_id = b.mandant_id AND
     a.wg_hierarchie_id = b.wg_id AND
     b.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
WHERE a.arthiertyp_id = 10 
  AND a.wg_hierarchie_ebene_id = 5 /*Warengruppe*/ 
  AND a.wg_hierarchie_id >= 0
;

UPDATE DBP_DATA.wg_spr_zu_2
   SET wg_bez = s.RO_wg_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.wg_id        as wg_id, 
                a.spr_id        as SPR_ID,
                a.arthiertyp_id as arthiertyp_id,
                b.wg_bez       as RO_wg_bez
          FROM  DBP_DATA.wg_spr_zu_2 a
         INNER  JOIN DBP_DATA.wg_spr_zu_2 b
            ON  a.wg_id=b.wg_id 
           AND  a.arthiertyp_id = b.arthiertyp_id
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.wg_bez <>b.wg_bez
         GROUP  BY 1,2,3,4
) s
WHERE wg_spr_zu.mandant_id =4 
  AND wg_spr_zu.wg_id = s.wg_id
  AND wg_spr_zu.arthiertyp_id = s.arthiertyp_id
  AND wg_spr_zu.spr_id = s.SPR_ID
  AND wg_spr_zu.wg_bez <> s.RO_wg_bez
;

update dbp_data.wg_spr_zu_2 from (select *
                                from dbp_etl_process.wg_spr_zu_korrektur_2) b
                                
set wg_bez = b.wg_bez

where dbp_data.wg_spr_zu.mandant_id = b.mandant_id and
      dbp_data.wg_spr_zu.wg_id = b.wg_id and
      dbp_data.wg_spr_zu.spr_id = b.spr_id
;

update dbp_data.owg_spr_zu_2 from (select *
                                 from dbp_etl_process.owg_spr_zu_korrektur_2) b
                                
set owg_bez = b.owg_bez

where dbp_data.owg_spr_zu.mandant_id = b.mandant_id and
      dbp_data.owg_spr_zu.owg_id = b.owg_id and
      dbp_data.owg_spr_zu.spr_id = b.spr_id
;

update dbp_data.wg_per_2 set dat_bis = '2024-11-30',
                           werbeteam_cd = 'nicht vorhanden'
where wg_id = 961 and
      dat_bis = '9999-12-31'
;
