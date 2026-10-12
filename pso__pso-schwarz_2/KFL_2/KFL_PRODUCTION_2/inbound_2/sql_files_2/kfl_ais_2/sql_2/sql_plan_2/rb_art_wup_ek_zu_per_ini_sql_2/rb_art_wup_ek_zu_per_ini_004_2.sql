--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_wup_ek_datum_relevant_2  (
   dat_relevant DATE NOT NULL,
   dat_ausstieg DATE NOT NULL,
   rueckbewertung_fg BYTEINT NOT NULL
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
INSERT INTO DBP_ETL.art_wup_ek_datum_relevant_2 (dat_relevant,
                                                 dat_ausstieg,
                                                 rueckbewertung_fg)
SELECT CASE
         WHEN EXTRACT(MONTH FROM CURRENT_DATE) = 1
         THEN CAST(EXTRACT(YEAR FROM CURRENT_DATE)-1||'-01-01' AS DATE)
         ELSE CAST(EXTRACT(YEAR FROM CURRENT_DATE)  ||'-01-01' AS DATE)
       END AS dat_relevant,
       CURRENT_DATE AS dat_ausstieg,
       1 AS rueckbewertung_fg;

