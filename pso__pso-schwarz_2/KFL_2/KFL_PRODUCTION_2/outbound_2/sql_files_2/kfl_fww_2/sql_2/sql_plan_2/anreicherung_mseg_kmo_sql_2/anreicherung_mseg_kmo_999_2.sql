CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mseg_art_gp_wup_zu_2 (
    mandant_id INTEGER NOT NULL,
    lagerbew_beleg_id INTEGER NOT NULL,
    lagerbew_beleg_pos_id INTEGER NOT NULL,
    kj INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_buch DATE NOT NULL,
    anz_ek_infosatz INTEGER,
    anz_ek_orderbuch INTEGER,
    bq_gp_id INTEGER,
    bq_ekorg INTEGER,
    bq_findung_id INTEGER,
    regel_gp_id INTEGER,
    regel_ekorg INTEGER
);


INSERT INTO dbp_etl.kmo_mseg_art_gp_wup_zu_2 (
    mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj,
    art_id,
    wup_id,
    nb_id,
    dat_buch,
    anz_ek_infosatz,
    anz_ek_orderbuch,
    bq_gp_id,
    bq_ekorg,
    bq_findung_id,
    regel_gp_id,
    regel_ekorg
)
(
    SELECT
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.lagerbew_beleg_pos_id,
        A.kj,
        A.art_id,
        CASE
            WHEN A.nb_id = -111
                THEN A.wup_id
            ELSE W.wup_id
        END AS wup_id_,
        -111 AS nb_id_,
        A.dat_buch,
        0 AS anz_ek_infosatz,
        0 AS anz_ek_orderbuch,
        0 AS bq_gp_id,
        0 AS bq_ekorg,
        0 AS bq_findung_id,
        0 AS regel_gp_id,
        0 AS regel_ekorg
    FROM dbp_data.lagerbew_det_delta_2 AS A
    INNER JOIN
        dbp_data.wup_2 AS W
        ON A.mandant_id = W.mandant_id AND A.empfaenger_id = W.wup_id
    WHERE
        (A.nb_id = -111 OR W.nb_id = -111)
        AND A.mandant_id > 1
        AND A.lager_bewart_id IN (
            '301', '302', '311', '312', '641', '642', '647', '648'
        )
        AND (
            A.mandant_id, A.lagerbew_beleg_id, A.lagerbew_beleg_pos_id, A.kj
        ) NOT IN (SELECT (
            mandant_id, lagerbew_beleg_id,
            lagerbew_beleg_pos_id, kj
        )
        FROM dbp_etl.kmo_mseg_art_gp_wup_zu_2)
);


DROP TABLE IF EXISTS dbp_etl.kmo_mkpfmseg_dat_2;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mkpfmseg_dat_2 (
    dat_buch DATE
);


INSERT INTO dbp_etl.kmo_mkpfmseg_dat_2 (dat_buch)
(
    SELECT dat_buch
    FROM dbp_etl.kmo_mseg_art_gp_wup_zu_2
    GROUP BY dat_buch
);


DROP TABLE IF EXISTS dbp_etl.kmo_mkpfmseg_dat_min_2;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mkpfmseg_dat_min_2 (
    dat_buch DATE
);


INSERT INTO dbp_etl.kmo_mkpfmseg_dat_min_2 (dat_buch)
(
    SELECT MIN(dat_buch) AS dat_buch
    FROM dbp_etl.kmo_mseg_art_gp_wup_zu_2
);


DROP TABLE IF EXISTS dbp_etl.kmo_mkpfmseg_anr_2;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mkpfmseg_anr_2 (
    mandant_id INTEGER NOT NULL,
    lagerbew_beleg_id INTEGER NOT NULL,
    lagerbew_beleg_pos_id INTEGER NOT NULL,
    kj INTEGER NOT NULL,
    dat_buch DATE NOT NULL,
    gp_id_zl INTEGER NOT NULL,
    einkaufsorganisation_id INTEGER,
    bq_findung_id INTEGER NOT NULL,
    betrag_einstandspreis NUMERIC(29, 4)
);


DROP TABLE IF EXISTS dbp_etl.`_vol_art_gp_wup_zu_per`;


CREATE TABLE IF NOT EXISTS dbp_etl.`_vol_art_gp_wup_zu_per` (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER,
    einkaufsorganisation_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    einstandspreis NUMERIC(29, 4)
);


/* nicht ueber Wup_2 einschraenken */ INSERT INTO dbp_etl.`_vol_art_gp_wup_zu_per` (
    mandant_id, art_id,
    gp_id, wup_id, nb_id, einkaufsorganisation_id, dat, einstandspreis
)
(
    SELECT
        a.mandant_id,
        a.art_id,
        a.gp_id,
        a.wup_id,
        a.nb_id,
        a.einkaufsorganisation_id,
        D.dat_buch,
        a.einstandspreis
    FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            A.gp_id,
            A.einkaufsorganisation_id,
            A.dat_von,
            A.dat_bis,
            A.wrg_id,
            CAST(A.einstandspreis AS NUMERIC) AS einstandspreis
        FROM dbp_data.art_gp_wup_zu_per_2 AS A
        INNER JOIN dbp_etl.kmo_mkpfmseg_dat_min_2 AS M ON A.dat_bis >= M.dat_buch
        WHERE
            A.mandant_id > 1
            AND (
                A.mandant_id, A.art_id) IN (
                SELECT (mandant_id, art_id)
                FROM dbp_etl.kmo_mseg_art_gp_wup_zu_2
            )
    ) AS a
    INNER JOIN
        dbp_etl.kmo_mkpfmseg_dat_2 AS D
        ON D.dat_buch BETWEEN a.dat_von AND a.dat_bis
);


INSERT INTO dbp_etl.kmo_mkpfmseg_anr_2 (
    mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj, dat_buch,
    gp_id_zl, einkaufsorganisation_id, bq_findung_id, betrag_einstandspreis
)
(SELECT
    mandant_id,
    lagerbew_beleg_id,
    lagerbew_beleg_pos_id,
    kj,
    dat_buch,
    gp_id_zl,
    einkaufsorganisation_id,
    bq_findung_id_,
    einstandspreis_
FROM (
    SELECT
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.lagerbew_beleg_pos_id,
        A.kj,
        X.einkaufsorganisation_id,
        A.dat_buch,
        CASE
            WHEN X.bq_findung_id = 25
                THEN 0
            ELSE
                ROUND(
                    CAST(
                        A.menge_lagerbew_bme
                        * COALESCE(
                            AGW.einstandspreis, AGWW.einstandspreis
                        ) AS NUMERIC
                    ),
                    4
                )
        END AS einstandspreis_,
        X.gp_id AS gp_id_zl,
        X.bq_findung_id + CASE
            WHEN X.bezugsweg_id = 1 AND X.bq_findung_id NOT IN (25, 26, 27)
                THEN 12
            ELSE 0
        END AS bq_findung_id_
    FROM dbp_data.lagerbew_det_delta_2 AS A
    INNER JOIN dbp_etl.kmo_mkpfmseg_dat_2 AS D ON A.dat_buch = D.dat_buch
    INNER JOIN dbp_etl.kmo_mseg_art_gp_wup_zu_2 AS Z
        ON
            A.mandant_id = Z.mandant_id AND A.lagerbew_beleg_id
            = Z.lagerbew_beleg_id
            AND A.lagerbew_beleg_pos_id = Z.lagerbew_beleg_pos_id
            AND A.kj = Z.kj
            AND A.dat_buch = Z
            .dat_buch
    INNER JOIN dbp_data.art_gp_nm_zu_per_2 AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id
            AND A.wup_id = X.wup_id AND A.dat_buch BETWEEN X.dat_von AND X.dat_bis
    -- Ermittlung betriebsspezifischer ZEKP_2 Satz mit VZ

    LEFT JOIN dbp_etl.`_vol_art_gp_wup_zu_per` AS AGW
        ON
            A.mandant_id = AGW.mandant_id AND Z.wup_id = AGW
            .wup_id /* hier Zugriff mit VZ aus BQ Findung!! */
            AND Z.nb_id = AGW.nb_id
            AND A.art_id = AGW.art_id
            AND X.gp_id
            = AGW.gp_id
            AND X.einkaufsorganisation_id = AGW.einkaufsorganisation_id
            AND A.dat_buch = AGW.dat
    -- Betrieb = blank wenn beim ersten Zugriff nichts gefunden wird.

    LEFT JOIN dbp_etl.`_vol_art_gp_wup_zu_per` AS AGWW
        ON
            A.mandant_id = AGWW.mandant_id AND AGWW.wup_id
            = -1 /* Betrieb = 'blank' */
            AND A.art_id = AGWW.art_id
            AND X.gp_id = AGWW.gp_id
            AND X.einkaufsorganisation_id
            = AGWW.einkaufsorganisation_id AND A.dat_buch = AGWW.dat
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.lagerbew_beleg_pos_id,
        A.kj,
        X.einkaufsorganisation_id,
        A.dat_buch,
        einstandspreis_,
        gp_id_zl,
        bq_findung_id_
) AS a);


UPDATE dbp_data.lagerbew_det_delta_2 SET
    gp_id_zl = a.gp_id_zl,
    einkaufsorganisation_id = a.einkaufsorganisation_id,
    bq_findung_id = a.bq_findung_id,
    betrag_einstandspreis
    = COALESCE(a.betrag_lagerbew, lagerbew_det_delta.betrag_lagerbew)
FROM (
    SELECT
        mandant_id,
        lagerbew_beleg_id,
        lagerbew_beleg_pos_id,
        kj,
        dat_buch,
        MAX(gp_id_zl) AS gp_id_zl,
        MAX(einkaufsorganisation_id) AS einkaufsorganisation_id,
        MAX(bq_findung_id) AS bq_findung_id,
        MAX(betrag_einstandspreis) AS betrag_lagerbew
    FROM dbp_etl.kmo_mkpfmseg_anr_2
    GROUP BY
        mandant_id,
        lagerbew_beleg_id,
        lagerbew_beleg_pos_id,
        kj,
        dat_buch
) AS a
WHERE
    lagerbew_det_delta.mandant_id = a.mandant_id
    AND lagerbew_det_delta.lagerbew_beleg_id = a.lagerbew_beleg_id
    AND lagerbew_det_delta.lagerbew_beleg_pos_id = a.lagerbew_beleg_pos_id AND lagerbew_det_delta.kj = a.kj
    AND lagerbew_det_delta.dat_buch = a.dat_buch;


DROP TABLE IF EXISTS dbp_etl.`_vol_art_gp_wup_zu_per`;


DROP TABLE IF EXISTS dbp_etl.kmo_mkpfmseg_dat_2;


DROP TABLE IF EXISTS dbp_etl.kmo_mkpfmseg_dat_min_2;


DROP TABLE IF EXISTS dbp_etl.kmo_mkpfmseg_anr_2;


TRUNCATE TABLE dbp_etl.kmo_mseg_art_gp_wup_zu_2;
