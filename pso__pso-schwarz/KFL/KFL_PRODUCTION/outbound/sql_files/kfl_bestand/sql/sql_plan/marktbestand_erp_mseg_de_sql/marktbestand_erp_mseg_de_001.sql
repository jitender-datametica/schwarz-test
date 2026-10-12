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
    DECLARE rows_deleted INT64;

    WHILE loop_counter1 > 0 DO

        INSERT INTO `_bestand`
        (
            mandant_id,
            art_id,
            wup_id,
            dat,
            menge_frei,
            menge_qual,
            menge_gesp
        )
        SELECT
            COALESCE(a.mandant_id, b.mandant_id),
            COALESCE(a.art_id, b.art_id),
            COALESCE(a.wup_id, b.wup_id),
            COALESCE(a.dat, DATE_ADD(b.dat, INTERVAL 1 DAY)),

            IFNULL(b.menge_frei, 0) + IFNULL(a.menge_lief_frei, 0),
            IFNULL(b.menge_qual, 0) + IFNULL(a.menge_lief_qual, 0),
            IFNULL(b.menge_gesp, 0) + IFNULL(a.menge_lief_gesp, 0)

        FROM (
            SELECT
                mandant_id,
                art_id,
                wup_id,
                dat,
                SUM(menge_lief_frei) AS menge_lief_frei,
                SUM(menge_lief_qual) AS menge_lief_qual,
                SUM(menge_lief_gesp) AS menge_lief_gesp
            FROM _lieferung1
            WHERE
                dat = (
                    SELECT MIN(dat)
                    FROM _tage
                )
            GROUP BY mandant_id, art_id, wup_id, dat
        ) a

        FULL OUTER JOIN (
            SELECT *
            FROM _bestand
            WHERE dat = (
                SELECT DATE_SUB(MIN(dat), INTERVAL 1 DAY)
                FROM _tage
            )
        ) b

            ON
                a.art_id = b.art_id
                AND a.wup_id = b.wup_id
                AND a.mandant_id = b.mandant_id
                AND a.dat = DATE_ADD(b.dat, INTERVAL 1 DAY)
        ;

        -- Capture rows to be deleted BEFORE deletion
        -- SET rows_deleted = (
        -- SELECT COUNT(*)
        -- FROM dbp_data._tage
        -- WHERE dat = (
        -- SELECT MIN(dat)
        -- FROM dbp_data._tage
        -- )
        -- );

        -- Perform delete
        DELETE FROM _tage
        WHERE dat = (
            SELECT MIN(dat)
            FROM _tage
        );

        -- Use same semantics as Snowflake
        SET loop_counter1 = @@row_count;
        -- rows_deleted;

        SET loop_counter_value = loop_counter_value + 1;

    END WHILE;

--SELECT loop_counter_value;
END;

--EXECUTE IMMEDIATE CONVERTED BLOCK - END


UPDATE dbp_data.marktbestand_erp SET
    menge_lgbest_erp_frei_bme = b.menge_frei FROM (
    SELECT *
    FROM `_bestand`
    WHERE
        dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 5 DAY) AND (CURRENT_DATE("Europe/Berlin"))
        AND mandant_id = 1
) AS b
WHERE
    marktbestand_erp.mandant_id = b.mandant_id AND marktbestand_erp.wup_id = b.wup_id AND marktbestand_erp.art_id = b.art_id AND marktbestand_erp.dat = b.dat;


INSERT INTO dbp_data.marktbestand_erp (
    mandant_id, art_id, wup_id, nb_id, dat, bestand_id, bezugsweg_id,
    relevant_fg, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_gesp_bme, fortschreibung_fg,
    td_update, td_insert
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        B.nb_id,
        A.dat,
        -9999 AS bestand_id,
        1 AS bezugsweg_id,
        0 AS relevant_fg,
        A.menge_frei AS menge_lgbest_erp_frei_bme,
        0 AS menge_lgbest_erp_qual_bme,
        0 AS menge_lgbest_erp_gesp_bme,
        0 AS fortschreibung_fg,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM `_bestand` AS A
    INNER JOIN dbp_data.wup AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
    WHERE
        A.mandant_id = 1
        AND (
            A.mandant_id, A.wup_id, A.art_id, A.dat) NOT IN (
            SELECT (mandant_id, wup_id, art_id, dat)
            FROM dbp_data.marktbestand_erp
            WHERE
                dat BETWEEN (
                    SELECT MIN(dat) AS a607192888
                    FROM `_bestand`
                ) AND (CURRENT_DATE("Europe/Berlin")
                )
                AND mandant_id = 1
        )
);
