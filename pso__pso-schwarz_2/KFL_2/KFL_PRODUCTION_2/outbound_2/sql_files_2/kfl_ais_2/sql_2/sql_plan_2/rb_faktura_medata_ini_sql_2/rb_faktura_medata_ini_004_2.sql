--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.


INSERT INTO dbp_etl.rb_faktura_medata_date_2 (gjmo, kjmo, dat_von, dat_bis)
(
    SELECT
        gjmo,
        kjmo,
        MIN(dat) AS dat_von,
        MAX(dat) AS dat_bis
    FROM dbp_data.tag_2
    WHERE
        dat < CURRENT_DATE("Europe/Berlin")
        AND (kj = EXTRACT(
            YEAR FROM CURRENT_DATE("Europe/Berlin")
        )
        OR kj = EXTRACT(YEAR FROM CURRENT_DATE("Europe/Berlin")) - 1
        AND 1 = EXTRACT(
            MONTH FROM
            CURRENT_DATE("Europe/Berlin")
        ))
    GROUP BY
        kjmo,
        gjmo
);
