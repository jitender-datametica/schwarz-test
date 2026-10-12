CREATE OR REPLACE TEMPORARY TABLE _sort_ist2 AS
SELECT
    a.wup_id,
    a.kreistyp_gruppe_id,
    a.mandant_id,
    a.wg_id,
    a.art_id,
    a.kassenumsatz,
    a.anz_tage,
    a.preis,
    a.list_kz,
    b.sm_id
FROM dbp_etl.sort_ist_2 AS a
INNER JOIN (
    SELECT
        a0.mandant_id,
        a0.wup_id,
        a0.wg_id,
        CASE WHEN a0.sm_id = 6 THEN 5 ELSE a0.sm_id END AS sm_id
    FROM dbp_data.sm_wup_wg_zu_per_2 AS a0
    INNER JOIN dbp_data.wup_2 AS b
        ON a0.mandant_id = b.mandant_id AND a0.wup_id = b.wup_id
    WHERE
        a0.mandant_id = 1
        AND a0.spr_id = 22
        AND a0.arthiertyp_id = 2
        AND a0.sm_id BETWEEN 1 AND 6
        AND b.nb_id = 0
        AND CURRENT_DATE("Europe/Berlin") BETWEEN a0.dat_von AND a0.dat_bis
        AND CURRENT_DATE("Europe/Berlin") BETWEEN b.dat_von AND b.dat_bis
        AND (a0.mandant_id, a0.wg_id) IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 11 AND mandant_id = 1
        )
    GROUP BY
        a0.mandant_id,
        a0.wup_id,
        a0.wg_id,
        sm_id
) AS b
    ON a.wg_id = b.wg_id AND a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id;

CREATE OR REPLACE TEMPORARY TABLE _perf1 AS
SELECT
    a.mandant_id,
    a.wup_id,
    a.wg_id,
    CASE WHEN a.sm_id = 6 THEN 5 ELSE a.sm_id END AS sm_id
FROM dbp_data.sm_wup_wg_zu_per_2 AS a
INNER JOIN dbp_data.wup_2 AS b
    ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id
WHERE
    a.mandant_id = 1
    AND a.spr_id = 22
    AND a.arthiertyp_id = 2
    AND a.sm_id BETWEEN 1 AND 6
    AND CURRENT_DATE("Europe/Berlin") BETWEEN a.dat_von AND a.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN b.dat_von AND b.dat_bis
    AND b.nb_id = 0
    AND (a.mandant_id, a.wg_id) IN (
        SELECT (mandant_id, wg_id)
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 11 AND mandant_id = 1
    )
GROUP BY
    a.mandant_id,
    a.wup_id,
    a.wg_id,
    sm_id;

CREATE OR REPLACE TEMPORARY TABLE _ist_listung AS
SELECT
    a.mandant_id,
    a.art_id,
    a.wup_id,
    c.kreistyp_gruppe_id,
    d.sm_id
FROM dbp_data.art_list_wup_zu_per_2 AS a
INNER JOIN dbp_data.art_wg_zu_per_2 AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND b.dat_bis = CAST('9999-12-31' AS DATE)
        AND b.arthiertyp_id = 2
INNER JOIN dbp_data.wup_2 AS c
    ON a.wup_id = c.wup_id AND a.mandant_id = c.mandant_id
INNER JOIN `_perf1` AS d
    ON b.wg_id = d.wg_id AND a.mandant_id = d.mandant_id AND a.wup_id = d.wup_id
WHERE
    TRIM(a.list_quelle_id) <> '2'
    AND a.nb_id = 0
    AND a.mandant_id = 1
    AND a.list_komponente_fg = 0
    AND CURRENT_DATE("Europe/Berlin") BETWEEN c.dat_von AND c.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN a.dat_von AND a.dat_bis
    AND (b.mandant_id, b.wg_id) IN (
        SELECT (mandant_id, wg_id)
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 11 AND mandant_id = 1
    )
    AND a.art_id > 0
GROUP BY
    a.mandant_id,
    a.art_id,
    a.wup_id,
    c.kreistyp_gruppe_id,
    d.sm_id;

CREATE OR REPLACE TEMPORARY TABLE _ist_listung_null AS
SELECT
    a.mandant_id,
    a.art_id,
    a.wup_id,
    c.kreistyp_gruppe_id,
    d.sm_id
FROM dbp_data.art_wup_zu_per_2 AS a
INNER JOIN dbp_data.art_wg_zu_per_2 AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND b.dat_bis = CAST('9999-12-31' AS DATE)
        AND b.arthiertyp_id = 2
INNER JOIN dbp_data.wup_2 AS c
    ON a.wup_id = c.wup_id AND a.mandant_id = c.mandant_id
INNER JOIN (
    SELECT
        a0.mandant_id,
        a0.wup_id,
        a0.wg_id,
        CASE WHEN a0.sm_id = 6 THEN 5 ELSE a0.sm_id END AS sm_id
    FROM dbp_data.sm_wup_wg_zu_per_2 AS a0
    INNER JOIN dbp_data.wup_2 AS b0
        ON a0.mandant_id = b0.mandant_id AND a0.wup_id = b0.wup_id
    WHERE
        a0.mandant_id = 1
        AND a0.spr_id = 22
        AND a0.arthiertyp_id = 2
        AND a0.sm_id BETWEEN 1 AND 6
        AND CURRENT_DATE("Europe/Berlin") BETWEEN a0.dat_von AND a0.dat_bis
        AND CURRENT_DATE("Europe/Berlin") BETWEEN b0.dat_von AND b0.dat_bis
        AND b0.nb_id = 0
        AND (a0.mandant_id, a0.wg_id) IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 11 AND mandant_id = 1
        )
    GROUP BY
        a0.mandant_id,
        a0.wup_id,
        a0.wg_id,
        sm_id
) AS d
    ON b.wg_id = d.wg_id AND a.mandant_id = d.mandant_id AND a.wup_id = d.wup_id
WHERE
    a.mandant_id = 1
    AND a.listung_id = 0
    AND CURRENT_DATE("Europe/Berlin") BETWEEN c.dat_von AND c.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN a.dat_von AND a.dat_bis
    AND (b.mandant_id, b.wg_id) IN (
        SELECT (mandant_id, wg_id)
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 11 AND mandant_id = 1
    )
    AND a.art_id > 0
GROUP BY
    a.mandant_id,
    a.art_id,
    a.wup_id,
    c.kreistyp_gruppe_id,
    d.sm_id;

CREATE OR REPLACE TEMPORARY TABLE _ist_listung_article AS
SELECT
    a.mandant_id,
    a.art_id,
    a.wup_id,
    b.kreistyp_gruppe_id,
    b.sm_id,
    b.kassenumsatz AS kassenumsatz_artikel,
    b.anz_tage AS anz_tage_artikel,
    b.preis AS preis_artikel,
    b.list_kz,
    1 AS markt_zaehlung_fg
FROM `_ist_listung` AS a
INNER JOIN `_sort_ist2` AS b
    ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.art_id = b.art_id;

INSERT INTO `_ist_listung_article`
(
    SELECT
        a.mandant_id,
        a.art_id,
        a.wup_id,
        b.kreistyp_gruppe_id,
        b.sm_id,
        b.kassenumsatz AS kassenumsatz_artikel,
        b.anz_tage AS anz_tage_artikel,
        b.preis AS preis_artikel,
        b.list_kz,
        0 AS markt_zaehlung_fg
    FROM `_ist_listung_null` AS a
    INNER JOIN `_sort_ist2` AS b
        ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.art_id = b.art_id
    WHERE
        NOT (a.art_id, a.wup_id) IN (
            SELECT (art_id, wup_id)
            FROM `_ist_listung_article`
        )
);

CREATE OR REPLACE TEMPORARY TABLE _art_list_wup_zu_per AS
SELECT
    a.art_id,
    a.mandant_id,
    a.wup_id
FROM dbp_data.art_list_wup_zu_per_2 AS a
INNER JOIN dbp_data.art_wg_zu_per_2 AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND b.arthiertyp_id = 2
        AND b.dat_bis = CAST('9999-12-31' AS DATE)
INNER JOIN dbp_data.wup_2 AS c
    ON a.mandant_id = c.mandant_id AND a.wup_id = c.wup_id
WHERE
    a.mandant_id = 1
    AND b.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 11
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN a.dat_von AND a.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN c.dat_von AND c.dat_bis
    AND a.nb_id = 0
    AND c.nb_id = 0
    AND c.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin")
    AND NOT TRIM(a.list_quelle_id) IN ('2')
GROUP BY
    a.art_id,
    a.mandant_id,
    a.wup_id;

CREATE OR REPLACE TEMPORARY TABLE _art_list_wup_kill_1 AS
SELECT
    a.art_id,
    a.mandant_id,
    a.wup_id
FROM dbp_data.art_list_wup_zu_per_2 AS a
INNER JOIN dbp_data.art_wg_zu_per_2 AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND b.arthiertyp_id = 2
        AND b.dat_bis = CAST('9999-12-31' AS DATE)
INNER JOIN dbp_data.wup_2 AS c
    ON a.mandant_id = c.mandant_id AND a.wup_id = c.wup_id
WHERE
    a.mandant_id = 1
    AND b.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 11
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN a.dat_von AND a.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN c.dat_von AND c.dat_bis
    AND a.list_komponente_fg = 1
    AND a.nb_id = 0
    AND c.nb_id = 0
    AND c.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin")
    AND NOT TRIM(a.list_quelle_id) IN ('2')
    AND NOT (a.wup_id, a.art_id, a.mandant_id) IN (
        SELECT (wup_id, art_id, mandant_id)
        FROM `_art_list_wup_zu_per`
    );

CREATE OR REPLACE TEMPORARY TABLE _art_list_wup_kill_2 AS
SELECT
    a.art_id,
    a.mandant_id,
    a.wup_id
FROM dbp_data.art_list_wup_zu_per_2 AS a
INNER JOIN dbp_data.art_wg_zu_per_2 AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND b.arthiertyp_id = 2
        AND b.dat_bis = CAST('9999-12-31' AS DATE)
INNER JOIN dbp_data.wup_2 AS c
    ON a.mandant_id = c.mandant_id AND a.wup_id = c.wup_id
WHERE
    a.mandant_id = 1
    AND b.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 11
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN a.dat_von AND a.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN c.dat_von AND c.dat_bis
    AND TRIM(a.list_quelle_id) IN ('2')
    AND a.nb_id = 0
    AND c.nb_id = 0
    AND c.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin")
    AND NOT (a.wup_id, a.art_id, a.mandant_id) IN (
        SELECT (wup_id, art_id, mandant_id)
        FROM `_art_list_wup_zu_per`
    )
GROUP BY
    a.art_id,
    a.mandant_id,
    a.wup_id;

CREATE OR REPLACE TEMPORARY TABLE _einzel_markt AS
SELECT
    a.mandant_id,
    a.art_id,
    a.wup_id
FROM dbp_data.art_list_wup_zu_per_2 AS a
INNER JOIN dbp_data.art_wg_zu_per_2 AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND b.arthiertyp_id = 2
        AND b.dat_bis = CAST('9999-12-31' AS DATE)
INNER JOIN dbp_data.wup_2 AS c
    ON a.mandant_id = c.mandant_id AND a.wup_id = c.wup_id
WHERE
    a.mandant_id = 1
    AND b.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 11
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN a.dat_von AND a.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN c.dat_von AND c.dat_bis
    AND TRIM(a.list_quelle_id) IN ('C')
    AND a.list_komponente_fg = 0
    AND a.nb_id = 0
    AND c.nb_id = 0
    AND c.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin")
GROUP BY
    a.mandant_id,
    a.art_id,
    a.wup_id;

CREATE OR REPLACE TEMPORARY TABLE _sonstige_bst AS
SELECT
    a.mandant_id,
    a.art_id,
    a.wup_id
FROM dbp_data.art_list_wup_zu_per_2 AS a
INNER JOIN dbp_data.art_wg_zu_per_2 AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND b.arthiertyp_id = 2
        AND b.dat_bis = CAST('9999-12-31' AS DATE)
INNER JOIN dbp_data.wup_2 AS c
    ON a.mandant_id = c.mandant_id AND a.wup_id = c.wup_id
WHERE
    a.mandant_id = 1
    AND b.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 11
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN a.dat_von AND a.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN c.dat_von AND c.dat_bis
    AND TRIM(a.list_quelle_id) IN ('3')
    AND a.list_komponente_fg = 0
    AND a.nb_id = 0
    AND a.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_wsop_2
        WHERE
            CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis AND mandant_id = 1
    )
    AND c.nb_id = 0
    AND c.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin")
    AND NOT a.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_region_zu_2
    )
GROUP BY
    a.mandant_id,
    a.art_id,
    a.wup_id;

CREATE OR REPLACE TEMPORARY TABLE _soll_listung AS
SELECT
    a.mandant_id,
    a.art_id,
    c.wup_id,
    c.sm_id,
    c.kreistyp_gruppe_id
FROM dbp_data.art_2 AS a
INNER JOIN dbp_data.art_wg_zu_per_2 AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND b.arthiertyp_id = 2
        AND b.dat_bis = CAST('9999-12-31' AS DATE)
INNER JOIN (
    SELECT
        a0.mandant_id,
        a0.wup_id,
        a0.wg_id,
        CASE WHEN a0.sm_id = 6 THEN 5 ELSE a0.sm_id END AS sm_id,
        b0.kreistyp_gruppe_id
    FROM dbp_data.sm_wup_wg_zu_per_2 AS a0
    INNER JOIN dbp_data.wup_2 AS b0
        ON a0.mandant_id = b0.mandant_id AND a0.wup_id = b0.wup_id
    WHERE
        a0.mandant_id = 1
        AND a0.spr_id = 22
        AND a0.arthiertyp_id = 2
        AND CURRENT_DATE("Europe/Berlin") BETWEEN a0.dat_von AND a0.dat_bis
        AND CURRENT_DATE("Europe/Berlin") BETWEEN b0.dat_von AND b0.dat_bis
        AND a0.sm_id BETWEEN 1 AND 6
        AND b0.nb_id = 0
        AND (a0.mandant_id, a0.wg_id) IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 11 AND mandant_id = 1
        )
    GROUP BY
        a0.mandant_id,
        a0.wup_id,
        a0.wg_id,
        sm_id,
        b0.kreistyp_gruppe_id
) AS c
    ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
WHERE
    a.mandant_id = 1 AND a.dat_bis = CAST('9999-12-31' AS DATE)
GROUP BY
    a.mandant_id,
    a.art_id,
    c.wup_id,
    c.sm_id,
    c.kreistyp_gruppe_id;

CREATE OR REPLACE TEMPORARY TABLE _markt_umsatz_gesamt AS
(
    SELECT
        a11.wup_id,
        a11.mandant_id,
        SUM(a11.umsatz_netto + a11.umsatz_mwst_betrag) AS kassenumsatz,
        COUNT(DISTINCT a11.dat) AS anz_tage
    FROM dbp_msi_view2.mv_artbew_wg_tag_sum_2 AS a11
    WHERE
        a11.dat BETWEEN CURRENT_DATE("Europe/Berlin") - 366 AND CURRENT_DATE("Europe/Berlin") - 1 AND a11.mandant_id = 1
    GROUP BY
        1,
        2
);

CREATE OR REPLACE TEMPORARY TABLE _ist_listung_article_plus_gesamt AS
(
    SELECT
        a.*,
        b.kassenumsatz AS kassenumsatz_gesamt,
        b.anz_tage AS anz_tage_gesamt
    FROM _ist_listung_article AS a
    LEFT JOIN _markt_umsatz_gesamt AS b
        ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id
);

CREATE OR REPLACE TEMPORARY TABLE _sort_ist4 AS
(
    SELECT
        a.mandant_id,
        a.art_id,
        a.list_kz,
        Count(DISTINCT a.wup_id) AS anz_markt,
        IfNull(
            Sum(
                CASE
                    WHEN a.kassenumsatz_gesamt <> 0 AND Coalesce(b.markt_zaehlung_fg, 0) = 1
                        THEN a.kassenumsatz_gesamt
                    ELSE 0
                END
            ) / NullIf(
                Sum(
                    CASE
                        WHEN a.kassenumsatz_gesamt <> 0 AND Coalesce(b.markt_zaehlung_fg, 0) = 1
                            THEN a.anz_tage_gesamt
                        ELSE 0
                    END
                ),
                0
            ),
            0
        ) AS avg_umsatz_gesamt,
        IfNull(
            Sum(
                CASE
                    WHEN a.kassenumsatz_artikel <> 0 AND Coalesce(b.markt_zaehlung_fg, 0) = 1
                        THEN a.kassenumsatz_artikel
                    ELSE 0
                END
            ) / NullIf(
                Sum(
                    CASE
                        WHEN a.kassenumsatz_artikel <> 0 AND Coalesce(b.markt_zaehlung_fg, 0) = 1
                            THEN a.anz_tage_artikel
                        ELSE 0
                    END
                ),
                0
            ),
            0
        ) AS avg_umsatz_artikel,
        Avg(preis_artikel) AS preis
    FROM _ist_listung_article_plus_gesamt AS a
    LEFT JOIN (
        SELECT
            mandant_id,
            art_id,
            1 AS markt_zaehlung_fg
        FROM dbp_data.art_list_wup_zu_per_2
        WHERE
            dat_bis >= CURRENT_DATE("Europe/Berlin") - 366
            AND mandant_id = 1
            AND NOT TRIM(list_quelle_id) IN ('2')
        GROUP BY
            1,
            2
    ) AS b
        ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
    GROUP BY
        1,
        2,
        3
);

CREATE OR REPLACE TEMPORARY TABLE _differenz_soll AS
SELECT *
FROM `_soll_listung`
WHERE
    NOT (mandant_id, art_id, wup_id, sm_id) IN (
        SELECT (mandant_id, art_id, wup_id, sm_id)
        FROM `_ist_listung`
    );

CREATE OR REPLACE TEMPORARY TABLE _differenz_soll_1 AS
(
    SELECT
        a.*,
        COALESCE(b.kassenumsatz, 0) AS kassenumsatz_gesamt,
        COALESCE(b.anz_tage, 0) AS anz_tage_gesamt,
        IFNULL(COALESCE(b.kassenumsatz, 0) / NULLIF(b.anz_tage, 0), 0) AS avg_umsatz_gesamt
    FROM _differenz_soll AS a
    LEFT JOIN _markt_umsatz_gesamt AS b
        ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id
);

CREATE OR REPLACE TEMPORARY TABLE _list_extended AS
(
    SELECT
        a.mandant_id,
        a.art_id,
        1 AS sm_id_selected,
        a.sm_id,
        b.list_kz,
        TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        a.wup_id,
        a.avg_umsatz_gesamt,
        b.avg_umsatz_artikel,
        b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        IFNULL(
            (
                b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
            ),
            0
        ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) AS umsatz_kpi,
        IFNULL(
            IFNULL(
                (
                    b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
                ),
                0
            ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) / NULLIF(b.preis, 0),
            0
        ) AS absatz_kpi,
        IFNULL(
            IFNULL(
                (
                    b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
                ),
                0
            ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) / NULLIF(b.preis, 0),
            0
        ) * COALESCE(c.stueck_re_mep, 0) AS rohertrag_kpi
    FROM _differenz_soll_1 AS a
    JOIN _sort_ist4 AS b
        ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
    LEFT JOIN dbp_etl.bf_sort_sal_export_2 AS c
        ON FLOOR(a.art_id / 100) = CAST(c.art_nr AS INT64)
    WHERE
        a.sm_id >= 1
);

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    b.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    b.avg_umsatz_artikel,
    b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
    IFNULL(
        (
            b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
        ),
        0
    ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) AS umsatz_kpi,
    IFNULL(
        IFNULL(
            (
                b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
            ),
            0
        ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) / NULLIF(b.preis, 0),
        0
    ) AS absatz_kpi,
    IFNULL(
        IFNULL(
            (
                b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
            ),
            0
        ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) / NULLIF(b.preis, 0),
        0
    ) * COALESCE(c.stueck_re_mep, 0) AS rohertrag_kpi
FROM _differenz_soll_1 AS a
JOIN _sort_ist4 AS b
    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
LEFT JOIN dbp_etl.bf_sort_sal_export_2 AS c
    ON FLOOR(a.art_id / 100) = CAST(c.art_nr AS INT64)
WHERE
    a.sm_id >= 2;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    b.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    b.avg_umsatz_artikel,
    b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
    IFNULL(
        (
            b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
        ),
        0
    ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) AS umsatz_kpi,
    IFNULL(
        IFNULL(
            (
                b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
            ),
            0
        ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) / NULLIF(b.preis, 0),
        0
    ) AS absatz_kpi,
    IFNULL(
        IFNULL(
            (
                b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
            ),
            0
        ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) / NULLIF(b.preis, 0),
        0
    ) * COALESCE(c.stueck_re_mep, 0) AS rohertrag_kpi
FROM _differenz_soll_1 AS a
JOIN _sort_ist4 AS b
    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
LEFT JOIN dbp_etl.bf_sort_sal_export_2 AS c
    ON FLOOR(a.art_id / 100) = CAST(c.art_nr AS INT64)
WHERE
    a.sm_id >= 3;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    b.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    b.avg_umsatz_artikel,
    b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
    IFNULL(
        (
            b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
        ),
        0
    ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) AS umsatz_kpi,
    IFNULL(
        IFNULL(
            (
                b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
            ),
            0
        ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) / NULLIF(b.preis, 0),
        0
    ) AS absatz_kpi,
    IFNULL(
        IFNULL(
            (
                b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
            ),
            0
        ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) / NULLIF(b.preis, 0),
        0
    ) * COALESCE(c.stueck_re_mep, 0) AS rohertrag_kpi
FROM _differenz_soll_1 AS a
JOIN _sort_ist4 AS b
    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
LEFT JOIN dbp_etl.bf_sort_sal_export_2 AS c
    ON FLOOR(a.art_id / 100) = CAST(c.art_nr AS INT64)
WHERE
    a.sm_id >= 4;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    b.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    b.avg_umsatz_artikel,
    b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
    IFNULL(
        (
            b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
        ),
        0
    ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) AS umsatz_kpi,
    IFNULL(
        IFNULL(
            (
                b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
            ),
            0
        ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) / NULLIF(b.preis, 0),
        0
    ) AS absatz_kpi,
    IFNULL(
        IFNULL(
            (
                b.avg_umsatz_artikel * a.avg_umsatz_gesamt / NULLIF(b.avg_umsatz_gesamt, 0)
            ),
            0
        ) * 300 * COALESCE(c.schnelldreherquote / 100, 0) / NULLIF(b.preis, 0),
        0
    ) * COALESCE(c.stueck_re_mep, 0) AS rohertrag_kpi
FROM _differenz_soll_1 AS a
JOIN _sort_ist4 AS b
    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
LEFT JOIN dbp_etl.bf_sort_sal_export_2 AS c
    ON FLOOR(a.art_id / 100) = CAST(c.art_nr AS INT64)
WHERE
    a.sm_id >= 5;

CREATE OR REPLACE TEMPORARY TABLE _list_extended_region_only AS
(
    SELECT
        a.mandant_id,
        a.art_id,
        0 AS sm_id_selected,
        a.sm_id,
        a.list_kz,
        TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
        CASE WHEN TRIM(TRIM(a.kreistyp_gruppe_id)) = 'N' THEN 'x' ELSE '-' END AS nord,
        CASE WHEN TRIM(TRIM(a.kreistyp_gruppe_id)) = 'O' THEN 'x' ELSE '-' END AS ost_basis,
        CASE WHEN TRIM(TRIM(a.kreistyp_gruppe_id)) = 'Q' THEN 'x' ELSE '-' END AS ost_gross,
        CASE WHEN TRIM(TRIM(a.kreistyp_gruppe_id)) = 'G' THEN 'x' ELSE '-' END AS sued_ost,
        CASE WHEN TRIM(TRIM(a.kreistyp_gruppe_id)) = 'M' THEN 'x' ELSE '-' END AS sued_west,
        CASE WHEN TRIM(TRIM(a.kreistyp_gruppe_id)) = 'W' THEN 'x' ELSE '-' END AS west,
        a.wup_id,
        a.avg_umsatz_gesamt,
        a.avg_umsatz_artikel,
        a.avg_umsatz_gesamt_list,
        a.umsatz_kpi,
        a.absatz_kpi,
        a.rohertrag_kpi
    FROM _list_extended AS a
    JOIN (
        SELECT
            mandant_id,
            art_id,
            wup_id,
            kreistyp_gruppe_id
        FROM _list_extended
        GROUP BY
            1,
            2,
            3,
            4
    ) AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND a.wup_id = x.wup_id
            AND TRIM(TRIM(a.kreistyp_gruppe_id)) = TRIM(x.kreistyp_gruppe_id)
    GROUP BY
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19
);

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    'x' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('N') AND a.sm_id < 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    'x' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('N') AND a.sm_id < 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    'x' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('N') AND a.sm_id < 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    'x' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('N') AND a.sm_id < 2
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    'x' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('O') AND a.sm_id < 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    'x' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('O') AND a.sm_id < 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    'x' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('O') AND a.sm_id < 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    'x' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('O') AND a.sm_id < 2
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    'x' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('Q') AND a.sm_id < 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    'x' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('Q') AND a.sm_id < 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    'x' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('Q') AND a.sm_id < 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    'x' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('Q') AND a.sm_id < 2
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    'x' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('G') AND a.sm_id < 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    'x' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('G') AND a.sm_id < 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    'x' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('G') AND a.sm_id < 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    'x' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('G') AND a.sm_id < 2
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    'x' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('M') AND a.sm_id < 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    'x' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('M') AND a.sm_id < 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    'x' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('M') AND a.sm_id < 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    'x' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('M') AND a.sm_id < 2
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    'x' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('W') AND a.sm_id < 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    'x' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('W') AND a.sm_id < 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    'x' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('W') AND a.sm_id < 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    'x' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_extended AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('W') AND a.sm_id < 2
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_extended
SELECT *
FROM _list_extended_region_only;

CREATE OR REPLACE TEMPORARY TABLE _sort_ist3_reduction AS
(
    SELECT
        a.mandant_id,
        a.wup_id,
        a.art_id,
        a.sm_id,
        TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
        a.kassenumsatz_artikel,
        a.preis_artikel,
        COALESCE(b.kassenumsatz, 0) AS kassenumsatz_gesamt,
        COALESCE(b.anz_tage, 0) AS anz_tage_gesamt,
        a.anz_tage_artikel,
        IFNULL(b.kassenumsatz / NULLIF(b.anz_tage, 0), 0) AS avg_umsatz_gesamt,
        IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_gesamt, 0), 0) AS avg_umsatz_artikel,
        CAST(0 AS INT64) AS anz_tage_listung_artikel
    FROM _ist_listung_article_plus_gesamt AS a
    LEFT JOIN _markt_umsatz_gesamt AS b
        ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id
    WHERE
        sm_id <> -1
);

CREATE OR REPLACE TEMPORARY TABLE _test AS
(
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM _sort_ist3_reduction
    GROUP BY
        1,
        2,
        3
);

CREATE OR REPLACE TEMPORARY TABLE _help_me AS
(
    SELECT
        a.mandant_id,
        a.wup_id,
        a.art_id,
        MIN(a.dat_von) AS min_dat,
        MAX(a.dat_bis) AS max_dat
    FROM dbp_data.art_list_wup_zu_per_2 AS a
    JOIN _test AS b
        ON a.wup_id = b.wup_id AND a.art_id = b.art_id AND a.mandant_id = b.mandant_id
    WHERE
        TRIM(a.list_quelle_id) <> '-2'
        AND a.nb_id = 0
        AND a.list_komponente_fg = 0
        AND a.mandant_id = 1
        AND a.dat_bis >= CURRENT_DATE("Europe/Berlin") - 366
    GROUP BY
        1,
        2,
        3
);

CREATE OR REPLACE TEMPORARY TABLE _tage AS
(
    SELECT
        b.dat,
        a.mandant_id,
        a.wup_id,
        a.art_id
    FROM _help_me AS a
    JOIN dbp_data.tag_2 AS b
        ON b.dat BETWEEN a.min_dat AND a.max_dat
    WHERE
        b.dat BETWEEN CURRENT_DATE("Europe/Berlin") - 366 AND CURRENT_DATE("Europe/Berlin") - 1
);

UPDATE _sort_ist3_reduction SET anz_tage_listung_artikel = CASE WHEN b.anz_tage > 300 THEN 300 ELSE b.anz_tage END
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        COUNT(DISTINCT dat) AS anz_tage
    FROM _tage
    GROUP BY
        1,
        2,
        3
) AS b
WHERE
    _sort_ist3_reduction.mandant_id = b.mandant_id
    AND _sort_ist3_reduction.art_id = b.art_id
    AND _sort_ist3_reduction.wup_id = b.wup_id;

CREATE OR REPLACE TEMPORARY TABLE _list_reduced AS
(
    SELECT
        a.mandant_id,
        a.art_id,
        2 AS sm_id_selected,
        a.sm_id,
        b.list_kz,
        TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        a.wup_id,
        a.avg_umsatz_gesamt,
        b.avg_umsatz_artikel,
        b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        (
            -1
        ) * (
            IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
        ) * (
            IFNULL(
                CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
                0
            )
        ) AS umsatz_kpi,
        IFNULL(
            (
                -1
            ) * (
                IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
            ) * (
                IFNULL(
                    CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
                    0
                )
            ) / NULLIF(a.preis_artikel, 0),
            0
        ) AS absatz_kpi,
        IFNULL(
            (
                -1
            ) * (
                IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
            ) * (
                IFNULL(
                    CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
                    0
                )
            ) / NULLIF(a.preis_artikel, 0),
            0
        ) * COALESCE(c.stueck_re_mep, 0) AS rohertrag_kpi
    FROM _sort_ist3_reduction AS a
    JOIN _sort_ist4 AS b
        ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
    LEFT JOIN dbp_etl.bf_sort_sal_export_2 AS c
        ON FLOOR(a.art_id / 100) = CAST(c.art_nr AS INT64)
    WHERE
        a.sm_id < 2
    GROUP BY
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19
);

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    b.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    b.avg_umsatz_artikel,
    b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
    (
        -1
    ) * (
        IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
    ) * (
        IFNULL(
            CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
            0
        )
    ) AS umsatz_kpi,
    IFNULL(
        (
            -1
        ) * (
            IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
        ) * (
            IFNULL(
                CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
                0
            )
        ) / NULLIF(a.preis_artikel, 0),
        0
    ) AS absatz_kpi,
    IFNULL(
        (
            -1
        ) * (
            IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
        ) * (
            IFNULL(
                CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
                0
            )
        ) / NULLIF(a.preis_artikel, 0),
        0
    ) * COALESCE(c.stueck_re_mep, 0) AS rohertrag_kpi
FROM _sort_ist3_reduction AS a
JOIN _sort_ist4 AS b
    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
LEFT JOIN dbp_etl.bf_sort_sal_export_2 AS c
    ON FLOOR(a.art_id / 100) = CAST(c.art_nr AS INT64)
WHERE
    a.sm_id < 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    b.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    b.avg_umsatz_artikel,
    b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
    (
        -1
    ) * (
        IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
    ) * (
        IFNULL(
            CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
            0
        )
    ) AS umsatz_kpi,
    IFNULL(
        (
            -1
        ) * (
            IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
        ) * (
            IFNULL(
                CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
                0
            )
        ) / NULLIF(a.preis_artikel, 0),
        0
    ) AS absatz_kpi,
    IFNULL(
        (
            -1
        ) * (
            IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
        ) * (
            IFNULL(
                CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
                0
            )
        ) / NULLIF(a.preis_artikel, 0),
        0
    ) * COALESCE(c.stueck_re_mep, 0) AS rohertrag_kpi
FROM _sort_ist3_reduction AS a
JOIN _sort_ist4 AS b
    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
LEFT JOIN dbp_etl.bf_sort_sal_export_2 AS c
    ON FLOOR(a.art_id / 100) = CAST(c.art_nr AS INT64)
WHERE
    a.sm_id < 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    b.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    b.avg_umsatz_artikel,
    b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
    (
        -1
    ) * (
        IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
    ) * (
        IFNULL(
            CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
            0
        )
    ) AS umsatz_kpi,
    IFNULL(
        (
            -1
        ) * (
            IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
        ) * (
            IFNULL(
                CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
                0
            )
        ) / NULLIF(a.preis_artikel, 0),
        0
    ) AS absatz_kpi,
    IFNULL(
        (
            -1
        ) * (
            IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
        ) * (
            IFNULL(
                CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
                0
            )
        ) / NULLIF(a.preis_artikel, 0),
        0
    ) * COALESCE(c.stueck_re_mep, 0) AS rohertrag_kpi
FROM _sort_ist3_reduction AS a
JOIN _sort_ist4 AS b
    ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
LEFT JOIN dbp_etl.bf_sort_sal_export_2 AS c
    ON FLOOR(a.art_id / 100) = CAST(c.art_nr AS INT64)
WHERE
    a.sm_id <= 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

CREATE OR REPLACE TEMPORARY TABLE _list_reduced_region_only AS
(
    SELECT
        a.mandant_id,
        a.art_id,
        0 AS sm_id_selected,
        a.sm_id,
        a.list_kz,
        TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
        CASE WHEN TRIM(TRIM(a.kreistyp_gruppe_id)) = 'N' THEN 'x' ELSE '-' END AS nord,
        CASE WHEN TRIM(TRIM(a.kreistyp_gruppe_id)) = 'O' THEN 'x' ELSE '-' END AS ost_basis,
        CASE WHEN TRIM(TRIM(a.kreistyp_gruppe_id)) = 'Q' THEN 'x' ELSE '-' END AS ost_gross,
        CASE WHEN TRIM(TRIM(a.kreistyp_gruppe_id)) = 'G' THEN 'x' ELSE '-' END AS sued_ost,
        CASE WHEN TRIM(TRIM(a.kreistyp_gruppe_id)) = 'M' THEN 'x' ELSE '-' END AS sued_west,
        CASE WHEN TRIM(TRIM(a.kreistyp_gruppe_id)) = 'W' THEN 'x' ELSE '-' END AS west,
        a.wup_id,
        a.avg_umsatz_gesamt,
        a.avg_umsatz_artikel,
        a.avg_umsatz_gesamt_list,
        a.umsatz_kpi,
        a.absatz_kpi,
        a.rohertrag_kpi
    FROM _list_reduced AS a
    JOIN (
        SELECT
            mandant_id,
            art_id,
            wup_id,
            kreistyp_gruppe_id
        FROM _list_reduced
        GROUP BY
            1,
            2,
            3,
            4
    ) AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND a.wup_id = x.wup_id
            AND TRIM(TRIM(a.kreistyp_gruppe_id)) = TRIM(x.kreistyp_gruppe_id)
    GROUP BY
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19
);

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    'x' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('N') AND a.sm_id >= 2
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    'x' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('N') AND a.sm_id >= 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    'x' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('N') AND a.sm_id >= 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    'x' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('N') AND a.sm_id >= 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    'x' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('O') AND a.sm_id >= 2
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    'x' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('O') AND a.sm_id >= 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    'x' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('O') AND a.sm_id >= 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    'x' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('O') AND a.sm_id >= 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    'x' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('Q') AND a.sm_id >= 2
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    'x' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('Q') AND a.sm_id >= 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    'x' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('Q') AND a.sm_id >= 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    'x' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('Q') AND a.sm_id >= 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    'x' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('G') AND a.sm_id >= 2
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    'x' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('G') AND a.sm_id >= 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    'x' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('G') AND a.sm_id >= 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    'x' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('G') AND a.sm_id >= 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    'x' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('M') AND a.sm_id >= 2
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    'x' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('M') AND a.sm_id >= 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    'x' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('M') AND a.sm_id >= 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    'x' AS sued_west,
    '-' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('M') AND a.sm_id >= 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    2 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    'x' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('W') AND a.sm_id >= 2
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    3 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    'x' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('W') AND a.sm_id >= 3
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    4 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    'x' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('W') AND a.sm_id >= 4
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT
    a.mandant_id,
    a.art_id,
    5 AS sm_id_selected,
    a.sm_id,
    a.list_kz,
    TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    'x' AS west,
    a.wup_id,
    a.avg_umsatz_gesamt,
    a.avg_umsatz_artikel,
    a.avg_umsatz_gesamt_list,
    a.umsatz_kpi,
    a.absatz_kpi,
    a.rohertrag_kpi
FROM _list_reduced AS a
WHERE
    TRIM(a.kreistyp_gruppe_id) IN ('W') AND a.sm_id >= 5
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19;

INSERT INTO _list_reduced
SELECT *
FROM _list_reduced_region_only;

CREATE OR REPLACE TEMPORARY TABLE _list_delisted AS
(
    SELECT
        a.mandant_id,
        a.art_id,
        0 AS sm_id_selected,
        a.sm_id,
        b.list_kz,
        TRIM(a.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        a.wup_id,
        a.avg_umsatz_gesamt,
        b.avg_umsatz_artikel,
        b.avg_umsatz_gesamt AS avg_umsatz_gesamt_list,
        (
            -1
        ) * (
            IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
        ) * (
            IFNULL(
                CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
                0
            )
        ) AS umsatz_kpi,
        IFNULL(
            (
                -1
            ) * (
                IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
            ) * (
                IFNULL(
                    CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
                    0
                )
            ) / NULLIF(a.preis_artikel, 0),
            0
        ) AS absatz_kpi,
        IFNULL(
            (
                -1
            ) * (
                IFNULL(a.kassenumsatz_artikel / NULLIF(a.anz_tage_artikel, 0), 0) * 300
            ) * (
                IFNULL(
                    CAST(a.anz_tage_artikel AS FLOAT64) / NULLIF(CAST(a.anz_tage_listung_artikel AS FLOAT64), 0),
                    0
                )
            ) / NULLIF(a.preis_artikel, 0),
            0
        ) * COALESCE(c.stueck_re_mep, 0) AS rohertrag_kpi
    FROM _sort_ist3_reduction AS a
    JOIN _sort_ist4 AS b
        ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
    LEFT JOIN dbp_etl.bf_sort_sal_export_2 AS c
        ON FLOOR(a.art_id / 100) = CAST(c.art_nr AS INT64)
    WHERE
        a.sm_id <= 5
    GROUP BY
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19
);

UPDATE _list_reduced SET umsatz_kpi = 0, absatz_kpi = 0, rohertrag_kpi = 0
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM _art_list_wup_kill_1
    GROUP BY
        1,
        2,
        3
) AS b
WHERE
    _list_reduced.mandant_id = b.mandant_id
    AND _list_reduced.wup_id = b.wup_id
    AND _list_reduced.art_id = b.art_id;

UPDATE _list_reduced SET umsatz_kpi = 0, absatz_kpi = 0, rohertrag_kpi = 0
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM _art_list_wup_kill_2
    GROUP BY
        1,
        2,
        3
) AS b
WHERE
    _list_reduced.mandant_id = b.mandant_id
    AND _list_reduced.wup_id = b.wup_id
    AND _list_reduced.art_id = b.art_id;

UPDATE _list_reduced SET umsatz_kpi = 0, absatz_kpi = 0, rohertrag_kpi = 0
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM _einzel_markt
    GROUP BY
        1,
        2,
        3
) AS b
WHERE
    _list_reduced.mandant_id = b.mandant_id
    AND _list_reduced.wup_id = b.wup_id
    AND _list_reduced.art_id = b.art_id;

UPDATE _list_reduced SET umsatz_kpi = 0, absatz_kpi = 0, rohertrag_kpi = 0
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM _sonstige_bst
    GROUP BY
        1,
        2,
        3
) AS b
WHERE
    _list_reduced.mandant_id = b.mandant_id
    AND _list_reduced.wup_id = b.wup_id
    AND _list_reduced.art_id = b.art_id;

UPDATE _list_extended SET umsatz_kpi = 0, absatz_kpi = 0, rohertrag_kpi = 0
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM _art_list_wup_kill_2
    GROUP BY
        1,
        2,
        3
) AS b
WHERE
    _list_extended.mandant_id = b.mandant_id
    AND _list_extended.wup_id = b.wup_id
    AND _list_extended.art_id = b.art_id;

UPDATE _list_extended SET umsatz_kpi = 0, absatz_kpi = 0, rohertrag_kpi = 0
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM _einzel_markt
    GROUP BY
        1,
        2,
        3
) AS b
WHERE
    _list_extended.mandant_id = b.mandant_id
    AND _list_extended.wup_id = b.wup_id
    AND _list_extended.art_id = b.art_id;

UPDATE _list_extended SET umsatz_kpi = 0, absatz_kpi = 0, rohertrag_kpi = 0
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id
    FROM _sonstige_bst
    GROUP BY
        1,
        2,
        3
) AS b
WHERE
    _list_extended.mandant_id = b.mandant_id
    AND _list_extended.wup_id = b.wup_id
    AND _list_extended.art_id = b.art_id;

DELETE FROM dbp_msi_data.kl_listung_2
WHERE
    kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

INSERT INTO dbp_msi_data.kl_listung_2 (
    kl_listung_id,
    listung_art,
    mandant_id,
    art_id,
    sm_id_selected,
    sm_id,
    nord,
    ost_basis,
    ost_gross,
    sued_ost,
    sued_west,
    west,
    wup_id,
    umsatz_hr,
    absatz_hr,
    rohertrag_hr,
    erweiterung_fg,
    reduktion_fg,
    kjwo_update,
    list_kz
)
SELECT
    (
        ROW_NUMBER() OVER (
            ORDER BY mandant_id, mandant_id, art_id, sm_id_selected, sm_id, nord, ost_basis, ost_gross, sued_ost, sued_west, west, wup_id, CAST(umsatz_kpi AS NUMERIC), CAST(absatz_kpi AS NUMERIC), CAST(rohertrag_kpi AS NUMERIC), b.kjwo, list_kz
        ) + COALESCE(
            (
                SELECT MAX(kl_listung_id)
                FROM dbp_msi_data.kl_listung_2
                WHERE
                    kl_listung_id <> 0
            ),
            0
        )
    ) AS kl_listung_id,
    'Listung reduzieren' AS listung_art,
    mandant_id,
    art_id,
    sm_id_selected,
    sm_id,
    nord,
    ost_basis,
    ost_gross,
    sued_ost,
    sued_west,
    west,
    wup_id,
    CAST(umsatz_kpi AS NUMERIC),
    CAST(absatz_kpi AS NUMERIC),
    CAST(rohertrag_kpi AS NUMERIC),
    0 AS erweiterung_fg,
    0 AS reduktion_fg,
    b.kjwo AS kjwo_update,
    list_kz
FROM _list_reduced AS a
JOIN dbp_data.woche_2 AS b
    ON 1 = 1
WHERE
    b.kjwo IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

INSERT INTO dbp_msi_data.kl_listung_2 (
    kl_listung_id,
    listung_art,
    mandant_id,
    art_id,
    sm_id_selected,
    sm_id,
    nord,
    ost_basis,
    ost_gross,
    sued_ost,
    sued_west,
    west,
    wup_id,
    umsatz_hr,
    absatz_hr,
    rohertrag_hr,
    erweiterung_fg,
    reduktion_fg,
    kjwo_update,
    list_kz
)
SELECT
    (
        ROW_NUMBER() OVER (
            ORDER BY mandant_id, mandant_id, art_id, sm_id_selected, sm_id, nord, ost_basis, ost_gross, sued_ost, sued_west, west, wup_id, CAST(umsatz_kpi AS NUMERIC), CAST(absatz_kpi AS NUMERIC), CAST(rohertrag_kpi AS NUMERIC), b.kjwo, list_kz
        ) + COALESCE(
            (
                SELECT MAX(kl_listung_id)
                FROM dbp_msi_data.kl_listung_2
                WHERE
                    kl_listung_id <> 0
            ),
            0
        )
    ) AS kl_listung_id,
    'Listung erweitern' AS listung_art,
    mandant_id,
    art_id,
    sm_id_selected,
    sm_id,
    nord,
    ost_basis,
    ost_gross,
    sued_ost,
    sued_west,
    west,
    wup_id,
    CAST(umsatz_kpi AS NUMERIC),
    CAST(absatz_kpi AS NUMERIC),
    CAST(rohertrag_kpi AS NUMERIC),
    0 AS erweiterung_fg,
    0 AS reduktion_fg,
    b.kjwo AS kjwo_update,
    list_kz
FROM _list_extended AS a
JOIN dbp_data.woche_2 AS b
    ON 1 = 1
WHERE
    b.kjwo IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

INSERT INTO dbp_msi_data.kl_listung_2 (
    kl_listung_id,
    listung_art,
    mandant_id,
    art_id,
    sm_id_selected,
    sm_id,
    nord,
    ost_basis,
    ost_gross,
    sued_ost,
    sued_west,
    west,
    wup_id,
    umsatz_hr,
    absatz_hr,
    rohertrag_hr,
    erweiterung_fg,
    reduktion_fg,
    kjwo_update,
    list_kz
)
SELECT
    (
        ROW_NUMBER() OVER (
            ORDER BY mandant_id, mandant_id, art_id, sm_id_selected, sm_id, nord, ost_basis, ost_gross, sued_ost, sued_west, west, wup_id, CAST(umsatz_kpi AS NUMERIC), CAST(absatz_kpi AS NUMERIC), CAST(rohertrag_kpi AS NUMERIC), b.kjwo, list_kz
        ) + COALESCE(
            (
                SELECT MAX(kl_listung_id)
                FROM dbp_msi_data.kl_listung_2
                WHERE
                    kl_listung_id <> 0
            ),
            0
        )
    ) AS kl_listung_id,
    'Auslistung' AS listung_art,
    mandant_id,
    art_id,
    sm_id_selected,
    sm_id,
    nord,
    ost_basis,
    ost_gross,
    sued_ost,
    sued_west,
    west,
    wup_id,
    CAST(umsatz_kpi AS NUMERIC),
    CAST(absatz_kpi AS NUMERIC),
    CAST(rohertrag_kpi AS NUMERIC),
    0 AS erweiterung_fg,
    0 AS reduktion_fg,
    b.kjwo AS kjwo_update,
    list_kz
FROM _list_delisted AS a
JOIN dbp_data.woche_2 AS b
    ON 1 = 1
WHERE
    b.kjwo IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

UPDATE dbp_msi_data.kl_listung_2 SET nord = 'u'
WHERE
    listung_art = 'Listung reduzieren'
    AND nord = 'x'
    AND kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

UPDATE dbp_msi_data.kl_listung_2 SET west = 'u'
WHERE
    listung_art = 'Listung reduzieren'
    AND west = 'x'
    AND kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

UPDATE dbp_msi_data.kl_listung_2 SET ost_basis = 'u'
WHERE
    listung_art = 'Listung reduzieren'
    AND ost_basis = 'x'
    AND kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

UPDATE dbp_msi_data.kl_listung_2 SET ost_gross = 'u'
WHERE
    listung_art = 'Listung reduzieren'
    AND ost_gross = 'x'
    AND kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

UPDATE dbp_msi_data.kl_listung_2 SET sued_ost = 'u'
WHERE
    listung_art = 'Listung reduzieren'
    AND sued_ost = 'x'
    AND kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

UPDATE dbp_msi_data.kl_listung_2 SET sued_west = 'u'
WHERE
    listung_art = 'Listung reduzieren'
    AND sued_west = 'x'
    AND kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

UPDATE dbp_msi_data.kl_listung_2 SET sm_id_selected = -1
WHERE
    listung_art = 'Auslistung'
    AND kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

CREATE OR REPLACE TEMPORARY TABLE _track_soll AS
SELECT
    mandant_id,
    wup_id,
    art_id
FROM `_differenz_soll`
GROUP BY
    mandant_id,
    wup_id,
    art_id;

DELETE FROM `_track_soll`
WHERE
    (mandant_id, wup_id, art_id) IN (
        SELECT (mandant_id, wup_id, art_id)
        FROM `_art_list_wup_kill_2`
    );

DELETE FROM `_track_soll`
WHERE
    (mandant_id, wup_id, art_id) IN (
        SELECT (mandant_id, wup_id, art_id)
        FROM `_einzel_markt`
    );

DELETE FROM `_track_soll`
WHERE
    (mandant_id, wup_id, art_id) IN (
        SELECT (mandant_id, wup_id, art_id)
        FROM `_sonstige_bst`
    );

CREATE OR REPLACE TEMPORARY TABLE _track_ist AS
SELECT
    mandant_id,
    wup_id,
    art_id
FROM `_ist_listung_article`
WHERE
    markt_zaehlung_fg = 1;

DELETE FROM `_track_ist`
WHERE
    (mandant_id, wup_id, art_id) IN (
        SELECT (mandant_id, wup_id, art_id)
        FROM `_art_list_wup_kill_2`
    );

DELETE FROM `_track_ist`
WHERE
    (mandant_id, wup_id, art_id) IN (
        SELECT (mandant_id, wup_id, art_id)
        FROM `_einzel_markt`
    );

DELETE FROM `_track_ist`
WHERE
    (mandant_id, wup_id, art_id) IN (
        SELECT (mandant_id, wup_id, art_id)
        FROM `_sonstige_bst`
    );

UPDATE dbp_msi_data.kl_listung_2 SET erweiterung_fg = 1
FROM `_track_soll` AS b
WHERE
    kl_listung.mandant_id = b.mandant_id
    AND kl_listung.wup_id = b.wup_id
    AND kl_listung.art_id = b.art_id
    AND kl_listung.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

UPDATE dbp_msi_data.kl_listung_2 SET reduktion_fg = 1
FROM `_track_ist` AS b
WHERE
    kl_listung.mandant_id = b.mandant_id
    AND kl_listung.wup_id = b.wup_id
    AND kl_listung.art_id = b.art_id
    AND kl_listung.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );

DELETE FROM dbp_msi_data.kl_listung_2
WHERE
    art_id IN (
        SELECT DISTINCT art_id
        FROM dbp_etl.kl_basis_listung_2
        WHERE
            list_kz <> 'A'
    )
    AND listung_art IN ('Auslistung', 'Listung reduzieren')
    AND kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE
            akt_wo = 1
    );
