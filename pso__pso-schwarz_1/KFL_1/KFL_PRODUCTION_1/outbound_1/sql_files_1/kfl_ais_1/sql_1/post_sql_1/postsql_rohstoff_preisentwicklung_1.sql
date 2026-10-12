-------------------------
--- 1. Zeitprioritaet ---
-------------------------

-- Weekly


CREATE OR REPLACE TEMPORARY TABLE _zwischen AS
SELECT
    A.rohstoff_nr,
    A.dat_rohstoff_preis,
    A.rohstoff_einh_name,
    A.wrg_id,
    A.frequenz_cd,
    A.kjwo,
    A.preis_rohstoff_max,
    A.preis_rohstoff_min,
    A.preis_rohstoff_avg,
    A.preis_gefuellt_fg,
    A.td_update,
    A.td_insert
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
INNER JOIN (SELECT
    rohstoff_nr,
    COUNT(DISTINCT frequenz_cd) AS anz
FROM dbp_data.rohstoff_preisentwicklung_1
GROUP BY rohstoff_nr
HAVING anz > 1) AS b ON A.rohstoff_nr = b.rohstoff_nr AND A.frequenz_cd = 'Weekly';


DELETE FROM dbp_data.rohstoff_preisentwicklung_1
WHERE rohstoff_nr IN (
    SELECT rohstoff_nr
    FROM `_zwischen`
);


INSERT INTO dbp_data.rohstoff_preisentwicklung_1
(
    SELECT *
    FROM `_zwischen`
);


-- Daily


CREATE OR REPLACE TEMPORARY TABLE _zwischen AS
SELECT
    A.rohstoff_nr,
    A.dat_rohstoff_preis,
    A.rohstoff_einh_name,
    A.wrg_id,
    A.frequenz_cd,
    A.kjwo,
    A.preis_rohstoff_max,
    A.preis_rohstoff_min,
    A.preis_rohstoff_avg,
    A.preis_gefuellt_fg,
    A.td_update,
    A.td_insert
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
INNER JOIN (SELECT
    rohstoff_nr,
    COUNT(DISTINCT frequenz_cd) AS anz
FROM dbp_data.rohstoff_preisentwicklung_1
GROUP BY rohstoff_nr
HAVING anz > 1) AS b ON A.rohstoff_nr = b.rohstoff_nr AND A.frequenz_cd = 'Daily';


DELETE FROM dbp_data.rohstoff_preisentwicklung_1
WHERE rohstoff_nr IN (
    SELECT rohstoff_nr
    FROM `_zwischen`
);


INSERT INTO dbp_data.rohstoff_preisentwicklung_1
(
    SELECT *
    FROM `_zwischen`
);


-- Monthly


CREATE OR REPLACE TEMPORARY TABLE _zwischen AS
SELECT
    A.rohstoff_nr,
    A.dat_rohstoff_preis,
    A.rohstoff_einh_name,
    A.wrg_id,
    A.frequenz_cd,
    A.kjwo,
    A.preis_rohstoff_max,
    A.preis_rohstoff_min,
    A.preis_rohstoff_avg,
    A.preis_gefuellt_fg,
    A.td_update,
    A.td_insert
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
INNER JOIN (SELECT
    rohstoff_nr,
    COUNT(DISTINCT frequenz_cd) AS anz
FROM dbp_data.rohstoff_preisentwicklung_1
GROUP BY rohstoff_nr
HAVING anz > 1) AS b ON A.rohstoff_nr = b.rohstoff_nr AND A.frequenz_cd = 'Monthly';


DELETE FROM dbp_data.rohstoff_preisentwicklung_1
WHERE rohstoff_nr IN (
    SELECT rohstoff_nr
    FROM `_zwischen`
);


INSERT INTO dbp_data.rohstoff_preisentwicklung_1
(
    SELECT *
    FROM `_zwischen`
);


-------------------------
--- 2. Interpolierung ---
-------------------------


CREATE OR REPLACE TEMPORARY TABLE _zeit_rohstoff_preisentwicklung AS
SELECT
    B.dat,
    B.kjmo,
    B.kjqu,
    B.kj,
    B.akt_tag,
    A.rohstoff_nr,
    A.dat_rohstoff_preis,
    A.rohstoff_einh_name,
    A.wrg_id,
    A.frequenz_cd,
    A.kjwo,
    A.preis_rohstoff_max,
    A.preis_rohstoff_min,
    A.preis_rohstoff_avg,
    A.preis_gefuellt_fg,
    A.td_update,
    A.td_insert
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
INNER JOIN dbp_data.tag_1 AS B ON A.dat_rohstoff_preis = B.dat;


---------------------------------
---           Daily           ---
---------------------------------


CREATE OR REPLACE TEMPORARY TABLE _tag_check AS
SELECT
    rohstoff_nr,
    dat,
    akt_tag
FROM `_zeit_rohstoff_preisentwicklung`
WHERE frequenz_cd = 'Daily'
GROUP BY
    rohstoff_nr,
    dat,
    akt_tag;


CREATE OR REPLACE TEMPORARY TABLE _z0 AS
SELECT
    rohstoff_nr,
    akt_tag,
    dat,
    (SUM(akt_tag) OVER (
        PARTITION BY rohstoff_nr ORDER BY akt_tag IS NULL, akt_tag ROWS BETWEEN CURRENT ROW AND 1
        FOLLOWING
    )) - akt_tag AS vorher,
    CASE
        WHEN (SUM(akt_tag) OVER (
            PARTITION BY rohstoff_nr ORDER BY akt_tag IS NULL, akt_tag ROWS BETWEEN CURRENT ROW AND 1
            FOLLOWING
        )) - akt_tag = 0
            THEN 1
        WHEN
            akt_tag - ((SUM(akt_tag) OVER (
                PARTITION BY rohstoff_nr ORDER BY akt_tag IS NULL, akt_tag ROWS BETWEEN
                CURRENT ROW AND 1 FOLLOWING
            )) - akt_tag) NOT IN (1)
            THEN 0
        ELSE 1
    END AS partition_
FROM `_tag_check`;


CREATE OR REPLACE TEMPORARY TABLE _z1 AS
SELECT
    A.rohstoff_nr,
    A.dat,
    B.dat AS vorher,
    ROW_NUMBER() OVER (PARTITION BY A.rohstoff_nr ORDER BY A.dat IS NULL, A.dat) AS group_id,
    A.partition_
FROM `_z0` AS A
INNER JOIN dbp_data.tag_1 AS B ON A.vorher = B.akt_tag
WHERE A.partition_ = 0;


CREATE OR REPLACE TEMPORARY TABLE _z2 AS
SELECT
    group_id,
    MAX(wtag_id) AS wtag_id,
    MAX(akt_tag_von) AS akt_tag_von,
    MAX(akt_tag_bis) AS akt_tag_bis,
    rohstoff_nr,
    frequenz_cd,
    MAX(dat_rohstoff_preis_von) AS dat_rohstoff_preis_von,
    MAX(dat_rohstoff_preis_bis) AS dat_rohstoff_preis_bis,
    wrg_id,
    rohstoff_einh_name,
    MAX(preis_rohstoff_max_von) AS preis_rohstoff_max_von,
    MAX(preis_rohstoff_max_bis) AS preis_rohstoff_max_bis,
    MAX(dat_von) AS dat_von,
    MAX(dat_bis) AS dat_bis
FROM (
    SELECT
        B.group_id,
        E.wtag_id,
        D.akt_tag AS akt_tag_von,
        CAST(NULL AS INTEGER) AS akt_tag_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        A.dat_rohstoff_preis AS dat_rohstoff_preis_von,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        A.preis_rohstoff_max AS preis_rohstoff_max_von,
        CAST(NULL AS BIGNUMERIC) AS preis_rohstoff_max_bis,
        B.vorher AS dat_von,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_bis
    FROM `_zeit_rohstoff_preisentwicklung` AS A
    INNER JOIN `_z1` AS B ON A.dat = B.vorher AND A.rohstoff_nr = B.rohstoff_nr
    INNER JOIN dbp_data.tag_1 AS D ON A.dat = D.dat
    INNER JOIN dbp_data.tag_1 AS E ON A.dat_rohstoff_preis = E.dat
    WHERE B.partition_ = 0
    GROUP BY
        B.group_id,
        E.wtag_id,
        akt_tag_von,
        akt_tag_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis_von,
        dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max_von,
        preis_rohstoff_max_bis,
        dat_von,
        dat_bis
    UNION ALL
    SELECT
        B.group_id,
        E.wtag_id,
        CAST(NULL AS INTEGER) AS akt_wo_von,
        D.akt_tag AS akt_wo_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_rohstoff_preis_von,
        A.dat_rohstoff_preis AS dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        CAST(NULL AS BIGNUMERIC) AS preis_rohstoff_max_von,
        A.preis_rohstoff_max AS preis_rohstoff_max_bis,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_von,
        B.dat AS dat_bis
    FROM `_zeit_rohstoff_preisentwicklung` AS A
    INNER JOIN `_z1` AS B ON A.dat = B.dat AND A.rohstoff_nr = B.rohstoff_nr
    INNER JOIN dbp_data.tag_1 AS D ON A.dat = D.dat
    INNER JOIN dbp_data.tag_1 AS E ON A.dat_rohstoff_preis = E.dat
    WHERE B.partition_ = 0
    GROUP BY
        B.group_id,
        E.wtag_id,
        akt_wo_von,
        akt_wo_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis_von,
        dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max_von,
        preis_rohstoff_max_bis,
        dat_von,
        dat_bis
) AS x
GROUP BY
    group_id,
    rohstoff_nr,
    frequenz_cd,
    wrg_id,
    rohstoff_einh_name;


CREATE OR REPLACE TABLE dbp_etl.rohstoff_preisentwicklung_interpolated_1 LIKE dbp_data.rohstoff_preisentwicklung_1;


INSERT INTO dbp_etl.rohstoff_preisentwicklung_interpolated_1 (
    rohstoff_nr, dat_rohstoff_preis,
    rohstoff_einh_name, wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg,
    preis_gefuellt_fg, td_update, td_insert
)
(
    SELECT
        rohstoff_nr,
        dat_rohstoff_preis,
        rohstoff_einh_name,
        wrg_id,
        frequenz_cd,
        kjwo,
        preis_rohstoff_max,
        preis_rohstoff_min,
        preis_rohstoff_avg,
        preis_gefuellt_fg,
        td_update,
        td_update AS td_insert
    FROM (
        SELECT
            A.rohstoff_nr,
            A.frequenz_cd,
            B.dat AS dat_rohstoff_preis,
            B.kjwo,
            A.wrg_id,
            A.rohstoff_einh_name,
            A.preis_rohstoff_max_von + (SUM(1) OVER (
                PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.dat IS NULL, B.dat
                RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
                SUM(1
                )
                    OVER (
                        PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                        UNBOUNDED PRECEDING AND CURRENT ROW
                    )
            ) + 1)) AS preis_rohstoff_max,
            A.preis_rohstoff_max_von + (SUM(1) OVER (
                PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.dat IS NULL, B.dat
                RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
                SUM(1
                )
                    OVER (
                        PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                        UNBOUNDED PRECEDING AND CURRENT ROW
                    )
            ) + 1)) AS preis_rohstoff_min,
            A.preis_rohstoff_max_von + (SUM(1) OVER (
                PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.dat IS NULL, B.dat
                RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
                SUM(1
                )
                    OVER (
                        PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                        UNBOUNDED PRECEDING AND CURRENT ROW
                    )
            ) + 1)) AS preis_rohstoff_avg,
            1 AS preis_gefuellt_fg,
            CURRENT_TIMESTAMP() AS td_update,
            CURRENT_TIMESTAMP() AS td_insert
        FROM `_z2` AS A
        INNER JOIN dbp_data.tag_1 AS B ON B.akt_tag BETWEEN A.akt_tag_von + 1 AND (A.akt_tag_bis - 1)
    ) AS x
    GROUP BY
        rohstoff_nr,
        frequenz_cd,
        dat_rohstoff_preis,
        kjwo,
        wrg_id,
        rohstoff_einh_name,
        preis_rohstoff_max,
        preis_rohstoff_min,
        preis_rohstoff_avg,
        preis_gefuellt_fg,
        td_update,
        td_insert
);


---------------------------------
---          Weekly           ---
---------------------------------


CREATE OR REPLACE TEMPORARY TABLE _wo_check AS
SELECT
    rohstoff_nr,
    kjwo
FROM `_zeit_rohstoff_preisentwicklung`
WHERE frequenz_cd = 'Weekly'
GROUP BY
    rohstoff_nr,
    kjwo;


CREATE OR REPLACE TEMPORARY TABLE _z0 AS
SELECT
    rohstoff_nr,
    kjwo,
    (SUM(kjwo) OVER (PARTITION BY rohstoff_nr ORDER BY kjwo IS NULL, kjwo ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)) -
    kjwo AS vorher,
    CASE
        WHEN
            (SUM(kjwo) OVER (PARTITION BY rohstoff_nr ORDER BY kjwo IS NULL, kjwo ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING))
            - kjwo = 0
            THEN 1
        WHEN
            kjwo - ((SUM(kjwo) OVER (
                PARTITION BY rohstoff_nr ORDER BY kjwo IS NULL, kjwo ROWS BETWEEN CURRENT ROW AND 1
                FOLLOWING
            )) - kjwo) NOT IN (1, 48, 49)
            THEN 0
        ELSE 1
    END AS partition_
FROM `_wo_check`;


CREATE OR REPLACE TEMPORARY TABLE _z1 AS
SELECT
    rohstoff_nr,
    kjwo,
    vorher,
    partition_,
    ROW_NUMBER() OVER (PARTITION BY rohstoff_nr ORDER BY kjwo IS NULL, kjwo) AS group_id
FROM `_z0` AS A
WHERE partition_ = 0;


CREATE OR REPLACE TEMPORARY TABLE _z2 AS
SELECT
    group_id,
    MAX(wtag_id) AS wtag_id,
    MAX(akt_wo_von) AS akt_wo_von,
    MAX(akt_wo_bis) AS akt_wo_bis,
    rohstoff_nr,
    frequenz_cd,
    MAX(dat_rohstoff_preis_von) AS dat_rohstoff_preis_von,
    MAX(dat_rohstoff_preis_bis) AS dat_rohstoff_preis_bis,
    wrg_id,
    rohstoff_einh_name,
    MAX(preis_rohstoff_max_von) AS preis_rohstoff_max_von,
    MAX(preis_rohstoff_max_bis) AS preis_rohstoff_max_bis,
    MAX(kjwo_von) AS kjwo_von,
    MAX(kjwo_bis) AS kjwo_bis
FROM (
    SELECT
        B.group_id,
        E.wtag_id,
        D.akt_wo AS akt_wo_von,
        CAST(NULL AS INTEGER) AS akt_wo_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        A.dat_rohstoff_preis AS dat_rohstoff_preis_von,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        A.preis_rohstoff_max AS preis_rohstoff_max_von,
        CAST(NULL AS BIGNUMERIC) AS preis_rohstoff_max_bis,
        B.vorher AS kjwo_von,
        CAST(NULL AS INTEGER) AS kjwo_bis
    FROM `_zeit_rohstoff_preisentwicklung` AS A
    INNER JOIN `_z1` AS B ON A.kjwo = B.vorher AND A.rohstoff_nr = B.rohstoff_nr
    INNER JOIN dbp_data.woche_1 AS D ON A.kjwo = D.kjwo
    INNER JOIN dbp_data.tag_1 AS E ON A.dat_rohstoff_preis = E.dat
    WHERE B.partition_ = 0
    GROUP BY
        B.group_id,
        E.wtag_id,
        akt_wo_von,
        akt_wo_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis_von,
        dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max_von,
        preis_rohstoff_max_bis,
        kjwo_von,
        kjwo_bis
    UNION ALL
    SELECT
        B.group_id,
        E.wtag_id,
        CAST(NULL AS INTEGER) AS akt_wo_von,
        D.akt_wo AS akt_wo_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_rohstoff_preis_von,
        A.dat_rohstoff_preis AS dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        CAST(NULL AS BIGNUMERIC) AS preis_rohstoff_max_von,
        A.preis_rohstoff_max AS preis_rohstoff_max_bis,
        CAST(NULL AS INTEGER) AS kjwo_von,
        B.kjwo AS kjwo_bis
    FROM `_zeit_rohstoff_preisentwicklung` AS A
    INNER JOIN `_z1` AS B ON A.kjwo = B.kjwo AND A.rohstoff_nr = B.rohstoff_nr
    INNER JOIN dbp_data.woche_1 AS D ON A.kjwo = D.kjwo
    INNER JOIN dbp_data.tag_1 AS E ON A.dat_rohstoff_preis = E.dat
    WHERE B.partition_ = 0
    GROUP BY
        B.group_id,
        E.wtag_id,
        akt_wo_von,
        akt_wo_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis_von,
        dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max_von,
        preis_rohstoff_max_bis,
        kjwo_von,
        kjwo_bis
) AS x
GROUP BY
    group_id,
    rohstoff_nr,
    frequenz_cd,
    wrg_id,
    rohstoff_einh_name;


INSERT INTO dbp_etl.rohstoff_preisentwicklung_interpolated_1 (
    rohstoff_nr, dat_rohstoff_preis,
    rohstoff_einh_name, wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg,
    preis_gefuellt_fg, td_update, td_insert
)
(
    SELECT
        rohstoff_nr,
        dat_rohstoff_preis,
        rohstoff_einh_name,
        wrg_id,
        frequenz_cd,
        kjwo,
        preis_rohstoff_max,
        preis_rohstoff_min,
        preis_rohstoff_avg,
        preis_gefuellt_fg,
        td_update,
        td_update AS td_insert
    FROM (
        SELECT
            A.rohstoff_nr,
            A.frequenz_cd,
            B.dat AS dat_rohstoff_preis,
            B.kjwo,
            A.wrg_id,
            A.rohstoff_einh_name,
            A.preis_rohstoff_max_von + (SUM(1) OVER (
                PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.kjwo IS NULL, B.kjwo
                RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
                SUM(1
                )
                    OVER (
                        PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                        UNBOUNDED PRECEDING AND CURRENT ROW
                    )
            ) + 1)) AS preis_rohstoff_max,
            A.preis_rohstoff_max_von + (SUM(1) OVER (
                PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.kjwo IS NULL, B.kjwo
                RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
                SUM(1
                )
                    OVER (
                        PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                        UNBOUNDED PRECEDING AND CURRENT ROW
                    )
            ) + 1)) AS preis_rohstoff_min,
            A.preis_rohstoff_max_von + (SUM(1) OVER (
                PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.kjwo IS NULL, B.kjwo
                RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
                SUM(1
                )
                    OVER (
                        PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                        UNBOUNDED PRECEDING AND CURRENT ROW
                    )
            ) + 1)) AS preis_rohstoff_avg,
            1 AS preis_gefuellt_fg,
            CURRENT_TIMESTAMP() AS td_update,
            CURRENT_TIMESTAMP() AS td_insert
        FROM `_z2` AS A
        INNER JOIN
            dbp_data.tag_1
                AS B
            ON
                B.akt_wo BETWEEN A.akt_wo_von + 1 AND (A.akt_wo_bis - 1) AND A.wtag_id
                = B.wtag_id
    ) AS x
    GROUP BY
        rohstoff_nr,
        frequenz_cd,
        dat_rohstoff_preis,
        kjwo,
        wrg_id,
        rohstoff_einh_name,
        preis_rohstoff_max,
        preis_rohstoff_min,
        preis_rohstoff_avg,
        preis_gefuellt_fg,
        td_update,
        td_insert
);


---------------------------------
---         Monthly           ---
---------------------------------


CREATE OR REPLACE TEMPORARY TABLE _mo_check AS
SELECT
    rohstoff_nr,
    kjmo
FROM `_zeit_rohstoff_preisentwicklung`
WHERE frequenz_cd = 'Monthly'
GROUP BY
    rohstoff_nr,
    kjmo;


CREATE OR REPLACE TEMPORARY TABLE _z0 AS
SELECT
    rohstoff_nr,
    kjmo,
    (SUM(kjmo) OVER (PARTITION BY rohstoff_nr ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)) -
    kjmo AS vorher,
    CASE
        WHEN
            (SUM(kjmo) OVER (PARTITION BY rohstoff_nr ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING))
            - kjmo = 0
            THEN 1
        WHEN
            kjmo - ((SUM(kjmo) OVER (
                PARTITION BY rohstoff_nr ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN CURRENT ROW AND 1
                FOLLOWING
            )) - kjmo) NOT IN (1, 89)
            THEN 0
        ELSE 1
    END AS partition_
FROM `_mo_check`;


CREATE OR REPLACE TEMPORARY TABLE _z1 AS
SELECT
    rohstoff_nr,
    kjmo,
    vorher,
    partition_,
    ROW_NUMBER() OVER (PARTITION BY rohstoff_nr ORDER BY kjmo IS NULL, kjmo) AS group_id
FROM `_z0` AS A
WHERE partition_ = 0;


CREATE OR REPLACE TEMPORARY TABLE _z2 AS
SELECT
    group_id,
    MAX(wtag_id) AS wtag_id,
    MAX(akt_mo_von) AS akt_mo_von,
    MAX(akt_mo_bis) AS akt_mo_bis,
    rohstoff_nr,
    frequenz_cd,
    MAX(dat_rohstoff_preis_von) AS dat_rohstoff_preis_von,
    MAX(dat_rohstoff_preis_bis) AS dat_rohstoff_preis_bis,
    wrg_id,
    rohstoff_einh_name,
    MAX(preis_rohstoff_max_von) AS preis_rohstoff_max_von,
    MAX(preis_rohstoff_max_bis) AS preis_rohstoff_max_bis,
    MAX(kjmo_von) AS kjmo_von,
    MAX(kjmo_bis) AS kjmo_bis
FROM (
    SELECT
        B.group_id,
        E.wtag_id,
        D.akt_mo AS akt_mo_von,
        CAST(NULL AS INTEGER) AS akt_mo_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        A.dat_rohstoff_preis AS dat_rohstoff_preis_von,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        A.preis_rohstoff_max AS preis_rohstoff_max_von,
        CAST(NULL AS BIGNUMERIC) AS preis_rohstoff_max_bis,
        B.vorher AS kjmo_von,
        CAST(NULL AS INTEGER) AS kjmo_bis
    FROM `_zeit_rohstoff_preisentwicklung` AS A
    INNER JOIN `_z1` AS B ON A.kjmo = B.vorher AND A.rohstoff_nr = B.rohstoff_nr
    INNER JOIN dbp_data.monat_1 AS D ON A.kjmo = D.kjmo
    INNER JOIN dbp_data.tag_1 AS E ON A.dat_rohstoff_preis = E.dat
    WHERE B.partition_ = 0
    GROUP BY
        B.group_id,
        E.wtag_id,
        akt_mo_von,
        akt_mo_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis_von,
        dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max_von,
        preis_rohstoff_max_bis,
        kjmo_von,
        kjmo_bis
    UNION ALL
    SELECT
        B.group_id,
        E.wtag_id,
        CAST(NULL AS INTEGER) AS akt_mo_von,
        D.akt_mo AS akt_mo_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_rohstoff_preis_von,
        A.dat_rohstoff_preis AS dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        CAST(NULL AS BIGNUMERIC) AS preis_rohstoff_max_von,
        A.preis_rohstoff_max AS preis_rohstoff_max_bis,
        CAST(NULL AS INTEGER) AS kjmo_von,
        B.kjmo AS kjmo_bis
    FROM `_zeit_rohstoff_preisentwicklung` AS A
    INNER JOIN `_z1` AS B ON A.kjmo = B.kjmo AND A.rohstoff_nr = B.rohstoff_nr
    INNER JOIN dbp_data.monat_1 AS D ON A.kjmo = D.kjmo
    INNER JOIN dbp_data.tag_1 AS E ON A.dat_rohstoff_preis = E.dat
    WHERE B.partition_ = 0
    GROUP BY
        B.group_id,
        E.wtag_id,
        akt_mo_von,
        akt_mo_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis_von,
        dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max_von,
        preis_rohstoff_max_bis,
        kjmo_von,
        kjmo_bis
) AS x
GROUP BY
    group_id,
    rohstoff_nr,
    frequenz_cd,
    wrg_id,
    rohstoff_einh_name;


INSERT INTO dbp_etl.rohstoff_preisentwicklung_interpolated_1 (
    rohstoff_nr, dat_rohstoff_preis,
    rohstoff_einh_name, wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg,
    preis_gefuellt_fg, td_update, td_insert
)
(
    SELECT
        A.rohstoff_nr,
        B.min_dat AS dat_rohstoff_preis,
        A.rohstoff_einh_name,
        A.wrg_id,
        A.frequenz_cd,
        C.kjwo,
        A.preis_rohstoff_max_von + (SUM(1) OVER (
            PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.kjmo IS NULL, B.kjmo
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
            SUM(1
            )
                OVER (
                    PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                    UNBOUNDED PRECEDING AND CURRENT ROW
                )
        ) + 1)) AS preis_rohstoff_max,
        A.preis_rohstoff_max_von + (SUM(1) OVER (
            PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.kjmo IS NULL, B.kjmo
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
            SUM(1
            )
                OVER (
                    PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                    UNBOUNDED PRECEDING AND CURRENT ROW
                )
        ) + 1)) AS preis_rohstoff_min,
        A.preis_rohstoff_max_von + (SUM(1) OVER (
            PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.kjmo IS NULL, B.kjmo
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
            SUM(1
            )
                OVER (
                    PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                    UNBOUNDED PRECEDING AND CURRENT ROW
                )
        ) + 1)) AS preis_rohstoff_avg,
        1 AS preis_gefuellt_fg,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM `_z2` AS A
    INNER JOIN dbp_data.monat_1 AS B ON B.akt_mo BETWEEN A.akt_mo_von + 1 AND (A.akt_mo_bis - 1)
    INNER JOIN dbp_data.tag_1 AS C ON B.min_dat = C.dat
);


---------------------------------
---        Quarterly          ---
---------------------------------


CREATE OR REPLACE TEMPORARY TABLE _qu_check AS
SELECT
    rohstoff_nr,
    kjqu
FROM `_zeit_rohstoff_preisentwicklung`
WHERE frequenz_cd = 'Quarterly'
GROUP BY
    rohstoff_nr,
    kjqu;


CREATE OR REPLACE TEMPORARY TABLE _z0 AS
SELECT
    rohstoff_nr,
    kjqu,
    (SUM(kjqu) OVER (PARTITION BY rohstoff_nr ORDER BY kjqu IS NULL, kjqu ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)) -
    kjqu AS vorher,
    CASE
        WHEN
            (SUM(kjqu) OVER (PARTITION BY rohstoff_nr ORDER BY kjqu IS NULL, kjqu ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING))
            - kjqu = 0
            THEN 1
        WHEN
            kjqu - ((SUM(kjqu) OVER (
                PARTITION BY rohstoff_nr ORDER BY kjqu IS NULL, kjqu ROWS BETWEEN CURRENT ROW AND 1
                FOLLOWING
            )) - kjqu) NOT IN (1, 97)
            THEN 0
        ELSE 1
    END AS partition_
FROM `_qu_check`;


CREATE OR REPLACE TEMPORARY TABLE _z1 AS
SELECT
    rohstoff_nr,
    kjqu,
    vorher,
    partition_,
    ROW_NUMBER() OVER (PARTITION BY rohstoff_nr ORDER BY kjqu IS NULL, kjqu) AS group_id
FROM `_z0` AS A
WHERE partition_ = 0;


CREATE OR REPLACE TEMPORARY TABLE _z2 AS
SELECT
    group_id,
    MAX(wtag_id) AS wtag_id,
    MAX(akt_kjqu_von) AS akt_kjqu_von,
    MAX(akt_kjqu_bis) AS akt_kjqu_bis,
    rohstoff_nr,
    frequenz_cd,
    MAX(dat_rohstoff_preis_von) AS dat_rohstoff_preis_von,
    MAX(dat_rohstoff_preis_bis) AS dat_rohstoff_preis_bis,
    wrg_id,
    rohstoff_einh_name,
    MAX(preis_rohstoff_max_von) AS preis_rohstoff_max_von,
    MAX(preis_rohstoff_max_bis) AS preis_rohstoff_max_bis,
    MAX(kjqu_von) AS kjqu_von,
    MAX(kjqu_bis) AS kjqu_bis
FROM (
    SELECT
        B.group_id,
        E.wtag_id,
        D.akt_kjqu AS akt_kjqu_von,
        CAST(NULL AS INTEGER) AS akt_kjqu_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        A.dat_rohstoff_preis AS dat_rohstoff_preis_von,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        A.preis_rohstoff_max AS preis_rohstoff_max_von,
        CAST(NULL AS BIGNUMERIC) AS preis_rohstoff_max_bis,
        B.vorher AS kjqu_von,
        CAST(NULL AS INTEGER) AS kjqu_bis
    FROM `_zeit_rohstoff_preisentwicklung` AS A
    INNER JOIN `_z1` AS B ON A.kjqu = B.vorher AND A.rohstoff_nr = B.rohstoff_nr
    INNER JOIN dbp_data.quartal_kj_1 AS D ON A.kjqu = D.kjqu
    INNER JOIN dbp_data.tag_1 AS E ON A.dat_rohstoff_preis = E.dat
    WHERE B.partition_ = 0
    GROUP BY
        B.group_id,
        E.wtag_id,
        akt_kjqu_von,
        akt_kjqu_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis_von,
        dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max_von,
        preis_rohstoff_max_bis,
        kjqu_von,
        kjqu_bis
    UNION ALL
    SELECT
        B.group_id,
        E.wtag_id,
        CAST(NULL AS INTEGER) AS akt_kjqu_von,
        D.akt_kjqu AS akt_kjqu_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_rohstoff_preis_von,
        A.dat_rohstoff_preis AS dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        CAST(NULL AS BIGNUMERIC) AS preis_rohstoff_max_von,
        A.preis_rohstoff_max AS preis_rohstoff_max_bis,
        CAST(NULL AS INTEGER) AS kjqu_von,
        B.kjqu AS kjqu_bis
    FROM `_zeit_rohstoff_preisentwicklung` AS A
    INNER JOIN `_z1` AS B ON A.kjqu = B.kjqu AND A.rohstoff_nr = B.rohstoff_nr
    INNER JOIN dbp_data.monat_1 AS D ON A.kjqu = D.kjqu
    INNER JOIN dbp_data.tag_1 AS E ON A.dat_rohstoff_preis = E.dat
    WHERE B.partition_ = 0
    GROUP BY
        B.group_id,
        E.wtag_id,
        akt_kjqu_von,
        akt_kjqu_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis_von,
        dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max_von,
        preis_rohstoff_max_bis,
        kjqu_von,
        kjqu_bis
) AS x
GROUP BY
    group_id,
    rohstoff_nr,
    frequenz_cd,
    wrg_id,
    rohstoff_einh_name;


INSERT INTO dbp_etl.rohstoff_preisentwicklung_interpolated_1 (
    rohstoff_nr, dat_rohstoff_preis,
    rohstoff_einh_name, wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg,
    preis_gefuellt_fg, td_update, td_insert
)
(
    SELECT
        A.rohstoff_nr,
        c.min_dat AS dat_rohstoff_preis,
        A.rohstoff_einh_name,
        A.wrg_id,
        A.frequenz_cd,
        D.kjwo,
        A.preis_rohstoff_max_von + (SUM(1) OVER (
            PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.kjqu IS NULL, B.kjqu
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
            SUM(1
            )
                OVER (
                    PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                    UNBOUNDED PRECEDING AND CURRENT ROW
                )
        ) + 1)) AS preis_rohstoff_max,
        A.preis_rohstoff_max_von + (SUM(1) OVER (
            PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.kjqu IS NULL, B.kjqu
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
            SUM(1
            )
                OVER (
                    PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                    UNBOUNDED PRECEDING AND CURRENT ROW
                )
        ) + 1)) AS preis_rohstoff_min,
        A.preis_rohstoff_max_von + (SUM(1) OVER (
            PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.kjqu IS NULL, B.kjqu
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
            SUM(1
            )
                OVER (
                    PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                    UNBOUNDED PRECEDING AND CURRENT ROW
                )
        ) + 1)) AS preis_rohstoff_avg,
        1 AS preis_gefuellt_fg,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM `_z2` AS A
    INNER JOIN dbp_data.quartal_kj_1 AS B ON B.akt_kjqu BETWEEN A.akt_kjqu_von + 1 AND (A.akt_kjqu_bis - 1)
    INNER JOIN (SELECT
        kjqu,
        MIN(min_dat) AS min_dat
    FROM dbp_data.monat_1
    GROUP BY kjqu) AS c ON B.kjqu = c.kjqu
    INNER JOIN dbp_data.tag_1 AS D ON c.min_dat = D.dat
);


---------------------------------
---          Yearly           ---
---------------------------------


CREATE OR REPLACE TEMPORARY TABLE _kj_check AS
SELECT
    rohstoff_nr,
    kj
FROM `_zeit_rohstoff_preisentwicklung`
WHERE frequenz_cd = 'Yearly'
GROUP BY
    rohstoff_nr,
    kj;


CREATE OR REPLACE TEMPORARY TABLE _z0 AS
SELECT
    rohstoff_nr,
    kj,
    (
        SUM(kj) OVER (PARTITION BY rohstoff_nr ORDER BY kj IS NULL, kj ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)) - kj AS
    vorher,
    CASE
        WHEN
            (SUM(kj) OVER (PARTITION BY rohstoff_nr ORDER BY kj IS NULL, kj ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)) - kj =
            0
            THEN 1
        WHEN
            kj - (
                (SUM(kj) OVER (PARTITION BY rohstoff_nr ORDER BY kj IS NULL, kj ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING))
                - kj
            ) NOT IN (1
            )
            THEN 0
        ELSE 1
    END AS partition_
FROM `_kj_check`;


CREATE OR REPLACE TEMPORARY TABLE _z1 AS
SELECT
    rohstoff_nr,
    kj,
    vorher,
    partition_,
    ROW_NUMBER() OVER (PARTITION BY rohstoff_nr ORDER BY kj IS NULL, kj) AS group_id
FROM `_z0` AS A
WHERE partition_ = 0;


CREATE OR REPLACE TEMPORARY TABLE _z2 AS
SELECT
    group_id,
    MAX(wtag_id) AS wtag_id,
    MAX(akt_kj_von) AS akt_kj_von,
    MAX(akt_kj_bis) AS akt_kj_bis,
    rohstoff_nr,
    frequenz_cd,
    MAX(dat_rohstoff_preis_von) AS dat_rohstoff_preis_von,
    MAX(dat_rohstoff_preis_bis) AS dat_rohstoff_preis_bis,
    wrg_id,
    rohstoff_einh_name,
    MAX(preis_rohstoff_max_von) AS preis_rohstoff_max_von,
    MAX(preis_rohstoff_max_bis) AS preis_rohstoff_max_bis,
    MAX(kj_von) AS kj_von,
    MAX(kj_bis) AS kj_bis
FROM (
    SELECT
        B.group_id,
        E.wtag_id,
        D.akt_kj AS akt_kj_von,
        CAST(NULL AS INTEGER) AS akt_kj_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        A.dat_rohstoff_preis AS dat_rohstoff_preis_von,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        A.preis_rohstoff_max AS preis_rohstoff_max_von,
        CAST(NULL AS BIGNUMERIC) AS preis_rohstoff_max_bis,
        B.vorher AS kj_von,
        CAST(NULL AS INTEGER) AS kj_bis
    FROM `_zeit_rohstoff_preisentwicklung` AS A
    INNER JOIN `_z1` AS B ON A.kj = B.vorher AND A.rohstoff_nr = B.rohstoff_nr
    INNER JOIN dbp_data.jahr_kj_1 AS D ON A.kj = D.kj
    INNER JOIN dbp_data.tag_1 AS E ON A.dat_rohstoff_preis = E.dat
    WHERE B.partition_ = 0
    GROUP BY
        B.group_id,
        E.wtag_id,
        akt_kj_von,
        akt_kj_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis_von,
        dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max_von,
        preis_rohstoff_max_bis,
        kj_von,
        kj_bis
    UNION ALL
    SELECT
        B.group_id,
        E.wtag_id,
        CAST(NULL AS INTEGER) AS akt_kj_von,
        D.akt_kj AS akt_kj_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_rohstoff_preis_von,
        A.dat_rohstoff_preis AS dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        CAST(NULL AS BIGNUMERIC) AS preis_rohstoff_max_von,
        A.preis_rohstoff_max AS preis_rohstoff_max_bis,
        CAST(NULL AS INTEGER) AS kj_von,
        B.kj AS kj_bis
    FROM `_zeit_rohstoff_preisentwicklung` AS A
    INNER JOIN `_z1` AS B ON A.kj = B.kj AND A.rohstoff_nr = B.rohstoff_nr
    INNER JOIN dbp_data.jahr_kj_1 AS D ON A.kj = D.kj
    INNER JOIN dbp_data.tag_1 AS E ON A.dat_rohstoff_preis = E.dat
    WHERE B.partition_ = 0
    GROUP BY
        B.group_id,
        E.wtag_id,
        akt_kj_von,
        akt_kj_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis_von,
        dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max_von,
        preis_rohstoff_max_bis,
        kj_von,
        kj_bis
) AS x
GROUP BY
    group_id,
    rohstoff_nr,
    frequenz_cd,
    wrg_id,
    rohstoff_einh_name;


INSERT INTO dbp_etl.rohstoff_preisentwicklung_interpolated_1 (
    rohstoff_nr, dat_rohstoff_preis,
    rohstoff_einh_name, wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg,
    preis_gefuellt_fg, td_update, td_insert
)
(
    SELECT
        A.rohstoff_nr,
        c.min_dat AS dat_rohstoff_preis,
        A.rohstoff_einh_name,
        A.wrg_id,
        A.frequenz_cd,
        D.kjwo,
        A.preis_rohstoff_max_von + (SUM(1) OVER (
            PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.kj IS NULL, B.kj
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
            SUM(1
            )
                OVER (
                    PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                    UNBOUNDED PRECEDING AND CURRENT ROW
                )
        ) + 1)) AS preis_rohstoff_max,
        A.preis_rohstoff_max_von + (SUM(1) OVER (
            PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.kj IS NULL, B.kj
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
            SUM(1
            )
                OVER (
                    PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                    UNBOUNDED PRECEDING AND CURRENT ROW
                )
        ) + 1)) AS preis_rohstoff_min,
        A.preis_rohstoff_max_von + (SUM(1) OVER (
            PARTITION BY A.group_id, A.rohstoff_nr ORDER BY B.kj IS NULL, B.kj
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) * ((A.preis_rohstoff_max_bis - A.preis_rohstoff_max_von) / ((
            SUM(1
            )
                OVER (
                    PARTITION BY A.group_id, A.rohstoff_nr ORDER BY A.group_id IS NULL, A.group_id RANGE BETWEEN
                    UNBOUNDED PRECEDING AND CURRENT ROW
                )
        ) + 1)) AS preis_rohstoff_avg,
        1 AS preis_gefuellt_fg,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM `_z2` AS A
    INNER JOIN dbp_data.jahr_kj_1 AS B ON B.akt_kj BETWEEN A.akt_kj_von + 1 AND (A.akt_kj_bis - 1)
    INNER JOIN (SELECT
        kj,
        MIN(min_dat) AS min_dat
    FROM dbp_data.monat_1
    GROUP BY kj) AS c ON B.kj = c.kj
    INNER JOIN dbp_data.tag_1 AS D ON c.min_dat = D.dat
);


INSERT INTO dbp_data.rohstoff_preisentwicklung_1 (
    rohstoff_nr, dat_rohstoff_preis, rohstoff_einh_name,
    wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg, preis_gefuellt_fg, td_update,
    td_insert
)
(
    SELECT *
    FROM dbp_etl.rohstoff_preisentwicklung_interpolated_1
);


---------------------------------
--- 3. Faecher                ---
---------------------------------

---------------------------------
---          Daily            ---
---------------------------------


CREATE OR REPLACE TEMPORARY TABLE _faecher AS
SELECT
    A.rohstoff_nr,
    MAX(A.dat_rohstoff_preis) AS max_dat_rohstoff_preis_,
    MAX(b.max_dat_frequenz) AS max_dat_frequenz_
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
INNER JOIN (
    SELECT MAX(dat_rohstoff_preis) AS max_dat_frequenz
    FROM dbp_data.rohstoff_preisentwicklung_1
    WHERE frequenz_cd = 'Daily'
) AS b
    ON TRUE
WHERE A.frequenz_cd = 'Daily'
GROUP BY A.rohstoff_nr
HAVING max_dat_rohstoff_preis_ < max_dat_frequenz_;


INSERT INTO dbp_data.rohstoff_preisentwicklung_1 (
    rohstoff_nr, dat_rohstoff_preis, rohstoff_einh_name,
    wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg, preis_gefuellt_fg, td_update,
    td_insert
)
(
    SELECT
        A.rohstoff_nr,
        C.dat AS dat_rohstoff_preis,
        A.rohstoff_einh_name,
        A.wrg_id,
        A.frequenz_cd,
        C.kjwo,
        A.preis_rohstoff_max,
        A.preis_rohstoff_min,
        A.preis_rohstoff_avg,
        1 AS preis_gefuellt_fg,
        A.td_update,
        A.td_insert
    FROM dbp_data.rohstoff_preisentwicklung_1 AS A
    INNER JOIN `_faecher` AS B ON A.rohstoff_nr = B.rohstoff_nr AND A.dat_rohstoff_preis = B.max_dat_rohstoff_preis_
    INNER JOIN
        dbp_data.tag_1
            AS C
        ON
            C.dat BETWEEN DATE_ADD(B.max_dat_rohstoff_preis_, INTERVAL 1 DAY) AND B.max_dat_frequenz_
);


---------------------------------
---          Weekly           ---
---------------------------------


CREATE OR REPLACE TEMPORARY TABLE _faecher AS
SELECT
    A.rohstoff_nr,
    MAX(A.dat_rohstoff_preis) AS max_dat_rohstoff_preis_,
    MAX(b.max_dat_frequenz) AS max_dat_frequenz_
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
INNER JOIN (
    SELECT MAX(dat_rohstoff_preis) AS max_dat_frequenz
    FROM dbp_data.rohstoff_preisentwicklung_1
    WHERE frequenz_cd = 'Weekly'
) AS b
    ON TRUE
WHERE A.frequenz_cd = 'Weekly'
GROUP BY A.rohstoff_nr
HAVING max_dat_rohstoff_preis_ < max_dat_frequenz_;


INSERT INTO dbp_data.rohstoff_preisentwicklung_1 (
    rohstoff_nr, dat_rohstoff_preis, rohstoff_einh_name,
    wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg, preis_gefuellt_fg, td_update,
    td_insert
)
(
    SELECT
        A.rohstoff_nr,
        C.dat AS dat_rohstoff_preis,
        A.rohstoff_einh_name,
        A.wrg_id,
        A.frequenz_cd,
        C.kjwo,
        A.preis_rohstoff_max,
        A.preis_rohstoff_min,
        A.preis_rohstoff_avg,
        1 AS preis_gefuellt_fg,
        A.td_update,
        A.td_insert
    FROM dbp_data.rohstoff_preisentwicklung_1 AS A
    INNER JOIN `_faecher` AS B ON A.rohstoff_nr = B.rohstoff_nr AND A.dat_rohstoff_preis = B.max_dat_rohstoff_preis_
    INNER JOIN
        dbp_data.tag_1
            AS C
        ON
            C.dat BETWEEN DATE_ADD(B.max_dat_rohstoff_preis_, INTERVAL 1 DAY) AND B.max_dat_frequenz_ AND C.wtag_id = 3
);


---------------------------------
---         Monthly           ---
---------------------------------


CREATE OR REPLACE TEMPORARY TABLE _faecher AS
SELECT
    x.rohstoff_nr,
    x.max_dat_rohstoff_preis_,
    Y.kjmo AS kjmo_max,
    x.max_dat_frequenz_,
    Z.kjmo AS kjmo_max_bis
FROM (
    SELECT
        A.rohstoff_nr,
        MAX(A.dat_rohstoff_preis) AS max_dat_rohstoff_preis_,
        MAX(b.max_dat_frequenz) AS max_dat_frequenz_
    FROM dbp_data.rohstoff_preisentwicklung_1 AS A
    INNER JOIN (
        SELECT MAX(dat_rohstoff_preis) AS max_dat_frequenz
        FROM dbp_data.rohstoff_preisentwicklung_1
        WHERE frequenz_cd = 'Monthly'
    ) AS b
        ON TRUE
    WHERE A.frequenz_cd = 'Monthly'
    GROUP BY A.rohstoff_nr
    HAVING max_dat_rohstoff_preis_ < max_dat_frequenz_
) AS x
INNER JOIN dbp_data.monat_1 AS Y ON x.max_dat_rohstoff_preis_ = Y.min_dat
INNER JOIN dbp_data.monat_1 AS Z ON x.max_dat_frequenz_ = Z.min_dat;


INSERT INTO dbp_data.rohstoff_preisentwicklung_1 (
    rohstoff_nr, dat_rohstoff_preis, rohstoff_einh_name,
    wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg, preis_gefuellt_fg, td_update,
    td_insert
)
(
    SELECT
        A.rohstoff_nr,
        C.min_dat AS dat_rohstoff_preis,
        A.rohstoff_einh_name,
        A.wrg_id,
        A.frequenz_cd,
        D.kjwo,
        A.preis_rohstoff_max,
        A.preis_rohstoff_min,
        A.preis_rohstoff_avg,
        1 AS preis_gefuellt_fg,
        A.td_update,
        A.td_insert
    FROM dbp_data.rohstoff_preisentwicklung_1 AS A
    INNER JOIN `_faecher` AS B ON A.rohstoff_nr = B.rohstoff_nr AND A.dat_rohstoff_preis = B.max_dat_rohstoff_preis_
    INNER JOIN dbp_data.monat_1 AS C
        ON
            C.min_dat BETWEEN DATE_ADD(B.max_dat_rohstoff_preis_, INTERVAL 1 DAY
            ) AND B.max_dat_frequenz_
    INNER JOIN dbp_data.tag_1 AS D ON C.min_dat = D.dat
    GROUP BY
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis,
        D.kjwo,
        A.wrg_id,
        A.rohstoff_einh_name,
        A.preis_rohstoff_max,
        A.preis_rohstoff_min,
        A.preis_rohstoff_avg,
        preis_gefuellt_fg,
        A.td_update,
        A.td_insert
);


---------------------------------
---       Quarterly           ---
---------------------------------


CREATE OR REPLACE TEMPORARY TABLE _faecher AS
SELECT
    x.rohstoff_nr,
    x.max_dat_rohstoff_preis_,
    y.kjqu AS kjqu_max,
    x.max_dat_frequenz_,
    z.kjqu AS kjqu_max_bis
FROM (
    SELECT
        A.rohstoff_nr,
        MAX(A.dat_rohstoff_preis) AS max_dat_rohstoff_preis_,
        MAX(b.max_dat_frequenz) AS max_dat_frequenz_
    FROM dbp_data.rohstoff_preisentwicklung_1 AS A
    INNER JOIN (
        SELECT MAX(dat_rohstoff_preis) AS max_dat_frequenz
        FROM dbp_data.rohstoff_preisentwicklung_1
        WHERE frequenz_cd = 'Quarterly'
    ) AS b
        ON TRUE
    WHERE A.frequenz_cd = 'Quarterly'
    GROUP BY A.rohstoff_nr
    HAVING max_dat_rohstoff_preis_ < max_dat_frequenz_
) AS x
INNER JOIN (SELECT
    kjqu,
    MIN(min_dat) AS min_dat
FROM dbp_data.monat_1
GROUP BY kjqu) AS y ON x.max_dat_rohstoff_preis_ = y.min_dat
INNER JOIN (SELECT
    kjqu,
    MIN(min_dat) AS min_dat
FROM dbp_data.monat_1
GROUP BY kjqu) AS z ON x.max_dat_frequenz_ = z.min_dat;


INSERT INTO dbp_data.rohstoff_preisentwicklung_1 (
    rohstoff_nr, dat_rohstoff_preis, rohstoff_einh_name,
    wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg, preis_gefuellt_fg, td_update,
    td_insert
)
(
    SELECT
        A.rohstoff_nr,
        c.min_dat AS dat_rohstoff_preis,
        A.rohstoff_einh_name,
        A.wrg_id,
        A.frequenz_cd,
        D.kjwo,
        A.preis_rohstoff_max,
        A.preis_rohstoff_min,
        A.preis_rohstoff_avg,
        1 AS preis_gefuellt_fg,
        A.td_update,
        A.td_insert
    FROM dbp_data.rohstoff_preisentwicklung_1 AS A
    INNER JOIN `_faecher` AS B ON A.rohstoff_nr = B.rohstoff_nr AND A.dat_rohstoff_preis = B.max_dat_rohstoff_preis_
    INNER JOIN (SELECT
        kjqu,
        MIN(min_dat) AS min_dat
    FROM dbp_data.monat_1
    GROUP BY kjqu) AS c ON c.min_dat BETWEEN DATE_ADD(B.max_dat_rohstoff_preis_, INTERVAL 1 DAY) AND B.max_dat_frequenz_
    INNER JOIN dbp_data.tag_1 AS D ON c.min_dat = D.dat
    GROUP BY
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis,
        D.kjwo,
        A.wrg_id,
        A.rohstoff_einh_name,
        A.preis_rohstoff_max,
        A.preis_rohstoff_min,
        A.preis_rohstoff_avg,
        preis_gefuellt_fg,
        A.td_update,
        A.td_insert
);


---------------------------------
---          Yearly           ---
---------------------------------


CREATE OR REPLACE TEMPORARY TABLE _faecher AS
SELECT
    x.rohstoff_nr,
    x.max_dat_rohstoff_preis_,
    y.kj AS kjqu_max,
    x.max_dat_frequenz_,
    z.kj AS kj_max_bis
FROM (
    SELECT
        A.rohstoff_nr,
        MAX(A.dat_rohstoff_preis) AS max_dat_rohstoff_preis_,
        MAX(b.max_dat_frequenz) AS max_dat_frequenz_
    FROM dbp_data.rohstoff_preisentwicklung_1 AS A
    INNER JOIN (
        SELECT MAX(dat_rohstoff_preis) AS max_dat_frequenz
        FROM dbp_data.rohstoff_preisentwicklung_1
        WHERE frequenz_cd = 'Yearly'
    ) AS b
        ON TRUE
    WHERE A.frequenz_cd = 'Yearly'
    GROUP BY A.rohstoff_nr
    HAVING max_dat_rohstoff_preis_ < max_dat_frequenz_
) AS x
INNER JOIN (SELECT
    kj,
    MIN(min_dat) AS min_dat
FROM dbp_data.monat_1
GROUP BY kj) AS y ON x.max_dat_rohstoff_preis_ = y.min_dat
INNER JOIN (SELECT
    kj,
    MIN(min_dat) AS min_dat
FROM dbp_data.monat_1
GROUP BY kj) AS z ON x.max_dat_frequenz_ = z.min_dat;


INSERT INTO dbp_data.rohstoff_preisentwicklung_1 (
    rohstoff_nr, dat_rohstoff_preis, rohstoff_einh_name,
    wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg, preis_gefuellt_fg, td_update,
    td_insert
)
(
    SELECT
        A.rohstoff_nr,
        c.min_dat AS dat_rohstoff_preis,
        A.rohstoff_einh_name,
        A.wrg_id,
        A.frequenz_cd,
        D.kjwo,
        A.preis_rohstoff_max,
        A.preis_rohstoff_min,
        A.preis_rohstoff_avg,
        1 AS preis_gefuellt_fg,
        A.td_update,
        A.td_insert
    FROM dbp_data.rohstoff_preisentwicklung_1 AS A
    INNER JOIN `_faecher` AS B ON A.rohstoff_nr = B.rohstoff_nr AND A.dat_rohstoff_preis = B.max_dat_rohstoff_preis_
    INNER JOIN (SELECT
        kj,
        MIN(min_dat) AS min_dat
    FROM dbp_data.monat_1
    GROUP BY kj) AS c ON c.min_dat BETWEEN DATE_ADD(B.max_dat_rohstoff_preis_, INTERVAL 1 DAY) AND B.max_dat_frequenz_
    INNER JOIN dbp_data.tag_1 AS D ON c.min_dat = D.dat
    GROUP BY
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis,
        D.kjwo,
        A.wrg_id,
        A.rohstoff_einh_name,
        A.preis_rohstoff_max,
        A.preis_rohstoff_min,
        A.preis_rohstoff_avg,
        preis_gefuellt_fg,
        A.td_update,
        A.td_insert
);


---------------------------------
--- 4. Unit_1 Conversion        ---
---------------------------------


CREATE OR REPLACE TEMPORARY TABLE _murks_1 AS
SELECT
    A.rohstoff_nr,
    A.frequenz_cd,
    A.dat_rohstoff_preis,
    A.kjwo,
    A.wrg_id,
    B.rohstoff_einh_id_nach AS rohstoff_einh_name,
    A.preis_rohstoff_max / B.umrechnungsfaktor AS preis_rohstoff_max,
    A.preis_rohstoff_min / B.umrechnungsfaktor AS preis_rohstoff_min,
    A.preis_rohstoff_avg / B.umrechnungsfaktor AS preis_rohstoff_avg,
    A.preis_gefuellt_fg,
    A.td_update,
    A.td_insert
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
INNER JOIN dbp_etl_process.rohstoff_umrechnung_1
    AS B ON LOWER(A.rohstoff_einh_name) = LOWER(B.rohstoff_einh_id_von
);


INSERT INTO dbp_data.rohstoff_preisentwicklung_1 (
    rohstoff_nr, dat_rohstoff_preis, rohstoff_einh_name,
    wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg, preis_gefuellt_fg, td_update,
    td_insert
)
(SELECT
    rohstoff_nr,
    dat_rohstoff_preis,
    rohstoff_einh_name,
    wrg_id,
    frequenz_cd,
    kjwo,
    preis_rohstoff_max,
    preis_rohstoff_min,
    preis_rohstoff_avg,
    preis_gefuellt_fg,
    td_update,
    td_insert
FROM `_murks_1`);


---------------------------------
--- 5. Tagesfaecher           ---
---------------------------------


CREATE OR REPLACE TEMPORARY TABLE _day_daily AS
SELECT
    rohstoff_nr,
    MAX(dat_rohstoff_preis) AS dat_rohstoff_preis
FROM dbp_data.rohstoff_preisentwicklung_1
WHERE
    frequenz_cd = 'Daily'
    AND preis_gefuellt_fg = 0
GROUP BY rohstoff_nr;


CREATE OR REPLACE TEMPORARY TABLE _day_weekly AS
SELECT
    A.rohstoff_nr,
    MAX(A.dat_rohstoff_preis) AS dat_rohstoff_preis,
    MAX(b.max_dat) AS max_dat_null
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
LEFT JOIN (SELECT
    kjwo_ww,
    MIN(dat) AS min_dat,
    MAX(dat) AS max_dat
FROM dbp_data.werbewoche_kl_1
WHERE mandant_id = 2
GROUP BY kjwo_ww) AS b ON A.dat_rohstoff_preis = b.min_dat
WHERE
    A.frequenz_cd = 'Weekly'
    AND A.preis_gefuellt_fg = 0
GROUP BY A.rohstoff_nr;


UPDATE `_day_weekly` SET
    max_dat_null = b.max_dat FROM (SELECT
    kjwo,
    MIN(dat) AS min_dat,
    MAX(dat) AS max_dat
FROM dbp_data.tag_1
GROUP BY kjwo) AS b
WHERE `_day_weekly`.max_dat_null IS NULL AND `_day_weekly`.dat_rohstoff_preis = b.min_dat;


UPDATE `_day_weekly` SET
    max_dat_null = DATE_ADD(`_day_weekly`.dat_rohstoff_preis, INTERVAL 6 DAY)
WHERE max_dat_null IS NULL;


CREATE OR REPLACE TEMPORARY TABLE _day_monthly AS
SELECT
    A.rohstoff_nr,
    MAX(A.dat_rohstoff_preis) AS dat_rohstoff_preis,
    MAX(b.max_dat) AS max_dat_null
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
INNER JOIN (SELECT
    kjmo,
    MIN(dat) AS min_dat,
    MAX(dat) AS max_dat
FROM dbp_data.tag_1
GROUP BY kjmo) AS b ON A.dat_rohstoff_preis = b.min_dat
WHERE
    A.frequenz_cd = 'Monthly'
    AND A.preis_gefuellt_fg = 0
GROUP BY A.rohstoff_nr;


CREATE OR REPLACE TEMPORARY TABLE _day_quarterly AS
SELECT
    A.rohstoff_nr,
    MAX(A.dat_rohstoff_preis) AS dat_rohstoff_preis,
    MAX(b.max_dat) AS max_dat_null
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
INNER JOIN (SELECT
    kjqu,
    MIN(dat) AS min_dat,
    MAX(dat) AS max_dat
FROM dbp_data.tag_1
GROUP BY kjqu) AS b ON A.dat_rohstoff_preis = b.min_dat
WHERE
    A.frequenz_cd = 'Quarterly'
    AND A.preis_gefuellt_fg = 0
GROUP BY A.rohstoff_nr;


CREATE OR REPLACE TEMPORARY TABLE _day_yearly AS
SELECT
    A.rohstoff_nr,
    MAX(A.dat_rohstoff_preis) AS dat_rohstoff_preis,
    MAX(b.max_dat) AS max_dat_null
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
INNER JOIN (SELECT
    kj,
    MIN(dat) AS min_dat,
    MAX(dat) AS max_dat
FROM dbp_data.tag_1
GROUP BY kj) AS b ON A.dat_rohstoff_preis = b.min_dat
WHERE
    A.frequenz_cd = 'Yearly'
    AND A.preis_gefuellt_fg = 0
GROUP BY A.rohstoff_nr;


CREATE OR REPLACE TEMPORARY TABLE _zeit_rohstoff_preisentwicklung AS
SELECT
    B.dat,
    B.kjmo,
    B.kjqu,
    B.kj,
    B.akt_tag,
    A.rohstoff_nr,
    A.dat_rohstoff_preis,
    A.rohstoff_einh_name,
    A.wrg_id,
    A.frequenz_cd,
    A.kjwo,
    A.preis_rohstoff_max,
    A.preis_rohstoff_min,
    A.preis_rohstoff_avg,
    A.preis_gefuellt_fg,
    A.td_update,
    A.td_insert
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
INNER JOIN dbp_data.tag_1 AS B ON A.dat_rohstoff_preis = B.dat;


CREATE OR REPLACE TEMPORARY TABLE _tag_check AS
SELECT
    rohstoff_nr,
    dat,
    akt_tag
FROM `_zeit_rohstoff_preisentwicklung`
WHERE frequenz_cd <> 'Daily'
GROUP BY
    rohstoff_nr,
    dat,
    akt_tag;


CREATE OR REPLACE TEMPORARY TABLE _z0 AS
SELECT
    rohstoff_nr,
    akt_tag,
    dat,
    (SUM(akt_tag) OVER (
        PARTITION BY rohstoff_nr ORDER BY akt_tag IS NULL, akt_tag ROWS BETWEEN CURRENT ROW AND 1
        FOLLOWING
    )) - akt_tag AS vorher,
    CASE
        WHEN (SUM(akt_tag) OVER (
            PARTITION BY rohstoff_nr ORDER BY akt_tag IS NULL, akt_tag ROWS BETWEEN CURRENT ROW AND 1
            FOLLOWING
        )) - akt_tag = 0
            THEN 1
        WHEN
            akt_tag - ((SUM(akt_tag) OVER (
                PARTITION BY rohstoff_nr ORDER BY akt_tag IS NULL, akt_tag ROWS BETWEEN
                CURRENT ROW AND 1 FOLLOWING
            )) - akt_tag) NOT IN (1)
            THEN 0
        ELSE 1
    END AS partition_
FROM `_tag_check`;


CREATE OR REPLACE TEMPORARY TABLE _z1 AS
SELECT
    A.rohstoff_nr,
    A.dat,
    B.dat AS vorher,
    ROW_NUMBER() OVER (PARTITION BY A.rohstoff_nr ORDER BY A.dat IS NULL, A.dat) AS group_id,
    A.partition_
FROM `_z0` AS A
INNER JOIN dbp_data.tag_1 AS B ON A.vorher = B.akt_tag
WHERE A.partition_ = 0;


CREATE OR REPLACE TEMPORARY TABLE _z2 AS
SELECT
    group_id,
    MAX(wtag_id) AS wtag_id,
    MAX(akt_tag_von) AS akt_tag_von,
    MAX(akt_tag_bis) AS akt_tag_bis,
    rohstoff_nr,
    frequenz_cd,
    MAX(dat_rohstoff_preis_von) AS dat_rohstoff_preis_von,
    MAX(dat_rohstoff_preis_bis) AS dat_rohstoff_preis_bis,
    wrg_id,
    rohstoff_einh_name,
    preis_gefuellt_fg,
    MAX(preis_rohstoff_max_von) AS preis_rohstoff_max_von,
    MAX(preis_rohstoff_max_bis) AS preis_rohstoff_max_bis,
    MAX(dat_von) AS dat_von,
    MAX(dat_bis) AS dat_bis
FROM (
    SELECT
        B.group_id,
        E.wtag_id,
        D.akt_tag AS akt_tag_von,
        CAST(NULL AS INTEGER) AS akt_tag_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        A.dat_rohstoff_preis AS dat_rohstoff_preis_von,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        A.preis_rohstoff_max AS preis_rohstoff_max_von,
        CAST(NULL AS BIGNUMERIC) AS preis_rohstoff_max_bis,
        B.vorher AS dat_von,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_bis,
        A.preis_gefuellt_fg
    FROM `_zeit_rohstoff_preisentwicklung` AS A
    INNER JOIN `_z1` AS B ON A.dat = B.vorher AND A.rohstoff_nr = B.rohstoff_nr
    INNER JOIN dbp_data.tag_1 AS D ON A.dat = D.dat
    INNER JOIN dbp_data.tag_1 AS E ON A.dat_rohstoff_preis = E.dat
    WHERE B.partition_ = 0
    GROUP BY
        B.group_id,
        E.wtag_id,
        akt_tag_von,
        akt_tag_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis_von,
        dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max_von,
        preis_rohstoff_max_bis,
        dat_von,
        dat_bis,
        A.preis_gefuellt_fg
    UNION ALL
    SELECT
        B.group_id,
        E.wtag_id,
        CAST(NULL AS INTEGER) AS akt_wo_von,
        D.akt_tag AS akt_wo_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_rohstoff_preis_von,
        A.dat_rohstoff_preis AS dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        CAST(NULL AS BIGNUMERIC) AS preis_rohstoff_max_von,
        A.preis_rohstoff_max AS preis_rohstoff_max_bis,
        CAST(CAST(NULL AS STRING) AS DATE) AS dat_von,
        B.dat AS dat_bis,
        A.preis_gefuellt_fg
    FROM `_zeit_rohstoff_preisentwicklung` AS A
    INNER JOIN `_z1` AS B ON A.dat = B.dat AND A.rohstoff_nr = B.rohstoff_nr
    INNER JOIN dbp_data.tag_1 AS D ON A.dat = D.dat
    INNER JOIN dbp_data.tag_1 AS E ON A.dat_rohstoff_preis = E.dat
    WHERE B.partition_ = 0
    GROUP BY
        B.group_id,
        E.wtag_id,
        akt_wo_von,
        akt_wo_bis,
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis_von,
        dat_rohstoff_preis_bis,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max_von,
        preis_rohstoff_max_bis,
        dat_von,
        dat_bis,
        A.preis_gefuellt_fg
) AS x
GROUP BY
    group_id,
    rohstoff_nr,
    frequenz_cd,
    wrg_id,
    rohstoff_einh_name,
    preis_gefuellt_fg;


CREATE OR REPLACE TABLE dbp_etl.rohstoff_preisentwicklung_interpolated_1 LIKE dbp_data.rohstoff_preisentwicklung_1;


INSERT INTO dbp_etl.rohstoff_preisentwicklung_interpolated_1 (
    rohstoff_nr, dat_rohstoff_preis,
    rohstoff_einh_name, wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg,
    preis_gefuellt_fg, td_update, td_insert
)
(
    SELECT
        A.rohstoff_nr,
        B.dat AS dat_rohstoff_preis,
        A.rohstoff_einh_name,
        A.wrg_id,
        A.frequenz_cd,
        B.kjwo,
        A.preis_rohstoff_max_von AS preis_rohstoff_max,
        A.preis_rohstoff_max_von AS preis_rohstoff_min,
        A.preis_rohstoff_max_von AS preis_rohstoff_avg,
        A.preis_gefuellt_fg,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM `_z2` AS A
    INNER JOIN dbp_data.tag_1 AS B ON B.akt_tag BETWEEN A.akt_tag_von + 1 AND (A.akt_tag_bis - 1)
    GROUP BY
        A.rohstoff_nr,
        A.frequenz_cd,
        dat_rohstoff_preis,
        B.kjwo,
        A.wrg_id,
        A.rohstoff_einh_name,
        preis_rohstoff_max,
        preis_rohstoff_min,
        preis_rohstoff_avg,
        A.preis_gefuellt_fg,
        td_update,
        td_insert
);


DELETE FROM dbp_etl.rohstoff_preisentwicklung_interpolated_1
WHERE (rohstoff_nr, rohstoff_einh_name, dat_rohstoff_preis, frequenz_cd, wrg_id) IN (SELECT (
    rohstoff_nr,
    rohstoff_einh_name, dat_rohstoff_preis, frequenz_cd, wrg_id
)
FROM dbp_data.rohstoff_preisentwicklung_1);


INSERT INTO dbp_data.rohstoff_preisentwicklung_1 (
    rohstoff_nr, dat_rohstoff_preis, rohstoff_einh_name,
    wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg, preis_gefuellt_fg, td_update,
    td_insert
)
(
    SELECT *
    FROM dbp_etl.rohstoff_preisentwicklung_interpolated_1
);


CREATE OR REPLACE TEMPORARY TABLE _zeit_rohstoff_preisentwicklung AS
SELECT
    A.rohstoff_nr,
    A.dat_rohstoff_preis,
    A.rohstoff_einh_name,
    A.wrg_id,
    A.frequenz_cd,
    A.kjwo,
    A.preis_rohstoff_max,
    A.preis_rohstoff_min,
    A.preis_rohstoff_avg,
    A.preis_gefuellt_fg,
    A.td_update,
    A.td_insert
FROM dbp_data.rohstoff_preisentwicklung_1 AS A
INNER JOIN dbp_data.tag_1 AS B ON A.dat_rohstoff_preis = B.dat
WHERE A.frequenz_cd <> 'Daily';


CREATE OR REPLACE TEMPORARY TABLE _tag_check AS
SELECT
    rohstoff_nr,
    dat_rohstoff_preis
FROM `_zeit_rohstoff_preisentwicklung`
WHERE frequenz_cd <> 'Daily'
GROUP BY
    rohstoff_nr,
    dat_rohstoff_preis;


CREATE OR REPLACE TEMPORARY TABLE _zeit_rohstoff_preisentwicklung AS
SELECT
    A.rohstoff_nr,
    A.dat_rohstoff_preis,
    A.rohstoff_einh_name,
    A.wrg_id,
    A.frequenz_cd,
    A.kjwo,
    A.preis_rohstoff_max,
    A.preis_rohstoff_min,
    A.preis_rohstoff_avg,
    A.preis_gefuellt_fg,
    A.td_update,
    A.td_insert
FROM `_zeit_rohstoff_preisentwicklung` AS A
INNER JOIN (SELECT
    rohstoff_nr,
    MIN(max_dat) AS min_max_dat
FROM (SELECT
    rohstoff_nr,
    MAX(dat_rohstoff_preis) AS max_dat
FROM `_tag_check`
GROUP BY rohstoff_nr) AS t
GROUP BY rohstoff_nr) AS b ON A.rohstoff_nr = b.rohstoff_nr AND A.dat_rohstoff_preis = b.min_max_dat;


CREATE OR REPLACE TEMPORARY TABLE _days AS
SELECT
    dat,
    akt_tag,
    kjwo
FROM dbp_data.tag_1
WHERE dat BETWEEN (
    SELECT MIN(dat_rohstoff_preis) AS rohstoff_preis
    FROM dbp_data.rohstoff_preisentwicklung_1
) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
);


CREATE OR REPLACE TEMPORARY TABLE _snap1 AS
SELECT
    A.rohstoff_nr,
    B.dat AS dat_rohstoff_preis,
    A.rohstoff_einh_name,
    A.wrg_id,
    A.frequenz_cd,
    B.kjwo,
    A.preis_rohstoff_max,
    A.preis_rohstoff_min,
    A.preis_rohstoff_avg,
    A.preis_gefuellt_fg,
    A.td_update,
    A.td_insert
FROM `_zeit_rohstoff_preisentwicklung` AS A
INNER JOIN `_days` AS B ON TRUE
GROUP BY
    A.rohstoff_nr,
    dat_rohstoff_preis,
    A.rohstoff_einh_name,
    A.wrg_id,
    A.frequenz_cd,
    B.kjwo,
    A.preis_rohstoff_max,
    A.preis_rohstoff_min,
    A.preis_rohstoff_avg,
    A.preis_gefuellt_fg,
    A.td_update,
    A.td_insert;


INSERT INTO dbp_data.rohstoff_preisentwicklung_1 (
    rohstoff_nr, dat_rohstoff_preis, rohstoff_einh_name,
    wrg_id, frequenz_cd, kjwo, preis_rohstoff_max, preis_rohstoff_min, preis_rohstoff_avg, preis_gefuellt_fg, td_update,
    td_insert
)
(
    SELECT *
    FROM `_snap1`
    WHERE (rohstoff_nr, rohstoff_einh_name, dat_rohstoff_preis, frequenz_cd, wrg_id) NOT IN (SELECT (
        rohstoff_nr,
        rohstoff_einh_name, dat_rohstoff_preis, frequenz_cd, wrg_id
    )
    FROM dbp_data.rohstoff_preisentwicklung_1)
);


DELETE FROM dbp_data.rohstoff_preisentwicklung_1
WHERE dat_rohstoff_preis >= CURRENT_DATE("Europe/Berlin");


-- 1. Tag_1


UPDATE dbp_data.rohstoff_preisentwicklung_1 SET
    preis_gefuellt_fg = 2
FROM `_day_daily` AS b
WHERE
    rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr AND rohstoff_preisentwicklung.dat_rohstoff_preis > b.dat_rohstoff_preis
    AND rohstoff_preisentwicklung.frequenz_cd = 'Daily';


-- 2. Woche_1


UPDATE dbp_data.rohstoff_preisentwicklung_1 SET
    preis_gefuellt_fg = 0
FROM `_day_weekly` AS b
WHERE
    rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr AND rohstoff_preisentwicklung.dat_rohstoff_preis BETWEEN b.dat_rohstoff_preis
    AND b.max_dat_null AND rohstoff_preisentwicklung.frequenz_cd = 'Weekly';


UPDATE dbp_data.rohstoff_preisentwicklung_1 SET
    preis_gefuellt_fg = 2
FROM `_day_weekly` AS b
WHERE
    rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr AND rohstoff_preisentwicklung.dat_rohstoff_preis > b.max_dat_null
    AND rohstoff_preisentwicklung.frequenz_cd = 'Weekly';


-- 3. Monat_1


UPDATE dbp_data.rohstoff_preisentwicklung_1 SET
    preis_gefuellt_fg = 0
FROM `_day_monthly` AS b
WHERE
    rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr AND rohstoff_preisentwicklung.dat_rohstoff_preis BETWEEN b.dat_rohstoff_preis
    AND b.max_dat_null AND rohstoff_preisentwicklung.frequenz_cd = 'Monthly';


UPDATE dbp_data.rohstoff_preisentwicklung_1 SET
    preis_gefuellt_fg = 2
FROM `_day_monthly` AS b
WHERE
    rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr AND rohstoff_preisentwicklung.dat_rohstoff_preis > b.max_dat_null
    AND rohstoff_preisentwicklung.frequenz_cd = 'Monthly';


-- 4. Quartal


UPDATE dbp_data.rohstoff_preisentwicklung_1 SET
    preis_gefuellt_fg = 0
FROM `_day_quarterly` AS b
WHERE
    rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr AND rohstoff_preisentwicklung.dat_rohstoff_preis BETWEEN b.dat_rohstoff_preis
    AND b.max_dat_null AND rohstoff_preisentwicklung.frequenz_cd = 'Quarterly';


UPDATE dbp_data.rohstoff_preisentwicklung_1 SET
    preis_gefuellt_fg = 2
FROM `_day_quarterly` AS b
WHERE
    rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr AND rohstoff_preisentwicklung.dat_rohstoff_preis > b.max_dat_null
    AND rohstoff_preisentwicklung.frequenz_cd = 'Quarterly';


-- 5. Jahr


UPDATE dbp_data.rohstoff_preisentwicklung_1 SET
    preis_gefuellt_fg = 0
FROM `_day_yearly` AS b
WHERE
    rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr AND rohstoff_preisentwicklung.dat_rohstoff_preis BETWEEN b.dat_rohstoff_preis
    AND b.max_dat_null AND rohstoff_preisentwicklung.frequenz_cd = 'Yearly';


UPDATE dbp_data.rohstoff_preisentwicklung_1 SET
    preis_gefuellt_fg = 2
FROM `_day_yearly` AS b
WHERE
    rohstoff_preisentwicklung.rohstoff_nr = b.rohstoff_nr AND rohstoff_preisentwicklung.dat_rohstoff_preis > b.max_dat_null
    AND rohstoff_preisentwicklung.frequenz_cd = 'Yearly';


---------------------------------
--- 6. Werbewoche             ---
---------------------------------


UPDATE dbp_data.rohstoff_preisentwicklung_1 SET
    kjwo = b.kjwo_ww FROM (
    SELECT *
    FROM dbp_data.werbewoche_kl_1
    WHERE mandant_id = 2
) AS b
WHERE rohstoff_preisentwicklung.dat_rohstoff_preis = b.dat;
