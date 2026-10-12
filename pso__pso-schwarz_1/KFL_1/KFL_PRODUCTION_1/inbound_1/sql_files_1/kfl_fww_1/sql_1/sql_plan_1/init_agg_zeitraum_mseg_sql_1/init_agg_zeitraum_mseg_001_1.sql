--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.zeitraum_mseg_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.zeitraum_mseg_1  (
      mandant_id        BYTEINT,
      min_dat           DATE,
      max_dat           DATE,
      ranking           INTEGER
     )
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.zeitraum_mseg_1
--(
--         mandant_id
--        ,min_dat
--        ,max_dat
--        ,ranking
--)
--SELECT
--          c.mandant_id
--        , b.min_dat
--        , b.max_dat 
--        , RANK () OVER (PARTITION BY c.mandant_id ORDER BY b.min_dat DESC)  AS ranking
--
--FROM ${DWH_COMMON_DBX_DATA}.tag_1 a
--
--INNER JOIN ${DWH_COMMON_DBX_DATA}.monat_1 b
--        ON a.kjmo = b.kjmo
--
--CROSS JOIN ${DWH_COMMON_DBX_DATA}.mandant_1 c 
--
--WHERE a.dat BETWEEN   ${DAT_START} AND DATE
--AND c.mandant_id IN  (${MANDANT_1})
--GROUP BY 1,2,3
--
--QUALIFY ranking <= ${ZEITRAUM}
--;
--
--Comment from validation checker
--error line 21 at position 23 unexpected 'AND'.
--WHERE a.dat BETWEEN   $ ^^^> {DAT_START} AND CURRENT_DATE
--syntax error line 22 at position 22 unexpected ')'.
--AND c.mandant_id IN  ( ^^^> ${MANDANT_1})
--syntax error line 26 at position 0 unexpected ';'.
-- ^^^> ;
--translated statement
INSERT INTO DBP_ETL.zeitraum_mseg_1
(
         mandant_id
        ,min_dat
        ,max_dat
        ,ranking
)
SELECT
          c.mandant_id
        , b.min_dat
        , b.max_dat 
        , RANK () OVER (PARTITION BY c.mandant_id ORDER BY b.min_dat DESC)  AS ranking

FROM DBP_DATA.tag_1 a

INNER JOIN DBP_DATA.monat_1 b
        ON a.kjmo = b.kjmo

CROSS JOIN DBP_DATA.mandant_1 c 

WHERE a.dat BETWEEN   ${DAT_START} AND CURRENT_DATE
AND c.mandant_id IN  (${MANDANT_1})
GROUP BY 1,2,3

QUALIFY ranking <= ${ZEITRAUM}
;

