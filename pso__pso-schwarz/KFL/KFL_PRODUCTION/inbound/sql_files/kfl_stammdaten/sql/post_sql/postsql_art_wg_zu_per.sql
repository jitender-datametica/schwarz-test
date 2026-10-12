update ${TEMP_TABLE} set wug_id = 0
where mandant_id = 1 and
      art_id = 980001200
;

UPDATE DBP_DATA.art_wg_zu_per 
SET
     dat_bis                   = _dat_bis
FROM
(SELECT
     art_id                    as _art_id
    ,mandant_id                as _mandant_id
    ,wug_id                    as _wug_id
    ,wg_id                     as _wg_id
    ,dat_von                   as _dat_von
    ,arthiertyp_id             as _arthiertyp_id
    ,dat_bis                   as _dat_bis
FROM ${TEMP_TABLE} ) t1 
WHERE
       art_id                    = _art_id
   AND mandant_id                = _mandant_id
   AND arthiertyp_id             = _arthiertyp_id
   AND wg_id                     = _wg_id
   AND wug_id                    = _wug_id
   AND dat_von                   = _dat_von
;

UPDATE DBP_DATA.art_wg_zu_per

SET wug_id = _wug_id
   ,wg_id  = _wg_id

FROM
(
  SELECT
     art_id           AS _art_id
    ,mandant_id       AS _mandant_id
    ,MAX(wug_id)      AS _wug_id
    ,MAX(wg_id)       AS _wg_id
    ,dat_von          AS _dat_von
    ,arthiertyp_id    AS _arthiertyp_id
    ,dat_bis          AS _dat_bis
  FROM ${TEMP_TABLE}
  GROUP BY 1,2,5,6,7
) dt1 WHERE art_id = _art_id
  AND dat_von = _dat_von
  AND arthiertyp_id = _arthiertyp_id
  AND mandant_id = _mandant_id
  AND dat_bis = to_date('9999-12-31','YYYY-MM-DD')
  AND (wug_id <> _wug_id OR wg_id  <> _wg_id)
;

INSERT INTO DBP_DATA.art_wg_zu_per
(
   art_id
  ,mandant_id
  ,wug_id
  ,wg_id
  ,dat_von
  ,arthiertyp_id
  ,dat_bis
)
SELECT
   a.art_id
  ,a.mandant_id
  ,a.wug_id
  ,a.wg_id
  ,a.dat_von
  ,a.arthiertyp_id
  ,a.dat_bis
FROM ${TEMP_TABLE} a

LEFT OUTER JOIN DBP_DATA.art_wg_zu_per b
ON a.mandant_id       = b.mandant_id
  AND a.art_id        = b.art_id
  AND a.arthiertyp_id = b.arthiertyp_id
  AND a.wg_id        = b.wg_id
  AND a.wug_id       = b.wug_id
  AND b.dat_bis       = to_date('9999-12-31','YYYY-MM-DD')
  AND b.dat_von      <= a.dat_von

WHERE b.art_id IS NULL
  AND (a.art_id, a.mandant_id, a.wg_id,a.wug_id, a.arthiertyp_id, a.dat_bis) NOT IN
  (
    SELECT 
       art_id
      ,mandant_id
      ,wg_id
      ,wug_id
      ,arthiertyp_id
      ,dat_bis
    FROM DBP_DATA.art_wg_zu_per
  )

GROUP BY 1,2,3,4,5,6,7
;

UPDATE DBP_DATA.art_wg_zu_per

SET dat_bis = dt1.dat_bis

FROM
  (
   SELECT
      mandant_id
     ,art_id
     ,dat_von
     ,arthiertyp_id
     ,CASE
       WHEN (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, art_id, arthiertyp_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD'))) = 0 THEN TO_DATE('9999-12-31','YYYY-MM-DD')
	 ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, art_id, arthiertyp_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD')))),'YYYYMMDD'))
    END AS DAT_BIS
    FROM DBP_DATA.art_wg_zu_per
  ) dt1
 WHERE DBP_DATA.art_wg_zu_per.mandant_id    = dt1.mandant_id
  AND DBP_DATA.art_wg_zu_per.art_id        = dt1.art_id
  AND DBP_DATA.art_wg_zu_per.arthiertyp_id = dt1.arthiertyp_id
  AND DBP_DATA.art_wg_zu_per.dat_von       = dt1.dat_von
  AND DBP_DATA.art_wg_zu_per.dat_bis      <> dt1.dat_bis
;

UPDATE DBP_DATA.art_wg_zu_per 
SET dat_von = b.dat_von_mara

FROM (SELECT a.mandant_id,
             a.art_id,
             a.dat_von_wg,
             b.dat_von_mara
      FROM (SELECT mandant_id,
                   art_id,
                   MIN(dat_von) AS dat_von_wg
            FROM DBP_DATA.art_wg_zu_per
            GROUP BY 1,2) a
      JOIN (SELECT mandant_id,
                   art_id,
                   MIN(dat_von) AS dat_von_mara
            FROM DBP_DATA.art
            GROUP BY 1,2) b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id
      WHERE a.dat_von_wg > b.dat_von_mara) b

WHERE DBP_DATA.art_wg_zu_per.mandant_id = b.mandant_id AND
      DBP_DATA.art_wg_zu_per.art_id = b.art_id AND
      DBP_DATA.art_wg_zu_per.dat_von = b.dat_von_wg
;

INSERT INTO DBP_ETL_PROCESS.dwh_wg_erfass_artikel
(art_id, mandant_id, wg_id, arthiertyp_id )
SELECT
a.art_id
, 1 AS mandant_id
, aw.wg_id wgr
, 2 as _arthiertyp_id
FROM DBP_DATA.art a

INNER JOIN DBP_DATA.art_wg_zu_per aw
ON a.art_id = aw.art_id
AND wg_art_fg = 1
AND a.mandant_id = 1
AND aw.arthiertyp_id = 2
AND aw.mandant_id = 1
AND a.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
AND aw.dat_bis = to_date('9999-12-31','YYYY-MM-DD')

LEFT OUTER JOIN DBP_DATA.wg_per wg
ON  aw.wg_id = wg.wg_id
AND wg.mandant_id = 1
AND a.mwst_id = wg.lead_mwst_id
AND wg.arthiertyp_id = 2
AND wg.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
WHERE ( aw.wg_id , _arthiertyp_id)
NOT IN
(
SELECT
wg_id
, arthiertyp_id
FROM DBP_ETL_PROCESS.dwh_wg_erfass_artikel
) 
QUALIFY  row_number() OVER (PARTITION BY  aw.wg_id  order by COALESCE((wg.lead_mwst_id-a.mwst_id),999), a.art_id desc) = 1 
;
