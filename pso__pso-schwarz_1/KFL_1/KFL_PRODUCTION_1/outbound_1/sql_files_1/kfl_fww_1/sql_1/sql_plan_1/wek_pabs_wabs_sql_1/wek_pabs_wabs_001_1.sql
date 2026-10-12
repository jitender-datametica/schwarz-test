CREATE OR REPLACE TABLE dbp_etl.tag_wa_kalk_final_abs_1 (
    mandant_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    dat DATE,
    wrg_id STRING(3) COLLATE 'und:ci',
    zek_id STRING(3),
    eigenmarke_fg INTEGER,
    wup_bereinigt_fg INTEGER,
    umsatz_netto NUMERIC(29, 4),
    umsatz_netto_vj NUMERIC(29, 4),
    umsatz_netto_vj_km NUMERIC(29, 4),
    logkostenzuschlag NUMERIC(29, 4),
    logkostenzuschlag_vj NUMERIC(29, 4),
    logkostenzuschlag_vj_km NUMERIC(29, 4),
    betrag_kmep_km FLOAT64,
    betrag_kmep_km_vj FLOAT64,
    betrag_kmep_kw FLOAT64,
    betrag_kmep_kw_vj FLOAT64,
    betrag_kmep_ww FLOAT64,
    betrag_kmep_ww_vj FLOAT64,
    werbe_abschrift_netto NUMERIC(29, 4) NOT NULL,
    werbe_abschrift_netto_vj NUMERIC(29, 4) NOT NULL,
    werbe_abschrift_netto_vj_km NUMERIC(29, 4) NOT NULL,
    preis_abschrift_netto NUMERIC(29, 4) NOT NULL,
    preis_abschrift_netto_vj NUMERIC(29, 4) NOT NULL,
    preis_abschrift_netto_vj_km NUMERIC(29, 4) NOT NULL,
    umrechnungskurs_hist NUMERIC(29, 5)
);


CREATE OR REPLACE TABLE dbp_etl.`_ekc_preis_abschriften` AS
SELECT
    A.mandant_id,
    A.art_id,
    COALESCE(B.bewart_id, 1002) AS bewart_id,
    COALESCE(B.bewart_det_id, 100210) AS bewart_det_id,
    A.wup_id,
    A.nb_id,
    A.dat,
    A.wrg_id,
    C.zek_id,
    C.eigenmarke_fg,
    0 AS wup_bereinigt_fg,
    ROUND(SUM(CAST(A.abschriftbetrag_netto AS FLOAT64) * COALESCE(CAST(B.anteil AS FLOAT64), 1.0000)), 2)
        AS
        preis_abschrift_netto
FROM dbp_data.marktabschriften_1 AS A
INNER JOIN dbp_etl_process.ekc_zek_1 AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
LEFT JOIN dbp_etl_process.ekc_artbew_flagging_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
        AND A.art_id = B.art_id AND A.dat = B.dat
WHERE
    A.mandant_id = 1
    AND (
        A.dat BETWEEN DATE '2022-03-01' AND DATE '2024-02-29' AND A.abschriftart_id IN (5, 7, 26, 30) OR A.dat BETWEEN
        DATE '2024-03-01' AND DATE '9999-12-31' AND A.abschriftart_id IN (5, 7, 26, 27, 30) AND NOT A.dat BETWEEN
        DATE '2022-03-01' AND DATE '2024-02-29' OR A.abschriftart_id IN (5, 7, 26) AND NOT A.dat BETWEEN DATE '2022-03-01'
        AND DATE '2024-02-29' AND NOT A.dat BETWEEN DATE '2024-03-01' AND DATE '9999-12-31'
    )
    AND A.dat >= (
        SELECT DATE_SUB(MIN(dat), INTERVAL 400 DAY)
        FROM dbp_etl.zeitraum_fww_kmo_gld_1
    )
GROUP BY
    A.mandant_id,
    A.art_id,
    bewart_id,
    bewart_det_id,
    A.wup_id,
    A.nb_id,
    A.dat,
    A.wrg_id,
    C.zek_id,
    C.eigenmarke_fg,
    wup_bereinigt_fg
UNION ALL
SELECT
    A.mandant_id,
    A.art_id,
    COALESCE(B.bewart_id, 1002) AS bewart_id,
    COALESCE(B.bewart_det_id, 100210) AS bewart_det_id,
    A.wup_id,
    A.nb_id,
    A.dat_umbew AS dat,
    A.wrg_id,
    C.zek_id,
    C.eigenmarke_fg,
    0 AS wup_bereinigt_fg,
    ROUND(SUM(CASE
        WHEN
            A.mandant_id IN (2, 5) AND A.preis_aend_grund_id IN (7, 10, 26) OR A.mandant_id IN (6) AND A.preis_aend_grund_id
            IN (2, 26) OR A.mandant_id IN (3) AND A.preis_aend_grund_id IN (11, 26) OR A.mandant_id IN (4, 7, 8) AND A.preis_aend_grund_id
            IN (7, 26)
            THEN CAST(A.diff_wert_bestand_netto AS FLOAT64) * COALESCE(CAST(B.anteil AS FLOAT64), 1.0000)
        ELSE 0
    END), 2) AS preis_abschrift_netto
FROM dbp_data.art_umbewertung_1 AS A
INNER JOIN dbp_etl_process.ekc_zek_1 AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
LEFT JOIN dbp_etl_process.ekc_artbew_flagging_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
        AND A.art_id = B.art_id AND A.dat_umbew = B.dat
WHERE
    A.mandant_id > 1
    AND A.dat_umbew >= (
        SELECT DATE_SUB(MIN(dat), INTERVAL 400 DAY)
        FROM dbp_etl.zeitraum_fww_kmo_gld_1
    )
GROUP BY
    A.mandant_id,
    A.art_id,
    bewart_id,
    bewart_det_id,
    A.wup_id,
    A.nb_id,
    dat,
    A.wrg_id,
    C.zek_id,
    C.eigenmarke_fg,
    wup_bereinigt_fg;


CREATE OR REPLACE TABLE dbp_etl.`_ekc_werbe_abschriften` AS
SELECT
    A.mandant_id,
    A.art_id,
    1002 AS bewart_id,
    100210 AS bewart_det_id,
    A.wup_id,
    A.nb_id,
    A.dat,
    A.wrg_id,
    C.zek_id,
    C.eigenmarke_fg,
    0 AS wup_bereinigt_fg,
    SUM(A.abschriftbetrag_netto) AS werbe_abschrift_netto
FROM dbp_data.marktabschriften_1 AS A
INNER JOIN dbp_etl_process.ekc_zek_1 AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
WHERE
    A.abschriftart_id = -1
    AND A.mandant_id = 1
    AND (A.dat >= DATE '2020-12-01' AND A.wv_grund_id IN (
        0, 2, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66,
        67
    ) OR (A.dat >= DATE '2020-12-01'
    ) IS NOT TRUE)
    AND A.dat >= (
        SELECT DATE_SUB(MIN(dat), INTERVAL 400 DAY)
        FROM dbp_etl.zeitraum_fww_kmo_gld_1
    )
GROUP BY
    A.mandant_id,
    A.art_id,
    bewart_id,
    bewart_det_id,
    A.wup_id,
    A.nb_id,
    A.dat,
    A.wrg_id,
    C.zek_id,
    C.eigenmarke_fg,
    wup_bereinigt_fg
UNION ALL
SELECT
    x.mandant_id,
    x.art_id,
    x.bewart_id,
    x.bewart_det_id,
    x.wup_id,
    x.nb_id,
    x.dat,
    x.wrg_id,
    C.zek_id,
    C.eigenmarke_fg,
    0 AS wup_bereinigt_fg,
    SUM(x.abschriftbetrag_netto) AS werbe_abschrift_netto
FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        1002 AS bewart_id,
        100210 AS bewart_det_id,
        A.dat,
        A.wrg_id,
        SUM(A.abschriftbetrag_netto) AS abschriftbetrag_netto
    FROM dbp_data.marktabschriften_kmo_aktion_1 AS A
    INNER JOIN dbp_data.art_wg_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    WHERE (A.dat < DATE '2020-03-01' AND A.mandant_id > 1 OR (
        A.dat >= DATE '2020-03-01' AND A.dat < DATE '2020-10-01'
        AND A.mandant_id IN (
            3, 5, 6, 8) OR (
            A.dat >= DATE '2020-10-01' AND A.dat < DATE '2021-01-01' AND A.mandant_id
            IN (
                3, 5, 8) OR (
                A.dat >= DATE '2021-01-01' AND A.dat < DATE '2021-09-01' AND A.mandant_id IN (3, 8) OR A.dat >= DATE '2021-09-01' AND A.dat < DATE '2022-04-01' AND A.mandant_id IN (3) AND ((
                    A.dat >=
                    DATE '2021-01-01' AND A.dat < DATE '2021-09-01'
                )) IS NOT TRUE
            ) AND ((
                A.dat >= DATE '2020-10-01' AND A.dat < DATE '2021-01-01'
            )
            ) IS NOT TRUE
        ) AND (
            (A.dat >= DATE '2020-03-01' AND A.dat < DATE '2020-10-01'
            )
        ) IS NOT TRUE
    ) AND (A.dat < DATE '2020-03-01'
    ) IS NOT TRUE)
    AND A.aktion_relevant_fg = 1
    AND A.dat >= (
        SELECT DATE_SUB(MIN(dat), INTERVAL 400 DAY)
        FROM dbp_etl.zeitraum_fww_kmo_gld_1
    )
    AND (
        B.mandant_id, B.wg_id) NOT IN (
        SELECT (mandant_id, wg_id)
        FROM dbp_data.wg_filter_zu_1
        WHERE
            arthiertyp_id = 2
            AND wg_filter_id = 2
    )
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        bewart_id,
        bewart_det_id,
        A.dat,
        A.wrg_id
    UNION ALL
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        1002 AS bewart_id,
        100210 AS bewart_det_id,
        A.dat_umbew AS dat,
        A.wrg_id,
        SUM(-1 * A.diff_wert_bestand_netto) AS abschriftbetrag_netto
    FROM dbp_data.art_umbewertung_1 AS A
    INNER JOIN dbp_data.art_wg_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    WHERE (A.dat_umbew < DATE '2020-03-01' AND A.mandant_id > 1 OR (
        A.dat_umbew >= DATE '2020-03-01' AND A.dat_umbew <
        DATE '2020-10-01' AND A.mandant_id IN (
            3, 5, 6, 8) OR (
            A.dat_umbew >= DATE '2020-10-01' AND A.dat_umbew <
            DATE '2021-01-01' AND A.mandant_id IN (
                3, 5, 8) OR (
                A.dat_umbew >= DATE '2021-01-01' AND A.dat_umbew <
                DATE '2021-09-01' AND A.mandant_id IN (3, 8) OR A.dat_umbew >= DATE '2021-09-01' AND A.dat_umbew <
                DATE '2022-04-01' AND A.mandant_id IN (3) AND ((
                    A.dat_umbew >= DATE '2021-01-01' AND A.dat_umbew <
                    DATE '2021-09-01'
                )) IS NOT TRUE
            ) AND ((
                A.dat_umbew >= DATE '2020-10-01' AND A.dat_umbew <
                DATE '2021-01-01'
            )
            ) IS NOT TRUE
        ) AND ((
            A.dat_umbew >= DATE '2020-03-01' AND A.dat_umbew <
            DATE '2020-10-01'
        )
        ) IS NOT TRUE
    ) AND (A.dat_umbew < DATE '2020-03-01'
    ) IS NOT TRUE)
    AND A.preis_aend_grund_id = 6
    AND A.dat_umbew >= (
        SELECT DATE_SUB(MIN(dat), INTERVAL 400 DAY)
        FROM dbp_etl.zeitraum_fww_kmo_gld_1
    )
    AND (
        B.mandant_id, B.wg_id) NOT IN (
        SELECT (mandant_id, wg_id)
        FROM dbp_data.wg_filter_zu_1
        WHERE
            arthiertyp_id = 2
            AND wg_filter_id = 2
    )
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        bewart_id,
        bewart_det_id,
        dat,
        A.wrg_id
    UNION ALL
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        1002 AS bewart_id,
        100210 AS bewart_det_id,
        dat,
        wrg_1,
        SUM(-1 * (
            pv_aktion + pv_bby + pv_kdn_bby + pv_kdp_bby + pv_aktion_bby + pv_aktion_kdn_bby + pv_aktion_kdp_bby +
            pv_bonrabatt_bby
        )) AS abschriftbetrag_netto
    FROM dbp_data.artbew_1 AS A
    WHERE (dat >= DATE '2020-03-01' AND dat < DATE '2020-10-01' AND mandant_id IN (
        2, 4, 7) OR (
        dat >= DATE '2020-10-01'
        AND dat < DATE '2021-01-01' AND mandant_id IN (
            2, 4, 6, 7) OR (
            dat >= DATE '2021-01-01' AND dat <
            DATE '2021-09-01' AND mandant_id IN (
                2, 4, 5, 6, 7) OR (
                dat >= DATE '2021-09-01' AND dat <
                DATE '2022-04-01' AND mandant_id IN (2, 4, 5, 6, 7, 8) OR mandant_id IN (2, 3, 4, 5, 6, 7, 8) AND ((
                    dat
                    >= DATE '2021-09-01' AND dat < DATE '2022-04-01'
                )) IS NOT TRUE
            ) AND ((
                dat >= DATE '2021-01-01' AND
                dat < DATE '2021-09-01'
            )
            ) IS NOT TRUE
        ) AND (
            (dat >= DATE '2020-10-01' AND dat < DATE '2021-01-01'
            )
        )
        IS NOT TRUE
    ) AND ((dat >= DATE '2020-03-01' AND dat < DATE '2020-10-01')
    ) IS NOT TRUE)
    AND dat >= (
        SELECT DATE_SUB(MIN(dat), INTERVAL 400 DAY)
        FROM dbp_etl.zeitraum_fww_kmo_gld_1
    )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        A.bewart_id,
        A.bewart_det_id,
        dat,
        wrg_1
) AS x
INNER JOIN dbp_etl_process.ekc_zek_1 AS C ON x.mandant_id = C.mandant_id AND x.art_id = C.art_id
GROUP BY
    x.mandant_id,
    x.art_id,
    x.bewart_id,
    x.bewart_det_id,
    x.wup_id,
    x.nb_id,
    x.dat,
    x.wrg_id,
    C.zek_id,
    C.eigenmarke_fg,
    wup_bereinigt_fg;


CREATE OR REPLACE TABLE dbp_etl.`_wabs` AS
SELECT
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    wup_id,
    nb_id,
    dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    werbe_abschrift_netto,
    CAST(0 AS NUMERIC) AS werbe_abschrift_netto_vj,
    CAST(0 AS NUMERIC) AS werbe_abschrift_netto_vj_km
FROM dbp_etl.`_ekc_werbe_abschriften`
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1) AND (
    SELECT MAX(dat)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1
);


CREATE OR REPLACE TABLE dbp_etl.`_wabs_vj` AS
SELECT
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    wup_id,
    nb_id,
    DATE_ADD(dat, INTERVAL 364 DAY) AS dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    werbe_abschrift_netto AS werbe_abschrift_netto_vj
FROM dbp_etl.`_ekc_werbe_abschriften` AS A
WHERE dat BETWEEN (
    SELECT DATE_SUB(MIN(dat), INTERVAL 364 DAY)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1) AND (
    SELECT DATE_SUB(MAX(dat), INTERVAL 364 DAY)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1
);


CREATE OR REPLACE TABLE dbp_etl.`_wabs_vj_km` AS
SELECT
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    wup_id,
    nb_id,
    dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    SUM(werbe_abschrift_netto) AS werbe_abschrift_netto_vj_km
FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        DATE_ADD(A.dat, INTERVAL X.days_back DAY) AS dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        A.werbe_abschrift_netto
    FROM dbp_etl.`_ekc_werbe_abschriften` AS A
    INNER JOIN dbp_etl.zeitraum_fww_kmo_gld_1 AS X ON A.dat = DATE_SUB(X.dat, INTERVAL X.days_back DAY)
    WHERE
        DATE_ADD(
            A.dat, INTERVAL X.days_back DAY) NOT IN (
            SELECT dat
            FROM dbp_etl.zeitraum_fww_kmo_gld_1
            WHERE sj = 1
        )
    UNION ALL
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        DATE_SUB(DATE_ADD(A.dat, INTERVAL X.days_back DAY), INTERVAL 1 DAY) AS dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        A.werbe_abschrift_netto
    FROM dbp_etl.`_ekc_werbe_abschriften` AS A
    INNER JOIN dbp_etl.zeitraum_fww_kmo_gld_1 AS X
        ON A.dat = DATE_ADD(DATE_SUB(
            X.dat, INTERVAL X.days_back
            DAY
        ), INTERVAL 1 DAY) AND X.sj = -1
) AS x
GROUP BY
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    wup_id,
    nb_id,
    dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg;


MERGE INTO dbp_etl.`_wabs` AS A
USING dbp_etl.`_wabs_vj` AS b
    ON
        A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.art_id = b.art_id AND A.bewart_id = b.bewart_id AND A.bewart_det_id = b.bewart_det_id AND A.dat = b.dat AND A.wrg_id = b.wrg_id
WHEN MATCHED THEN
    UPDATE SET
        werbe_abschrift_netto_vj = CAST(b.werbe_abschrift_netto_vj AS NUMERIC)
WHEN NOT MATCHED THEN INSERT VALUES (
    b.mandant_id, b.art_id, b.bewart_id, b.bewart_det_id, b.wup_id, b.nb_id, b.dat, b.wrg_id,
    b.zek_id, b.eigenmarke_fg, 0, 0, CAST(b.werbe_abschrift_netto_vj AS NUMERIC), 0
);


MERGE INTO dbp_etl.`_wabs` AS A
USING dbp_etl.`_wabs_vj_km` AS b
    ON
        A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.art_id = b.art_id AND A.bewart_id = b.bewart_id AND A.bewart_det_id = b.bewart_det_id AND A.dat = b.dat AND A.wrg_id = b.wrg_id
WHEN MATCHED THEN
    UPDATE SET
        werbe_abschrift_netto_vj_km = CAST(b.werbe_abschrift_netto_vj_km AS NUMERIC)
WHEN NOT MATCHED THEN INSERT VALUES (
    b.mandant_id, b.art_id, b.bewart_id, b.bewart_det_id, b.wup_id, b.nb_id, b.dat, b.wrg_id,
    b.zek_id, b.eigenmarke_fg, 0, 0, 0, CAST(b.werbe_abschrift_netto_vj_km AS NUMERIC)
);


CREATE OR REPLACE TABLE dbp_etl.`_pabs` AS
SELECT
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    wup_id,
    nb_id,
    dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    CASE
        WHEN mandant_id = 1
            THEN -1 * preis_abschrift_netto
        ELSE preis_abschrift_netto
    END AS preis_abschrift_netto,
    CAST(0 AS NUMERIC) AS preis_abschrift_netto_vj,
    CAST(0 AS NUMERIC) AS preis_abschrift_netto_vj_km
FROM dbp_etl.`_ekc_preis_abschriften`
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1) AND (
    SELECT MAX(dat)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1
);


CREATE OR REPLACE TABLE dbp_etl.`_pabs_vj` AS
SELECT
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    wup_id,
    nb_id,
    DATE_ADD(dat, INTERVAL 364 DAY) AS dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    CASE
        WHEN mandant_id = 1
            THEN -1 * preis_abschrift_netto
        ELSE preis_abschrift_netto
    END AS preis_abschrift_netto_vj
FROM dbp_etl.`_ekc_preis_abschriften` AS A
WHERE dat BETWEEN (
    SELECT DATE_SUB(MIN(dat), INTERVAL 364 DAY)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1) AND (
    SELECT DATE_SUB(MAX(dat), INTERVAL 364 DAY)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1
);


CREATE OR REPLACE TABLE dbp_etl.`_pabs_vj_km` AS
SELECT
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    wup_id,
    nb_id,
    dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    SUM(preis_abschrift_netto_vj_km) AS preis_abschrift_netto_vj_km
FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        DATE_ADD(A.dat, INTERVAL X.days_back DAY) AS dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        CASE
            WHEN A.mandant_id = 1
                THEN -1 * A.preis_abschrift_netto
            ELSE A.preis_abschrift_netto
        END AS preis_abschrift_netto_vj_km
    FROM dbp_etl.`_ekc_preis_abschriften` AS A
    INNER JOIN dbp_etl.zeitraum_fww_kmo_gld_1 AS X ON A.dat = DATE_SUB(X.dat, INTERVAL X.days_back DAY)
    WHERE
        DATE_ADD(
            A.dat, INTERVAL X.days_back DAY) NOT IN (
            SELECT dat
            FROM dbp_etl.zeitraum_fww_kmo_gld_1
            WHERE sj = 1
        )
    UNION ALL
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        DATE_SUB(DATE_ADD(A.dat, INTERVAL X.days_back DAY), INTERVAL 1 DAY) AS dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        CASE
            WHEN A.mandant_id = 1
                THEN -1 * A.preis_abschrift_netto
            ELSE A.preis_abschrift_netto
        END AS preis_abschrift_netto_vj_km
    FROM dbp_etl.`_ekc_preis_abschriften` AS A
    INNER JOIN dbp_etl.zeitraum_fww_kmo_gld_1 AS X
        ON A.dat = DATE_ADD(DATE_SUB(
            X.dat, INTERVAL X.days_back
            DAY
        ), INTERVAL 1 DAY) AND X.sj = -1
) AS x
GROUP BY
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    wup_id,
    nb_id,
    dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg;


MERGE INTO dbp_etl.`_pabs` AS A
USING dbp_etl.`_pabs_vj` AS b
    ON
        A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.art_id = b.art_id AND A.bewart_id = b.bewart_id AND A.bewart_det_id = b.bewart_det_id AND A.dat = b.dat AND A.wrg_id = b.wrg_id
WHEN MATCHED THEN
    UPDATE SET
        preis_abschrift_netto_vj = CAST(ROUND(CAST(b.preis_abschrift_netto_vj AS BIGNUMERIC), 0) AS NUMERIC)
WHEN NOT MATCHED THEN INSERT VALUES (
    b.mandant_id, b.art_id, b.bewart_id, b.bewart_det_id, b.wup_id, b.nb_id, b.dat, b.wrg_id,
    b.zek_id, b.eigenmarke_fg, 0, 0, CAST(ROUND(CAST(b.preis_abschrift_netto_vj AS BIGNUMERIC), 0) AS NUMERIC), 0
);


MERGE INTO dbp_etl.`_pabs` AS A
USING dbp_etl.`_pabs_vj_km` AS b
    ON
        A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.art_id = b.art_id AND A.bewart_id = b.bewart_id AND A.bewart_det_id = b.bewart_det_id AND A.dat = b.dat AND A.wrg_id = b.wrg_id
WHEN MATCHED THEN
    UPDATE SET
        preis_abschrift_netto_vj_km = CAST(ROUND(CAST(b.preis_abschrift_netto_vj_km AS BIGNUMERIC), 0) AS NUMERIC)
WHEN NOT MATCHED THEN INSERT VALUES (
    b.mandant_id, b.art_id, b.bewart_id, b.bewart_det_id, b.wup_id, b.nb_id, b.dat, b.wrg_id,
    b.zek_id, b.eigenmarke_fg, 0, 0, 0, CAST(ROUND(CAST(b.preis_abschrift_netto_vj_km AS BIGNUMERIC), 0) AS NUMERIC)
);


INSERT INTO dbp_etl.tag_wa_kalk_final_abs_1 (
    mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id,
    dat, wrg_id, zek_id, eigenmarke_fg, wup_bereinigt_fg, umsatz_netto, umsatz_netto_vj, umsatz_netto_vj_km,
    logkostenzuschlag, logkostenzuschlag_vj, logkostenzuschlag_vj_km, betrag_kmep_km, betrag_kmep_km_vj, betrag_kmep_kw,
    betrag_kmep_kw_vj, betrag_kmep_ww, betrag_kmep_ww_vj, werbe_abschrift_netto, werbe_abschrift_netto_vj,
    werbe_abschrift_netto_vj_km, preis_abschrift_netto, preis_abschrift_netto_vj, preis_abschrift_netto_vj_km,
    umrechnungskurs_hist
)
(SELECT
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    wup_id,
    nb_id,
    dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    0 AS umsatz_netto,
    0 AS umsatz_netto_vj,
    0 AS umsatz_netto_vj_km,
    0 AS logkostenzuschlag,
    0 AS logkostenzuschlag_vj,
    0 AS logkostenzuschlag_vj_km,
    0 AS betrag_kmep_km,
    0 AS betrag_kmep_km_vj,
    0 AS betrag_kmep_kw,
    0 AS betrag_kmep_kw_vj,
    0 AS betrag_kmep_ww,
    0 AS betrag_kmep_ww_vj,
    CAST(werbe_abschrift_netto AS NUMERIC) AS werbe_abschrift_netto,
    werbe_abschrift_netto_vj,
    werbe_abschrift_netto_vj_km,
    0 AS preis_abschrift_netto,
    0 AS preis_abschrift_netto_vj,
    0 AS preis_abschrift_netto_vj_km,
    1 AS umrechnungskurs_hist
FROM dbp_etl.`_wabs` AS A);


INSERT INTO dbp_etl.tag_wa_kalk_final_abs_1 (
    mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id,
    dat, wrg_id, zek_id, eigenmarke_fg, wup_bereinigt_fg, umsatz_netto, umsatz_netto_vj, umsatz_netto_vj_km,
    logkostenzuschlag, logkostenzuschlag_vj, logkostenzuschlag_vj_km, betrag_kmep_km, betrag_kmep_km_vj, betrag_kmep_kw,
    betrag_kmep_kw_vj, betrag_kmep_ww, betrag_kmep_ww_vj, werbe_abschrift_netto, werbe_abschrift_netto_vj,
    werbe_abschrift_netto_vj_km, preis_abschrift_netto, preis_abschrift_netto_vj, preis_abschrift_netto_vj_km,
    umrechnungskurs_hist
)
(SELECT
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    wup_id,
    nb_id,
    dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    0 AS umsatz_netto,
    0 AS umsatz_netto_vj,
    0 AS umsatz_netto_vj_km,
    0 AS logkostenzuschlag,
    0 AS logkostenzuschlag_vj,
    0 AS logkostenzuschlag_vj_km,
    0 AS betrag_kmep_km,
    0 AS betrag_kmep_km_vj,
    0 AS betrag_kmep_kw,
    0 AS betrag_kmep_kw_vj,
    0 AS betrag_kmep_ww,
    0 AS betrag_kmep_ww_vj,
    0 AS werbe_abschrift_netto,
    0 AS werbe_abschrift_netto_vj,
    0 AS werbe_abschrift_netto_vj_km,
    ROUND(CAST(preis_abschrift_netto AS NUMERIC), 4) AS preis_abschrift_netto,
    preis_abschrift_netto_vj,
    preis_abschrift_netto_vj_km,
    1 AS umrechnungskurs_hist
FROM dbp_etl.`_pabs` AS A);


INSERT INTO dbp_etl.tag_wa_kalk_final_abs_1 (
    mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id,
    dat, wrg_id, zek_id, eigenmarke_fg, wup_bereinigt_fg, umsatz_netto, umsatz_netto_vj, umsatz_netto_vj_km,
    logkostenzuschlag, logkostenzuschlag_vj, logkostenzuschlag_vj_km, betrag_kmep_km, betrag_kmep_km_vj, betrag_kmep_kw,
    betrag_kmep_kw_vj, betrag_kmep_ww, betrag_kmep_ww_vj, werbe_abschrift_netto, werbe_abschrift_netto_vj,
    werbe_abschrift_netto_vj_km, preis_abschrift_netto, preis_abschrift_netto_vj, preis_abschrift_netto_vj_km,
    umrechnungskurs_hist
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        1 AS wup_bereinigt_fg,
        A.umsatz_netto,
        A.umsatz_netto_vj,
        A.umsatz_netto_vj_km,
        A.logkostenzuschlag,
        A.logkostenzuschlag_vj,
        A.logkostenzuschlag_vj_km,
        A.betrag_kmep_km,
        A.betrag_kmep_km_vj,
        A.betrag_kmep_kw,
        A.betrag_kmep_kw_vj,
        A.betrag_kmep_ww,
        A.betrag_kmep_ww_vj,
        A.werbe_abschrift_netto,
        A.werbe_abschrift_netto_vj,
        A.werbe_abschrift_netto_vj_km,
        A.preis_abschrift_netto,
        A.preis_abschrift_netto_vj,
        A.preis_abschrift_netto_vj_km,
        A.umrechnungskurs_hist
    FROM dbp_etl.tag_wa_kalk_final_abs_1 AS A
    INNER JOIN dbp_data.tag_1 AS X1 ON A.dat = X1.dat
    INNER JOIN dbp_data.wup_1 AS X2
        ON
            A.mandant_id = X2.mandant_id AND A.nb_id = X2.nb_id AND A.wup_id = X2.wup_id
    WHERE
        X1.wo_dat_von >= IF(
            X2.dat_von = LAST_DAY(X2.dat_von), LAST_DAY(DATE_ADD(X2.dat_von, INTERVAL 12 MONTH)),
            DATE_ADD(X2.dat_von, INTERVAL 12 MONTH)
        )
        AND X1.wo_dat_bis <= X2.dat_bis
);


INSERT INTO dbp_etl.tag_wa_kalk_final_abs_1 (
    mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id,
    dat, wrg_id, zek_id, eigenmarke_fg, wup_bereinigt_fg, umsatz_netto, umsatz_netto_vj, umsatz_netto_vj_km,
    logkostenzuschlag, logkostenzuschlag_vj, logkostenzuschlag_vj_km, betrag_kmep_km, betrag_kmep_km_vj, betrag_kmep_kw,
    betrag_kmep_kw_vj, betrag_kmep_ww, betrag_kmep_ww_vj, werbe_abschrift_netto, werbe_abschrift_netto_vj,
    werbe_abschrift_netto_vj_km, preis_abschrift_netto, preis_abschrift_netto_vj, preis_abschrift_netto_vj_km,
    umrechnungskurs_hist
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        'EUR' AS wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        A.umsatz_netto * D1.umrechnungskurs,
        A.umsatz_netto_vj * D1.umrechnungskurs,
        A.umsatz_netto_vj_km * D1.umrechnungskurs,
        A.logkostenzuschlag * D1.umrechnungskurs,
        A.logkostenzuschlag_vj * D1.umrechnungskurs,
        A.logkostenzuschlag_vj_km * D1.umrechnungskurs,
        CAST(A.betrag_kmep_km * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_km_vj * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_kw * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_kw_vj * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_ww * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_ww_vj * D1.umrechnungskurs AS FLOAT64),
        A.werbe_abschrift_netto * D1.umrechnungskurs,
        A.werbe_abschrift_netto_vj * D1.umrechnungskurs,
        A.werbe_abschrift_netto_vj_km * D1.umrechnungskurs,
        A.preis_abschrift_netto * D1.umrechnungskurs,
        A.preis_abschrift_netto_vj * D1.umrechnungskurs,
        A.preis_abschrift_netto_vj_km * D1.umrechnungskurs,
        A.umrechnungskurs_hist
    FROM dbp_etl.tag_wa_kalk_final_abs_1 AS A
    INNER JOIN dbp_data.kurs_1 AS D1
        ON A.wrg_id = D1.von_wrg_id AND D1.dat_bis = PARSE_DATE(
            '%F',
            '9999-12-31'
        ) AND D1.nach_wrg_id = 'EUR' AND D1.kurstyp_id = 3
    WHERE A.mandant_id IN (2, 3, 4, 7)
);


UPDATE dbp_etl.tag_wa_kalk_final_abs_1 SET
    umrechnungskurs_hist = b.umrechnungskurs_hist FROM (
    SELECT
        D.mandant_id,
        A.dat,
        'EUR' AS wrg_id,
        B.umrechnungskurs / C.umrechnungskurs AS umrechnungskurs_hist
    FROM dbp_data.tag_1 AS A
    INNER JOIN dbp_data.mandant_1 AS D ON TRUE
    INNER JOIN dbp_data.kurs_1 AS B ON D.default_wrg = B.von_wrg_id AND A.dat BETWEEN B.dat_von AND B.dat_bis

    INNER JOIN dbp_data.kurs_1 AS C ON D.default_wrg = C.von_wrg_id
    WHERE
        C.dat_bis = DATE '9999-12-31'
        AND C.nach_wrg_id = 'EUR'
        AND C.kurstyp_id = 3
        AND B.nach_wrg_id = 'EUR'
        AND B.kurstyp_id = 3
        AND D.mandant_id IN (2, 3, 4, 7)
        AND A.akt_mo BETWEEN -13 AND 0
    GROUP BY
        D.mandant_id,
        A.dat,
        wrg_id,
        umrechnungskurs_hist
) AS b
WHERE
    tag_wa_kalk_final_abs.mandant_id = b.mandant_id AND tag_wa_kalk_final_abs.dat = b.dat AND tag_wa_kalk_final_abs.wrg_id
    = b.wrg_id;


DELETE FROM dbp_data.artbew_dat_ek_cp_sum_1
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1) AND (
    SELECT MAX(dat)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1
) AND transaktion_typ_id = 1;


INSERT INTO dbp_data.artbew_dat_ek_cp_sum_1 (
    mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id,
    dat, wrg_id, wup_bereinigt_fg, transaktion_typ_id, zek_id, gp_id, eigenmarke_fg, umsatz_netto, umsatz_netto_vj,
    betrag_kmep_kw, betrag_kmep_kw_vj, betrag_kmep_ww, betrag_kmep_ww_vj, logkostenzuschlag, logkostenzuschlag_vj,
    werbe_abschrift_netto, werbe_abschrift_netto_vj, preis_abschrift_netto, preis_abschrift_netto_vj, umrechnungskurs_hist
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        A.wup_bereinigt_fg,
        1 AS transaktion_typ_id,
        A.zek_id,
        COALESCE(B.gp_id, -1) AS gp_id,
        A.eigenmarke_fg,
        A.umsatz_netto,
        A.umsatz_netto_vj,
        ROUND(CAST(A.betrag_kmep_kw AS NUMERIC), 4) AS betrag_kmep_kw,
        ROUND(CAST(A.betrag_kmep_kw_vj AS NUMERIC), 4) AS betrag_kmep_kw_vj,
        ROUND(CAST(A.betrag_kmep_ww AS NUMERIC), 4) AS betrag_kmep_ww,
        ROUND(CAST(A.betrag_kmep_ww_vj AS NUMERIC), 4) AS betrag_kmep_ww_vj,
        A.logkostenzuschlag,
        A.logkostenzuschlag_vj,
        A.werbe_abschrift_netto,
        A.werbe_abschrift_netto_vj,
        A.preis_abschrift_netto,
        A.preis_abschrift_netto_vj,
        A.umrechnungskurs_hist
    FROM dbp_etl.tag_wa_kalk_final_abs_1 AS A
    LEFT JOIN dbp_etl.art_gp_nm_zu_per_fww_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND
            A.art_id = B.art_id AND A.dat = B.dat
    WHERE
        A.preis_abschrift_netto <> 0
        OR A.preis_abschrift_netto_vj <> 0
        OR A.werbe_abschrift_netto <> 0
        OR A.werbe_abschrift_netto_vj <> 0
);


DELETE FROM dbp_data.artbew_mo_ek_cp_sum_1
WHERE kjmo BETWEEN (
    SELECT MIN(kjmo)
    FROM dbp_etl.zeitraum_fww_kmo_gld_1) AND (SELECT MAX(kjmo)
FROM dbp_etl.zeitraum_fww_kmo_gld_1) AND (
    preis_abschrift_netto <> 0 OR preis_abschrift_netto_vj <> 0 OR
    werbe_abschrift_netto <> 0 OR werbe_abschrift_netto_vj <> 0
);


INSERT INTO dbp_data.artbew_mo_ek_cp_sum_1 (
    mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id,
    gp_id, kjmo, wrg_id, wup_bereinigt_fg, posten_id, zek_id, eigenmarke_fg, umsatz_netto, umsatz_netto_vj, betrag_kmep,
    betrag_kmep_vj, logkostenzuschlag, logkostenzuschlag_vj, werbe_abschrift_netto, werbe_abschrift_netto_vj,
    preis_abschrift_netto, preis_abschrift_netto_vj, umrechnungskurs_hist
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        COALESCE(C.gp_id, -1),
        CAST(ROUND(CAST(SUBSTR(FORMAT_DATE('%Y%m%d', A.dat), 1, 6) AS BIGNUMERIC), 0) AS INTEGER) AS kjmo,
        A.wrg_id,
        A.wup_bereinigt_fg,
        B.posten_id,
        A.zek_id,
        A.eigenmarke_fg,
        SUM(A.umsatz_netto),
        SUM(A.umsatz_netto_vj),
        ROUND(CAST(SUM(A.betrag_kmep_km) AS NUMERIC), 4),
        ROUND(CAST(SUM(A.betrag_kmep_km_vj) AS NUMERIC), 4),
        SUM(A.logkostenzuschlag),
        SUM(A.logkostenzuschlag_vj),
        SUM(A.werbe_abschrift_netto),
        SUM(A.werbe_abschrift_netto_vj_km),
        SUM(A.preis_abschrift_netto),
        SUM(A.preis_abschrift_netto_vj_km),
        MAX(A.umrechnungskurs_hist)
    FROM dbp_etl.tag_wa_kalk_final_abs_1 AS A
    INNER JOIN dbp_data.monat_1 AS X
        ON ROUND(
            CAST(SUBSTR(FORMAT_DATE('%Y%m%d', A.dat), 1, 6) AS BIGNUMERIC),
            0
        ) = X.kjmo
    INNER JOIN dbp_data.art_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.dat
            BETWEEN B.dat_von AND B.dat_bis
    LEFT JOIN dbp_etl.art_gp_nm_zu_per_fww_1 AS C
        ON
            A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id AND
            A.art_id = C.art_id AND A.dat = C.dat
    WHERE
        A.preis_abschrift_netto <> 0
        OR A.preis_abschrift_netto_vj_km <> 0
        OR A.werbe_abschrift_netto <> 0
        OR A.werbe_abschrift_netto_vj_km <> 0
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        kjmo,
        A.wrg_id,
        B.posten_id,
        A.wup_bereinigt_fg,
        A.zek_id,
        A.eigenmarke_fg,
        COALESCE(C.gp_id, -1)
);
