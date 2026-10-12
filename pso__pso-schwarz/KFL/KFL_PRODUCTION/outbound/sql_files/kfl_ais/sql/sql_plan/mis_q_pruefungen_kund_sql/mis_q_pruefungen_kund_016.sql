--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.mis_q_kunden_gleich (
    mandant_id INTEGER,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    dat_gleich DATE,
    bonanzahl NUMERIC(29, 2)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.mis_q_kunden_gleich (
    mandant_id, wup_id, nb_id, dat, dat_gleich, bonanzahl
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.dat,
        T2.dat_vgl AS dat_gleich,
        T1.bonanzahl
    FROM dbp_etl.mis_q_kunden AS T1
    INNER JOIN dbp_etl.mis_q_kunden AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.wup_id = T2.wup_id AND T1
            .nb_id = T2.nb_id
            AND T1.dat = T2.dat
            AND T1.bonanzahl = T2.bonanzahl
    WHERE
        T1.kunden_fg = 1
        AND T2.kundengleich_fg = 1
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.KUNDENANZ_AGG_WT' does not exist or not authorized.


UPDATE dbp_data.wupcal SET
    pruef_grund_id_kunde = dt1.pruef_grund_id_kunde_,
    pruef_status_id_kunde = CASE
        WHEN wupcal.pruef_status_id_kunde IS NULL
            THEN dt1.pruef_status_id_kunde_
        ELSE dt1.pruef_status_id_kunde_reload_
    END FROM (
    SELECT
        t1.mandant_id AS mandant_id_,
        t1.wup_id AS wup_id_,
        t1.nb_id AS nb_id_,
        t1.dat AS dat_,
        MAX(CASE
            WHEN T2.wup_id IS NULL
                THEN ' '
            ELSE 'D'
        END || CASE
            WHEN T3.wup_id IS NULL
                THEN ' '
            ELSE 'G'
        END || ' ') AS pruef_grund_id_kunde_,
        CASE
            WHEN
                MAX(CASE
                    WHEN T2.wup_id IS NULL
                        THEN ' '
                    ELSE 'D'
                END || CASE
                    WHEN T3.wup_id IS NULL
                        THEN ' '
                    ELSE 'G'
                END || ' ') = '   '
                THEN 1
            ELSE 0
        END AS pruef_status_id_kunde_,
        CASE
            WHEN
                MAX(CASE
                    WHEN T2.wup_id IS NULL
                        THEN ' '
                    ELSE 'D'
                END || CASE
                    WHEN T3.wup_id IS NULL
                        THEN ' '
                    ELSE 'G'
                END || ' ') = '   '
                THEN 2
            ELSE -1
        END AS pruef_status_id_kunde_reload_
    FROM (
        SELECT *
        FROM dbp_etl_process.kundenanz_agg_wt
        WHERE
            dat BETWEEN DATE_SUB(
                CURRENT_DATE("Europe/Berlin"), INTERVAL 365 DAY
            ) AND (CURRENT_DATE("Europe/Berlin"))
    ) AS t1
    LEFT JOIN dbp_etl.mis_q_kunden_abw_avg AS T2
        ON
            t1.dat = T2.dat AND t1.mandant_id = T2.mandant_id
            AND t1.wup_id = T2.wup_id AND t1.nb_id = T2.nb_id
    LEFT JOIN dbp_etl.mis_q_kunden_gleich AS T3
        ON
            t1.dat = T3.dat AND t1.mandant_id = T3.mandant_id
            AND t1.wup_id = T3.wup_id AND t1.nb_id = T3.nb_id
    WHERE t1.calc_fg = 0
    GROUP BY
        mandant_id_,
        wup_id_,
        nb_id_,
        dat_
) AS dt1
WHERE
    wupcal.mandant_id = dt1.mandant_id_
    AND wupcal.wup_id = dt1.wup_id_
    AND wupcal.nb_id = dt1.nb_id_
    AND wupcal.dat
    = dt1.dat_;
