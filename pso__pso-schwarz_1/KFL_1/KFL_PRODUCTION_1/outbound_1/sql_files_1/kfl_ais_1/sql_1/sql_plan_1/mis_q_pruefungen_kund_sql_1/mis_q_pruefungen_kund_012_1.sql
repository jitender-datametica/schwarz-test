--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.mis_q_kunden_abw_avg_1 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    bonanzahl NUMERIC(29, 2),
    bonanzahl_avg NUMERIC(29, 2),
    abweichung_prz NUMERIC(29, 2)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.mis_q_kunden_abw_avg_1 (
    mandant_id, wup_id, nb_id, dat, bonanzahl, bonanzahl_avg,
    abweichung_prz
)
(SELECT
    mandant_id,
    wup_id,
    nb_id,
    dat,
    bonanzahl,
    CAST(CASE
        WHEN bonanzahl_avg_sum = 0 OR kundenavg_fg_sum = 0
            THEN NULL
        ELSE bonanzahl_avg_sum / kundenavg_fg_sum
    END AS NUMERIC) AS bonanzahl_avg,
    CAST(CASE
        WHEN
            CASE
                WHEN bonanzahl_avg_sum = 0 OR kundenavg_fg_sum = 0
                    THEN NULL
                ELSE bonanzahl_avg_sum / kundenavg_fg_sum
            END IS NULL OR CASE
                WHEN bonanzahl_avg_sum = 0 OR kundenavg_fg_sum = 0
                    THEN NULL
                ELSE bonanzahl_avg_sum / kundenavg_fg_sum
            END = 0
            THEN NULL
        ELSE (bonanzahl - CASE
            WHEN bonanzahl_avg_sum = 0 OR kundenavg_fg_sum = 0
                THEN NULL
            ELSE bonanzahl_avg_sum / kundenavg_fg_sum
        END) / CASE
            WHEN bonanzahl_avg_sum = 0 OR kundenavg_fg_sum = 0
                THEN NULL
            ELSE bonanzahl_avg_sum / kundenavg_fg_sum
        END
    END AS NUMERIC) AS abweichung_prz
FROM (
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        SUM(bonanzahl * kunden_fg) AS bonanzahl,
        SUM(bonanzahl * kundenavg_fg) AS bonanzahl_avg_sum,
        SUM(kundenavg_fg) AS kundenavg_fg_sum
    FROM dbp_etl.mis_q_kunden_1
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat
) AS dt1
WHERE CASE
    WHEN
        CASE
            WHEN bonanzahl_avg_sum = 0 OR kundenavg_fg_sum = 0
                THEN NULL
            ELSE bonanzahl_avg_sum / kundenavg_fg_sum
        END IS NULL OR CASE
            WHEN bonanzahl_avg_sum = 0 OR kundenavg_fg_sum = 0
                THEN NULL
            ELSE bonanzahl_avg_sum / kundenavg_fg_sum
        END = 0
        THEN NULL
    ELSE (bonanzahl - CASE
        WHEN bonanzahl_avg_sum = 0 OR kundenavg_fg_sum = 0
            THEN NULL
        ELSE bonanzahl_avg_sum / kundenavg_fg_sum
    END) / CASE
        WHEN bonanzahl_avg_sum = 0 OR kundenavg_fg_sum = 0
            THEN NULL
        ELSE bonanzahl_avg_sum / kundenavg_fg_sum
    END
END NOT BETWEEN -0.5 AND 0.5);
