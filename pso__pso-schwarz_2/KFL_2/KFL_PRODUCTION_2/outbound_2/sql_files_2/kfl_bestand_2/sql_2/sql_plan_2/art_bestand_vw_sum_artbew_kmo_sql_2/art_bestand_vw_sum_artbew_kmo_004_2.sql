-- [not OK] statement is not translated correctly-----------------------------------------------------------------
-- WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
-- WARNING : Possible parameter resolution issue
-- original statement
-- INSERT INTO DBX_LOAD.art_best_vw_sum_artbew_kmo_dat_2
-- (
--  mandant_id,
--  dat
-- )
-- SELECT
--  $MANDANT_ID AS mandant_id,
--  dat
-- FROM DBX_DATA.tag_2
-- WHERE dat BETWEEN CAST('$START' AS DATE FORMAT 'YYYYMMDD') AND CAST('$ENDE' AS DATE FORMAT 'YYYYMMDD')
-- AND (mandant_id, dat) NOT IN
-- (
--   SELECT
--     mandant_id,
--     dat
--   FROM DBX_LOAD.art_best_vw_sum_artbew_kmo_dat_2
-- )
-- ;
--
-- Comment from validation checker
-- error line 7 at position 3 unexpected 'AS'.
--  $ ^^^> MANDANT_ID AS mandant_id,
-- syntax error line 10 at position 34 unexpected 'FORMAT'.
-- WHERE dat BETWEEN CAST('$START' AS ^^^>  DATE FORMAT 'YYYYMMDD') AND CAST('$ENDE' AS DATE FORMAT 'YYYYMMDD')
-- syntax error line 10 at position 73 unexpected 'FORMAT'.
-- WHERE dat BETWEEN CAST('$START' AS DATE FORMAT 'YYYYMMDD') AND CAST('$END ^^^> E' AS DATE FORMAT 'YYYYMMDD')
-- translated statement

INSERT INTO dbp_etl.art_best_vw_sum_artbew_kmo_dat_2
  (mandant_id, dat)
    (
      SELECT
        $MANDANT_ID AS mandant_id,
        dat
      FROM dbp_data.tag_2
      WHERE
        dat BETWEEN DATE('$START') AND (DATE('$ENDE'))
        AND (1, dat)
          NOT IN (
            SELECT (mandant_id, dat)
            FROM dbp_etl.art_best_vw_sum_artbew_kmo_dat_2
          )
    );
