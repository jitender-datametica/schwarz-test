--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS dbp_etl.zeitraum_mseg;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE IF NOT EXISTS dbp_etl.zeitraum_mseg (
mandant_id INTEGER,
min_dat DATE,
max_dat DATE,
ranking INTEGER
);
--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.zeitraum_mseg
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
--FROM KFL_PRODUCTION.${DWH_COMMON_DBX_DATA}.tag a
--
--INNER JOIN KFL_PRODUCTION.${DWH_COMMON_DBX_DATA}.monat b
--        ON a.kjmo = b.kjmo
--
--CROSS JOIN KFL_PRODUCTION.${DWH_COMMON_DBX_DATA}.mandant c 
--
--WHERE a.dat BETWEEN   ${DAT_START} AND DATE
--AND c.mandant_id IN  (${MANDANT})
--GROUP BY 1,2,3
--
--QUALIFY ranking <= ${ZEITRAUM}
--;
--
--Comment from validation checker
--error line 21 at position 23 unexpected 'AND'.
--WHERE a.dat BETWEEN   $ ^^^> {DAT_START} AND CURRENT_DATE("Europe/Berlin")
--syntax error line 22 at position 22 unexpected ')'.
--AND c.mandant_id IN  ( ^^^> ${MANDANT})
--syntax error line 26 at position 0 unexpected ';'.
-- ^^^> ;
--translated statement

INSERT INTO dbp_etl.zeitraum_mseg (mandant_id, min_dat, max_dat, ranking)
(SELECT t1.mandant_id,
  t1.min_dat,
  t1.max_dat,
  RANK() OVER (PARTITION BY t1.mandant_id ORDER BY t1.min_dat IS NULL DESC, t1.min_dat DESC) AS ranking
 FROM (SELECT C.mandant_id,
    B.min_dat,
    B.max_dat
   FROM dbp_data.tag AS A
    INNER JOIN dbp_data.monat AS B ON A.kjmo = B.kjmo
    INNER JOIN dbp_data.mandant AS C ON TRUE
   WHERE A.dat BETWEEN ${DAT_START} AND (CURRENT_DATE("Europe/Berlin"))
    AND C.mandant_id IN (${MANDANT})
   GROUP BY B.min_dat,
    B.max_dat,
    C.mandant_id) AS t1
 QUALIFY (RANK() OVER (PARTITION BY t1.mandant_id ORDER BY t1.min_dat IS NULL DESC, t1.min_dat DESC)) <= ${ZEITRAUM});