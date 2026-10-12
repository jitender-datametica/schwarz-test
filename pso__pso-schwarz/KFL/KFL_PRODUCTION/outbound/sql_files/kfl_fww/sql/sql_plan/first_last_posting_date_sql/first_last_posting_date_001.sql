--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.lagerbew_art_bewart_zu;


CREATE TABLE IF NOT EXISTS dbp_etl.lagerbew_art_bewart_zu (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_buch_first DATE NOT NULL,
    dat_buch_last DATE NOT NULL,
    dat_erfasst_first DATE NOT NULL,
    dat_erfasst_last DATE NOT NULL
);


INSERT INTO dbp_etl.lagerbew_art_bewart_zu (
    art_id, mandant_id, lager_bewart_id, wup_id, nb_id,
    dat_buch_first, dat_buch_last, dat_erfasst_first, dat_erfasst_last
)
(
    SELECT
        A.art_id AS art_id,
        A.mandant_id AS mandan_id,
        A.lager_bewart_id,
        A.wup_id AS wup_id,
        A.nb_id AS nb_id,
        MIN(A.dat_buch) AS dat_buch_first,
        MAX(A.dat_buch) AS dat_buch_last,
        MIN(B.dat_erfasst) AS dat_erfasst_first,
        MAX(B.dat_erfasst) AS dat_erfasst_last
    FROM dbp_data.lagerbew_det AS A
    INNER JOIN dbp_data.lagerbew AS B
        ON
            A.mandant_id = B.mandant_id AND A.dat_buch = B.dat_buch AND A.lagerbew_beleg_id
            = B.lagerbew_beleg_id
    WHERE A.dat_buch BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 45 DAY) AND (CURRENT_DATE("Europe/Berlin"))
    GROUP BY
        mandan_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.lager_bewart_id
);


UPDATE dbp_data.lagerbew_art_bewart_zu

SET
    dat_buch_last = dt.dat_buch_last,

    dat_erfasst_last = dt.dat_erfasst_last

FROM dbp_etl.lagerbew_art_bewart_zu dt

WHERE
    lagerbew_art_bewart_zu.mandant_id = dt.mandant_id
    AND lagerbew_art_bewart_zu.art_id = dt.art_id
    AND lagerbew_art_bewart_zu.wup_id = dt.wup_id
    AND lagerbew_art_bewart_zu.lager_bewart_id = dt.lager_bewart_id;


INSERT INTO dbp_data.lagerbew_art_bewart_zu (
    art_id, mandant_id, lager_bewart_id, wup_id, nb_id,
    dat_buch_first, dat_buch_last, dat_erfasst_first, dat_erfasst_last
)
(
    SELECT *
    FROM dbp_etl.lagerbew_art_bewart_zu
    WHERE (CAST(mandant_id AS BIGNUMERIC), CAST(art_id AS BIGNUMERIC), CAST(wup_id AS BIGNUMERIC), lager_bewart_id) NOT IN (
        SELECT AS STRUCT
            CAST(mandant_id AS BIGNUMERIC), --PE_Review
            CAST(art_id AS BIGNUMERIC), --PE_Review
            CAST(wup_id AS BIGNUMERIC), --PE_Review
            lager_bewart_id
        FROM dbp_data.lagerbew_art_bewart_zu
    )
);
