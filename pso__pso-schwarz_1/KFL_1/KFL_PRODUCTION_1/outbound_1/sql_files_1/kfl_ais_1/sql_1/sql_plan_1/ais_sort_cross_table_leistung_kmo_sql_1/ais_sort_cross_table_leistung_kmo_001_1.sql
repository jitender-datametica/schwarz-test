--PARAMS


SELECT ${mandant_id} AS mandant_id;


SELECT ${anz_tage} AS anz_tage;


CREATE OR REPLACE TEMPORARY TABLE _sort_ist2_1 AS
SELECT
    A.wup_id,
    A.mandant_id,
    A.wg_id,
    A.art_id,
    A.kassenumsatz,
    A.anz_tage,
    A.preis,
    A.list_kz,
    b.sm_id,
    b.ksm_id
FROM dbp_etl.sort_ist_kmo_1 AS A
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.wup_id,
        A0.wg_id,
        CASE
            WHEN A0.sm_id = 6
                THEN 5
            ELSE A0.sm_id
        END AS sm_id,
        TRIM(A0.ksm_id) AS ksm_id
    FROM dbp_data.sm_wup_wg_zu_per_1 AS A0
    INNER JOIN dbp_data.wup_1 AS B
        ON
            A0.mandant_id = B.mandant_id AND A0.wup_id = B.wup_id AND CURRENT_DATE("Europe/Berlin")
            BETWEEN B.dat_von AND B.dat_bis
    INNER JOIN dbp_data.wg_filter_zu_1 AS WFZ
        ON
            A0.wg_id = WFZ.wg_id AND A0.mandant_id = WFZ.mandant_id AND
            WFZ.wg_filter_id = 47 AND WFZ.arthiertyp_id = 2
    WHERE
        A0.mandant_id = ${mandant_id}
        AND A0.arthiertyp_id = 2
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A0.dat_von AND A0.dat_bis
        AND (A0.sm_id BETWEEN 1 AND 6 OR TRIM(A0.ksm_id) IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9'))
        AND B.nb_id = 0
    GROUP BY
        A0.mandant_id,
        A0.wup_id,
        A0.wg_id,
        sm_id,
        ksm_id
) AS b ON A.wg_id = b.wg_id AND A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _ist_listung_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    d.sm_id,
    d.ksm_id
FROM dbp_data.art_list_wup_zu_per_1 AS A
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
        = DATE '9999-12-31' AND B.arthiertyp_id = 2
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.wup_id,
        A0.wg_id,
        CASE
            WHEN A0.sm_id = 6
                THEN 5
            ELSE A0.sm_id
        END AS sm_id,
        TRIM(A0.ksm_id) AS ksm_id
    FROM dbp_data.sm_wup_wg_zu_per_1 AS A0
    INNER JOIN dbp_data.wup_1 AS B0
        ON
            A0.mandant_id = B0.mandant_id AND A0.wup_id = B0.wup_id AND
            CURRENT_DATE("Europe/Berlin") BETWEEN B0.dat_von AND B0.dat_bis
    INNER JOIN dbp_data.wg_filter_zu_1 AS WFZ
        ON
            A0.wg_id = WFZ.wg_id AND A0.mandant_id = WFZ.mandant_id AND
            WFZ.wg_filter_id = 47 AND WFZ.arthiertyp_id = 2
    WHERE
        A0.mandant_id = ${mandant_id}
        AND A0.arthiertyp_id = 2
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A0.dat_von AND A0.dat_bis
        AND (A0.sm_id BETWEEN 1 AND 6 OR TRIM(A0.ksm_id) IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9'))
        AND B0.nb_id = 0
    GROUP BY
        A0.mandant_id,
        A0.wup_id,
        A0.wg_id,
        sm_id,
        ksm_id
) AS d ON B.wg_id = d.wg_id AND A.mandant_id = d.mandant_id AND A.wup_id = d.wup_id
WHERE
    A.nb_id = 0
    AND A.mandant_id = ${mandant_id}
    AND A.list_komponente_fg = 0
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND A.art_id > 0
    AND TRIM(A.list_quelle_id) NOT IN ('2')
GROUP BY
    A.mandant_id,
    A.art_id,
    A.wup_id,
    d.sm_id,
    d.ksm_id;


CREATE OR REPLACE TEMPORARY TABLE _ist_listung_null_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    d.sm_id,
    d.ksm_id
FROM dbp_data.art_wup_zu_per_1 AS A
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
        = DATE '9999-12-31' AND B.arthiertyp_id = 2
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.wup_id,
        A0.wg_id,
        CASE
            WHEN A0.sm_id = 6
                THEN 5
            ELSE A0.sm_id
        END AS sm_id,
        TRIM(A0.ksm_id) AS ksm_id
    FROM dbp_data.sm_wup_wg_zu_per_1 AS A0
    INNER JOIN dbp_data.wup_1 AS B0
        ON
            A0.mandant_id = B0.mandant_id AND A0.wup_id = B0.wup_id AND
            CURRENT_DATE("Europe/Berlin") BETWEEN B0.dat_von AND B0.dat_bis
    INNER JOIN dbp_data.wg_filter_zu_1 AS WFZ
        ON
            A0.wg_id = WFZ.wg_id AND A0.mandant_id = WFZ.mandant_id AND
            WFZ.wg_filter_id = 47 AND WFZ.arthiertyp_id = 2
    WHERE
        A0.mandant_id = ${mandant_id}
        AND A0.arthiertyp_id = 2
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A0.dat_von AND A0.dat_bis
        AND (A0.sm_id BETWEEN 1 AND 6 OR TRIM(A0.ksm_id) IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9'))
        AND B0.nb_id = 0
    GROUP BY
        A0.mandant_id,
        A0.wup_id,
        A0.wg_id,
        sm_id,
        ksm_id
) AS d ON B.wg_id = d.wg_id AND A.mandant_id = d.mandant_id AND A.wup_id = d.wup_id
WHERE
    A.mandant_id = ${mandant_id}
    AND A.listung_id = 0
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND A.art_id > 0
GROUP BY
    A.mandant_id,
    A.art_id,
    A.wup_id,
    d.sm_id,
    d.ksm_id;


CREATE OR REPLACE TEMPORARY TABLE _ist_listung_article_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.sm_id,
    TRIM(A.ksm_id) AS ksm_id,
    COALESCE(B.kassenumsatz, 0) AS kassenumsatz_artikel,
    COALESCE(B.anz_tage, 0) AS anz_tage_artikel,
    COALESCE(B.preis, 0) AS preis_artikel,
    COALESCE(B.list_kz, 'A') AS list_kz,
    1 AS markt_zaehlung_fg
FROM `_ist_listung_1` AS A
LEFT JOIN `_sort_ist2_1` AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.art_id = B.art_id;


INSERT INTO `_ist_listung_article_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        B.sm_id,
        B.ksm_id,
        B.kassenumsatz AS kassenumsatz_artikel,
        B.anz_tage AS anz_tage_artikel,
        B.preis AS preis_artikel,
        B.list_kz,
        0 AS markt_zaehlung_fg
    FROM `_ist_listung_null_1` AS A
    INNER JOIN `_sort_ist2_1` AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.art_id = B.art_id
    WHERE (
        A.mandant_id, A.art_id, A.wup_id) NOT IN (
        SELECT (mandant_id, art_id, wup_id)
        FROM `_ist_listung_article_1`
    )
);


CREATE OR REPLACE TEMPORARY TABLE _art_list_wup_zu_per_1 AS
SELECT
    A.art_id,
    A.mandant_id,
    A.wup_id,
    TRIM(A.list_quelle_id) AS list_quelle_id
FROM dbp_data.art_list_wup_zu_per_1 AS A
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wup_1 AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
WHERE
    A.mandant_id = ${mandant_id}
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_1
        WHERE wg_filter_id = 11
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN C.dat_von AND C.dat_bis
    AND A.nb_id = 0
    AND C.nb_id = 0
    AND C.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin")
    AND TRIM(A.list_quelle_id) NOT IN ('2')
GROUP BY
    A.art_id,
    A.mandant_id,
    A.wup_id,
    list_quelle_id;


CREATE OR REPLACE TEMPORARY TABLE _art_list_wup_kill_1_1 AS
SELECT
    A.art_id,
    A.mandant_id,
    A.wup_id
FROM dbp_data.art_list_wup_zu_per_1 AS A
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wup_1 AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
WHERE
    A.mandant_id = ${mandant_id}
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_1
        WHERE wg_filter_id = 11
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN C.dat_von AND C.dat_bis
    AND A.list_komponente_fg = 1
    AND A.nb_id = 0
    AND C.nb_id = 0
    AND C.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin")
    AND TRIM(A.list_quelle_id) NOT IN ('2')
    AND (
        A.wup_id, A.art_id, A.mandant_id) NOT IN (
        SELECT (wup_id, art_id, mandant_id)
        FROM `_art_list_wup_zu_per_1`
    );


CREATE OR REPLACE TEMPORARY TABLE _art_list_wup_kill_2_1 AS
SELECT
    A.art_id,
    A.mandant_id,
    A.wup_id
FROM dbp_data.art_list_wup_zu_per_1 AS A
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wup_1 AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
WHERE
    A.mandant_id = ${mandant_id}
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_1
        WHERE wg_filter_id = 11
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN C.dat_von AND C.dat_bis
    AND TRIM(A.list_quelle_id) IN ('2')
    AND A.nb_id = 0
    AND C.nb_id = 0
    AND C.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin")
    AND (
        A.wup_id, A.art_id, A.mandant_id) NOT IN (
        SELECT (wup_id, art_id, mandant_id)
        FROM `_art_list_wup_zu_per_1`
    )
GROUP BY
    A.art_id,
    A.mandant_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _einzel_markt_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id
FROM dbp_data.art_list_wup_zu_per_1 AS A
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wup_1 AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
WHERE
    A.mandant_id = ${mandant_id}
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_1
        WHERE wg_filter_id = 11
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN C.dat_von AND C.dat_bis
    AND TRIM(A.list_quelle_id) IN ('C')
    AND A.list_komponente_fg = 0
    AND A.nb_id = 0
    AND C.nb_id = 0
    AND C.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.mandant_id,
    A.art_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _sonstige_bst_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id
FROM dbp_data.art_list_wup_zu_per_1 AS A
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wup_1 AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
WHERE
    A.mandant_id = ${mandant_id}
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_1
        WHERE wg_filter_id = 11
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN C.dat_von AND C.dat_bis
    AND TRIM(A.list_quelle_id) IN ('3')
    AND A.list_komponente_fg = 0
    AND A.nb_id = 0
    AND (
        A.mandant_id, A.baustein_id) IN (
        SELECT (mandant_id, baustein_id)
        FROM dbp_etl.baustein_wsop_1
        WHERE
            CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
            AND mandant_id = ${mandant_id}
    )
    AND C.nb_id = 0
    AND C.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.mandant_id,
    A.art_id,
    A.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _soll_listung_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    c.wup_id,
    c.sm_id,
    c.ksm_id
FROM dbp_data.art_1 AS A
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.wup_id,
        A0.wg_id,
        CASE
            WHEN A0.sm_id = 6
                THEN 5
            ELSE A0.sm_id
        END AS sm_id,
        TRIM(A0.ksm_id) AS ksm_id
    FROM dbp_data.sm_wup_wg_zu_per_1 AS A0
    INNER JOIN dbp_data.wup_1 AS B0
        ON
            A0.mandant_id = B0.mandant_id AND A0.wup_id = B0.wup_id AND
            CURRENT_DATE("Europe/Berlin") BETWEEN B0.dat_von AND B0.dat_bis
    INNER JOIN dbp_data.wg_filter_zu_1 AS WFZ
        ON
            A0.wg_id = WFZ.wg_id AND A0.mandant_id = WFZ.mandant_id AND
            WFZ.wg_filter_id = 47 AND WFZ.arthiertyp_id = 2
    WHERE
        A0.mandant_id = ${mandant_id}
        AND A0.arthiertyp_id = 2
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A0.dat_von AND A0.dat_bis
        AND (A0.sm_id BETWEEN 1 AND 6 OR TRIM(A0.ksm_id) IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9'))
        AND B0.nb_id = 0
    GROUP BY
        A0.mandant_id,
        A0.wup_id,
        A0.wg_id,
        sm_id,
        ksm_id
) AS c ON B.wg_id = c.wg_id AND B.mandant_id = c.mandant_id
WHERE
    A.mandant_id = ${mandant_id}
    AND A.dat_bis = DATE '9999-12-31'
GROUP BY
    A.mandant_id,
    A.art_id,
    c.wup_id,
    c.sm_id,
    c.ksm_id;


CREATE OR REPLACE TEMPORARY TABLE _markt_umsatz_gesamt_1 AS
SELECT
    wup_id,
    mandant_id,
    SUM(umsatz_netto + umsatz_mwst_betrag) AS kassenumsatz,
    COUNT(DISTINCT dat) AS anz_tage
FROM dbp_data.artbew_wg_tp2_sum_1
WHERE
    mandant_id = ${mandant_id}
    AND arthiertyp_id = 2
    AND dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 366 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
    AND bewart_id IN (1001, 1002)
GROUP BY
    wup_id,
    mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _ist_listung_article_plus_gesamt_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.sm_id,
    A.ksm_id,
    A.kassenumsatz_artikel,
    A.anz_tage_artikel,
    A.preis_artikel,
    A.list_kz,
    A.markt_zaehlung_fg,
    B.kassenumsatz AS kassenumsatz_gesamt,
    B.anz_tage AS anz_tage_gesamt
FROM `_ist_listung_article_1` AS A
LEFT JOIN `_markt_umsatz_gesamt_1` AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _sort_ist4_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.list_kz,
    COUNT(DISTINCT A.wup_id) AS anz_markt,
    IFNULL(SUM(CASE
        WHEN A.kassenumsatz_gesamt <> 0 AND COALESCE(b.markt_zaehlung_fg, 0) = 1
            THEN A.kassenumsatz_gesamt
        ELSE 0
    END) / IF(SUM(CASE
        WHEN A.kassenumsatz_gesamt <> 0 AND COALESCE(b.markt_zaehlung_fg, 0) = 1
            THEN CAST(A.anz_tage_gesamt AS INTEGER)
        ELSE 0
    END) = 0, NULL, SUM(CASE
        WHEN A.kassenumsatz_gesamt <> 0 AND COALESCE(b.markt_zaehlung_fg, 0) = 1
            THEN CAST(A.anz_tage_gesamt AS INTEGER)
        ELSE 0
    END)), 0) AS avg_umsatz_gesamt,
    IFNULL(SUM(CASE
        WHEN A.kassenumsatz_artikel <> 0 AND COALESCE(b.markt_zaehlung_fg, 0) = 1
            THEN A.kassenumsatz_artikel
        ELSE 0
    END) / IF(SUM(CASE
        WHEN A.kassenumsatz_artikel <> 0 AND COALESCE(b.markt_zaehlung_fg, 0) = 1
            THEN A.anz_tage_artikel
        ELSE 0
    END) = 0, NULL, SUM(CASE
        WHEN A.kassenumsatz_artikel <> 0 AND COALESCE(b.markt_zaehlung_fg, 0) = 1
            THEN A.anz_tage_artikel
        ELSE 0
    END)), 0) AS avg_umsatz_artikel,
    AVG(A.preis_artikel) AS preis
FROM `_ist_listung_article_plus_gesamt_1` AS A
LEFT JOIN (
    SELECT
        mandant_id,
        art_id,
        1 AS markt_zaehlung_fg
    FROM dbp_data.art_list_wup_zu_per_1
    WHERE
        dat_bis >= DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 366 DAY)
        AND mandant_id = ${mandant_id}
        AND list_quelle_id NOT IN ('2')
    GROUP BY
        mandant_id,
        art_id
) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
GROUP BY
    A.mandant_id,
    A.art_id,
    A.list_kz;


CREATE OR REPLACE TEMPORARY TABLE _differenz_soll_1 AS
SELECT *
FROM `_soll_listung_1`
WHERE
    sm_id IS NOT NULL
    AND (
        mandant_id, art_id, wup_id, sm_id) NOT IN (
        SELECT (mandant_id, art_id, wup_id, sm_id)
        FROM `_ist_listung_1`
        WHERE sm_id IS NOT NULL
    );


INSERT INTO `_differenz_soll_1`
(
    SELECT *
    FROM `_soll_listung_1`
    WHERE
        ksm_id IS NOT NULL
        AND (
            mandant_id, art_id, wup_id, ksm_id) NOT IN (
            SELECT (mandant_id, art_id, wup_id, ksm_id)
            FROM `_ist_listung_1`
            WHERE ksm_id IS NOT NULL
        )
);


CREATE OR REPLACE TEMPORARY TABLE _differenz_soll_1_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.sm_id,
    A.ksm_id,
    B.kassenumsatz AS kassenumsatz_gesamt,
    B.anz_tage AS anz_tage_gesamt,
    IFNULL(B.kassenumsatz / IF(B.anz_tage = 0, NULL, B.anz_tage), 0) AS avg_umsatz_gesamt
FROM `_differenz_soll_1` AS A
LEFT JOIN `_markt_umsatz_gesamt_1` AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _list_extended_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    1 AS sm_id_selected,
    '  ' AS ksm_id_selected,
    A.sm_id,
    TRIM(A.ksm_id) AS ksm_id,
    B.list_kz,
    A.wup_id,
    A.avg_umsatz_gesamt,
    B.avg_umsatz_artikel,
    B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
    IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage} *
    COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
    IFNULL(
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) *
        ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
    ) AS absatz_kpi,
    IFNULL(
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
        * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
        C.rohertrag_einheit,
        0
    ) AS rohertrag_kpi
FROM `_differenz_soll_1_1` AS A
INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
LEFT JOIN (
    dbp_data.sal_kmo_1 AS C INNER JOIN (
        SELECT MAX(kjmo) AS a1886105636
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = ${mandant_id}
    ) AS t0
        ON C.kjmo = t0.a1886105636
) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
WHERE A.sm_id >= 1;


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        2 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE A.sm_id >= 2
);


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        3 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE A.sm_id >= 3
);


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        4 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE A.sm_id >= 4
);


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        5 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE A.sm_id >= 5
);


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K1' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
);


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K2' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
);


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K3' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
);


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K4' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K4', 'K5', 'K6', 'K7', 'K8', 'K9')
);


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K5' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K5', 'K6', 'K7', 'K8', 'K9')
);


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K6' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K6', 'K7', 'K8', 'K9')
);


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K7' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K7', 'K8', 'K9')
);


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K8' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K8', 'K9')
);


INSERT INTO `_list_extended_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K9' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        A.avg_umsatz_gesamt,
        B.avg_umsatz_artikel,
        B.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0) * ${anz_tage}
        * COALESCE(C.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0)
            * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(B.avg_umsatz_artikel * A.avg_umsatz_gesamt / IF(B.avg_umsatz_gesamt = 0, NULL, B.avg_umsatz_gesamt), 0
            ) * ${anz_tage} * COALESCE(C.schnelldreherquote / 100, 0) / IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(
            C.rohertrag_einheit,
            0
        ) AS rohertrag_kpi
    FROM `_differenz_soll_1_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K9')
);


CREATE OR REPLACE TEMPORARY TABLE _sort_ist3_reduction_1 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.art_id,
    A.sm_id,
    TRIM(A.ksm_id) AS ksm_id,
    A.kassenumsatz_artikel,
    A.anz_tage_artikel,
    0 AS anz_tage_listung_artikel
FROM `_ist_listung_article_plus_gesamt_1` AS A
LEFT JOIN `_markt_umsatz_gesamt_1` AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _sort_ist3_group AS
SELECT
    mandant_id,
    wup_id,
    art_id
FROM `_sort_ist3_reduction_1`
GROUP BY
    mandant_id,
    wup_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _schnelldreherquote_day AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.art_id,
    MIN(A.dat_von) AS min_dat,
    MAX(A.dat_bis) AS max_dat
FROM dbp_data.art_list_wup_zu_per_1 AS A
INNER JOIN `_sort_ist3_group` AS B ON A.wup_id = B.wup_id AND A.art_id = B.art_id AND A.mandant_id = B.mandant_id
WHERE
    TRIM(A.list_quelle_id) <> '-2'
    AND A.nb_id = 0
    AND A.list_komponente_fg = 0
    AND A.mandant_id = ${mandant_id}
    AND A.dat_bis >= DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 366 DAY)
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _tage AS
SELECT
    B.dat,
    A.mandant_id,
    A.wup_id,
    A.art_id
FROM `_schnelldreherquote_day` AS A
INNER JOIN dbp_data.tag_1 AS B ON B.dat BETWEEN A.min_dat AND A.max_dat
WHERE B.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 366 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY));


UPDATE `_sort_ist3_reduction_1` SET
    anz_tage_listung_artikel = CASE
        WHEN b.anz_tage > ${anz_tage}
            THEN ${anz_tage}
        ELSE CAST(b.anz_tage AS INTEGER)
    END FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        COUNT(DISTINCT dat) AS anz_tage
    FROM `_tage`
    GROUP BY
        mandant_id,
        wup_id,
        art_id
) AS b
WHERE
    `_sort_ist3_reduction_1`.mandant_id = b.mandant_id AND `_sort_ist3_reduction_1`.art_id = b.art_id AND
    `_sort_ist3_reduction_1`.wup_id = b.wup_id;


CREATE OR REPLACE TEMPORARY TABLE _list_reduced_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    2 AS sm_id_selected,
    '  ' AS ksm_id_selected,
    A.sm_id,
    TRIM(A.ksm_id) AS ksm_id,
    B.list_kz,
    A.wup_id,
    -1 * IFNULL(
        A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(CAST(A.anz_tage_artikel AS FLOAT64)
    / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0) AS
    umsatz_kpi,
    IFNULL(-1 * IFNULL(
        A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
        CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
    ) / IF(B.preis = 0, NULL, B.preis
    ), 0) AS absatz_kpi,
    IFNULL(-1 * IFNULL(
        A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
        CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
    ) / IF(B.preis = 0, NULL, B.preis
    ), 0) * COALESCE(C.rohertrag_einheit, 0) AS rohertrag_kpi
FROM `_sort_ist3_reduction_1` AS A
INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
LEFT JOIN (
    dbp_data.sal_kmo_1 AS C INNER JOIN (
        SELECT MAX(kjmo) AS a1886105636
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = ${mandant_id}
    ) AS t0
        ON C.kjmo = t0.a1886105636
) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
WHERE A.sm_id < 2
GROUP BY
    A.mandant_id,
    A.art_id,
    sm_id_selected,
    ksm_id_selected,
    A.sm_id,
    ksm_id,
    B.list_kz,
    A.wup_id,
    umsatz_kpi,
    absatz_kpi,
    rohertrag_kpi;


INSERT INTO `_list_reduced_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        3 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        -1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0) AS
        umsatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) / IF(B.preis = 0, NULL, B.preis
        ), 0) AS absatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) /
        IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(C.rohertrag_einheit, 0) AS rohertrag_kpi
    FROM `_sort_ist3_reduction_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE A.sm_id < 3
    GROUP BY
        A.mandant_id,
        A.art_id,
        sm_id_selected,
        ksm_id_selected,
        A.sm_id,
        ksm_id,
        B.list_kz,
        A.wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


INSERT INTO `_list_reduced_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        4 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        -1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0) AS
        umsatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) / IF(B.preis = 0, NULL, B.preis
        ), 0) AS absatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) /
        IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(C.rohertrag_einheit, 0) AS rohertrag_kpi
    FROM `_sort_ist3_reduction_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE A.sm_id < 4
    GROUP BY
        A.mandant_id,
        A.art_id,
        sm_id_selected,
        ksm_id_selected,
        A.sm_id,
        ksm_id,
        B.list_kz,
        A.wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


INSERT INTO `_list_reduced_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        5 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        -1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0) AS
        umsatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) / IF(B.preis = 0, NULL, B.preis
        ), 0) AS absatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) /
        IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(C.rohertrag_einheit, 0) AS rohertrag_kpi
    FROM `_sort_ist3_reduction_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE A.sm_id < 5
    GROUP BY
        A.mandant_id,
        A.art_id,
        sm_id_selected,
        ksm_id_selected,
        A.sm_id,
        ksm_id,
        B.list_kz,
        A.wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


INSERT INTO `_list_reduced_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K2' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        -1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0) AS
        umsatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) / IF(B.preis = 0, NULL, B.preis
        ), 0) AS absatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) /
        IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(C.rohertrag_einheit, 0) AS rohertrag_kpi
    FROM `_sort_ist3_reduction_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K1')
    GROUP BY
        A.mandant_id,
        A.art_id,
        sm_id_selected,
        ksm_id_selected,
        A.sm_id,
        ksm_id,
        B.list_kz,
        A.wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


INSERT INTO `_list_reduced_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K3' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        -1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0) AS
        umsatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) / IF(B.preis = 0, NULL, B.preis
        ), 0) AS absatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) /
        IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(C.rohertrag_einheit, 0) AS rohertrag_kpi
    FROM `_sort_ist3_reduction_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K1', 'K2')
    GROUP BY
        A.mandant_id,
        A.art_id,
        sm_id_selected,
        ksm_id_selected,
        A.sm_id,
        ksm_id,
        B.list_kz,
        A.wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


INSERT INTO `_list_reduced_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K4' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        -1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0) AS
        umsatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) / IF(B.preis = 0, NULL, B.preis
        ), 0) AS absatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) /
        IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(C.rohertrag_einheit, 0) AS rohertrag_kpi
    FROM `_sort_ist3_reduction_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K1', 'K2', 'K3')
    GROUP BY
        A.mandant_id,
        A.art_id,
        sm_id_selected,
        ksm_id_selected,
        A.sm_id,
        ksm_id,
        B.list_kz,
        A.wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


INSERT INTO `_list_reduced_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K5' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        -1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0) AS
        umsatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) / IF(B.preis = 0, NULL, B.preis
        ), 0) AS absatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) /
        IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(C.rohertrag_einheit, 0) AS rohertrag_kpi
    FROM `_sort_ist3_reduction_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K1', 'K2', 'K3', 'K4')
    GROUP BY
        A.mandant_id,
        A.art_id,
        sm_id_selected,
        ksm_id_selected,
        A.sm_id,
        ksm_id,
        B.list_kz,
        A.wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


INSERT INTO `_list_reduced_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K6' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        -1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0) AS
        umsatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) / IF(B.preis = 0, NULL, B.preis
        ), 0) AS absatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) /
        IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(C.rohertrag_einheit, 0) AS rohertrag_kpi
    FROM `_sort_ist3_reduction_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K1', 'K2', 'K3', 'K4', 'K5')
    GROUP BY
        A.mandant_id,
        A.art_id,
        sm_id_selected,
        ksm_id_selected,
        A.sm_id,
        ksm_id,
        B.list_kz,
        A.wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


INSERT INTO `_list_reduced_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K7' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        -1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0) AS
        umsatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) / IF(B.preis = 0, NULL, B.preis
        ), 0) AS absatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) /
        IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(C.rohertrag_einheit, 0) AS rohertrag_kpi
    FROM `_sort_ist3_reduction_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6')
    GROUP BY
        A.mandant_id,
        A.art_id,
        sm_id_selected,
        ksm_id_selected,
        A.sm_id,
        ksm_id,
        B.list_kz,
        A.wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


INSERT INTO `_list_reduced_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K8' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        -1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0) AS
        umsatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) / IF(B.preis = 0, NULL, B.preis
        ), 0) AS absatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) /
        IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(C.rohertrag_einheit, 0) AS rohertrag_kpi
    FROM `_sort_ist3_reduction_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7')
    GROUP BY
        A.mandant_id,
        A.art_id,
        sm_id_selected,
        ksm_id_selected,
        A.sm_id,
        ksm_id,
        B.list_kz,
        A.wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


INSERT INTO `_list_reduced_1`
(
    SELECT
        A.mandant_id,
        A.art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K9' AS ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        B.list_kz,
        A.wup_id,
        -1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(CAST(A.anz_tage_artikel AS FLOAT64)
        / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0) AS
        umsatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) / IF(B.preis = 0, NULL, B.preis
        ), 0) AS absatz_kpi,
        IFNULL(-1 * IFNULL(
            A.kassenumsatz_artikel / IF(A.anz_tage_artikel = 0, NULL, A.anz_tage_artikel), 0) * ${anz_tage} * IFNULL(
            CAST(A.anz_tage_artikel AS FLOAT64)
            / IF(CAST(A.anz_tage_listung_artikel AS FLOAT64) = 0, NULL, CAST(A.anz_tage_listung_artikel AS FLOAT64)), 0
        ) /
        IF(B.preis = 0, NULL, B.preis), 0) * COALESCE(C.rohertrag_einheit, 0) AS rohertrag_kpi
    FROM `_sort_ist3_reduction_1` AS A
    INNER JOIN `_sort_ist4_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    LEFT JOIN (
        dbp_data.sal_kmo_1 AS C INNER JOIN (
            SELECT MAX(kjmo) AS a1886105636
            FROM dbp_data.sortiment_leistung_1
            WHERE mandant_id = ${mandant_id}
        ) AS t0
            ON C.kjmo = t0.a1886105636
    ) ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    WHERE TRIM(A.ksm_id) IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8')
    GROUP BY
        A.mandant_id,
        A.art_id,
        sm_id_selected,
        ksm_id_selected,
        A.sm_id,
        ksm_id,
        B.list_kz,
        A.wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


CREATE OR REPLACE TEMPORARY TABLE _list_delisted_1 AS
SELECT
    mandant_id,
    art_id,
    0 AS sm_id_selected,
    '  ' AS ksm_id_selected,
    sm_id,
    TRIM(ksm_id) AS ksm_id,
    list_kz,
    wup_id,
    umsatz_kpi,
    absatz_kpi,
    rohertrag_kpi
FROM `_list_reduced_1` AS A
WHERE sm_id <= 5
GROUP BY
    mandant_id,
    art_id,
    sm_id_selected,
    ksm_id_selected,
    sm_id,
    ksm_id,
    list_kz,
    wup_id,
    umsatz_kpi,
    absatz_kpi,
    rohertrag_kpi;


INSERT INTO `_list_delisted_1`
(
    SELECT
        mandant_id,
        art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K0' AS ksm_id_selected,
        sm_id,
        TRIM(ksm_id) AS ksm_id,
        list_kz,
        wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
    FROM `_list_reduced_1` AS A
    WHERE TRIM(ksm_id) IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
    GROUP BY
        mandant_id,
        art_id,
        sm_id_selected,
        ksm_id_selected,
        sm_id,
        ksm_id,
        list_kz,
        wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


INSERT INTO `_list_delisted_1`
(
    SELECT
        mandant_id,
        art_id,
        -1 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        sm_id,
        TRIM(ksm_id) AS ksm_id,
        list_kz,
        wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
    FROM `_list_reduced_1` AS A
    WHERE sm_id <= 5
    GROUP BY
        mandant_id,
        art_id,
        A.sm_id_selected,
        A.ksm_id_selected,
        sm_id,
        A.ksm_id,
        list_kz,
        wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


INSERT INTO `_list_delisted_1`
(
    SELECT
        mandant_id,
        art_id,
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'KK' AS ksm_id_selected,
        sm_id,
        TRIM(ksm_id) AS ksm_id,
        list_kz,
        wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
    FROM `_list_reduced_1` AS A
    WHERE TRIM(ksm_id) IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
    GROUP BY
        mandant_id,
        art_id,
        sm_id_selected,
        ksm_id_selected,
        sm_id,
        ksm_id,
        list_kz,
        wup_id,
        umsatz_kpi,
        absatz_kpi,
        rohertrag_kpi
);


CREATE OR REPLACE TEMPORARY TABLE _track_sst_1 AS
SELECT
    mandant_id,
    kjwo_update,
    art_id,
    CASE
        WHEN listung_sst_mvke IN ('N/A', 'R')
            THEN NULL
        ELSE listung_sst_mvke
    END AS listung_sst_mvke
FROM dbp_data.sortiment_leistung_1
WHERE
    kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = ${mandant_id}
    )
    AND mandant_id = ${mandant_id}
    AND (
        anz_maerkte_k_sst <> 0 OR anz_maerkte_sst <> 0 OR anz_maerkte_baustein_sonstige <> 0 OR anz_maerkte_listung_einzel
        <> 0 OR anz_maerkte_listung_gesamt <> 0
    )
GROUP BY
    mandant_id,
    kjwo_update,
    art_id,
    listung_sst_mvke;


CREATE OR REPLACE TEMPORARY TABLE _track_ksst_1 AS
SELECT
    mandant_id,
    kjwo_update,
    art_id,
    CASE
        WHEN listung_k_sst_mvke IN ('N/A', 'R')
            THEN NULL
        ELSE listung_k_sst_mvke
    END AS listung_k_sst_mvke
FROM dbp_data.sortiment_leistung_1
WHERE
    kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.sortiment_leistung_1
        WHERE mandant_id = ${mandant_id}
    )
    AND mandant_id = ${mandant_id}
    AND (
        anz_maerkte_k_sst <> 0 OR anz_maerkte_sst <> 0 OR anz_maerkte_baustein_sonstige <> 0 OR anz_maerkte_listung_einzel
        <> 0 OR anz_maerkte_listung_gesamt <> 0
    )
GROUP BY
    mandant_id,
    kjwo_update,
    art_id,
    listung_k_sst_mvke;


UPDATE `_list_reduced_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM `_art_list_wup_kill_1_1`
    GROUP BY
        art_id,
        mandant_id,
        wup_id
) AS t0
WHERE
    `_list_reduced_1`.mandant_id = t0.mandant_id AND `_list_reduced_1`.wup_id = t0.wup_id AND `_list_reduced_1`.art_id
    = t0.art_id;


UPDATE `_list_reduced_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM `_art_list_wup_kill_2_1`
    GROUP BY
        art_id,
        mandant_id,
        wup_id
) AS t0
WHERE
    `_list_reduced_1`.mandant_id = t0.mandant_id AND `_list_reduced_1`.wup_id = t0.wup_id AND `_list_reduced_1`.art_id
    = t0.art_id;


UPDATE `_list_reduced_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id,
        COALESCE(CAST(B.listung_sst_mvke AS BIGNUMERIC), 6) AS listung_sst_mvke
    FROM `_art_list_wup_zu_per_1` AS A
    INNER JOIN `_track_sst_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    WHERE
        B.listung_sst_mvke IS NOT NULL
        AND B.listung_sst_mvke NOT IN ('R')
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.art_id,
        listung_sst_mvke
) AS b
WHERE
    `_list_reduced_1`.mandant_id = b.mandant_id AND `_list_reduced_1`.wup_id = b.wup_id AND `_list_reduced_1`.art_id =
    b.art_id AND `_list_reduced_1`.sm_id < ROUND(CAST(b.listung_sst_mvke AS BIGNUMERIC), 0);


UPDATE `_list_reduced_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id,
        COALESCE(B.listung_k_sst_mvke, 'K9') AS listung_k_sst_mvke
    FROM `_art_list_wup_zu_per_1` AS A
    INNER JOIN `_track_ksst_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    WHERE
        B.listung_k_sst_mvke IS NOT NULL
        AND B.listung_k_sst_mvke NOT IN ('R')
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.art_id,
        listung_k_sst_mvke
) AS b
WHERE
    `_list_reduced_1`.mandant_id = b.mandant_id AND `_list_reduced_1`.wup_id = b.wup_id AND `_list_reduced_1`.art_id =
    b.art_id AND SUBSTR(TRIM(`_list_reduced_1`.ksm_id), 2, 1) < SUBSTR(TRIM(b.listung_k_sst_mvke), 2, 1);


UPDATE `_list_reduced_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM `_sonstige_bst_1`
    GROUP BY
        mandant_id,
        art_id,
        wup_id
) AS t0
WHERE
    `_list_reduced_1`.mandant_id = t0.mandant_id AND `_list_reduced_1`.wup_id = t0.wup_id AND `_list_reduced_1`.art_id
    = t0.art_id;


UPDATE `_list_extended_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM `_art_list_wup_kill_1_1`
    GROUP BY
        art_id,
        mandant_id,
        wup_id
) AS t0
WHERE
    `_list_extended_1`.mandant_id = t0.mandant_id AND `_list_extended_1`.wup_id = t0.wup_id AND `_list_extended_1`.art_id
    = t0.art_id;


UPDATE `_list_extended_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM `_art_list_wup_kill_2_1`
    GROUP BY
        art_id,
        mandant_id,
        wup_id
) AS t0
WHERE
    `_list_extended_1`.mandant_id = t0.mandant_id AND `_list_extended_1`.wup_id = t0.wup_id AND `_list_extended_1`.art_id
    = t0.art_id;


UPDATE `_list_extended_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id,
        COALESCE(CAST(B.listung_sst_mvke AS BIGNUMERIC), 1) AS listung_sst_mvke
    FROM `_art_list_wup_zu_per_1` AS A
    INNER JOIN `_track_sst_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    WHERE
        B.listung_sst_mvke IS NOT NULL
        AND B.listung_sst_mvke NOT IN ('R')
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.art_id,
        listung_sst_mvke
) AS b
WHERE
    `_list_extended_1`.mandant_id = b.mandant_id AND `_list_extended_1`.wup_id = b.wup_id AND `_list_extended_1`.art_id
    = b.art_id AND `_list_extended_1`.sm_id >= ROUND(CAST(b.listung_sst_mvke AS BIGNUMERIC), 0);


UPDATE `_list_extended_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id,
        COALESCE(B.listung_k_sst_mvke, 'K1') AS listung_k_sst_mvke
    FROM `_art_list_wup_zu_per_1` AS A
    INNER JOIN `_track_ksst_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    WHERE
        B.listung_k_sst_mvke IS NOT NULL
        AND B.listung_k_sst_mvke NOT IN ('R')
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.art_id,
        listung_k_sst_mvke
) AS b
WHERE
    `_list_extended_1`.mandant_id = b.mandant_id AND `_list_extended_1`.wup_id = b.wup_id AND `_list_extended_1`.art_id
    = b.art_id AND SUBSTR(TRIM(`_list_extended_1`.ksm_id), 2, 1) >= SUBSTR(TRIM(b.listung_k_sst_mvke), 2, 1);


UPDATE `_list_extended_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM `_sonstige_bst_1`
    GROUP BY
        mandant_id,
        art_id,
        wup_id
) AS t0
WHERE
    `_list_extended_1`.mandant_id = t0.mandant_id AND `_list_extended_1`.wup_id = t0.wup_id AND `_list_extended_1`.art_id
    = t0.art_id;


UPDATE `_list_delisted_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM `_art_list_wup_kill_1_1`
    GROUP BY
        art_id,
        mandant_id,
        wup_id
) AS t0
WHERE
    `_list_delisted_1`.mandant_id = t0.mandant_id AND `_list_delisted_1`.wup_id = t0.wup_id AND `_list_delisted_1`.art_id
    = t0.art_id AND (`_list_delisted_1`.sm_id_selected = -1 OR `_list_delisted_1`.ksm_id_selected = 'KK');


UPDATE `_list_delisted_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM `_art_list_wup_kill_2_1`
    GROUP BY
        art_id,
        mandant_id,
        wup_id
) AS t0
WHERE
    `_list_delisted_1`.mandant_id = t0.mandant_id AND `_list_delisted_1`.wup_id = t0.wup_id AND `_list_delisted_1`.art_id
    = t0.art_id AND (`_list_delisted_1`.sm_id_selected = -1 OR `_list_delisted_1`.ksm_id_selected = 'KK');


UPDATE `_list_delisted_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id,
        COALESCE(CAST(B.listung_sst_mvke AS BIGNUMERIC), 6) AS listung_sst_mvke
    FROM `_art_list_wup_zu_per_1` AS A
    INNER JOIN `_track_sst_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    WHERE
        B.listung_sst_mvke IS NOT NULL
        AND B.listung_sst_mvke NOT IN ('R')
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.art_id,
        listung_sst_mvke
) AS b
WHERE
    `_list_delisted_1`.mandant_id = b.mandant_id AND `_list_delisted_1`.wup_id = b.wup_id AND `_list_delisted_1`.art_id
    = b.art_id AND `_list_delisted_1`.sm_id < ROUND(CAST(b.listung_sst_mvke AS BIGNUMERIC), 0) AND `_list_delisted_1`.sm_id_selected
    = -1;


UPDATE `_list_delisted_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id,
        COALESCE(B.listung_k_sst_mvke, 'K9') AS listung_k_sst_mvke
    FROM `_art_list_wup_zu_per_1` AS A
    INNER JOIN `_track_ksst_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    WHERE
        B.listung_k_sst_mvke IS NOT NULL
        AND B.listung_k_sst_mvke NOT IN ('R')
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.art_id,
        listung_k_sst_mvke
) AS b
WHERE
    `_list_delisted_1`.mandant_id = b.mandant_id AND `_list_delisted_1`.wup_id = b.wup_id AND `_list_delisted_1`.art_id
    = b.art_id AND SUBSTR(
        TRIM(`_list_delisted_1`.ksm_id), 2, 1) < SUBSTR(TRIM(b.listung_k_sst_mvke), 2, 1) AND TRIM(
        `_list_delisted_1`
        .ksm_id_selected
    ) = 'KK';


UPDATE `_list_delisted_1` SET
    umsatz_kpi = 0,
    absatz_kpi = 0,
    rohertrag_kpi = 0 FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM `_sonstige_bst_1`
    GROUP BY
        mandant_id,
        art_id,
        wup_id
) AS t0
WHERE
    `_list_delisted_1`.mandant_id = t0.mandant_id AND `_list_delisted_1`.wup_id = t0.wup_id AND `_list_delisted_1`.art_id
    = t0.art_id AND (`_list_delisted_1`.sm_id_selected = -1 OR `_list_delisted_1`.ksm_id_selected = 'KK');


DELETE FROM dbp_msi_data.kl_listung_kmo_1
WHERE mandant_id = ${mandant_id} AND kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche_1
    WHERE akt_wo = 1
);


INSERT INTO dbp_msi_data.kl_listung_kmo_1 (
    kl_listung_kmo_id, mandant_id, listung_art, art_id, wup_id,
    sm_id_selected, ksm_id_selected, sm_id, ksm_id, umsatz_hr, absatz_hr, rohertrag_hr, erweiterung_fg, reduktion_fg,
    kjwo_update, list_kz
)
(
    SELECT
        CAST((ROW_NUMBER() OVER (
            ORDER BY
                'Listung reduzieren' IS NULL, 'Listung reduzieren', `_list_reduced_1`.mandant_id IS NULL, `_list_reduced_1`.mandant_id, `_list_reduced_1`.art_id IS NULL, `_list_reduced_1`.art_id, `_list_reduced_1`.sm_id_selected IS NULL, `_list_reduced_1`.sm_id_selected,
                `_list_reduced_1`.ksm_id_selected IS NULL, `_list_reduced_1`.ksm_id_selected, `_list_reduced_1`.sm_id IS NULL, `_list_reduced_1`.sm_id, `_list_reduced_1`.ksm_id IS NULL, `_list_reduced_1`.ksm_id, `_list_reduced_1`.wup_id IS NULL, `_list_reduced_1`.wup_id, `_list_reduced_1`.umsatz_kpi IS NULL,
                `_list_reduced_1`.umsatz_kpi, `_list_reduced_1`.absatz_kpi IS NULL, `_list_reduced_1`.absatz_kpi, `_list_reduced_1`.rohertrag_kpi IS NULL, `_list_reduced_1`.rohertrag_kpi, 0 IS NULL, 0, 0 IS NULL, 0, B.kjwo IS NULL, B.kjwo, `_list_reduced_1`.list_kz IS NULL, `_list_reduced_1`.list_kz
        )) +
        COALESCE((
            SELECT MAX(kl_listung_kmo_id)
            FROM dbp_msi_data.kl_listung_kmo_1
            WHERE kl_listung_kmo_id <> 0
        ), 0) AS NUMERIC) AS kl_listung_kmo_id,
        `_list_reduced_1`.mandant_id,
        'Listung reduzieren' AS listung_art,
        `_list_reduced_1`.art_id,
        `_list_reduced_1`.wup_id,
        `_list_reduced_1`.sm_id_selected,
        `_list_reduced_1`.ksm_id_selected,
        `_list_reduced_1`.sm_id,
        `_list_reduced_1`.ksm_id,
        ROUND(CAST(`_list_reduced_1`.umsatz_kpi AS NUMERIC), 4) AS umsatz_kpi,
        ROUND(CAST(`_list_reduced_1`.absatz_kpi AS NUMERIC), 4) AS absatz_kpi,
        CAST(`_list_reduced_1`.rohertrag_kpi AS NUMERIC) AS rohertrag_kpi,
        0 AS erweiterung_fg,
        0 AS reduktion_fg,
        B.kjwo AS kjwo_update,
        `_list_reduced_1`.list_kz
    FROM `_list_reduced_1`
    INNER JOIN dbp_data.woche_1 AS B ON TRUE
    WHERE
        B.kjwo IN (
            SELECT kjwo
            FROM dbp_data.woche_1
            WHERE akt_wo = 1
        )
);


INSERT INTO dbp_msi_data.kl_listung_kmo_1 (
    kl_listung_kmo_id, mandant_id, listung_art, art_id, wup_id,
    sm_id_selected, ksm_id_selected, sm_id, ksm_id, umsatz_hr, absatz_hr, rohertrag_hr, erweiterung_fg, reduktion_fg,
    kjwo_update, list_kz
)
(
    SELECT
        CAST((ROW_NUMBER() OVER (
            ORDER BY
                'Listung erweitern' IS NULL, 'Listung erweitern', `_list_extended_1`.mandant_id IS NULL, `_list_extended_1`.mandant_id, `_list_extended_1`.art_id IS NULL, `_list_extended_1`.art_id, `_list_extended_1`.sm_id_selected IS NULL, `_list_extended_1`.sm_id_selected,
                `_list_extended_1`.ksm_id_selected IS NULL, `_list_extended_1`.ksm_id_selected, `_list_extended_1`.sm_id IS NULL, `_list_extended_1`.sm_id, `_list_extended_1`.ksm_id IS NULL, `_list_extended_1`.ksm_id, `_list_extended_1`.wup_id IS NULL, `_list_extended_1`.wup_id, `_list_extended_1`.umsatz_kpi
                IS NULL, `_list_extended_1`.umsatz_kpi, `_list_extended_1`.absatz_kpi IS NULL, `_list_extended_1`.absatz_kpi, `_list_extended_1`.rohertrag_kpi IS NULL, `_list_extended_1`.rohertrag_kpi, 0 IS NULL, 0, 0 IS NULL, 0, B.kjwo IS NULL, B.kjwo, `_list_extended_1`.list_kz IS NULL, `_list_extended_1`
                .list_kz
        )) + COALESCE((SELECT
            MAX(kl_listung_kmo_id
            )
        FROM dbp_msi_data.kl_listung_kmo_1
        WHERE kl_listung_kmo_id <> 0), 0) AS NUMERIC) AS kl_listung_kmo_id,
        `_list_extended_1`.mandant_id,
        'Listung erweitern' AS listung_art,
        `_list_extended_1`.art_id,
        `_list_extended_1`.wup_id,
        `_list_extended_1`.sm_id_selected,
        `_list_extended_1`.ksm_id_selected,
        `_list_extended_1`.sm_id,
        `_list_extended_1`.ksm_id,
        CAST(`_list_extended_1`.umsatz_kpi AS NUMERIC) AS umsatz_kpi,
        CAST(`_list_extended_1`.absatz_kpi AS NUMERIC) AS absatz_kpi,
        CAST(`_list_extended_1`.rohertrag_kpi AS NUMERIC) AS rohertrag_kpi,
        0 AS erweiterung_fg,
        0 AS reduktion_fg,
        B.kjwo AS kjwo_update,
        `_list_extended_1`.list_kz
    FROM `_list_extended_1`
    INNER JOIN dbp_data.woche_1 AS B ON TRUE
    WHERE
        B.kjwo IN (
            SELECT kjwo
            FROM dbp_data.woche_1
            WHERE akt_wo = 1
        )
);


INSERT INTO dbp_msi_data.kl_listung_kmo_1 (
    kl_listung_kmo_id, mandant_id, listung_art, art_id, wup_id,
    sm_id_selected, ksm_id_selected, sm_id, ksm_id, umsatz_hr, absatz_hr, rohertrag_hr, erweiterung_fg, reduktion_fg,
    kjwo_update, list_kz
)
(
    SELECT
        CAST((ROW_NUMBER() OVER (
            ORDER BY
                'Auslistung' IS NULL, 'Auslistung', `_list_delisted_1`.mandant_id IS NULL, `_list_delisted_1`.mandant_id, `_list_delisted_1`.art_id IS NULL, `_list_delisted_1`.art_id, `_list_delisted_1`.sm_id_selected IS NULL, `_list_delisted_1`.sm_id_selected,
                `_list_delisted_1`.ksm_id_selected IS NULL, `_list_delisted_1`.ksm_id_selected, `_list_delisted_1`.sm_id IS NULL, `_list_delisted_1`.sm_id, `_list_delisted_1`.ksm_id IS NULL, `_list_delisted_1`.ksm_id, `_list_delisted_1`.wup_id IS NULL, `_list_delisted_1`.wup_id, `_list_delisted_1`.umsatz_kpi
                IS NULL, `_list_delisted_1`.umsatz_kpi, `_list_delisted_1`.absatz_kpi IS NULL, `_list_delisted_1`.absatz_kpi, `_list_delisted_1`.rohertrag_kpi IS NULL, `_list_delisted_1`.rohertrag_kpi, 0 IS NULL, 0, 0 IS NULL, 0, B.kjwo IS NULL, B.kjwo, `_list_delisted_1`.list_kz IS NULL, `_list_delisted_1`
                .list_kz
        )) + COALESCE((SELECT
            MAX(kl_listung_kmo_id
            )
        FROM dbp_msi_data.kl_listung_kmo_1
        WHERE kl_listung_kmo_id <> 0), 0) AS NUMERIC) AS kl_listung_kmo_id,
        `_list_delisted_1`.mandant_id,
        'Auslistung' AS listung_art,
        `_list_delisted_1`.art_id,
        `_list_delisted_1`.wup_id,
        `_list_delisted_1`.sm_id_selected,
        `_list_delisted_1`.ksm_id_selected,
        `_list_delisted_1`.sm_id,
        `_list_delisted_1`.ksm_id,
        ROUND(CAST(`_list_delisted_1`.umsatz_kpi AS NUMERIC), 4) AS umsatz_kpi,
        ROUND(CAST(`_list_delisted_1`.absatz_kpi AS NUMERIC), 4) AS absatz_kpi,
        CAST(`_list_delisted_1`.rohertrag_kpi AS NUMERIC) AS rohertrag_kpi,
        0 AS erweiterung_fg,
        0 AS reduktion_fg,
        B.kjwo AS kjwo_update,
        `_list_delisted_1`.list_kz
    FROM `_list_delisted_1`
    INNER JOIN dbp_data.woche_1 AS B ON TRUE
    WHERE
        B.kjwo IN (
            SELECT kjwo
            FROM dbp_data.woche_1
            WHERE akt_wo = 1
        )
);


CREATE OR REPLACE TEMPORARY TABLE _track_soll_1 AS
SELECT
    mandant_id,
    wup_id,
    art_id,
    sm_id,
    ksm_id
FROM `_differenz_soll_1`
GROUP BY
    mandant_id,
    wup_id,
    art_id,
    sm_id,
    ksm_id;


DELETE FROM `_track_soll_1`
WHERE (
    mandant_id, wup_id, art_id) IN (
    SELECT (mandant_id, wup_id, art_id)
    FROM `_art_list_wup_kill_2_1`
);


DELETE FROM `_track_soll_1`
WHERE (
    mandant_id, wup_id, art_id, sm_id) IN (
    SELECT (A.mandant_id, A.wup_id, A.art_id, C.sm_id)
    FROM `_art_list_wup_zu_per_1` AS A
    INNER JOIN `_track_sst_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    INNER JOIN `_track_soll_1` AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id AND A.art_id = C.art_id AND C.sm_id >= ROUND(CAST(COALESCE(CAST(B.listung_sst_mvke AS BIGNUMERIC), 1) AS BIGNUMERIC), 0)
    GROUP BY A.mandant_id,
    A.wup_id,
    A.art_id,
    C.sm_id
);


DELETE FROM `_track_soll_1`
WHERE (
    mandant_id, wup_id, art_id, ksm_id) IN (
    SELECT (A.mandant_id, A.wup_id, A.art_id, C.ksm_id)
    FROM `_art_list_wup_zu_per_1` AS A
    INNER JOIN `_track_ksst_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    INNER JOIN `_track_soll_1` AS C
        ON
            A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id AND A.art_id = C.art_id AND
            SUBSTR(TRIM(C.ksm_id), 2, 1) >= SUBSTR(COALESCE(TRIM(B.listung_k_sst_mvke), 'K1'), 2, 1)
    GROUP BY A.mandant_id,
    A.wup_id,
    A.art_id,
    C.ksm_id
);


DELETE FROM `_track_soll_1`
WHERE (
    mandant_id, wup_id, art_id) IN (
    SELECT (mandant_id, wup_id, art_id)
    FROM `_sonstige_bst_1`
);


CREATE OR REPLACE TEMPORARY TABLE _track_ist_1 AS
SELECT
    mandant_id,
    wup_id,
    art_id,
    sm_id,
    ksm_id
FROM `_ist_listung_article_1`
WHERE markt_zaehlung_fg = 1;


DELETE FROM `_track_ist_1`
WHERE (
    mandant_id, wup_id, art_id) IN (
    SELECT (mandant_id, wup_id, art_id)
    FROM `_art_list_wup_kill_2_1`
);


DELETE FROM `_track_ist_1`
WHERE (
    mandant_id, wup_id, art_id, sm_id) IN (
    SELECT (A.mandant_id, A.wup_id, A.art_id, C.sm_id)
    FROM `_art_list_wup_zu_per_1` AS A
    INNER JOIN `_track_sst_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    INNER JOIN `_track_ist_1` AS C
        ON
            A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id AND A.art_id = C.art_id AND C.sm_id
            < ROUND(CAST(COALESCE(CAST(B.listung_sst_mvke AS BIGNUMERIC), 6) AS BIGNUMERIC), 0)
    GROUP BY A.mandant_id,
    A.wup_id,
    A.art_id,
    C.sm_id
);


DELETE FROM `_track_ist_1`
WHERE (
    mandant_id, wup_id, art_id, ksm_id) IN (
    SELECT (A.mandant_id, A.wup_id, A.art_id, C.ksm_id)
    FROM `_art_list_wup_zu_per_1` AS A
    INNER JOIN `_track_ksst_1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    INNER JOIN `_track_ist_1` AS C
        ON
            A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id AND A.art_id = C.art_id AND
            SUBSTR(TRIM(C.ksm_id), 2, 1) < SUBSTR(COALESCE(TRIM(B.listung_k_sst_mvke), 'K9'), 2, 1)
    GROUP BY A.mandant_id,
    A.wup_id,
    A.art_id,
    C.ksm_id
);


DELETE FROM `_track_ist_1`
WHERE (
    mandant_id, wup_id, art_id) IN (
    SELECT (mandant_id, wup_id, art_id)
    FROM `_sonstige_bst_1`
);


UPDATE dbp_msi_data.kl_listung_kmo_1 SET
    erweiterung_fg = 1
FROM `_track_soll_1` AS b
WHERE
    kl_listung_kmo.mandant_id = b.mandant_id AND kl_listung_kmo.wup_id = b.wup_id AND kl_listung_kmo.art_id = b.art_id
    AND kl_listung_kmo.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_1
        WHERE akt_wo = 1
    );


UPDATE dbp_msi_data.kl_listung_kmo_1 SET
    reduktion_fg = 1
FROM `_track_ist_1` AS b
WHERE
    kl_listung_kmo.mandant_id = b.mandant_id AND kl_listung_kmo.wup_id = b.wup_id AND kl_listung_kmo.art_id = b.art_id
    AND kl_listung_kmo.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_1
        WHERE akt_wo = 1
    );


DELETE FROM dbp_msi_data.kl_listung_kmo_1
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM (SELECT DISTINCT
        mandant_id,
        art_id
    FROM dbp_etl.kl_basis_listung_kmo_1
    WHERE list_kz <> 'A') AS t2
) AND listung_art IN ('Auslistung', 'Listung reduzieren'
) AND kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche_1
    WHERE akt_wo = 1
);


CREATE OR REPLACE TEMPORARY TABLE _red_step1_1 AS
SELECT
    mandant_id,
    kjwo_update,
    listung_art,
    art_id,
    MAX(sm_id_selected) AS sm_id_selected
FROM dbp_msi_data.kl_listung_kmo_1
WHERE
    ksm_id IS NULL
    AND listung_art = 'Listung reduzieren'
    AND kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_1
        WHERE akt_wo = 1
    )
    AND mandant_id = ${mandant_id}
GROUP BY
    mandant_id,
    kjwo_update,
    listung_art,
    art_id;


INSERT INTO dbp_msi_data.kl_listung_kmo_1 (
    kl_listung_kmo_id, mandant_id, listung_art, art_id, wup_id,
    sm_id_selected, ksm_id_selected, sm_id, ksm_id, umsatz_hr, absatz_hr, rohertrag_hr, erweiterung_fg, reduktion_fg,
    kjwo_update, list_kz
)
(
    SELECT
        CAST((ROW_NUMBER() OVER (
            ORDER BY
                A.mandant_id IS NULL, A.mandant_id, A.listung_art IS NULL, A.listung_art, A.art_id IS NULL, A.art_id, A.wup_id IS NULL, A.wup_id, 6 IS NULL, 6, A.ksm_id_selected IS NULL, A.ksm_id_selected, A.sm_id IS NULL, A.sm_id, A.ksm_id IS NULL, A.ksm_id, A.umsatz_hr
                IS NULL, A.umsatz_hr, A.absatz_hr IS NULL, A.absatz_hr, A.rohertrag_hr IS NULL, A.rohertrag_hr, A.erweiterung_fg IS NULL, A.erweiterung_fg, A.reduktion_fg IS NULL, A.reduktion_fg, A.kjwo_update IS NULL, A.kjwo_update, A.list_kz IS NULL, A.list_kz
        )) + COALESCE((SELECT
            MAX(kl_listung_kmo_id
            )
        FROM dbp_msi_data.kl_listung_kmo_1
        WHERE kl_listung_kmo_id <> 0), 0) AS NUMERIC) AS kl_listung_kmo_id,
        A.mandant_id,
        A.listung_art,
        A.art_id,
        A.wup_id,
        6 AS sm_id_selected,
        A.ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        A.umsatz_hr,
        A.absatz_hr,
        A.rohertrag_hr,
        A.erweiterung_fg,
        A.reduktion_fg,
        A.kjwo_update,
        A.list_kz
    FROM dbp_msi_data.kl_listung_kmo_1 AS A
    INNER JOIN
        `_red_step1_1`
            AS B
        ON
            A.mandant_id = B.mandant_id AND A.kjwo_update = B.kjwo_update AND A.art_id = B.art_id
            AND A.sm_id_selected = B.sm_id_selected AND A.listung_art = B.listung_art
);


INSERT INTO dbp_msi_data.kl_listung_kmo_1 (
    kl_listung_kmo_id, mandant_id, listung_art, art_id, wup_id,
    sm_id_selected, ksm_id_selected, sm_id, ksm_id, umsatz_hr, absatz_hr, rohertrag_hr, erweiterung_fg, reduktion_fg,
    kjwo_update, list_kz
)
(
    SELECT
        CAST((ROW_NUMBER() OVER (
            ORDER BY
                A.mandant_id IS NULL, A.mandant_id, A.listung_art IS NULL, A.listung_art, A.art_id IS NULL, A.art_id, A.wup_id IS NULL, A.wup_id, 7 IS NULL, 7, A.ksm_id_selected IS NULL, A.ksm_id_selected, A.sm_id IS NULL, A.sm_id, A.ksm_id IS NULL, A.ksm_id, A.umsatz_hr
                IS NULL, A.umsatz_hr, A.absatz_hr IS NULL, A.absatz_hr, A.rohertrag_hr IS NULL, A.rohertrag_hr, A.erweiterung_fg IS NULL, A.erweiterung_fg, A.reduktion_fg IS NULL, A.reduktion_fg, A.kjwo_update IS NULL, A.kjwo_update, A.list_kz IS NULL, A.list_kz
        )) + COALESCE((SELECT
            MAX(kl_listung_kmo_id
            )
        FROM dbp_msi_data.kl_listung_kmo_1
        WHERE kl_listung_kmo_id <> 0), 0) AS NUMERIC) AS kl_listung_kmo_id,
        A.mandant_id,
        A.listung_art,
        A.art_id,
        A.wup_id,
        7 AS sm_id_selected,
        A.ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        A.umsatz_hr,
        A.absatz_hr,
        A.rohertrag_hr,
        A.erweiterung_fg,
        A.reduktion_fg,
        A.kjwo_update,
        A.list_kz
    FROM dbp_msi_data.kl_listung_kmo_1 AS A
    INNER JOIN
        `_red_step1_1`
            AS B
        ON
            A.mandant_id = B.mandant_id AND A.kjwo_update = B.kjwo_update AND A.art_id = B.art_id
            AND A.sm_id_selected = B.sm_id_selected AND A.listung_art = B.listung_art
);


INSERT INTO dbp_msi_data.kl_listung_kmo_1 (
    kl_listung_kmo_id, mandant_id, listung_art, art_id, wup_id,
    sm_id_selected, ksm_id_selected, sm_id, ksm_id, umsatz_hr, absatz_hr, rohertrag_hr, erweiterung_fg, reduktion_fg,
    kjwo_update, list_kz
)
(
    SELECT
        CAST((ROW_NUMBER() OVER (
            ORDER BY
                A.mandant_id IS NULL, A.mandant_id, A.listung_art IS NULL, A.listung_art, A.art_id IS NULL, A.art_id, A.wup_id IS NULL, A.wup_id, 8 IS NULL, 8, A.ksm_id_selected IS NULL, A.ksm_id_selected, A.sm_id IS NULL, A.sm_id, A.ksm_id IS NULL, A.ksm_id, A.umsatz_hr
                IS NULL, A.umsatz_hr, A.absatz_hr IS NULL, A.absatz_hr, A.rohertrag_hr IS NULL, A.rohertrag_hr, A.erweiterung_fg IS NULL, A.erweiterung_fg, A.reduktion_fg IS NULL, A.reduktion_fg, A.kjwo_update IS NULL, A.kjwo_update, A.list_kz IS NULL, A.list_kz
        )) + COALESCE((SELECT
            MAX(kl_listung_kmo_id
            )
        FROM dbp_msi_data.kl_listung_kmo_1
        WHERE kl_listung_kmo_id <> 0), 0) AS NUMERIC) AS kl_listung_kmo_id,
        A.mandant_id,
        A.listung_art,
        A.art_id,
        A.wup_id,
        8 AS sm_id_selected,
        A.ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        A.umsatz_hr,
        A.absatz_hr,
        A.rohertrag_hr,
        A.erweiterung_fg,
        A.reduktion_fg,
        A.kjwo_update,
        A.list_kz
    FROM dbp_msi_data.kl_listung_kmo_1 AS A
    INNER JOIN
        `_red_step1_1`
            AS B
        ON
            A.mandant_id = B.mandant_id AND A.kjwo_update = B.kjwo_update AND A.art_id = B.art_id
            AND A.sm_id_selected = B.sm_id_selected AND A.listung_art = B.listung_art
);


INSERT INTO dbp_msi_data.kl_listung_kmo_1 (
    kl_listung_kmo_id, mandant_id, listung_art, art_id, wup_id,
    sm_id_selected, ksm_id_selected, sm_id, ksm_id, umsatz_hr, absatz_hr, rohertrag_hr, erweiterung_fg, reduktion_fg,
    kjwo_update, list_kz
)
(
    SELECT
        CAST((ROW_NUMBER() OVER (
            ORDER BY
                A.mandant_id IS NULL, A.mandant_id, A.listung_art IS NULL, A.listung_art, A.art_id IS NULL, A.art_id, A.wup_id IS NULL, A.wup_id, 9 IS NULL, 9, A.ksm_id_selected IS NULL, A.ksm_id_selected, A.sm_id IS NULL, A.sm_id, A.ksm_id IS NULL, A.ksm_id, A.umsatz_hr
                IS NULL, A.umsatz_hr, A.absatz_hr IS NULL, A.absatz_hr, A.rohertrag_hr IS NULL, A.rohertrag_hr, A.erweiterung_fg IS NULL, A.erweiterung_fg, A.reduktion_fg IS NULL, A.reduktion_fg, A.kjwo_update IS NULL, A.kjwo_update, A.list_kz IS NULL, A.list_kz
        )) + COALESCE((SELECT
            MAX(kl_listung_kmo_id
            )
        FROM dbp_msi_data.kl_listung_kmo_1
        WHERE kl_listung_kmo_id <> 0), 0) AS NUMERIC) AS kl_listung_kmo_id,
        A.mandant_id,
        A.listung_art,
        A.art_id,
        A.wup_id,
        9 AS sm_id_selected,
        A.ksm_id_selected,
        A.sm_id,
        TRIM(A.ksm_id) AS ksm_id,
        A.umsatz_hr,
        A.absatz_hr,
        A.rohertrag_hr,
        A.erweiterung_fg,
        A.reduktion_fg,
        A.kjwo_update,
        A.list_kz
    FROM dbp_msi_data.kl_listung_kmo_1 AS A
    INNER JOIN
        `_red_step1_1`
            AS B
        ON
            A.mandant_id = B.mandant_id AND A.kjwo_update = B.kjwo_update AND A.art_id = B.art_id
            AND A.sm_id_selected = B.sm_id_selected AND A.listung_art = B.listung_art
);
