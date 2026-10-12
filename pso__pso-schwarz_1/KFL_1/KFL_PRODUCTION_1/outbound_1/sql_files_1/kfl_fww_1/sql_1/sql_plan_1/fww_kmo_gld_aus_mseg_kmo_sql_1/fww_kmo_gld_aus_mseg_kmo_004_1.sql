INSERT INTO dbp_etl.gld_dat_1 (dat)
(
    SELECT dat
    FROM dbp_data.tag_1
    WHERE dat BETWEEN (
        SELECT MIN(dat)
        FROM dbp_data.tag_1
        WHERE akt_mo = -12
    ) AND (CURRENT_DATE("Europe/Berlin")
    )
    AND dat NOT IN (
        SELECT dat
        FROM dbp_etl.gld_dat_1
    )
);


CREATE OR REPLACE TABLE dbp_etl.tmp_art_wup_tag_gld_1 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    ek_gld NUMERIC(29, 4),
    umrechnungskurs FLOAT64
);


CREATE OR REPLACE TABLE dbp_etl.snap_art_wup_tag_gld_1 AS
SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_buch,
    SUM(sum_betrag) AS sum_betrag,
    SUM(CAST(sum_menge AS NUMERIC)) AS sum_menge
FROM (
    SELECT
        L.mandant_id,
        L.art_id,
        L.wup_id,
        L.nb_id,
        L.dat_buch,
        ABS(SUM(CAST(L.betrag_lagerbew AS NUMERIC))) AS sum_betrag,
        ABS(SUM(L.menge_lagerbew_bme)) AS sum_menge
    FROM dbp_data.lagerbew_det_1 AS L
    INNER JOIN dbp_etl.gld_dat_1 AS D ON L.dat_buch = D.dat
    WHERE
        L.lager_bewart_id IN ('251', '252')
        AND L.mandant_id > 1
    GROUP BY
        L.mandant_id,
        L.art_id,
        L.wup_id,
        L.nb_id,
        L.dat_buch
    UNION ALL
    SELECT
        L.mandant_id,
        L.art_id,
        L.wup_id,
        L.nb_id,
        L.dat_buch,
        ABS(SUM(CAST(L.betrag_lagerbew AS NUMERIC))) AS sum_betrag,
        ABS(SUM(L.menge_lagerbew_bme)) AS sum_menge
    FROM dbp_data.lagerbew_det_delta_1 AS L
    INNER JOIN dbp_etl.gld_dat_1 AS D ON L.dat_buch = D.dat
    WHERE
        L.lager_bewart_id IN ('251', '252')
        AND L.mandant_id > 1
    GROUP BY
        L.mandant_id,
        L.art_id,
        L.wup_id,
        L.nb_id,
        L.dat_buch
) AS x
GROUP BY
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_buch;


INSERT INTO dbp_etl.tmp_art_wup_tag_gld_1 (art_id, mandant_id, wup_id, nb_id, dat, ek_gld, umrechnungskurs
)
(
    SELECT
        A.art_id,
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.dat_buch,
        CAST(CASE
            WHEN A.sum_menge = 0
                THEN 0
            ELSE A.sum_betrag / A.sum_menge
        END AS NUMERIC) AS ek_gld,
        CAST(K.umrechnungskurs AS FLOAT64) AS umrechnungskurs
    FROM dbp_etl.snap_art_wup_tag_gld_1 AS A
    INNER JOIN dbp_data.mandant_1 AS M ON A.mandant_id = M.mandant_id
    INNER JOIN
        dbp_data.kurs_1
            AS K
        ON
            M.default_wrg = K.von_wrg_id AND K.kurstyp_id = 3 AND K.nach_wrg_id =
            'EUR' AND K.dat_bis = DATE '9999-12-31'
);


INSERT INTO dbp_etl_process.ekc_artbew_agg_wt_1 (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_etl.tmp_art_wup_tag_gld_1
    WHERE (
        mandant_id, wup_id, nb_id, dat) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat)
        FROM dbp_etl_process.ekc_artbew_agg_wt_1
    )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat
);


CREATE OR REPLACE TABLE dbp_etl.fehlende_art_wup_tag_gld_1 AS
SELECT
    a.mandant_id,
    a.wup_id,
    a.art_id,
    a.dat
FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id,
        A.dat
    FROM dbp_data.artbew_1 AS A
    INNER JOIN dbp_etl.gld_dat_1 AS C ON A.dat = C.dat
    WHERE A.mandant_id > 1
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.dat,
        A.art_id
) AS a
LEFT JOIN dbp_etl.tmp_art_wup_tag_gld_1 AS B
    ON
        a.mandant_id = B.mandant_id AND a.wup_id = B.wup_id AND a.art_id = B.art_id AND a.dat = B.dat
WHERE B.umrechnungskurs IS NULL
GROUP BY
    a.mandant_id,
    a.wup_id,
    a.art_id,
    a.dat;


CREATE OR REPLACE TABLE dbp_etl.abweichende_art_wup_tag_gld_1 AS
SELECT
    B.mandant_id,
    B.dat,
    B.wup_id,
    B.art_id,
    B.ek_gld,
    B.umrechnungskurs
FROM dbp_data.artbew_1 AS A
INNER JOIN dbp_data.art_1 AS D ON A.mandant_id = D.mandant_id AND A.art_id = D.art_id
INNER JOIN dbp_etl.gld_dat_1 AS C ON A.dat = C.dat
INNER JOIN dbp_etl.tmp_art_wup_tag_gld_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.art_id = B.art_id AND A.dat = B.dat
WHERE
    A.ek_gld <> ROUND(CAST(B.ek_gld * A.menge AS NUMERIC), 4)
    AND A.art_id > -1
    AND D.wg_art_fg = 0
GROUP BY
    B.mandant_id,
    B.dat,
    B.wup_id,
    B.art_id,
    B.ek_gld,
    B.umrechnungskurs;


UPDATE dbp_data.artbew_1 SET
    ek_gld = 0,
    diff_ek_gld_konz = 0
FROM dbp_etl.fehlende_art_wup_tag_gld_1 AS b
WHERE
    artbew.mandant_id = b.mandant_id AND artbew.wup_id = b.wup_id AND artbew.art_id = b.art_id AND artbew.dat = b.dat
    AND artbew.mandant_id > 1;


UPDATE dbp_data.artbew_1 SET
    ek_gld = artbew.umsatz_netto,
    diff_ek_gld_konz = artbew.diff_umsatz_netto_konz
FROM dbp_etl.gld_dat_1
WHERE artbew.dat = gld_dat.dat AND artbew.mandant_id > 1 AND artbew.art_id = -1;


UPDATE dbp_data.artbew_1 SET
    ek_gld = artbew.ek_netto,
    diff_ek_gld_konz = artbew.diff_ek_netto_konz
FROM dbp_etl.gld_dat_1, dbp_data.art_1 AS A
WHERE
    artbew.dat = gld_dat.dat AND artbew.mandant_id > 1 AND artbew.mandant_id = A.mandant_id AND artbew.art_id = A.art_id
    AND artbew.art_id > -1 AND A.wg_art_fg = 1;


UPDATE dbp_data.artbew_1 SET
    ek_gld = CAST(b.ek_gld * artbew.menge AS NUMERIC),
    diff_ek_gld_konz = CAST(b.ek_gld * artbew.menge * b.umrechnungskurs AS NUMERIC) FROM
    dbp_etl.abweichende_art_wup_tag_gld_1 --PE-Review
        AS b
WHERE
    artbew.mandant_id = b.mandant_id AND artbew.wup_id = b.wup_id AND artbew.art_id = b.art_id AND artbew.dat = b.dat
    AND artbew.mandant_id > 1;


DROP TABLE IF EXISTS dbp_etl.gld_dat_1;


DROP TABLE IF EXISTS dbp_etl.tmp_art_wup_tag_gld_1;
