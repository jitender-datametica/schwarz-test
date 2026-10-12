SELECT dat_relevant
FROM dbp_etl.kmo_art_wup_ek_datum_relevant_1;


DELETE FROM dbp_etl_process.metadata_kmo_art_wup_ek_1
WHERE ende IS NULL;


INSERT INTO dbp_etl_process.metadata_kmo_art_wup_ek_1 (snapshot_datum, verdat, beginn)
(SELECT
    dat_relevant AS snapshot_datum,
    CURRENT_DATE("Europe/Berlin") AS verdat,
    CAST(CURRENT_TIMESTAMP() AS DATETIME) AS beginn
FROM dbp_etl.kmo_art_wup_ek_datum_relevant_1);


/* neue Spalte */ CREATE TEMPORARY TABLE IF NOT EXISTS _art_wup_ek_zu_per_w (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_relevant DATE NOT NULL,
    ek_netto NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    komponentenmenge NUMERIC(29, 4) NOT NULL,
    wrg_id STRING(3) NOT NULL,
    ek_nettonetto NUMERIC(29, 4),
    kein_zekp_fg INTEGER
);


/* neue Spalten */ CREATE TEMPORARY TABLE IF NOT EXISTS _art_wup_ek_zu_per_x (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_relevant DATE NOT NULL,
    ek_netto NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    komponentenmenge NUMERIC(29, 4) NOT NULL,
    wrg_id STRING(3) NOT NULL,
    ek_nettonetto NUMERIC(29, 4),
    kein_zekp_fg INTEGER
);


/* neue Spalten */ CREATE TEMPORARY TABLE IF NOT EXISTS _art_wup_ek_zu_per_tmp (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    ek_netto NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    komponentenmenge NUMERIC(29, 4) NOT NULL,
    wrg_id STRING(3) NOT NULL,
    ek_nettonetto NUMERIC(29, 4),
    kein_zekp_fg INTEGER
);


/* neue Spalten */ CREATE TEMPORARY TABLE IF NOT EXISTS _art_wup_ek_zu_per_tmp2 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    ek_netto NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    komponentenmenge NUMERIC(29, 4) NOT NULL,
    wrg_id STRING(3) NOT NULL,
    ek_nettonetto NUMERIC(29, 4),
    kein_zekp_fg INTEGER
);


CREATE TEMPORARY TABLE IF NOT EXISTS _hauptlieferant (
    dat_relevant DATE NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL
);


CREATE TEMPORARY TABLE IF NOT EXISTS _mandant_artikel_kombi (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL
);


INSERT INTO `_hauptlieferant` (dat_relevant, mandant_id, wup_id, nb_id, art_id, gp_id)
(
    SELECT
        b.dat_relevant,
        A.mandant_id,
        -1 AS wup_id,
        -1 AS nb_id,
        A.art_id,
        MAX(b.gp_id) AS gp_id
    FROM dbp_data.art_gp_nm_zu_per_1 AS A
    INNER JOIN (SELECT
        t1.dat_relevant,
        t1.mandant_id,
        t1.art_id,
        t1.gp_id
    FROM (
        SELECT
            R.dat_relevant,
            A0.mandant_id,
            A0.art_id,
            A0.gp_id,
            COUNT(*) AS z0
        FROM dbp_data.art_gp_nm_zu_per_1 AS A0
        INNER JOIN dbp_etl.kmo_art_wup_ek_datum_relevant_1 AS R ON TRUE
        WHERE
            A0.gp_id <> -1
            AND A0.mandant_id > 1
            AND R.dat_relevant BETWEEN A0.dat_von AND A0.dat_bis
        GROUP BY
            A0.mandant_id,
            A0.art_id,
            A0.gp_id,
            R.dat_relevant
    ) AS t1_1
    QUALIFY (RANK() OVER (PARTITION BY t1.mandant_id, t1.art_id ORDER BY t1.z0 IS NULL DESC, t1.z0 DESC)) = 1) AS b
        ON
            A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND b.dat_relevant BETWEEN A.dat_von AND A.dat_bis
    GROUP BY
        A.mandant_id,
        A.art_id,
        b.dat_relevant
);


INSERT INTO `_mandant_artikel_kombi` (mandant_id, art_id)
(
    SELECT
        A.mandant_id,
        A.art_id
    FROM dbp_data.art_gp_nm_zu_per_1 AS A
    INNER JOIN dbp_etl.kmo_art_wup_ek_datum_relevant_1 AS R ON TRUE
    WHERE
        A.mandant_id > 1
        AND R.dat_relevant BETWEEN A.dat_von AND A.dat_bis
    GROUP BY
        A.mandant_id,
        A.art_id
);


INSERT INTO `_hauptlieferant` (dat_relevant, mandant_id, wup_id, nb_id, art_id, gp_id)
(
    SELECT
        R.dat_relevant,
        A.mandant_id,
        -1 AS wup_id,
        -1 AS nb_id,
        A.art_id,
        -1 AS gp_id
    FROM `_mandant_artikel_kombi` AS A
    INNER JOIN dbp_etl.kmo_art_wup_ek_datum_relevant_1 AS R ON TRUE
    LEFT JOIN `_hauptlieferant` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    WHERE B.mandant_id IS NULL
);


INSERT INTO `_art_wup_ek_zu_per_w` (
    art_id, mandant_id, wup_id, nb_id, dat_relevant, ek_netto, ek_netto_bnk, ek_mep,
    einstandspreis, komponentenmenge, wrg_id, ek_nettonetto, kein_zekp_fg
)
(
    SELECT
        a.art_id,
        a.mandant_id,
        -1 AS wup_id,
        -1 AS nb_id,
        a.dat_relevant,
        COALESCE(CAST(b.ek_netto AS NUMERIC), 1) AS ek_netto,
        COALESCE(CAST(b.ek_netto_bnk AS NUMERIC), 1) AS ek_netto_bnk,
        COALESCE(CAST(b.ek_mep AS NUMERIC), 1) AS ek_mep,
        COALESCE(CAST(b.einstandspreis AS NUMERIC), 1) AS einstandspreis,
        COALESCE(b.komponentenmenge, 1) AS komponentenmenge,
        COALESCE(b.wrg_id, C.default_wrg) AS wrg_id,
        COALESCE(CAST(b.ek_nettonetto AS NUMERIC), 1) AS ek_nettonetto,
        CASE
            WHEN b.ek_netto IS NULL
                THEN 1
            ELSE 0
        END AS kein_zekp_fg
    FROM (
        SELECT
            dat_relevant,
            mandant_id,
            art_id,
            gp_id
        FROM `_hauptlieferant` AS A
        GROUP BY
            dat_relevant,
            mandant_id,
            art_id,
            gp_id
    ) AS a
    INNER JOIN dbp_data.mandant_1 AS C ON a.mandant_id = C.mandant_id
    LEFT JOIN (
        SELECT *
        FROM dbp_data.art_gp_wup_zu_per_1
        WHERE CAST(ek_netto AS NUMERIC) > 0
    ) AS b
        ON
            a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.gp_id = b.gp_id
            AND b.wup_id = -1 AND a.dat_relevant BETWEEN b.dat_von AND b.dat_bis
);


INSERT INTO `_art_wup_ek_zu_per_x` (
    art_id, mandant_id, wup_id, nb_id, dat_relevant, ek_netto, ek_netto_bnk, ek_mep,
    einstandspreis, komponentenmenge, wrg_id, ek_nettonetto, kein_zekp_fg
)
(
    SELECT
        A.art_id,
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.dat_relevant,
        A.ek_netto,
        A.ek_netto_bnk,
        A.ek_mep,
        A.einstandspreis,
        A.komponentenmenge,
        A.wrg_id,
        A.ek_nettonetto,
        A.kein_zekp_fg
    FROM `_art_wup_ek_zu_per_w` AS A
    INNER JOIN dbp_data.art_wup_ek_zu_per_1 AS Z
        ON
            A.mandant_id = Z.mandant_id AND A.wup_id = Z.wup_id AND A.art_id = Z.art_id AND A.dat_relevant BETWEEN Z.dat_von AND Z.dat_bis
    WHERE
        A.ek_netto <> CAST(Z.ek_netto AS NUMERIC)
        OR A.ek_netto_bnk <> CAST(Z.ek_netto_bnk AS NUMERIC)
        OR A.ek_mep <> CAST(Z.ek_mep AS NUMERIC)
        OR A.einstandspreis <> CAST(Z.einstandspreis AS NUMERIC)
        OR A.komponentenmenge <> Z.komponentenmenge
        OR A.ek_nettonetto <> CAST(Z.ek_nettonetto AS NUMERIC)
);


INSERT INTO `_art_wup_ek_zu_per_x` (
    art_id, mandant_id, wup_id, nb_id, dat_relevant, ek_netto, ek_netto_bnk, ek_mep,
    einstandspreis, komponentenmenge, wrg_id, ek_nettonetto, kein_zekp_fg
)
(
    SELECT *
    FROM `_art_wup_ek_zu_per_w` AS A
    WHERE (
        mandant_id, wup_id, art_id) NOT IN (
        SELECT (mandant_id, wup_id, art_id)
        FROM dbp_data.art_wup_ek_zu_per_1
    )
);


/* nur die Historie, die nicht neu kommt, übernehmen! */ INSERT INTO `_art_wup_ek_zu_per_tmp` (
    art_id, mandant_id,
    wup_id, nb_id, dat_von, dat_bis, ek_netto, ek_netto_bnk, ek_mep, einstandspreis, komponentenmenge, wrg_id,
    ek_nettonetto, kein_zekp_fg
)
(SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    dat_von,
    PARSE_DATE('%Y%m%d', '99991231') AS dat_bis,
    CAST(ek_netto AS NUMERIC) AS ek_netto,
    CAST(ek_netto_bnk AS NUMERIC) AS ek_netto_bnk,
    CAST(ek_mep AS NUMERIC) AS ek_mep,
    CAST(einstandspreis AS NUMERIC) AS einstandspreis,
    komponentenmenge,
    wrg_id,
    CAST(ek_nettonetto AS NUMERIC) AS ek_nettonetto,
    kein_zekp_fg
FROM dbp_data.art_wup_ek_zu_per_1
WHERE (
    mandant_id, wup_id, art_id) IN (
    SELECT (mandant_id, wup_id, art_id)
    FROM `_art_wup_ek_zu_per_x`
)
AND (
    mandant_id, wup_id, art_id, dat_von) NOT IN (
    SELECT (mandant_id, wup_id, art_id, dat_relevant)
    FROM `_art_wup_ek_zu_per_x`
));


INSERT INTO `_art_wup_ek_zu_per_tmp` (
    art_id, mandant_id, wup_id, nb_id, dat_von, dat_bis, ek_netto, ek_netto_bnk,
    ek_mep, einstandspreis, komponentenmenge, wrg_id, ek_nettonetto, kein_zekp_fg
)
(SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    dat_relevant AS dat_von,
    PARSE_DATE('%Y%m%d', '99991231') AS dat_bis,
    ek_netto,
    ek_netto_bnk,
    ek_mep,
    einstandspreis,
    komponentenmenge,
    wrg_id,
    ek_nettonetto,
    kein_zekp_fg
FROM `_art_wup_ek_zu_per_x`);


-- Falls mehrere neue Zuordnungen in ein bestehendes Intervall fallen

/* letzten Datesatz nicht einfuegen, dieser wird ersetzt */ INSERT INTO `_art_wup_ek_zu_per_tmp` (
    art_id, mandant_id,
    wup_id, nb_id, dat_von, dat_bis, ek_netto, ek_netto_bnk, ek_mep, einstandspreis, komponentenmenge, wrg_id,
    ek_nettonetto, kein_zekp_fg
)
(
    SELECT
        Z.art_id,
        Z.mandant_id,
        Z.wup_id,
        Z.nb_id,
        DATE_ADD(A.dat_relevant, INTERVAL 1 DAY) AS dat_von_,
        PARSE_DATE('%Y%m%d', '99991231') AS dat_bis_,
        CAST(Z.ek_netto AS NUMERIC) AS ek_netto_,
        CAST(Z.ek_netto_bnk AS NUMERIC) AS ek_netto_bnk_,
        CAST(Z.ek_mep AS NUMERIC) AS ek_mep_,
        CAST(Z.einstandspreis AS NUMERIC) AS einstandspreis_,
        Z.komponentenmenge,
        Z.wrg_id,
        CAST(Z.ek_nettonetto AS NUMERIC) AS ek_nettonetto_,
        Z.kein_zekp_fg
    FROM `_art_wup_ek_zu_per_x` AS A
    INNER JOIN dbp_data.art_wup_ek_zu_per_1 AS Z
        ON
            A.mandant_id = Z.mandant_id AND A.wup_id = Z.wup_id AND A.art_id = Z.art_id AND A.dat_relevant >= Z.dat_von AND /* innerhalb eines bestehenden Zeitraums */ A.dat_relevant
            < Z.dat_bis AND Z.dat_bis < PARSE_DATE('%Y%m%d', '99991231') AND (
                A.ek_netto <> CAST(Z.ek_netto AS NUMERIC) OR A.ek_netto_bnk <> CAST(Z.ek_netto_bnk AS NUMERIC) OR A.ek_mep <> CAST(Z.ek_mep AS NUMERIC) OR A.einstandspreis
                <> CAST(Z.einstandspreis AS NUMERIC) OR A.komponentenmenge <> Z.komponentenmenge OR A.ek_nettonetto <> CAST(Z.ek_nettonetto AS NUMERIC)
            )
    WHERE (Z.mandant_id, Z.art_id, Z.wup_id, DATE_ADD(A.dat_relevant, INTERVAL 1 DAY)) NOT IN (SELECT (
        mandant_id, art_id,
        wup_id, dat_relevant
    )
    FROM `_art_wup_ek_zu_per_x`)
    GROUP BY
        Z.art_id,
        Z.mandant_id,
        Z.wup_id,
        Z.nb_id,
        dat_von_,
        dat_bis_,
        ek_netto_,
        ek_netto_bnk_,
        ek_mep_,
        einstandspreis_,
        Z.komponentenmenge,
        Z.wrg_id,
        ek_nettonetto_,
        Z.kein_zekp_fg
);


-- kein Vorgänger da ist, oder die einen EK-Wechsel im Vergleich zum

-- Alle Datensätze markieren, die entweder keinen Wechsel haben, weil

/* COALESCE(MDIFF(ek_netto, 1, dat_von ASC), 1) AS ek_netto_wechsel_fg,
             COALESCE(MDIFF(ek_netto_bnk, 1, dat_von ASC), 1) AS ek_netto_bnk_wechsel_fg,
             COALESCE(MDIFF(ek_mep, 1, dat_von ASC), 1) AS ek_mep_wechsel_fg,
             COALESCE(MDIFF(einstandspreis, 1, dat_von ASC), 1) AS einstandspreis_wechsel_fg,
             COALESCE(MDIFF(komponentenmenge, 1, dat_von ASC), 1) AS komp_wechsel_fg,
             COALESCE(MDIFF(ek_nettonetto, 1, dat_von ASC), 1) AS ek_nettonetto_wechsel_fg */
-- Vorgänger aufweisen.
/* GROUP BY mandant_id,art_id,wup_id */ INSERT INTO `_art_wup_ek_zu_per_tmp2` (
    art_id,
    mandant_id, wup_id, nb_id, dat_von, dat_bis, ek_netto, ek_netto_bnk, ek_mep, einstandspreis, komponentenmenge, wrg_id,
    ek_nettonetto, kein_zekp_fg
)
(SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    dat_von,
    dat_bis,
    ek_netto,
    ek_netto_bnk,
    ek_mep,
    einstandspreis,
    komponentenmenge,
    wrg_id,
    ek_nettonetto,
    kein_zekp_fg
FROM `_art_wup_ek_zu_per_tmp`
QUALIFY COALESCE(ek_netto - (SUM(ek_netto) OVER (PARTITION BY
    mandant_id, art_id, wup_id ORDER BY
    dat_von IS NULL,
    dat_von
ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)), 1) <> 0 OR COALESCE(ek_netto_bnk - (SUM(ek_netto_bnk)
    OVER (
        PARTITION BY mandant_id, art_id, wup_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND
        1 PRECEDING)), 1) <> 0 OR COALESCE(ek_mep - (SUM(ek_mep) OVER (
    PARTITION BY mandant_id, art_id, wup_id
    ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
)), 1) <> 0 OR COALESCE(einstandspreis
- (SUM(einstandspreis) OVER (
    PARTITION BY mandant_id, art_id, wup_id ORDER BY dat_von IS NULL, dat_von
    ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
)), 1) <> 0 OR COALESCE(komponentenmenge - (SUM(komponentenmenge) OVER
(
    PARTITION BY mandant_id, art_id, wup_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND 1
    PRECEDING)), 1) <> 0 OR COALESCE(ek_nettonetto - (SUM(ek_nettonetto) OVER (
    PARTITION BY
        mandant_id, art_id,
        wup_id
    ORDER BY dat_von IS NULL, dat_von
    ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
)), 1) <> 0);


UPDATE `_art_wup_ek_zu_per_tmp2` AS `_art_wup_ek_zu_per_tmp20` SET
    dat_bis = dt1.dat_bis_ FROM (SELECT
    mandant_id,
    wup_id,
    art_id,
    dat_von,
    CASE
        WHEN (SUM(ROUND(
            CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (
            ORDER BY dat_von IS NULL, dat_von
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
        )) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von
        ) AS BIGNUMERIC), 0) = 0
        OR (LEAD(dat_von, 1, PARSE_DATE('%F', '9999-12-31')) OVER (
            PARTITION BY
                mandant_id, wup_id, art_id ORDER BY
                dat_von
                IS NULL, dat_von
        )) = PARSE_DATE('%F', '9999-12-31')
            THEN PARSE_DATE('%F', '9999-12-31')
        ELSE DATE_ADD(LEAD(dat_von, 1, PARSE_DATE(
            '%F', '9999-12-31')) OVER (
            PARTITION BY mandant_id, wup_id, art_id
            ORDER BY dat_von IS NULL, dat_von
        ), INTERVAL -1 DAY)
    END AS dat_bis_
FROM `_art_wup_ek_zu_per_tmp2`
QUALIFY CASE
    WHEN (SUM(ROUND(
        CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (
        ORDER BY dat_von IS NULL, dat_von
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    )) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von
    ) AS BIGNUMERIC), 0) = 0
    OR (LEAD(dat_von, 1, PARSE_DATE('%F', '9999-12-31')) OVER (
        PARTITION BY mandant_id, wup_id, art_id ORDER BY
            dat_von IS NULL, dat_von
    )) = PARSE_DATE('%F', '9999-12-31')
        THEN PARSE_DATE('%F', '9999-12-31')
    ELSE DATE_ADD(LEAD(dat_von, 1, PARSE_DATE(
        '%F', '9999-12-31')) OVER (
        PARTITION BY mandant_id, wup_id, art_id
        ORDER BY dat_von IS NULL, dat_von
    ), INTERVAL -1 DAY)
END <> dat_bis /* GROUP BY mandant_id,wup_id,art_id */) AS dt1
WHERE
    `_art_wup_ek_zu_per_tmp20`.mandant_id = dt1.mandant_id AND `_art_wup_ek_zu_per_tmp20`.wup_id = dt1.wup_id AND
    `_art_wup_ek_zu_per_tmp20`.art_id = dt1.art_id AND `_art_wup_ek_zu_per_tmp20`.dat_von = dt1.dat_von AND
    `_art_wup_ek_zu_per_tmp20`.dat_bis <> dt1.dat_bis_;


DELETE FROM dbp_data.art_wup_ek_zu_per_1 AS A
WHERE (
    mandant_id, wup_id, art_id) IN (
    SELECT (mandant_id, wup_id, art_id)
    FROM `_art_wup_ek_zu_per_x`
);


INSERT INTO dbp_data.art_wup_ek_zu_per_1 (
    art_id, mandant_id, wup_id, nb_id, dat_von, dat_bis, ek_netto,
    ek_netto_bnk, ek_mep, einstandspreis, komponentenmenge, wrg_id, ek_nettonetto, kein_zekp_fg
)
(
    SELECT *
    FROM `_art_wup_ek_zu_per_tmp2`
);


UPDATE dbp_etl_process.metadata_kmo_art_wup_ek_1 SET
    ende = CAST(CURRENT_TIMESTAMP() AS DATETIME)
WHERE ende IS NULL;
