--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.artkz_loesch
(
  loesch_id,
  mandant_id,
  spr_id,
  loesch_bez
)
SELECT distinct
  loesch_id,
  mandant_id,
  22 AS spr_id,
  loesch_bez
FROM ${TEMP_TABLE} /*DBP_ETL.artkz_loesch_temp*/  t1
WHERE (loesch_id,mandant_id,1) not in
  (SELECT t3.loesch_id,t3.mandant_id, count(t3.spr_id)  
   FROM DBP_DATA.artkz_loesch  t3 
   WHERE t3.spr_id=22
   GROUP BY 1,2
   HAVING count(t3.spr_id) =1 
   )
;

