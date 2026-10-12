--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.mis_q_kunden_join_tag_2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    dat_vgl DATE NOT NULL,
    kundengleich_fg INTEGER NOT NULL,
    kundenavg_fg INTEGER NOT NULL,
    kunden_fg INTEGER NOT NULL
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMzENT.DBP_ETL_PROCESS.KUNDENANZ_AGG_WT_2' does not exist or not authorized.


INSERT INTO dbp_etl.mis_q_kunden_join_tag_2 (
    mandant_id, wup_id, nb_id, dat, dat_vgl, kundengleich_fg,
    kundenavg_fg, kunden_fg
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        dat_vgl,
        SUM(kundengleich_fg),
        SUM(kundenavg_fg),
        SUM(kunden_fg)
    FROM (
        SELECT
            t3.mandant_id,
            t3.wup_id,
            t3.nb_id,
            T1.dat AS dat,
            T2.dat AS dat_vgl,
            CASE
                WHEN T1.dat = T2.dat
                    THEN 1
                ELSE 0
            END AS kunden_fg,
            CASE
                WHEN T1.dat = T2.dat
                    THEN 0
                ELSE 1
            END AS kundenavg_fg,
            0 AS kundengleich_fg
        FROM dbp_data.tag_2 AS T1_2
        INNER JOIN (
            SELECT *
            FROM dbp_etl_process.kundenanz_agg_wt_2
            WHERE
                dat BETWEEN DATE_SUB(
                    CURRENT_DATE("Europe/Berlin"), INTERVAL 365 DAY
                ) AND (CURRENT_DATE("Europe/Berlin"))
        ) AS t3
            ON T1.dat = t3.dat
        INNER JOIN dbp_data.tag_2 AS T2
            ON
                T2.dat BETWEEN DATE_SUB(T1.dat, INTERVAL 30 DAY) AND T1.dat
                AND T1_2
                .wtag_id = T2.wtag_id
        WHERE t3.calc_fg = 0
        UNION DISTINCT
        SELECT
            t4.mandant_id,
            t4.wup_id,
            t4.nb_id,
            t4.dat,
            T5.dat AS dat_vgl,
            0 AS kunden_fg,
            0 AS kundenavg_fg,
            1 AS kundengleich_fg
        FROM (
            SELECT *
            FROM dbp_etl_process.kundenanz_agg_wt_2
            WHERE
                dat BETWEEN DATE_SUB(
                    CURRENT_DATE("Europe/Berlin"), INTERVAL 365 DAY
                ) AND (CURRENT_DATE("Europe/Berlin"))
        ) AS t4
        INNER JOIN dbp_data.tag_2 AS T5
            ON
                T5.dat BETWEEN DATE_SUB(t4.dat, INTERVAL 3 DAY) AND (DATE_SUB(
                    t4.dat,
                    INTERVAL 1 DAY
                ))
        WHERE t4.calc_fg = 0
        GROUP BY
            t4.mandant_id,
            t4.wup_id,
            t4.nb_id,
            t4.dat,
            dat_vgl,
            kunden_fg,
            kundenavg_fg
    ) AS dt1
    WHERE
        EXISTS (
            SELECT *
            FROM dbp_data.wupcal_2 AS T6
            WHERE
                dat = dt1.dat_vgl
                AND wup_id = dt1.wup_id
                AND nb_id = dt1.nb_id
                AND mandant_id = dt1.mandant_id
                AND datenlieferung_bonanzahl = 1
                AND offen = 1
        )
        AND EXISTS (
            SELECT *
            FROM dbp_data.wupcal_2 AS T7
            WHERE
                dat = dt1.dat
                AND wup_id = dt1.wup_id
                AND nb_id = dt1.nb_id
                AND mandant_id = dt1.mandant_id
                AND datenlieferung_bonanzahl = 1
                AND offen = 1
        )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat,
        dat_vgl
);
