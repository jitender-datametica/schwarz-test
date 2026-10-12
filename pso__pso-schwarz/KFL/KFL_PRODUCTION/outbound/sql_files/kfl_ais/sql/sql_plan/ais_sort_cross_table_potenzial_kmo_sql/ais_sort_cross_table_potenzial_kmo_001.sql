--PARAMS


SELECT ${mandant_id} AS mandant_id;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TEMPORARY TABLE DBP_DATA.schema.table ...)


CREATE OR REPLACE TEMPORARY TABLE _soll_kategorien_maerkte_1 AS
SELECT
    A.mandant_id,
    A.art_id,
    c.wup_id,
    c.sm_id,
    c.ksm_id,
    c.kreistyp_gruppe_id
FROM dbp_data.art AS A
INNER JOIN dbp_data.art_wg_zu_per AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.wup_id,
        A0.wg_id,
        A0.sm_id,
        A0.ksm_id,
        B0.kreistyp_gruppe_id
    FROM dbp_data.sm_wup_wg_zu_per AS A0
    INNER JOIN dbp_data.wup AS B0
        ON
            A0.mandant_id = B0.mandant_id AND A0.wup_id = B0.wup_id AND
            CURRENT_DATE("Europe/Berlin") BETWEEN B0.dat_von AND B0.dat_bis
    INNER JOIN dbp_data.wg_filter_zu AS WFZ
        ON
            A0.wg_id = WFZ.wg_id AND A0.mandant_id = WFZ.mandant_id AND
            WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
    WHERE
        A0.mandant_id = ${mandant_id}
        AND A0.arthiertyp_id = 2
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A0.dat_von AND A0.dat_bis
        AND (A0.sm_id BETWEEN 1 AND 5 OR A0.ksm_id IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9'))
        AND B0.nb_id = 0
    GROUP BY
        A0.mandant_id,
        A0.wup_id,
        A0.wg_id,
        A0.sm_id,
        A0.ksm_id,
        B0.kreistyp_gruppe_id
) AS c ON B.wg_id = c.wg_id AND B.mandant_id = c.mandant_id
WHERE
    A.mandant_id = ${mandant_id}
    AND A.dat_bis = PARSE_DATE('%F', '9999-12-31')
GROUP BY
    A.mandant_id,
    A.art_id,
    c.wup_id,
    c.sm_id,
    c.ksm_id,
    c.kreistyp_gruppe_id;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TEMPORARY TABLE DBP_DATA.schema.table ...)


CREATE OR REPLACE TEMPORARY TABLE _list_enlisted1_1 AS
SELECT
    1 AS sm_id_selected,
    '  ' AS ksm_id_selected,
    c.sm_id,
    c.ksm_id,
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
FROM dbp_data.sortiment_leistung AS A
INNER JOIN (
    SELECT
        A0.mandant_id,
        b.gtin_id,
        MAX(C.wg_id) AS wg_id
    FROM dbp_data.sal_kmo AS A0
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            gtin_id
        FROM dbp_etl.art_matching_nielsen_per_kmo
        WHERE mandant_id = ${mandant_id}
        GROUP BY
            mandant_id,
            art_id,
            gtin_id
    ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
    INNER JOIN dbp_data.art_wg_zu_per AS C
        ON
            C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
            PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
    WHERE A0.mandant_id = ${mandant_id}
    GROUP BY
        A0.mandant_id,
        b.gtin_id
) AS b
    ON
        ROUND(CAST(A.gtin AS BIGNUMERIC), 0
        ) = b.gtin_id AND A.mandant_id = b.mandant_id
INNER JOIN (
    SELECT
        A1.mandant_id,
        A1.wg_id,
        A1.sm_id,
        A1.ksm_id,
        COUNT(DISTINCT A1.wup_id) AS anz_maerkte
    FROM dbp_data.sm_wup_wg_zu_per AS A1
    INNER JOIN dbp_data.wup AS B
        ON
            A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND CURRENT_DATE("Europe/Berlin")
            BETWEEN B.dat_von AND B.dat_bis
    INNER JOIN dbp_data.wg_filter_zu AS WFZ
        ON
            A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id AND
            WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
    WHERE
        A1.mandant_id = ${mandant_id}
        AND A1.arthiertyp_id = 2
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
        AND A1.sm_id BETWEEN 1 AND 5
        AND B.nb_id = 0
    GROUP BY
        A1.mandant_id,
        A1.wg_id,
        A1.sm_id,
        A1.ksm_id
) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
WHERE
    A.art_id IS NOT NULL
    AND A.mandant_id = ${mandant_id}
    AND A.kjwo_update IN (
        SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.sortiment_leistung
        WHERE mandant_id = ${mandant_id}
    )
    AND A.gtin IS NOT NULL;


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        1 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.sm_id BETWEEN 1 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        2 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.sm_id BETWEEN 2 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        2 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.sm_id BETWEEN 2 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        3 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.sm_id BETWEEN 3 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        3 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.sm_id BETWEEN 3 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        4 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.sm_id BETWEEN 4 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        4 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.sm_id BETWEEN 4 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        5 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.sm_id BETWEEN 5 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        5 AS sm_id_selected,
        '  ' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.sm_id BETWEEN 5 AND 5
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K1' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K1' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K2' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K2' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K3' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K3' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K4' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K4', 'K5', 'K6', 'K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K4' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K4', 'K5', 'K6', 'K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K5' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K5', 'K6', 'K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K5' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K5', 'K6', 'K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K6' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K6', 'K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K6' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K6', 'K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K7' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K7' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K7', 'K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K8' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K8' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K8', 'K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K9' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.gtin_id,
            MAX(C.wg_id) AS wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                gtin_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                gtin_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        WHERE A0.mandant_id = ${mandant_id}
        GROUP BY
            A0.mandant_id,
            b.gtin_id
    ) AS b
        ON
            ROUND(CAST(A.gtin AS BIGNUMERIC), 0
            ) = b.gtin_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NOT NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO `_list_enlisted1_1`
(
    SELECT
        CAST(NULL AS INTEGER) AS sm_id_selected,
        'K9' AS ksm_id_selected,
        c.sm_id,
        c.ksm_id,
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
    FROM dbp_data.sortiment_leistung AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
            b.wg_id
        FROM dbp_data.sal_kmo AS A0
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                kl_owg_id AS wg_id
            FROM dbp_etl.art_matching_nielsen_per_kmo
            WHERE mandant_id = ${mandant_id}
            GROUP BY
                mandant_id,
                art_id,
                wg_id
        ) AS b ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id
        INNER JOIN dbp_data.art_wg_zu_per AS C
            ON
                C.mandant_id = ${mandant_id} AND C.arthiertyp_id = 2 AND C.dat_bis =
                PARSE_DATE('%F', '9999-12-31') AND b.art_id = C.art_id
        GROUP BY
            A0.mandant_id,
            b.wg_id
    ) AS b ON A.kl_owg_id = b.wg_id AND A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id,
            COUNT(DISTINCT A1.wup_id) AS anz_maerkte
        FROM dbp_data.sm_wup_wg_zu_per AS A1
        INNER JOIN dbp_data.wup AS B
            ON
                A1.mandant_id = B.mandant_id AND A1.wup_id = B.wup_id AND
                CURRENT_DATE("Europe/Berlin") BETWEEN B.dat_von AND B.dat_bis
        INNER JOIN dbp_data.wg_filter_zu AS WFZ
            ON
                A1.wg_id = WFZ.wg_id AND A1.mandant_id = WFZ.mandant_id
                AND WFZ.wg_filter_id = 11 AND WFZ.arthiertyp_id = 2
        WHERE
            A1.mandant_id = ${mandant_id}
            AND A1.arthiertyp_id = 2
            AND CURRENT_DATE("Europe/Berlin") BETWEEN A1.dat_von AND A1.dat_bis
            AND A1.ksm_id IN ('K9')
            AND B.nb_id = 0
        GROUP BY
            A1.mandant_id,
            A1.wg_id,
            A1.sm_id,
            A1.ksm_id
    ) AS c ON b.wg_id = c.wg_id AND b.mandant_id = c.mandant_id
    WHERE
        A.art_id IS NULL
        AND A.mandant_id = ${mandant_id}
        AND A.kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.sortiment_leistung
            WHERE mandant_id = ${mandant_id}
        )
        AND A.gtin IS NOT NULL
    GROUP BY
        sm_id_selected,
        ksm_id_selected,
        c.sm_id,
        c.ksm_id,
        nord,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        A.kl_owg_id,
        b.wg_id,
        A.gtin,
        A.nielsen_art_bez,
        A.umsatz_artikel,
        kl_markt_anteil_owg,
        A.durchschnitt_anz_maerkte,
        A.durchschnitt_preis,
        A.anz_wochen,
        c.anz_maerkte
);


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TEMPORARY TABLE DBP_DATA.schema.table ...)


CREATE OR REPLACE TEMPORARY TABLE _list_enlisted2_1 AS
SELECT
    sm_id_selected,
    ksm_id_selected,
    sm_id,
    ksm_id,
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
    ), 0) * anz_maerkte * 12 AS umsatz,
    IFNULL(IFNULL(IFNULL(umsatz_artikel * kl_markt_anteil_owg / IF(
        durchschnitt_anz_maerkte = 0, NULL,
        durchschnitt_anz_maerkte
    ), 0) / IF(anz_wochen = 0, NULL, anz_wochen), 0) * anz_maerkte * 12 / IF(durchschnitt_preis
    = 0, NULL, durchschnitt_preis), 0) AS absatz
FROM `_list_enlisted1_1`;


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_msi_data.nl_listung_kmo
WHERE mandant_id = ${mandant_id} AND kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche
    WHERE akt_wo = 1
);


INSERT INTO dbp_msi_data.nl_listung_kmo (
    nl_listung_kmo_id, mandant_id, listung_art, sm_id_selected,
    ksm_id_selected, sm_id, ksm_id, gtin, ost_basis, ost_gross, sued_ost, sued_west, west, nord, kl_owg_id, wg_id,
    art_nielsen_bez, umsatz_artikel, durchschnitt_anz_maerkte, durchschnitt_preis, anz_wochen, anz_maerkte, umsatz_hr,
    absatz_hr, kjwo_update
)
(
    SELECT
        CAST((ROW_NUMBER() OVER (
            ORDER BY
                ${mandant_id} IS NULL, ${mandant_id}, 'Listung erweitern' IS NULL, 'Listung erweitern', `_list_enlisted2_1`.sm_id_selected IS NULL, `_list_enlisted2_1`.sm_id_selected, `_list_enlisted2_1`.sm_id IS NULL, `_list_enlisted2_1`.sm_id, `_list_enlisted2_1`.gtin IS NULL,
                `_list_enlisted2_1`.gtin, `_list_enlisted2_1`.ost_basis IS NULL, `_list_enlisted2_1`.ost_basis, `_list_enlisted2_1`.ost_gross IS NULL, `_list_enlisted2_1`.ost_gross, `_list_enlisted2_1`.sued_ost IS NULL, `_list_enlisted2_1`.sued_ost, `_list_enlisted2_1`.sued_west IS NULL, `_list_enlisted2_1`
                .sued_west, `_list_enlisted2_1`.west IS NULL, `_list_enlisted2_1`.west, `_list_enlisted2_1`.nord IS NULL, `_list_enlisted2_1`.nord, `_list_enlisted2_1`.kl_owg_id IS NULL, `_list_enlisted2_1`.kl_owg_id, `_list_enlisted2_1`.wg_id IS NULL, `_list_enlisted2_1`.wg_id, `_list_enlisted2_1`.nielsen_art_bez
                IS NULL, `_list_enlisted2_1`.nielsen_art_bez, `_list_enlisted2_1`.umsatz_artikel IS NULL, `_list_enlisted2_1`.umsatz_artikel, `_list_enlisted2_1`.durchschnitt_anz_maerkte IS NULL, `_list_enlisted2_1`.durchschnitt_anz_maerkte, `_list_enlisted2_1`.durchschnitt_preis IS NULL, `_list_enlisted2_1`
                .durchschnitt_preis, `_list_enlisted2_1`.anz_wochen IS NULL, `_list_enlisted2_1`.anz_wochen, `_list_enlisted2_1`.anz_maerkte IS NULL, `_list_enlisted2_1`.anz_maerkte, `_list_enlisted2_1`.umsatz IS NULL, `_list_enlisted2_1`.umsatz, `_list_enlisted2_1`.absatz IS NULL, `_list_enlisted2_1`.absatz,
                B.kjwo IS NULL, B.kjwo
        )) + COALESCE((SELECT
            MAX(nl_listung_kmo_id
            )
        FROM dbp_msi_data.nl_listung_kmo
        WHERE nl_listung_kmo_id <> 0), 0) AS NUMERIC) AS nl_listung_kmo_id,
        ${mandant_id} AS mandant_id,
        'Listung erweitern' AS listung_art,
        `_list_enlisted2_1`.sm_id_selected,
        `_list_enlisted2_1`.ksm_id_selected,
        `_list_enlisted2_1`.sm_id,
        `_list_enlisted2_1`.ksm_id,
        `_list_enlisted2_1`.gtin,
        `_list_enlisted2_1`.ost_basis,
        `_list_enlisted2_1`.ost_gross,
        `_list_enlisted2_1`.sued_ost,
        `_list_enlisted2_1`.sued_west,
        `_list_enlisted2_1`.west,
        `_list_enlisted2_1`.nord,
        `_list_enlisted2_1`.kl_owg_id,
        `_list_enlisted2_1`.wg_id,
        `_list_enlisted2_1`.nielsen_art_bez,
        `_list_enlisted2_1`.umsatz_artikel,
        `_list_enlisted2_1`.durchschnitt_anz_maerkte,
        `_list_enlisted2_1`.durchschnitt_preis,
        `_list_enlisted2_1`.anz_wochen,
        `_list_enlisted2_1`.anz_maerkte,
        CAST(`_list_enlisted2_1`.umsatz AS NUMERIC),
        CAST(`_list_enlisted2_1`.absatz AS NUMERIC),
        B.kjwo AS kjwo_update
    FROM `_list_enlisted2_1`
    INNER JOIN dbp_data.woche AS B ON TRUE
    WHERE
        B.kjwo IN (
            SELECT kjwo
            FROM dbp_data.woche
            WHERE akt_wo = 1
        )
);


INSERT INTO dbp_msi_data.nl_listung_kmo (
    nl_listung_kmo_id, mandant_id, listung_art, sm_id_selected,
    ksm_id_selected, sm_id, ksm_id, gtin, ost_basis, ost_gross, sued_ost, sued_west, west, nord, kl_owg_id, wg_id,
    art_nielsen_bez, umsatz_artikel, durchschnitt_anz_maerkte, durchschnitt_preis, anz_wochen, anz_maerkte, umsatz_hr,
    absatz_hr, kjwo_update
)
(
    SELECT
        CAST((ROW_NUMBER() OVER (
            ORDER BY
                ${mandant_id} IS NULL, ${mandant_id}, 'Einlistung Potenzialartikel' IS NULL, 'Einlistung Potenzialartikel', `_list_enlisted2_1`.sm_id_selected IS NULL, `_list_enlisted2_1`.sm_id_selected, `_list_enlisted2_1`.sm_id IS NULL, `_list_enlisted2_1`.sm_id, `_list_enlisted2_1`.gtin
                IS NULL, `_list_enlisted2_1`.gtin, `_list_enlisted2_1`.ost_basis IS NULL, `_list_enlisted2_1`.ost_basis, `_list_enlisted2_1`.ost_gross IS NULL, `_list_enlisted2_1`.ost_gross, `_list_enlisted2_1`.sued_ost IS NULL, `_list_enlisted2_1`.sued_ost, `_list_enlisted2_1`.sued_west IS NULL,
                `_list_enlisted2_1`.sued_west, `_list_enlisted2_1`.west IS NULL, `_list_enlisted2_1`.west, `_list_enlisted2_1`.nord IS NULL, `_list_enlisted2_1`.nord, `_list_enlisted2_1`.kl_owg_id IS NULL, `_list_enlisted2_1`.kl_owg_id, `_list_enlisted2_1`.wg_id IS NULL, `_list_enlisted2_1`.wg_id,
                `_list_enlisted2_1`.nielsen_art_bez IS NULL, `_list_enlisted2_1`.nielsen_art_bez, `_list_enlisted2_1`.umsatz_artikel IS NULL, `_list_enlisted2_1`.umsatz_artikel, `_list_enlisted2_1`.durchschnitt_anz_maerkte IS NULL, `_list_enlisted2_1`.durchschnitt_anz_maerkte, `_list_enlisted2_1`.durchschnitt_preis
                IS NULL, `_list_enlisted2_1`.durchschnitt_preis, `_list_enlisted2_1`.anz_wochen IS NULL, `_list_enlisted2_1`.anz_wochen, `_list_enlisted2_1`.anz_maerkte IS NULL, `_list_enlisted2_1`.anz_maerkte, `_list_enlisted2_1`.umsatz IS NULL, `_list_enlisted2_1`.umsatz, `_list_enlisted2_1`.absatz
                IS NULL, `_list_enlisted2_1`.absatz, B.kjwo IS NULL, B.kjwo
        )) + COALESCE((SELECT
            MAX(nl_listung_kmo_id
            )
        FROM dbp_msi_data.nl_listung_kmo
        WHERE nl_listung_kmo_id <> 0), 0) AS NUMERIC) AS nl_listung_kmo_id,
        ${mandant_id} AS mandant_id,
        'Einlistung Potenzialartikel' AS listung_art,
        `_list_enlisted2_1`.sm_id_selected,
        `_list_enlisted2_1`.ksm_id_selected,
        `_list_enlisted2_1`.sm_id,
        `_list_enlisted2_1`.ksm_id,
        `_list_enlisted2_1`.gtin,
        `_list_enlisted2_1`.ost_basis,
        `_list_enlisted2_1`.ost_gross,
        `_list_enlisted2_1`.sued_ost,
        `_list_enlisted2_1`.sued_west,
        `_list_enlisted2_1`.west,
        `_list_enlisted2_1`.nord,
        `_list_enlisted2_1`.kl_owg_id,
        `_list_enlisted2_1`.wg_id,
        `_list_enlisted2_1`.nielsen_art_bez,
        `_list_enlisted2_1`.umsatz_artikel,
        `_list_enlisted2_1`.durchschnitt_anz_maerkte,
        `_list_enlisted2_1`.durchschnitt_preis,
        `_list_enlisted2_1`.anz_wochen,
        `_list_enlisted2_1`.anz_maerkte,
        CAST(`_list_enlisted2_1`.umsatz AS NUMERIC),
        CAST(`_list_enlisted2_1`.absatz AS NUMERIC),
        B.kjwo AS kjwo_update
    FROM `_list_enlisted2_1`
    INNER JOIN dbp_data.woche AS B ON TRUE
    WHERE
        B.kjwo IN (
            SELECT kjwo
            FROM dbp_data.woche
            WHERE akt_wo = 1
        )
);
