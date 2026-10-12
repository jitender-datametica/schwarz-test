--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.wup_wotag_zu_per
WHERE dat_bis = PARSE_DATE('%F', '9999-12-31');


--translated statement


-- cast(DATE/100*100+1 AS DATE) - 1 - it results in last day of previous month
-- 80991231 /* = 31.12.9999
INSERT INTO
dbp_data.wup_wotag_zu_per (
    mandant_id, wup_id, nb_id, wtag_id, umsatz_prz, dat_von, dat_bis
)
(
    SELECT
        dt1.mandant_id,
        dt1.wup_id,
        dt1.nb_id,
        dt1.wtag_id,
        CAST(CASE
            WHEN dt2.avg_umsatz_brutto = 0
                THEN 0
            ELSE dt1.avg_umsatz_brutto * 100.000 / dt2.avg_umsatz_brutto
        END AS NUMERIC),
        DATE_SUB(
            CURRENT_DATE("Europe/Berlin"),
            INTERVAL EXTRACT(DAY FROM CURRENT_DATE("Europe/Berlin")) DAY
        ),
        PARSE_DATE('%F', '9999-12-31')
    FROM (
        SELECT
            AWS.wup_id,
            AWS.nb_id,
            AWS.mandant_id,
            T.wtag_id,
            SUM(AWS.umsatz_brutto) / COUNT(AWS.dat) AS avg_umsatz_brutto
        FROM dbp_data.artbew_wg_sum AS AWS
        INNER JOIN dbp_data.tag AS T
            ON
                AWS.dat = T.dat
                AND T.dat
                > DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 365 DAY)
                AND AWS.bewart_id NOT IN (1005, 1010)
                AND AWS.nb_id NOT IN (2, 7)
        GROUP BY
            AWS.mandant_id,
            AWS.nb_id,
            AWS.wup_id,
            T.wtag_id
    ) AS dt1
    INNER JOIN (
        SELECT
            wup_id,
            nb_id,
            mandant_id,
            SUM(avg_umsatz_brutto) AS avg_umsatz_brutto
        FROM (
            SELECT
                AWS0.wup_id,
                AWS0.nb_id,
                AWS0.mandant_id,
                SUM(AWS0.umsatz_brutto) / COUNT(AWS0.dat) AS avg_umsatz_brutto
            FROM dbp_data.artbew_wg_sum AS AWS0
            INNER JOIN dbp_data.tag AS T0
                ON
                    AWS0.dat = T0.dat AND T0.dat > DATE_SUB(
                        CURRENT_DATE("Europe/Berlin"), INTERVAL 365
                        DAY
                    ) AND AWS0.bewart_id NOT IN (1005, 1010
                    ) AND AWS0.nb_id NOT IN (2, 7
                    )
            GROUP BY
                AWS0.mandant_id,
                AWS0.nb_id,
                AWS0.wup_id,
                T0.wtag_id
        ) AS dt3
        GROUP BY
            wup_id,
            nb_id,
            mandant_id
    ) AS dt2
        ON
            dt1.mandant_id = dt2.mandant_id
            AND dt1.wup_id = dt2.wup_id
            AND dt1.nb_id = dt2.nb_id
);


--translated statement


UPDATE dbp_data.wup_wotag_zu_per AS wup_wotag_zu_per0 SET
    dat_bis = dt1.dat_bis FROM (SELECT
    mandant_id,
    wup_id,
    nb_id,
    wtag_id,
    dat_von
    -- , CASE WHEN (MSUM(CAST(dat_von AS INTEGER), 2, mandant_id, wup_id, nb_id, wtag_id, dat_von desc)-CAST(dat_von AS INTEGER)) <> 0

    -- THEN CAST((MSUM(CAST(dat_von AS INTEGER), 2, mandant_id, wup_id, nb_id, wtag_id, dat_von desc)-CAST(dat_von AS INTEGER)) AS DATE) -1

    -- ELSE to_date('9999-12-31','YYYY-MM-DD')
    -- END AS dat_bis
    ,
    COALESCE(DATE_SUB(LAG(dat_von, 1) OVER (
        PARTITION BY
            mandant_id, wup_id, nb_id, wtag_id ORDER BY
            dat_von IS NULL DESC,
            dat_von DESC
    ), INTERVAL 1 DAY), PARSE_DATE('%F', '9999-12-31')) AS dat_bis
FROM dbp_data.wup_wotag_zu_per) AS dt1
WHERE
    wup_wotag_zu_per0.mandant_id = dt1.mandant_id
    AND wup_wotag_zu_per0.wup_id = dt1.wup_id
    AND wup_wotag_zu_per0.nb_id
    = dt1.nb_id AND wup_wotag_zu_per0.wtag_id = dt1.wtag_id AND wup_wotag_zu_per0.dat_von = dt1.dat_von;
