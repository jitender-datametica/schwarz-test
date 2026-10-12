CREATE OR REPLACE TABLE dbp_etl.rel_lagerbew_abschr_tmp_1 (
    mandant_id INTEGER NOT NULL,
    lagerbew_beleg_id INTEGER NOT NULL,
    kj INTEGER NOT NULL,
    dat_buch DATE NOT NULL,
    ref_lagerbew_beleg_id STRING(20) COLLATE 'und:ci'
);


CREATE OR REPLACE TABLE dbp_etl.rel_dat_buch_abschr_tmp_1 (
    dat_buch DATE NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.abschriftart_char_tmp_1 (
    mandant_id INTEGER NOT NULL,
    abschriftart_id STRING(3) COLLATE 'und:ci'
);


CREATE OR REPLACE TABLE dbp_etl.marktabschriften_mseg_agg_dat_1 (
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE,
    mandant_id INTEGER NOT NULL
);


INSERT INTO dbp_etl.rel_lagerbew_abschr_tmp_1 (
    mandant_id, lagerbew_beleg_id, kj, dat_buch,
    ref_lagerbew_beleg_id
)
(
    SELECT
        mandant_id,
        lagerbew_beleg_id,
        kj,
        dat_buch,
        ref_lagerbew_beleg_id
    FROM dbp_data.lagerbew_1
    WHERE
        mandant_id > 1
        AND dat_buch BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 365 DAY) AND (CURRENT_DATE("Europe/Berlin"))
        AND COALESCE(TRIM(ref_lagerbew_beleg_id), '') <> ''
        AND LENGTH(TRIM(ref_lagerbew_beleg_id)) = 14
        AND (
            mandant_id, kj, ref_lagerbew_beleg_id) IN (
            SELECT (mandant_id, kj, ref_lagerbew_beleg_id)
            FROM dbp_etl.mseg_abschriften_gen_1
        )
        AND (
            mandant_id, lagerbew_beleg_id, kj) NOT IN (
            SELECT (mandant_id, wup_abschrift_id, kj)
            FROM dbp_etl.mseg_abschriften_gen_1
        )
);


UPDATE dbp_etl.mseg_abschriften_gen_1 SET
    ref_lagerbew_beleg_id = CAST(mseg_abschriften_gen.wup_id AS STRING) || TRIM(mseg_abschriften_gen.ref_lagerbew_beleg_id
    )
WHERE LENGTH(TRIM(ref_lagerbew_beleg_id)) = 10;


INSERT INTO dbp_etl.rel_dat_buch_abschr_tmp_1 (dat_buch)
(
    SELECT *
    FROM (
        SELECT dat_buch
        FROM dbp_etl.rel_lagerbew_abschr_tmp_1
        GROUP BY dat_buch
        UNION DISTINCT
        SELECT dat
        FROM dbp_etl.mseg_abschriften_gen_1
        GROUP BY dat
    ) AS t1_1
);


INSERT INTO dbp_etl.abschriftart_char_tmp_1 (mandant_id, abschriftart_id)
(
    SELECT
        mandant_id,
        TRIM(CAST(abschriftart_id AS STRING)) AS abschriftart_id
    FROM dbp_data.l_abschriftart_1
    WHERE
        mandant_id > 1
        AND abschriftart_id < 1000
);


INSERT INTO dbp_etl.mseg_abschriften_gen_1 (
    abschriftart_id, abschriftbetrag_brutto, abschriftbetrag_netto,
    art_id, dat, kj, lastupd_dat, mandant_id, menge_abschrift, nb_id, positionsnummer_id, ref_lagerbew_beleg_id, woche_id,
    wrg_id, wup_abschrift_id, wup_id
)
(
    SELECT
        CAST(D.lager_bewart_id AS INTEGER) AS abschriftart_id,
        CAST(ABS(D.betrag_verkauf) * CASE
            WHEN D.soll_haben_kz = 'S'
                THEN -1
            ELSE 1
        END AS NUMERIC) AS abschriftbetrag_brutto,
        CAST(ABS(D.betrag_vk_netto) * CASE
            WHEN D.soll_haben_kz = 'S'
                THEN -1
            ELSE 1
        END AS NUMERIC) AS abschriftbetrag_netto,
        D.art_id,
        D.dat_buch AS dat,
        K.kj,
        CURRENT_DATE("Europe/Berlin") AS lastupd_dat,
        D.mandant_id,
        CAST(CASE
            WHEN
                CASE
                    WHEN R.gewart_id = 'KG'
                        THEN ABS(D.menge_lagerbew_bme) * CASE
                            WHEN D.soll_haben_kz = 'S'
                                THEN -1
                            ELSE 1
                        END * 1000
                    WHEN (ABS(D.menge_lagerbew_bme) * CASE
                        WHEN D.soll_haben_kz = 'S'
                            THEN -1
                        ELSE 1
                    END) BETWEEN 0.001 AND 1
                        THEN 1
                    WHEN (ABS(D.menge_lagerbew_bme) * CASE
                        WHEN D.soll_haben_kz = 'S'
                            THEN -1
                        ELSE 1
                    END) BETWEEN -1 AND (-0.001)
                        THEN -1
                    ELSE ABS(D.menge_lagerbew_bme) * CASE
                        WHEN D.soll_haben_kz = 'S'
                            THEN -1
                        ELSE 1
                    END
                END > 999999999
                THEN 999999999
            WHEN
                CASE
                    WHEN R.gewart_id = 'KG'
                        THEN ABS(D.menge_lagerbew_bme) * CASE
                            WHEN D.soll_haben_kz = 'S'
                                THEN -1
                            ELSE 1
                        END * 1000
                    WHEN (ABS(D.menge_lagerbew_bme) * CASE
                        WHEN D.soll_haben_kz = 'S'
                            THEN -1
                        ELSE 1
                    END) BETWEEN 0.001 AND 1
                        THEN 1
                    WHEN (ABS(D.menge_lagerbew_bme) * CASE
                        WHEN D.soll_haben_kz = 'S'
                            THEN -1
                        ELSE 1
                    END) BETWEEN -1 AND (-0.001)
                        THEN -1
                    ELSE ABS(D.menge_lagerbew_bme) * CASE
                        WHEN D.soll_haben_kz = 'S'
                            THEN -1
                        ELSE 1
                    END
                END < -999999999
                THEN -999999999
            ELSE CASE
                WHEN R.gewart_id = 'KG'
                    THEN ABS(D.menge_lagerbew_bme) * CASE
                        WHEN D.soll_haben_kz = 'S'
                            THEN -1
                        ELSE 1
                    END * 1000
                WHEN (ABS(D.menge_lagerbew_bme) * CASE
                    WHEN D.soll_haben_kz = 'S'
                        THEN -1
                    ELSE 1
                END) BETWEEN 0.001 AND 1
                    THEN 1
                WHEN (ABS(D.menge_lagerbew_bme) * CASE
                    WHEN D.soll_haben_kz = 'S'
                        THEN -1
                    ELSE 1
                END) BETWEEN -1 AND (-0.001)
                    THEN -1
                ELSE ABS(D.menge_lagerbew_bme) * CASE
                    WHEN D.soll_haben_kz = 'S'
                        THEN -1
                    ELSE 1
                END
            END
        END AS INTEGER) AS menge_abschrift,
        D.nb_id,
        D.lagerbew_beleg_pos_id AS positionsnummer_id,
        CASE
            WHEN LENGTH(TRIM(K.ref_lagerbew_beleg_id)) = 10
                THEN CAST(D.wup_id AS STRING) || TRIM(K.ref_lagerbew_beleg_id)
            ELSE K.ref_lagerbew_beleg_id
        END AS ref_lagerbew_beleg_id_,
        G.kjwo AS woche_id,
        D.wrg_id,
        D.lagerbew_beleg_id AS wup_abschrift_id,
        D.wup_id
    FROM dbp_data.lagerbew_det_1 AS D
    INNER JOIN dbp_etl.rel_dat_buch_abschr_tmp_1 AS T ON D.dat_buch = T.dat_buch
    INNER JOIN dbp_etl.rel_lagerbew_abschr_tmp_1 AS K
        ON
            D.mandant_id = K.mandant_id AND D.lagerbew_beleg_id
            = K.lagerbew_beleg_id AND D.kj = K.kj AND D.dat_buch = K.dat_buch
    INNER JOIN dbp_etl.abschriftart_char_tmp_1 AS A
        ON
            D.mandant_id = A.mandant_id AND D.lager_bewart_id = A.abschriftart_id
    INNER JOIN dbp_data.tag_1 AS G ON D.dat_buch = G.dat
    INNER JOIN dbp_data.art_1 AS R ON D.mandant_id = R.mandant_id AND D.art_id = R.art_id
    WHERE
        D.mandant_id > 1
        AND D.dat_buch BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 365 DAY) AND (CURRENT_DATE("Europe/Berlin"))
        AND (D.mandant_id, D.kj, CASE
            WHEN LENGTH(TRIM(K.ref_lagerbew_beleg_id)) = 10
                THEN CAST(D.wup_id AS STRING) || TRIM(K.ref_lagerbew_beleg_id)
            ELSE K.ref_lagerbew_beleg_id
        END) IN (SELECT (mandant_id, kj, ref_lagerbew_beleg_id)
        FROM dbp_etl.mseg_abschriften_gen_1)
);


CREATE OR REPLACE TEMPORARY TABLE _zwischen AS
SELECT *
FROM dbp_data.marktabschriften_1
WHERE (mandant_id, wup_id, art_id, dat, wup_abschrift_id, positionsnummer_id) IN (SELECT (
    mandant_id, wup_id, art_id,
    dat, wup_abschrift_id, positionsnummer_id
)
FROM dbp_etl.mseg_abschriften_gen_1);


DELETE FROM dbp_data.marktabschriften_1
WHERE (mandant_id, wup_id, art_id, dat, wup_abschrift_id, positionsnummer_id) IN (SELECT (
    mandant_id, wup_id, art_id,
    dat, wup_abschrift_id, positionsnummer_id
)
FROM dbp_etl.mseg_abschriften_gen_1);


INSERT INTO dbp_data.marktabschriften_1 (
    wup_id, wup_abschrift_id, positionsnummer_id, nb_id, dat,
    mandant_id, lastupd_dat, woche_id, menge_abschrift, abschriftart_id, art_id, abschriftbetrag_netto,
    abschriftbetrag_brutto, wrg_id, td_insert, td_update
)
(
    SELECT
        wup_id,
        wup_abschrift_id,
        positionsnummer_id,
        nb_id,
        dat,
        mandant_id,
        lastupd_dat,
        woche_id,
        menge_abschrift,
        abschriftart_id,
        art_id,
        abschriftbetrag_netto,
        abschriftbetrag_brutto,
        wrg_id,
        CURRENT_TIMESTAMP() AS td_insert,
        CURRENT_TIMESTAMP() AS td_update
    FROM dbp_etl.mseg_abschriften_gen_1
    WHERE
        ref_lagerbew_beleg_id IS NULL
        OR ref_lagerbew_beleg_id = ''
);


INSERT INTO dbp_data.marktabschriften_1 (
    wup_id, wup_abschrift_id, positionsnummer_id, nb_id, dat,
    mandant_id, lastupd_dat, woche_id, menge_abschrift, abschriftart_id, art_id, abschriftbetrag_netto,
    abschriftbetrag_brutto, wrg_id, td_insert, td_update
)
(SELECT
    wup_id,
    wup_abschrift_id,
    positionsnummer_id,
    nb_id,
    dat,
    mandant_id,
    lastupd_dat,
    woche_id,
    SUM(menge_abschrift) OVER (PARTITION BY mandant_id, art_id, kj, CASE
        WHEN MOD(abschriftart_id, 2) = 0
            THEN abschriftart_id - 1
        ELSE abschriftart_id
    END, dat, ref_lagerbew_beleg_id ORDER BY 1 IS NULL, 1 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
    menge_abschrift_,
    abschriftart_id,
    art_id,
    SUM(abschriftbetrag_netto) OVER (PARTITION BY mandant_id, art_id, kj, CASE
        WHEN MOD(abschriftart_id, 2) = 0
            THEN abschriftart_id - 1
        ELSE abschriftart_id
    END, dat, ref_lagerbew_beleg_id ORDER BY 1 IS NULL, 1 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
    abschriftbetrag_netto_,
    SUM(abschriftbetrag_brutto) OVER (PARTITION BY mandant_id, art_id, kj, CASE
        WHEN MOD(abschriftart_id, 2) = 0
            THEN abschriftart_id - 1
        ELSE abschriftart_id
    END, dat, ref_lagerbew_beleg_id ORDER BY 1 IS NULL, 1 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
    abschriftbetrag_brutto_,
    wrg_id,
    CURRENT_TIMESTAMP() AS td_insert,
    CURRENT_TIMESTAMP() AS td_update
FROM dbp_etl.mseg_abschriften_gen_1
WHERE ref_lagerbew_beleg_id <> ''
QUALIFY (ROW_NUMBER() OVER (PARTITION BY
    mandant_id, art_id, dat, CASE
        WHEN MOD(abschriftart_id, 2) = 0
            THEN abschriftart_id - 1
        ELSE abschriftart_id
    END, kj, ref_lagerbew_beleg_id
ORDER BY wup_abschrift_id IS NULL, wup_abschrift_id, positionsnummer_id IS NULL, positionsnummer_id)) = 1);


CREATE OR REPLACE TEMPORARY TABLE _marktabs_ro_md AS
SELECT
    D.mandant_id,
    D.wup_id,
    D.nb_id,
    D.art_id,
    D.lagerbew_beleg_id AS wup_abschrift_id,
    D.lagerbew_beleg_pos_id AS positionsnummer_id,
    D.lager_bewart_id AS abschriftart_id,
    D.dat_buch AS dat,
    CURRENT_DATE("Europe/Berlin") AS lastupd_dat,
    G.kjwo AS woche_id,
    ABS(D.menge_lagerbew_bme) * CASE
        WHEN D.soll_haben_kz = 'S'
            THEN -1
        ELSE 1
    END AS menge_abschrift,
    ABS(D.betrag_vk_netto) * CASE
        WHEN D.soll_haben_kz = 'S'
            THEN -1
        ELSE 1
    END AS abschriftbetrag_netto,
    ABS(D.betrag_verkauf) * CASE
        WHEN D.soll_haben_kz = 'S'
            THEN -1
        ELSE 1
    END AS abschriftbetrag_brutto,
    D.wrg_id,
    R.gewart_id,
    A.ref_lagerbew_beleg_id,
    D.kj
FROM dbp_data.lagerbew_1 AS A
INNER JOIN dbp_data.lagerbew_det_1 AS D
    ON
        A.mandant_id = D.mandant_id AND A.lagerbew_beleg_id = D.lagerbew_beleg_id
        AND A.dat_buch = D.dat_buch
INNER JOIN dbp_data.tag_1 AS G ON D.dat_buch = G.dat
INNER JOIN dbp_data.art_1 AS R ON D.mandant_id = R.mandant_id AND D.art_id = R.art_id
WHERE
    D.mandant_id IN (4, 7)
    AND D.auto_fg <> ''
    AND D.dat_buch BETWEEN (
        SELECT MIN(dat) AS dat_buch
        FROM dbp_data.marktabschriften_1
        WHERE mandant_id IN (4, 7)
    ) AND (CURRENT_DATE("Europe/Berlin")
    )
    AND A.ref_lagerbew_beleg_id = 'SC'
    AND D.lager_bewart_id IN ('343', '344');


UPDATE `_marktabs_ro_md` AS `_marktabs_ro_md0` SET
    menge_abschrift = u.menge_abschrift_ FROM (SELECT
    mandant_id,
    wup_id,
    art_id,
    dat,
    wup_abschrift_id,
    positionsnummer_id,
    CASE
        WHEN gewart_id = 'KG'
            THEN menge_abschrift * 1000
        ELSE menge_abschrift
    END AS menge_abschrift_g,
    CASE
        WHEN
            CASE
                WHEN gewart_id = 'KG'
                    THEN menge_abschrift * 1000
                ELSE menge_abschrift
            END BETWEEN 0.001 AND 1
            THEN 1
        WHEN
            CASE
                WHEN gewart_id = 'KG'
                    THEN menge_abschrift * 1000
                ELSE menge_abschrift
            END BETWEEN -1 AND (-0.001)
            THEN -1
        ELSE CASE
            WHEN gewart_id = 'KG'
                THEN menge_abschrift * 1000
            ELSE menge_abschrift
        END
    END AS menge_abschrift_
FROM `_marktabs_ro_md`) AS u
WHERE
    `_marktabs_ro_md0`.mandant_id = u.mandant_id AND `_marktabs_ro_md0`.wup_id = u.wup_id AND `_marktabs_ro_md0`.art_id
    = u.art_id AND `_marktabs_ro_md0`.dat = u.dat AND `_marktabs_ro_md0`.wup_abschrift_id = u.wup_abschrift_id AND
    `_marktabs_ro_md0`.positionsnummer_id = u.positionsnummer_id;


UPDATE `_marktabs_ro_md` SET
    menge_abschrift = CASE
        WHEN `_marktabs_ro_md`.menge_abschrift > 999999999
            THEN 999999999
        WHEN `_marktabs_ro_md`.menge_abschrift < -999999999
            THEN -999999999
        ELSE `_marktabs_ro_md`.menge_abschrift
    END
WHERE TRUE;


INSERT INTO `_zwischen`
(
    SELECT *
    FROM dbp_data.marktabschriften_1
    WHERE dat IN (
        SELECT dat
        FROM `_marktabs_ro_md`
    )
    AND mandant_id IN (4, 7)
    AND abschriftart_id IN (343, 344)
);


DELETE FROM dbp_data.marktabschriften_1
WHERE dat IN (
    SELECT dat
    FROM `_marktabs_ro_md`
) AND mandant_id IN (4, 7
) AND abschriftart_id IN (343, 344
);


INSERT INTO dbp_data.marktabschriften_1 (
    wup_id, wup_abschrift_id, positionsnummer_id, nb_id, dat,
    mandant_id, lastupd_dat, woche_id, menge_abschrift, abschriftart_id, art_id, abschriftbetrag_netto,
    abschriftbetrag_brutto, wrg_id, td_insert, td_update
)
(SELECT
    wup_id,
    wup_abschrift_id,
    positionsnummer_id,
    nb_id,
    dat,
    mandant_id,
    lastupd_dat,
    woche_id,
    CAST(SUM(menge_abschrift) OVER (PARTITION BY mandant_id, art_id, dat, abschriftart_id ORDER BY 1 IS NULL, 1 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS NUMERIC)
        AS menge_abschrift_,
    CAST(abschriftart_id AS INTEGER) AS abschriftart_id,
    art_id,
    CAST(SUM(abschriftbetrag_netto) OVER (PARTITION BY mandant_id, art_id, dat, abschriftart_id ORDER BY 1 IS NULL, 1 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS NUMERIC)
        AS abschriftbetrag_netto_,
    CAST(SUM(abschriftbetrag_brutto) OVER (PARTITION BY mandant_id, art_id, dat, abschriftart_id ORDER BY 1 IS NULL, 1 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS NUMERIC)
        AS abschriftbetrag_brutto_,
    wrg_id,
    CURRENT_TIMESTAMP() AS td_insert,
    CURRENT_TIMESTAMP() AS td_update
FROM `_marktabs_ro_md`
QUALIFY COALESCE(SUM(menge_abschrift) OVER (
    PARTITION BY mandant_id, art_id, dat, abschriftart_id ORDER BY 1 IS NULL, 1
    RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 0) <> 0 OR COALESCE(SUM(abschriftbetrag_netto) OVER (PARTITION BY
    mandant_id, art_id, dat, abschriftart_id
ORDER BY 1 IS NULL, 1 RANGE BETWEEN UNBOUNDED PRECEDING AND
CURRENT ROW), 0) <> 0 OR COALESCE(SUM(abschriftbetrag_brutto) OVER (
    PARTITION BY
        mandant_id, art_id, dat,
        abschriftart_id
    ORDER BY 1 IS NULL, 1
    RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
), 0) <> 0);


INSERT INTO dbp_etl_process.uapc_marktabschriften_deletion_1 (
    mandant_id, wup_id, art_id, dat,
    wup_abschrift_id, positionsnummer_id, row_id, td_insert, td_update
)
(SELECT
    mandant_id,
    wup_id,
    art_id,
    dat,
    wup_abschrift_id,
    positionsnummer_id,
    (ROW_NUMBER() OVER (
        ORDER BY
            mandant_id IS NULL, mandant_id, wup_id IS NULL, wup_id, art_id IS NULL, art_id, dat
            IS NULL, dat, wup_abschrift_id IS NULL, wup_abschrift_id, positionsnummer_id IS NULL, positionsnummer_id
    )) +
    COALESCE((
        SELECT MAX(row_id)
        FROM dbp_etl_process.uapc_marktabschriften_deletion_1
    ), 0) AS row_id,
    CURRENT_TIMESTAMP() AS td_insert,
    CURRENT_TIMESTAMP() AS td_update
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        dat,
        wup_abschrift_id,
        positionsnummer_id
    FROM `_zwischen`
    WHERE (mandant_id, wup_id, art_id, dat, wup_abschrift_id, positionsnummer_id) NOT IN (SELECT (
        mandant_id, wup_id,
        art_id, dat, wup_abschrift_id, positionsnummer_id
    )
    FROM dbp_data.marktabschriften_1)
    GROUP BY
        wup_id,
        wup_abschrift_id,
        positionsnummer_id,
        dat,
        mandant_id,
        art_id
) AS t2);


INSERT INTO dbp_etl.marktabschriften_mseg_agg_dat_1 (wup_id, nb_id, dat, mandant_id)
(
    SELECT
        wup_id,
        nb_id,
        dat,
        mandant_id
    FROM dbp_etl.mseg_abschriften_gen_1
    GROUP BY
        dat,
        mandant_id,
        nb_id,
        wup_id
);


DELETE FROM dbp_data.marktabschriften_wg_sum_1
WHERE (
    wup_id, nb_id, dat, mandant_id) IN (SELECT (wup_id, nb_id, dat, mandant_id)
FROM dbp_etl.marktabschriften_mseg_agg_dat_1) AND (mandant_id, abschriftart_id) NOT IN (
    SELECT (
        mandant_id,
        abschriftart_id
    )
    FROM dbp_data.abschriftart_abschriftgrp_zu_1
    WHERE abschriftgruppe_id = 400
);


INSERT INTO dbp_data.marktabschriften_wg_sum_1 (
    mandant_id, wup_id, nb_id, abschriftart_id, wg_id,
    arthiertyp_id, dat, abschriftbetrag_netto, abschriftbetrag_brutto, wrg_id
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.abschriftart_id,
        T2.wg_id,
        T2.arthiertyp_id,
        T1.dat,
        SUM(T1.abschriftbetrag_netto),
        SUM(T1.abschriftbetrag_brutto),
        T1.wrg_id
    FROM dbp_data.marktabschriften_1 AS T1_1
    INNER JOIN dbp_etl.marktabschriften_mseg_agg_dat_1 AS D
        ON
            T1.wup_id = D.wup_id AND T1.nb_id = D.nb_id
            AND T1.dat = D.dat AND T1.mandant_id = D.mandant_id
    INNER JOIN dbp_data.art_wg_zu_per_1 AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id AND
            T1.dat BETWEEN T2.dat_von AND T2.dat_bis AND T2.arthiertyp_id = 2
    GROUP BY
        T1.wup_id,
        T1.nb_id,
        T1.dat,
        T1.mandant_id,
        T1.abschriftart_id,
        T1.wrg_id,
        T2.arthiertyp_id,
        T2.wg_id
);


DROP TABLE IF EXISTS dbp_etl.rel_lagerbew_abschr_tmp_1;


DROP TABLE IF EXISTS dbp_etl.rel_dat_buch_abschr_tmp_1;


DROP TABLE IF EXISTS dbp_etl.abschriftart_char_tmp_1;
