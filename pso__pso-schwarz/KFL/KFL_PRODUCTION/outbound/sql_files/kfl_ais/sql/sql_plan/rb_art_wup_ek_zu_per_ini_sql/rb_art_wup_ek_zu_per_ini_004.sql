--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.art_wup_ek_datum_relevant (
    dat_relevant DATE NOT NULL,
    dat_ausstieg DATE NOT NULL,
    rueckbewertung_fg INTEGER NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.


INSERT INTO dbp_etl.art_wup_ek_datum_relevant (
    dat_relevant, dat_ausstieg, rueckbewertung_fg
)
(
    SELECT
        CASE
            WHEN EXTRACT(MONTH FROM CURRENT_DATE("Europe/Berlin")) = 1
                THEN
                    DATE(
                        CAST(
                            EXTRACT(YEAR FROM CURRENT_DATE("Europe/Berlin"))
                            - 1 AS STRING
                        )
                        || '-01-01'
                    )
            ELSE
                DATE(
                    CAST(
                        EXTRACT(
                            YEAR FROM CURRENT_DATE("Europe/Berlin")
                        ) AS STRING
                    )
                    || '-01-01'
                )
        END AS dat_relevant,
        CURRENT_DATE("Europe/Berlin") AS dat_ausstieg,
        1 AS rueckbewertung_fg
);
