UPDATE dbp_data.wupcal_1 SET
    ssm_umsatz_faktor = b.ssm_umsatz_faktor,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT *
    FROM dbp_data.wupcal_zukunft_1
    WHERE dat = CURRENT_DATE("Europe/Berlin")
) AS b
WHERE
    wupcal.mandant_id = b.mandant_id AND wupcal.wup_id = b.wup_id AND wupcal.nb_id = b.nb_id AND wupcal.dat = b.dat;


DELETE FROM dbp_data.wupcal_zukunft_1
WHERE dat = CURRENT_DATE("Europe/Berlin");


INSERT INTO dbp_data.wupcal_zukunft_1 (
    mandant_id, wup_id, nb_id, dat, offen, offen_von, offen_bis,
    offen_theke_von, offen_theke_bis
)
(
    SELECT
        x.mandant_id,
        x.wup_id,
        x.nb_id,
        B.dat,
        x.offen,
        x.offen_von_,
        x.offen_bis_,
        x.offen_theke_von,
        x.offen_theke_bis
    FROM (
        SELECT
            mandant_id,
            wup_id,
            nb_id,
            1 AS offen,
            MIN(CASE
                WHEN offen_von = 240000
                    THEN 0
                ELSE offen_von
            END) AS offen_von_,
            MAX(CASE
                WHEN offen_bis = 240000
                    THEN 0
                ELSE offen_bis
            END) AS offen_bis_,
            MIN(PARSE_TIME('%H%M%S', CAST(CASE
                WHEN offen_von = 240000
                    THEN 0
                ELSE offen_von
            END AS STRING FORMAT '000000'))) AS offen_theke_von,
            MAX(PARSE_TIME('%H%M%S', CAST(CASE
                WHEN offen_bis = 240000
                    THEN 0
                ELSE offen_bis
            END AS STRING FORMAT '000000'))) AS offen_theke_bis
        FROM dbp_data.wupcal_1 AS A
        GROUP BY
            mandant_id,
            wup_id,
            nb_id,
            offen
    ) AS x
    INNER JOIN dbp_data.tag_1 AS B ON TRUE
    WHERE
        B.dat BETWEEN DATE_ADD(
            CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY
        ) AND (DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 90 DAY))
        AND (
            x.mandant_id, x.wup_id, x.nb_id, B.dat) NOT IN (
            SELECT (mandant_id, wup_id, nb_id, dat)
            FROM dbp_data.wupcal_zukunft_1
        )
    GROUP BY
        x.mandant_id,
        x.wup_id,
        x.nb_id,
        x.offen,
        x.offen_von_,
        x.offen_bis_,
        x.offen_theke_von,
        x.offen_theke_bis,
        B.dat
);


UPDATE dbp_data.wupcal_zukunft_1 SET
    offen_von = b.offen_von_,
    offen_bis = b.offen_bis_,
    offen_theke_von = b.offen_theke_von,
    offen_theke_bis = b.offen_theke_bis,
    td_update = CURRENT_TIMESTAMP() FROM (SELECT
    t1.dat,
    t1.wtag_id,
    t1.mandant_id,
    t1.wup_id,
    t1.offen_von_,
    t1.offen_bis_,
    PARSE_TIME('%H%M%S', CAST(t1.offen_von_ AS STRING FORMAT '000000'))
        AS offen_theke_von,
    PARSE_TIME('%H%M%S', CAST(t1.offen_bis_ AS STRING FORMAT '000000'))
        AS offen_theke_bis
FROM (
    SELECT
        A.dat,
        A.wtag_id,
        B.mandant_id,
        B.wup_id,
        CASE
            WHEN B.zeit_von = 240000
                THEN 0
            ELSE B.zeit_von
        END AS offen_von_,
        CASE
            WHEN B.zeit_bis = 240000
                THEN 0
            ELSE B.zeit_bis
        END AS offen_bis_
    FROM dbp_data.tag_1 AS A
    INNER JOIN
        dbp_data.vaus_wup_oeffnung_zu_per_1 AS B
        ON A.wtag_id = B.wup_oeffnungs_typ_id
    WHERE
        A.dat BETWEEN DATE_ADD(
            CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY
        ) AND (DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 90 DAY))
    GROUP BY
        A.dat,
        A.wtag_id,
        B.mandant_id,
        B.wup_id,
        offen_von_,
        offen_bis_
) AS t1_1) AS b
WHERE
    wupcal_zukunft.mandant_id = b.mandant_id AND wupcal_zukunft.dat = b.dat AND wupcal_zukunft.wup_id = b.wup_id;


UPDATE dbp_data.wupcal_zukunft_1 SET
    offen = t0.offen,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        MAX(offen) AS offen
    FROM dbp_data.wupcal_ereignis_zu_1 AS WEZ
    GROUP BY
        dat,
        wup_id,
        nb_id,
        mandant_id
) AS t0
WHERE
    t0.mandant_id = wupcal_zukunft.mandant_id
    AND t0.wup_id = wupcal_zukunft.wup_id
    AND t0.nb_id = wupcal_zukunft.nb_id
    AND t0.dat = wupcal_zukunft.dat;


CREATE TEMPORARY TABLE IF NOT EXISTS _avg_ist AS
SELECT
    T1.mandant_id,
    T1.wup_id,
    T1.wtag_id,
    AVG(T1.ums_netto) AS umsatz_netto
FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_1 AS T1_1
INNER JOIN
    dbp_data.mandant_1 AS T2
    ON T1.mandant_id = T2.mandant_id AND T1.wrg_id = T2.default_wrg
WHERE T1.akt_wo BETWEEN -10 AND (-1)
GROUP BY
    T1.mandant_id,
    T1.wup_id,
    T1.wtag_id;


CREATE TEMPORARY TABLE IF NOT EXISTS _plan AS
SELECT
    T1.mandant_id,
    T1.wup_id,
    T1.dat,
    T2.wtag_id,
    T1.wrg_id,
    COALESCE(T1.ums_netto_plan_man_meldeschluss_plus2, T1.ums_netto_plan_man)
        AS umsatz_plan_hl
FROM dbp_data.wup_stunden_tag_1 AS T1_1
INNER JOIN dbp_data.tag_1 AS T2 ON T1.dat = T2.dat
WHERE T2.akt_wo BETWEEN 0 AND 16;


CREATE TEMPORARY TABLE IF NOT EXISTS _umsatz_hebel AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.wrg_id,
    COALESCE(
        CAST(A.umsatz_plan_hl AS BIGNUMERIC)
        / IF(
            CAST(B.umsatz_netto AS BIGNUMERIC) = 0,
            NULL,
            CAST(B.umsatz_netto AS BIGNUMERIC)
        ), 1.0000
    ) AS umsatz_hebel
FROM `_plan` AS A
INNER JOIN
    `_avg_ist` AS B
    ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.wtag_id = B.wtag_id;


UPDATE dbp_data.wupcal_zukunft_1 SET
    ssm_umsatz_faktor = b.umsatz_hebel,
    td_update = CURRENT_TIMESTAMP()
FROM `_umsatz_hebel` AS b
WHERE
    wupcal_zukunft.mandant_id = b.mandant_id
    AND wupcal_zukunft.wup_id = b.wup_id
    AND wupcal_zukunft.dat = b.dat
    AND wupcal_zukunft.dat > DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 55 DAY);


UPDATE dbp_data.wupcal_1 SET
    ssm_umsatz_faktor = b.ssm_umsatz_faktor,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT *
    FROM dbp_data.wupcal_zukunft_1
    WHERE dat = CURRENT_DATE("Europe/Berlin")
) AS b
WHERE
    wupcal.mandant_id = b.mandant_id AND wupcal.wup_id = b.wup_id AND wupcal.nb_id = b.nb_id AND wupcal.dat = b.dat;


UPDATE dbp_data.wupcal_1 SET
    offen_von = b.offen_von,
    offen_bis = b.offen_bis FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.dat,
        MAX(C.zeit_von) AS offen_von,
        MAX(C.zeit_bis) AS offen_bis
    FROM dbp_data.wupcal_1 AS A
    INNER JOIN dbp_data.tag_1 AS B ON A.dat = B.dat
    INNER JOIN dbp_data.vaus_wup_oeffnung_zu_per_1 AS C
        ON
            A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
            AND A.dat BETWEEN C.dat_von AND C.dat_bis
            AND B.wtag_id = C.wup_oeffnungs_typ_id
    WHERE
        A.nb_id = 0
        AND A.offen_von IS NULL
        AND A.dat >= DATE '2024-01-01'
        AND A.offen = 1
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.dat
) AS b
WHERE
    wupcal.mandant_id = b.mandant_id
    AND wupcal.wup_id = b.wup_id
    AND wupcal.dat = b.dat
    AND wupcal.offen_von IS NULL
    AND wupcal.offen = 1 AND wupcal.nb_id = 0;


UPDATE dbp_data.wupcal_zukunft_1 SET
    offen_von = b.offen_von,
    offen_bis = b.offen_bis FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.dat,
        MAX(C.zeit_von) AS offen_von,
        MAX(C.zeit_bis) AS offen_bis
    FROM dbp_data.wupcal_zukunft_1 AS A
    INNER JOIN dbp_data.tag_1 AS B ON A.dat = B.dat
    INNER JOIN dbp_data.vaus_wup_oeffnung_zu_per_1 AS C
        ON
            A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
            AND A.dat BETWEEN C.dat_von AND C.dat_bis
            AND B.wtag_id = C.wup_oeffnungs_typ_id
    WHERE
        A.nb_id = 0
        AND A.offen_von IS NULL
        AND A.dat >= DATE '2024-01-01'
        AND A.offen = 1
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.dat
) AS b
WHERE
    wupcal_zukunft.mandant_id = b.mandant_id
    AND wupcal_zukunft.wup_id = b.wup_id
    AND wupcal_zukunft.dat = b.dat
    AND wupcal_zukunft.offen_von IS NULL AND wupcal_zukunft.offen = 1 AND wupcal_zukunft.nb_id = 0;
