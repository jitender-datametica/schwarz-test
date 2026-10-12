-- KMO --


CREATE OR REPLACE TEMPORARY TABLE _bestand (
    mandant_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    dat DATE,
    menge_frei NUMERIC(29, 3),
    menge_qual NUMERIC(29, 3),
    menge_gesp NUMERIC(29, 3)
);


INSERT INTO `_bestand`
(
    SELECT
        mandant_id,
        art_id,
        wup_id,
        dat,
        menge_lgbest_erp_frei_bme AS menge_frei,
        menge_lgbest_erp_qual_bme AS menge_qual,
        menge_lgbest_erp_gesp_bme AS menge_gesp
    FROM dbp_etl_process.dwh_mardh_monatsendbestand
    WHERE
        mandant_id > 1
        AND (
            mandant_id, dat) IN (
            SELECT (mandant_id, MAX(dat))
            FROM dbp_etl_process.dwh_mardh_monatsendbestand
            WHERE mandant_id > 1
            GROUP BY mandant_id
        )
);


CREATE OR REPLACE TEMPORARY TABLE _lieferung1 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.dat_buch AS dat,
    SUM(CASE
        WHEN
            A.lager_bewart_id = '313' OR A.lager_bewart_id IN ('343', '344') AND A.menge_lagerbew_bme = 0 AND A.mandant_id =
            5
            THEN A.menge_erf
        WHEN A.mandant_id = 2 AND A.wup_id IN (2700, 3900) AND A.lager_bewart_id = '315'
            THEN 0
        ELSE A.menge_lagerbew_bme
    END) AS menge_lief_frei,
    0 AS menge_lief_qual,
    0 AS menge_lief_gesp
FROM dbp_data.lagerbew_det AS A
INNER JOIN dbp_etl_process.mseg_bewart_daria AS B
    ON
        A.lager_bewart_id = B.lager_bewart_id AND TRIM(A.auto_fg
        ) = TRIM(B.auto_fg_frei) AND B.relevant_fg = 1
WHERE
    A.mandant_id > 1
    AND A.dat_buch BETWEEN (
        SELECT DATE_ADD(MIN(dat), INTERVAL 1 DAY)
        FROM `_bestand`
    ) AND (CURRENT_DATE("Europe/Berlin")
    )
GROUP BY
    A.mandant_id,
    A.art_id,
    A.wup_id,
    dat
UNION ALL
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.dat_buch AS dat,
    0 AS menge_lief_frei,
    SUM(A.menge_lagerbew_bme) AS menge_lief_qual,
    0 AS menge_lief_gesp
FROM dbp_data.lagerbew_det AS A
INNER JOIN dbp_etl_process.mseg_bewart_daria AS B
    ON
        A.lager_bewart_id = B.lager_bewart_id AND TRIM(A.auto_fg
        ) = TRIM(B.auto_fg_qual) AND B.relevant_fg = 1
WHERE
    A.mandant_id > 1
    AND A.dat_buch BETWEEN (
        SELECT DATE_ADD(MIN(dat), INTERVAL 1 DAY)
        FROM `_bestand`
    ) AND (CURRENT_DATE("Europe/Berlin")
    )
GROUP BY
    A.mandant_id,
    A.art_id,
    A.wup_id,
    dat
UNION ALL
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.dat_buch AS dat,
    0 AS menge_lief_frei,
    0 AS menge_lief_qual,
    SUM(A.menge_lagerbew_bme) AS menge_lief_gesp
FROM dbp_data.lagerbew_det AS A
INNER JOIN dbp_etl_process.mseg_bewart_daria AS B
    ON
        A.lager_bewart_id = B.lager_bewart_id AND TRIM(A.auto_fg
        ) = TRIM(B.auto_fg_gesp) AND B.relevant_fg = 1
WHERE
    A.mandant_id > 1
    AND A.dat_buch BETWEEN (
        SELECT DATE_ADD(MIN(dat), INTERVAL 1 DAY)
        FROM `_bestand`
    ) AND (CURRENT_DATE("Europe/Berlin")
    )
GROUP BY
    A.mandant_id,
    A.art_id,
    A.wup_id,
    dat;


CREATE OR REPLACE TEMPORARY TABLE _tage AS
SELECT dat
FROM dbp_data.tag
WHERE dat BETWEEN (
    SELECT DATE_ADD(MIN(dat), INTERVAL 1 DAY)
    FROM `_bestand`
) AND (CURRENT_DATE("Europe/Berlin")
);


--EXECUTE IMMEDIATE CONVERTED BLOCK - START
BEGIN
    DECLARE loop_counter1 INT64 DEFAULT 1;
    DECLARE loop_counter_value INT64 DEFAULT 0;

    while ((loop_counter1) > 0) do


        insert into _bestand
        select
            coalesce(a.mandant_id, b.mandant_id),
            coalesce(a.art_id, b.art_id),
            coalesce(a.wup_id, b.wup_id),
            coalesce(a.dat, b.dat + 1),
            IFNULL(b.menge_frei, 0) + IFNULL(a.menge_lief_frei, 0),
            IFNULL(b.menge_qual, 0) + IFNULL(a.menge_lief_qual, 0),
            IFNULL(b.menge_gesp, 0) + IFNULL(a.menge_lief_gesp, 0)
        from (select
            mandant_id,
            art_id,
            wup_id,
            dat,
            sum(menge_lief_frei) as menge_lief_frei,
            sum(menge_lief_qual) as menge_lief_qual,
            sum(menge_lief_gesp) as menge_lief_gesp
        from _lieferung1
        where dat in (select min(dat) from _tage)
        group by 1, 2, 3, 4) a
        full join (
            select *
            from _bestand
            where dat in (select min(dat) - 1 from _tage)
        ) b
            on
                a.art_id = b.art_id and
                a.wup_id = b.wup_id and
                a.mandant_id = b.mandant_id and
                a.dat = b.dat + 1;


        delete from _tage
        where dat in (select min(dat) from _tage);


        SET loop_counter1 = @@row_count;
        SET loop_counter_value = loop_counter_value + 1;
    end while;

    SELECT loop_counter_value;

END;
--EXECUTE IMMEDIATE CONVERTED BLOCK - END


DELETE FROM dbp_etl_process.mard_bcg
WHERE DATE(
    td_insert) BETWEEN (SELECT MIN(dat)
FROM `_bestand`) AND (
    SELECT MAX(dat)
    FROM `_bestand`
) AND DATE(td_insert
) BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY
) AND (CURRENT_DATE("Europe/Berlin")
) AND
mandant_id > 1;


INSERT INTO dbp_etl_process.mard_bcg (
    mandant_id, art_id, wup_id, nb_id, menge_lgbest_erp_frei_bme,
    td_insert, td_update
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        E.wup_id,
        E.nb_id,
        A.menge_frei AS menge_lgbest_erp_frei_bme,
        CAST(A.dat AS TIMESTAMP) AS td_insert,
        CURRENT_TIMESTAMP() AS td_update
    FROM `_bestand` AS A
    INNER JOIN dbp_data.art_wg_zu_per AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    INNER JOIN dbp_data.wg_spr_zu AS C
        ON
            A.mandant_id = C.mandant_id AND B.wg_id = C.wg_id AND B.arthiertyp_id
            = C.arthiertyp_id AND C.spr_id = 22
    INNER JOIN dbp_data.wg_per AS D
        ON
            A.mandant_id = D.mandant_id AND B.wg_id = D.wg_id AND B.arthiertyp_id
            = D.arthiertyp_id AND D.dat_bis = DATE '9999-12-31'
    INNER JOIN dbp_data.wup AS E ON A.mandant_id = E.mandant_id AND A.wup_id = E.wup_id AND E.nb_id = 0
    WHERE
        D.owg_id IN (1006, 1010)
        AND A.mandant_id > 1
        AND A.dat BETWEEN (
            SELECT MIN(dat)
            FROM `_bestand`) AND (
            SELECT MAX(dat)
            FROM `_bestand`
        )
        AND A.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY) AND (CURRENT_DATE("Europe/Berlin"))
);


-- DE --


CREATE OR REPLACE TEMPORARY TABLE _bestand (
    mandant_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    dat DATE,
    menge_frei NUMERIC(29, 3),
    menge_qual NUMERIC(29, 3),
    menge_gesp NUMERIC(29, 3)
);


INSERT INTO `_bestand`
(
    SELECT
        mandant_id,
        art_id,
        wup_id,
        dat,
        menge_lgbest_erp_frei_bme AS menge_frei,
        menge_lgbest_erp_qual_bme AS menge_qual,
        menge_lgbest_erp_gesp_bme AS menge_gesp
    FROM dbp_etl_process.dwh_mardh_monatsendbestand
    WHERE
        mandant_id = 1
        AND dat IN (
            SELECT MAX(dat) AS a1169003766
            FROM dbp_etl_process.dwh_mardh_monatsendbestand
            WHERE mandant_id = 1
        )
);


CREATE OR REPLACE TEMPORARY TABLE _mseg_daria AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    CASE
        WHEN A.lagerbew_beleg_storno_id <> 0
            THEN B.dat_erfasst
        ELSE A.dat_buch
    END AS dat_buch,
    A.kj,
    A.lager_bewart_id,
    A.grund_id,
    A.menge_erf,
    A.menge_lagerbew_bme,
    A.lagerbew_beleg_id,
    A.lagerbew_beleg_pos_id,
    A.auto_fg
FROM dbp_data.lagerbew_det AS A
INNER JOIN dbp_data.lagerbew AS B
    ON
        A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
        AND A.kj = B.kj
WHERE
    A.mandant_id = 1
    AND A.dat_buch >= (
        SELECT MAX(dat)
        FROM dbp_etl_process.dwh_mardh_monatsendbestand
        WHERE mandant_id = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _lieferung1 AS
SELECT
    mandant_id,
    art_id,
    wup_id,
    dat,
    SUM(menge_lief) AS menge_lief_frei,
    0 AS menge_lief_qual,
    0 AS menge_lief_gesp
FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.dat_buch AS dat,
        SUM(CASE
            WHEN A.lager_bewart_id = '313'
                THEN A.menge_erf
            WHEN A.lager_bewart_id IN ('912', '915') AND CAST(A.grund_id AS FLOAT64) >= 8010
                THEN 0
            ELSE A.menge_lagerbew_bme
        END) AS menge_lief
    FROM `_mseg_daria` AS A
    INNER JOIN dbp_etl_process.mseg_bewart_de AS B
        ON
            A.lager_bewart_id = B.lager_bewart_id AND TRIM(A.auto_fg
            ) = TRIM(B.auto_fg) AND B.relevant_fg = 1
    WHERE
        A.mandant_id = 1
        AND A.dat_buch BETWEEN (
            SELECT DATE_ADD(MIN(dat), INTERVAL 1 DAY)
            FROM `_bestand`
        ) AND (CURRENT_DATE("Europe/Berlin")
        )
        AND A.art_id NOT IN (120246300, 120246500, 120246900, 120247300)
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.wup_id,
        dat
    UNION ALL
    SELECT
        mandant_id,
        art_id,
        wup_id,
        dat,
        SUM(menge) * -1 AS menge_lief
    FROM dbp_data.artbew AS A
    WHERE
        mandant_id = 1
        AND dat BETWEEN (
            SELECT DATE_ADD(MIN(dat), INTERVAL 1 DAY)
            FROM `_bestand`
        ) AND (CURRENT_DATE("Europe/Berlin")
        )
        AND art_id NOT IN (120246300, 120246500, 120246900, 120247300)
    GROUP BY
        mandant_id,
        art_id,
        wup_id,
        dat
) AS x
GROUP BY
    mandant_id,
    art_id,
    wup_id,
    dat;


CREATE OR REPLACE TEMPORARY TABLE _tage AS
SELECT dat
FROM dbp_data.tag
WHERE dat BETWEEN (
    SELECT DATE_ADD(MIN(dat), INTERVAL 1 DAY)
    FROM `_bestand`
) AND (CURRENT_DATE("Europe/Berlin")
);


--EXECUTE IMMEDIATE CONVERTED BLOCK - START
BEGIN
    DECLARE loop_counter1 INT64 DEFAULT 1;
    DECLARE loop_counter_value INT64 DEFAULT 0;

    while ((loop_counter1) > 0) do


        insert into _bestand
        select
            coalesce(a.mandant_id, b.mandant_id),
            coalesce(a.art_id, b.art_id),
            coalesce(a.wup_id, b.wup_id),
            coalesce(a.dat, b.dat + 1),
            IFNULL(b.menge_frei, 0) + IFNULL(a.menge_lief_frei, 0),
            IFNULL(b.menge_qual, 0) + IFNULL(a.menge_lief_qual, 0),
            IFNULL(b.menge_gesp, 0) + IFNULL(a.menge_lief_gesp, 0)
        from (select
            mandant_id,
            art_id,
            wup_id,
            dat,
            sum(menge_lief_frei) as menge_lief_frei,
            sum(menge_lief_qual) as menge_lief_qual,
            sum(menge_lief_gesp) as menge_lief_gesp
        from _lieferung1
        where dat in (select min(dat) from _tage)
        group by 1, 2, 3, 4) a
        full join (
            select *
            from _bestand
            where dat in (select min(dat) - 1 from _tage)
        ) b
            on
                a.art_id = b.art_id and
                a.wup_id = b.wup_id and
                a.mandant_id = b.mandant_id and
                a.dat = b.dat + 1;


        delete from _tage
        where dat in (select min(dat) from _tage);


        SET loop_counter1 = @@row_count;
        SET loop_counter_value = loop_counter_value + 1;
    end while;

    SELECT loop_counter_value;

END;
--EXECUTE IMMEDIATE CONVERTED BLOCK - END


DELETE FROM dbp_etl_process.mard_bcg
WHERE DATE(
    td_insert) BETWEEN (SELECT MIN(dat)
FROM `_bestand`) AND (
    SELECT MAX(dat)
    FROM `_bestand`
) AND DATE(td_insert
) BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY
) AND (CURRENT_DATE("Europe/Berlin")
) AND
mandant_id = 1;


INSERT INTO dbp_etl_process.mard_bcg (
    mandant_id, art_id, wup_id, nb_id, menge_lgbest_erp_frei_bme,
    td_insert, td_update
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        E.wup_id,
        E.nb_id,
        A.menge_frei AS menge_lgbest_erp_frei_bme,
        CAST(A.dat AS TIMESTAMP) AS td_insert,
        CURRENT_TIMESTAMP() AS td_update
    FROM `_bestand` AS A
    INNER JOIN dbp_data.art_wg_zu_per AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    INNER JOIN dbp_data.wg_spr_zu AS C
        ON
            A.mandant_id = C.mandant_id AND B.wg_id = C.wg_id AND B.arthiertyp_id
            = C.arthiertyp_id AND C.spr_id = 22
    INNER JOIN dbp_data.wg_per AS D
        ON
            A.mandant_id = D.mandant_id AND B.wg_id = D.wg_id AND B.arthiertyp_id
            = D.arthiertyp_id AND D.dat_bis = DATE '9999-12-31'
    INNER JOIN dbp_data.wup AS E ON A.mandant_id = E.mandant_id AND A.wup_id = E.wup_id AND E.nb_id = 0
    WHERE
        D.owg_id IN (1006, 1010)
        AND A.mandant_id = 1
        AND A.dat BETWEEN (
            SELECT MIN(dat)
            FROM `_bestand`) AND (
            SELECT MAX(dat)
            FROM `_bestand`
        )
        AND A.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY) AND (CURRENT_DATE("Europe/Berlin"))
);
