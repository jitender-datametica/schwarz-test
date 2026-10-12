--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.

--2021-09-22 mfialkiewicz drop moved from script 001


DROP TABLE IF EXISTS dbp_etl.artbew_agg_tmp;


CREATE TABLE IF NOT EXISTS dbp_etl.artbew_agg_tmp (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.artbew_agg_tmp (wup_id, mandant_id, nb_id, dat)
(
    SELECT
        wup_id,
        mandant_id,
        nb_id,
        dat
    FROM dbp_etl.`_artbew_tmp`
    GROUP BY
        wup_id,
        mandant_id,
        nb_id,
        dat
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.artbew_agg_wt (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_etl.artbew_agg_tmp
    WHERE (
        mandant_id, wup_id, nb_id, dat) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat)
        FROM dbp_data.artbew_agg_wt
    )
    GROUP BY
        wup_id,
        mandant_id,
        nb_id,
        dat
);
