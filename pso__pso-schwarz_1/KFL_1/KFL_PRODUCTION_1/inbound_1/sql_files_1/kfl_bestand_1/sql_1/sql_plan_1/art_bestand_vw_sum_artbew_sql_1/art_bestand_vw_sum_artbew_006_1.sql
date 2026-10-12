--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : Possible parameter resolution issue
--original statement
--INSERT INTO DBX_LOAD.art_bestand_vw_sum_artbew_dat_1
--(
--  mandant_id, 
--  dat 
--) 
--SELECT 
--  1 AS mandant_id,
--  dat 
--FROM DBX_DATA.tag_1 
--WHERE dat BETWEEN CAST('$START' AS DATE FORMAT 'YYYYMMDD') AND CAST('$ENDE' AS DATE FORMAT 'YYYYMMDD')
-- AND (mandant_id, dat) NOT IN 
-- (
--   SELECT 
--     mandant_id, 
--     dat 
--   FROM DBX_LOAD.art_bestand_vw_sum_artbew_dat_1
-- ) 
--;
--
--Comment from validation checker
--error line 10 at position 34 unexpected 'FORMAT'.
--WHERE dat BETWEEN CAST('$START' AS ^^^>  DATE FORMAT 'YYYYMMDD') AND CAST('$ENDE' AS DATE FORMAT 'YYYYMMDD')
--syntax error line 10 at position 73 unexpected 'FORMAT'.
--WHERE dat BETWEEN CAST('$START' AS DATE FORMAT 'YYYYMMDD') AND CAST('$END ^^^> E' AS DATE FORMAT 'YYYYMMDD')
--translated statement
INSERT INTO DBP_ETL.art_bestand_vw_sum_artbew_dat_1
(
  mandant_id, 
  dat 
) 
SELECT 
  1 AS mandant_id,
  dat 
FROM DBP_DATA.tag_1 
WHERE dat BETWEEN CAST('$START' AS DATE FORMAT 'YYYYMMDD') AND CAST('$ENDE' AS DATE FORMAT 'YYYYMMDD')
 AND (mandant_id, dat) NOT IN 
 (
   SELECT 
     mandant_id, 
     dat 
   FROM DBP_ETL.art_bestand_vw_sum_artbew_dat_1
 ) 
;

