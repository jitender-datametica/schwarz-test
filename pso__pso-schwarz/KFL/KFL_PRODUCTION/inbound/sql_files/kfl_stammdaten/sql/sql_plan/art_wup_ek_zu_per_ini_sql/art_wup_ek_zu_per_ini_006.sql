--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_wup_ek_datum_relevant (dat_relevant,
--                                                 dat_ausstieg,
--                                                 rueckbewertung_fg)
--SELECT CASE
--         WHEN EXTRACT(MONTH FROM DATE) = 1
--         THEN CAST(EXTRACT(YEAR FROM DATE)-1||'-01-01' AS DATE)
--         ELSE CAST(EXTRACT(YEAR FROM DATE)  ||'-01-01' AS DATE)
--       END AS dat_relevant,
--       DATE AS dat_ausstieg,
--       1 AS rueckbewertung_fg;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBP_ETL.art_wup_ek_datum_relevant (dat_relevant,
                                                 dat_ausstieg,
                                                 rueckbewertung_fg)
SELECT CASE
         WHEN EXTRACT(MONTH FROM CURRENT_DATE) = 1
         THEN CAST(EXTRACT(YEAR FROM CURRENT_DATE)-1||'-01-01' AS CURRENT_DATE)
         ELSE CAST(EXTRACT(YEAR FROM CURRENT_DATE)  ||'-01-01' AS CURRENT_DATE)
       END AS dat_relevant,
       CURRENT_DATE AS dat_ausstieg,
       1 AS rueckbewertung_fg;

