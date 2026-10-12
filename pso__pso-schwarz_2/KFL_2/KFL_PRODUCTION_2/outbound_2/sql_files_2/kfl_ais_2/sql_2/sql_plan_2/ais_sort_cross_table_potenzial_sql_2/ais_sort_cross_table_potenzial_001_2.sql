CREATE OR REPLACE TEMPORARY TABLE _list_enlisted1 AS
SELECT
    1 AS sm_id_selected,
    c.sm_id,
    '-' AS nord,
    '-' AS ost_basis,
    '-' AS ost_gross,
    '-' AS sued_ost,
    '-' AS sued_west,
    '-' AS west,
    A.kl_owg_id,
    b.wg_id,
    A.gtin,
    A.nielsen_art_bez,
    A.umsatz_artikel,
    CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
    A.durchschnitt_anz_maerkte,
    A.durchschnitt_preis,
    A.anz_wochen,
    c.anz_maerkte
FROM dbp_data.sortiment_leistung_2 AS A
INNER JOIN (
    SELECT
        b.gtin_id,
        MAX(C.wg_id) AS wg_id
    FROM dbp_etl.bf_sort_sal_export_2 AS A0
    INNER JOIN (
        SELECT
            art_id,
            gtin_id
        FROM dbp_etl.art_matching_nielsen_per_2
        GROUP BY
            art_id,
            gtin_id
    ) AS b
        ON
            ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
            ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
            )
    INNER JOIN dbp_data.art_wg_zu_per_2 AS C
        ON
            C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
            PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
    GROUP BY b.gtin_id
) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
INNER JOIN (
    SELECT
        A1.wg_id,
        A1.sm_id,
        COUNT(DISTINCT A1.wup_id) AS anz_maerkte
    FROM dbp_data.sm_wup_wg_zu_per_2 AS A1
    INNER JOIN dbp_data.wup_2 AS B ON A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id
    INNER JOIN dbp_data.wg_filter_zu_2 AS WFZ
        ON
            A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id AND
            WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
    WHERE
        A1.mandant_id = 1
        AND A1.spr_id = 22
        AND A1.arthiertyp_id = 2
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
        AND CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        AND A1.sm_id BETWEEN 1 AND 5
        AND B.nb_id = 0
    GROUP BY
        A1.wg_id,
        A1.sm_id
) AS c ON b.wg_id = c.wg_id
WHERE
    A.art_id IS NOT NULL
    AND A.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_2
        WHERE akt_wo = 1
    )
    AND A.mandant_id = 1
    AND A.gtin IS NOT NULL;


INSERT INTO `_list_enlisted1`
(
    SELECT
        1 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            A1.wg_id,
            A1.sm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per_2 AS A1
        INNER JOIN dbp_data.wup_2 AS B ON A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id
        INNER JOIN dbp_data.wg_filter_zu_2 AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = 1
            AND A1.spr_id = 22
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
            AND A1.sm_id BETWEEN 1 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.wg_id,
            A1.sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            A1.wg_id,
            A1.sm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per_2 AS A1
        INNER JOIN dbp_data.wup_2 AS B ON A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id
        INNER JOIN dbp_data.wg_filter_zu_2 AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = 1
            AND A1.spr_id = 22
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
            AND A1.sm_id BETWEEN 2 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.wg_id,
            A1.sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            A1.wg_id,
            A1.sm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per_2 AS A1
        INNER JOIN dbp_data.wup_2 AS B ON A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id
        INNER JOIN dbp_data.wg_filter_zu_2 AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = 1
            AND A1.spr_id = 22
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
            AND A1.sm_id BETWEEN 2 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.wg_id,
            A1.sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            A1.wg_id,
            A1.sm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per_2 AS A1
        INNER JOIN dbp_data.wup_2 AS B ON A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id
        INNER JOIN dbp_data.wg_filter_zu_2 AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = 1
            AND A1.spr_id = 22
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
            AND A1.sm_id BETWEEN 3 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.wg_id,
            A1.sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            A1.wg_id,
            A1.sm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per_2 AS A1
        INNER JOIN dbp_data.wup_2 AS B ON A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id
        INNER JOIN dbp_data.wg_filter_zu_2 AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = 1
            AND A1.spr_id = 22
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
            AND A1.sm_id BETWEEN 3 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.wg_id,
            A1.sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            A1.wg_id,
            A1.sm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per_2 AS A1
        INNER JOIN dbp_data.wup_2 AS B ON A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id
        INNER JOIN dbp_data.wg_filter_zu_2 AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = 1
            AND A1.spr_id = 22
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
            AND A1.sm_id BETWEEN 4 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.wg_id,
            A1.sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            A1.wg_id,
            A1.sm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per_2 AS A1
        INNER JOIN dbp_data.wup_2 AS B ON A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id
        INNER JOIN dbp_data.wg_filter_zu_2 AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = 1
            AND A1.spr_id = 22
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
            AND A1.sm_id BETWEEN 4 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.wg_id,
            A1.sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            A1.wg_id,
            A1.sm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per_2 AS A1
        INNER JOIN dbp_data.wup_2 AS B ON A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id
        INNER JOIN dbp_data.wg_filter_zu_2 AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = 1
            AND A1.spr_id = 22
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
            AND A1.sm_id BETWEEN 5 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.wg_id,
            A1.sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            A1.wg_id,
            A1.sm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per_2 AS A1
        INNER JOIN dbp_data.wup_2 AS B ON A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id
        INNER JOIN dbp_data.wg_filter_zu_2 AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = 1
            AND A1.spr_id = 22
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
            AND A1.sm_id BETWEEN 5 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.wg_id,
            A1.sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


CREATE OR REPLACE TEMPORARY TABLE _enlistment_potential AS
SELECT
    B.kreistyp_gruppe_id,
    A.wg_id,
    A.wup_id,
    A.sm_id
FROM dbp_data.sm_wup_wg_zu_per_2 AS A
INNER JOIN dbp_data.wup_2 AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
INNER JOIN dbp_data.wg_filter_zu_2 AS WFZ
    ON
        A.wg_id = WFZ.wg_id AND A.mandant_id = WFZ.mandant_id AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
WHERE
    A.mandant_id = 1
    AND A.spr_id = 22
    AND A.arthiertyp_id = 2
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
    AND A.sm_id BETWEEN 1 AND 5
    AND B.nb_id = 0
GROUP BY
    B.kreistyp_gruppe_id,
    A.wg_id,
    A.wup_id,
    A.sm_id;


CREATE OR REPLACE TEMPORARY TABLE _list_enlisted1_region_only AS
SELECT
    0 AS sm_id_selected,
    A.sm_id,
    CASE
        WHEN TRIM(x.kreistyp_gruppe_id) = 'N'
            THEN 'x'
        ELSE '-'
    END AS nord,
    CASE
        WHEN TRIM(x.kreistyp_gruppe_id) = 'O'
            THEN 'x'
        ELSE '-'
    END AS ost_basis,
    CASE
        WHEN TRIM(x.kreistyp_gruppe_id) = 'Q'
            THEN 'x'
        ELSE '-'
    END AS ost_gross,
    CASE
        WHEN TRIM(x.kreistyp_gruppe_id) = 'G'
            THEN 'x'
        ELSE '-'
    END AS sued_ost,
    CASE
        WHEN TRIM(x.kreistyp_gruppe_id) = 'M'
            THEN 'x'
        ELSE '-'
    END AS sued_west,
    CASE
        WHEN TRIM(x.kreistyp_gruppe_id) = 'W'
            THEN 'x'
        ELSE '-'
    END AS west,
    A.kl_owg_id,
    A.wg_id,
    A.gtin,
    A.nielsen_art_bez,
    A.umsatz_artikel,
    A.kl_markt_anteil_owg,
    A.durchschnitt_anz_maerkte,
    A.durchschnitt_preis,
    A.anz_wochen,
    x.anz_maerkte
FROM `_list_enlisted1` AS A
INNER JOIN (
    SELECT
        wg_id,
        kreistyp_gruppe_id,
        COUNT(DISTINCT wup_id) AS anz_maerkte
    FROM `_enlistment_potential`
    WHERE TRIM(kreistyp_gruppe_id) IN ('O', 'G', 'M', 'N', 'Q', 'W')
    GROUP BY
        wg_id,
        kreistyp_gruppe_id
) AS x ON A.wg_id = x.wg_id
GROUP BY
    sm_id_selected,
    A.sm_id,
    nord,
    ost_basis,
    ost_gross,
    sued_ost,
    sued_west,
    west,
    A.kl_owg_id,
    A.wg_id,
    A.gtin,
    A.nielsen_art_bez,
    A.umsatz_artikel,
    A.kl_markt_anteil_owg,
    A.durchschnitt_anz_maerkte,
    A.durchschnitt_preis,
    A.anz_wochen,
    x.anz_maerkte;


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        'x' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'N'
            AND sm_id < 2
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        'x' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'N'
            AND sm_id < 2
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        'x' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'N'
            AND sm_id < 3
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        'x' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'N'
            AND sm_id < 3
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        'x' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'N'
            AND sm_id < 4
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        'x' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'N'
            AND sm_id < 4
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        'x' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'N'
            AND sm_id < 5
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        'x' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'N'
            AND sm_id < 5
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        'x' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'O'
            AND sm_id < 2
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        'x' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'O'
            AND sm_id < 2
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        'x' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'O'
            AND sm_id < 3
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        'x' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'O'
            AND sm_id < 3
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        'x' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'O'
            AND sm_id < 4
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        'x' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'O'
            AND sm_id < 4
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        'x' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'O'
            AND sm_id < 5
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        'x' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'O'
            AND sm_id < 5
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        'x' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'Q'
            AND sm_id < 2
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        'x' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'Q'
            AND sm_id < 2
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        'x' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'Q'
            AND sm_id < 3
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        'x' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'Q'
            AND sm_id < 3
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        'x' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'Q'
            AND sm_id < 4
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        'x' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'Q'
            AND sm_id < 4
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        'x' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'Q'
            AND sm_id < 5
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        'x' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'Q'
            AND sm_id < 5
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        'x' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'G'
            AND sm_id < 2
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        'x' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'G'
            AND sm_id < 2
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        'x' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'G'
            AND sm_id < 3
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        'x' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'G'
            AND sm_id < 3
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        'x' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'G'
            AND sm_id < 4
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        'x' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'G'
            AND sm_id < 4
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        'x' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'G'
            AND sm_id < 5
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        'x' AS sued_ost,
        '-' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'G'
            AND sm_id < 5
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        'x' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'M'
            AND sm_id < 2
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        'x' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'M'
            AND sm_id < 2
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        'x' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'M'
            AND sm_id < 3
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        'x' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'M'
            AND sm_id < 3
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        'x' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'M'
            AND sm_id < 4
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        'x' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'M'
            AND sm_id < 4
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        'x' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'M'
            AND sm_id < 5
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        'x' AS sued_west,
        '-' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'M'
            AND sm_id < 5
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        'x' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'W'
            AND sm_id < 2
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        2 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        'x' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'W'
            AND sm_id < 2
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        'x' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'W'
            AND sm_id < 3
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        3 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        'x' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'W'
            AND sm_id < 3
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        'x' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'W'
            AND sm_id < 4
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        4 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        'x' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'W'
            AND sm_id < 4
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        'x' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                gtin_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.gtin_id
    ) AS b ON ROUND(CAST(A.gtin AS BIGNUMERIC), 0) = b.gtin_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'W'
            AND sm_id < 5
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.art_id IS NOT NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
        AND A.gtin IS NOT NULL
);


INSERT INTO `_list_enlisted1`
(
    SELECT
        5 AS sm_id_selected,
        c.sm_id,
        '-' AS nord,
        '-' AS ost_basis,
        '-' AS ost_gross,
        '-' AS sued_ost,
        '-' AS sued_west,
        'x' AS west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        CAST(A.kl_markt_anteil_owg AS FLOAT64) / 100.0000 AS kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
    FROM dbp_data.sortiment_leistung_2 AS A
    INNER JOIN (
        SELECT
            b.kl_owg_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_etl.bf_sort_sal_export_2 AS A0
        INNER JOIN (
            SELECT
                art_id,
                kl_owg_id
            FROM dbp_etl.art_matching_nielsen_per_2
            GROUP BY
                art_id,
                kl_owg_id
        ) AS b
            ON
                ROUND(CAST(A0.art_nr AS BIGNUMERIC), 0
                ) = CAST(FLOOR(b.art_id / 100) AS INTEGER
                )
        INNER JOIN dbp_data.art_wg_zu_per_2 AS C
            ON
                C.mandant_id = 1 AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY b.kl_owg_id
    ) AS b ON A.kl_owg_id = b.kl_owg_id
    INNER JOIN (
        SELECT
            wg_id,
            sm_id,
            COUNT(DISTINCT wup_id) AS anz_maerkte
        FROM `_enlistment_potential`
        WHERE
            TRIM(kreistyp_gruppe_id) = 'W'
            AND sm_id < 5
        GROUP BY
            wg_id,
            sm_id
    ) AS c ON b.wg_id = c.wg_id
    WHERE
        A.gtin IS NOT NULL
        AND A.art_id IS NULL
        AND A.kjwo_update IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
        AND A.mandant_id = 1
);


INSERT INTO `_list_enlisted1`
(
    SELECT *
    FROM `_list_enlisted1_region_only`
);


CREATE OR REPLACE TEMPORARY TABLE _list_enlisted2 AS
SELECT
    sm_id_selected,
    sm_id,
    nord,
    ost_basis,
    ost_gross,
    sued_ost,
    sued_west,
    west,
    kl_owg_id,
    wg_id,
    gtin,
    nielsen_art_bez,
    umsatz_artikel,
    kl_markt_anteil_owg,
    durchschnitt_anz_maerkte,
    durchschnitt_preis,
    anz_wochen,
    anz_maerkte,
    umsatz_artikel * kl_markt_anteil_owg AS erg1,
    IFNULL(
        umsatz_artikel * kl_markt_anteil_owg / IF(durchschnitt_anz_maerkte = 0, NULL, durchschnitt_anz_maerkte), 0) AS
    erg2,
    IFNULL(IFNULL(
        umsatz_artikel * kl_markt_anteil_owg / IF(durchschnitt_anz_maerkte = 0, NULL, durchschnitt_anz_maerkte),
        0
    ) / IF(anz_wochen = 0, NULL, anz_wochen
    ), 0) AS erg3,
    IFNULL(IFNULL(
        umsatz_artikel * kl_markt_anteil_owg / IF(durchschnitt_anz_maerkte = 0, NULL, durchschnitt_anz_maerkte
        ), 0
    ) / IF(anz_wochen = 0, NULL, anz_wochen
    ), 0) * anz_maerkte * 52 AS umsatz,
    IFNULL(IFNULL(IFNULL(umsatz_artikel * kl_markt_anteil_owg / IF(
        durchschnitt_anz_maerkte = 0, NULL,
        durchschnitt_anz_maerkte
    ), 0) / IF(anz_wochen = 0, NULL, anz_wochen), 0) * anz_maerkte * 52 / IF(durchschnitt_preis
    = 0, NULL, durchschnitt_preis), 0) AS absatz
FROM `_list_enlisted1`;


DELETE FROM dbp_msi_data.nl_listung_2
WHERE kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche_2
    WHERE akt_wo = 1
);


INSERT INTO dbp_msi_data.nl_listung_2 (
    nl_listung_id, mandant_id, listung_art, sm_id_selected, sm_id, gtin,
    ost_basis, ost_gross, sued_ost, sued_west, west, nord, kl_owg_id, wg_id, art_nielsen_bez, umsatz_artikel,
    durchschnitt_anz_maerkte, durchschnitt_preis, anz_wochen, anz_maerkte, umsatz_hr, absatz_hr, kjwo_update
)
(
    SELECT
        CAST((ROW_NUMBER() OVER (
            ORDER BY
                A.sm_id_selected IS NULL, A.sm_id_selected, A.sm_id IS NULL, A.sm_id, A.gtin IS NULL, A.gtin, A.ost_basis IS NULL, A.ost_basis, A.ost_gross IS NULL, A.ost_gross, A.sued_ost IS NULL, A.sued_ost, A.sued_west IS NULL, A.sued_west, A.west IS NULL, A.west, A.nord
                IS NULL, A.nord, A.kl_owg_id IS NULL, A.kl_owg_id, A.wg_id IS NULL, A.wg_id, A.nielsen_art_bez IS NULL, A.nielsen_art_bez, A.umsatz_artikel IS NULL, A.umsatz_artikel, A.durchschnitt_anz_maerkte IS NULL, A.durchschnitt_anz_maerkte, A.durchschnitt_preis IS NULL, A.durchschnitt_preis, A.anz_wochen
                IS NULL, A.anz_wochen, A.anz_maerkte IS NULL, A.anz_maerkte, A.umsatz IS NULL, A.umsatz, A.absatz IS NULL, A.absatz, B.kjwo IS NULL, B.kjwo
        )) + COALESCE((SELECT
            MAX(nl_listung_id
            )
        FROM dbp_msi_data.nl_listung_2
        WHERE nl_listung_id <> 0), 0) AS NUMERIC) AS nl_listung_id,
        1 AS mandant_id,
        'Listung erweitern' AS listung_art,
        A.sm_id_selected,
        A.sm_id,
        A.gtin,
        A.ost_basis,
        A.ost_gross,
        A.sued_ost,
        A.sued_west,
        A.west,
        A.nord,
        A.kl_owg_id,
        A.wg_id,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        A.anz_maerkte,
        CAST(A.umsatz as NUMERIC), --pe_review
        CAST(A.absatz as NUMERIC), --pe_review
        B.kjwo AS kjwo_update
    FROM `_list_enlisted2` AS A
    INNER JOIN dbp_data.woche_2 AS B ON TRUE
    WHERE
        B.kjwo IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
);


INSERT INTO dbp_msi_data.nl_listung_2 (
    nl_listung_id, mandant_id, listung_art, sm_id_selected, sm_id, gtin,
    ost_basis, ost_gross, sued_ost, sued_west, west, nord, kl_owg_id, wg_id, art_nielsen_bez, umsatz_artikel,
    durchschnitt_anz_maerkte, durchschnitt_preis, anz_wochen, anz_maerkte, umsatz_hr, absatz_hr, kjwo_update
)
(
    SELECT
        CAST((ROW_NUMBER() OVER (
            ORDER BY
                A.sm_id_selected IS NULL, A.sm_id_selected, A.sm_id IS NULL, A.sm_id, A.gtin IS NULL, A.gtin, A.ost_basis IS NULL, A.ost_basis, A.ost_gross IS NULL, A.ost_gross, A.sued_ost IS NULL, A.sued_ost, A.sued_west IS NULL, A.sued_west, A.west IS NULL, A.west, A.nord
                IS NULL, A.nord, A.kl_owg_id IS NULL, A.kl_owg_id, A.wg_id IS NULL, A.wg_id, A.nielsen_art_bez IS NULL, A.nielsen_art_bez, A.umsatz_artikel IS NULL, A.umsatz_artikel, A.durchschnitt_anz_maerkte IS NULL, A.durchschnitt_anz_maerkte, A.durchschnitt_preis IS NULL, A.durchschnitt_preis, A.anz_wochen
                IS NULL, A.anz_wochen, A.anz_maerkte IS NULL, A.anz_maerkte, A.umsatz IS NULL, A.umsatz, A.absatz IS NULL, A.absatz, B.kjwo IS NULL, B.kjwo
        )) + COALESCE((SELECT
            MAX(nl_listung_id
            )
        FROM dbp_msi_data.nl_listung_2
        WHERE nl_listung_id <> 0), 0) AS NUMERIC) AS nl_listung_id,
        1 AS mandant_id,
        'Einlistung Potenzialartikel' AS listung_art,
        A.sm_id_selected,
        A.sm_id,
        A.gtin,
        A.ost_basis,
        A.ost_gross,
        A.sued_ost,
        A.sued_west,
        A.west,
        A.nord,
        A.kl_owg_id,
        A.wg_id,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        A.anz_maerkte,
        CAST(A.umsatz as NUMERIC), --pe_review
        CAST(A.absatz as NUMERIC), --pe_review
        B.kjwo AS kjwo_update
    FROM `_list_enlisted2` AS A
    INNER JOIN dbp_data.woche_2 AS B ON TRUE
    WHERE
        B.kjwo IN (
            SELECT kjwo
            FROM dbp_data.woche_2
            WHERE akt_wo = 1
        )
);
