CREATE OR REPLACE TABLE dbp_etl.zeitraum_fww_kmo_gld_2 AS
SELECT
    A.dat,
    A.kjmo,
    CASE
        WHEN
            MOD(EXTRACT(YEAR FROM A.dat), 4) = 0
            AND EXTRACT(MONTH FROM A.dat) >= 3
            THEN 366
        WHEN
            MOD(EXTRACT(YEAR FROM A.dat), 4) = 1
            AND EXTRACT(MONTH FROM A.dat) <= 2
            THEN 366
        ELSE 365
    END AS days_back,
    CASE
        WHEN
            EXTRACT(MONTH FROM A.dat) = 2
            AND MOD(EXTRACT(YEAR FROM A.dat), 4) = 0
            AND EXTRACT(DAY FROM A.dat) = 29
            THEN 1
        WHEN
            EXTRACT(MONTH FROM A.dat) = 2
            AND MOD(EXTRACT(YEAR FROM A.dat), 4) = 1
            AND EXTRACT(DAY FROM A.dat) = 28
            THEN -1
        ELSE 0
    END AS sj
FROM dbp_data.tag_2 AS A
INNER JOIN (
    SELECT
        MIN(kjmo) AS min_kjmo,
        MAX(kjmo) AS max_kjmo
    FROM (
        SELECT kjmo
        FROM dbp_data.tag_2
        WHERE
            akt_mo BETWEEN (
                SELECT akt_mo
                FROM dbp_etl_process.fww_gld_zeitraum_2
            ) AND 0
        GROUP BY kjmo
    ) AS x
) AS b ON A.kjmo BETWEEN b.min_kjmo AND b.max_kjmo
WHERE A.dat < CURRENT_DATE("Europe/Berlin");


MERGE INTO dbp_etl_process.ekc_zek_2 AS A
USING (
    SELECT
        A0.mandant_id,
        A0.art_id,
        A0.zek_id,
        CASE
            WHEN A0.zek_id <> A0.zek_vat_id
                THEN 1
            ELSE 0
        END AS eigenmarke_fg
    FROM dbp_data.art_2 AS A0
    INNER JOIN dbp_data.art_wg_zu_per_2 AS B
        ON
            A0.mandant_id = B.mandant_id
            AND A0.art_id = B.art_id
            AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    INNER JOIN dbp_data.wg_per_2 AS C
        ON
            A0.mandant_id = C.mandant_id
            AND B.wg_id = C.wg_id
            AND C.arthiertyp_id
            = 2 AND C.dat_bis = DATE '9999-12-31'
    WHERE
        A0.dat_bis = DATE '9999-12-31'
        AND A0.mandant_id = 1
        AND C.abt_id NOT IN (8)
    GROUP BY
        A0.mandant_id,
        A0.art_id,
        A0.zek_id,
        eigenmarke_fg
) AS b
    ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
WHEN MATCHED THEN
    UPDATE SET
        zek_id = b.zek_id,
        eigenmarke_fg = b.eigenmarke_fg
WHEN NOT MATCHED THEN INSERT
    (mandant_id, art_id, zek_id, eigenmarke_fg) VALUES (
    b.mandant_id, b.art_id,
    b.zek_id, b.eigenmarke_fg
);


MERGE INTO dbp_etl_process.ekc_zek_2 AS A
USING (
    SELECT
        A0.mandant_id,
        A0.art_id,
        A0.zek_id,
        CASE
            WHEN A0.eigenmarke_id <> ''
                THEN 1
            ELSE 0
        END AS eigenmarke_fg
    FROM dbp_data.art_2 AS A0
    INNER JOIN dbp_data.art_wg_zu_per_2 AS B
        ON
            A0.mandant_id = B.mandant_id
            AND A0.art_id = B.art_id
            AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    INNER JOIN dbp_data.wg_per_2 AS C
        ON
            A0.mandant_id = C.mandant_id
            AND B.wg_id = C.wg_id
            AND C.arthiertyp_id
            = 2 AND C.dat_bis = DATE '9999-12-31'
    WHERE
        A0.dat_bis = DATE '9999-12-31'
        AND A0.mandant_id = 1
        AND C.abt_id IN (8)
    GROUP BY
        A0.mandant_id,
        A0.art_id,
        A0.zek_id,
        eigenmarke_fg
) AS b
    ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
WHEN MATCHED THEN
    UPDATE SET
        zek_id = b.zek_id,
        eigenmarke_fg = b.eigenmarke_fg
WHEN NOT MATCHED THEN INSERT
    (mandant_id, art_id, zek_id, eigenmarke_fg) VALUES (
    b.mandant_id, b.art_id,
    b.zek_id, b.eigenmarke_fg
);


MERGE INTO dbp_etl_process.ekc_zek_2 AS A
USING (
    SELECT
        mandant_id,
        art_id,
        zek_id,
        CASE
            WHEN eigenmarke_id <> ''
                THEN 1
            ELSE 0
        END AS eigenmarke_fg
    FROM dbp_data.art_2 AS A
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
    GROUP BY
        mandant_id,
        art_id,
        zek_id,
        eigenmarke_fg
) AS b
    ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
WHEN MATCHED THEN
    UPDATE SET
        zek_id = b.zek_id,
        eigenmarke_fg = b.eigenmarke_fg
WHEN NOT MATCHED THEN INSERT
    (mandant_id, art_id, zek_id, eigenmarke_fg) VALUES (
    b.mandant_id, b.art_id,
    b.zek_id, b.eigenmarke_fg
);
