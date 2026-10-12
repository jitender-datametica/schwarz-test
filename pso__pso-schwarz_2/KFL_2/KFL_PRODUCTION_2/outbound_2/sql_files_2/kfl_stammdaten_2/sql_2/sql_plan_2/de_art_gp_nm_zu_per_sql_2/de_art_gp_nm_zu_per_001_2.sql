CREATE OR REPLACE TEMPORARY TABLE _zwischen_tabelle (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    art_id INTEGER,
    dat DATE,
    bezugsweg_id INTEGER,
    anz_ek_infosatz INTEGER,
    anz_ek_orderbuch INTEGER,
    bq_gp_id INTEGER,
    bq_ekorg INTEGER,
    bq_findung_id INTEGER,
    regel_gp_id INTEGER,
    regel_ekorg INTEGER,
    ref_wup_id INTEGER,
    ref_nb_id INTEGER,
    wg_id INTEGER,
    kreistyp_gruppe_id STRING(4)
);


CREATE OR REPLACE TEMPORARY TABLE _kmo_art_gp_wup_zu_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    bezugsweg_id INTEGER,
    anz_ek_infosatz INTEGER,
    anz_ek_orderbuch INTEGER,
    bq_gp_id INTEGER,
    bq_ekorg INTEGER,
    bq_findung_id INTEGER,
    regel_gp_id INTEGER,
    regel_ekorg INTEGER,
    ref_wup_id INTEGER,
    ref_nb_id INTEGER,
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER
);


CREATE OR REPLACE TEMPORARY TABLE _kmo_art_gp_wup_zu_3 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    bezugsweg_id INTEGER,
    anz_ek_infosatz INTEGER,
    anz_ek_orderbuch INTEGER,
    bq_gp_id INTEGER,
    bq_ekorg INTEGER,
    bq_findung_id INTEGER,
    regel_gp_id INTEGER,
    regel_ekorg INTEGER,
    ref_wup_id INTEGER,
    ref_nb_id INTEGER,
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER
) CLUSTER BY mandant_id, dat, art_id, wup_id;


CREATE OR REPLACE TEMPORARY TABLE _art_gp_wup_zu_per AS
SELECT
    mandant_id,
    art_id,
    gp_id,
    wup_id,
    nb_id,
    einkaufsorganisation_id,
    dat_von,
    dat_bis
FROM dbp_data.art_gp_wup_zu_per_2
WHERE dat_bis >= (
    SELECT dat_relevant
    FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
)
AND mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _vz_wg_wup_zu_per AS
SELECT
    V.mandant_id,
    V.arthiertyp_id,
    V.wg_hierarchie_ebene_id,
    V.wg_hierarchie_id,
    V.wup_id,
    V.nb_id,
    V.vz_wup_id,
    D.dat_relevant AS dat,
    V.vz_prio_id,
    COALESCE(V.kreistyp_id, '') AS kreistyp_id,
    COALESCE(K.vz_prio_id, V.vz_prio_id) AS zek_kreis_vz_prio_id
FROM dbp_data.vz_wg_wup_zu_per_2 AS V
INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D ON D.dat_relevant BETWEEN V.dat_von AND V.dat_bis
LEFT JOIN dbp_data.l_kreistyp_2 AS K ON V.mandant_id = K.mandant_id AND V.kreistyp_id = K.kreistyp_id
WHERE CASE
    WHEN V.mandant_id = 3 AND V.kreistyp_id = 'Z'
        THEN 0
    ELSE 1
END = 1
AND V.mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _kmo_art_gp_wup_oh_bzw (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    bezugsweg_id INTEGER,
    anz_ek_infosatz INTEGER,
    anz_ek_orderbuch INTEGER,
    bq_gp_id INTEGER,
    bq_ekorg INTEGER,
    bq_findung_id INTEGER,
    regel_gp_id INTEGER,
    regel_ekorg INTEGER,
    ref_wup_id INTEGER,
    ref_nb_id INTEGER,
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER
);


CREATE OR REPLACE TEMPORARY TABLE _art_gp_nm_zu_per_tmp (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    gp_id INTEGER NOT NULL,
    einkaufsorganisation_id INTEGER NOT NULL,
    dat_bis DATE NOT NULL,
    bq_findung_id INTEGER,
    vz_wup_id INTEGER,
    bezugsweg_id INTEGER
);


CREATE OR REPLACE TEMPORARY TABLE _art_gp_nm_zu_per_tmp2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    gp_id INTEGER NOT NULL,
    einkaufsorganisation_id INTEGER NOT NULL,
    dat_bis DATE NOT NULL,
    bq_findung_id INTEGER,
    vz_wup_id INTEGER,
    bezugsweg_id INTEGER
);


CREATE OR REPLACE TEMPORARY TABLE _kmo_art_gp_wup_zu_3x (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    bezugsweg_id INTEGER,
    anz_ek_infosatz INTEGER,
    anz_ek_orderbuch INTEGER,
    bq_gp_id INTEGER,
    bq_ekorg INTEGER,
    bq_findung_id INTEGER,
    regel_gp_id INTEGER,
    regel_ekorg INTEGER,
    ref_wup_id INTEGER,
    ref_nb_id INTEGER,
    kreistyp_gruppe_id STRING(4),
    wg_id INTEGER
);


INSERT INTO `_zwischen_tabelle`
(
    SELECT
        b.mandant_id,
        b.wup_id,
        b.nb_id,
        a.art_id,
        X.dat_relevant AS dat,
        COALESCE(D.bezugsweg_id, 0) AS bezugsweg_id,
        0 AS anz_ek_infosatz,
        0 AS anz_ek_orderbuch,
        0 AS bq_gp_id,
        0 AS bq_ekorg,
        0 AS bq_findung_id,
        0 AS regel_gp_id,
        0 AS regel_ekorg,
        0 AS ref_wup_id,
        0 AS ref_nb_id,
        COALESCE(c.wg_id, 0) AS wg_id,
        COALESCE(b.kreistyp_gruppe_id, '') AS kreistyp_gruppe_id
    FROM (((((
        SELECT
            mandant_id,
            art_id
        FROM dbp_data.artbew_2
        WHERE
            mandant_id = 1
            AND dat >= (
                SELECT MIN(dat)
                FROM dbp_data.tag_2
                WHERE akt_kj = -1
            )
            AND art_id > 0
        GROUP BY
            mandant_id,
            art_id
        UNION DISTINCT
        SELECT
            mandant_id,
            art_id
        FROM dbp_data.lagerbew_det_2
        WHERE
            mandant_id = 1
            AND dat_buch >= (
                SELECT MIN(dat)
                FROM dbp_data.tag_2
                WHERE akt_kj = -1
            )
            AND art_id > 0
        GROUP BY
            mandant_id,
            art_id
    )
    UNION DISTINCT
    SELECT
        mandant_id,
        art_id
    FROM dbp_data.art_gp_nm_zu_per_2
    WHERE
        mandant_id = 1
        AND art_id > 0
    GROUP BY
        mandant_id,
        art_id
    )
    UNION DISTINCT
    SELECT
        mandant_id,
        art_id
    FROM dbp_data.besch_best_det_2
    WHERE
        mandant_id = 1
        AND art_id > 0
        AND dat_best_beleg >= (
            SELECT MIN(dat)
            FROM dbp_data.tag_2
            WHERE akt_kj = -1
        )
    GROUP BY
        mandant_id,
        art_id
    )
    UNION DISTINCT
    SELECT
        mandant_id,
        art_id
    FROM dbp_data.ek_orderbuch_2
    WHERE mandant_id = 1
    GROUP BY
        art_id,
        mandant_id
    )
    UNION DISTINCT
    SELECT
        mandant_id,
        art_id
    FROM dbp_data.art_list_wup_zu_per_2
    WHERE
        mandant_id = 1
        AND dat_bis >= (
            SELECT MIN(dat)
            FROM dbp_data.tag_2
            WHERE akt_gj = 0
        )
    GROUP BY
        art_id,
        mandant_id
    ) AS a
    INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS X ON TRUE
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            nb_id,
            kreistyp_gruppe_id
        FROM dbp_data.wup_2
        WHERE
            nb_id = 0
            AND mandant_id = 1
        GROUP BY
            wup_id,
            nb_id,
            mandant_id,
            kreistyp_gruppe_id
        UNION DISTINCT
        SELECT
            mandant_id,
            wup_id,
            nb_id,
            kreistyp_gruppe_id
        FROM dbp_data.wup_2
        WHERE
            nb_id = -111
            AND mandant_id = 1
        GROUP BY
            wup_id,
            nb_id,
            mandant_id,
            kreistyp_gruppe_id
    ) AS b ON a.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT *
        FROM dbp_data.art_wg_zu_per_2
        WHERE
            mandant_id = 1
            AND (
                SELECT dat_relevant
                FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
            ) BETWEEN dat_von AND dat_bis
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.art_id = c.art_id AND c.arthiertyp_id = 2 AND c.dat_bis = DATE '9999-12-31'
    LEFT JOIN (
        dbp_data.art_wup_status_per_2 AS D LEFT JOIN (
            SELECT dat_relevant AS `A11860`
            FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
        ) AS t31
            ON TRUE
    )
        ON
            a.mandant_id = D.mandant_id AND a.art_id
            = D.art_id AND b.wup_id = D.wup_id AND t31.`A11860` BETWEEN D.dat_von AND D.dat_bis
);


CREATE OR REPLACE TEMPORARY TABLE _kmo_ek_infosatz AS
SELECT
    E.mandant_id,
    E.art_id,
    D.dat_relevant AS dat,
    CASE
        WHEN EK.nb_id IN (-111, 99)
            THEN 0
        ELSE EK.wup_id
    END AS wup_id,
    CASE
        WHEN EK.nb_id IN (-111, 99)
            THEN 0
        ELSE EK.nb_id
    END AS nb_id,
    COUNT(E.mandant_id) AS anz_ek_infosatz,
    MAX(E.gp_id) AS bq_gp_id,
    MAX(E.einkaufsorganisation_id) AS bq_ekorg,
    MAX(CASE
        WHEN E.regel_gp_fg = 1
            THEN E.gp_id
        ELSE 0
    END) AS regel_gp_id,
    MAX(CASE
        WHEN E.regel_gp_fg = 1
            THEN E.einkaufsorganisation_id
        ELSE 0
    END) AS regel_ekorg,
    1 AS ek_infosatz_art,
    CAST(NULL AS BIGNUMERIC) AS ek_infosatz_id,
    DATE(NULL) AS dat_erstellung
FROM dbp_data.ek_infosatz_2 AS E
INNER JOIN dbp_data.ek_infosatz_wup_zu_2 AS EK ON E.mandant_id = EK.mandant_id AND E.ek_infosatz_id = EK.ek_infosatz_id

INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D
    ON
        D.dat_relevant BETWEEN E.dat_von AND E.dat_bis
        AND E.dat_erstellung <= D.dat_relevant
WHERE
    EK.loesch_fg = 0
    AND E.mandant_id = 1
    AND E.loesch_fg = 0
    AND (
        E.art_id, D.dat_relevant) IN (
        SELECT (art_id, dat)
        FROM `_zwischen_tabelle`
    )
GROUP BY
    E.mandant_id,
    E.art_id,
    dat,
    wup_id,
    nb_id,
    ek_infosatz_art;


INSERT INTO `_kmo_ek_infosatz` (
    mandant_id, art_id, dat, wup_id, nb_id, anz_ek_infosatz, bq_gp_id, bq_ekorg, regel_gp_id,
    regel_ekorg, ek_infosatz_art, ek_infosatz_id, dat_erstellung
)
(
    SELECT DISTINCT
        E.mandant_id,
        E.art_id,
        D.dat_relevant AS dat,
        CASE
            WHEN EK.nb_id IN (-111, 99)
                THEN 0
            ELSE EK.wup_id
        END AS wup_id,
        CASE
            WHEN EK.nb_id IN (-111, 99)
                THEN 0
            ELSE EK.nb_id
        END AS nb_id,
        1 AS anz_ek_infosatz,
        E.gp_id AS bq_gp_id,
        E.einkaufsorganisation_id AS bq_ekorg,
        0 AS regel_gp_id,
        0 AS regel_ekorg,
        2 AS ek_infosatz_art,
        E.ek_infosatz_id,
        E.dat_erstellung
    FROM dbp_data.ek_infosatz_2 AS E
    INNER JOIN dbp_data.ek_infosatz_wup_zu_2 AS EK ON E.mandant_id = EK.mandant_id AND E.ek_infosatz_id = EK.ek_infosatz_id
    INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D
        ON E.dat_erstellung <= D.dat_relevant AND (
            E.loesch_fg
            = 1 OR EK.loesch_fg = 1 OR E.dat_von > D.dat_relevant OR E.dat_bis < D.dat_relevant
        )
    WHERE
        E.mandant_id = 1
        AND (
            E.art_id, D.dat_relevant) IN (
            SELECT (art_id, dat)
            FROM `_zwischen_tabelle`
        )
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY
            E.mandant_id, E.art_id, EK.wup_id, EK.nb_id ORDER BY
            E.ek_infosatz_id IS NULL
            DESC, E.ek_infosatz_id DESC, E.dat_erstellung IS NULL DESC, E.dat_erstellung DESC
    )) = 1
);


INSERT INTO `_kmo_ek_infosatz` (
    mandant_id, art_id, dat, wup_id, nb_id, anz_ek_infosatz, bq_gp_id, bq_ekorg, regel_gp_id,
    regel_ekorg, ek_infosatz_art, ek_infosatz_id, dat_erstellung
)
(
    SELECT DISTINCT
        E.mandant_id,
        E.art_id,
        D.dat_relevant AS dat,
        CASE
            WHEN EK.nb_id IN (-111, 99)
                THEN 0
            ELSE EK.wup_id
        END AS wup_id,
        CASE
            WHEN EK.nb_id IN (-111, 99)
                THEN 0
            ELSE EK.nb_id
        END AS nb_id,
        1 AS anz_ek_infosatz,
        E.gp_id AS bq_gp_id,
        E.einkaufsorganisation_id AS bq_ekorg,
        0 AS regel_gp_id,
        0 AS regel_ekorg,
        3 AS ek_infosatz_art,
        E.ek_infosatz_id,
        E.dat_erstellung
    FROM dbp_data.ek_infosatz_2 AS E
    INNER JOIN dbp_data.ek_infosatz_wup_zu_2 AS EK ON E.mandant_id = EK.mandant_id AND E.ek_infosatz_id = EK.ek_infosatz_id
    INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D
        ON
            D.dat_relevant BETWEEN E.dat_von AND E.dat_bis
            AND E.dat_erstellung <= D.dat_relevant
    WHERE
        E.mandant_id = 1
        AND E.loesch_fg = 0
        AND EK.loesch_fg = 0
        AND (
            E.art_id, D.dat_relevant) IN (
            SELECT (art_id, dat)
            FROM `_zwischen_tabelle`
        )
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY E.mandant_id, E.art_id, dat, EK.wup_id, EK.nb_id, E.gp_id, E.einkaufsorganisation_id
        ORDER BY
            E.ek_infosatz_id IS NULL DESC, E.ek_infosatz_id DESC, E.dat_erstellung IS NULL DESC, E.dat_erstellung
            DESC
    )) = 1
);


CREATE OR REPLACE TEMPORARY TABLE _kmo_art_kreistyp_gruppe AS
SELECT
    A.art_id,
    A.mandant_id,
    A.kreistyp_id,
    TRIM(A.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    D.dat_relevant AS dat,
    K.vz_prio_id
FROM dbp_data.art_kreistyp_gruppe_zu_per_2 AS A
INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D ON D.dat_relevant BETWEEN A.dat_von AND A.dat_bis
LEFT JOIN dbp_data.l_kreistyp_2 AS K ON A.mandant_id = K.mandant_id AND A.kreistyp_id = K.kreistyp_id
WHERE
    A.kreistyp_id <> 'Z'
    AND A.mandant_id = 1;


UPDATE `_zwischen_tabelle` SET
    bezugsweg_id = 4
WHERE nb_id = -111 AND bezugsweg_id NOT IN (1, 4);


MERGE INTO `_zwischen_tabelle` AS A
USING (
    SELECT
        A0.mandant_id,
        A0.art_id,
        A0.wup_id,
        D.dat_relevant AS dat,
        MIN(ROUND(CAST(A0.bezugsquelle_kz AS BIGNUMERIC), 0)) AS bezugsweg_id_
    FROM dbp_data.art_wup_ordersatz_2 AS A0
    INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D ON D.dat_relevant BETWEEN A0.dat_von AND A0.dat_bis

    WHERE (
        A0.mandant_id, A0.wup_id, A0.art_id) IN (
        SELECT (mandant_id, wup_id, art_id)
        FROM `_zwischen_tabelle`
        WHERE bezugsweg_id NOT IN (1, 4)
    )
    AND A0.mandant_id = 1
    AND A0.bezugsquelle_kz IN ('1', '4')
    GROUP BY
        A0.mandant_id,
        A0.art_id,
        A0.wup_id,
        dat
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.dat = b.dat AND A.bezugsweg_id
        NOT IN (1, 4)
WHEN MATCHED THEN UPDATE SET
    bezugsweg_id = CAST(b.bezugsweg_id_ AS INTEGER);


MERGE INTO `_zwischen_tabelle` AS A
USING (
    SELECT
        aws.mandant_id,
        aws.art_id,
        X.dat_relevant AS dat,
        aws.bezugsweg_id AS bezugsweg_id_,
        count(*) AS anzahl --PE-Review
    FROM (
        SELECT
            A0.mandant_id,
            A0.art_id,
            A0.dat_von,
            A0.dat_bis,
            A0.bezugsweg_id
        FROM dbp_data.art_wup_status_per_2 AS A0
        INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D ON TRUE
        WHERE
            A0.art_id IN (
                SELECT art_id
                FROM `_zwischen_tabelle`
                WHERE bezugsweg_id NOT IN (1, 4)
            )
            AND A0.mandant_id = 1
            AND A0.bezugsweg_id IN (1, 4)
            AND A0.dat_bis >= D.dat_relevant
    ) AS aws
    INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS X ON TRUE
    WHERE X.dat_relevant BETWEEN aws.dat_von AND aws.dat_bis
    GROUP BY
        aws.mandant_id,
        aws.art_id,
        dat,
        aws.bezugsweg_id
    QUALIFY (
        ROW_NUMBER()
            OVER (PARTITION BY aws.mandant_id, aws.art_id, dat, dat ORDER BY anzahl IS NULL DESC, anzahl DESC
            )
    ) = 1
) AS b
    ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.dat = b.dat AND A.bezugsweg_id NOT IN (1, 4)
WHEN MATCHED THEN UPDATE SET
    bezugsweg_id = b.bezugsweg_id_;


INSERT INTO `_kmo_art_gp_wup_oh_bzw`
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat,
    bezugsweg_id,
    anz_ek_infosatz,
    anz_ek_orderbuch,
    0 AS bq_gp_id,
    0 AS bq_ekorg,
    0 AS bq_findung_id,
    regel_gp_id,
    regel_ekorg,
    ref_wup_id,
    ref_nb_id,
    kreistyp_gruppe_id,
    wg_id
FROM `_zwischen_tabelle`
WHERE bezugsweg_id NOT IN (1, 4));


DELETE FROM `_zwischen_tabelle`
WHERE bezugsweg_id NOT IN (1, 4);


INSERT INTO `_kmo_art_gp_wup_zu_2`
(SELECT
    t1.mandant_id,
    t1.art_id,
    t1.wup_id,
    t1.nb_id,
    t1.dat,
    t1.bezugsweg_id,
    0 AS anz_ek_infosatz,
    0 AS anz_ek_orderbuch,
    0 AS bq_gp_id,
    0 AS bq_ekorg,
    0 AS bq_findung_id,
    0 AS regel_gp_id,
    0 AS regel_ekorg,
    t1.vz_wup_id_ AS ref_wup_id,
    -111 AS ref_nb_id,
    t1.kreistyp_gruppe_id,
    t1.wg_id
FROM (
    SELECT
        AGW.mandant_id,
        AGW.art_id,
        AGW.wup_id,
        AGW.nb_id,
        AGW.dat,
        AGW.kreistyp_gruppe_id,
        COALESCE(AK.kreistyp_id, AKK.kreistyp_id) AS kreistyp_id_,
        CASE
            WHEN TRIM(AGW.kreistyp_gruppe_id) = ''
                THEN -1
            ELSE COALESCE(AK.vz_prio_id, AKK.vz_prio_id, -1)
        END AS vz_prio_id_,
        COALESCE(WWWG.vz_wup_id, WWUP.vz_wup_id, VZWG.vz_wup_id, VZWUP.vz_wup_id) AS vz_wup_id_,
        -111 AS vz_nb_id_,
        AGW.bezugsweg_id,
        AGW.wg_id,
        WWWG.zek_kreis_vz_prio_id,
        WWUP.zek_kreis_vz_prio_id AS zek_kreis_vz_prio_id0,
        VZWG.zek_kreis_vz_prio_id AS zek_kreis_vz_prio_id1,
        VZWUP.zek_kreis_vz_prio_id AS zek_kreis_vz_prio_id2,
        VZWG.vz_prio_id,
        VZWUP.vz_prio_id AS vz_prio_id0
    FROM `_zwischen_tabelle` AS AGW
    LEFT JOIN `_kmo_art_kreistyp_gruppe` AS AK
        ON
            AGW.mandant_id = AK.mandant_id AND AGW.art_id = AK.art_id AND AGW.kreistyp_gruppe_id
            = AK.kreistyp_gruppe_id AND AGW.dat = AK.dat
    LEFT JOIN `_kmo_art_kreistyp_gruppe` AS AKK ON AGW.mandant_id = AKK.mandant_id AND AGW.art_id = AKK.art_id AND TRIM(AKK.kreistyp_gruppe_id) = '' AND AGW.dat = AKK.dat
    LEFT JOIN `_vz_wg_wup_zu_per` AS WWWG
        ON
            AGW.mandant_id = WWWG.mandant_id AND AGW.wup_id = WWWG.wup_id AND AGW.nb_id
            = WWWG.nb_id AND AGW.wg_id = WWWG.wg_hierarchie_id AND WWWG.arthiertyp_id = 6 AND WWWG.wg_hierarchie_ebene_id
            = 5 AND WWWG.kreistyp_id = COALESCE(AK.kreistyp_id, AKK.kreistyp_id) AND AGW.dat = WWWG.dat
    LEFT JOIN `_vz_wg_wup_zu_per` AS WWUP
        ON
            AGW.mandant_id = WWUP.mandant_id AND AGW.wup_id = WWUP.wup_id AND AGW.nb_id
            = WWUP.nb_id AND WWUP.kreistyp_id = COALESCE(AK.kreistyp_id, AKK.kreistyp_id) AND WWUP.wg_hierarchie_id = -1
            AND AGW.dat = WWUP.dat
    LEFT JOIN `_vz_wg_wup_zu_per` AS VZWG
        ON
            AGW.mandant_id = VZWG.mandant_id AND AGW.wup_id = VZWG.wup_id AND AGW.nb_id
            = VZWG.nb_id AND AGW.wg_id = VZWG.wg_hierarchie_id AND VZWG.arthiertyp_id = 6 AND VZWG.wg_hierarchie_ebene_id
            = 5 AND VZWG.zek_kreis_vz_prio_id > CASE
                WHEN TRIM(AGW.kreistyp_gruppe_id) = ''
                    THEN -1
                ELSE COALESCE(AK.vz_prio_id, AKK.vz_prio_id, -1)
            END AND AGW.dat = VZWG.dat
    LEFT JOIN `_vz_wg_wup_zu_per` AS VZWUP
        ON
            AGW.mandant_id = VZWUP.mandant_id AND AGW.wup_id = VZWUP.wup_id AND AGW.nb_id
            = VZWUP.nb_id AND VZWUP.zek_kreis_vz_prio_id > CASE
                WHEN TRIM(AGW.kreistyp_gruppe_id) = ''
                    THEN -1
                ELSE COALESCE(AK.vz_prio_id, AKK.vz_prio_id, -1)
            END AND VZWUP.wg_hierarchie_id = -1 AND AGW.dat = VZWUP.dat
    WHERE
        AGW.bezugsweg_id = 4
        AND AGW.mandant_id = 1
        AND AGW.nb_id <> -111
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY AGW.mandant_id, AGW.art_id, AGW.wup_id, AGW.nb_id, AGW.dat ORDER BY COALESCE(
        WWWG.zek_kreis_vz_prio_id, zek_kreis_vz_prio_id0) IS NULL, COALESCE(WWWG.zek_kreis_vz_prio_id,
    zek_kreis_vz_prio_id0), COALESCE(zek_kreis_vz_prio_id1, zek_kreis_vz_prio_id2) IS NULL, COALESCE(zek_kreis_vz_prio_id1,
    zek_kreis_vz_prio_id2), COALESCE(VZWG.vz_prio_id, vz_prio_id0) IS NULL, COALESCE(
        VZWG.vz_prio_id,
        vz_prio_id0
    ))) = 1
) AS t1_2);


INSERT INTO `_kmo_art_gp_wup_zu_2`
(
    SELECT
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        dat,
        bezugsweg_id,
        anz_ek_infosatz,
        anz_ek_orderbuch,
        0 AS bq_gp_id,
        0 AS bq_ekorg,
        bq_findung_id,
        regel_gp_id,
        regel_ekorg,
        wup_id AS ref_wup_id,
        nb_id AS ref_nb_id,
        kreistyp_gruppe_id,
        wg_id
    FROM `_zwischen_tabelle`
    WHERE
        bezugsweg_id = 1
        OR nb_id = -111
);


TRUNCATE TABLE `_kmo_art_gp_wup_zu_3`;--PE-Review


INSERT INTO `_kmo_art_gp_wup_zu_3`
(
    SELECT
        AGW.mandant_id,
        AGW.art_id,
        AGW.wup_id,
        AGW.nb_id,
        AGW.dat,
        AGW.bezugsweg_id,
        COALESCE(E.anz_ek_infosatz, EO.anz_ek_infosatz, EK.anz_ek_infosatz, EKK.anz_ek_infosatz, 0) AS anz_ek_infosatz_,
        AGW.anz_ek_orderbuch,
        CASE
            WHEN COALESCE(E.anz_ek_infosatz, EO.anz_ek_infosatz, EK.anz_ek_infosatz, EKK.anz_ek_infosatz, 0) = 1
                THEN COALESCE(E.bq_gp_id, EO.bq_gp_id, EK.bq_gp_id, EKK.bq_gp_id, 0)
            ELSE 0
        END AS bq_gp_id_,
        CASE
            WHEN COALESCE(E.anz_ek_infosatz, EO.anz_ek_infosatz, EK.anz_ek_infosatz, EKK.anz_ek_infosatz, 0) = 1
                THEN COALESCE(E.bq_ekorg, EO.bq_ekorg, EK.bq_ekorg, EKK.bq_ekorg, 0)
            ELSE 0
        END AS bq_ekorg_,
        CASE
            WHEN COALESCE(E.anz_ek_infosatz, EO.anz_ek_infosatz, EK.anz_ek_infosatz, EKK.anz_ek_infosatz, 0) = 1
                THEN CASE
                    WHEN COALESCE(E.mandant_id, EO.mandant_id) IS NOT NULL
                        THEN 1
                    ELSE 3
                END
            ELSE 0
        END AS bq_findung_id_,
        COALESCE(E.regel_gp_id, EO.regel_gp_id, 0) AS regel_gp_id_,
        COALESCE(E.regel_ekorg, EO.regel_ekorg, 0) AS regel_ekorg_,
        COALESCE(AGW.ref_wup_id, -1) AS ref_wup_id,
        AGW.ref_nb_id,
        AGW.kreistyp_gruppe_id,
        AGW.wg_id
    FROM `_kmo_art_gp_wup_zu_2` AS AGW
    LEFT JOIN `_kmo_ek_infosatz` AS E
        ON
            AGW.mandant_id = E.mandant_id AND AGW.ref_wup_id = E.wup_id AND AGW.art_id = E.art_id
            AND AGW.dat = E.dat AND E.ek_infosatz_art = 1
    LEFT JOIN `_kmo_ek_infosatz` AS EO
        ON
            AGW.mandant_id = EO.mandant_id AND EO.wup_id = 0 AND AGW.art_id = EO.art_id AND
            AGW.dat = EO.dat AND EO.ek_infosatz_art = 1
    LEFT JOIN `_kmo_ek_infosatz` AS EK
        ON
            AGW.mandant_id = EK.mandant_id AND AGW.ref_wup_id = EK.wup_id AND AGW.art_id =
            EK.art_id AND AGW.dat = EK.dat AND EK.ek_infosatz_art = 2
    LEFT JOIN
        `_kmo_ek_infosatz`
            AS EKK
        ON
            AGW.mandant_id = EKK.mandant_id AND EKK.wup_id = 0 AND AGW.art_id = EKK.art_id
            AND AGW.dat = EKK.dat AND EKK.ek_infosatz_art = 2
);


MERGE INTO `_kmo_art_gp_wup_zu_3` AS A
USING (
    SELECT
        AGW.mandant_id,
        AGW.art_id,
        AGW.wup_id,
        AGW.nb_id,
        AGW.dat,
        AGW.bezugsweg_id,
        COALESCE(EK.bq_gp_id, EKK.bq_gp_id) AS bq_gp_id_,
        COALESCE(EK.bq_ekorg, EKK.bq_ekorg) AS bq_ekorg_
    FROM `_kmo_art_gp_wup_zu_3` AS AGW
    LEFT JOIN `_kmo_ek_infosatz` AS EK
        ON
            AGW.mandant_id = EK.mandant_id AND AGW.ref_wup_id = EK.wup_id AND AGW.art_id =
            EK.art_id AND AGW.dat = EK.dat AND EK.ek_infosatz_art = 3 AND LENGTH(CAST(EK.bq_gp_id AS STRING)) = 4
    LEFT JOIN `_kmo_ek_infosatz` AS EKK
        ON
            AGW.mandant_id = EKK.mandant_id AND EKK.wup_id = 0 AND AGW.art_id = EKK.art_id
            AND AGW.dat = EKK.dat AND EKK.ek_infosatz_art = 3 AND LENGTH(CAST(EKK.bq_gp_id AS STRING)) = 4
    WHERE
        AGW.anz_ek_infosatz > 1
        AND (AGW.bq_findung_id = 0 OR LENGTH(CAST(AGW.bq_gp_id AS STRING)) = 4)
        AND AGW.anz_ek_orderbuch <> 1
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY AGW.mandant_id, AGW.art_id, AGW.wup_id, AGW.nb_id, AGW.dat, AGW.bezugsweg_id
        ORDER BY
            COALESCE(EK.ek_infosatz_id, EKK.ek_infosatz_id) IS NULL DESC, COALESCE(EK.ek_infosatz_id, EKK.ek_infosatz_id
            ) DESC, COALESCE(EK.dat_erstellung, EKK.dat_erstellung) IS NULL DESC, COALESCE(EK.dat_erstellung, EKK.dat_erstellung
            ) DESC
    )) = 1
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat = b.dat
        AND A.anz_ek_infosatz > 1 AND (A.bq_findung_id = 0 OR LENGTH(CAST(A.bq_gp_id AS STRING)) = 4) AND A.anz_ek_orderbuch
        <> 1 AND LENGTH(CAST(b.bq_gp_id_ AS STRING)) = 4
WHEN MATCHED THEN UPDATE SET
    bq_gp_id = CASE
        WHEN A.anz_ek_orderbuch > 1 OR A.regel_gp_id = 0
            THEN b.bq_gp_id_
        ELSE A.regel_gp_id
    END,
    bq_ekorg = CASE
        WHEN A.anz_ek_orderbuch > 1 OR A.regel_ekorg = 0
            THEN b.bq_ekorg_
        ELSE A.regel_ekorg
    END,
    bq_findung_id = CASE
        WHEN A.anz_ek_orderbuch = 0 AND A.regel_gp_id = 0
            THEN 9
        WHEN A.anz_ek_orderbuch = 0 AND A.regel_gp_id > 0
            THEN 11
        WHEN A.anz_ek_orderbuch > 0
            THEN 5
        ELSE NULL
    END;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_gp_id = b.gp_id,
    ref_wup_id = b.vz_wup_id FROM (
    SELECT *
    FROM dbp_data.ek_orderbuch_2
    WHERE
        mandant_id = 1
        AND gesperrt_fg = 0
        AND (
            SELECT dat_relevant
            FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
        ) BETWEEN dat_von AND dat_bis
        AND vz_wup_id IS NOT NULL
) AS b
WHERE
    `_kmo_art_gp_wup_zu_3`.mandant_id = b.mandant_id AND `_kmo_art_gp_wup_zu_3`.art_id = b.art_id AND
    `_kmo_art_gp_wup_zu_3`.ref_wup_id = b.wup_id AND LENGTH(CAST(`_kmo_art_gp_wup_zu_3`.bq_gp_id AS STRING)) = 4;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_gp_id = b.gp_id,
    ref_wup_id = b.vz_wup_id FROM (
    SELECT *
    FROM dbp_data.ek_orderbuch_2
    WHERE
        mandant_id = 1
        AND gesperrt_fg = 0
        AND (
            SELECT dat_relevant
            FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
        ) BETWEEN dat_von AND dat_bis
        AND vz_wup_id IS NOT NULL
) AS b
WHERE
    `_kmo_art_gp_wup_zu_3`.mandant_id = b.mandant_id AND `_kmo_art_gp_wup_zu_3`.art_id = b.art_id AND
    `_kmo_art_gp_wup_zu_3`.wup_id = b.wup_id AND LENGTH(CAST(`_kmo_art_gp_wup_zu_3`.bq_gp_id AS STRING)) = 4;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_gp_id = b.gp_id FROM (
    SELECT *
    FROM dbp_data.ek_orderbuch_2
    WHERE
        mandant_id = 1
        AND gesperrt_fg = 0
        AND (
            SELECT dat_relevant
            FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
        ) BETWEEN dat_von AND dat_bis
) AS b
WHERE
    `_kmo_art_gp_wup_zu_3`.mandant_id = b.mandant_id AND `_kmo_art_gp_wup_zu_3`.art_id = b.art_id AND
    `_kmo_art_gp_wup_zu_3`.bq_gp_id = b.wup_id AND LENGTH(CAST(`_kmo_art_gp_wup_zu_3`.bq_gp_id AS STRING)) = 4;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_gp_id = 0,
    bq_findung_id = 0,
    bq_ekorg = 0
WHERE LENGTH(CAST(bq_gp_id AS STRING)) = 4;


MERGE INTO `_kmo_art_gp_wup_zu_3` AS A
USING (
    SELECT
        AGW.mandant_id,
        AGW.art_id,
        AGW.wup_id,
        AGW.nb_id,
        AGW.dat,
        COUNT(E.mandant_id) AS anz_ek_orderbuch,
        MAX(E.gp_id) AS bq_gp_id,
        MAX(E.einkaufsorganisation_id) AS bq_ekorg,
        MAX(CASE
            WHEN E.fix_gp_fg = 1
                THEN E.gp_id
            ELSE 0
        END) AS fix_gp_id,
        MAX(CASE
            WHEN E.fix_gp_fg = 1
                THEN E.einkaufsorganisation_id
            ELSE 0
        END) AS fix_ekorg
    FROM `_kmo_art_gp_wup_zu_3` AS AGW
    INNER JOIN dbp_data.ek_orderbuch_2 AS E ON AGW.mandant_id = E.mandant_id AND AGW.art_id = E.art_id AND (AGW.ref_wup_id = E.wup_id OR AGW.wup_id = E.wup_id) AND E.gesperrt_fg = 0 AND AGW.dat BETWEEN E.dat_von AND E.dat_bis

    WHERE
        AGW.anz_ek_infosatz > 1
        AND AGW.bq_findung_id = 0
    GROUP BY
        AGW.mandant_id,
        AGW.art_id,
        AGW.wup_id,
        AGW.nb_id,
        AGW.dat
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat = b.dat
        AND A.anz_ek_infosatz > 1 AND LENGTH(CAST(b.fix_gp_id AS STRING)) <> 4
WHEN MATCHED THEN UPDATE SET
    anz_ek_orderbuch = CASE
        WHEN b.fix_gp_id > 0
            THEN 1
        ELSE CAST(b.anz_ek_orderbuch AS INTEGER)
    END,
    bq_gp_id = CASE
        WHEN b.fix_gp_id > 0
            THEN b.fix_gp_id
        ELSE CASE
            WHEN b.anz_ek_orderbuch = 1
                THEN b.bq_gp_id
            ELSE 0
        END
    END,
    bq_ekorg = CASE
        WHEN b.fix_gp_id > 0
            THEN b.fix_ekorg
        ELSE CASE
            WHEN b.anz_ek_orderbuch = 1
                THEN b.bq_ekorg
            ELSE 0
        END
    END,
    bq_findung_id = CASE
        WHEN b.anz_ek_orderbuch = 1 OR b.fix_gp_id > 0
            THEN 7
        ELSE 0
    END;


MERGE INTO `_kmo_art_gp_wup_zu_3` AS A
USING (SELECT
    AGW.mandant_id,
    AGW.art_id,
    AGW.wup_id,
    AGW.nb_id,
    AGW.dat,
    COALESCE(EK.bq_gp_id, EKK.bq_gp_id) AS bq_gp_id_,
    COALESCE(EK.bq_ekorg, EKK.bq_ekorg) AS bq_ekorg_
FROM `_kmo_art_gp_wup_zu_3` AS AGW
INNER JOIN dbp_data.ek_orderbuch_2 AS E ON AGW.mandant_id = E.mandant_id AND AGW.art_id = E.art_id AND (AGW.ref_wup_id = E.wup_id OR AGW.wup_id = E.wup_id) AND E.gesperrt_fg = 0 AND AGW.dat BETWEEN E.dat_von AND E.dat_bis

    LEFT JOIN `_kmo_ek_infosatz` AS EK
        ON
            AGW.mandant_id = EK.mandant_id AND AGW.ref_wup_id = EK.wup_id AND AGW.art_id =
            EK.art_id AND E.gp_id = EK.bq_gp_id AND AGW.dat = EK.dat AND EK.ek_infosatz_art = 3
    LEFT JOIN `_kmo_ek_infosatz` AS EKK
        ON
            AGW.mandant_id = EKK.mandant_id AND EKK.wup_id = 0 AND AGW.art_id = EKK.art_id
            AND E.gp_id = EKK.bq_gp_id AND AGW.dat = EKK.dat AND EKK.ek_infosatz_art = 3
    WHERE
        AGW.anz_ek_infosatz > 1
        AND AGW.anz_ek_orderbuch > 1
        AND AGW.bq_findung_id = 0
        AND (EK.mandant_id IS NOT NULL OR EKK.mandant_id IS NOT NULL)
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY AGW.mandant_id, AGW.art_id, AGW.wup_id, AGW.nb_id, AGW.dat ORDER BY COALESCE(EK.ek_infosatz_id, EKK.ek_infosatz_id) IS NULL DESC, COALESCE(EK.ek_infosatz_id, EKK.ek_infosatz_id) DESC)) = 1)
    AS b
    ON
        A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat = b.dat
        AND A.bq_findung_id = 0
WHEN MATCHED THEN UPDATE SET
    bq_gp_id = b.bq_gp_id_,
    bq_ekorg = b.bq_ekorg_,
    bq_findung_id = 5;


MERGE INTO `_kmo_art_gp_wup_zu_3` AS A
USING (SELECT
    AGW.mandant_id,
    AGW.art_id,
    AGW.wup_id,
    AGW.nb_id,
    AGW.dat,
    COALESCE(EK.bq_gp_id, EKK.bq_gp_id) AS bq_gp_id_,
    COALESCE(EK.bq_ekorg, EKK.bq_ekorg) AS bq_ekorg_
FROM `_kmo_art_gp_wup_zu_3` AS AGW
INNER JOIN dbp_data.ek_orderbuch_2 AS E ON AGW.mandant_id = E.mandant_id AND AGW.art_id = E.art_id AND (AGW.ref_wup_id = E.wup_id OR AGW.wup_id = E.wup_id) AND E.gesperrt_fg = 0 AND AGW.dat BETWEEN E.dat_von AND E.dat_bis

    LEFT JOIN `_kmo_ek_infosatz` AS EK
        ON
            AGW.mandant_id = EK.mandant_id AND AGW.ref_wup_id = EK.wup_id AND AGW.art_id =
            EK.art_id AND E.gp_id = EK.bq_gp_id AND AGW.dat = EK.dat AND EK.ek_infosatz_art = 3
    LEFT JOIN `_kmo_ek_infosatz` AS EKK
        ON
            AGW.mandant_id = EKK.mandant_id AND EKK.wup_id = 0 AND AGW.art_id = EKK.art_id
            AND CASE
                WHEN LENGTH(CAST(E.gp_id AS STRING)) = 4
                    THEN 1
                ELSE E.gp_id
            END = CASE
                WHEN LENGTH(CAST(E.gp_id AS STRING)) = 4
                    THEN 1
                ELSE EKK.bq_gp_id
            END AND AGW.dat = EKK.dat AND EKK.ek_infosatz_art = 3
    WHERE
        AGW.anz_ek_infosatz > 1
        AND AGW.anz_ek_orderbuch = 0
        AND AGW.bq_findung_id = 0
        AND (EK.mandant_id IS NOT NULL OR EKK.mandant_id IS NOT NULL)
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY AGW.mandant_id, AGW.art_id, AGW.wup_id, AGW.nb_id, AGW.dat ORDER BY COALESCE(EK.ek_infosatz_id, EKK.ek_infosatz_id) IS NULL DESC, COALESCE(EK.ek_infosatz_id, EKK.ek_infosatz_id) DESC)) = 1)
    AS b
    ON
        A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat = b.dat
        AND A.bq_findung_id = 0
WHEN MATCHED THEN UPDATE SET
    bq_gp_id = b.bq_gp_id_,
    bq_ekorg = b.bq_ekorg_,
    bq_findung_id = 5;


INSERT INTO `_kmo_art_gp_wup_zu_3`
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat,
    bezugsweg_id,
    anz_ek_infosatz,
    anz_ek_orderbuch,
    bq_gp_id,
    bq_ekorg,
    bq_findung_id,
    regel_gp_id,
    regel_ekorg,
    COALESCE(ref_wup_id, -1) AS ref_wup_id,
    ref_nb_id,
    kreistyp_gruppe_id,
    wg_id
FROM `_kmo_art_gp_wup_oh_bzw`);


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_gp_id = G.gp_id,
    bq_ekorg = G.einkaufsorganisation_id
FROM dbp_data.gp_2 AS G
WHERE `_kmo_art_gp_wup_zu_3`.mandant_id = G.mandant_id AND `_kmo_art_gp_wup_zu_3`.bq_findung_id = 0 AND G.gp_id = -1;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_findung_id = 25
WHERE bq_findung_id = 0;


CREATE OR REPLACE TEMPORARY TABLE _make_it_distinct AS
SELECT DISTINCT *
FROM `_kmo_art_gp_wup_zu_3`;


TRUNCATE TABLE `_kmo_art_gp_wup_zu_3`; --PE-Review


INSERT INTO `_kmo_art_gp_wup_zu_3`
(
    SELECT
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        dat,
        bezugsweg_id,
        MIN(anz_ek_infosatz) AS anz_ek_infosatz,
        MIN(anz_ek_orderbuch) AS anz_ek_orderbuch,
        bq_gp_id,
        bq_ekorg,
        MIN(bq_findung_id) AS bq_findung_id,
        regel_gp_id,
        regel_ekorg,
        ref_wup_id,
        ref_nb_id,
        kreistyp_gruppe_id,
        wg_id
    FROM `_make_it_distinct`
    GROUP BY
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        dat,
        bezugsweg_id,
        bq_gp_id,
        bq_ekorg,
        regel_gp_id,
        regel_ekorg,
        ref_wup_id,
        ref_nb_id,
        kreistyp_gruppe_id,
        wg_id
);


MERGE INTO `_kmo_art_gp_wup_zu_3` AS A
USING (
    SELECT
        A0.mandant_id,
        A0.wup_id,
        A0.nb_id,
        A0.art_id,
        A0.dat,
        MIN(A0.bq_findung_id + CASE
            WHEN AGW.mandant_id IS NULL
                THEN 1
            ELSE 0
        END + CASE
            WHEN A0.bezugsweg_id = 1
                THEN 0
            ELSE 12
        END) AS bq_findung_id_
    FROM `_kmo_art_gp_wup_zu_3` AS A0
    LEFT JOIN `_art_gp_wup_zu_per` AS AGW
        ON
            A0.mandant_id = AGW.mandant_id AND A0.ref_wup_id = AGW.wup_id AND A0.art_id =
            AGW.art_id AND A0.bq_gp_id = AGW.gp_id AND A0.bq_ekorg = AGW.einkaufsorganisation_id AND A0.dat BETWEEN AGW.dat_von
            AND AGW.dat_bis
    LEFT JOIN `_art_gp_wup_zu_per` AS AGWW
        ON
            A0.mandant_id = AGWW.mandant_id AND AGWW.wup_id = -1 AND A0.art_id = AGWW.art_id
            AND A0.bq_gp_id = AGWW.gp_id AND A0.bq_ekorg = AGWW.einkaufsorganisation_id AND A0.dat BETWEEN AGWW.dat_von AND
            AGWW.dat_bis
    WHERE A0.bq_findung_id <> 25
    GROUP BY
        A0.mandant_id,
        A0.wup_id,
        A0.nb_id,
        A0.art_id,
        A0.dat
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.art_id = b.art_id AND A.dat = b.dat AND A.bq_findung_id <>
        25
WHEN MATCHED THEN UPDATE SET
    bq_findung_id = b.bq_findung_id_;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_findung_id = 27 FROM (
    SELECT
        EIN.mandant_id,
        EIN.art_id,
        A.dat_relevant AS dat,
        EIN.ek_faktor AS zwgs,
        COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
        COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
    FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS A
    INNER JOIN dbp_data.art_man_spanne_per_2 AS EIN
        ON
            EIN.konditionsart_id = 'ZWGS' AND EIN.loesch_fg = 0
            AND A.dat_relevant BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_man_spanne_per_2 AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.art_id = MEP.art_id
            AND MEP.konditionsart_id = 'ZWGM' AND MEP.loesch_fg = 0 AND A.dat_relevant BETWEEN MEP.dat_von AND MEP.dat_bis
    LEFT JOIN dbp_data.art_man_spanne_per_2 AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.art_id =
            EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' AND EKBNK.loesch_fg = 0 AND A.dat_relevant BETWEEN EKBNK.dat_von
            AND EKBNK.dat_bis
    WHERE EIN.mandant_id = 1
) AS b
WHERE
    `_kmo_art_gp_wup_zu_3`.mandant_id = b.mandant_id AND `_kmo_art_gp_wup_zu_3`.art_id = b.art_id AND
    `_kmo_art_gp_wup_zu_3`.dat = b.dat;


MERGE INTO `_kmo_art_gp_wup_zu_3` AS A
USING (
    SELECT
        EIN.mandant_id,
        EIN.wup_id,
        EIN.art_id,
        A0.dat_relevant AS dat,
        EIN.ek_faktor AS zwgs,
        COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
        COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
    FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS A0
    INNER JOIN dbp_data.art_wup_man_spanne_per_2 AS EIN
        ON
            EIN.konditionsart_id = 'ZWGS' AND EIN.loesch_fg =
            0 AND A0.dat_relevant BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_wup_man_spanne_per_2 AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.wup_id =
            MEP.wup_id AND EIN.art_id = MEP.art_id AND MEP.konditionsart_id = 'ZWGM' AND MEP.loesch_fg = 0 AND A0.dat_relevant
            BETWEEN MEP.dat_von AND MEP.dat_bis
    LEFT JOIN dbp_data.art_wup_man_spanne_per_2 AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.wup_id
            = EKBNK.wup_id AND EIN.art_id = EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' AND EKBNK.loesch_fg = 0 AND A0.dat_relevant BETWEEN EKBNK.dat_von AND EKBNK.dat_bis
    WHERE EIN.mandant_id = 1
) AS b
    ON A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.art_id = b.art_id AND A.dat = b.dat
WHEN MATCHED THEN UPDATE SET
    bq_findung_id = 26;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_findung_id = 2,
    ref_wup_id = -1 FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id
    FROM `_kmo_art_gp_wup_zu_3` AS A
    INNER JOIN `_art_gp_wup_zu_per` AS B
        ON
            A.mandant_id = B.mandant_id AND A.ref_wup_id = B.wup_id AND A.bq_gp_id = B.gp_id
            AND A.art_id = B.art_id AND A.dat BETWEEN B.dat_von AND B.dat_bis
    LEFT JOIN (
        SELECT *
        FROM `_kmo_ek_infosatz`
        WHERE ek_infosatz_art = 1
    ) AS c
        ON A.mandant_id = c.mandant_id AND A.art_id = c.art_id AND A.ref_wup_id = c.wup_id
    WHERE
        A.anz_ek_infosatz = 1
        AND A.bq_findung_id = 1
        AND A.bezugsweg_id = 1
        AND c.wup_id IS NULL
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.wup_id
) AS b
WHERE
    `_kmo_art_gp_wup_zu_3`.mandant_id = b.mandant_id AND `_kmo_art_gp_wup_zu_3`.wup_id = b.wup_id AND
    `_kmo_art_gp_wup_zu_3`.art_id = b.art_id;


MERGE INTO `_kmo_art_gp_wup_zu_3` AS A
USING (
    SELECT
        AGW.mandant_id,
        AGW.art_id,
        AGW.wup_id,
        AGW.nb_id,
        AGW.dat,
        AGW.bezugsweg_id,
        COALESCE(EK.bq_gp_id, EKK.bq_gp_id) AS bq_gp_id_,
        COALESCE(EK.bq_ekorg, EKK.bq_ekorg) AS bq_ekorg_
    FROM `_kmo_art_gp_wup_zu_3` AS AGW
    LEFT JOIN `_kmo_ek_infosatz` AS EK
        ON
            AGW.mandant_id = EK.mandant_id AND AGW.ref_wup_id = EK.wup_id AND AGW.art_id =
            EK.art_id AND AGW.dat = EK.dat AND EK.ek_infosatz_art = 3
    LEFT JOIN `_kmo_ek_infosatz` AS EKK
        ON
            AGW.mandant_id = EKK.mandant_id AND EKK.wup_id = 0 AND AGW.art_id = EKK.art_id
            AND AGW.dat = EKK.dat AND EKK.ek_infosatz_art = 3
    WHERE
        AGW.anz_ek_infosatz > 1
        AND (AGW.bq_findung_id = 25 OR LENGTH(CAST(AGW.bq_gp_id AS STRING)) = 4)
        AND AGW.anz_ek_orderbuch <> 1
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY AGW.mandant_id, AGW.art_id, AGW.wup_id, AGW.nb_id, AGW.dat, AGW.bezugsweg_id
        ORDER BY
            COALESCE(EK.ek_infosatz_id, EKK.ek_infosatz_id) IS NULL DESC, COALESCE(EK.ek_infosatz_id, EKK.ek_infosatz_id
            ) DESC, COALESCE(EK.dat_erstellung, EKK.dat_erstellung) IS NULL DESC, COALESCE(EK.dat_erstellung, EKK.dat_erstellung
            ) DESC
    )) = 1
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat = b.dat
        AND A.anz_ek_infosatz > 1 AND (A.bq_findung_id = 25 OR LENGTH(CAST(A.bq_gp_id AS STRING)) = 4) AND A.anz_ek_orderbuch
        <> 1
WHEN MATCHED THEN UPDATE SET
    bq_gp_id = CASE
        WHEN A.anz_ek_orderbuch > 1 OR A.regel_gp_id = 0
            THEN b.bq_gp_id_
        ELSE A.regel_gp_id
    END,
    bq_ekorg = CASE
        WHEN A.anz_ek_orderbuch > 1 OR A.regel_ekorg = 0
            THEN b.bq_ekorg_
        ELSE A.regel_ekorg
    END,
    bq_findung_id = CASE
        WHEN A.anz_ek_orderbuch = 0 AND A.regel_gp_id = 0
            THEN 9
        WHEN A.anz_ek_orderbuch = 0 AND A.regel_gp_id > 0
            THEN 11
        WHEN A.anz_ek_orderbuch > 0
            THEN 5
        ELSE NULL
    END;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_gp_id = b.gp_id FROM (
    SELECT *
    FROM dbp_data.ek_orderbuch_2
    WHERE
        mandant_id = 1
        AND gesperrt_fg = 0
        AND (
            SELECT dat_relevant
            FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
        ) BETWEEN dat_von AND dat_bis
        AND vz_wup_id IS NOT NULL
) AS b
WHERE
    `_kmo_art_gp_wup_zu_3`.mandant_id = b.mandant_id AND `_kmo_art_gp_wup_zu_3`.art_id = b.art_id AND
    `_kmo_art_gp_wup_zu_3`.ref_wup_id = b.wup_id AND LENGTH(CAST(`_kmo_art_gp_wup_zu_3`.bq_gp_id AS STRING)) = 4;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_gp_id = b.gp_id FROM (
    SELECT *
    FROM dbp_data.ek_orderbuch_2
    WHERE
        mandant_id = 1
        AND gesperrt_fg = 0
        AND (
            SELECT dat_relevant
            FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
        ) BETWEEN dat_von AND dat_bis
        AND vz_wup_id IS NOT NULL
) AS b
WHERE
    `_kmo_art_gp_wup_zu_3`.mandant_id = b.mandant_id AND `_kmo_art_gp_wup_zu_3`.art_id = b.art_id AND
    `_kmo_art_gp_wup_zu_3`.wup_id = b.wup_id AND LENGTH(CAST(`_kmo_art_gp_wup_zu_3`.bq_gp_id AS STRING)) = 4;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_gp_id = b.gp_id FROM (
    SELECT *
    FROM dbp_data.ek_orderbuch_2
    WHERE
        mandant_id = 1
        AND gesperrt_fg = 0
        AND (
            SELECT dat_relevant
            FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
        ) BETWEEN dat_von AND dat_bis
) AS b
WHERE
    `_kmo_art_gp_wup_zu_3`.mandant_id = b.mandant_id AND `_kmo_art_gp_wup_zu_3`.art_id = b.art_id AND
    `_kmo_art_gp_wup_zu_3`.bq_gp_id = b.wup_id AND LENGTH(CAST(`_kmo_art_gp_wup_zu_3`.bq_gp_id AS STRING)) = 4;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    ref_wup_id = b.vz_wup_id FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        vz_wup_id
    FROM dbp_data.ek_orderbuch_2
    WHERE
        mandant_id = 1
        AND gesperrt_fg = 0
        AND (
            SELECT dat_relevant
            FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
        ) BETWEEN dat_von AND dat_bis
        AND vz_wup_id IS NOT NULL
) AS b
WHERE
    `_kmo_art_gp_wup_zu_3`.mandant_id = b.mandant_id AND `_kmo_art_gp_wup_zu_3`.art_id = b.art_id AND
    `_kmo_art_gp_wup_zu_3`.wup_id = b.wup_id;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_gp_id = b.gp_id
FROM dbp_etl_process.bq_findung_korrektur_2 AS b
WHERE
    `_kmo_art_gp_wup_zu_3`.mandant_id = b.mandant_id AND `_kmo_art_gp_wup_zu_3`.wup_id = b.wup_id AND
    `_kmo_art_gp_wup_zu_3`.art_id = b.art_id;


CREATE OR REPLACE TEMPORARY TABLE _snapshot_art_gp AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.dat_von,
    A.gp_id,
    A.einkaufsorganisation_id,
    A.dat_bis,
    A.vz_wup_id,
    A.bq_findung_id,
    A.bezugsweg_id,
    A.td_update,
    A.td_insert
FROM dbp_data.art_gp_nm_zu_per_2 AS A
INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS B ON A.dat_bis >= B.dat_relevant
WHERE A.mandant_id = 1;


INSERT INTO `_kmo_art_gp_wup_zu_3x`
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.bezugsweg_id,
        A.anz_ek_infosatz,
        A.anz_ek_orderbuch,
        A.bq_gp_id,
        A.bq_ekorg,
        A.bq_findung_id,
        A.regel_gp_id,
        A.regel_ekorg,
        A.ref_wup_id,
        A.ref_nb_id,
        A.kreistyp_gruppe_id,
        A.wg_id
    FROM `_kmo_art_gp_wup_zu_3` AS A
    INNER JOIN `_snapshot_art_gp` AS Z
        ON
            A.mandant_id = Z.mandant_id AND A.wup_id = Z.wup_id AND A.art_id = Z.art_id AND
            A.dat BETWEEN Z.dat_von AND Z.dat_bis
    WHERE
        A.bq_gp_id <> Z.gp_id
        OR A.bq_findung_id <> COALESCE(Z.bq_findung_id, -1)
        OR A.ref_wup_id <> COALESCE(Z.vz_wup_id, -1)
        OR A.bezugsweg_id <> Z.bezugsweg_id
);


INSERT INTO `_kmo_art_gp_wup_zu_3x`
(
    SELECT *
    FROM `_kmo_art_gp_wup_zu_3` AS A
    WHERE (
        mandant_id, wup_id, art_id) NOT IN (
        SELECT (mandant_id, wup_id, art_id)
        FROM `_snapshot_art_gp`
    )
);


INSERT INTO `_art_gp_nm_zu_per_tmp` (
    mandant_id, art_id, wup_id, nb_id, dat_von, gp_id, einkaufsorganisation_id, dat_bis,
    bq_findung_id, vz_wup_id, bezugsweg_id
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_von,
    gp_id,
    einkaufsorganisation_id,
    DATE('9999-12-31') AS dat_bis,
    COALESCE(bq_findung_id, -1) AS bq_findung_id,
    COALESCE(vz_wup_id, -1) AS vz_wup_id,
    bezugsweg_id
FROM dbp_data.art_gp_nm_zu_per_2
WHERE (
    mandant_id, wup_id, art_id) IN (
    SELECT (mandant_id, wup_id, art_id)
    FROM `_kmo_art_gp_wup_zu_3x`
)
AND mandant_id = 1
AND (
    mandant_id, wup_id, art_id, dat_von) NOT IN (
    SELECT (mandant_id, wup_id, art_id, dat)
    FROM `_kmo_art_gp_wup_zu_3x`
));


INSERT INTO `_art_gp_nm_zu_per_tmp` (
    mandant_id, art_id, wup_id, nb_id, dat_von, gp_id, einkaufsorganisation_id, dat_bis,
    bq_findung_id, vz_wup_id, bezugsweg_id
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat AS dat_von,
    bq_gp_id AS gp_id,
    bq_ekorg AS einkaufsorganisation_id,
    DATE('9999-12-31') AS dat_bis,
    bq_findung_id,
    ref_wup_id,
    bezugsweg_id
FROM `_kmo_art_gp_wup_zu_3x`);


INSERT INTO `_art_gp_nm_zu_per_tmp` (
    mandant_id, art_id, wup_id, nb_id, dat_von, gp_id, einkaufsorganisation_id, dat_bis,
    bq_findung_id, vz_wup_id, bezugsweg_id
)
(
    SELECT
        Z.mandant_id,
        Z.art_id,
        Z.wup_id,
        Z.nb_id,
        DATE_ADD(A.dat, INTERVAL 1 DAY) AS dat_von_,
        Z.gp_id,
        Z.einkaufsorganisation_id,
        DATE('9999-12-31') AS dat_bis_,
        COALESCE(Z.bq_findung_id, -1),
        COALESCE(Z.vz_wup_id, -1),
        Z.bezugsweg_id
    FROM `_kmo_art_gp_wup_zu_3x` AS A
    INNER JOIN dbp_data.art_gp_nm_zu_per_2 AS Z
        ON A.mandant_id = Z.mandant_id AND A.wup_id = Z.wup_id AND A.art_id = Z.art_id AND A.dat >= Z.dat_von AND A.dat < Z.dat_bis AND Z.dat_bis < DATE '9999-12-31' AND (
            A.bq_gp_id
            <> Z.gp_id OR A.bq_findung_id <> COALESCE(Z.bq_findung_id, -1) OR A.ref_wup_id <> COALESCE(Z.vz_wup_id, -1) OR
            A.bezugsweg_id <> Z.bezugsweg_id
        )
    WHERE
        Z.mandant_id = 1
        AND (Z.mandant_id, Z.art_id, Z.wup_id, DATE_ADD(A.dat, INTERVAL 1 DAY)) NOT IN (SELECT (
            mandant_id, art_id, wup_id,
            dat_von
        )
        FROM `_art_gp_nm_zu_per_tmp`)
    GROUP BY
        Z.mandant_id,
        Z.wup_id,
        Z.nb_id,
        Z.art_id,
        Z.gp_id,
        Z.einkaufsorganisation_id,
        COALESCE(Z.bq_findung_id, -1),
        COALESCE(Z.vz_wup_id, -1),
        dat_von_,
        dat_bis_,
        Z.bezugsweg_id
);


INSERT INTO `_art_gp_nm_zu_per_tmp2` (
    mandant_id, art_id, wup_id, nb_id, dat_von, gp_id, einkaufsorganisation_id,
    dat_bis, bq_findung_id, vz_wup_id, bezugsweg_id
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_von,
    gp_id,
    einkaufsorganisation_id,
    dat_bis,
    bq_findung_id,
    vz_wup_id,
    bezugsweg_id
FROM `_art_gp_nm_zu_per_tmp`
QUALIFY COALESCE(gp_id - (SUM(gp_id) OVER (
    PARTITION BY mandant_id, art_id, wup_id ORDER BY dat_von IS NULL, dat_von
    ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)), 1) <> 0 OR COALESCE(bq_findung_id - (SUM(bq_findung_id) OVER (
    PARTITION BY
        mandant_id, art_id, wup_id
    ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
)), 1)
<> 0 OR COALESCE(vz_wup_id - (SUM(vz_wup_id) OVER (PARTITION BY
    mandant_id, art_id, wup_id ORDER BY
    dat_von
    IS NULL, dat_von
ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)), 1) <> 0 OR COALESCE(bezugsweg_id - (SUM(bezugsweg_id
) OVER (
    PARTITION BY mandant_id, art_id, wup_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND 1
    PRECEDING
)), 1) <> 0);


UPDATE `_art_gp_nm_zu_per_tmp2` AS `_art_gp_nm_zu_per_tmp20` SET
    dat_bis = dt1.dat_bis_ FROM (SELECT
    mandant_id,
    wup_id,
    art_id,
    dat_von,
    CASE
        WHEN (SUM(ROUND(CAST(
            FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id,
            art_id
        ORDER BY dat_von IS NULL, dat_von
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC),
        0) = 0
            THEN PARSE_DATE('%F', '9999-12-31')
        ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id, art_id
        ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) -
        ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)), INTERVAL -1 DAY)
    END AS dat_bis_
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        dat_von
    FROM `_art_gp_nm_zu_per_tmp2`
    GROUP BY
        mandant_id,
        art_id,
        wup_id,
        dat_von
) AS t0) AS dt1
WHERE
    `_art_gp_nm_zu_per_tmp20`.mandant_id = dt1.mandant_id AND `_art_gp_nm_zu_per_tmp20`.wup_id = dt1.wup_id AND
    `_art_gp_nm_zu_per_tmp20`.art_id = dt1.art_id AND `_art_gp_nm_zu_per_tmp20`.dat_von = dt1.dat_von AND
    `_art_gp_nm_zu_per_tmp20`.dat_bis <> dt1.dat_bis_;


CREATE OR REPLACE TEMPORARY TABLE _track_existence AS
SELECT
    mandant_id,
    wup_id,
    art_id
FROM dbp_data.art_gp_nm_zu_per_2
WHERE mandant_id = 1
GROUP BY
    mandant_id,
    wup_id,
    art_id;


UPDATE `_art_gp_nm_zu_per_tmp2` SET
    dat_von = DATE_SUB(`_art_gp_nm_zu_per_tmp2`.dat_von, INTERVAL 1 DAY)
WHERE (
    mandant_id, wup_id, art_id) NOT IN (
    SELECT (mandant_id, wup_id, art_id)
    FROM `_track_existence`
);


CREATE OR REPLACE TEMPORARY TABLE _agpn AS
SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    MIN(gp_id) AS gp_id,
    einkaufsorganisation_id,
    bq_findung_id,
    vz_wup_id,
    dat_von,
    dat_bis,
    bezugsweg_id,
    CURRENT_TIMESTAMP() AS td_insert,
    CURRENT_TIMESTAMP() AS td_update
FROM `_art_gp_nm_zu_per_tmp2`
GROUP BY
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    einkaufsorganisation_id,
    bq_findung_id,
    vz_wup_id,
    dat_von,
    dat_bis,
    bezugsweg_id;


CREATE OR REPLACE TEMPORARY TABLE _days AS
SELECT dat
FROM dbp_data.tag_2
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 30 DAY) AND (CURRENT_DATE("Europe/Berlin"));


CREATE OR REPLACE TEMPORARY TABLE _dups_agpn AS
SELECT *
FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id,
        MAX(A.dat_bis) AS max_dat_bis,
        MIN(A.gp_id) AS min_gp_id,
        MAX(A.gp_id) AS max_gp_id
    FROM `_agpn` AS A
    INNER JOIN `_days` AS B ON B.dat BETWEEN A.dat_von AND A.dat_bis
    GROUP BY
        B.dat,
        A.mandant_id,
        A.wup_id,
        A.art_id
    HAVING COUNT(*) > 1
) AS x
GROUP BY
    mandant_id,
    wup_id,
    art_id,
    max_dat_bis,
    min_gp_id,
    max_gp_id;


SELECT COUNT(*)
FROM `_dups_agpn`;


DELETE FROM `_agpn`
WHERE (
    mandant_id, wup_id, art_id, dat_bis, gp_id) IN (
    SELECT (mandant_id, wup_id, art_id, max_dat_bis, min_gp_id)
    FROM `_dups_agpn`
);


DELETE FROM dbp_data.art_gp_nm_zu_per_2 AS A
WHERE (
    mandant_id, wup_id, art_id) IN (
    SELECT (mandant_id, wup_id, art_id)
    FROM `_kmo_art_gp_wup_zu_3x`
);


INSERT INTO dbp_data.art_gp_nm_zu_per_2 (
    mandant_id, art_id, wup_id, nb_id, dat_von, gp_id,
    einkaufsorganisation_id, dat_bis, vz_wup_id, bq_findung_id, bezugsweg_id, td_update, td_insert
)
(
    SELECT
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        dat_von,
        gp_id,
        einkaufsorganisation_id,
        dat_bis,
        vz_wup_id,
        bq_findung_id,
        bezugsweg_id,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM `_agpn`
    GROUP BY
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        gp_id,
        einkaufsorganisation_id,
        bq_findung_id,
        vz_wup_id,
        dat_von,
        dat_bis,
        bezugsweg_id
);


UPDATE dbp_etl_process.metadata_kmo_bq_findung_2 SET
    ende = CAST(CURRENT_TIMESTAMP() AS DATETIME)
WHERE ende IS NULL;
