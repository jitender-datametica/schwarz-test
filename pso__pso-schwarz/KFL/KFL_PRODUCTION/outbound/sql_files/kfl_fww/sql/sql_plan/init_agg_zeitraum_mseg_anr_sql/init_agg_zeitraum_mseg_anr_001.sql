--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.zeitraum_mseg_anr;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.


CREATE TABLE IF NOT EXISTS dbp_etl.zeitraum_mseg_anr (
    mandant_id INTEGER,
    min_dat DATE,
    max_dat DATE,
    ranking INTEGER
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ZEITRAUM_MSEG' does not exist or not authorized.


INSERT INTO dbp_etl.zeitraum_mseg_anr (mandant_id, min_dat, max_dat, ranking)
(SELECT
    mandant_id,
    min_dat,
    max_dat,
    ranking
FROM dbp_etl.zeitraum_mseg
WHERE (
    mandant_id, ranking) IN (
    SELECT (mandant_id, MAX(ranking))
    FROM dbp_etl.zeitraum_mseg
    GROUP BY mandant_id
));
