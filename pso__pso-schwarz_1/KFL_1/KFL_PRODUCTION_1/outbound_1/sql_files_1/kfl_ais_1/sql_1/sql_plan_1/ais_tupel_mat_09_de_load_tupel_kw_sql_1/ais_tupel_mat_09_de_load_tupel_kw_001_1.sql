CREATE OR REPLACE TEMPORARY TABLE _zeitraum_woche AS
SELECT
    kjwo,
    kjwo_vj
FROM dbp_data.tag_1
WHERE akt_wo BETWEEN -63 AND (-1)
GROUP BY
    kjwo,
    kjwo_vj;


CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_tag_sum_de_1 (
    mandant_id INTEGER,
    dat DATE,
    wg_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    bewart_id INTEGER,
    menge NUMERIC(29, 3),
    umsatz_netto NUMERIC(29, 4),
    umsatz_brutto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_tag_1 (
    mandant_id INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    dat DATE,
    absatz NUMERIC(29, 3),
    absatz_sa NUMERIC(29, 3),
    absatz_af NUMERIC(29, 3),
    umsatz NUMERIC(29, 4),
    umsatz_sa NUMERIC(29, 4),
    umsatz_af NUMERIC(29, 4),
    umsatz_brutto NUMERIC(29, 4),
    umsatz_brutto_af NUMERIC(29, 4),
    umsatz_brutto_sa NUMERIC(29, 4),
    ertrag NUMERIC(29, 4),
    ertrag_sa NUMERIC(29, 4),
    ertrag_af NUMERIC(29, 4),
    anzahl_wochen_mit_absatz INTEGER,
    anzahl_wochen_mit_absatz_sa INTEGER,
    anzahl_wochen_mit_absatz_af INTEGER
);


INSERT INTO dbp_etl.bf_artbew_wg_art_tag_sum_de_1
(
    SELECT
        A.mandant_id,
        A.dat,
        B.wg_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.bewart_id,
        CAST(A.menge * d.umrech_faktor AS NUMERIC),
        A.umsatz_netto,
        A.umsatz_netto + A.umsatz_mwst_betrag AS umsatz_brutto,
        A.ek_mep
    FROM dbp_data.artbew_1 AS A
    INNER JOIN dbp_data.tag_1 AS C ON A.dat = C.dat
    INNER JOIN dbp_data.art_wg_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            MAX(umrech_faktor) AS umrech_faktor
        FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
        WHERE
            mandant_id = 1
            AND art_id <> -1
        GROUP BY
            mandant_id,
            art_id
    ) AS d ON A.art_id = d.art_id AND A.mandant_id = d.mandant_id
    WHERE
        C.kjwo IN (
            SELECT kjwo
            FROM `_zeitraum_woche`
        )
        AND A.mandant_id = 1
);


INSERT INTO dbp_etl.bf_listung_markt_tag_1 (
    mandant_id, wg_id, art_id, wup_id, nb_id, kreistyp_gruppe_id,
    dat, absatz, absatz_sa, absatz_af, umsatz, umsatz_sa, umsatz_af, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa,
    ertrag, ertrag_sa, ertrag_af, anzahl_wochen_mit_absatz, anzahl_wochen_mit_absatz_sa, anzahl_wochen_mit_absatz_af
)
(
    SELECT
        V01.mandant_id,
        V01.wg_id,
        V01.art_id,
        V01.wup_id,
        V01.nb_id,
        V04.kreistyp_gruppe_id,
        V01.dat,
        IFNULL(SUM(V01.menge), 0) AS absatz,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.menge
            ELSE NULL
        END), 0) AS NUMERIC) AS absatz_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.menge
            ELSE NULL
        END), 0) AS NUMERIC) AS absatz_af,
        IFNULL(SUM(V01.umsatz_netto), 0) AS umsatz,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_netto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_netto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_af,
        IFNULL(SUM(V01.umsatz_brutto), 0) AS umsatz_brutto,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_brutto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_brutto_af,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_brutto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_brutto_sa,
        IFNULL(SUM(V01.umsatz_netto - V01.ek_mep), 0) AS ertrag,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_netto - V01.ek_mep
            ELSE NULL
        END), 0) AS NUMERIC) AS ertrag_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_netto - V01.ek_mep
            ELSE NULL
        END), 0) AS NUMERIC) AS ertrag_af,
        IFNULL(CASE
            WHEN IFNULL(SUM(V01.menge), 0) > 0
                THEN COUNT(DISTINCT V01.dat)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz,
        IFNULL(CASE
            WHEN
                IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.menge
                    ELSE NULL
                END), 0) > 0 AND IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.menge
                    ELSE NULL
                END), 0) IS NOT NULL
                THEN COUNT(DISTINCT CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.dat
                    ELSE NULL
                END)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz_sa,
        IFNULL(CASE
            WHEN
                IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.menge
                    ELSE NULL
                END), 0) > 0 AND IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.menge
                    ELSE NULL
                END), 0) IS NOT NULL
                THEN COUNT(DISTINCT CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.dat
                    ELSE NULL
                END)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz_af
    FROM dbp_etl.bf_artbew_wg_art_tag_sum_de_1 AS V01
    INNER JOIN dbp_data.art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id

    INNER JOIN dbp_data.wup_1 AS V04
        ON
            V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
            = V04.mandant_id
    WHERE
        V01.mandant_id = 1
        AND V03.arthiertyp_id = 2
        AND V03.dat_bis = DATE '9999-12-31'
    GROUP BY
        V01.mandant_id,
        V01.wg_id,
        V01.art_id,
        V01.wup_id,
        V01.nb_id,
        V04.kreistyp_gruppe_id,
        V01.dat
);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_tag (
    dat DATE,
    matching_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT64,
    anz_wo_mit_absatz_af FLOAT64,
    anz_wo_mit_absatz_sa FLOAT64
);


INSERT INTO zzsp07_pre_tag
(
    SELECT
        A11.dat,
        b.art_matching_id AS matching_id,
        A11.mandant_id,
        A11.wup_id,
        CAST(CASE
            WHEN SUM(A11.absatz) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz,
        CAST(CASE
            WHEN SUM(A11.absatz_af) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz_af,
        CAST(CASE
            WHEN SUM(A11.absatz_sa) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz_sa
    FROM dbp_etl.bf_listung_markt_tag_1 AS A11
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
        WHERE art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
    GROUP BY
        A11.dat,
        matching_id,
        A11.mandant_id,
        A11.wup_id
);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_tag_xxx AS
SELECT
    A.mandant_id,
    A.matching_id,
    B.kjwo,
    SUM(A.anz_wo_mit_absatz) / 7.0000 AS anz_wo_mit_absatz,
    SUM(A.anz_wo_mit_absatz_af) / 7.0000 AS anz_wo_mit_absatz_af,
    SUM(A.anz_wo_mit_absatz_sa) / 7.0000 AS anz_wo_mit_absatz_sa
FROM zzsp07_pre_tag AS A
INNER JOIN dbp_data.tag_1 AS B ON A.dat = B.dat
GROUP BY
    A.mandant_id,
    A.matching_id,
    B.kjwo;


CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_wo_sum_de_1 (
    mandant_id INTEGER,
    kjwo INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    bewart_id INTEGER,
    menge NUMERIC(29, 3),
    umsatz_netto NUMERIC(29, 4),
    umsatz_brutto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_kw_1 (
    mandant_id INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    kjwo INTEGER,
    absatz NUMERIC(29, 3),
    absatz_sa NUMERIC(29, 3),
    absatz_af NUMERIC(29, 3),
    umsatz NUMERIC(29, 4),
    umsatz_sa NUMERIC(29, 4),
    umsatz_af NUMERIC(29, 4),
    umsatz_brutto NUMERIC(29, 4),
    umsatz_brutto_af NUMERIC(29, 4),
    umsatz_brutto_sa NUMERIC(29, 4),
    ertrag NUMERIC(29, 4),
    ertrag_sa NUMERIC(29, 4),
    ertrag_af NUMERIC(29, 4),
    anzahl_wochen_mit_absatz INTEGER,
    anzahl_wochen_mit_absatz_sa INTEGER,
    anzahl_wochen_mit_absatz_af INTEGER
);


INSERT INTO dbp_etl.bf_artbew_wg_art_wo_sum_de_1
(
    SELECT
        A.mandant_id,
        C.kjwo,
        B.wg_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.bewart_id,
        CAST(A.menge * d.umrech_faktor AS NUMERIC),
        A.umsatz_netto,
        A.umsatz_netto + A.umsatz_mwst_betrag AS umsatz_brutto,
        A.ek_mep
    FROM dbp_data.artbew_wo_sum_1 AS A
    INNER JOIN dbp_data.woche_kj_kl_1 AS C ON A.kjwo_kl = C.kjwo_kl
    INNER JOIN dbp_data.art_wg_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            MAX(umrech_faktor) AS umrech_faktor
        FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
        WHERE
            mandant_id = 1
            AND art_id <> -1
        GROUP BY
            mandant_id,
            art_id
    ) AS d ON A.art_id = d.art_id AND A.mandant_id = d.mandant_id
    WHERE
        C.kjwo IN (
            SELECT kjwo
            FROM `_zeitraum_woche`
        )
        AND A.mandant_id = 1
);


INSERT INTO dbp_etl.bf_listung_markt_kw_1 (
    mandant_id, wg_id, art_id, wup_id, nb_id, kreistyp_gruppe_id,
    kjwo, absatz, absatz_sa, absatz_af, umsatz, umsatz_sa, umsatz_af, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa,
    ertrag, ertrag_sa, ertrag_af, anzahl_wochen_mit_absatz, anzahl_wochen_mit_absatz_sa, anzahl_wochen_mit_absatz_af
)
(
    SELECT
        V01.mandant_id,
        V01.wg_id,
        V01.art_id,
        V01.wup_id,
        V01.nb_id,
        V04.kreistyp_gruppe_id,
        V01.kjwo,
        IFNULL(SUM(V01.menge), 0) AS absatz,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.menge
            ELSE NULL
        END), 0) AS NUMERIC) AS absatz_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.menge
            ELSE NULL
        END), 0) AS NUMERIC) AS absatz_af,
        IFNULL(SUM(V01.umsatz_netto), 0) AS umsatz,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_netto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_netto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_af,
        IFNULL(SUM(V01.umsatz_brutto), 0) AS umsatz_brutto,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_brutto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_brutto_af,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_brutto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_brutto_sa,
        IFNULL(SUM(V01.umsatz_netto - V01.ek_mep), 0) AS ertrag,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_netto - V01.ek_mep
            ELSE NULL
        END), 0) AS NUMERIC) AS ertrag_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_netto - V01.ek_mep
            ELSE NULL
        END), 0) AS NUMERIC) AS ertrag_af,
        IFNULL(CASE
            WHEN IFNULL(SUM(V01.menge), 0) > 0
                THEN COUNT(DISTINCT V01.kjwo)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz,
        IFNULL(CASE
            WHEN
                IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.menge
                    ELSE NULL
                END), 0) > 0 AND IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.menge
                    ELSE NULL
                END), 0) IS NOT NULL
                THEN COUNT(DISTINCT CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.kjwo
                    ELSE NULL
                END)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz_sa,
        IFNULL(CASE
            WHEN
                IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.menge
                    ELSE NULL
                END), 0) > 0 AND IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.menge
                    ELSE NULL
                END), 0) IS NOT NULL
                THEN COUNT(DISTINCT CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.kjwo
                    ELSE NULL
                END)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz_af
    FROM dbp_etl.bf_artbew_wg_art_wo_sum_de_1 AS V01
    INNER JOIN dbp_data.art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id

    INNER JOIN dbp_data.wup_1 AS V04
        ON
            V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
            = V04.mandant_id
    WHERE
        V01.mandant_id = 1
        AND V03.arthiertyp_id = 2
        AND V03.dat_bis = DATE '9999-12-31'
    GROUP BY
        V01.mandant_id,
        V01.wg_id,
        V01.art_id,
        V01.wup_id,
        V01.nb_id,
        V04.kreistyp_gruppe_id,
        V01.kjwo
);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre (
    kjwo INTEGER,
    matching_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT64,
    anz_wo_mit_absatz_af FLOAT64,
    anz_wo_mit_absatz_sa FLOAT64
);


INSERT INTO zzsp07_pre
(
    SELECT
        A11.kjwo,
        b.art_matching_id AS matching_id,
        A11.mandant_id,
        A11.wup_id,
        CAST(CASE
            WHEN SUM(A11.absatz) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz,
        CAST(CASE
            WHEN SUM(A11.absatz_af) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz_af,
        CAST(CASE
            WHEN SUM(A11.absatz_sa) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz_sa
    FROM dbp_etl.bf_listung_markt_kw_1 AS A11
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
        WHERE art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
    GROUP BY
        A11.kjwo,
        matching_id,
        A11.mandant_id,
        A11.wup_id
);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_xxx AS
SELECT
    mandant_id,
    matching_id,
    kjwo,
    SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
    SUM(anz_wo_mit_absatz_af) AS anz_wo_mit_absatz_af,
    SUM(anz_wo_mit_absatz_sa) AS anz_wo_mit_absatz_sa
FROM zzsp07_pre
GROUP BY
    mandant_id,
    matching_id,
    kjwo;


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre (
    kjwo INTEGER,
    matching_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    anz_wo_listung_1 FLOAT64
);


INSERT INTO zzsp08_pre
(
    SELECT
        A11.kjwo,
        b.art_matching_id AS matching_id,
        A11.mandant_id,
        A11.wup_id,
        CAST(COUNT(DISTINCT A11.kjwo) AS FLOAT64) AS anz_wo_listung_1
    FROM dbp_data.art_wup_listung_kjwo_1 AS A11
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
        WHERE art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
    WHERE
        A11.kjwo IN (
            SELECT kjwo
            FROM `_zeitraum_woche`
        )
        AND A11.mandant_id = 1
    GROUP BY
        A11.kjwo,
        matching_id,
        A11.mandant_id,
        A11.wup_id
);


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre_xxx AS
SELECT
    mandant_id,
    matching_id,
    kjwo,
    SUM(anz_wo_listung_1) AS anz_wo_listung_1
FROM zzsp08_pre
GROUP BY
    mandant_id,
    matching_id,
    kjwo;


CREATE OR REPLACE TEMPORARY TABLE _mm AS
SELECT
    A.kjwo,
    A.matching_id,
    A.mandant_id,
    A.wup_id,
    A.anz_wo_listung_1,
    B.anz_wo_mit_absatz
FROM zzsp08_pre AS A
INNER JOIN zzsp07_pre
    AS B ON A.mandant_id = B.mandant_id AND A.matching_id = B.matching_id AND A.wup_id = B.wup_id AND
A.kjwo = B.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _mm_y AS
SELECT
    A.kjwo,
    A.matching_id,
    A.mandant_id,
    A.wup_id,
    A.anz_wo_listung_1,
    B.anz_wo_mit_absatz
FROM zzsp08_pre AS A
INNER JOIN zzsp07_pre
    AS B ON A.mandant_id = B.mandant_id AND A.matching_id = B.matching_id AND A.wup_id = B.wup_id AND
A.kjwo = B.kjwo;


DELETE FROM `_mm_y`
WHERE anz_wo_mit_absatz = 0;


CREATE OR REPLACE TEMPORARY TABLE _mm_y_xxx AS
SELECT
    mandant_id,
    matching_id,
    kjwo,
    SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz
FROM `_mm_y`
GROUP BY
    mandant_id,
    matching_id,
    kjwo;


CREATE OR REPLACE TEMPORARY TABLE _mm_z AS
SELECT
    b.art_matching_id AS matching_id,
    A11.mandant_id,
    A11.kjwo,
    SUM(A11.umsatz_af) AS umsatz_af_mit_listung,
    SUM(A11.umsatz_sa) AS umsatz_sa_mit_listung,
    SUM(A11.umsatz_brutto_af) AS umsatz_brutto_af_mit_listung,
    SUM(A11.umsatz_brutto_sa) AS umsatz_brutto_sa_mit_listung,
    SUM(A11.ertrag_af) AS ertrag_af_mit_listung,
    SUM(A11.ertrag_sa) AS ertrag_sa_mit_listung,
    SUM(A11.absatz_af) AS absatz_af_mit_listung,
    SUM(A11.absatz_sa) AS absatz_sa_mit_listung
FROM dbp_etl.bf_listung_markt_kw_1 AS A11
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
INNER JOIN `_mm_y` AS C
    ON
        A11.mandant_id = C.mandant_id AND b.art_matching_id = C.matching_id AND A11.kjwo = C.kjwo
        AND A11.wup_id = C.wup_id
GROUP BY
    matching_id,
    A11.mandant_id,
    A11.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _mm_x AS
SELECT
    mandant_id,
    matching_id,
    kjwo,
    SUM(anz_wo_listung_1) AS anz_wo_mit_listung_absatz
FROM `_mm`
GROUP BY
    mandant_id,
    matching_id,
    kjwo;


INSERT INTO `_mm`
(SELECT
    kjwo,
    matching_id,
    mandant_id,
    wup_id,
    anz_wo_listung_1,
    0
FROM zzsp08_pre
WHERE (
    kjwo, matching_id, mandant_id, wup_id) NOT IN (
    SELECT (kjwo, matching_id, mandant_id, wup_id)
    FROM `_mm`
));


CREATE OR REPLACE TEMPORARY TABLE zzsp07 (
    matching_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    anz_wo_mit_absatz FLOAT64
);


INSERT INTO zzsp07
(
    SELECT
        matching_id,
        mandant_id,
        kjwo,
        SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz
    FROM `_mm` AS A11
    WHERE anz_wo_mit_absatz <> 0
    GROUP BY
        kjwo,
        matching_id,
        mandant_id
);


CREATE OR REPLACE TEMPORARY TABLE zzsp08 (
    matching_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    anz_wo_listung_1 FLOAT64
);


INSERT INTO zzsp08
(
    SELECT
        matching_id,
        mandant_id,
        kjwo,
        SUM(anz_wo_listung_1) AS anz_wo_listung_1
    FROM `_mm` AS A11
    GROUP BY
        kjwo,
        matching_id,
        mandant_id
);


CREATE OR REPLACE TEMPORARY TABLE zzoj09 (
    matching_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER
);


INSERT INTO zzoj09
(
    SELECT *
    FROM (
        SELECT
            matching_id,
            mandant_id,
            kjwo
        FROM zzsp07 AS PA11
        GROUP BY
            matching_id,
            mandant_id,
            kjwo
        UNION DISTINCT
        SELECT
            matching_id,
            mandant_id,
            kjwo
        FROM zzsp08 AS PA11
        GROUP BY
            matching_id,
            mandant_id,
            kjwo
    ) AS t1_1
);


CREATE OR REPLACE TEMPORARY TABLE zzmd0a_xxx (
    matching_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    wjxbfs1 FLOAT64,
    anz_wo_listung_1 FLOAT64,
    anz_wo_mit_absatz FLOAT64,
    schnelldreherquote FLOAT64
);


INSERT INTO zzmd0a_xxx
(
    SELECT
        PA11.matching_id,
        PA11.mandant_id,
        PA11.kjwo,
        1.0 AS wjxbfs1,
        PA13.anz_wo_listung_1,
        PA12.anz_wo_mit_absatz,
        ROUND(PA12.anz_wo_mit_absatz / IF(PA13.anz_wo_listung_1 = 0, NULL, PA13.anz_wo_listung_1) * 100, 1) AS schnelldreherquote
    FROM zzoj09 AS PA11
    LEFT JOIN zzsp07 AS PA12
        ON
            PA11.matching_id = PA12.matching_id AND PA11.mandant_id = PA12.mandant_id AND PA11.kjwo =
            PA12.kjwo
    LEFT JOIN
        zzsp08
            AS PA13
        ON
            PA11.matching_id = PA13.matching_id AND PA11.mandant_id = PA13.mandant_id AND PA11.kjwo =
            PA13.kjwo
);


CREATE OR REPLACE TEMPORARY TABLE _anz_wochen AS
SELECT
    A.kjwo,
    b.art_matching_id,
    A.wup_id,
    IFNULL(SUM(A.absatz), 0) AS absatz_,
    IFNULL(SUM(A.absatz_af), 0) AS absatz_af_,
    IFNULL(SUM(A.absatz_sa), 0) AS absatz_sa_,
    IFNULL(SUM(A.umsatz), 0) AS umsatz_,
    IFNULL(SUM(A.umsatz_af), 0) AS umsatz_af_,
    IFNULL(SUM(A.umsatz_sa), 0) AS umsatz_sa_,
    IFNULL(SUM(A.umsatz_brutto), 0) AS umsatz_brutto_,
    IFNULL(SUM(A.umsatz_brutto_af), 0) AS umsatz_brutto_af_,
    IFNULL(SUM(A.umsatz_brutto_sa), 0) AS umsatz_brutto_sa_,
    IFNULL(SUM(A.ertrag), 0) AS ertrag_,
    IFNULL(SUM(A.ertrag_af), 0) AS ertrag_af_,
    IFNULL(SUM(A.ertrag_sa), 0) AS ertrag_sa_,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.absatz), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.absatz_af), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.absatz_sa), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_sa,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz_af), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz_sa), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz_sa,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz_brutto), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz_brutto,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz_brutto_af), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz_brutto_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz_brutto_sa), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz_brutto_sa,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.ertrag), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_ertrag,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.ertrag_af), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_ertrag_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.ertrag_sa), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_ertrag_sa
FROM dbp_etl.bf_listung_markt_kw_1 AS A
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        status_1
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        art_matching_id,
        art_id,
        status_1
) AS b ON A.art_id = b.art_id
WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM `_zeitraum_woche`
    )
GROUP BY
    A.kjwo,
    b.art_matching_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _anz_wochen1 AS
SELECT
    art_matching_id,
    kjwo,
    SUM(absatz_) AS absatz,
    SUM(absatz_af_) AS absatz_af,
    SUM(absatz_sa_) AS absatz_sa,
    SUM(umsatz_) AS umsatz,
    SUM(umsatz_af_) AS umsatz_af,
    SUM(umsatz_sa_) AS umsatz_sa,
    SUM(umsatz_brutto_) AS umsatz_brutto,
    SUM(umsatz_brutto_af_) AS umsatz_brutto_af,
    SUM(umsatz_brutto_sa_) AS umsatz_brutto_sa,
    SUM(ertrag_) AS ertrag,
    SUM(ertrag_af_) AS ertrag_af,
    SUM(ertrag_sa_) AS ertrag_sa,
    SUM(anzahl_wochen_mit_umsatz) AS anzahl_wochen_mit_umsatz,
    SUM(anzahl_wochen_mit_umsatz_af) AS anzahl_wochen_mit_umsatz_af,
    SUM(anzahl_wochen_mit_umsatz_sa) AS anzahl_wochen_mit_umsatz_sa,
    SUM(anzahl_wochen_mit_umsatz_brutto) AS anzahl_wochen_mit_umsatz_brutto,
    SUM(anzahl_wochen_mit_umsatz_brutto_af) AS anzahl_wochen_mit_umsatz_brutto_af,
    SUM(anzahl_wochen_mit_umsatz_brutto_sa) AS anzahl_wochen_mit_umsatz_brutto_sa,
    SUM(anzahl_wochen_mit_ertrag) AS anzahl_wochen_mit_ertrag,
    SUM(anzahl_wochen_mit_ertrag_af) AS anzahl_wochen_mit_ertrag_af,
    SUM(anzahl_wochen_mit_ertrag_sa) AS anzahl_wochen_mit_ertrag_sa,
    SUM(anzahl_wochen_mit_absatz) AS anzahl_wochen_mit_absatz,
    SUM(anzahl_wochen_mit_absatz_af) AS anzahl_wochen_mit_absatz_af,
    SUM(anzahl_wochen_mit_absatz_sa) AS anzahl_wochen_mit_absatz_sa
FROM `_anz_wochen`
GROUP BY
    art_matching_id,
    kjwo;


CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_tag_sum_de_vj_1 (
    mandant_id INTEGER,
    dat DATE,
    wg_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    bewart_id INTEGER,
    menge NUMERIC(29, 3),
    umsatz_netto NUMERIC(29, 4),
    umsatz_brutto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_tag_vj_1 (
    mandant_id INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    dat DATE,
    absatz NUMERIC(29, 3),
    absatz_sa NUMERIC(29, 3),
    absatz_af NUMERIC(29, 3),
    umsatz NUMERIC(29, 4),
    umsatz_sa NUMERIC(29, 4),
    umsatz_af NUMERIC(29, 4),
    umsatz_brutto NUMERIC(29, 4),
    umsatz_brutto_af NUMERIC(29, 4),
    umsatz_brutto_sa NUMERIC(29, 4),
    ertrag NUMERIC(29, 4),
    ertrag_sa NUMERIC(29, 4),
    ertrag_af NUMERIC(29, 4),
    anzahl_wochen_mit_absatz INTEGER,
    anzahl_wochen_mit_absatz_sa INTEGER,
    anzahl_wochen_mit_absatz_af INTEGER
);


INSERT INTO dbp_etl.bf_artbew_wg_art_tag_sum_de_vj_1
(
    SELECT
        A.mandant_id,
        A.dat,
        B.wg_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.bewart_id,
        CAST(A.menge * d.umrech_faktor AS NUMERIC),
        A.umsatz_netto,
        A.umsatz_netto + A.umsatz_mwst_betrag AS umsatz_brutto,
        A.ek_mep
    FROM dbp_data.artbew_1 AS A
    INNER JOIN dbp_data.tag_1 AS C ON A.dat = C.dat
    INNER JOIN dbp_data.art_wg_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            MAX(umrech_faktor) AS umrech_faktor
        FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
        WHERE
            mandant_id = 1
            AND art_id <> -1
        GROUP BY
            mandant_id,
            art_id
    ) AS d ON A.art_id = d.art_id AND A.mandant_id = d.mandant_id
    WHERE
        C.kjwo IN (
            SELECT kjwo_vj
            FROM `_zeitraum_woche`
        )
        AND A.mandant_id = 1
);


INSERT INTO dbp_etl.bf_listung_markt_tag_vj_1 (
    mandant_id, wg_id, art_id, wup_id, nb_id, kreistyp_gruppe_id,
    dat, absatz, absatz_sa, absatz_af, umsatz, umsatz_sa, umsatz_af, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa,
    ertrag, ertrag_sa, ertrag_af, anzahl_wochen_mit_absatz, anzahl_wochen_mit_absatz_sa, anzahl_wochen_mit_absatz_af
)
(
    SELECT
        V01.mandant_id,
        V01.wg_id,
        V01.art_id,
        V01.wup_id,
        V01.nb_id,
        V04.kreistyp_gruppe_id,
        V01.dat,
        IFNULL(SUM(V01.menge), 0) AS absatz,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.menge
            ELSE NULL
        END), 0) AS NUMERIC) AS absatz_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.menge
            ELSE NULL
        END), 0) AS NUMERIC) AS absatz_af,
        IFNULL(SUM(V01.umsatz_netto), 0) AS umsatz,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_netto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_netto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_af,
        IFNULL(SUM(V01.umsatz_brutto), 0) AS umsatz_brutto,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_brutto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_brutto_af,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_brutto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_brutto_sa,
        IFNULL(SUM(V01.umsatz_netto - V01.ek_mep), 0) AS ertrag,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_netto - V01.ek_mep
            ELSE NULL
        END), 0) AS NUMERIC) AS ertrag_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_netto - V01.ek_mep
            ELSE NULL
        END), 0) AS NUMERIC) AS ertrag_af,
        IFNULL(CASE
            WHEN IFNULL(SUM(V01.menge), 0) > 0
                THEN COUNT(DISTINCT V01.dat)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz,
        IFNULL(CASE
            WHEN
                IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.menge
                    ELSE NULL
                END), 0) > 0 AND IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.menge
                    ELSE NULL
                END), 0) IS NOT NULL
                THEN COUNT(DISTINCT CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.dat
                    ELSE NULL
                END)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz_sa,
        IFNULL(CASE
            WHEN
                IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.menge
                    ELSE NULL
                END), 0) > 0 AND IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.menge
                    ELSE NULL
                END), 0) IS NOT NULL
                THEN COUNT(DISTINCT CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.dat
                    ELSE NULL
                END)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz_af
    FROM dbp_etl.bf_artbew_wg_art_tag_sum_de_vj_1 AS V01
    INNER JOIN dbp_data.art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id

    INNER JOIN dbp_data.wup_1 AS V04
        ON
            V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
            = V04.mandant_id
    WHERE
        V01.mandant_id = 1
        AND V03.arthiertyp_id = 2
        AND V03.dat_bis = DATE '9999-12-31'
    GROUP BY
        V01.mandant_id,
        V01.wg_id,
        V01.art_id,
        V01.wup_id,
        V01.nb_id,
        V04.kreistyp_gruppe_id,
        V01.dat
);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_tag_vj (
    dat DATE,
    matching_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT64,
    anz_wo_mit_absatz_af FLOAT64,
    anz_wo_mit_absatz_sa FLOAT64
);


INSERT INTO zzsp07_pre_tag_vj
(
    SELECT
        A11.dat,
        b.art_matching_id AS matching_id,
        A11.mandant_id,
        A11.wup_id,
        CAST(CASE
            WHEN SUM(A11.absatz) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz,
        CAST(CASE
            WHEN SUM(A11.absatz_af) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz_af,
        CAST(CASE
            WHEN SUM(A11.absatz_sa) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz_sa
    FROM dbp_etl.bf_listung_markt_tag_vj_1 AS A11
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
        WHERE art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
    GROUP BY
        A11.dat,
        matching_id,
        A11.mandant_id,
        A11.wup_id
);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_tag_vj_xxx AS
SELECT
    A.mandant_id,
    A.matching_id,
    B.kjwo,
    SUM(A.anz_wo_mit_absatz) / 7.0000 AS anz_wo_mit_absatz,
    SUM(A.anz_wo_mit_absatz_af) / 7.0000 AS anz_wo_mit_absatz_af,
    SUM(A.anz_wo_mit_absatz_sa) / 7.0000 AS anz_wo_mit_absatz_sa
FROM zzsp07_pre_tag_vj AS A
INNER JOIN dbp_data.tag_1 AS B ON A.dat = B.dat
GROUP BY
    A.mandant_id,
    A.matching_id,
    B.kjwo;


CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_wo_sum_de_vj_1 (
    mandant_id INTEGER,
    kjwo INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    bewart_id INTEGER,
    menge NUMERIC(29, 3),
    umsatz_netto NUMERIC(29, 4),
    umsatz_brutto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.bf_listung_markt_kw_vj_1 (
    mandant_id INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    kjwo INTEGER,
    absatz NUMERIC(29, 3),
    absatz_sa NUMERIC(29, 3),
    absatz_af NUMERIC(29, 3),
    umsatz NUMERIC(29, 4),
    umsatz_sa NUMERIC(29, 4),
    umsatz_af NUMERIC(29, 4),
    umsatz_brutto NUMERIC(29, 4),
    umsatz_brutto_af NUMERIC(29, 4),
    umsatz_brutto_sa NUMERIC(29, 4),
    ertrag NUMERIC(29, 4),
    ertrag_sa NUMERIC(29, 4),
    ertrag_af NUMERIC(29, 4),
    anzahl_wochen_mit_absatz INTEGER,
    anzahl_wochen_mit_absatz_sa INTEGER,
    anzahl_wochen_mit_absatz_af INTEGER
);


INSERT INTO dbp_etl.bf_artbew_wg_art_wo_sum_de_vj_1
(
    SELECT
        A.mandant_id,
        C.kjwo,
        B.wg_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.bewart_id,
        CAST(A.menge * d.umrech_faktor AS NUMERIC),
        A.umsatz_netto,
        A.umsatz_netto + A.umsatz_mwst_betrag AS umsatz_brutto,
        A.ek_mep
    FROM dbp_data.artbew_wo_sum_1 AS A
    INNER JOIN dbp_data.woche_kj_kl_1 AS C ON A.kjwo_kl = C.kjwo_kl
    INNER JOIN dbp_data.art_wg_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            MAX(umrech_faktor) AS umrech_faktor
        FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
        WHERE
            mandant_id = 1
            AND art_id <> -1
        GROUP BY
            mandant_id,
            art_id
    ) AS d ON A.art_id = d.art_id AND A.mandant_id = d.mandant_id
    WHERE
        C.kjwo IN (
            SELECT kjwo_vj
            FROM `_zeitraum_woche`
        )
        AND A.mandant_id = 1
);


INSERT INTO dbp_etl.bf_listung_markt_kw_vj_1 (
    mandant_id, wg_id, art_id, wup_id, nb_id, kreistyp_gruppe_id,
    kjwo, absatz, absatz_sa, absatz_af, umsatz, umsatz_sa, umsatz_af, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa,
    ertrag, ertrag_sa, ertrag_af, anzahl_wochen_mit_absatz, anzahl_wochen_mit_absatz_sa, anzahl_wochen_mit_absatz_af
)
(
    SELECT
        V01.mandant_id,
        V01.wg_id,
        V01.art_id,
        V01.wup_id,
        V01.nb_id,
        V04.kreistyp_gruppe_id,
        V01.kjwo,
        IFNULL(SUM(V01.menge), 0) AS absatz,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.menge
            ELSE NULL
        END), 0) AS NUMERIC) AS absatz_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.menge
            ELSE NULL
        END), 0) AS NUMERIC) AS absatz_af,
        IFNULL(SUM(V01.umsatz_netto), 0) AS umsatz,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_netto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_netto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_af,
        IFNULL(SUM(V01.umsatz_brutto), 0) AS umsatz_brutto,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_brutto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_brutto_af,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_brutto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_brutto_sa,
        IFNULL(SUM(V01.umsatz_netto - V01.ek_mep), 0) AS ertrag,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_netto - V01.ek_mep
            ELSE NULL
        END), 0) AS NUMERIC) AS ertrag_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_netto - V01.ek_mep
            ELSE NULL
        END), 0) AS NUMERIC) AS ertrag_af,
        IFNULL(CASE
            WHEN IFNULL(SUM(V01.menge), 0) > 0
                THEN COUNT(DISTINCT V01.kjwo)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz,
        IFNULL(CASE
            WHEN
                IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.menge
                    ELSE NULL
                END), 0) > 0 AND IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.menge
                    ELSE NULL
                END), 0) IS NOT NULL
                THEN COUNT(DISTINCT CASE
                    WHEN V01.bewart_id = 1002
                        THEN V01.kjwo
                    ELSE NULL
                END)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz_sa,
        IFNULL(CASE
            WHEN
                IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.menge
                    ELSE NULL
                END), 0) > 0 AND IFNULL(SUM(CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.menge
                    ELSE NULL
                END), 0) IS NOT NULL
                THEN COUNT(DISTINCT CASE
                    WHEN V01.bewart_id = 1001
                        THEN V01.kjwo
                    ELSE NULL
                END)
            ELSE NULL
        END, 0) AS anzahl_wochen_mit_absatz_af
    FROM dbp_etl.bf_artbew_wg_art_wo_sum_de_vj_1 AS V01
    INNER JOIN dbp_data.art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id

    INNER JOIN dbp_data.wup_1 AS V04
        ON
            V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
            = V04.mandant_id
    WHERE
        V01.mandant_id = 1
        AND V03.arthiertyp_id = 2
        AND V03.dat_bis = DATE '9999-12-31'
    GROUP BY
        V01.mandant_id,
        V01.wg_id,
        V01.art_id,
        V01.wup_id,
        V01.nb_id,
        V04.kreistyp_gruppe_id,
        V01.kjwo
);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_vj (
    kjwo INTEGER,
    matching_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT64,
    anz_wo_mit_absatz_af FLOAT64,
    anz_wo_mit_absatz_sa FLOAT64
);


INSERT INTO zzsp07_pre_vj
(
    SELECT
        A11.kjwo,
        b.art_matching_id AS matching_id,
        A11.mandant_id,
        A11.wup_id,
        CAST(CASE
            WHEN SUM(A11.absatz) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz,
        CAST(CASE
            WHEN SUM(A11.absatz_af) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz_af,
        CAST(CASE
            WHEN SUM(A11.absatz_sa) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz_sa
    FROM dbp_etl.bf_listung_markt_kw_vj_1 AS A11
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
        WHERE art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
    GROUP BY
        A11.kjwo,
        matching_id,
        A11.mandant_id,
        A11.wup_id
);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_vj_xxx AS
SELECT
    mandant_id,
    matching_id,
    kjwo,
    SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
    SUM(anz_wo_mit_absatz_af) AS anz_wo_mit_absatz_af,
    SUM(anz_wo_mit_absatz_sa) AS anz_wo_mit_absatz_sa
FROM zzsp07_pre_vj
GROUP BY
    mandant_id,
    matching_id,
    kjwo;


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre_vj (
    kjwo INTEGER,
    matching_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    anz_wo_listung_1 FLOAT64
);


INSERT INTO zzsp08_pre_vj
(
    SELECT
        A11.kjwo,
        b.art_matching_id AS matching_id,
        A11.mandant_id,
        A11.wup_id,
        CAST(COUNT(DISTINCT A11.kjwo) AS FLOAT64) AS anz_wo_listung_1
    FROM dbp_data.art_wup_listung_kjwo_1 AS A11
    INNER JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
        WHERE art_id <> -1
        GROUP BY
            mandant_id,
            art_matching_id,
            art_id
    ) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
    WHERE
        A11.kjwo IN (
            SELECT kjwo_vj
            FROM `_zeitraum_woche`
        )
        AND A11.mandant_id = 1
    GROUP BY
        A11.kjwo,
        matching_id,
        A11.mandant_id,
        A11.wup_id
);


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre_vj_xxx AS
SELECT
    mandant_id,
    matching_id,
    kjwo,
    SUM(anz_wo_listung_1) AS anz_wo_listung_1
FROM zzsp08_pre_vj
GROUP BY
    mandant_id,
    matching_id,
    kjwo;


CREATE OR REPLACE TEMPORARY TABLE _mm_vj AS
SELECT
    A.kjwo,
    A.matching_id,
    A.mandant_id,
    A.wup_id,
    A.anz_wo_listung_1,
    B.anz_wo_mit_absatz
FROM zzsp08_pre_vj AS A
INNER JOIN zzsp07_pre_vj
    AS B ON A.mandant_id = B.mandant_id AND A.matching_id = B.matching_id AND A.wup_id = B.wup_id
AND A.kjwo = B.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _mm_y_vj AS
SELECT
    A.kjwo,
    A.matching_id,
    A.mandant_id,
    A.wup_id,
    A.anz_wo_listung_1,
    B.anz_wo_mit_absatz
FROM zzsp08_pre_vj AS A
INNER JOIN zzsp07_pre_vj
    AS B ON A.mandant_id = B.mandant_id AND A.matching_id = B.matching_id AND A.wup_id = B.wup_id
AND A.kjwo = B.kjwo;


DELETE FROM `_mm_y_vj`
WHERE anz_wo_mit_absatz = 0;


CREATE OR REPLACE TEMPORARY TABLE _mm_z_vj AS
SELECT
    b.art_matching_id AS matching_id,
    A11.mandant_id,
    A11.kjwo,
    SUM(A11.umsatz_af) AS umsatz_af_mit_listung,
    SUM(A11.umsatz_sa) AS umsatz_sa_mit_listung,
    SUM(A11.umsatz_brutto_af) AS umsatz_brutto_af_mit_listung,
    SUM(A11.umsatz_brutto_sa) AS umsatz_brutto_sa_mit_listung,
    SUM(A11.ertrag_af) AS ertrag_af_mit_listung,
    SUM(A11.ertrag_sa) AS ertrag_sa_mit_listung,
    SUM(A11.absatz_af) AS absatz_af_mit_listung,
    SUM(A11.absatz_sa) AS absatz_sa_mit_listung
FROM dbp_etl.bf_listung_markt_kw_vj_1 AS A11
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS b ON A11.art_id = b.art_id AND A11.mandant_id = b.mandant_id
INNER JOIN `_mm_y_vj` AS C
    ON
        A11.mandant_id = C.mandant_id AND b.art_matching_id = C.matching_id AND A11.kjwo = C.kjwo
        AND A11.wup_id = C.wup_id
GROUP BY
    matching_id,
    A11.mandant_id,
    A11.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _mm_x_vj AS
SELECT
    mandant_id,
    matching_id,
    kjwo,
    SUM(anz_wo_listung_1) AS anz_wo_mit_listung_absatz
FROM `_mm_vj`
GROUP BY
    mandant_id,
    matching_id,
    kjwo;


INSERT INTO `_mm_vj`
(SELECT
    kjwo,
    matching_id,
    mandant_id,
    wup_id,
    anz_wo_listung_1,
    0
FROM zzsp08_pre_vj
WHERE (
    kjwo, matching_id, mandant_id, wup_id) NOT IN (
    SELECT (kjwo, matching_id, mandant_id, wup_id)
    FROM `_mm_vj`
));


CREATE OR REPLACE TEMPORARY TABLE zzsp07_vj (
    matching_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    anz_wo_mit_absatz FLOAT64
);


INSERT INTO zzsp07_vj
(
    SELECT
        matching_id,
        mandant_id,
        kjwo,
        SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz
    FROM `_mm_vj` AS A11
    WHERE anz_wo_mit_absatz <> 0
    GROUP BY
        kjwo,
        matching_id,
        mandant_id
);


CREATE OR REPLACE TEMPORARY TABLE zzsp08_vj (
    matching_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    anz_wo_listung_1 FLOAT64
);


INSERT INTO zzsp08_vj
(
    SELECT
        matching_id,
        mandant_id,
        kjwo,
        SUM(anz_wo_listung_1) AS anz_wo_listung_1
    FROM `_mm_vj` AS A11
    GROUP BY
        kjwo,
        matching_id,
        mandant_id
);


CREATE OR REPLACE TEMPORARY TABLE zzoj09_vj (
    matching_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER
);


INSERT INTO zzoj09_vj
(
    SELECT *
    FROM (
        SELECT
            matching_id,
            mandant_id,
            kjwo
        FROM zzsp07_vj AS PA11
        GROUP BY
            matching_id,
            mandant_id,
            kjwo
        UNION DISTINCT
        SELECT
            matching_id,
            mandant_id,
            kjwo
        FROM zzsp08_vj AS PA11
        GROUP BY
            matching_id,
            mandant_id,
            kjwo
    ) AS t1_1
);


CREATE OR REPLACE TEMPORARY TABLE zzmd0a_xxx_vj (
    matching_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    wjxbfs1 FLOAT64,
    anz_wo_listung_1 FLOAT64,
    anz_wo_mit_absatz FLOAT64,
    schnelldreherquote FLOAT64
);


INSERT INTO zzmd0a_xxx_vj
(
    SELECT
        PA11.matching_id,
        PA11.mandant_id,
        PA11.kjwo,
        1.0 AS wjxbfs1,
        PA13.anz_wo_listung_1,
        PA12.anz_wo_mit_absatz,
        ROUND(PA12.anz_wo_mit_absatz / IF(PA13.anz_wo_listung_1 = 0, NULL, PA13.anz_wo_listung_1) * 100, 1) AS schnelldreherquote
    FROM zzoj09_vj AS PA11
    LEFT JOIN zzsp07_vj AS PA12
        ON
            PA11.matching_id = PA12.matching_id AND PA11.mandant_id = PA12.mandant_id AND PA11.kjwo
            = PA12.kjwo
    LEFT JOIN
        zzsp08_vj
            AS PA13
        ON
            PA11.matching_id = PA13.matching_id AND PA11.mandant_id = PA13.mandant_id AND PA11.kjwo
            = PA13.kjwo
);


CREATE OR REPLACE TEMPORARY TABLE _anz_wochen_vj AS
SELECT
    A.kjwo,
    b.art_matching_id,
    A.wup_id,
    IFNULL(SUM(A.absatz), 0) AS absatz_,
    IFNULL(SUM(A.absatz_af), 0) AS absatz_af_,
    IFNULL(SUM(A.absatz_sa), 0) AS absatz_sa_,
    IFNULL(SUM(A.umsatz), 0) AS umsatz_,
    IFNULL(SUM(A.umsatz_af), 0) AS umsatz_af_,
    IFNULL(SUM(A.umsatz_sa), 0) AS umsatz_sa_,
    IFNULL(SUM(A.umsatz_brutto), 0) AS umsatz_brutto_,
    IFNULL(SUM(A.umsatz_brutto_af), 0) AS umsatz_brutto_af_,
    IFNULL(SUM(A.umsatz_brutto_sa), 0) AS umsatz_brutto_sa_,
    IFNULL(SUM(A.ertrag), 0) AS ertrag_,
    IFNULL(SUM(A.ertrag_af), 0) AS ertrag_af_,
    IFNULL(SUM(A.ertrag_sa), 0) AS ertrag_sa_,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.absatz), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.absatz_af), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.absatz_sa), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_sa,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz_af), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz_sa), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz_sa,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz_brutto), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz_brutto,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz_brutto_af), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz_brutto_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.umsatz_brutto_sa), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_umsatz_brutto_sa,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.ertrag), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_ertrag,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.ertrag_af), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_ertrag_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.ertrag_sa), 0) > 0
            THEN COUNT(DISTINCT A.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_ertrag_sa
FROM dbp_etl.bf_listung_markt_kw_vj_1 AS A
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        status_1
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        art_matching_id,
        art_id,
        status_1
) AS b ON A.art_id = b.art_id
WHERE
    A.kjwo IN (
        SELECT kjwo_vj
        FROM `_zeitraum_woche`
    )
GROUP BY
    A.kjwo,
    b.art_matching_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _anz_wochen1_vj AS
SELECT
    art_matching_id,
    kjwo,
    SUM(absatz_) AS absatz,
    SUM(absatz_af_) AS absatz_af,
    SUM(absatz_sa_) AS absatz_sa,
    SUM(umsatz_) AS umsatz,
    SUM(umsatz_af_) AS umsatz_af,
    SUM(umsatz_sa_) AS umsatz_sa,
    SUM(umsatz_brutto_) AS umsatz_brutto,
    SUM(umsatz_brutto_af_) AS umsatz_brutto_af,
    SUM(umsatz_brutto_sa_) AS umsatz_brutto_sa,
    SUM(ertrag_) AS ertrag,
    SUM(ertrag_af_) AS ertrag_af,
    SUM(ertrag_sa_) AS ertrag_sa,
    SUM(anzahl_wochen_mit_umsatz) AS anzahl_wochen_mit_umsatz,
    SUM(anzahl_wochen_mit_umsatz_af) AS anzahl_wochen_mit_umsatz_af,
    SUM(anzahl_wochen_mit_umsatz_sa) AS anzahl_wochen_mit_umsatz_sa,
    SUM(anzahl_wochen_mit_umsatz_brutto) AS anzahl_wochen_mit_umsatz_brutto,
    SUM(anzahl_wochen_mit_umsatz_brutto_af) AS anzahl_wochen_mit_umsatz_brutto_af,
    SUM(anzahl_wochen_mit_umsatz_brutto_sa) AS anzahl_wochen_mit_umsatz_brutto_sa,
    SUM(anzahl_wochen_mit_ertrag) AS anzahl_wochen_mit_ertrag,
    SUM(anzahl_wochen_mit_ertrag_af) AS anzahl_wochen_mit_ertrag_af,
    SUM(anzahl_wochen_mit_ertrag_sa) AS anzahl_wochen_mit_ertrag_sa,
    SUM(anzahl_wochen_mit_absatz) AS anzahl_wochen_mit_absatz,
    SUM(anzahl_wochen_mit_absatz_af) AS anzahl_wochen_mit_absatz_af,
    SUM(anzahl_wochen_mit_absatz_sa) AS anzahl_wochen_mit_absatz_sa
FROM `_anz_wochen_vj`
GROUP BY
    art_matching_id,
    kjwo;


CREATE OR REPLACE VIEW dbp_etl.mv_listung_markt_kw_1 (
    mandant_id, wg_id, art_id, wup_id, nb_id,
    kreistyp_gruppe_id, kjwo, absatz, absatz_sa, absatz_af, anz_wo_mit_absatz, anz_wo_mit_absatz_sa, anz_wo_mit_absatz_af
)
AS SELECT
    V01.mandant_id,
    V01.wg_id,
    V01.art_id,
    V01.wup_id,
    V01.nb_id,
    V04.kreistyp_gruppe_id,
    V01.kjwo,
    IFNULL(SUM(V01.menge), 0) AS absatz,
    IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1002
            THEN V01.menge
        ELSE NULL
    END), 0) AS absatz_sa,
    IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1001
            THEN V01.menge
        ELSE NULL
    END), 0) AS absatz_af,
    IFNULL(COUNT(DISTINCT V01.kjwo), 0) AS anzahl_wochen_mit_absatz,
    IFNULL(COUNT(DISTINCT CASE
        WHEN V01.bewart_id = 1002
            THEN V01.kjwo
        ELSE NULL
    END), 0) AS anzahl_wochen_mit_absatz_sa,
    IFNULL(COUNT(DISTINCT CASE
        WHEN V01.bewart_id = 1001
            THEN V01.kjwo
        ELSE NULL
    END), 0) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_wo_sum_de_1 AS V01
INNER JOIN dbp_data.art_wg_zu_per_1 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
INNER JOIN dbp_data.wup_1 AS V04
    ON
        V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id =
        V04.mandant_id
WHERE
    V01.mandant_id = 1
    AND V03.arthiertyp_id = 2
    AND V03.dat_bis = DATE '9999-12-31'
GROUP BY
    V01.mandant_id,
    V01.wg_id,
    V01.art_id,
    V01.wup_id,
    V01.nb_id,
    V04.kreistyp_gruppe_id,
    V01.kjwo;


CREATE OR REPLACE TEMPORARY TABLE zzmd0e (
    art_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    absatz_sk1 FLOAT64,
    anz_wo_mit_abs_sk1 FLOAT64,
    absatz_sk2 FLOAT64,
    anz_wo_mit_abs_sk2 FLOAT64,
    absatz_sk3 FLOAT64,
    anz_wo_mit_abs_sk3 FLOAT64,
    absatz_sk4 FLOAT64,
    anz_wo_mit_abs_sk4 FLOAT64,
    absatz_sk5 FLOAT64,
    anz_wo_mit_abs_sk5 FLOAT64,
    absatz_sk6 FLOAT64,
    anz_wo_mit_abs_sk6 FLOAT64,
    absatz_sk7 FLOAT64,
    anz_wo_mit_abs_sk7 FLOAT64,
    absatz_af_sk1_bis6 FLOAT64,
    absatz_sa_sk1_bis6 FLOAT64
);


INSERT INTO zzmd0e
(
    SELECT
        A11.art_id,
        A11.mandant_id,
        T.kjwo,
        CAST(SUM(CASE
            WHEN A14.sm_id = 1 AND A14.mandant_id = 1
                THEN A11.absatz
            ELSE NULL
        END) AS FLOAT64) AS absatz_sk1,
        CAST(SUM(CASE
            WHEN A14.sm_id = 1 AND A14.mandant_id = 1
                THEN A11.anzahl_wochen_mit_absatz
            ELSE NULL
        END) AS FLOAT64) AS anz_wo_mit_abs_sk1,
        CAST(SUM(CASE
            WHEN A14.sm_id = 2 AND A14.mandant_id = 1
                THEN A11.absatz
            ELSE NULL
        END) AS FLOAT64) AS absatz_sk2,
        CAST(SUM(CASE
            WHEN A14.sm_id = 2 AND A14.mandant_id = 1
                THEN A11.anzahl_wochen_mit_absatz
            ELSE NULL
        END) AS FLOAT64) AS anz_wo_mit_abs_sk2,
        CAST(SUM(CASE
            WHEN A14.sm_id = 3 AND A14.mandant_id = 1
                THEN A11.absatz
            ELSE NULL
        END) AS FLOAT64) AS absatz_sk3,
        CAST(SUM(CASE
            WHEN A14.sm_id = 3 AND A14.mandant_id = 1
                THEN A11.anzahl_wochen_mit_absatz
            ELSE NULL
        END) AS FLOAT64) AS anz_wo_mit_abs_sk3,
        CAST(SUM(CASE
            WHEN A14.sm_id = 4 AND A14.mandant_id = 1
                THEN A11.absatz
            ELSE NULL
        END) AS FLOAT64) AS absatz_sk4,
        CAST(SUM(CASE
            WHEN A14.sm_id = 4 AND A14.mandant_id = 1
                THEN A11.anzahl_wochen_mit_absatz
            ELSE NULL
        END) AS FLOAT64) AS anz_wo_mit_abs_sk4,
        CAST(SUM(CASE
            WHEN A14.sm_id = 5 AND A14.mandant_id = 1
                THEN A11.absatz
            ELSE NULL
        END) AS FLOAT64) AS absatz_sk5,
        CAST(SUM(CASE
            WHEN A14.sm_id = 5 AND A14.mandant_id = 1
                THEN A11.anzahl_wochen_mit_absatz
            ELSE NULL
        END) AS FLOAT64) AS anz_wo_mit_abs_sk5,
        CAST(SUM(CASE
            WHEN A14.sm_id = 6 AND A14.mandant_id = 1
                THEN A11.absatz
            ELSE NULL
        END) AS FLOAT64) AS absatz_sk6,
        CAST(SUM(CASE
            WHEN A14.sm_id = 6 AND A14.mandant_id = 1
                THEN A11.anzahl_wochen_mit_absatz
            ELSE NULL
        END) AS FLOAT64) AS anz_wo_mit_abs_sk6,
        CAST(SUM(CASE
            WHEN A14.sm_id = 7 AND A14.mandant_id = 1
                THEN A11.absatz
            ELSE NULL
        END) AS FLOAT64) AS absatz_sk7,
        CAST(SUM(CASE
            WHEN A14.sm_id = 7 AND A14.mandant_id = 1
                THEN A11.anzahl_wochen_mit_absatz
            ELSE NULL
        END) AS FLOAT64) AS anz_wo_mit_abs_sk7,
        CAST(SUM(CASE
            WHEN A14.mandant_id = 1 AND A14.sm_id IN (1, 2, 3, 4, 5, 6, 7)
                THEN A11.absatz_af
            ELSE NULL
        END) AS FLOAT64) AS absatz_af_sk1_bis6,
        CAST(SUM(CASE
            WHEN A14.mandant_id = 1 AND A14.sm_id IN (1, 2, 3, 4, 5, 6, 7)
                THEN A11.absatz_sa
            ELSE NULL
        END) AS FLOAT64) AS absatz_sa_sk1_bis6
    FROM dbp_etl.bf_listung_markt_tag_1 AS A11
    INNER JOIN dbp_data.tag_1 AS T ON A11.dat = T.dat
    INNER JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per_1 AS A14
        ON
            A11.mandant_id = A14.mandant_id AND A11.nb_id =
            A14.nb_id AND A11.wg_id = A14.wg_id AND A11.wup_id = A14.wup_id
    WHERE
        A14.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_1
            WHERE
                mandant_id = 1
                AND wg_filter_id = 11
                AND arthiertyp_id = 2
        )
        AND A11.mandant_id = 1
        AND (
            A14.sm_id = 1 AND A14.mandant_id = 1 OR A14.sm_id = 2 AND A14.mandant_id = 1 OR A14.sm_id = 3 AND A14.mandant_id
            = 1 OR A14.sm_id = 4 AND A14.mandant_id = 1 OR A14.sm_id = 5 AND A14.mandant_id = 1 OR A14.sm_id = 6 AND A14.mandant_id = 1 OR A14.sm_id = 7 AND A14.mandant_id = 1 OR A14.mandant_id = 1 AND A14.sm_id IN (
                1, 2, 3, 4, 5, 6,
                7
            )
        )
    GROUP BY
        A11.art_id,
        A11.mandant_id,
        T.kjwo
);


CREATE OR REPLACE TEMPORARY TABLE zzmd0e1 AS
SELECT
    b.art_matching_id,
    A.kjwo,
    SUM(A.absatz_sk1) AS absatz_sk1,
    SUM(A.anz_wo_mit_abs_sk1) / 7.0000 AS anz_wo_mit_abs_sk1,
    SUM(A.absatz_sk2) AS absatz_sk2,
    SUM(A.anz_wo_mit_abs_sk2) / 7.0000 AS anz_wo_mit_abs_sk2,
    SUM(A.absatz_sk3) AS absatz_sk3,
    SUM(A.anz_wo_mit_abs_sk3) / 7.0000 AS anz_wo_mit_abs_sk3,
    SUM(A.absatz_sk4) AS absatz_sk4,
    SUM(A.anz_wo_mit_abs_sk4) / 7.0000 AS anz_wo_mit_abs_sk4,
    SUM(A.absatz_sk5) AS absatz_sk5,
    SUM(A.anz_wo_mit_abs_sk5) / 7.0000 AS anz_wo_mit_abs_sk5,
    SUM(A.absatz_sk6) AS absatz_sk6,
    SUM(A.anz_wo_mit_abs_sk6) / 7.0000 AS anz_wo_mit_abs_sk6,
    SUM(A.absatz_sk7) AS absatz_sk7,
    SUM(A.anz_wo_mit_abs_sk7) / 7.0000 AS anz_wo_mit_abs_sk7,
    SUM(A.absatz_af_sk1_bis6) AS absatz_af_sk1_bis6,
    SUM(A.absatz_sa_sk1_bis6) AS absatz_sa_sk1_bis6
FROM zzmd0e AS A
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        status_1
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        art_matching_id,
        art_id,
        status_1
) AS b ON A.art_id = b.art_id
GROUP BY
    b.art_matching_id,
    A.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _regio1 AS
SELECT
    b.art_matching_id,
    T.kjwo,
    SUM(CASE
        WHEN A.kreistyp_gruppe_id = 'N'
            THEN A.absatz
        ELSE NULL
    END) AS absatz_nord,
    SUM(CASE
        WHEN A.kreistyp_gruppe_id = 'W'
            THEN A.absatz
        ELSE NULL
    END) AS absatz_west,
    SUM(CASE
        WHEN A.kreistyp_gruppe_id = 'G'
            THEN A.absatz
        ELSE NULL
    END) AS absatz_sued_ost,
    SUM(CASE
        WHEN A.kreistyp_gruppe_id = 'M'
            THEN A.absatz
        ELSE NULL
    END) AS absatz_sued_west,
    SUM(CASE
        WHEN A.kreistyp_gruppe_id = 'O'
            THEN A.absatz
        ELSE NULL
    END) AS absatz_ost_basis,
    SUM(CASE
        WHEN A.kreistyp_gruppe_id = 'Q'
            THEN A.absatz
        ELSE NULL
    END) AS absatz_ost_gross
FROM dbp_etl.bf_listung_markt_tag_1 AS A
INNER JOIN dbp_data.tag_1 AS T ON A.dat = T.dat
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        status_1
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        art_matching_id,
        art_id,
        status_1
) AS b ON A.art_id = b.art_id
GROUP BY
    b.art_matching_id,
    T.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _regio2 AS
SELECT
    b.art_matching_id,
    T.kjwo,
    SUM(CASE
        WHEN A.kreistyp_gruppe_id = 'N'
            THEN A.anzahl_wochen_mit_absatz
        ELSE NULL
    END) / 7.0000 AS anz_wo_mit_abs_nord,
    SUM(CASE
        WHEN A.kreistyp_gruppe_id = 'W'
            THEN A.anzahl_wochen_mit_absatz
        ELSE NULL
    END) / 7.0000 AS anz_wo_mit_abs_west,
    SUM(CASE
        WHEN A.kreistyp_gruppe_id = 'M'
            THEN A.anzahl_wochen_mit_absatz
        ELSE NULL
    END) / 7.0000 AS anz_wo_mit_abs_sued_ost,
    SUM(CASE
        WHEN A.kreistyp_gruppe_id = 'G'
            THEN A.anzahl_wochen_mit_absatz
        ELSE NULL
    END) / 7.0000 AS anz_wo_mit_abs_sued_west,
    SUM(CASE
        WHEN A.kreistyp_gruppe_id = 'O'
            THEN A.anzahl_wochen_mit_absatz
        ELSE NULL
    END) / 7.0000 AS anz_wo_mit_abs_ost_basis,
    SUM(CASE
        WHEN A.kreistyp_gruppe_id = 'Q'
            THEN A.anzahl_wochen_mit_absatz
        ELSE NULL
    END) / 7.0000 AS anz_wo_mit_abs_ost_gross
FROM dbp_etl.bf_listung_markt_tag_1 AS A
INNER JOIN dbp_data.tag_1 AS T ON A.dat = T.dat
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        status_1
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        art_matching_id,
        art_id,
        status_1
) AS b ON A.art_id = b.art_id
GROUP BY
    b.art_matching_id,
    T.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _vk1 AS
SELECT
    b.art_matching_id,
    C.kjwo_update AS kjwo,
    AVG(CASE
        WHEN A.pm_id = 1
            THEN A.vk_brutto
        ELSE NULL
    END) AS pk1,
    AVG(CASE
        WHEN A.pm_id = 2
            THEN A.vk_brutto
        ELSE NULL
    END) AS pk2,
    AVG(CASE
        WHEN A.pm_id = 3
            THEN A.vk_brutto
        ELSE NULL
    END) AS pk3,
    AVG(CASE
        WHEN A.pm_id = 4
            THEN A.vk_brutto
        ELSE NULL
    END) AS pk4,
    AVG(CASE
        WHEN A.pm_id = 5
            THEN A.vk_brutto
        ELSE NULL
    END) AS pk5,
    AVG(CASE
        WHEN A.pm_id = 6
            THEN A.vk_brutto
        ELSE NULL
    END) AS pk6,
    AVG(CASE
        WHEN A.pm_id = 7
            THEN A.vk_brutto
        ELSE NULL
    END) AS pk7,
    AVG(CASE
        WHEN A.pm_id = 8
            THEN A.vk_brutto
        ELSE NULL
    END) AS pk8,
    AVG(CASE
        WHEN A.pm_id = 9
            THEN A.vk_brutto
        ELSE NULL
    END) AS pk9,
    AVG(CASE
        WHEN A.pm_id = 10
            THEN A.vk_brutto
        ELSE NULL
    END) AS pk10
FROM dbp_data.art_pm_vw_zu_per_1 AS A
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        status_1
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        art_matching_id,
        art_id,
        status_1
) AS b ON A.art_id = b.art_id
INNER JOIN dbp_data.sortiment_leistung_1 AS C ON b.art_matching_id = C.matching_id AND A.mandant_id = C.mandant_id

WHERE
    A.mandant_id = 1
    AND A.dat_bis = DATE '9999-12-31'
    AND C.kjwo_update IN (
        SELECT kjwo_vj
        FROM `_zeitraum_woche`
    )
GROUP BY
    b.art_matching_id,
    kjwo;


CREATE OR REPLACE TEMPORARY TABLE _ek1 AS
SELECT
    b.art_matching_id,
    A.kjwo,
    SUM(A.total_rohertrag) AS total_rohertrag,
    SUM(A.total_rohertrag_sa) AS total_rohertrag_sa,
    SUM(A.total_rohertrag_af) AS total_rohertrag_af,
    SUM(A.total_rohetrag_vj) AS total_rohetrag_vj,
    SUM(A.total_rohertrag_olk) AS total_rohertrag_olk,
    SUM(A.total_rohertrag_olk_sa) AS total_rohertrag_olk_sa,
    SUM(A.total_rohertrag_olk_af) AS total_rohertrag_olk_af,
    SUM(A.total_rohertrag_olk_vj) AS total_rohertrag_olk_vj,
    SUM(A.abschriftsbetrag_ohne_werbung_netto) AS abschriftsbetrag_ohne_werbung_netto
FROM dbp_data.sal_int_1 AS A
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        status_1
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        art_matching_id,
        art_id,
        status_1
) AS b ON A.art_id = b.art_id
WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM `_zeitraum_woche`
    )
    AND A.mandant_id = 1
GROUP BY
    b.art_matching_id,
    A.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _ek1_vj AS
SELECT
    b.art_matching_id,
    A.mandant_id,
    A.kjwo,
    IFNULL(SUM(CASE
        WHEN A.bewart_id = 1001
            THEN A.umsatz_netto
        ELSE NULL
    END), 0) - IFNULL(SUM(CASE
        WHEN A.bewart_id = 1001
            THEN A.ek_mep
        ELSE NULL
    END), 0) AS re_mep_af_olk_vj,
    IFNULL(SUM(CASE
        WHEN A.bewart_id = 1002
            THEN A.umsatz_netto
        ELSE NULL
    END), 0) - IFNULL(SUM(CASE
        WHEN A.bewart_id = 1002
            THEN A.ek_mep
        ELSE NULL
    END), 0) AS re_mep_sa_olk_vj,
    IFNULL(SUM(A.umsatz_netto), 0) - IFNULL(SUM(A.ek_mep), 0) AS re_mep_tot_olk_vj
FROM dbp_etl.bf_artbew_wg_art_wo_sum_de_vj_1 AS A
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        mandant_id
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        art_matching_id,
        art_id,
        mandant_id
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
WHERE A.mandant_id = 1
GROUP BY
    b.art_matching_id,
    A.mandant_id,
    A.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _kpi1 AS
SELECT
    A.mandant_id,
    A.kjwo,
    c.art_matching_id,
    SUM(A.art_bons_af) AS art_bons_af,
    SUM(A.art_bons_sa) AS art_bons_sa,
    SUM(A.anz_bons) AS anz_bons,
    SUM(A.cp_bons_af) AS cp_bons_af,
    SUM(A.cp_bons_sa) AS cp_bons_sa
FROM dbp_etl.sort_kpi_woche_basis_1 AS A
INNER JOIN dbp_data.art_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.kl_art_id = B.kl_art_id AND B.dat_bis
        = DATE '9999-12-31'
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        mandant_id
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        art_matching_id,
        art_id,
        mandant_id
) AS c ON B.art_id = c.art_id AND B.mandant_id = c.mandant_id
WHERE
    A.mandant_id = 1
    AND A.kjwo IN (
        SELECT kjwo
        FROM `_zeitraum_woche`
    )
GROUP BY
    A.mandant_id,
    A.kjwo,
    c.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _tage_vj AS
SELECT
    C.mandant_id,
    A.dat,
    A.kjwo
FROM dbp_data.tag_1 AS A
INNER JOIN dbp_data.mandant_1 AS C ON TRUE
WHERE
    A.kjwo IN (
        SELECT kjwo_vj
        FROM `_zeitraum_woche`
    )
    AND C.mandant_id = 1
GROUP BY
    C.mandant_id,
    A.dat,
    A.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _vj_ek AS
SELECT
    A11.art_id,
    A11.mandant_id,
    B.kjwo,
    IFNULL(SUM(CASE
        WHEN A11.bewart_id = 1001
            THEN A11.umsatz_netto
        ELSE NULL
    END), 0) - IFNULL(SUM(CASE
        WHEN A11.bewart_id = 1001
            THEN A11.ek_mep - A11.logkostenzuschlag
        ELSE NULL
    END), 0) AS re_mep_af_olk_vj,
    IFNULL(SUM(CASE
        WHEN A11.bewart_id = 1002
            THEN A11.umsatz_netto
        ELSE NULL
    END), 0) - IFNULL(SUM(CASE
        WHEN A11.bewart_id = 1002
            THEN A11.ek_mep - A11.logkostenzuschlag
        ELSE NULL
    END), 0) AS re_mep_sa_olk_vj,
    IFNULL(SUM(A11.umsatz_netto), 0) - IFNULL(SUM(A11.ek_mep - A11.logkostenzuschlag), 0) AS re_mep_tot_olk_vj
FROM dbp_data.artbew_1 AS A11
INNER JOIN `_tage_vj` AS B ON A11.dat = B.dat
WHERE A11.mandant_id = 1
GROUP BY
    A11.art_id,
    A11.mandant_id,
    B.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _vj_ek1 AS
SELECT
    b.art_matching_id,
    A.mandant_id,
    A.kjwo,
    SUM(A.re_mep_af_olk_vj) AS re_mep_af_vj,
    SUM(A.re_mep_sa_olk_vj) AS re_mep_sa_vj,
    SUM(A.re_mep_tot_olk_vj) AS re_mep_vj
FROM `_vj_ek` AS A
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id,
        status_1
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id,
        status_1
) AS b ON A.art_id = b.art_id AND A.mandant_id = b.mandant_id
GROUP BY
    b.art_matching_id,
    A.mandant_id,
    A.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _main AS
SELECT
    A.kjwo,
    A.mandant_id,
    A.art_id,
    d.art_matching_id AS matching_id
FROM dbp_etl.bf_artbew_wg_art_wo_sum_de_1 AS A
INNER JOIN (
    SELECT
        art_matching_id,
        art_id,
        mandant_id
    FROM dbp_etl.art_matching_nielsen_per_de_xxx_1
    WHERE art_id <> -1
    GROUP BY
        art_matching_id,
        art_id,
        mandant_id
) AS d ON A.art_id = d.art_id AND A.mandant_id = d.mandant_id
GROUP BY
    A.kjwo,
    A.mandant_id,
    A.art_id,
    matching_id;


DELETE FROM dbp_data.tupel_kw_1
WHERE kjwo IN (
    SELECT kjwo
    FROM `_zeitraum_woche`
) AND mandant_id = 1;


INSERT INTO dbp_data.tupel_kw_1 (
    mandant_id, kjwo, matching_id, wrg_id,
    anzahl_markt_wochen_kombis_abverkauf_af, anzahl_markt_wochen_kombis_abverkauf_sa,
    anzahl_markt_wochen_kombis_abverkauf_af_vj, anzahl_markt_wochen_kombis_abverkauf_sa_vj, kassenumsatz_kl_absolut_brutto,
    kassenumsatz_af_kl_absolut_brutto, kassenumsatz_sa_kl_absolut_brutto, kassenumsatz_kl_absolut_brutto_vj,
    kassenumsatz_af_kl_absolut_brutto_vj, kassenumsatz_sa_kl_absolut_brutto_vj, kassenumsatz_kl_absolut_netto,
    kassenumsatz_af_kl_absolut_netto, kassenumsatz_sa_kl_absolut_netto, kassenumsatz_kl_absolut_netto_vj,
    kassenumsatz_af_kl_absolut_netto_vj, kassenumsatz_sa_kl_absolut_netto_vj, absatz_kl, absatz_af_kl, absatz_sa_kl,
    absatz_kl_vj, absatz_af_kl_vj, absatz_sa_kl_vj, absatz_sst1, absatz_sst2, absatz_sst3, absatz_sst4, absatz_sst5,
    absatz_sst6, absatz_sst7, absatz_ksst1, absatz_ksst2, absatz_ksst3, absatz_ksst4, absatz_ksst5, absatz_ksst6,
    absatz_ksst7, absatz_ost_basis, absatz_ost_gross, absatz_sued_ost, absatz_sued_west, absatz_west, absatz_nord,
    markt_wochen_sst1, markt_wochen_sst2, markt_wochen_sst3, markt_wochen_sst4, markt_wochen_sst5, markt_wochen_sst6,
    markt_wochen_sst7, markt_wochen_ksst1, markt_wochen_ksst2, markt_wochen_ksst3, markt_wochen_ksst4, markt_wochen_ksst5,
    markt_wochen_ksst6, markt_wochen_ksst7, markt_wochen_ost_basis, markt_wochen_ost_gross, markt_wochen_sued_ost,
    markt_wochen_sued_west, markt_wochen_west, markt_wochen_nord, anzahl_markt_wochen_kombis_abverkauf_mit_listung,
    anzahl_markt_wochen_kombis_listung, rohertrag_ekmep_olk_4n, anz_bons_af, anz_bons_sa, anz_bons_gesamt,
    rohertrag_ekmep_olk_4n_vj, rohertrag_ekmep_olk_4n_af, rohertrag_ekmep_olk_4n_sa, rohertrag_ekmep_olk_4n_af_vj,
    rohertrag_ekmep_olk_4n_sa_vj, totalabschriften_wert_netto_absolut, preisabschriften_preisanderungen_wert_netto_absolut,
    totalabschriften_wert_netto_absolut_vj, preisabschriften_preisanderungen_wert_netto_absolut_vj,
    totalabschriften_wert_netto_absolut_wg, preisabschriften_preisanderungen_wert_netto_absolut_wg, anz_bons_af_markt_tag,
    anz_bons_sa_markt_tag, cpq_tupel, cp_bons_af, cp_bons_sa, kassenumsatz_kl_absolut_netto_wg, anz_bons_tupel,
    restbon_summe, absatz_af_kl_listungswochen, absatz_af_kl_vj_listungswochen, absatz_sa_kl_listungswochen,
    absatz_sa_kl_vj_listungswochen, kassenumsatz_af_kl_absolut_netto_listungswochen,
    kassenumsatz_af_kl_absolut_netto_vj_listungswochen, kassenumsatz_sa_kl_absolut_netto_listungswochen,
    kassenumsatz_sa_kl_absolut_netto_vj_listungswochen, rohertrag_ekmep_olk_4n_af_listungswochen,
    rohertrag_ekmep_olk_4n_af_vj_listungswochen, rohertrag_ekmep_olk_4n_sa_listungswochen,
    rohertrag_ekmep_olk_4n_sa_vj_listungswochen
)
(
    SELECT
        A.mandant_id,
        A.kjwo AS kjwo_update,
        A.matching_id,
        X99.default_wrg,
        CAST(Q.anz_wo_mit_absatz_af AS INTEGER) AS anzahl_markt_wochen_kombis_abverkauf_af,
        CAST(Q.anz_wo_mit_absatz_sa AS INTEGER) AS anzahl_markt_wochen_kombis_abverkauf_sa,
        CAST(T.anz_wo_mit_absatz_af AS INTEGER) AS anzahl_markt_wochen_kombis_abverkauf_af_vj,
        CAST(T.anz_wo_mit_absatz_sa AS INTEGER) AS anzahl_markt_wochen_kombis_abverkauf_sa_vj,
        B.umsatz_brutto AS a273_kassenumsatz_kl_absolut_brutto,
        B.umsatz_brutto_af AS kassenumsatz_af_kl_absolut_brutto,
        B.umsatz_brutto_sa AS kassenumsatz_sa_kl_absolut_brutto,
        C.umsatz_brutto AS kassenumsatz_kl_absolut_brutto_vj,
        C.umsatz_brutto_af AS kassenumsatz_af_kl_absolut_brutto_vj,
        C.umsatz_brutto_sa AS kassenumsatz_sa_kl_absolut_brutto_vj,
        B.umsatz AS a21_kassenumsatz_kl_absolut_netto,
        B.umsatz_af AS kassenumsatz_af_kl_absolut_netto,
        B.umsatz_sa AS kassenumsatz_sa_kl_absolut_netto,
        C.umsatz AS kassenumsatz_kl_absolut_netto_vj,
        C.umsatz_af AS kassenumsatz_af_kl_absolut_netto_vj,
        C.umsatz_sa AS kassenumsatz_sa_kl_absolut_netto_vj,
        B.absatz AS a17_absatz_kl,
        B.absatz_af AS absatz_af_kl,
        B.absatz_sa AS absatz_sa_kl,
        C.absatz AS absatz_kl_vj,
        C.absatz_af AS absatz_af_kl_vj,
        C.absatz_sa AS absatz_sa_kl_vj,
        ROUND(CAST(D.absatz_sk1 AS NUMERIC), 4) AS a76_absatz_sst1,
        ROUND(CAST(D.absatz_sk2 AS NUMERIC), 4) AS a78_absatz_sst2,
        ROUND(CAST(D.absatz_sk3 AS NUMERIC), 4) AS a80_absatz_sst3,
        ROUND(CAST(D.absatz_sk4 AS NUMERIC), 4) AS a82_absatz_sst4,
        ROUND(CAST(D.absatz_sk5 AS NUMERIC), 4) AS a84_absatz_sst5,
        ROUND(CAST(D.absatz_sk6 AS NUMERIC), 4) AS a86_absatz_sst6,
        ROUND(CAST(D.absatz_sk7 AS NUMERIC), 4) AS a88_absatz_sst7,
        0 AS a62_absatz_ksst1,
        0 AS a64_absatz_ksst2,
        0 AS a66_absatz_ksst3,
        0 AS a68_absatz_ksst4,
        0 AS a70_absatz_ksst5,
        0 AS a72_absatz_ksst6,
        0 AS a74_absatz_ksst7,
        CAST(E.absatz_ost_basis AS NUMERIC) AS a90_absatz_ost_basis,
        CAST(E.absatz_ost_gross AS NUMERIC) AS a92_absatz_ost_gross,
        CAST(E.absatz_sued_ost AS NUMERIC) AS a94_absatz_sued_ost,
        CAST(E.absatz_sued_west AS NUMERIC) AS a96_absatz_sued_west,
        CAST(E.absatz_west AS NUMERIC) AS a98_absatz_west,
        CAST(E.absatz_nord AS NUMERIC) AS a100_absatz_nord,
        CAST(D.anz_wo_mit_abs_sk1 AS INTEGER) AS markt_wochen_sst1,
        CAST(D.anz_wo_mit_abs_sk2 AS INTEGER) AS markt_wochen_sst2,
        CAST(D.anz_wo_mit_abs_sk3 AS INTEGER) AS markt_wochen_sst3,
        CAST(D.anz_wo_mit_abs_sk4 AS INTEGER) AS markt_wochen_sst4,
        CAST(D.anz_wo_mit_abs_sk5 AS INTEGER) AS markt_wochen_sst5,
        CAST(D.anz_wo_mit_abs_sk6 AS INTEGER) AS markt_wochen_sst6,
        CAST(D.anz_wo_mit_abs_sk7 AS INTEGER) AS markt_wochen_sst7,
        0 AS markt_wochen_ksst1,
        0 AS markt_wochen_ksst2,
        0 AS markt_wochen_ksst3,
        0 AS markt_wochen_ksst4,
        0 AS markt_wochen_ksst5,
        0 AS markt_wochen_ksst6,
        0 AS markt_wochen_ksst7,
        CAST(F.anz_wo_mit_abs_ost_basis AS INTEGER) AS markt_wochen_ost_basis,
        CAST(F.anz_wo_mit_abs_ost_gross AS INTEGER) AS markt_wochen_ost_gross,
        CAST(F.anz_wo_mit_abs_sued_ost AS INTEGER) AS markt_wochen_sued_ost,
        CAST(F.anz_wo_mit_abs_sued_west AS INTEGER) AS markt_wochen_sued_west,
        CAST(F.anz_wo_mit_abs_west AS INTEGER) AS markt_wochen_west,
        CAST(F.anz_wo_mit_abs_nord AS INTEGER) AS markt_wochen_nord,
        CAST(S.anz_wo_mit_absatz AS INTEGER) AS anzahl_markt_wochen_kombis_abverkauf_mit_listung,
        CAST(R.anz_wo_listung_1 AS INTEGER) AS anzahl_markt_wochen_kombis_listung,
        I.total_rohertrag_olk AS a23_rohertrag_ekmep_olk_4n,
        K.art_bons_af AS anz_bons_af,
        K.art_bons_sa AS anz_bons_sa,
        0 AS anz_bons_gesamt,
        J.re_mep_vj AS rohertrag_ekmep_olk_4n_vj,
        I.total_rohertrag_olk_af AS rohertrag_ekmep_olk_4n_af,
        I.total_rohertrag_olk_sa AS rohertrag_ekmep_olk_4n_sa,
        CAST(J.re_mep_af_vj AS NUMERIC) AS rohertrag_ekmep_olk_4n_af_vj,
        CAST(J.re_mep_sa_vj AS NUMERIC) AS rohertrag_ekmep_olk_4n_sa_vj,
        I.abschriftsbetrag_ohne_werbung_netto AS a27_totalabschriften_wert_netto_absolut,
        0 AS a313_preisabschriften_preisanderungen_wert_netto_absolut,
        0 AS totalabschriften_wert_netto_absolut_vj,
        0 AS preisabschriften_preisanderungen_wert_netto_absolut_vj,
        0 AS totalabschriften_wert_netto_absolut_wg,
        0 AS preisabschriften_preisanderungen_wert_netto_absolut_wg,
        0 AS anz_bons_af_markt_tag,
        0 AS anz_bons_sa_markt_tag,
        K.cp_bons_af + K.cp_bons_sa AS cpq_tupel,
        K.cp_bons_af,
        K.cp_bons_sa,
        0 AS kassenumsatz_kl_absolut_netto_wg,
        K.anz_bons AS anz_bons_tupel,
        0 AS restbon_summe,
        O.absatz_af_mit_listung AS absatz_af_kl_listungswochen,
        P.absatz_af_mit_listung AS absatz_af_kl_vj_listungswochen,
        O.absatz_sa_mit_listung AS absatz_sa_kl_listungswochen,
        P.absatz_sa_mit_listung AS absatz_sa_kl_vj_listungswochen,
        O.umsatz_af_mit_listung AS kassenumsatz_af_kl_absolut_netto_listungswochen,
        P.umsatz_af_mit_listung AS kassenumsatz_af_kl_absolut_netto_vj_listungswochen,
        O.umsatz_sa_mit_listung AS kassenumsatz_sa_kl_absolut_netto_listungswochen,
        P.umsatz_sa_mit_listung AS kassenumsatz_sa_kl_absolut_netto_vj_listungswochen,
        O.ertrag_af_mit_listung AS rohertrag_ekmep_olk_4n_af_listungswochen,
        P.ertrag_af_mit_listung AS rohertrag_ekmep_olk_4n_af_vj_listungswochen,
        O.ertrag_sa_mit_listung AS rohertrag_ekmep_olk_4n_sa_listungswochen,
        P.ertrag_sa_mit_listung AS rohertrag_ekmep_olk_4n_sa_vj_listungswochen
    FROM `_main` AS A
    INNER JOIN dbp_data.mandant_1 AS X99 ON A.mandant_id = X99.mandant_id
    INNER JOIN `_zeitraum_woche` AS ZW ON A.kjwo = ZW.kjwo
    LEFT JOIN `_anz_wochen1` AS B ON A.matching_id = B.art_matching_id AND A.kjwo = B.kjwo
    LEFT JOIN `_anz_wochen1_vj` AS C ON A.matching_id = C.art_matching_id AND ZW.kjwo_vj = C.kjwo
    LEFT JOIN zzmd0e1 AS D ON A.matching_id = D.art_matching_id AND A.kjwo = D.kjwo
    LEFT JOIN `_regio1` AS E ON A.matching_id = E.art_matching_id AND A.kjwo = E.kjwo
    LEFT JOIN `_regio2` AS F ON A.matching_id = F.art_matching_id AND A.kjwo = F.kjwo
    LEFT JOIN `_vk1` AS H ON A.matching_id = H.art_matching_id AND A.kjwo = H.kjwo
    LEFT JOIN `_ek1` AS I ON A.matching_id = I.art_matching_id AND A.kjwo = I.kjwo
    LEFT JOIN `_vj_ek1` AS J ON A.matching_id = J.art_matching_id AND ZW.kjwo_vj = J.kjwo
    LEFT JOIN `_kpi1` AS K ON A.matching_id = K.art_matching_id AND A.mandant_id = K.mandant_id AND A.kjwo = K.kjwo
    LEFT JOIN `_mm_x` AS N ON A.matching_id = N.matching_id AND A.mandant_id = N.mandant_id AND A.kjwo = N.kjwo
    LEFT JOIN `_mm_z` AS O ON A.matching_id = O.matching_id AND A.mandant_id = O.mandant_id AND A.kjwo = O.kjwo
    LEFT JOIN `_mm_z_vj` AS P ON A.matching_id = P.matching_id AND A.mandant_id = P.mandant_id AND ZW.kjwo_vj = P.kjwo
    LEFT JOIN zzsp07_pre_tag_xxx AS Q ON A.matching_id = Q.matching_id AND A.mandant_id = Q.mandant_id AND A.kjwo = Q.kjwo

    LEFT JOIN zzsp08_pre_xxx AS R ON A.matching_id = R.matching_id AND A.mandant_id = R.mandant_id AND A.kjwo = R.kjwo
    LEFT JOIN `_mm_y_xxx` AS S ON A.matching_id = S.matching_id AND A.mandant_id = S.mandant_id AND A.kjwo = S.kjwo
    LEFT JOIN zzsp07_pre_tag_vj_xxx AS T
        ON
            A.matching_id = T.matching_id AND A.mandant_id = T.mandant_id AND ZW.kjwo_vj =
            T.kjwo
    LEFT JOIN zzsp08_pre_vj_xxx AS U ON A.matching_id = U.matching_id AND A.mandant_id = U.mandant_id AND ZW.kjwo_vj = U.kjwo

    WHERE
        A.mandant_id = 1
        AND B.umsatz_brutto > 0
);


--restbon + cherrypicker de_kw


CREATE OR REPLACE TEMPORARY TABLE _bons_art_de_kw AS
SELECT
    A.mandant_id,
    B.art_id,
    SUM(A.art_ums_af) AS art_umsatz_af,
    SUM(A.art_ums_sa) AS art_umsatz_sa,
    SUM(A.bon_ums_af) AS bon_umsatz_af,
    SUM(A.bon_ums_sa) AS bon_umsatz_sa,
    SUM(A.restbon_af) AS restbon_af,
    SUM(A.restbon_sa) AS restbon_sa,
    SUM(A.restbon_af) + SUM(A.restbon_sa) AS restbon_summe,
    SUM(A.art_bons_af) AS anz_bons_af,
    SUM(A.art_bons_sa) AS anz_bons_sa,
    SUM(A.art_bons_af) + SUM(A.art_bons_sa) AS anz_bons,
    SUM(A.cp_bons_sa) AS cpsa_fg
FROM dbp_etl.bf_bons_sort_sum_1 AS A
INNER JOIN dbp_data.art_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.kl_art_id = B.kl_art_id AND B.dat_bis
        = DATE '9999-12-31'
INNER JOIN dbp_data.tag_1 AS C ON A.dat = C.dat
WHERE
    A.mandant_id = 1
    AND (
        A.mandant_id, C.kjwo) IN (
        SELECT (mandant_id, kjwo)
        FROM (
            SELECT
                b.mandant_id,
                C0.kjwo,
                (RANK() OVER (
                    PARTITION BY
                        b.mandant_id ORDER BY
                        b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC, C0.kjwo
                        DESC
                )) * -1 AS akt_wo
            FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
            INNER JOIN (SELECT
                mandant_id,
                MAX(kjmo) AS kjmo
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = 1
            GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
            INNER JOIN dbp_data.woche_1 AS C0 ON A0.kjwo_bis >= C0.kjwo
            QUALIFY ((RANK() OVER (
                PARTITION BY
                    b.mandant_id ORDER BY
                    b.mandant_id IS NULL, b.mandant_id, C0.kjwo IS NULL DESC,
                    C0.kjwo DESC
            )) * -1) BETWEEN -63 AND (-1)
        ) AS t2
        GROUP BY mandant_id,
        kjwo
    )
GROUP BY
    A.mandant_id,
    B.art_id;


CREATE OR REPLACE TEMPORARY TABLE _bons_matching_de_kw AS
SELECT
    A.mandant_id,
    b.art_matching_id,
    SUM(A.art_umsatz_af) AS art_umsatz_af,
    SUM(A.art_umsatz_sa) AS art_umsatz_sa,
    SUM(A.bon_umsatz_af) AS bon_umsatz_af,
    SUM(A.bon_umsatz_sa) AS bon_umsatz_sa,
    SUM(A.restbon_af) AS restbon_af,
    SUM(A.restbon_sa) AS restbon_sa,
    SUM(A.restbon_summe) AS restbon_summe,
    SUM(A.anz_bons_af) AS anz_bons_af,
    SUM(A.anz_bons_sa) AS anz_bons_sa,
    SUM(A.anz_bons) AS anz_bons,
    SUM(A.cpsa_fg) AS cpsa_fg
FROM `_bons_art_de_kw` AS A
INNER JOIN (SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id
FROM dbp_etl.art_matching_nielsen_per_1
WHERE kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per_1
)
AND art_id <> -1) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
GROUP BY
    A.mandant_id,
    b.art_matching_id;


UPDATE dbp_data.tupel_kw_1 SET
    restbon_summe = b.restbon_summe,
    anz_bons_gesamt = b.anz_bons,
    anz_bons_af = b.anz_bons_af,
    anz_bons_sa = b.anz_bons_sa,
    cp_bons_sa = b.cpsa_fg
FROM `_bons_matching_de_kw` AS b
WHERE tupel_kw.mandant_id = b.mandant_id AND tupel_kw.matching_id = b.art_matching_id AND tupel_kw.kjwo = (SELECT
    MAX(kjwo_update
    )
FROM dbp_data.art_kl_preislage_zu_per_1
WHERE mandant_id = 1);


---------------------------
--de Bonreichweite


CREATE OR REPLACE TABLE dbp_etl_process.sort_bon_receipt_agg_sa_de_kw_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    SUM(A.total_receipt) AS sum_total_receipt
FROM dbp_etl_process.sort_bon_receipt_de_1 AS A
INNER JOIN (
    SELECT
        dat,
        kjwo
    FROM dbp_data.tag_1
    GROUP BY
        dat,
        kjwo
) AS x ON A.bon_dat = x.dat
WHERE (
    A.mandant_id, x.kjwo) IN (
    SELECT (mandant_id, kjwo)
    FROM (
        SELECT
            b.mandant_id,
            C.kjwo,
            (RANK() OVER (
                PARTITION BY
                    b.mandant_id ORDER BY
                    b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC, C.kjwo
                    DESC
            )) * -1 AS akt_wo
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
        INNER JOIN (SELECT
            mandant_id,
            MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
        INNER JOIN dbp_data.woche_1 AS C ON A0.kjwo_bis >= C.kjwo
        QUALIFY ((RANK() OVER (
            PARTITION BY
                b.mandant_id ORDER BY
                b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
                C.kjwo DESC
        )) * -1) BETWEEN -63 AND (-1)
    ) AS t4
    GROUP BY mandant_id,
    kjwo
)
AND A.anz_bons_sa_fg > 0
GROUP BY
    A.mandant_id,
    A.art_id;


CREATE OR REPLACE TABLE dbp_etl_process.sort_bon_receipt_agg_af_de_kw_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    SUM(A.total_receipt) AS sum_total_receipt
FROM dbp_etl_process.sort_bon_receipt_de_1 AS A
INNER JOIN (
    SELECT
        dat,
        kjwo
    FROM dbp_data.tag_1
    GROUP BY
        dat,
        kjwo
) AS x ON A.bon_dat = x.dat
WHERE (
    A.mandant_id, x.kjwo) IN (
    SELECT (mandant_id, kjwo)
    FROM (
        SELECT
            b.mandant_id,
            C.kjwo,
            (RANK() OVER (
                PARTITION BY
                    b.mandant_id ORDER BY
                    b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC, C.kjwo
                    DESC
            )) * -1 AS akt_wo
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_1 AS A0
        INNER JOIN (SELECT
            mandant_id,
            MAX(kjmo) AS kjmo
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = 1
        GROUP BY mandant_id) AS b ON A0.kjmo_sort = b.kjmo
        INNER JOIN dbp_data.woche_1 AS C ON A0.kjwo_bis >= C.kjwo
        QUALIFY ((RANK() OVER (
            PARTITION BY
                b.mandant_id ORDER BY
                b.mandant_id IS NULL, b.mandant_id, C.kjwo IS NULL DESC,
                C.kjwo DESC
        )) * -1) BETWEEN -63 AND (-1)
    ) AS t4
    GROUP BY mandant_id,
    kjwo
)
AND A.anz_bons_af_fg > 0
GROUP BY
    A.mandant_id,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _sort_bon_receipt_agg_de_lvl2_af_kw AS
SELECT
    A.mandant_id,
    b.art_matching_id,
    SUM(A.sum_total_receipt) AS sum_total_receipt
FROM dbp_etl_process.sort_bon_receipt_agg_af_de_kw_1 AS A
INNER JOIN (SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id
FROM dbp_etl.art_matching_nielsen_per_1
WHERE kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per_1
)
AND art_id <> -1) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
GROUP BY
    A.mandant_id,
    b.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _sort_bon_receipt_agg_de_lvl2_sa_kw AS
SELECT
    A.mandant_id,
    b.art_matching_id,
    SUM(A.sum_total_receipt) AS sum_total_receipt
FROM dbp_etl_process.sort_bon_receipt_agg_sa_de_kw_1 AS A
INNER JOIN (SELECT DISTINCT
    mandant_id,
    art_matching_id,
    art_id
FROM dbp_etl.art_matching_nielsen_per_1
WHERE kjwo_update = (
    SELECT MAX(kjwo_update)
    FROM dbp_etl.art_matching_nielsen_per_1
)
AND art_id <> -1) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
GROUP BY
    A.mandant_id,
    b.art_matching_id;


UPDATE dbp_data.tupel_kw_1 SET
    anz_bons_af_markt_tag = b.sum_total_receipt
FROM `_sort_bon_receipt_agg_de_lvl2_af_kw` AS b
WHERE tupel_kw.mandant_id = b.mandant_id AND tupel_kw.matching_id = b.art_matching_id AND tupel_kw.kjwo = (SELECT
    MAX(kjwo_update
    )
FROM dbp_data.art_kl_preislage_zu_per_1
WHERE mandant_id = 1);


UPDATE dbp_data.tupel_kw_1 SET
    anz_bons_sa_markt_tag = b.sum_total_receipt
FROM `_sort_bon_receipt_agg_de_lvl2_sa_kw` AS b
WHERE tupel_kw.mandant_id = b.mandant_id AND tupel_kw.matching_id = b.art_matching_id AND tupel_kw.kjwo = (SELECT
    MAX(kjwo_update
    )
FROM dbp_data.art_kl_preislage_zu_per_1
WHERE mandant_id = 1);
