DELETE  FROM ${TEMP_TABLE} /*DBP_ETL.wug_spr_zu_temp_2*/
WHERE wug_id = -1
;

DELETE FROM DBP_DATA.wug_spr_zu_2
WHERE
(
	 wg_id
	,wug_id
	,spr_id
	,mandant_id
	,arthiertyp_id
)
IN
(
  SELECT
	 wg_id
	,wug_id
	,spr_id
	,mandant_id
	,arthiertyp_id
  FROM ${TEMP_TABLE} /*DBP_ETL.wug_spr_zu_temp_2*/
  WHERE wug_bez <> 'system generated'
)
;

INSERT INTO DBP_DATA.wug_spr_zu_2
(
	wg_id
	,wug_id
	,wug_bez
	,mandant_id
	,spr_id
	,arthiertyp_id
)
SELECT
	wg_id
	,wug_id
	,wug_bez
	,mandant_id
	,spr_id
	,arthiertyp_id

FROM ${TEMP_TABLE} /*DBP_ETL.wug_spr_zu_temp_2*/
WHERE
(
	 wg_id
	,wug_id
	,spr_id
	,mandant_id
	,arthiertyp_id
)
NOT IN
(SELECT
	wg_id
	,wug_id
	,spr_id
	,mandant_id
	,arthiertyp_id
 FROM DBP_DATA.wug_spr_zu_2
)
;
DELETE  FROM ${TEMP_TABLE} 
WHERE wug_id = -1
;

DELETE FROM DBP_DATA.wug_spr_zu_2
WHERE
(
	 wg_id
	,wug_id
	,spr_id
	,mandant_id
	,arthiertyp_id
)
IN
(
  SELECT
	 wg_id
	,wug_id
	,spr_id
	,mandant_id
	,arthiertyp_id
  FROM ${TEMP_TABLE} /*DBP_ETL.wug_spr_zu_temp_2*/
  WHERE wug_bez <> 'system generated'
)
;

INSERT INTO DBP_DATA.wug_spr_zu_2
(
	wg_id
	,wug_id
	,wug_bez
	,mandant_id
	,spr_id
	,arthiertyp_id
)
SELECT
	wg_id
	,wug_id
	,wug_bez
	,mandant_id
	,spr_id
	,arthiertyp_id

FROM ${TEMP_TABLE} 
WHERE
(
	 wg_id
	,wug_id
	,spr_id
	,mandant_id
	,arthiertyp_id
)
NOT IN
(SELECT
	wg_id
	,wug_id
	,spr_id
	,mandant_id
	,arthiertyp_id
 FROM DBP_DATA.wug_spr_zu_2
)
;

delete from dbp_data.wug_spr_zu_2
where wug_id = -9
;


UPDATE  DBP_DATA.wug_spr_zu_2
   SET wug_bez = s.RO_wug_bez,
       td_update = CURRENT_TIMESTAMP
FROM (
        SELECT  a.wg_id  	as wg_id, 
                a.wug_id  	as wug_id,
                a.arthiertyp_id as arthiertyp_id,
                a.spr_id    as SPR_ID,
                b.wug_bez as RO_wug_bez
          FROM  DBP_DATA.wug_spr_zu_2 a
         INNER  JOIN DBP_DATA.wug_spr_zu_2 b
            ON  a.wg_id=b.wg_id
           AND  a.wug_id=b.wug_id
           AND  a.arthiertyp_id = b.arthiertyp_id 
           AND  a.spr_id= b.spr_id
         WHERE  a.mandant_id =4 and a.spr_id <>22 
           AND  b.mandant_id =7 and b.spr_id <>22
           AND  a.wug_bez <>b.wug_bez
         GROUP  BY 1,2,3,4,5
) s
WHERE wug_spr_zu.mandant_id    = 4 
  AND wug_spr_zu.wg_id         = s.wg_id
  AND wug_spr_zu.wug_id        = s.wug_id
  AND wug_spr_zu.arthiertyp_id = s.arthiertyp_id
  AND wug_spr_zu.spr_id        = s.SPR_ID
  AND wug_spr_zu.wug_bez       <> s.RO_wug_bez
;
