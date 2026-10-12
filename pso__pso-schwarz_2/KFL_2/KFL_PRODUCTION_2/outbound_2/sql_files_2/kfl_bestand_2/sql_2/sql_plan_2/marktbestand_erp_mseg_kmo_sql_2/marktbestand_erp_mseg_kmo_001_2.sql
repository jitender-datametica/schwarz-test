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
    FROM dbp_etl_process.dwh_mardh_monatsendbestand_2
    WHERE
        mandant_id > 1
        AND (
            mandant_id, dat) IN (
            SELECT (mandant_id, MAX(dat))
            FROM dbp_etl_process.dwh_mardh_monatsendbestand_2
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
        WHEN A.lager_bewart_id = '313'
            THEN A.menge_erf
        WHEN A.mandant_id = 2 AND A.wup_id IN (2700, 3900) AND A.lager_bewart_id = '315'
            THEN 0
        ELSE A.menge_lagerbew_bme
    END) AS menge_lief_frei,
    0 AS menge_lief_qual,
    0 AS menge_lief_gesp
FROM dbp_data.lagerbew_det_2 AS A
INNER JOIN dbp_etl_process.mseg_bewart_daria_2 AS B
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
FROM dbp_data.lagerbew_det_2 AS A
INNER JOIN dbp_etl_process.mseg_bewart_daria_2 AS B
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
FROM dbp_data.lagerbew_det_2 AS A
INNER JOIN dbp_etl_process.mseg_bewart_daria_2 AS B
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
FROM dbp_data.tag_2
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

        -- loop_counter1 := (select * from table(result_scan(last_query_id())));
        SET loop_counter1 = @@row_count;

        SET loop_counter_value = loop_counter_value + 1;
    end while;

-- return loop_counter_value;

END;
--EXECUTE IMMEDIATE CONVERTED BLOCK - END


UPDATE dbp_data.marktbestand_erp_2 SET
    menge_lgbest_erp_frei_bme = b.menge_frei,
    menge_lgbest_erp_qual_bme = b.menge_qual,
    menge_lgbest_erp_gesp_bme = b.menge_gesp FROM (
    SELECT *
    FROM `_bestand`
    WHERE
        dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 5 DAY) AND (CURRENT_DATE("Europe/Berlin"))
        AND mandant_id > 1
) AS b
WHERE
    marktbestand_erp.mandant_id = b.mandant_id AND marktbestand_erp.wup_id = b.wup_id AND marktbestand_erp.art_id = b.art_id AND marktbestand_erp.dat = b.dat;


INSERT INTO dbp_data.marktbestand_erp_2 (
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
        A.menge_qual AS menge_lgbest_erp_qual_bme,
        A.menge_gesp AS menge_lgbest_erp_gesp_bme,
        0 AS fortschreibung_fg,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM `_bestand` AS A
    INNER JOIN dbp_data.wup_2 AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
    WHERE
        A.mandant_id > 1
        AND (
            A.mandant_id, A.wup_id, A.art_id, A.dat) NOT IN (
            SELECT (mandant_id, wup_id, art_id, dat)
            FROM dbp_data.marktbestand_erp_2
            WHERE
                dat BETWEEN (
                    SELECT MIN(dat) AS a607192888
                    FROM `_bestand`
                ) AND (CURRENT_DATE("Europe/Berlin")
                )
                AND mandant_id > 1
        )
);
