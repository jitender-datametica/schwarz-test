--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.

--2021-09-22 mfialkiewicz drop moved from script 001 
DROP TABLE IF EXISTS DBP_ETL.artbew_agg_tmp_1; 

CREATE TABLE DBP_ETL.artbew_agg_tmp_1  (
  wup_id INTEGER NOT NULL,
  mandant_id BYTEINT NOT NULL,
  nb_id SMALLINT NOT NULL ,
  dat DATE NOT NULL
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.artbew_agg_tmp_1
(
   wup_id
  ,mandant_id
  ,nb_id
  ,dat
)
SELECT
   wup_id
  ,mandant_id
  ,nb_id
  ,dat
FROM _artbew_tmp
GROUP BY 1,2,3,4
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.artbew_agg_wt_1
(
   mandant_id
  ,wup_id
  ,nb_id
  ,dat
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,dat
FROM DBP_ETL.artbew_agg_tmp_1

WHERE (mandant_id, wup_id, nb_id, dat) NOT IN 
  (
    SELECT 
       mandant_id
      ,wup_id
      ,nb_id
      ,dat 
    FROM DBP_DATA.artbew_agg_wt_1
  )
  
GROUP BY 1,2,3,4
;

