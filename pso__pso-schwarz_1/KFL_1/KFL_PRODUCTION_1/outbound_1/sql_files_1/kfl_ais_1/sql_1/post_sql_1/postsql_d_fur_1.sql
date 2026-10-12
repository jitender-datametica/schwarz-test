CREATE OR REPLACE TABLE dbp_etl.fur_woche_sum_1 (
    wup_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    kjwo INTEGER NOT NULL,
    menge NUMERIC(29, 6)
);


CREATE OR REPLACE TABLE dbp_etl.d_fur_woche_sum_1 (
    wup_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    kjwo INTEGER NOT NULL,
    menge NUMERIC(29, 6)
);


/*
#------------------------------------------------------------------------------
# 3) Daten für den gewünschten Zeitraum für die ausgewählte Artikeln summiert in
#     berichtswesen_sum ablegen. Keine OuG-Artikel_1!!!
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE dbp_etl.d_fur_exp_1 AS
SELECT B.art_id
FROM dbp_data.art_1 AS B
INNER JOIN
    dbp_etl.d_fur_1 AS C
    ON B.kl_art_id = C.artikelnummer AND B.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.art_wg_zu_per_1 AS D
    ON
        B.mandant_id = D.mandant_id AND B.art_id = D.art_id AND D.arthiertyp_id
        = 2 AND D.dat_bis = DATE '9999-12-31'
WHERE
    B.mandant_id = 1
    AND D.wg_id NOT IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_1
        WHERE wg_filter_id = 12
    )
GROUP BY B.art_id;


INSERT INTO dbp_etl.d_fur_woche_sum_1 (wup_id, art_id, mandant_id, kjwo, menge)
(
    SELECT
        A.wup_id,
        A.art_id,
        A.mandant_id,
        C.kjwo,
        SUM(A.menge) AS menge
    FROM dbp_data.artbew_1 AS A
    INNER JOIN dbp_etl.d_fur_exp_1 AS B ON A.art_id = B.art_id
    INNER JOIN dbp_data.tag_1 AS C ON A.dat = C.dat
    WHERE
        A.mandant_id = 1
        AND A.dat BETWEEN (
            SELECT MIN(wo_dat_von) AS dat_von
            FROM dbp_data.woche_1
            WHERE akt_wo_kalendarisch IN (-60, -6)) AND (
            SELECT MAX(wo_dat_bis) AS dat_bis
            FROM dbp_data.woche_1
            WHERE akt_wo_kalendarisch IN (-60, -6)
        )
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.art_id,
        C.kjwo
);


INSERT INTO dbp_etl.d_fur_woche_sum_1 (wup_id, art_id, mandant_id, kjwo, menge)
(
    SELECT
        A.wup_id,
        A.art_id,
        A.mandant_id,
        D.kjwo,
        CAST(SUM(A.menge_abschrift * CASE
            WHEN B.gewart_id = 'KG'
                THEN 1 / 1000
            ELSE 1
        END * -1) AS NUMERIC) AS menge
    FROM dbp_data.marktabschriften_1 AS A
    INNER JOIN
        dbp_data.art_1 AS B
        ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    INNER JOIN dbp_etl.d_fur_exp_1 AS C ON A.art_id = C.art_id
    INNER JOIN dbp_data.tag_1 AS D ON A.dat = D.dat
    WHERE
        A.mandant_id = 1
        AND A.abschriftart_id IN (5, 7)
        AND A.dat BETWEEN (
            SELECT MIN(wo_dat_von) AS dat_von
            FROM dbp_data.woche_1
            WHERE akt_wo_kalendarisch IN (-60, -6)) AND (
            SELECT MAX(wo_dat_bis) AS dat_bis
            FROM dbp_data.woche_1
            WHERE akt_wo_kalendarisch IN (-60, -6)
        )
    GROUP BY
        A.wup_id,
        A.art_id,
        A.mandant_id,
        D.kjwo
);


INSERT INTO dbp_etl.fur_woche_sum_1 (wup_id, art_id, mandant_id, kjwo, menge)
(
    SELECT
        wup_id,
        art_id,
        mandant_id,
        kjwo,
        SUM(menge) AS menge
    FROM dbp_etl.d_fur_woche_sum_1
    GROUP BY
        wup_id,
        art_id,
        mandant_id,
        kjwo
);


CREATE OR REPLACE TABLE dbp_etl.fur_tag_sum_1 (
    wup_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    menge NUMERIC(29, 6)
);


CREATE OR REPLACE TABLE dbp_etl.d_fur_tag_sum_1 (
    wup_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    menge NUMERIC(29, 6)
);


/*
#------------------------------------------------------------------------------
# 3) Daten für den gewünschten Zeitraum für die ausgewählte Artikeln summiert in
#     berichtswesen_sum ablegen. Keine OuG-Artikel_1!!!
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE dbp_etl.d_fur_exp_1 AS
SELECT B.art_id
FROM dbp_data.art_1 AS B
INNER JOIN
    dbp_etl.d_fur_1 AS C
    ON B.kl_art_id = C.artikelnummer AND B.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.art_wg_zu_per_1 AS D
    ON
        B.mandant_id = D.mandant_id AND B.art_id = D.art_id AND D.arthiertyp_id
        = 2 AND D.dat_bis = DATE '9999-12-31'
WHERE
    B.mandant_id = 1
    AND D.wg_id NOT IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_1
        WHERE wg_filter_id = 12
    )
GROUP BY B.art_id;


INSERT INTO dbp_etl.d_fur_tag_sum_1 (wup_id, art_id, mandant_id, dat, menge)
(
    SELECT
        A.wup_id,
        A.art_id,
        A.mandant_id,
        A.dat,
        SUM(A.menge) AS menge
    FROM dbp_data.artbew_1 AS A
    INNER JOIN dbp_etl.d_fur_exp_1 AS B ON A.art_id = B.art_id
    WHERE
        A.mandant_id = 1
        AND A.dat BETWEEN (
            SELECT wo_dat_von
            FROM dbp_data.woche_1
            WHERE akt_wo_kalendarisch = -5
        ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
        )
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.dat,
        A.art_id
);


INSERT INTO dbp_etl.d_fur_tag_sum_1 (wup_id, art_id, mandant_id, dat, menge)
(
    SELECT
        A.wup_id,
        A.art_id,
        A.mandant_id,
        A.dat,
        CAST(SUM(A.menge_abschrift * CASE
            WHEN B.gewart_id = 'KG'
                THEN 1 / 1000
            ELSE 1
        END * -1) AS NUMERIC) AS menge
    FROM dbp_data.marktabschriften_1 AS A
    INNER JOIN
        dbp_data.art_1 AS B
        ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    INNER JOIN dbp_etl.d_fur_exp_1 AS C ON A.art_id = C.art_id
    WHERE
        A.mandant_id = 1
        AND A.abschriftart_id IN (5, 7)
        AND A.dat BETWEEN (
            SELECT wo_dat_von
            FROM dbp_data.woche_1
            WHERE akt_wo_kalendarisch = -5
        ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
        )
    GROUP BY
        A.wup_id,
        A.art_id,
        A.mandant_id,
        A.dat
);


INSERT INTO dbp_etl.fur_tag_sum_1 (wup_id, art_id, mandant_id, dat, menge)
(
    SELECT
        wup_id,
        art_id,
        mandant_id,
        dat,
        SUM(menge) AS menge
    FROM dbp_etl.d_fur_tag_sum_1
    GROUP BY
        wup_id,
        art_id,
        mandant_id,
        dat
);
