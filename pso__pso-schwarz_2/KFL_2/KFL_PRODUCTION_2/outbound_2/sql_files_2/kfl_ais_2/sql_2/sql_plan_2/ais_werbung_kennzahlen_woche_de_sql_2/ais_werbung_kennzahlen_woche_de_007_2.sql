BEGIN
    DECLARE wkw INT64;
    SET wkw = ${WKW};

    CREATE OR REPLACE TEMPORARY TABLE `_werbeartikel_1_2` (
        kjwo INT64,
        werbetyp_id INT64,
        aktion_id STRING(10),
        dat_von DATE,
        dat_bis DATE,
        wup_id INT64,
        mandant_id INT64,
        art_id INT64,
        akt_wo INT64,
        vk_brutto NUMERIC(29, 2),
        mutter_wb_id INT64,
        avq_relevant_fg INT64,
        dat_sperrung DATE
    );

    INSERT INTO `_werbeartikel_1_2` (
        kjwo,
        werbetyp_id,
        aktion_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        avq_relevant_fg,
        dat_sperrung
    )
    (
        SELECT
            x1.kjwo,
            2 AS werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(
                CASE
                    WHEN akta.dat_sperrung IS NULL OR akta.dat_sperrung >= akt.dat_von
                        THEN akt.avq_relevant_fg
                    ELSE 0
                END
            ) AS avq_relevant_fg,
            MAX(COALESCE(akta.dat_sperrung, CAST('9999-12-31' AS DATE))) AS dat_sperrung
        FROM (
            SELECT
                a.aktion_id,
                a.mandant_id,
                a.bewart_id,
                a.aktionsart_id,
                a.werbe_kat_id,
                a.dat_von,
                a.dat_bis,
                a.preisaktiviert_fg,
                a.kjwo_von,
                a.aktion_typ_id,
                a.td_update,
                a.td_insert,
                CASE
                    WHEN a.preisaktiviert_fg = 1
                        THEN 1
                    WHEN NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion_2 AS a
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf_2
                WHERE
                    mandant_id = 1
            ) AS b
                ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
            WHERE
                a.mandant_id = 1
                AND (
                    a.preisaktiviert_fg = 1 OR NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                )
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_2 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 4
        INNER JOIN dbp_data.tag_2 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 3
                AND DATE_SUB(x2.dat, INTERVAL '6' DAY) = x1.dat
        WHERE
            akt.mandant_id = 1
            AND x1.akt_wo = wkw
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 2) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_2`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );

    INSERT INTO `_werbeartikel_1_2` (
        kjwo,
        werbetyp_id,
        aktion_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        avq_relevant_fg,
        dat_sperrung
    )
    (
        SELECT
            x1.kjwo,
            3 AS werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(
                CASE
                    WHEN akta.dat_sperrung IS NULL OR akta.dat_sperrung >= akt.dat_von
                        THEN akt.avq_relevant_fg
                    ELSE 0
                END
            ) AS avq_relevant_fg,
            MAX(COALESCE(akta.dat_sperrung, CAST('9999-12-31' AS DATE))) AS dat_sperrung
        FROM (
            SELECT
                a.aktion_id,
                a.mandant_id,
                a.bewart_id,
                a.aktionsart_id,
                a.werbe_kat_id,
                a.dat_von,
                a.dat_bis,
                a.preisaktiviert_fg,
                a.kjwo_von,
                a.aktion_typ_id,
                a.td_update,
                a.td_insert,
                CASE
                    WHEN a.preisaktiviert_fg = 1
                        THEN 1
                    WHEN NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion_2 AS a
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf_2
                WHERE
                    mandant_id = 1
            ) AS b
                ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
            WHERE
                a.mandant_id = 1
                AND (
                    a.preisaktiviert_fg = 1 OR NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                )
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_2 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 1
        INNER JOIN dbp_data.tag_2 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 3
                AND DATE_SUB(x2.dat, INTERVAL '2' DAY) = x1.dat
        WHERE
            akt.mandant_id = 1
            AND x1.akt_wo = wkw
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 3) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_2`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );

    INSERT INTO `_werbeartikel_1_2` (
        kjwo,
        werbetyp_id,
        aktion_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        avq_relevant_fg,
        dat_sperrung
    )
    (
        SELECT
            x2.kjwo,
            3 AS werbetyp_id,
            akta.aktion_id,
            DATE_ADD(akt.dat_von, INTERVAL '1' DAY) AS dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x2.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(
                CASE
                    WHEN akta.dat_sperrung IS NULL OR akta.dat_sperrung >= akt.dat_von
                        THEN akt.avq_relevant_fg
                    ELSE 0
                END
            ) AS avq_relevant_fg,
            MAX(COALESCE(akta.dat_sperrung, CAST('9999-12-31' AS DATE))) AS dat_sperrung
        FROM (
            SELECT
                a.aktion_id,
                a.mandant_id,
                a.bewart_id,
                a.aktionsart_id,
                a.werbe_kat_id,
                a.dat_von,
                a.dat_bis,
                a.preisaktiviert_fg,
                a.kjwo_von,
                a.aktion_typ_id,
                a.td_update,
                a.td_insert,
                CASE
                    WHEN a.preisaktiviert_fg = 1
                        THEN 1
                    WHEN NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion_2 AS a
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf_2
                WHERE
                    mandant_id = 1
            ) AS b
                ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
            WHERE
                a.mandant_id = 1
                AND (
                    a.preisaktiviert_fg = 1 OR NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                )
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_2 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 7 AND x1.akt_wo = wkw - 1
        INNER JOIN dbp_data.tag_2 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 3
                AND DATE_SUB(x2.dat, INTERVAL '3' DAY) = x1.dat
                AND x2.akt_wo = wkw
        WHERE
            akt.mandant_id = 1
            AND x1.akt_wo = wkw - 1
            AND /* Filter auf regulaere Wochenstartaktionen! Korrekturaktionen zu der Standardwerbewoche werden ausgespart! */ akta.aktion_thema_id /* 04.10.2017, -dbay- */ IN ('1072', '1075', '1310', '4001', '1300', '1311', '1312', '1320', '1330')
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 3) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_2`
            )
        GROUP BY
            x2.kjwo,
            werbetyp_id,
            akta.aktion_id,
            dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x2.akt_wo,
            vk_brutto,
            mutter_wb_id
    );

    INSERT INTO `_werbeartikel_1_2` (
        kjwo,
        werbetyp_id,
        aktion_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        avq_relevant_fg,
        dat_sperrung
    )
    (
        SELECT
            x1.kjwo,
            c.werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(
                CASE
                    WHEN akta.dat_sperrung IS NULL OR akta.dat_sperrung >= akt.dat_von
                        THEN akt.avq_relevant_fg
                    ELSE 0
                END
            ) AS avq_relevant_fg,
            MAX(COALESCE(akta.dat_sperrung, CAST('9999-12-31' AS DATE))) AS dat_sperrung
        FROM (
            SELECT
                a.aktion_id,
                a.mandant_id,
                a.bewart_id,
                a.aktionsart_id,
                a.werbe_kat_id,
                a.dat_von,
                a.dat_bis,
                a.preisaktiviert_fg,
                a.kjwo_von,
                a.aktion_typ_id,
                a.td_update,
                a.td_insert,
                CASE
                    WHEN a.preisaktiviert_fg = 1
                        THEN 1
                    WHEN NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion_2 AS a
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf_2
                WHERE
                    mandant_id = 1
            ) AS b
                ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
            WHERE
                a.mandant_id = 1
                AND (
                    a.preisaktiviert_fg = 1 OR NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                )
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN (
            SELECT
                mandant_id,
                dat_von,
                dat_bis,
                werbe_typ_id AS werbetyp_id
            FROM dbp_data.ts_avq_werbezeitraum_abw_2
            WHERE
                mandant_id = 1
        ) AS c
            ON
                akt.mandant_id = c.mandant_id
                AND akt.dat_von = c.dat_von
                AND akt.dat_bis = c.dat_bis
        INNER JOIN dbp_data.tag_2 AS x1
            ON akt.dat_von = x1.dat
        WHERE
            akt.mandant_id = 1
            AND x1.akt_wo = wkw
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, c.werbetyp_id) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_2`
            )
        GROUP BY
            x1.kjwo,
            c.werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );

    INSERT INTO `_werbeartikel_1_2` (
        kjwo,
        werbetyp_id,
        aktion_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        avq_relevant_fg,
        dat_sperrung
    )
    (
        SELECT
            x1.kjwo,
            15 AS werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(
                CASE
                    WHEN akta.dat_sperrung IS NULL OR akta.dat_sperrung >= akt.dat_von
                        THEN akt.avq_relevant_fg
                    ELSE 0
                END
            ) AS avq_relevant_fg,
            MAX(COALESCE(akta.dat_sperrung, CAST('9999-12-31' AS DATE))) AS dat_sperrung
        FROM (
            SELECT
                a.aktion_id,
                a.mandant_id,
                a.bewart_id,
                a.aktionsart_id,
                a.werbe_kat_id,
                a.dat_von,
                a.dat_bis,
                a.preisaktiviert_fg,
                a.kjwo_von,
                a.aktion_typ_id,
                a.td_update,
                a.td_insert,
                CASE
                    WHEN a.preisaktiviert_fg = 1
                        THEN 1
                    WHEN NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion_2 AS a
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf_2
                WHERE
                    mandant_id = 1
            ) AS b
                ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
            WHERE
                a.mandant_id = 1
                AND (
                    a.preisaktiviert_fg = 1 OR NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                )
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_2 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 4
        INNER JOIN dbp_data.tag_2 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 6
                AND DATE_SUB(x2.dat, INTERVAL '9' DAY) = x1.dat
        WHERE
            akt.mandant_id = 1
            AND x1.akt_wo = wkw
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 15) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_2`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );

    INSERT INTO `_werbeartikel_1_2` (
        kjwo,
        werbetyp_id,
        aktion_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        avq_relevant_fg,
        dat_sperrung
    )
    (
        SELECT
            x1.kjwo,
            16 AS werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(
                CASE
                    WHEN akta.dat_sperrung IS NULL OR akta.dat_sperrung >= akt.dat_von
                        THEN akt.avq_relevant_fg
                    ELSE 0
                END
            ) AS avq_relevant_fg,
            MAX(COALESCE(akta.dat_sperrung, CAST('9999-12-31' AS DATE))) AS dat_sperrung
        FROM (
            SELECT
                a.aktion_id,
                a.mandant_id,
                a.bewart_id,
                a.aktionsart_id,
                a.werbe_kat_id,
                a.dat_von,
                a.dat_bis,
                a.preisaktiviert_fg,
                a.kjwo_von,
                a.aktion_typ_id,
                a.td_update,
                a.td_insert,
                CASE
                    WHEN a.preisaktiviert_fg = 1
                        THEN 1
                    WHEN NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion_2 AS a
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf_2
                WHERE
                    mandant_id = 1
            ) AS b
                ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
            WHERE
                a.mandant_id = 1
                AND (
                    a.preisaktiviert_fg = 1 OR NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                )
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_2 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 6
        INNER JOIN dbp_data.tag_2 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 6
                AND DATE_SUB(x2.dat, INTERVAL '0' DAY) = x1.dat
        WHERE
            akt.mandant_id = 1
            AND x1.akt_wo = wkw
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 16) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_2`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );

    INSERT INTO `_werbeartikel_1_2` (
        kjwo,
        werbetyp_id,
        aktion_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        avq_relevant_fg,
        dat_sperrung
    )
    (
        SELECT
            x1.kjwo,
            18 AS werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(
                CASE
                    WHEN akta.dat_sperrung IS NULL OR akta.dat_sperrung >= akt.dat_von
                        THEN akt.avq_relevant_fg
                    ELSE 0
                END
            ) AS avq_relevant_fg,
            MAX(COALESCE(akta.dat_sperrung, CAST('9999-12-31' AS DATE))) AS dat_sperrung
        FROM (
            SELECT
                a.aktion_id,
                a.mandant_id,
                a.bewart_id,
                a.aktionsart_id,
                a.werbe_kat_id,
                a.dat_von,
                a.dat_bis,
                a.preisaktiviert_fg,
                a.kjwo_von,
                a.aktion_typ_id,
                a.td_update,
                a.td_insert,
                CASE
                    WHEN a.preisaktiviert_fg = 1
                        THEN 1
                    WHEN NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion_2 AS a
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf_2
                WHERE
                    mandant_id = 1
            ) AS b
                ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
            WHERE
                a.mandant_id = 1
                AND (
                    a.preisaktiviert_fg = 1 OR NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                )
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_2 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 5
        INNER JOIN dbp_data.tag_2 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 6
                AND DATE_SUB(x2.dat, INTERVAL '1' DAY) = x1.dat
        WHERE
            akt.mandant_id = 1
            AND x1.akt_wo = wkw
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 18) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_2`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );

    /* Ein-Tag_2-Montagswerbung */
    INSERT INTO `_werbeartikel_1_2` (
        kjwo,
        werbetyp_id,
        aktion_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        avq_relevant_fg,
        dat_sperrung
    )
    (
        SELECT
            x1.kjwo,
            25 AS werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(
                CASE
                    WHEN akta.dat_sperrung IS NULL OR akta.dat_sperrung >= akt.dat_von
                        THEN akt.avq_relevant_fg
                    ELSE 0
                END
            ) AS avq_relevant_fg,
            MAX(COALESCE(akta.dat_sperrung, CAST('9999-12-31' AS DATE))) AS dat_sperrung
        FROM (
            SELECT
                a.aktion_id,
                a.mandant_id,
                a.bewart_id,
                a.aktionsart_id,
                a.werbe_kat_id,
                a.dat_von,
                a.dat_bis,
                a.preisaktiviert_fg,
                a.kjwo_von,
                a.aktion_typ_id,
                a.td_update,
                a.td_insert,
                CASE
                    WHEN a.preisaktiviert_fg = 1
                        THEN 1
                    WHEN NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion_2 AS a
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf_2
                WHERE
                    mandant_id = 1
            ) AS b
                ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
            WHERE
                a.mandant_id = 1
                AND (
                    a.preisaktiviert_fg = 1 OR NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                )
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_2 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 1
        INNER JOIN dbp_data.tag_2 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 1
                AND DATE_SUB(x2.dat, INTERVAL '0' DAY) = x1.dat
        WHERE
            akt.mandant_id = 1
            AND x1.akt_wo = wkw
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 25) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_2`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );

    /* Ein-Tag_2-Dienstagswerbung */
    INSERT INTO `_werbeartikel_1_2` (
        kjwo,
        werbetyp_id,
        aktion_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        avq_relevant_fg,
        dat_sperrung
    )
    (
        SELECT
            x1.kjwo,
            26 AS werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(
                CASE
                    WHEN akta.dat_sperrung IS NULL OR akta.dat_sperrung >= akt.dat_von
                        THEN akt.avq_relevant_fg
                    ELSE 0
                END
            ) AS avq_relevant_fg,
            MAX(COALESCE(akta.dat_sperrung, CAST('9999-12-31' AS DATE))) AS dat_sperrung
        FROM (
            SELECT
                a.aktion_id,
                a.mandant_id,
                a.bewart_id,
                a.aktionsart_id,
                a.werbe_kat_id,
                a.dat_von,
                a.dat_bis,
                a.preisaktiviert_fg,
                a.kjwo_von,
                a.aktion_typ_id,
                a.td_update,
                a.td_insert,
                CASE
                    WHEN a.preisaktiviert_fg = 1
                        THEN 1
                    WHEN NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion_2 AS a
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf_2
                WHERE
                    mandant_id = 1
            ) AS b
                ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
            WHERE
                a.mandant_id = 1
                AND (
                    a.preisaktiviert_fg = 1 OR NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                )
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_2 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 2
        INNER JOIN dbp_data.tag_2 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 2
                AND DATE_SUB(x2.dat, INTERVAL '0' DAY) = x1.dat
        WHERE
            akt.mandant_id = 1
            AND x1.akt_wo = wkw
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 26) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_2`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );

    /* Ein-Tag_2-Mittwochswerbung */
    INSERT INTO `_werbeartikel_1_2` (
        kjwo,
        werbetyp_id,
        aktion_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        avq_relevant_fg,
        dat_sperrung
    )
    (
        SELECT
            x1.kjwo,
            27 AS werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(
                CASE
                    WHEN akta.dat_sperrung IS NULL OR akta.dat_sperrung >= akt.dat_von
                        THEN akt.avq_relevant_fg
                    ELSE 0
                END
            ) AS avq_relevant_fg,
            MAX(COALESCE(akta.dat_sperrung, CAST('9999-12-31' AS DATE))) AS dat_sperrung
        FROM (
            SELECT
                a.aktion_id,
                a.mandant_id,
                a.bewart_id,
                a.aktionsart_id,
                a.werbe_kat_id,
                a.dat_von,
                a.dat_bis,
                a.preisaktiviert_fg,
                a.kjwo_von,
                a.aktion_typ_id,
                a.td_update,
                a.td_insert,
                CASE
                    WHEN a.preisaktiviert_fg = 1
                        THEN 1
                    WHEN NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion_2 AS a
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf_2
                WHERE
                    mandant_id = 1
            ) AS b
                ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
            WHERE
                a.mandant_id = 1
                AND (
                    a.preisaktiviert_fg = 1 OR NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                )
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_2 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 3
        INNER JOIN dbp_data.tag_2 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 3
                AND DATE_SUB(x2.dat, INTERVAL '0' DAY) = x1.dat
        WHERE
            akt.mandant_id = 1
            AND x1.akt_wo = wkw
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 27) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_2`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );

    /* Ein-Tag_2-Freitagswerbung */
    INSERT INTO `_werbeartikel_1_2` (
        kjwo,
        werbetyp_id,
        aktion_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        avq_relevant_fg,
        dat_sperrung
    )
    (
        SELECT
            x1.kjwo,
            28 AS werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(
                CASE
                    WHEN akta.dat_sperrung IS NULL OR akta.dat_sperrung >= akt.dat_von
                        THEN akt.avq_relevant_fg
                    ELSE 0
                END
            ) AS avq_relevant_fg,
            MAX(COALESCE(akta.dat_sperrung, CAST('9999-12-31' AS DATE))) AS dat_sperrung
        FROM (
            SELECT
                a.aktion_id,
                a.mandant_id,
                a.bewart_id,
                a.aktionsart_id,
                a.werbe_kat_id,
                a.dat_von,
                a.dat_bis,
                a.preisaktiviert_fg,
                a.kjwo_von,
                a.aktion_typ_id,
                a.td_update,
                a.td_insert,
                CASE
                    WHEN a.preisaktiviert_fg = 1
                        THEN 1
                    WHEN NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion_2 AS a
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf_2
                WHERE
                    mandant_id = 1
            ) AS b
                ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
            WHERE
                a.mandant_id = 1
                AND (
                    a.preisaktiviert_fg = 1 OR NOT b.bonuskauf_id IS NULL AND a.preisaktiviert_fg = 0
                )
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_2 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 5
        INNER JOIN dbp_data.tag_2 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 5
                AND DATE_SUB(x2.dat, INTERVAL '0' DAY) = x1.dat
        WHERE
            akt.mandant_id = 1
            AND x1.akt_wo = wkw
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 28) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_2`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akta.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );

    CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art AS
    SELECT
        mandant_id,
        art_id,
        COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
    FROM dbp_data.art_2 AS a
    WHERE
        dat_bis = CAST('9999-12-31' AS DATE)
        AND (mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM `_werbeartikel_1_2`
            GROUP BY
                mandant_id,
            art_id
        )
    GROUP BY
        mandant_id,
        art_id,
        a.mutter_wb_id;

    UPDATE `_werbeartikel_1_2` SET mutter_wb_id = b.mutter_wb_id
    FROM `_ff_mutter_art` AS b
    WHERE
        `_werbeartikel_1_2`.mandant_id = b.mandant_id
        AND `_werbeartikel_1_2`.art_id = b.art_id
        AND `_werbeartikel_1_2`.mutter_wb_id = -999;

    UPDATE `_werbeartikel_1_2` SET mutter_wb_id = `_werbeartikel_1_2`.art_id
    WHERE
        mutter_wb_id = -999;

    CREATE OR REPLACE TEMPORARY TABLE _pp AS
    SELECT
        kjwo,
        werbetyp_id,
        aktion_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        avq_relevant_fg,
        dat_sperrung,
        0 AS vk_vor_aktion_brutto,
        0 AS vk_aktion_brutto,
        0 AS vk_kcard_brutto
    FROM `_werbeartikel_1_2` AS a;

    CREATE OR REPLACE TEMPORARY TABLE `_werbeartikel_1_2` AS
    SELECT *
    FROM `_pp`;

    UPDATE `_werbeartikel_1_2` SET vk_brutto = b.vk_brutto
    FROM (
        SELECT
            a.art_id,
            a.mandant_id,
            a.wup_id,
            MAX(a.vk_brutto) AS vk_brutto
        FROM dbp_data.art_wup_vk_per_2 AS a
        INNER JOIN `_werbeartikel_1_2` AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.art_id = b.art_id
                AND a.wup_id = b.wup_id
                AND b.dat_von BETWEEN a.dat_von AND a.dat_bis
        GROUP BY
            a.art_id,
            a.mandant_id,
            a.wup_id
    ) AS b
    WHERE
        `_werbeartikel_1_2`.mandant_id = b.mandant_id
        AND `_werbeartikel_1_2`.wup_id = b.wup_id
        AND `_werbeartikel_1_2`.art_id = b.art_id;

    UPDATE `_werbeartikel_1_2` SET vk_vor_aktion_brutto = CAST(b.vk_vor_aktion_brutto AS INT64), vk_aktion_brutto = CAST(b.vk_vor_aktion_brutto AS INT64)
    FROM (
        SELECT
            a.art_id,
            a.mandant_id,
            a.wup_id,
            b.werbetyp_id,
            MAX(a.vk_vor_aktion_brutto) AS vk_vor_aktion_brutto,
            MIN(
                CASE
                    WHEN a.vk_aktion_brutto > 0
                        THEN a.vk_aktion_brutto
                    ELSE a.vk_vor_aktion_brutto
                END
            ) AS vk_aktion_brutto
        FROM dbp_data.aktion_2 AS c
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS a
            ON c.mandant_id = a.mandant_id AND c.aktion_id = a.aktion_id
        INNER JOIN `_werbeartikel_1_2` AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.art_id = b.art_id
                AND a.wup_id = b.wup_id
                AND b.dat_von BETWEEN c.dat_von AND c.dat_bis
        GROUP BY
            a.art_id,
            a.mandant_id,
            a.wup_id,
            b.werbetyp_id
    ) AS b
    WHERE
        `_werbeartikel_1_2`.mandant_id = b.mandant_id
        AND `_werbeartikel_1_2`.wup_id = b.wup_id
        AND `_werbeartikel_1_2`.art_id = b.art_id
        AND `_werbeartikel_1_2`.werbetyp_id = b.werbetyp_id;

    UPDATE `_werbeartikel_1_2` SET vk_kcard_brutto = CAST(b.vk_kcard_brutto AS INT64)
    FROM (
        SELECT
            a.art_id,
            a.mandant_id,
            a.wup_id,
            b.werbetyp_id,
            MIN(d.preis_aktion) AS vk_kcard_brutto
        FROM dbp_data.aktion_2 AS c
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS a
            ON c.mandant_id = a.mandant_id AND c.aktion_id = a.aktion_id
        INNER JOIN dbp_data.pmr_angebot_art_wup_zu_2 AS d
            ON
                0 <> a.mandant_id
                AND 0 <> d.mandant_id
                AND a.wup_id = d.wup_id
                AND a.art_id = d.art_id
                AND a.aktion_id = d.aktion_id
        INNER JOIN `_werbeartikel_1_2` AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.art_id = b.art_id
                AND a.wup_id = b.wup_id
                AND c.dat_von = b.dat_von
                AND c.dat_bis = b.dat_bis
        WHERE
            d.preis_aktion <> 0 AND c.aktion_typ_id <> 'KDP'
        GROUP BY
            a.mandant_id,
            a.art_id,
            a.wup_id,
            b.werbetyp_id
    ) AS b
    WHERE
        `_werbeartikel_1_2`.mandant_id = b.mandant_id
        AND `_werbeartikel_1_2`.wup_id = b.wup_id
        AND `_werbeartikel_1_2`.art_id = b.art_id
        AND `_werbeartikel_1_2`.werbetyp_id = b.werbetyp_id;

    DELETE FROM `_werbeartikel_1_2`
    WHERE
        wup_id IN (
            SELECT wup_id
            FROM dbp_data.wup_2
            WHERE
                mandant_id = 1 AND wup_name_v LIKE '%online%'
        );

    CREATE OR REPLACE TEMPORARY TABLE `_werbeartikel_1_2` AS
    SELECT
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id,
        MAX(avq_relevant_fg) AS avq_relevant_fg,
        MAX(dat_sperrung) AS dat_sperrung,
        MAX(vk_vor_aktion_brutto) AS vk_vor_aktion_brutto,
        MAX(vk_aktion_brutto) AS vk_aktion_brutto,
        MAX(vk_kcard_brutto) AS vk_kcard_brutto
    FROM `_werbeartikel_1_2` AS a
    GROUP BY
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        mutter_wb_id;

    /* kunftige und abgeschlossene aktionen volle anzahl tage */
    CREATE OR REPLACE TEMPORARY TABLE _werbetyp_tage AS
    SELECT
        mandant_id,
        werbetyp_id,
        CASE
            WHEN dat_von >= CURRENT_DATE("Europe/Berlin") OR dat_bis < CURRENT_DATE("Europe/Berlin")
                THEN DATE_DIFF(dat_bis, dat_von, DAY) + 1 /* laufende aktionen anzahl tage start bis heute */
            ELSE DATE_DIFF(CURRENT_DATE("Europe/Berlin"), dat_von, DAY)
        END AS anz_tage_aktion
    FROM `_werbeartikel_1_2` AS b
    GROUP BY
        mandant_id,
        werbetyp_id,
        anz_tage_aktion;

    CREATE OR REPLACE TEMPORARY TABLE _die_tage AS
    SELECT
        b.mandant_id,
        a.dat
    FROM dbp_data.tag_2 AS a
    INNER JOIN `_werbeartikel_1_2` AS b
        ON a.dat BETWEEN b.dat_von AND b.dat_bis
    GROUP BY
        b.mandant_id,
        a.dat;

    CREATE OR REPLACE TEMPORARY TABLE _test1_ff AS
    SELECT
        w.kjwo,
        w.werbetyp_id,
        CASE
            WHEN w.werbetyp_id = 1
                THEN DATE_ADD(w.dat_von, INTERVAL '1' DAY)
            ELSE w.dat_von
        END AS dat_von,
        w.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id,
        SUM(v.umsatz_netto) AS umsatz_netto,
        SUM(v.menge) AS menge_,
        6 - COUNT(DISTINCT v.dat) AS tage_menge_0
    FROM dbp_data.artbew_2 AS v
    INNER JOIN `_werbeartikel_1_2` AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.dat BETWEEN w.dat_von AND w.dat_bis
    WHERE
        (v.mandant_id, v.dat) IN (
            SELECT (mandant_id, dat)
            FROM `_die_tage`
        )
    GROUP BY
        w.kjwo,
        w.werbetyp_id,
        dat_von,
        w.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id
    HAVING
        menge_ > 0;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we1 AS
    SELECT
        a.mandant_id,
        a.kjwo,
        a.dat_von,
        a.dat_bis,
        a.werbetyp_id,
        a.wup_id,
        a.nb_id,
        a.art_id
    FROM `_test1_ff` AS a
    INNER JOIN dbp_data.art_wg_zu_per_2 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.art_id = b.art_id
            AND b.arthiertyp_id = 2
            AND b.dat_bis = CAST('9999-12-31' AS DATE);

    CREATE OR REPLACE TEMPORARY TABLE _ff_we2 AS
    SELECT
        a.mandant_id,
        a.kjwo,
        a.dat_von,
        a.dat_bis,
        a.werbetyp_id,
        a.wup_id,
        a.nb_id,
        a.art_id,
        b.dat,
        b.dat_2
    FROM `_ff_we1` AS a
    INNER JOIN (
        SELECT
            a0.kjwo,
            a0.werbetyp_id,
            CASE WHEN b.dat BETWEEN a0.dat_von AND a0.dat_bis THEN b.dat ELSE NULL END AS dat,
            CASE WHEN NOT b.dat BETWEEN a0.dat_von AND a0.dat_bis THEN b.dat ELSE NULL END AS dat_2
        FROM `_ff_we1` AS a0
        INNER JOIN dbp_data.tag_2 AS b
            ON b.dat BETWEEN DATE_SUB(a0.dat_von, INTERVAL '7' DAY) AND a0.dat_bis
        GROUP BY
            a0.kjwo,
            a0.werbetyp_id,
            dat,
            dat_2
    ) AS b
        ON a.kjwo = b.kjwo AND a.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _track_feuerwerk AS
    SELECT
        a.mandant_id,
        a.art_id
    FROM `_ff_we2` AS a
    INNER JOIN dbp_data.art_wg_zu_per_2 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.art_id = b.art_id
            AND b.arthiertyp_id = 2
            AND b.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        b.wg_id = 805
    GROUP BY
        a.mandant_id,
        a.art_id;

    DELETE FROM `_ff_we2`
    WHERE
        (mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM `_track_feuerwerk`
        )
        AND dat IS NULL;

    INSERT INTO `_ff_we2`
    (
        SELECT
            a.mandant_id,
            a.kjwo,
            a.dat_von,
            a.dat_bis,
            a.werbetyp_id,
            a.wup_id,
            a.nb_id,
            a.art_id,
            CAST(CAST(NULL AS STRING) AS DATE) AS dat,
            c.dat AS dat_2
        FROM `_ff_we2` AS a
        INNER JOIN `_track_feuerwerk` AS b
            ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id
        INNER JOIN dbp_data.tag_2 AS c
            ON TRUE
        WHERE
            NOT a.dat IS NULL
            AND c.dat BETWEEN DATE_SUB(a.dat_von, INTERVAL '45' DAY) AND (
                DATE_SUB(a.dat_von, INTERVAL '1' DAY)
            )
        GROUP BY
            a.mandant_id,
            a.kjwo,
            a.dat_von,
            a.dat_bis,
            a.werbetyp_id,
            a.wup_id,
            a.nb_id,
            a.art_id,
            dat,
            dat_2
    );

    CREATE OR REPLACE TEMPORARY TABLE _ff_we3 AS
    SELECT
        a.mandant_id,
        a.werbetyp_id,
        a.dat_von,
        a.dat_bis,
        a.kjwo,
        COALESCE(a.dat, a.dat_2) AS dat,
        a.wup_id,
        a.nb_id,
        a.art_id,
        COALESCE(b.menge_lagerbew_bme, 0) AS we_menge,
        COALESCE(c.menge_lagerbew_bme, 0) AS we_menge_2
    FROM `_ff_we2` AS a
    LEFT JOIN (
        SELECT
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            b.dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS a
        INNER JOIN dbp_data.lagerbew_det_2 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2`
            WHERE
                NOT dat IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_2 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_2 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id = 'WE'
            AND CASE
                WHEN
                    b.dat_buch < CAST('2020-02-01' AS DATE)
                    AND c1.bestellart_id IN (
                        'ZLNS',
                        'ZLN',
                        'UBE',
                        'ZDZA',
                        'ZLLA',
                        'ZLA',
                        'ZLAS',
                        'ZAME',
                        'ZWRP',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'ZWWL',
                        'UBPX'
                    )
                    OR b.dat_buch >= CAST('2020-02-01' AS DATE)
                    AND c1.bestellart_id IN (
                        'UBE',
                        'ZDZA',
                        'ZLLA',
                        'ZLA',
                        'ZLAS',
                        'ZAME',
                        'ZWRP',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'ZWWL',
                        'UBPX'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND a.mandant_id = 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu_2
                WHERE
                    mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
            )
            AND NOT x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 25 AND mandant_id = 1
            )
        GROUP BY
            b.mandant_id,
            b.art_id,
            b.wup_id,
            b.dat_buch,
            c.werbetyp_id
        UNION ALL
        SELECT
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            b.dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS a
        INNER JOIN dbp_data.lagerbew_det_2 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2`
            WHERE
                NOT dat IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_2 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_2 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id = 'WE'
            AND x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 25 AND mandant_id = 1
            )
            AND a.mandant_id = 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu_2
                WHERE
                    mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
            )
        GROUP BY
            b.mandant_id,
            b.art_id,
            b.wup_id,
            b.dat_buch,
            c.werbetyp_id
    ) AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.wup_id = b.wup_id
            AND a.art_id = b.art_id
            AND a.dat = b.dat_buch
            AND a.werbetyp_id = b.werbetyp_id
    LEFT JOIN (
        SELECT
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            b.dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS a
        INNER JOIN dbp_data.lagerbew_det_2 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2`
            WHERE
                NOT dat_2 IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_2 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_2 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id = 'WE'
            AND CASE
                WHEN
                    b.dat_buch < CAST('2020-02-01' AS DATE)
                    AND c1.bestellart_id IN (
                        'ZLNS',
                        'ZLN',
                        'UBE',
                        'ZDZA',
                        'ZLLA',
                        'ZLA',
                        'ZLAS',
                        'ZAME',
                        'ZWRP',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'ZWWL',
                        'UBPX'
                    )
                    OR b.dat_buch >= CAST('2020-02-01' AS DATE)
                    AND c1.bestellart_id IN (
                        'UBE',
                        'ZDZA',
                        'ZLLA',
                        'ZLA',
                        'ZLAS',
                        'ZAME',
                        'ZWRP',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'ZWWL',
                        'UBPX'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND a.mandant_id = 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu_2
                WHERE
                    mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
            )
            AND NOT x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 25 AND mandant_id = 1
            )
        GROUP BY
            b.mandant_id,
            b.art_id,
            b.wup_id,
            b.dat_buch,
            c.werbetyp_id
        UNION ALL
        SELECT
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            b.dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS a
        INNER JOIN dbp_data.lagerbew_det_2 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2`
            WHERE
                NOT dat_2 IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_2 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_2 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id = 'WE'
            AND x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 25 AND mandant_id = 1
            )
            AND a.mandant_id = 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu_2
                WHERE
                    mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
            )
        GROUP BY
            b.mandant_id,
            b.art_id,
            b.wup_id,
            b.dat_buch,
            c.werbetyp_id
        UNION ALL
        SELECT
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            DATE_SUB(c.dat_2, INTERVAL '7' DAY) AS dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS a
        INNER JOIN dbp_data.lagerbew_det_2 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2`
            WHERE
                NOT dat_2 IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = DATE_SUB(c.dat_2, INTERVAL '7' DAY)
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_2 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_2 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id = 'WE'
            AND CASE
                WHEN
                    b.dat_buch < CAST('2020-02-01' AS DATE)
                    AND c1.bestellart_id IN (
                        'ZLNS',
                        'ZLN',
                        'UBE',
                        'ZDZA',
                        'ZLLA',
                        'ZLA',
                        'ZLAS',
                        'ZAME',
                        'ZWRP',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'ZWWL',
                        'UBPX'
                    )
                    OR b.dat_buch >= CAST('2020-02-01' AS DATE)
                    AND c1.bestellart_id IN (
                        'UBE',
                        'ZDZA',
                        'ZLLA',
                        'ZLA',
                        'ZLAS',
                        'ZAME',
                        'ZWRP',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'ZWWL',
                        'UBPX'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 30 AND mandant_id = 1
            )
            AND /* NONFOOD */ a.mandant_id = 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu_2
                WHERE
                    mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
            )
        GROUP BY
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            dat_buch
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_2 = c.dat_buch
            AND a.werbetyp_id = c.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _stpo AS
    SELECT
        mandant_id,
        stueckliste_id,
        art_id AS kopf_art
    FROM dbp_data.stueckliste_2 AS a
    WHERE
        dat_bis = CAST('9999-12-31' AS DATE) AND mandant_id = 1
    GROUP BY
        mandant_id,
        stueckliste_id,
        kopf_art;

    CREATE OR REPLACE TEMPORARY TABLE _x_ray AS
    SELECT
        a.mandant_id,
        a.wup_id,
        a.werbetyp_id,
        b.kopf_art AS art_id,
        a.dat,
        a.dat_2
    FROM (
        SELECT
            mandant_id,
            wup_id,
            werbetyp_id,
            dat,
            dat_2
        FROM `_ff_we2`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            dat,
            dat_2
    ) AS a
    INNER JOIN (
        SELECT kopf_art
        FROM `_stpo`
        GROUP BY
            kopf_art
    ) AS b
        ON TRUE;

    CREATE OR REPLACE TEMPORARY TABLE _help_me1 AS
    SELECT
        mandant_id,
        dat
    FROM `_x_ray`
    WHERE
        NOT dat IS NULL
    GROUP BY
        mandant_id,
        dat;

    CREATE OR REPLACE TEMPORARY TABLE _help_me2 AS
    SELECT
        mandant_id,
        dat_2
    FROM `_x_ray`
    WHERE
        NOT dat_2 IS NULL
    GROUP BY
        mandant_id,
        dat_2;

    CREATE OR REPLACE TEMPORARY TABLE _mseg_package_ekpo AS
    SELECT
        b.mandant_id,
        b.lagerbew_beleg_id,
        b.lagerbew_beleg_pos_id,
        b.kj,
        b.grund_id,
        b.lager_bewart_id,
        b.art_id,
        b.wup_id,
        b.nb_id,
        b.auto_fg,
        b.lagerort_id,
        b.gp_id,
        b.einkaufsorganisation_id,
        b.soll_haben_kz,
        b.wrg_id,
        b.best_beleg_id,
        b.best_beleg_pos_id,
        b.betrag_lagerbew,
        b.betrag_verkauf,
        b.erfsngs_menge_einh_id,
        b.lagerplatz_id,
        b.kunde_id,
        b.menge_lagerbew_kolli,
        b.menge_lagerbew_bme,
        b.menge_lagerbew_palette,
        b.menge_lieferschein,
        b.menge_lief,
        b.menge_erf,
        b.empfaenger_id,
        b.dat_buch,
        b.lagerbew_beleg_storno_id,
        b.lagerbew_beleg_pos_storno_id,
        b.lagerbew_beleg_storno_kj,
        b.betrag_vk_netto,
        b.system_id,
        b.betrag_belegfluss_wg_art,
        b.mandant_id_kunde,
        b.mandant_id_empfaenger,
        b.bw_vorgang_id,
        b.betrag_verkauf_ist,
        b.betrag_vk_netto_vz,
        b.betrag_verkauf_ist_netto,
        b.betrag_einstandspreis,
        b.gp_id_zl,
        b.bq_findung_id,
        b.lagerbew_beleg_pos_mutter_id,
        b.line_id,
        b.display_art_id,
        b.td_update,
        b.td_insert
    FROM dbp_data.lagerbew_2 AS a
    INNER JOIN dbp_data.lagerbew_det_2 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
            AND a.dat_buch = b.dat_buch
    INNER JOIN dbp_data.besch_best_2 AS c1
        ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
    INNER JOIN dbp_data.besch_best_det_2 AS c2
        ON
            b.mandant_id = c2.mandant_id
            AND b.wup_id = c2.wup_id
            AND c1.dat_best_beleg = c2.dat_best_beleg
            AND b.best_beleg_id = c2.best_beleg_id
            AND b.best_beleg_pos_id = c2.best_beleg_pos_id
            AND b.art_id = c2.art_id
    WHERE
        a.vorgangsart_id = 'WE'
        AND CASE
            WHEN
                b.dat_buch < CAST('2020-02-01' AS DATE)
                AND c1.bestellart_id IN (
                    'ZLNS',
                    'ZLN',
                    'UBE',
                    'ZDZA',
                    'ZLLA',
                    'ZLA',
                    'ZLAS',
                    'ZAME',
                    'ZWRP',
                    'UBGK',
                    'UBG1',
                    'UBG2',
                    'ZWWL',
                    'UBPX'
                )
                OR b.dat_buch >= CAST('2020-02-01' AS DATE)
                AND c1.bestellart_id IN (
                    'UBE',
                    'ZDZA',
                    'ZLLA',
                    'ZLA',
                    'ZLAS',
                    'ZAME',
                    'ZWRP',
                    'UBGK',
                    'UBG1',
                    'UBG2',
                    'ZWWL',
                    'UBPX'
                )
                THEN 1
            ELSE 0
        END = 1
        AND a.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me1`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me2`
            ) AS t3
        )
        AND a.mandant_id = 1
        AND NOT b.lager_bewart_id IN (
            SELECT lager_bewart_id
            FROM dbp_data.lager_bewart_spr_zu_2
            WHERE
                mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
        );

    CREATE OR REPLACE TEMPORARY TABLE _mseg_package_not_ekpo AS
    SELECT
        b.mandant_id,
        b.lagerbew_beleg_id,
        b.lagerbew_beleg_pos_id,
        b.kj,
        b.grund_id,
        b.lager_bewart_id,
        b.art_id,
        b.wup_id,
        b.nb_id,
        b.auto_fg,
        b.lagerort_id,
        b.gp_id,
        b.einkaufsorganisation_id,
        b.soll_haben_kz,
        b.wrg_id,
        b.best_beleg_id,
        b.best_beleg_pos_id,
        b.betrag_lagerbew,
        b.betrag_verkauf,
        b.erfsngs_menge_einh_id,
        b.lagerplatz_id,
        b.kunde_id,
        b.menge_lagerbew_kolli,
        b.menge_lagerbew_bme,
        b.menge_lagerbew_palette,
        b.menge_lieferschein,
        b.menge_lief,
        b.menge_erf,
        b.empfaenger_id,
        b.dat_buch,
        b.lagerbew_beleg_storno_id,
        b.lagerbew_beleg_pos_storno_id,
        b.lagerbew_beleg_storno_kj,
        b.betrag_vk_netto,
        b.system_id,
        b.betrag_belegfluss_wg_art,
        b.mandant_id_kunde,
        b.mandant_id_empfaenger,
        b.bw_vorgang_id,
        b.betrag_verkauf_ist,
        b.betrag_vk_netto_vz,
        b.betrag_verkauf_ist_netto,
        b.betrag_einstandspreis,
        b.gp_id_zl,
        b.bq_findung_id,
        b.lagerbew_beleg_pos_mutter_id,
        b.line_id,
        b.display_art_id,
        b.td_update,
        b.td_insert
    FROM dbp_data.lagerbew_2 AS a
    INNER JOIN dbp_data.lagerbew_det_2 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
            AND a.dat_buch = b.dat_buch
    INNER JOIN dbp_data.besch_best_2 AS c1
        ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
    INNER JOIN dbp_data.besch_best_det_2 AS c2
        ON
            b.mandant_id = c2.mandant_id
            AND b.wup_id = c2.wup_id
            AND c1.dat_best_beleg = c2.dat_best_beleg
            AND b.best_beleg_id = c2.best_beleg_id
            AND b.best_beleg_pos_id = c2.best_beleg_pos_id
            AND b.art_id = c2.art_id
    WHERE
        a.vorgangsart_id = 'WE'
        AND a.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me1`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me2`
            ) AS t3
        )
        AND a.mandant_id = 1
        AND NOT b.lager_bewart_id IN (
            SELECT lager_bewart_id
            FROM dbp_data.lager_bewart_spr_zu_2
            WHERE
                mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
        );

    CREATE OR REPLACE TEMPORARY TABLE _x_track1 AS
    SELECT
        a.mandant_id,
        c.werbetyp_id,
        a.lagerbew_beleg_id,
        a.wup_id,
        a.art_id,
        a.dat_buch,
        SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_ekpo` AS a
    INNER JOIN (
        SELECT *
        FROM `_x_ray`
        WHERE
            NOT dat IS NULL
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat
    INNER JOIN dbp_data.art_wg_zu_per_2 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat)
            FROM `_help_me1`
        )
        AND NOT x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 25 AND mandant_id = 1
        )
    GROUP BY
        a.mandant_id,
        a.lagerbew_beleg_id,
        a.art_id,
        a.wup_id,
        a.dat_buch,
        c.werbetyp_id
    UNION ALL
    SELECT
        a.mandant_id,
        c.werbetyp_id,
        a.lagerbew_beleg_id,
        a.wup_id,
        a.art_id,
        a.dat_buch,
        SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_not_ekpo` AS a
    INNER JOIN (
        SELECT *
        FROM `_x_ray`
        WHERE
            NOT dat IS NULL
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat
    INNER JOIN dbp_data.art_wg_zu_per_2 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 25 AND mandant_id = 1
        )
        AND (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat)
            FROM `_help_me1`
        )
    GROUP BY
        a.mandant_id,
        a.lagerbew_beleg_id,
        a.art_id,
        a.wup_id,
        a.dat_buch,
        c.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _x_track2 AS
    SELECT
        a.mandant_id,
        c.werbetyp_id,
        a.lagerbew_beleg_id,
        a.wup_id,
        a.art_id,
        a.dat_buch,
        SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_ekpo` AS a
    INNER JOIN (
        SELECT *
        FROM `_x_ray`
        WHERE
            NOT dat_2 IS NULL
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per_2 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat_2)
            FROM `_help_me2`
        )
        AND NOT x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 25 AND mandant_id = 1
        )
    GROUP BY
        a.mandant_id,
        a.lagerbew_beleg_id,
        a.art_id,
        a.wup_id,
        a.dat_buch,
        c.werbetyp_id
    UNION ALL
    SELECT
        a.mandant_id,
        c.werbetyp_id,
        a.lagerbew_beleg_id,
        a.wup_id,
        a.art_id,
        a.dat_buch,
        SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_not_ekpo` AS a
    INNER JOIN (
        SELECT *
        FROM `_x_ray`
        WHERE
            NOT dat_2 IS NULL
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per_2 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 25 AND mandant_id = 1
        )
        AND (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat_2)
            FROM `_help_me2`
        )
    GROUP BY
        a.mandant_id,
        a.lagerbew_beleg_id,
        a.art_id,
        a.wup_id,
        a.dat_buch,
        c.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _display_update AS
    SELECT
        b.mandant_id,
        c.werbetyp_id,
        b.wup_id,
        b.art_id,
        b.dat_buch,
        SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM dbp_data.lagerbew_2 AS a
    INNER JOIN dbp_data.lagerbew_det_2 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
            AND a.dat_buch = b.dat_buch
    INNER JOIN (
        SELECT
            c.mandant_id,
            c.werbetyp_id,
            c.lagerbew_beleg_id,
            c.wup_id,
            b0.art_id,
            c.dat_buch
        FROM dbp_data.stueckliste_2 AS a0
        INNER JOIN dbp_data.stueckliste_det_2 AS b0
            ON a0.mandant_id = b0.mandant_id AND a0.stueckliste_id = b0.stueckliste_id
        INNER JOIN (
            SELECT
                a.mandant_id,
                a.werbetyp_id,
                c.lagerbew_beleg_id,
                a.wup_id,
                a.art_id,
                a.dat_buch
            FROM `_x_track1` AS a
            INNER JOIN dbp_data.lagerbew_2 AS b
                ON
                    a.mandant_id = b.mandant_id
                    AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                    AND a.dat_buch = b.dat_buch
            INNER JOIN dbp_data.lagerbew_2 AS c
                ON
                    a.mandant_id = c.mandant_id
                    AND b.ref_lagerbew_beleg_id = c.ref_lagerbew_beleg_id
                    AND b.dat_buch = c.dat_buch
            GROUP BY
                a.mandant_id,
                a.werbetyp_id,
                c.lagerbew_beleg_id,
                a.wup_id,
                a.art_id,
                a.dat_buch
            UNION ALL
            SELECT
                a.mandant_id,
                a.werbetyp_id,
                c.lagerbew_beleg_id,
                a.wup_id,
                a.art_id,
                a.dat_buch
            FROM `_x_track2` AS a
            INNER JOIN dbp_data.lagerbew_2 AS b
                ON
                    a.mandant_id = b.mandant_id
                    AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                    AND a.dat_buch = b.dat_buch
            INNER JOIN dbp_data.lagerbew_2 AS c
                ON
                    a.mandant_id = c.mandant_id
                    AND b.ref_lagerbew_beleg_id = c.ref_lagerbew_beleg_id
                    AND b.dat_buch = c.dat_buch
            GROUP BY
                a.mandant_id,
                a.werbetyp_id,
                c.lagerbew_beleg_id,
                a.wup_id,
                a.art_id,
                a.dat_buch
        ) AS c
            ON a0.mandant_id = c.mandant_id AND a0.art_id = c.art_id
        WHERE
            a0.dat_bis = CAST('9999-12-31' AS DATE)
        GROUP BY
            c.mandant_id,
            c.werbetyp_id,
            c.lagerbew_beleg_id,
            c.wup_id,
            b0.art_id,
            c.dat_buch
    ) AS c
        ON
            b.mandant_id = c.mandant_id
            AND b.wup_id = c.wup_id
            AND b.art_id = c.art_id
            AND b.dat_buch = c.dat_buch
            AND b.lagerbew_beleg_id = c.lagerbew_beleg_id
    WHERE
        a.vorgangsart_id IN ('WA', 'WE')
        AND NOT b.lager_bewart_id IN (
            SELECT lager_bewart_id
            FROM dbp_data.lager_bewart_spr_zu_2
            WHERE
                mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
        )
    GROUP BY
        b.mandant_id,
        c.werbetyp_id,
        b.wup_id,
        b.art_id,
        b.dat_buch;

    UPDATE `_ff_we3` SET we_menge = b.menge_lagerbew_bme + `_ff_we3`.we_menge
    FROM `_display_update` AS b
    WHERE
        `_ff_we3`.mandant_id = b.mandant_id
        AND `_ff_we3`.wup_id = b.wup_id
        AND `_ff_we3`.art_id = b.art_id
        AND `_ff_we3`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3`.dat = b.dat_buch
        AND `_ff_we3`.dat BETWEEN `_ff_we3`.dat_von AND `_ff_we3`.dat_bis;

    UPDATE `_ff_we3` SET we_menge_2 = b.menge_lagerbew_bme + `_ff_we3`.we_menge_2
    FROM `_display_update` AS b
    WHERE
        `_ff_we3`.mandant_id = b.mandant_id
        AND `_ff_we3`.wup_id = b.wup_id
        AND `_ff_we3`.art_id = b.art_id
        AND `_ff_we3`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3`.dat = b.dat_buch
        AND NOT `_ff_we3`.dat BETWEEN `_ff_we3`.dat_von AND `_ff_we3`.dat_bis;

    UPDATE `_ff_we3` SET we_menge_2 = 0
    FROM (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            DATE_SUB(a.dat_von, INTERVAL '3' DAY) AS min_dat
        FROM `_ff_we3` AS a
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                a.mandant_id = x.mandant_id
                AND a.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 27 AND mandant_id = 1
            )
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3`.mandant_id = b.mandant_id
        AND `_ff_we3`.wup_id = b.wup_id
        AND `_ff_we3`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3`.art_id = b.art_id
        AND `_ff_we3`.dat < b.min_dat;

    UPDATE `_ff_we3` SET we_menge_2 = 0
    FROM (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            CASE
                WHEN a.werbetyp_id = 3
                    THEN DATE_SUB(a.dat_von, INTERVAL '3' DAY)
                ELSE DATE_SUB(a.dat_von, INTERVAL '1' DAY)
            END AS min_dat
        FROM `_ff_we3` AS a
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                a.mandant_id = x.mandant_id
                AND a.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 28 AND mandant_id = 1
            )
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3`.mandant_id = b.mandant_id
        AND `_ff_we3`.wup_id = b.wup_id
        AND `_ff_we3`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3`.art_id = b.art_id
        AND `_ff_we3`.dat < b.min_dat;

    UPDATE `_ff_we3` SET we_menge_2 = 0
    FROM (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von AS min_dat
        FROM `_ff_we3` AS a
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                a.mandant_id = x.mandant_id
                AND a.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 50 AND mandant_id = 1
            )
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3`.mandant_id = b.mandant_id
        AND `_ff_we3`.wup_id = b.wup_id
        AND `_ff_we3`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3`.art_id = b.art_id
        AND `_ff_we3`.dat < b.min_dat;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we4 AS
    SELECT
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        nb_id,
        SUM(we_menge) AS we_menge,
        SUM(we_menge_2) AS we_menge_2,
        SUM(0) AS menge_aktionsstart
    FROM `_ff_we3` AS a
    GROUP BY
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        nb_id;

    CREATE OR REPLACE TEMPORARY TABLE _mbst_we1 AS
    SELECT
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id,
        SUM(COALESCE(u.menge_lgbest_erp_frei_bme, 0)) AS menge_aktionsstart
    FROM `_ff_we4` AS v
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            CASE WHEN werbetyp_id = 1 THEN dat_von ELSE DATE_SUB(dat_von, INTERVAL '1' DAY) END AS dat_von,
            kjwo
        FROM `_werbeartikel_1_2`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_von,
            kjwo
    ) AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.werbetyp_id = w.werbetyp_id
            AND (
                v.kjwo = w.kjwo OR v.kjwo = w.kjwo - 1
            )
    LEFT JOIN dbp_data.marktbestand_erp_2 AS u
        ON
            w.mandant_id = u.mandant_id
            AND w.wup_id = u.wup_id
            AND w.art_id = u.art_id
            AND w.dat_von = u.dat
    GROUP BY
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id;

    UPDATE `_ff_we4` SET menge_aktionsstart = CAST(b.menge_aktionsstart AS INT64)
    FROM (
        SELECT *
        FROM `_mbst_we1`
        WHERE
            menge_aktionsstart <> 0
    ) AS b
    WHERE
        `_ff_we4`.mandant_id = b.mandant_id
        AND `_ff_we4`.wup_id = b.wup_id
        AND `_ff_we4`.nb_id = b.nb_id
        AND `_ff_we4`.art_id = b.art_id
        AND `_ff_we4`.kjwo = b.kjwo
        AND `_ff_we4`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _wup_kalender AS
    SELECT
        a.kjwo,
        a.werbetyp_id,
        a.mandant_id,
        a.wup_id,
        SUM(COALESCE(b.offen, 1)) AS anz_offen
    FROM (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            dat_von,
            dat_bis,
            kjwo
        FROM `_werbeartikel_1_2`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            dat_von,
            dat_bis,
            kjwo
    ) AS a
    LEFT JOIN (
        SELECT *
        FROM dbp_data.wupcal_2
        WHERE
            (mandant_id, dat) IN (
                SELECT (mandant_id, dat)
                FROM `_die_tage`
            )
    ) AS b
        ON
            a.wup_id = b.wup_id
            AND a.mandant_id = b.mandant_id
            AND b.dat BETWEEN CASE
                WHEN a.werbetyp_id = 1
                    THEN DATE_ADD(a.dat_von, INTERVAL '1' DAY)
                ELSE a.dat_von
            END AND a.dat_bis
    GROUP BY
        a.kjwo,
        a.werbetyp_id,
        a.mandant_id,
        a.wup_id;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew AS
    SELECT
        w.kjwo,
        w.werbetyp_id,
        w.dat_von,
        w.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id,
        MAX(v.posten_id) AS posten_id,
        SUM(CASE WHEN x.wtag_id = 1 THEN v.umsatz_netto ELSE 0 END) AS umsatz_netto_mo,
        SUM(CASE WHEN x.wtag_id = 2 THEN v.umsatz_netto ELSE 0 END) AS umsatz_netto_di,
        SUM(CASE WHEN x.wtag_id = 3 THEN v.umsatz_netto ELSE 0 END) AS umsatz_netto_mi,
        SUM(CASE WHEN x.wtag_id = 4 THEN v.umsatz_netto ELSE 0 END) AS umsatz_netto_do,
        SUM(CASE WHEN x.wtag_id = 5 THEN v.umsatz_netto ELSE 0 END) AS umsatz_netto_fr,
        SUM(CASE WHEN x.wtag_id = 6 THEN v.umsatz_netto ELSE 0 END) AS umsatz_netto_sa,
        SUM(CASE WHEN x.wtag_id = 7 THEN v.umsatz_netto ELSE 0 END) AS umsatz_netto_so,
        SUM(v.umsatz_netto) AS umsatz_netto_wo,
        SUM(CASE WHEN x.wtag_id = 1 THEN v.menge ELSE 0 END) AS menge_mo,
        SUM(CASE WHEN x.wtag_id = 2 THEN v.menge ELSE 0 END) AS menge_di,
        SUM(CASE WHEN x.wtag_id = 3 THEN v.menge ELSE 0 END) AS menge_mi,
        SUM(CASE WHEN x.wtag_id = 4 THEN v.menge ELSE 0 END) AS menge_do,
        SUM(CASE WHEN x.wtag_id = 5 THEN v.menge ELSE 0 END) AS menge_fr,
        SUM(CASE WHEN x.wtag_id = 6 THEN v.menge ELSE 0 END) AS menge_sa,
        SUM(CASE WHEN x.wtag_id = 7 THEN v.menge ELSE 0 END) AS menge_so,
        SUM(v.menge) AS menge_wo,
        SUM(CASE WHEN v.bewart_id = 1002 THEN v.menge ELSE 0 END) AS menge_sa2,
        MAX(z.anz_offen) - COUNT(DISTINCT v.dat) AS tage_menge_0,
        SUM(0) AS we_menge,
        SUM(0) AS menge_aktionsstart,
        SUM(0) AS we_menge_ab_vorwoche
    FROM (
        SELECT
            mandant_id,
            wup_id,
            nb_id,
            dat,
            bewart_id,
            gp_id,
            art_id,
            aktion_id,
            promo_fg,
            ean_kasse,
            standard_aktion_id,
            einkaufsorganisation_id,
            herst_id,
            mwst_id,
            menge,
            wrg_2,
            umsatz_netto,
            diff_umsatz_netto_konz,
            umsatz_mwst_betrag,
            diff_umsatz_mwst_betrag_konz,
            ek_brutto,
            diff_ek_brutto_konz,
            ek_netto,
            diff_ek_netto_konz,
            ek_nettonetto,
            diff_ek_nettonetto_konz,
            ek_kal_basis,
            diff_ek_kal_basis_konz,
            ek_mep,
            diff_ek_mep_konz,
            ek_mep_vor_fwu,
            ek_mep_vor_fwu_konz,
            einstandspreis,
            diff_einstandspreis_konz,
            logkostenzuschlag,
            diff_logkostenzuschlag_konz,
            bezugsweg_id,
            ek_netto_bnk,
            diff_ek_netto_bnk_konz,
            ek_netto_bnk_sachk,
            diff_ek_netto_bnk_sachk_konz,
            posten_id,
            bq_findung_id,
            ek_gld,
            diff_ek_gld_konz,
            bonusbasis,
            bonusbasis_konz,
            bewart_det_id,
            wup_bereinigt_fg,
            pv_aktion,
            pv_aktion_konz,
            pv_bby,
            pv_bby_konz,
            pv_kdn_bby,
            pv_kdn_bby_konz,
            pv_kdp_bby,
            pv_kdp_bby_konz,
            pv_aktion_bby,
            pv_aktion_bby_konz,
            pv_aktion_kdn_bby,
            pv_aktion_kdn_bby_konz,
            pv_aktion_kdp_bby,
            pv_aktion_kdp_bby_konz,
            pv_bonrabatt_bby,
            pv_bonrabatt_bby_konz,
            td_update,
            td_insert,
            umrechnungskurs_hist,
            aktionsart_id_liste_txt,
            aktionsart_bez_liste_txt,
            aktion_typ_id_liste_txt,
            aktion_typ_bez_liste_txt
        FROM dbp_data.artbew_2 AS a
        WHERE
            (mandant_id, dat) IN (
                SELECT (mandant_id, dat)
                FROM `_die_tage`
            )
            AND umsatz_netto > 0
    ) AS v
    INNER JOIN `_werbeartikel_1_2` AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.dat BETWEEN CASE
                WHEN w.werbetyp_id = 1
                    THEN DATE_ADD(w.dat_von, INTERVAL '1' DAY)
                ELSE w.dat_von
            END AND w.dat_bis
    INNER JOIN dbp_data.tag_2 AS x
        ON v.dat = x.dat
    INNER JOIN `_wup_kalender` AS z
        ON
            w.kjwo = z.kjwo
            AND v.wup_id = z.wup_id
            AND v.mandant_id = z.mandant_id
            AND w.werbetyp_id = z.werbetyp_id
    GROUP BY
        w.kjwo,
        w.werbetyp_id,
        w.dat_von,
        w.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id;

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst1 AS
    SELECT
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id,
        SUM(COALESCE(u.menge_lgbest_erp_frei_bme, 0)) AS menge_endbestand
    FROM `_ff_we4` AS v
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_bis,
            kjwo
        FROM `_werbeartikel_1_2`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_bis,
            kjwo
    ) AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.werbetyp_id = w.werbetyp_id
            AND (
                v.kjwo = w.kjwo OR v.kjwo = w.kjwo - 1
            )
    LEFT JOIN dbp_data.marktbestand_erp_2 AS u
        ON
            w.mandant_id = u.mandant_id
            AND w.wup_id = u.wup_id
            AND w.art_id = u.art_id
            AND w.dat_bis = u.dat
            AND u.menge_lgbest_erp_frei_bme >= 0
    GROUP BY
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id;

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2 AS
    SELECT
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id,
        SUM(
            CASE
                WHEN
                    xx.gewart_id = 'ST'
                    AND x.menge_lgbest_erp_frei_bme = 0
                    OR xx.gewart_id = 'KG'
                    AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                    OR xx.gewart_id = 'G'
                    AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END
        ) AS anz_tage_null,
        SUM(
            CASE
                WHEN
                    xx.gewart_id = 'ST'
                    AND x.menge_lgbest_erp_frei_bme < 0
                    OR xx.gewart_id = 'KG'
                    AND x.menge_lgbest_erp_frei_bme < 0.000
                    OR xx.gewart_id = 'G'
                    AND x.menge_lgbest_erp_frei_bme < 0.000
                    THEN 1
                ELSE 0
            END
        ) AS anz_tage_minus
    FROM `_ff_we4` AS v
    INNER JOIN (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von,
            a.dat_bis,
            b.dat,
            a.kjwo
        FROM `_werbeartikel_1_2` AS a
        INNER JOIN dbp_data.tag_2 AS b
            ON b.dat BETWEEN a.dat_von AND a.dat_bis
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von,
            a.dat_bis,
            b.dat,
            a.kjwo
    ) AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.werbetyp_id = w.werbetyp_id
            AND (
                v.kjwo = w.kjwo OR v.kjwo = w.kjwo - 1
            )
    INNER JOIN dbp_data.art_2 AS xx
        ON v.mandant_id = xx.mandant_id AND v.art_id = xx.art_id
    LEFT JOIN dbp_data.marktbestand_erp_2 AS x
        ON
            w.mandant_id = x.mandant_id
            AND w.wup_id = x.wup_id
            AND w.art_id = x.art_id
            AND w.dat = x.dat
            AND x.dat < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id;

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2a AS
    SELECT
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id,
        MAX(
            CASE
                WHEN
                    xx.gewart_id = 'ST'
                    AND x.menge_lgbest_erp_frei_bme = 0
                    OR xx.gewart_id = 'KG'
                    AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                    OR xx.gewart_id = 'G'
                    AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END
        ) AS anz_null_tag1,
        0 AS anz_null_tag2,
        0 AS anz_null_tag3,
        0 AS anz_null_tag4,
        0 AS anz_null_tag5,
        0 AS anz_null_tag6,
        0 AS anz_null_tag7,
        MAX(
            CASE
                WHEN
                    xx.gewart_id = 'ST'
                    AND x.menge_lgbest_erp_frei_bme < 0
                    OR xx.gewart_id = 'KG'
                    AND x.menge_lgbest_erp_frei_bme < 0.000
                    OR xx.gewart_id = 'G'
                    AND x.menge_lgbest_erp_frei_bme < 0.000
                    THEN 1
                ELSE 0
            END
        ) AS anz_minus_tag1
    FROM `_ff_we4` AS v
    INNER JOIN (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von,
            a.dat_bis,
            b.dat,
            a.kjwo
        FROM `_werbeartikel_1_2` AS a
        INNER JOIN dbp_data.tag_2 AS b
            ON a.dat_von = b.dat
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von,
            a.dat_bis,
            b.dat,
            a.kjwo
    ) AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.werbetyp_id = w.werbetyp_id
            AND (
                v.kjwo = w.kjwo OR v.kjwo = w.kjwo - 1
            )
    INNER JOIN dbp_data.art_2 AS xx
        ON v.mandant_id = xx.mandant_id AND v.art_id = xx.art_id
    LEFT JOIN dbp_data.marktbestand_erp_2 AS x
        ON
            w.mandant_id = x.mandant_id
            AND w.wup_id = x.wup_id
            AND w.art_id = x.art_id
            AND w.dat = x.dat
            AND x.dat < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id;

        /* Anzahl Nullbestand Tag_2 2 */
    UPDATE `_test_we_mbst2a` SET anz_null_tag2 = CAST(b.anz_null_tag2 AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(
                CASE
                    WHEN
                        xx.gewart_id = 'ST'
                        AND a.menge_lgbest_erp_frei_bme = 0
                        OR xx.gewart_id = 'KG'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                        OR xx.gewart_id = 'G'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                        THEN 1
                    ELSE 0
                END
            ) AS anz_null_tag2
        FROM dbp_data.marktbestand_erp_2 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.tag_2 AS b
                ON b.dat = DATE_ADD(a0.dat_von, INTERVAL '1' DAY) AND a0.dat_bis >= b.dat
            GROUP BY
                a0.werbetyp_id,
                a0.dat_von,
                a0.dat_bis,
                a0.wup_id,
                a0.mandant_id,
                a0.art_id,
                b.dat
        ) AS w
            ON
                a.mandant_id = w.mandant_id
                AND a.wup_id = w.wup_id
                AND a.art_id = w.art_id
                AND a.dat = w.dat
                AND a.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS xx
            ON w.mandant_id = xx.mandant_id AND w.art_id = xx.art_id
        GROUP BY
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a`.wup_id = b.wup_id
        AND `_test_we_mbst2a`.art_id = b.art_id
        AND `_test_we_mbst2a`.dat_von = b.dat_von
        AND `_test_we_mbst2a`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_2 3 */
    UPDATE `_test_we_mbst2a` SET anz_null_tag3 = CAST(b.anz_null_tag3 AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(
                CASE
                    WHEN
                        xx.gewart_id = 'ST'
                        AND a.menge_lgbest_erp_frei_bme = 0
                        OR xx.gewart_id = 'KG'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                        OR xx.gewart_id = 'G'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                        THEN 1
                    ELSE 0
                END
            ) AS anz_null_tag3
        FROM dbp_data.marktbestand_erp_2 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.tag_2 AS b
                ON b.dat = DATE_ADD(a0.dat_von, INTERVAL '2' DAY) AND a0.dat_bis >= b.dat
            GROUP BY
                a0.werbetyp_id,
                a0.dat_von,
                a0.dat_bis,
                a0.wup_id,
                a0.mandant_id,
                a0.art_id,
                b.dat
        ) AS w
            ON
                a.mandant_id = w.mandant_id
                AND a.wup_id = w.wup_id
                AND a.art_id = w.art_id
                AND a.dat = w.dat
                AND a.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS xx
            ON w.mandant_id = xx.mandant_id AND w.art_id = xx.art_id
        GROUP BY
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a`.wup_id = b.wup_id
        AND `_test_we_mbst2a`.art_id = b.art_id
        AND `_test_we_mbst2a`.dat_von = b.dat_von
        AND `_test_we_mbst2a`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_2 4 */
    UPDATE `_test_we_mbst2a` SET anz_null_tag4 = CAST(b.anz_null_tag4 AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(
                CASE
                    WHEN
                        xx.gewart_id = 'ST'
                        AND a.menge_lgbest_erp_frei_bme = 0
                        OR xx.gewart_id = 'KG'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                        OR xx.gewart_id = 'G'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                        THEN 1
                    ELSE 0
                END
            ) AS anz_null_tag4
        FROM dbp_data.marktbestand_erp_2 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.tag_2 AS b
                ON b.dat = DATE_ADD(a0.dat_von, INTERVAL '3' DAY) AND a0.dat_bis >= b.dat
            GROUP BY
                a0.werbetyp_id,
                a0.dat_von,
                a0.dat_bis,
                a0.wup_id,
                a0.mandant_id,
                a0.art_id,
                b.dat
        ) AS w
            ON
                a.mandant_id = w.mandant_id
                AND a.wup_id = w.wup_id
                AND a.art_id = w.art_id
                AND a.dat = w.dat
                AND a.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS xx
            ON w.mandant_id = xx.mandant_id AND w.art_id = xx.art_id
        GROUP BY
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a`.wup_id = b.wup_id
        AND `_test_we_mbst2a`.art_id = b.art_id
        AND `_test_we_mbst2a`.dat_von = b.dat_von
        AND `_test_we_mbst2a`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_2 5 */
    UPDATE `_test_we_mbst2a` SET anz_null_tag5 = CAST(b.anz_null_tag5 AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(
                CASE
                    WHEN
                        xx.gewart_id = 'ST'
                        AND a.menge_lgbest_erp_frei_bme = 0
                        OR xx.gewart_id = 'KG'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                        OR xx.gewart_id = 'G'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                        THEN 1
                    ELSE 0
                END
            ) AS anz_null_tag5
        FROM dbp_data.marktbestand_erp_2 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.tag_2 AS b
                ON b.dat = DATE_ADD(a0.dat_von, INTERVAL '4' DAY) AND a0.dat_bis >= b.dat
            GROUP BY
                a0.werbetyp_id,
                a0.dat_von,
                a0.dat_bis,
                a0.wup_id,
                a0.mandant_id,
                a0.art_id,
                b.dat
        ) AS w
            ON
                a.mandant_id = w.mandant_id
                AND a.wup_id = w.wup_id
                AND a.art_id = w.art_id
                AND a.dat = w.dat
                AND a.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS xx
            ON w.mandant_id = xx.mandant_id AND w.art_id = xx.art_id
        GROUP BY
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a`.wup_id = b.wup_id
        AND `_test_we_mbst2a`.art_id = b.art_id
        AND `_test_we_mbst2a`.dat_von = b.dat_von
        AND `_test_we_mbst2a`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_2 6 */
    UPDATE `_test_we_mbst2a` SET anz_null_tag6 = CAST(b.anz_null_tag6 AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(
                CASE
                    WHEN
                        xx.gewart_id = 'ST'
                        AND a.menge_lgbest_erp_frei_bme = 0
                        OR xx.gewart_id = 'KG'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                        OR xx.gewart_id = 'G'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                        THEN 1
                    ELSE 0
                END
            ) AS anz_null_tag6
        FROM dbp_data.marktbestand_erp_2 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.tag_2 AS b
                ON b.dat = DATE_ADD(a0.dat_von, INTERVAL '5' DAY) AND a0.dat_bis >= b.dat
            GROUP BY
                a0.werbetyp_id,
                a0.dat_von,
                a0.dat_bis,
                a0.wup_id,
                a0.mandant_id,
                a0.art_id,
                b.dat
        ) AS w
            ON
                a.mandant_id = w.mandant_id
                AND a.wup_id = w.wup_id
                AND a.art_id = w.art_id
                AND a.dat = w.dat
                AND a.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS xx
            ON w.mandant_id = xx.mandant_id AND w.art_id = xx.art_id
        GROUP BY
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a`.wup_id = b.wup_id
        AND `_test_we_mbst2a`.art_id = b.art_id
        AND `_test_we_mbst2a`.dat_von = b.dat_von
        AND `_test_we_mbst2a`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_2 7 */
    UPDATE `_test_we_mbst2a` SET anz_null_tag7 = CAST(b.anz_null_tag7 AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(
                CASE
                    WHEN
                        xx.gewart_id = 'ST'
                        AND a.menge_lgbest_erp_frei_bme = 0
                        OR xx.gewart_id = 'KG'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                        OR xx.gewart_id = 'G'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                        THEN 1
                    ELSE 0
                END
            ) AS anz_null_tag7
        FROM dbp_data.marktbestand_erp_2 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.tag_2 AS b
                ON b.dat = DATE_ADD(a0.dat_von, INTERVAL '6' DAY) AND a0.dat_bis >= b.dat
            GROUP BY
                a0.werbetyp_id,
                a0.dat_von,
                a0.dat_bis,
                a0.wup_id,
                a0.mandant_id,
                a0.art_id,
                b.dat
        ) AS w
            ON
                a.mandant_id = w.mandant_id
                AND a.wup_id = w.wup_id
                AND a.art_id = w.art_id
                AND a.dat = w.dat
                AND a.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS xx
            ON w.mandant_id = xx.mandant_id AND w.art_id = xx.art_id
        GROUP BY
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a`.wup_id = b.wup_id
        AND `_test_we_mbst2a`.art_id = b.art_id
        AND `_test_we_mbst2a`.dat_von = b.dat_von
        AND `_test_we_mbst2a`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2b AS
    SELECT
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id,
        SUM(
            CASE
                WHEN
                    xx.gewart_id = 'ST'
                    AND x.menge_lgbest_erp_frei_bme = 0
                    OR xx.gewart_id = 'KG'
                    AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                    OR xx.gewart_id = 'G'
                    AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END
        ) AS anz_null_tag1_bis_tag3,
        SUM(
            CASE
                WHEN
                    xx.gewart_id = 'ST'
                    AND x.menge_lgbest_erp_frei_bme < 0
                    OR xx.gewart_id = 'KG'
                    AND x.menge_lgbest_erp_frei_bme < 0.000
                    OR xx.gewart_id = 'G'
                    AND x.menge_lgbest_erp_frei_bme < 0.000
                    THEN 1
                ELSE 0
            END
        ) AS anz_minus_tag1_bis_tag3
    FROM `_ff_we4` AS v
    INNER JOIN (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von,
            a.dat_bis,
            b.dat,
            a.kjwo
        FROM `_werbeartikel_1_2` AS a
        INNER JOIN dbp_data.tag_2 AS b
            ON
                b.dat BETWEEN a.dat_von AND a.dat_bis
                AND b.dat BETWEEN a.dat_von AND (
                    DATE_ADD(a.dat_von, INTERVAL '2' DAY)
                )
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von,
            a.dat_bis,
            b.dat,
            a.kjwo
    ) AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.werbetyp_id = w.werbetyp_id
            AND (
                v.kjwo = w.kjwo OR v.kjwo = w.kjwo - 1
            )
    INNER JOIN dbp_data.art_2 AS xx
        ON v.mandant_id = xx.mandant_id AND v.art_id = xx.art_id
    LEFT JOIN dbp_data.marktbestand_erp_2 AS x
        ON
            w.mandant_id = x.mandant_id
            AND w.wup_id = x.wup_id
            AND w.art_id = x.art_id
            AND w.dat = x.dat
            AND x.dat < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we5 AS
    SELECT
        a.kjwo,
        a.werbetyp_id,
        a.dat_von,
        a.dat_bis,
        a.mandant_id,
        a.wup_id,
        a.nb_id,
        a.art_id,
        SUM(a.we_menge) AS we_menge,
        SUM(a.we_menge_2) AS we_menge_ab_vorwoche,
        SUM(a.menge_aktionsstart) AS menge_aktionsstart,
        SUM(b.menge_endbestand) AS menge_endbestand
    FROM `_ff_we4` AS a
    INNER JOIN `_test_we_mbst1` AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.kjwo = b.kjwo
            AND a.wup_id = b.wup_id
            AND a.nb_id = b.nb_id
            AND a.art_id = b.art_id
            AND a.werbetyp_id = b.werbetyp_id
    GROUP BY
        a.kjwo,
        a.werbetyp_id,
        a.dat_von,
        a.dat_bis,
        a.mandant_id,
        a.wup_id,
        a.nb_id,
        a.art_id;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew1 AS
    SELECT
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        nb_id,
        posten_id,
        umsatz_netto_mo,
        umsatz_netto_di,
        umsatz_netto_mi,
        umsatz_netto_do,
        umsatz_netto_fr,
        umsatz_netto_sa,
        umsatz_netto_so,
        umsatz_netto_wo,
        menge_mo,
        menge_di,
        menge_mi,
        menge_do,
        menge_fr,
        menge_sa,
        menge_so,
        menge_wo,
        menge_sa2,
        tage_menge_0,
        we_menge,
        menge_aktionsstart,
        we_menge_ab_vorwoche,
        0 AS menge_endbestand,
        0 AS min_sicherh_bestand,
        1 AS faktor_flaki,
        0 AS anzahl_nullbestand,
        0 AS anzahl_tage_aktion,
        0 AS menge_historie_af,
        0 AS sollbestand,
        0 AS lager_prozent,
        0 AS mhd_zeitraum,
        0 AS menge_bestand_soll_max,
        0 AS menge_tag1_7bis13h,
        0 AS menge_nur_tag1,
        -1  AS bezugsweg_id,
        0 AS we_menge_vor_aktion,
        0 AS anzahl_nullbestand_tag1,
        0 AS anzahl_nullbestand_tag2,
        0 AS anzahl_nullbestand_tag3,
        0 AS anzahl_nullbestand_tag4,
        0 AS anzahl_nullbestand_tag5,
        0 AS anzahl_nullbestand_tag6,
        0 AS anzahl_nullbestand_tag7,
        0 AS anzahl_nullbestand_tag1bis3,
        0 AS anzahl_minusbestand,
        0 AS anzahl_minusbestand_tag1,
        0 AS anzahl_minusbestand_tag1bis3
    FROM `_ff_we_artbew` AS a;

    UPDATE `_ff_we_artbew1` SET we_menge = CAST(b.we_menge AS INT64), we_menge_ab_vorwoche = CAST(b.we_menge_ab_vorwoche AS INT64), we_menge_vor_aktion = CAST(b.we_menge_ab_vorwoche AS INT64), menge_aktionsstart = b.menge_aktionsstart, menge_endbestand = CAST(b.menge_endbestand AS INT64), min_sicherh_bestand = CAST(b.min_sicherh_bestand AS INT64), sollbestand = CAST(b.sollbestand AS INT64), bezugsweg_id = CAST(b.bezugsweg_id AS INT64)
    FROM (
        SELECT
            a.kjwo,
            a.werbetyp_id,
            a.dat_von,
            a.dat_bis,
            a.mandant_id,
            a.wup_id,
            a.nb_id,
            a.art_id,
            a.we_menge,
            a.we_menge_ab_vorwoche,
            a.menge_aktionsstart,
            a.menge_endbestand,
            f.min_sicherh_bestand,
            f.sollbestand,
            f.bezugsweg_id
        FROM `_ff_we5` AS a
        LEFT JOIN dbp_data.art_wup_status_per_2 AS f
            ON
                a.mandant_id = f.mandant_id
                AND a.wup_id = f.wup_id
                AND a.nb_id = f.nb_id
                AND a.art_id = f.art_id
                AND f.dat_bis = CAST('9999-12-31' AS DATE)
    ) AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1`.wup_id = b.wup_id
        AND `_ff_we_artbew1`.nb_id = b.nb_id
        AND `_ff_we_artbew1`.art_id = b.art_id
        AND `_ff_we_artbew1`.kjwo = b.kjwo
        AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1` SET mhd_zeitraum = CAST(b.mhd_zeitraum AS INT64), lager_prozent = CAST(b.lager_prozent AS INT64)
    FROM (
        SELECT
            a.kjwo,
            a.werbetyp_id,
            a.dat_von,
            a.dat_bis,
            a.mandant_id,
            a.wup_id,
            a.nb_id,
            a.art_id,
            a.we_menge,
            a.we_menge_ab_vorwoche,
            a.menge_aktionsstart,
            a.menge_endbestand,
            f.mhd_zeitraum,
            f.lager_prozent
        FROM `_ff_we5` AS a
        LEFT JOIN dbp_data.art_2 AS f
            ON a.mandant_id = f.mandant_id AND a.art_id = f.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1`.wup_id = b.wup_id
        AND `_ff_we_artbew1`.nb_id = b.nb_id
        AND `_ff_we_artbew1`.art_id = b.art_id
        AND `_ff_we_artbew1`.kjwo = b.kjwo
        AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1` SET menge_bestand_soll_max = CAST(b.menge_bestand_soll_max AS INT64)
    FROM (
        SELECT
            a.kjwo,
            a.werbetyp_id,
            a.dat_von,
            a.dat_bis,
            a.mandant_id,
            a.wup_id,
            a.nb_id,
            a.art_id,
            a.we_menge,
            a.we_menge_ab_vorwoche,
            a.menge_aktionsstart,
            a.menge_endbestand,
            f.menge_bestand_soll_max
        FROM `_ff_we5` AS a
        LEFT JOIN dbp_data.art_wup_nachschub_per_2 AS f
            ON
                a.mandant_id = f.mandant_id
                AND a.wup_id = f.wup_id
                AND a.nb_id = f.nb_id
                AND a.art_id = f.art_id
                AND f.dat_bis = CAST('9999-12-31' AS DATE)
    ) AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1`.wup_id = b.wup_id
        AND `_ff_we_artbew1`.nb_id = b.nb_id
        AND `_ff_we_artbew1`.art_id = b.art_id
        AND `_ff_we_artbew1`.kjwo = b.kjwo
        AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _fix_it_de AS
    SELECT
        t5.mandant_id0 AS mandant_id,
        t5.werbetyp_id,
        t5.wup_id0 AS wup_id,
        t5.art_id,
        t5.kjwo,
        t5.menge_tag1_7bis13h
    FROM (
        SELECT
            b.kjwo,
            b.werbetyp_id,
            b.wup_id AS wup_id0,
            b.mandant_id AS mandant_id0,
            b.art_id,
            SUM(a.menge) AS menge_tag1_7bis13h
        FROM dbp_ods.ods_bon_verkauf_2 AS a
        INNER JOIN `_werbeartikel_1_2` AS b
            ON
                a.mandant_id = b.mandant_id
                AND DATE(a.start_bon_zeile) = b.dat_von
                AND a.wup_id = b.wup_id
                AND b.art_id / 100  = a.kl_art_id
                AND CAST(a.start_bon_zeile AS TIME) BETWEEN CAST('07:00:00' AS TIME) AND CAST('13:00:00' AS TIME)
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.wup_id,
                a0.werbetyp_id
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.wupcal_2 AS b0
                ON a0.mandant_id = b0.mandant_id AND a0.wup_id = b0.wup_id AND a0.dat_von = b0.dat
            WHERE
                b0.offen = 1
            GROUP BY
                a0.werbetyp_id,
                a0.wup_id,
                a0.mandant_id
        ) AS x
            ON
                a.mandant_id = x.mandant_id
                AND a.wup_id = x.wup_id
                AND b.werbetyp_id = x.werbetyp_id
        WHERE
            a.mandant_id = 1
        GROUP BY
            b.kjwo,
            b.werbetyp_id,
            b.wup_id,
            b.mandant_id,
            b.art_id
        HAVING
            menge_tag1_7bis13h > 0
    ) AS t5;

    INSERT INTO `_fix_it_de`
    (
        SELECT
            t8.mandant_id0 AS mandant_id,
            t8.werbetyp_id,
            t8.wup_id0 AS wup_id,
            t8.art_id,
            t8.kjwo,
            t8.menge_tag1_7bis13h
        FROM (
            SELECT
                b.kjwo,
                b.werbetyp_id,
                b.wup_id AS wup_id0,
                b.mandant_id AS mandant_id0,
                b.art_id,
                SUM(a.menge) AS menge_tag1_7bis13h
            FROM dbp_ods.ods_bon_verkauf_2 AS a
            INNER JOIN `_werbeartikel_1_2` AS b
                ON
                    a.mandant_id = b.mandant_id
                    AND DATE(a.start_bon_zeile) BETWEEN b.dat_von AND b.dat_bis
                    AND a.wup_id = b.wup_id
                    AND b.art_id / 100  = a.kl_art_id
                    AND CAST(a.start_bon_zeile AS TIME) BETWEEN CAST('07:00:00' AS TIME) AND CAST('13:00:00' AS TIME)
            INNER JOIN (
                SELECT
                    a.mandant_id,
                    a.wup_id,
                    a.werbetyp_id,
                    MIN(b1.dat) AS min_dat
                FROM (
                    SELECT
                        a0.mandant_id,
                        a0.wup_id,
                        a0.werbetyp_id,
                        a0.dat_von,
                        a0.dat_bis
                    FROM `_werbeartikel_1_2` AS a0
                    INNER JOIN dbp_data.wupcal_2 AS b0
                        ON a0.mandant_id = b0.mandant_id AND a0.wup_id = b0.wup_id AND a0.dat_von = b0.dat
                    WHERE
                        b0.offen = 0
                    GROUP BY
                        a0.werbetyp_id,
                        a0.dat_von,
                        a0.dat_bis,
                        a0.wup_id,
                        a0.mandant_id
                ) AS a
                INNER JOIN dbp_data.wupcal_2 AS b1
                    ON
                        a.mandant_id = b1.mandant_id
                        AND a.wup_id = b1.wup_id
                        AND b1.dat BETWEEN a.dat_von AND a.dat_bis
                WHERE
                    b1.offen = 1
                GROUP BY
                    a.mandant_id,
                    a.wup_id,
                    a.werbetyp_id
            ) AS x
                ON
                    a.mandant_id = x.mandant_id
                    AND a.wup_id = x.wup_id
                    AND b.werbetyp_id = x.werbetyp_id
                    AND DATE(a.start_bon_zeile) = x.min_dat
            WHERE
                a.mandant_id = 1
            GROUP BY
                b.kjwo,
                b.werbetyp_id,
                b.wup_id,
                b.mandant_id,
                b.art_id
            HAVING
                menge_tag1_7bis13h > 0
        ) AS t8
    );

    /* Comment by: David Bandeira 03.01.2024 */ /* Quickfix EVT3544309 / Removing all duplicates from dbp_data._fix_it_de using a distinct in subselect. */ /* Add distinct in codeline 1881 */ /* This Quickfix need a review by Dennis Bayraktar */
    UPDATE `_ff_we_artbew1` SET menge_tag1_7bis13h = CAST(b.menge_tag1_7bis13h AS INT64)
    FROM (
        SELECT DISTINCT *
        FROM `_fix_it_de`
    ) AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1`.wup_id = b.wup_id
        AND `_ff_we_artbew1`.art_id = b.art_id
        AND `_ff_we_artbew1`.kjwo = b.kjwo
        AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _fix_it_de2 AS
    SELECT
        t5.mandant_id0 AS mandant_id,
        t5.werbetyp_id,
        t5.wup_id0 AS wup_id,
        t5.art_id,
        t5.kjwo,
        t5.menge_nur_tag1
    FROM (
        SELECT
            b.kjwo,
            b.werbetyp_id,
            b.wup_id AS wup_id0,
            b.mandant_id AS mandant_id0,
            b.art_id,
            SUM(a.menge) AS menge_nur_tag1
        FROM dbp_ods.ods_bon_verkauf_2 AS a
        INNER JOIN `_werbeartikel_1_2` AS b
            ON
                a.mandant_id = b.mandant_id
                AND DATE(a.start_bon_zeile) = b.dat_von
                AND a.wup_id = b.wup_id
                AND b.art_id / 100  = a.kl_art_id
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.wup_id,
                a0.werbetyp_id
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.wupcal_2 AS b0
                ON a0.mandant_id = b0.mandant_id AND a0.wup_id = b0.wup_id AND a0.dat_von = b0.dat
            WHERE
                b0.offen = 1
            GROUP BY
                a0.werbetyp_id,
                a0.wup_id,
                a0.mandant_id
        ) AS x
            ON
                a.mandant_id = x.mandant_id
                AND a.wup_id = x.wup_id
                AND b.werbetyp_id = x.werbetyp_id
        WHERE
            a.mandant_id = 1
        GROUP BY
            b.kjwo,
            b.werbetyp_id,
            b.wup_id,
            b.mandant_id,
            b.art_id
        HAVING
            menge_nur_tag1 > 0
    ) AS t5;

    INSERT INTO `_fix_it_de2`
    (
        SELECT
            t8.mandant_id0 AS mandant_id,
            t8.werbetyp_id,
            t8.wup_id0 AS wup_id,
            t8.art_id,
            t8.kjwo,
            t8.menge_nur_tag1
        FROM (
            SELECT
                b.kjwo,
                b.werbetyp_id,
                b.wup_id AS wup_id0,
                b.mandant_id AS mandant_id0,
                b.art_id,
                SUM(a.menge) AS menge_nur_tag1
            FROM dbp_ods.ods_bon_verkauf_2 AS a
            INNER JOIN `_werbeartikel_1_2` AS b
                ON
                    a.mandant_id = b.mandant_id
                    AND DATE(a.start_bon_zeile) BETWEEN b.dat_von AND b.dat_bis
                    AND a.wup_id = b.wup_id
                    AND b.art_id / 100  = a.kl_art_id
            INNER JOIN (
                SELECT
                    a.mandant_id,
                    a.wup_id,
                    a.werbetyp_id,
                    MIN(b1.dat) AS min_dat
                FROM (
                    SELECT
                        a0.mandant_id,
                        a0.wup_id,
                        a0.werbetyp_id,
                        a0.dat_von,
                        a0.dat_bis
                    FROM `_werbeartikel_1_2` AS a0
                    INNER JOIN dbp_data.wupcal_2 AS b0
                        ON a0.mandant_id = b0.mandant_id AND a0.wup_id = b0.wup_id AND a0.dat_von = b0.dat
                    WHERE
                        b0.offen = 0
                    GROUP BY
                        a0.werbetyp_id,
                        a0.dat_von,
                        a0.dat_bis,
                        a0.wup_id,
                        a0.mandant_id
                ) AS a
                INNER JOIN dbp_data.wupcal_2 AS b1
                    ON
                        a.mandant_id = b1.mandant_id
                        AND a.wup_id = b1.wup_id
                        AND b1.dat BETWEEN a.dat_von AND a.dat_bis
                WHERE
                    b1.offen = 1
                GROUP BY
                    a.mandant_id,
                    a.wup_id,
                    a.werbetyp_id
            ) AS x
                ON
                    a.mandant_id = x.mandant_id
                    AND a.wup_id = x.wup_id
                    AND b.werbetyp_id = x.werbetyp_id
                    AND DATE(a.start_bon_zeile) = x.min_dat
            WHERE
                a.mandant_id = 1
            GROUP BY
                b.kjwo,
                b.werbetyp_id,
                b.wup_id,
                b.mandant_id,
                b.art_id
            HAVING
                menge_nur_tag1 > 0
        ) AS t8
    );

    UPDATE `_ff_we_artbew1` SET menge_nur_tag1 = CAST(b.menge_nur_tag1 AS INT64)
    FROM (
        SELECT DISTINCT *
        FROM `_fix_it_de2`
    ) AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1`.wup_id = b.wup_id
        AND `_ff_we_artbew1`.art_id = b.art_id
        AND `_ff_we_artbew1`.kjwo = b.kjwo
        AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1` SET anzahl_nullbestand = CAST(b.anz_tage_null AS INT64), anzahl_minusbestand = CAST(b.anz_tage_minus AS INT64)
    FROM `_test_we_mbst2` AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1`.wup_id = b.wup_id
        AND `_ff_we_artbew1`.nb_id = b.nb_id
        AND `_ff_we_artbew1`.art_id = b.art_id
        AND `_ff_we_artbew1`.kjwo = b.kjwo
        AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1` SET anzahl_nullbestand_tag1 = CAST(b.anz_null_tag1 AS INT64), anzahl_nullbestand_tag2 = CAST(b.anz_null_tag2 AS INT64), anzahl_nullbestand_tag3 = CAST(b.anz_null_tag3 AS INT64), anzahl_nullbestand_tag4 = CAST(b.anz_null_tag4 AS INT64), anzahl_nullbestand_tag5 = CAST(b.anz_null_tag5 AS INT64), anzahl_nullbestand_tag6 = CAST(b.anz_null_tag6 AS INT64), anzahl_nullbestand_tag7 = CAST(b.anz_null_tag7 AS INT64), anzahl_minusbestand_tag1 = CAST(b.anz_minus_tag1 AS INT64)
    FROM `_test_we_mbst2a` AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1`.wup_id = b.wup_id
        AND `_ff_we_artbew1`.nb_id = b.nb_id
        AND `_ff_we_artbew1`.art_id = b.art_id
        AND `_ff_we_artbew1`.kjwo = b.kjwo
        AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1` SET anzahl_nullbestand_tag1bis3 = CAST(b.anz_null_tag1_bis_tag3 AS INT64), anzahl_minusbestand_tag1bis3 = CAST(b.anz_minus_tag1_bis_tag3 AS INT64)
    FROM `_test_we_mbst2b` AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1`.wup_id = b.wup_id
        AND `_ff_we_artbew1`.nb_id = b.nb_id
        AND `_ff_we_artbew1`.art_id = b.art_id
        AND `_ff_we_artbew1`.kjwo = b.kjwo
        AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1` SET menge_historie_af = CAST(b.menge_historie_af AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            SUM(d.menge) / 36.000 AS menge_historie_af
        FROM `_ff_we_artbew1` AS a
        INNER JOIN dbp_data.woche_2 AS b
            ON a.kjwo = b.kjwo
        INNER JOIN dbp_data.woche_kj_kl_2 AS c
            ON c.akt_wo BETWEEN b.akt_wo - 6 AND (
                b.akt_wo - 1
            )
        INNER JOIN dbp_data.artbew_wo_sum_2 AS d
            ON
                a.mandant_id = d.mandant_id
                AND a.wup_id = d.wup_id
                AND a.art_id = d.art_id
                AND c.kjwo_kl = d.kjwo_kl
        WHERE
            d.bewart_id = 1001 AND d.menge >= 0
        GROUP BY
            a.wup_id,
            a.mandant_id,
            a.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1`.wup_id = b.wup_id
        AND `_ff_we_artbew1`.art_id = b.art_id;

    UPDATE `_ff_we_artbew1` SET anzahl_tage_aktion = CAST(b.anz_tage_aktion AS INT64)
    FROM (
        SELECT
            mandant_id,
            werbetyp_id,
            MAX(anz_tage_aktion) AS anz_tage_aktion
        FROM `_werbetyp_tage`
        GROUP BY
            mandant_id,
            werbetyp_id
    ) AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1` SET we_menge_ab_vorwoche = `_ff_we_artbew1`.we_menge + `_ff_we_artbew1`.we_menge_ab_vorwoche
    WHERE
        TRUE;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew2 AS
    SELECT
        a.kjwo,
        a.werbetyp_id,
        a.dat_von,
        a.dat_bis,
        a.wup_id,
        a.mandant_id,
        a.art_id,
        a.nb_id,
        a.posten_id,
        a.umsatz_netto_mo,
        a.umsatz_netto_di,
        a.umsatz_netto_mi,
        a.umsatz_netto_do,
        a.umsatz_netto_fr,
        a.umsatz_netto_sa,
        a.umsatz_netto_so,
        a.umsatz_netto_wo,
        a.menge_mo,
        a.menge_di,
        a.menge_mi,
        a.menge_do,
        a.menge_fr,
        a.menge_sa,
        a.menge_so,
        a.menge_wo,
        a.menge_sa2,
        a.tage_menge_0,
        a.we_menge,
        a.menge_aktionsstart,
        a.we_menge_ab_vorwoche,
        a.menge_endbestand,
        a.min_sicherh_bestand,
        a.faktor_flaki,
        a.anzahl_nullbestand,
        a.anzahl_tage_aktion,
        a.menge_historie_af,
        a.sollbestand,
        a.lager_prozent,
        a.mhd_zeitraum,
        a.menge_bestand_soll_max,
        a.menge_tag1_7bis13h,
        a.menge_nur_tag1,
        a.bezugsweg_id,
        a.we_menge_vor_aktion,
        a.anzahl_nullbestand_tag1,
        a.anzahl_nullbestand_tag2,
        a.anzahl_nullbestand_tag3,
        a.anzahl_nullbestand_tag4,
        a.anzahl_nullbestand_tag5,
        a.anzahl_nullbestand_tag6,
        a.anzahl_nullbestand_tag7,
        a.anzahl_nullbestand_tag1bis3,
        a.anzahl_minusbestand,
        a.anzahl_minusbestand_tag1,
        a.anzahl_minusbestand_tag1bis3,
        b.wtag_id AS wtag_id_start,
        c.wtag_id AS wtag_id_ende,
        w.mutter_wb_id, /* Zuspielen der Mutter jetzt ueber die eingefrorenen Daten. */ /* 14.09.2016, -dbay- */
        w.avq_relevant_fg,
        w.vk_vor_aktion_brutto,
        w.vk_aktion_brutto,
        w.vk_kcard_brutto
    FROM `_ff_we_artbew1` AS a
    INNER JOIN dbp_data.tag_2 AS b
        ON CASE
            WHEN a.werbetyp_id = 1
                THEN DATE_ADD(a.dat_von, INTERVAL '1' DAY)
            ELSE a.dat_von
        END = b.dat
    INNER JOIN dbp_data.tag_2 AS c
        ON a.dat_bis = c.dat
    INNER JOIN `_werbeartikel_1_2` AS w
        ON
            a.mandant_id = w.mandant_id
            AND a.wup_id = w.wup_id
            AND a.art_id = w.art_id
            AND a.dat_von BETWEEN w.dat_von AND w.dat_bis
            AND a.werbetyp_id = w.werbetyp_id;

    DELETE FROM dbp_data.werbung_kennzahlen_woche_2
    WHERE
        (mandant_id, wup_id, nb_id, art_id, kjwo, werbe_typ_id) IN (
            SELECT (mandant_id, wup_id, nb_id, art_id, kjwo, werbetyp_id)
            FROM `_ff_we_artbew2`
        );

    INSERT INTO dbp_data.werbung_kennzahlen_woche_2 (
        mandant_id,
        kjwo,
        wup_id,
        nb_id,
        art_id,
        werbe_typ_id,
        menge_tag1,
        menge_tag2,
        menge_tag3,
        menge_tag4,
        menge_tag5,
        menge_tag6,
        menge_tag7,
        menge_nur_tag1,
        tage_menge_0,
        menge_endbestand,
        menge_aktionsstart,
        umsatz_netto_tag1,
        umsatz_netto_tag2,
        umsatz_netto_tag3,
        umsatz_netto_tag4,
        umsatz_netto_tag5,
        umsatz_netto_tag6,
        umsatz_netto_tag7,
        we_menge,
        min_sicherh_bestand,
        posten_id,
        we_menge_zentral,
        faktor_flaki,
        mutter_wb_id,
        wtag_id_start,
        wtag_id_ende,
        menge_historie_af,
        anzahl_nullbestand,
        anzahl_tage_aktion,
        menge_tag1_7bis13h,
        lager_prozent,
        mhd_zeitraum,
        sollbestand,
        menge_bestand_soll_max,
        werbenachvermarktung_fg,
        we_menge_vor_aktion,
        art_mutter_bezugsweg_id,
        anzahl_nullbestand_tag1,
        anzahl_nullbestand_tag2,
        anzahl_nullbestand_tag3,
        anzahl_nullbestand_tag4,
        anzahl_nullbestand_tag5,
        anzahl_nullbestand_tag6,
        anzahl_nullbestand_tag7,
        anzahl_nullbestand_tag1bis3,
        anzahl_minusbestand,
        anzahl_minusbestand_tag1,
        anzahl_minusbestand_tag1bis3,
        avq_relevant_fg,
        wrg_id,
        menge_sa,
        vk_vor_aktion_brutto,
        vk_aktion_brutto,
        vk_kcard_brutto,
        td_update,
        td_insert
    )
    (
        SELECT
            mandant_id,
            kjwo,
            wup_id,
            nb_id,
            art_id,
            werbetyp_id AS werbe_typ_id,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_mo
                WHEN werbetyp_id IN (26)
                    THEN menge_di
                WHEN werbetyp_id IN (27)
                    THEN menge_mi
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_do
                WHEN werbetyp_id IN (16)
                    THEN menge_sa
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_fr
                ELSE 0
            END AS NUMERIC) AS menge_tag1,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_di
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_fr
                WHEN werbetyp_id IN (16)
                    THEN menge_so
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_sa
                ELSE 0
            END AS NUMERIC) AS menge_tag2,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_mi
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_sa
                WHEN werbetyp_id IN (16)
                    THEN menge_mo
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_so
                ELSE 0
            END AS NUMERIC) AS menge_tag3,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_do
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_so
                WHEN werbetyp_id IN (16)
                    THEN menge_di
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_mo
                ELSE 0
            END AS NUMERIC) AS menge_tag4,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_fr
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_mo
                WHEN werbetyp_id IN (16)
                    THEN menge_mi
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_di
                ELSE 0
            END AS NUMERIC) AS menge_tag5,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_sa
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_di
                WHEN werbetyp_id IN (16)
                    THEN menge_do
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_mi
                ELSE 0
            END AS NUMERIC) AS menge_tag6,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_so
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_mi
                WHEN werbetyp_id IN (16)
                    THEN menge_fr
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_do
                ELSE 0
            END AS NUMERIC) AS menge_tag7,
            menge_nur_tag1,
            tage_menge_0,
            menge_endbestand,
            menge_aktionsstart,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_mo
                WHEN werbetyp_id IN (26)
                    THEN umsatz_netto_di
                WHEN werbetyp_id IN (27)
                    THEN umsatz_netto_mi
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_do
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_sa
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_fr
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag1,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_di
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_fr
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_so
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_sa
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag2,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_mi
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_sa
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_mo
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_so
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag3,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_do
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_so
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_di
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_mo
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag4,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_fr
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_mo
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_mi
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_di
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag5,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_sa
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_di
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_do
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_mi
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag6,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_so
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_mi
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_fr
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_do
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag7,
            we_menge,
            min_sicherh_bestand,
            posten_id,
            we_menge_ab_vorwoche AS we_menge_zentral,
            faktor_flaki,
            COALESCE(mutter_wb_id, art_id) AS mutter_wb_id,
            wtag_id_start,
            wtag_id_ende,
            menge_historie_af,
            CAST(CASE
                WHEN anzahl_tage_aktion < anzahl_nullbestand
                    THEN anzahl_tage_aktion
                ELSE anzahl_nullbestand
            END AS INT64) AS anzahl_nullbestand,
            CAST(anzahl_tage_aktion AS INT64) AS anzahl_tage_aktion,
            menge_tag1_7bis13h,
            CAST(lager_prozent AS INT64) AS lager_prozent,
            CAST(mhd_zeitraum AS INT64) AS mhd_zeitraum,
            sollbestand,
            menge_bestand_soll_max,
            0 AS werbenachvermarktung_fg,
            we_menge_vor_aktion,
            CAST(bezugsweg_id AS INT64) AS bezugsweg_id,
            CAST(anzahl_nullbestand_tag1 AS INT64) AS anzahl_nullbestand_tag1,
            CAST(anzahl_nullbestand_tag2 AS INT64) AS anzahl_nullbestand_tag2,
            CAST(anzahl_nullbestand_tag3 AS INT64) AS anzahl_nullbestand_tag3,
            CAST(anzahl_nullbestand_tag4 AS INT64) AS anzahl_nullbestand_tag4,
            CAST(anzahl_nullbestand_tag5 AS INT64) AS anzahl_nullbestand_tag5,
            CAST(anzahl_nullbestand_tag6 AS INT64) AS anzahl_nullbestand_tag6,
            CAST(anzahl_nullbestand_tag7 AS INT64) AS anzahl_nullbestand_tag7,
            CAST(anzahl_nullbestand_tag1bis3 AS INT64) AS anzahl_nullbestand_tag1bis3,
            CAST(anzahl_minusbestand AS INT64) AS anzahl_minusbestand,
            CAST(anzahl_minusbestand_tag1 AS INT64) AS anzahl_minusbestand_tag1,
            CAST(anzahl_minusbestand_tag1bis3 AS INT64) AS anzahl_minusbestand_tag1bis3,
            avq_relevant_fg,
            'EUR' AS wrg_id,
            CAST(menge_sa2 AS NUMERIC) AS menge_sa2,
            vk_vor_aktion_brutto,
            vk_aktion_brutto,
            vk_kcard_brutto,
            CURRENT_TIMESTAMP(),
            CURRENT_TIMESTAMP()
        FROM `_ff_we_artbew2`
    );

    CREATE OR REPLACE TEMPORARY TABLE _not_in1 AS
    SELECT *
    FROM `_werbeartikel_1_2`
    WHERE
        NOT (kjwo, wup_id, mandant_id, art_id, werbetyp_id) IN (
            SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
            FROM `_ff_we_artbew2`
        );

    CREATE OR REPLACE TEMPORARY TABLE _ff_we1_not_in AS
    SELECT
        a.mandant_id,
        a.kjwo,
        a.dat_von,
        a.dat_bis,
        a.werbetyp_id,
        a.wup_id,
        a.art_id
    FROM `_not_in1` AS a
    INNER JOIN dbp_data.art_wg_zu_per_2 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.art_id = b.art_id
            AND b.arthiertyp_id = 2
            AND b.dat_bis = CAST('9999-12-31' AS DATE);

    CREATE OR REPLACE TEMPORARY TABLE _ff_we2_not_in AS
    SELECT
        a.mandant_id,
        a.kjwo,
        a.dat_von,
        a.dat_bis,
        a.werbetyp_id,
        a.wup_id,
        a.art_id,
        b.dat,
        b.dat_2
    FROM `_ff_we1_not_in` AS a
    INNER JOIN (
        SELECT
            a0.kjwo,
            a0.werbetyp_id,
            CASE WHEN b.dat BETWEEN a0.dat_von AND a0.dat_bis THEN b.dat ELSE NULL END AS dat,
            CASE WHEN NOT b.dat BETWEEN a0.dat_von AND a0.dat_bis THEN b.dat ELSE NULL END AS dat_2
        FROM `_ff_we1_not_in` AS a0
        INNER JOIN dbp_data.tag_2 AS b
            ON b.dat BETWEEN DATE_SUB(a0.dat_von, INTERVAL '7' DAY) AND a0.dat_bis
        GROUP BY
            a0.kjwo,
            a0.werbetyp_id,
            dat,
            dat_2
    ) AS b
        ON a.kjwo = b.kjwo AND a.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we3_not_in AS
    SELECT
        a.mandant_id,
        a.werbetyp_id,
        a.dat_von,
        a.dat_bis,
        a.kjwo,
        COALESCE(a.dat, a.dat_2) AS dat,
        a.wup_id,
        a.art_id,
        COALESCE(b.menge_lagerbew_bme, 0) AS we_menge,
        COALESCE(c.menge_lagerbew_bme, 0) AS we_menge_2
    FROM `_ff_we2_not_in` AS a
    LEFT JOIN (
        SELECT
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            b.dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS a
        INNER JOIN dbp_data.lagerbew_det_2 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_not_in`
            WHERE
                NOT dat IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_2 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_2 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id = 'WE'
            AND CASE
                WHEN
                    b.dat_buch < CAST('2020-02-01' AS DATE)
                    AND c1.bestellart_id IN (
                        'ZLNS',
                        'ZLN',
                        'UBE',
                        'ZDZA',
                        'ZLLA',
                        'ZLA',
                        'ZLAS',
                        'ZAME',
                        'ZWRP',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'ZWWL',
                        'UBPX'
                    )
                    OR b.dat_buch >= CAST('2020-02-01' AS DATE)
                    AND c1.bestellart_id IN (
                        'UBE',
                        'ZDZA',
                        'ZLLA',
                        'ZLA',
                        'ZLAS',
                        'ZAME',
                        'ZWRP',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'ZWWL',
                        'UBPX'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND a.mandant_id = 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_not_in`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_not_in`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu_2
                WHERE
                    mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
            )
            AND NOT x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 25 AND mandant_id = 1
            )
        GROUP BY
            b.mandant_id,
            b.art_id,
            b.wup_id,
            b.dat_buch,
            c.werbetyp_id
        UNION ALL
        SELECT
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            b.dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS a
        INNER JOIN dbp_data.lagerbew_det_2 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_not_in`
            WHERE
                NOT dat IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_2 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_2 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id = 'WE'
            AND x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 25 AND mandant_id = 1
            )
            AND a.mandant_id = 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_not_in`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_not_in`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu_2
                WHERE
                    mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
            )
        GROUP BY
            b.mandant_id,
            b.art_id,
            b.wup_id,
            b.dat_buch,
            c.werbetyp_id
        UNION ALL
        SELECT
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            c.dat_2 AS dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS a
        INNER JOIN dbp_data.lagerbew_det_2 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_not_in`
            WHERE
                NOT dat_2 IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = DATE_SUB(c.dat_2, INTERVAL '7' DAY)
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_2 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_2 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id = 'WE'
            AND CASE
                WHEN
                    b.dat_buch < CAST('2020-02-01' AS DATE)
                    AND c1.bestellart_id IN (
                        'ZLNS',
                        'ZLN',
                        'UBE',
                        'ZDZA',
                        'ZLLA',
                        'ZLA',
                        'ZLAS',
                        'ZAME',
                        'ZWRP',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'ZWWL',
                        'UBPX'
                    )
                    OR b.dat_buch >= CAST('2020-02-01' AS DATE)
                    AND c1.bestellart_id IN (
                        'UBE',
                        'ZDZA',
                        'ZLLA',
                        'ZLA',
                        'ZLAS',
                        'ZAME',
                        'ZWRP',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'ZWWL',
                        'UBPX'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 30 AND mandant_id = 1
            )
            AND a.mandant_id = 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_not_in`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_not_in`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu_2
                WHERE
                    mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
            )
        GROUP BY
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            dat_buch
    ) AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.wup_id = b.wup_id
            AND a.art_id = b.art_id
            AND a.dat = b.dat_buch
            AND a.werbetyp_id = b.werbetyp_id
    LEFT JOIN (
        SELECT
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            b.dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS a
        INNER JOIN dbp_data.lagerbew_det_2 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_not_in`
            WHERE
                NOT dat_2 IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_2 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_2 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id = 'WE'
            AND CASE
                WHEN
                    b.dat_buch < CAST('2020-02-01' AS DATE)
                    AND c1.bestellart_id IN (
                        'ZLNS',
                        'ZLN',
                        'UBE',
                        'ZDZA',
                        'ZLLA',
                        'ZLA',
                        'ZLAS',
                        'ZAME',
                        'ZWRP',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'ZWWL',
                        'UBPX'
                    )
                    OR b.dat_buch >= CAST('2020-02-01' AS DATE)
                    AND c1.bestellart_id IN (
                        'UBE',
                        'ZDZA',
                        'ZLLA',
                        'ZLA',
                        'ZLAS',
                        'ZAME',
                        'ZWRP',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'ZWWL',
                        'UBPX'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND a.mandant_id = 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_not_in`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_not_in`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu_2
                WHERE
                    mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
            )
            AND NOT x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 25 AND mandant_id = 1
            )
        GROUP BY
            b.mandant_id,
            b.art_id,
            b.wup_id,
            b.dat_buch,
            c.werbetyp_id
        UNION ALL
        SELECT
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            b.dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS a
        INNER JOIN dbp_data.lagerbew_det_2 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_not_in`
            WHERE
                NOT dat_2 IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_2 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_2 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id = 'WE'
            AND x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 25 AND mandant_id = 1
            )
            AND a.mandant_id = 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_not_in`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_not_in`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu_2
                WHERE
                    mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
            )
        GROUP BY
            b.mandant_id,
            b.art_id,
            b.wup_id,
            b.dat_buch,
            c.werbetyp_id
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_2 = c.dat_buch
            AND a.werbetyp_id = c.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _x_ray_not_in AS
    SELECT
        a.mandant_id,
        a.wup_id,
        a.werbetyp_id,
        b.kopf_art AS art_id,
        a.dat,
        a.dat_2
    FROM (
        SELECT
            mandant_id,
            wup_id,
            werbetyp_id,
            dat,
            dat_2
        FROM `_ff_we2_not_in`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            dat,
            dat_2
    ) AS a
    INNER JOIN (
        SELECT kopf_art
        FROM `_stpo`
        GROUP BY
            kopf_art
    ) AS b
        ON TRUE;

    CREATE OR REPLACE TEMPORARY TABLE _help_me11 AS
    SELECT
        mandant_id,
        dat
    FROM `_x_ray_not_in`
    WHERE
        NOT dat IS NULL
    GROUP BY
        mandant_id,
        dat;

    CREATE OR REPLACE TEMPORARY TABLE _help_me22 AS
    SELECT
        mandant_id,
        dat_2
    FROM `_x_ray_not_in`
    WHERE
        NOT dat_2 IS NULL
    GROUP BY
        mandant_id,
        dat_2;

    CREATE OR REPLACE TEMPORARY TABLE _mseg_package_ekpo_not_in AS
    SELECT
        b.mandant_id,
        b.lagerbew_beleg_id,
        b.lagerbew_beleg_pos_id,
        b.kj,
        b.grund_id,
        b.lager_bewart_id,
        b.art_id,
        b.wup_id,
        b.nb_id,
        b.auto_fg,
        b.lagerort_id,
        b.gp_id,
        b.einkaufsorganisation_id,
        b.soll_haben_kz,
        b.wrg_id,
        b.best_beleg_id,
        b.best_beleg_pos_id,
        b.betrag_lagerbew,
        b.betrag_verkauf,
        b.erfsngs_menge_einh_id,
        b.lagerplatz_id,
        b.kunde_id,
        b.menge_lagerbew_kolli,
        b.menge_lagerbew_bme,
        b.menge_lagerbew_palette,
        b.menge_lieferschein,
        b.menge_lief,
        b.menge_erf,
        b.empfaenger_id,
        b.dat_buch,
        b.lagerbew_beleg_storno_id,
        b.lagerbew_beleg_pos_storno_id,
        b.lagerbew_beleg_storno_kj,
        b.betrag_vk_netto,
        b.system_id,
        b.betrag_belegfluss_wg_art,
        b.mandant_id_kunde,
        b.mandant_id_empfaenger,
        b.bw_vorgang_id,
        b.betrag_verkauf_ist,
        b.betrag_vk_netto_vz,
        b.betrag_verkauf_ist_netto,
        b.betrag_einstandspreis,
        b.gp_id_zl,
        b.bq_findung_id,
        b.lagerbew_beleg_pos_mutter_id,
        b.line_id,
        b.display_art_id,
        b.td_update,
        b.td_insert
    FROM dbp_data.lagerbew_2 AS a
    INNER JOIN dbp_data.lagerbew_det_2 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
            AND a.dat_buch = b.dat_buch
    INNER JOIN dbp_data.besch_best_2 AS c1
        ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
    INNER JOIN dbp_data.besch_best_det_2 AS c2
        ON
            b.mandant_id = c2.mandant_id
            AND b.wup_id = c2.wup_id
            AND c1.dat_best_beleg = c2.dat_best_beleg
            AND b.best_beleg_id = c2.best_beleg_id
            AND b.best_beleg_pos_id = c2.best_beleg_pos_id
            AND b.art_id = c2.art_id
    WHERE
        a.vorgangsart_id = 'WE'
        AND CASE
            WHEN
                b.dat_buch < CAST('2020-02-01' AS DATE)
                AND c1.bestellart_id IN (
                    'ZLNS',
                    'ZLN',
                    'UBE',
                    'ZDZA',
                    'ZLLA',
                    'ZLA',
                    'ZLAS',
                    'ZAME',
                    'ZWRP',
                    'UBGK',
                    'UBG1',
                    'UBG2',
                    'ZWWL',
                    'UBPX'
                )
                OR b.dat_buch >= CAST('2020-02-01' AS DATE)
                AND c1.bestellart_id IN (
                    'UBE',
                    'ZDZA',
                    'ZLLA',
                    'ZLA',
                    'ZLAS',
                    'ZAME',
                    'ZWRP',
                    'UBGK',
                    'UBG1',
                    'UBG2',
                    'ZWWL',
                    'UBPX'
                )
                THEN 1
            ELSE 0
        END = 1
        AND a.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me11`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me22`
            ) AS t3
        )
        AND a.mandant_id = 1
        AND NOT b.lager_bewart_id IN (
            SELECT lager_bewart_id
            FROM dbp_data.lager_bewart_spr_zu_2
            WHERE
                mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
        );

    CREATE OR REPLACE TEMPORARY TABLE _mseg_package_not_ekpo_not_in AS
    SELECT
        b.mandant_id,
        b.lagerbew_beleg_id,
        b.lagerbew_beleg_pos_id,
        b.kj,
        b.grund_id,
        b.lager_bewart_id,
        b.art_id,
        b.wup_id,
        b.nb_id,
        b.auto_fg,
        b.lagerort_id,
        b.gp_id,
        b.einkaufsorganisation_id,
        b.soll_haben_kz,
        b.wrg_id,
        b.best_beleg_id,
        b.best_beleg_pos_id,
        b.betrag_lagerbew,
        b.betrag_verkauf,
        b.erfsngs_menge_einh_id,
        b.lagerplatz_id,
        b.kunde_id,
        b.menge_lagerbew_kolli,
        b.menge_lagerbew_bme,
        b.menge_lagerbew_palette,
        b.menge_lieferschein,
        b.menge_lief,
        b.menge_erf,
        b.empfaenger_id,
        b.dat_buch,
        b.lagerbew_beleg_storno_id,
        b.lagerbew_beleg_pos_storno_id,
        b.lagerbew_beleg_storno_kj,
        b.betrag_vk_netto,
        b.system_id,
        b.betrag_belegfluss_wg_art,
        b.mandant_id_kunde,
        b.mandant_id_empfaenger,
        b.bw_vorgang_id,
        b.betrag_verkauf_ist,
        b.betrag_vk_netto_vz,
        b.betrag_verkauf_ist_netto,
        b.betrag_einstandspreis,
        b.gp_id_zl,
        b.bq_findung_id,
        b.lagerbew_beleg_pos_mutter_id,
        b.line_id,
        b.display_art_id,
        b.td_update,
        b.td_insert
    FROM dbp_data.lagerbew_2 AS a
    INNER JOIN dbp_data.lagerbew_det_2 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
            AND a.dat_buch = b.dat_buch
    INNER JOIN dbp_data.besch_best_2 AS c1
        ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
    INNER JOIN dbp_data.besch_best_det_2 AS c2
        ON
            b.mandant_id = c2.mandant_id
            AND b.wup_id = c2.wup_id
            AND c1.dat_best_beleg = c2.dat_best_beleg
            AND b.best_beleg_id = c2.best_beleg_id
            AND b.best_beleg_pos_id = c2.best_beleg_pos_id
            AND b.art_id = c2.art_id
    WHERE
        a.vorgangsart_id = 'WE'
        AND a.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me11`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me22`
            ) AS t3
        )
        AND a.mandant_id = 1
        AND NOT b.lager_bewart_id IN (
            SELECT lager_bewart_id
            FROM dbp_data.lager_bewart_spr_zu_2
            WHERE
                mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
        );

    CREATE OR REPLACE TEMPORARY TABLE _x_track1_not_in AS
    SELECT
        a.mandant_id,
        c.werbetyp_id,
        a.lagerbew_beleg_id,
        a.wup_id,
        a.art_id,
        a.dat_buch,
        SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_ekpo_not_in` AS a
    INNER JOIN (
        SELECT *
        FROM `_x_ray_not_in`
        WHERE
            NOT dat IS NULL
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat
    INNER JOIN dbp_data.art_wg_zu_per_2 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat)
            FROM `_help_me11`
        )
        AND NOT x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 25 AND mandant_id = 1
        )
    GROUP BY
        a.mandant_id,
        a.lagerbew_beleg_id,
        a.art_id,
        a.wup_id,
        a.dat_buch,
        c.werbetyp_id
    UNION ALL
    SELECT
        a.mandant_id,
        c.werbetyp_id,
        a.lagerbew_beleg_id,
        a.wup_id,
        a.art_id,
        a.dat_buch,
        SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_not_ekpo_not_in` AS a
    INNER JOIN (
        SELECT *
        FROM `_x_ray_not_in`
        WHERE
            NOT dat IS NULL
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat
    INNER JOIN dbp_data.art_wg_zu_per_2 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 25 AND mandant_id = 1
        )
        AND (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat)
            FROM `_help_me11`
        )
    GROUP BY
        a.mandant_id,
        a.lagerbew_beleg_id,
        a.art_id,
        a.wup_id,
        a.dat_buch,
        c.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _x_track2_not_in AS
    SELECT
        a.mandant_id,
        c.werbetyp_id,
        a.lagerbew_beleg_id,
        a.wup_id,
        a.art_id,
        a.dat_buch,
        SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_ekpo_not_in` AS a
    INNER JOIN (
        SELECT *
        FROM `_x_ray_not_in`
        WHERE
            NOT dat_2 IS NULL
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per_2 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat_2)
            FROM `_help_me22`
        )
        AND NOT x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 25 AND mandant_id = 1
        )
    GROUP BY
        a.mandant_id,
        a.lagerbew_beleg_id,
        a.art_id,
        a.wup_id,
        a.dat_buch,
        c.werbetyp_id
    UNION ALL
    SELECT
        a.mandant_id,
        c.werbetyp_id,
        a.lagerbew_beleg_id,
        a.wup_id,
        a.art_id,
        a.dat_buch,
        SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_not_ekpo_not_in` AS a
    INNER JOIN (
        SELECT *
        FROM `_x_ray_not_in`
        WHERE
            NOT dat_2 IS NULL
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per_2 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 25 AND mandant_id = 1
        )
        AND (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat_2)
            FROM `_help_me22`
        )
    GROUP BY
        a.mandant_id,
        a.lagerbew_beleg_id,
        a.art_id,
        a.wup_id,
        a.dat_buch,
        c.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _display_update_not_in AS
    SELECT
        b.mandant_id,
        c.werbetyp_id,
        b.wup_id,
        b.art_id,
        b.dat_buch,
        SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM dbp_data.lagerbew_2 AS a
    INNER JOIN dbp_data.lagerbew_det_2 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
            AND a.dat_buch = b.dat_buch
    INNER JOIN (
        SELECT
            c.mandant_id,
            c.werbetyp_id,
            c.lagerbew_beleg_id,
            c.wup_id,
            b0.art_id,
            c.dat_buch
        FROM dbp_data.stueckliste_2 AS a0
        INNER JOIN dbp_data.stueckliste_det_2 AS b0
            ON a0.mandant_id = b0.mandant_id AND a0.stueckliste_id = b0.stueckliste_id
        INNER JOIN (
            SELECT
                mandant_id,
                werbetyp_id,
                lagerbew_beleg_id,
                wup_id,
                art_id,
                dat_buch
            FROM `_x_track1_not_in`
            GROUP BY
                mandant_id,
                werbetyp_id,
                lagerbew_beleg_id,
                wup_id,
                art_id,
                dat_buch
            UNION ALL
            SELECT
                mandant_id,
                werbetyp_id,
                lagerbew_beleg_id,
                wup_id,
                art_id,
                dat_buch
            FROM `_x_track2_not_in`
            GROUP BY
                mandant_id,
                werbetyp_id,
                lagerbew_beleg_id,
                wup_id,
                art_id,
                dat_buch
        ) AS c
            ON a0.mandant_id = c.mandant_id AND a0.art_id = c.art_id
        WHERE
            a0.dat_bis = CAST('9999-12-31' AS DATE)
        GROUP BY
            c.mandant_id,
            c.werbetyp_id,
            c.lagerbew_beleg_id,
            c.wup_id,
            b0.art_id,
            c.dat_buch
    ) AS c
        ON
            b.mandant_id = c.mandant_id
            AND b.wup_id = c.wup_id
            AND b.art_id = c.art_id
            AND b.dat_buch = c.dat_buch
            AND b.lagerbew_beleg_id = c.lagerbew_beleg_id
    WHERE
        a.vorgangsart_id = 'WE'
        AND NOT b.lager_bewart_id IN (
            SELECT lager_bewart_id
            FROM dbp_data.lager_bewart_spr_zu_2
            WHERE
                mandant_id = 1 AND spr_id = 22 AND lager_bewart_bez LIKE '%Retoure%'
        )
    GROUP BY
        b.mandant_id,
        c.werbetyp_id,
        b.wup_id,
        b.art_id,
        b.dat_buch;

    UPDATE `_ff_we3_not_in` SET we_menge = b.menge_lagerbew_bme + `_ff_we3_not_in`.we_menge
    FROM `_display_update_not_in` AS b
    WHERE
        `_ff_we3_not_in`.mandant_id = b.mandant_id
        AND `_ff_we3_not_in`.wup_id = b.wup_id
        AND `_ff_we3_not_in`.art_id = b.art_id
        AND `_ff_we3_not_in`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_not_in`.dat = b.dat_buch
        AND `_ff_we3_not_in`.dat BETWEEN `_ff_we3_not_in`.dat_von AND `_ff_we3_not_in`.dat_bis;

    UPDATE `_ff_we3_not_in` SET we_menge_2 = b.menge_lagerbew_bme + `_ff_we3_not_in`.we_menge_2
    FROM `_display_update_not_in` AS b
    WHERE
        `_ff_we3_not_in`.mandant_id = b.mandant_id
        AND `_ff_we3_not_in`.wup_id = b.wup_id
        AND `_ff_we3_not_in`.art_id = b.art_id
        AND `_ff_we3_not_in`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_not_in`.dat = b.dat_buch
        AND NOT `_ff_we3_not_in`.dat BETWEEN `_ff_we3_not_in`.dat_von AND `_ff_we3_not_in`.dat_bis;

    UPDATE `_ff_we3_not_in` SET we_menge_2 = 0
    FROM (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            DATE_SUB(a.dat_von, INTERVAL '3' DAY) AS min_dat
        FROM `_ff_we3_not_in` AS a
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                a.mandant_id = x.mandant_id
                AND a.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 27 AND mandant_id = 1
            )
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3_not_in`.mandant_id = b.mandant_id
        AND `_ff_we3_not_in`.wup_id = b.wup_id
        AND `_ff_we3_not_in`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_not_in`.art_id = b.art_id
        AND `_ff_we3_not_in`.dat < b.min_dat;

    UPDATE `_ff_we3_not_in` SET we_menge_2 = 0
    FROM (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            CASE
                WHEN a.werbetyp_id = 3
                    THEN DATE_SUB(a.dat_von, INTERVAL '3' DAY)
                ELSE DATE_SUB(a.dat_von, INTERVAL '1' DAY)
            END AS min_dat
        FROM `_ff_we3_not_in` AS a
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                a.mandant_id = x.mandant_id
                AND a.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 28 AND mandant_id = 1
            )
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3_not_in`.mandant_id = b.mandant_id
        AND `_ff_we3_not_in`.wup_id = b.wup_id
        AND `_ff_we3_not_in`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_not_in`.art_id = b.art_id
        AND `_ff_we3_not_in`.dat < b.min_dat;

    UPDATE `_ff_we3_not_in` SET we_menge_2 = 0
    FROM (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von AS min_dat
        FROM `_ff_we3_not_in` AS a
        INNER JOIN dbp_data.art_wg_zu_per_2 AS x
            ON
                a.mandant_id = x.mandant_id
                AND a.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 12 AND mandant_id = 1
            )
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3_not_in`.mandant_id = b.mandant_id
        AND `_ff_we3_not_in`.wup_id = b.wup_id
        AND `_ff_we3_not_in`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_not_in`.art_id = b.art_id
        AND `_ff_we3_not_in`.dat < b.min_dat;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we4_not_in AS
    SELECT
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        SUM(we_menge) AS we_menge,
        SUM(we_menge_2) AS we_menge_2,
        SUM(0) AS menge_aktionsstart
    FROM `_ff_we3_not_in` AS a
    GROUP BY
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id;

    CREATE OR REPLACE TEMPORARY TABLE _mbst_we1_not_in AS
    SELECT
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        SUM(COALESCE(u.menge_lgbest_erp_frei_bme, 0)) AS menge_aktionsstart
    FROM `_ff_we4_not_in` AS v
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            CASE WHEN werbetyp_id = 1 THEN dat_von ELSE DATE_SUB(dat_von, INTERVAL '1' DAY) END AS dat_von,
            kjwo
        FROM `_werbeartikel_1_2`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_von,
            kjwo
    ) AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.werbetyp_id = w.werbetyp_id
            AND (
                v.kjwo = w.kjwo OR v.kjwo = w.kjwo - 1
            )
    LEFT JOIN dbp_data.marktbestand_erp_2 AS u
        ON
            w.mandant_id = u.mandant_id
            AND w.wup_id = u.wup_id
            AND w.art_id = u.art_id
            AND w.dat_von = u.dat
    GROUP BY
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id;

    UPDATE `_ff_we4_not_in` SET menge_aktionsstart = CAST(b.menge_aktionsstart AS INT64)
    FROM (
        SELECT *
        FROM `_mbst_we1_not_in`
        WHERE
            menge_aktionsstart <> 0
    ) AS b
    WHERE
        `_ff_we4_not_in`.mandant_id = b.mandant_id
        AND `_ff_we4_not_in`.wup_id = b.wup_id
        AND `_ff_we4_not_in`.art_id = b.art_id
        AND `_ff_we4_not_in`.kjwo = b.kjwo
        AND `_ff_we4_not_in`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art_not_in AS
    SELECT
        mandant_id,
        art_id,
        COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
    FROM dbp_data.art_2 AS a
    WHERE
        dat_bis = CAST('9999-12-31' AS DATE)
        AND (mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM `_ff_we4_not_in`
            GROUP BY
                mandant_id,
            art_id
        )
    GROUP BY
        mandant_id,
        art_id,
        a.mutter_wb_id;

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst1_not_in AS
    SELECT
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        SUM(COALESCE(u.menge_lgbest_erp_frei_bme, 0)) AS menge_endbestand
    FROM `_ff_we4_not_in` AS v
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_bis,
            kjwo
        FROM `_werbeartikel_1_2`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_bis,
            kjwo
    ) AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.werbetyp_id = w.werbetyp_id
            AND (
                v.kjwo = w.kjwo OR v.kjwo = w.kjwo - 1
            )
    LEFT JOIN dbp_data.marktbestand_erp_2 AS u
        ON
            w.mandant_id = u.mandant_id
            AND w.wup_id = u.wup_id
            AND w.art_id = u.art_id
            AND w.dat_bis = u.dat
            AND u.menge_lgbest_erp_frei_bme >= 0
    GROUP BY
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id;

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2_not_in AS
    SELECT
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        SUM(
            CASE
                WHEN
                    xx.gewart_id = 'ST'
                    AND x.menge_lgbest_erp_frei_bme = 0
                    OR xx.gewart_id = 'KG'
                    AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                    OR xx.gewart_id = 'G'
                    AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END
        ) AS anz_tage_null,
        SUM(
            CASE
                WHEN
                    xx.gewart_id = 'ST'
                    AND x.menge_lgbest_erp_frei_bme < 0
                    OR xx.gewart_id = 'KG'
                    AND x.menge_lgbest_erp_frei_bme < 0.000
                    OR xx.gewart_id = 'G'
                    AND x.menge_lgbest_erp_frei_bme < 0.000
                    THEN 1
                ELSE 0
            END
        ) AS anz_tage_minus
    FROM `_ff_we4_not_in` AS v
    INNER JOIN (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von,
            a.dat_bis,
            b.dat,
            a.kjwo
        FROM `_werbeartikel_1_2` AS a
        INNER JOIN dbp_data.tag_2 AS b
            ON b.dat BETWEEN a.dat_von AND a.dat_bis
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von,
            a.dat_bis,
            b.dat,
            a.kjwo
    ) AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.werbetyp_id = w.werbetyp_id
            AND (
                v.kjwo = w.kjwo OR v.kjwo = w.kjwo - 1
            )
    INNER JOIN dbp_data.art_2 AS xx
        ON v.mandant_id = xx.mandant_id AND v.art_id = xx.art_id
    LEFT JOIN dbp_data.marktbestand_erp_2 AS x
        ON
            w.mandant_id = x.mandant_id
            AND w.wup_id = x.wup_id
            AND w.art_id = x.art_id
            AND w.dat = x.dat
            AND x.dat < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id;

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2a_not_in AS
    SELECT
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        MAX(
            CASE
                WHEN
                    xx.gewart_id = 'ST'
                    AND x.menge_lgbest_erp_frei_bme = 0
                    OR xx.gewart_id = 'KG'
                    AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                    OR xx.gewart_id = 'G'
                    AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END
        ) AS anz_null_tag1,
        0 AS anz_null_tag2,
        0 AS anz_null_tag3,
        0 AS anz_null_tag4,
        0 AS anz_null_tag5,
        0 AS anz_null_tag6,
        0 AS anz_null_tag7,
        MAX(
            CASE
                WHEN
                    xx.gewart_id = 'ST'
                    AND x.menge_lgbest_erp_frei_bme < 0
                    OR xx.gewart_id = 'KG'
                    AND x.menge_lgbest_erp_frei_bme < 0.000
                    OR xx.gewart_id = 'G'
                    AND x.menge_lgbest_erp_frei_bme < 0.000
                    THEN 1
                ELSE 0
            END
        ) AS anz_minus_tag1
    FROM `_ff_we4_not_in` AS v
    INNER JOIN (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von,
            a.dat_bis,
            b.dat,
            a.kjwo
        FROM `_werbeartikel_1_2` AS a
        INNER JOIN dbp_data.tag_2 AS b
            ON a.dat_von = b.dat
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von,
            a.dat_bis,
            b.dat,
            a.kjwo
    ) AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.werbetyp_id = w.werbetyp_id
            AND (
                v.kjwo = w.kjwo OR v.kjwo = w.kjwo - 1
            )
    INNER JOIN dbp_data.art_2 AS xx
        ON v.mandant_id = xx.mandant_id AND v.art_id = xx.art_id
    LEFT JOIN dbp_data.marktbestand_erp_2 AS x
        ON
            w.mandant_id = x.mandant_id
            AND w.wup_id = x.wup_id
            AND w.art_id = x.art_id
            AND w.dat = x.dat
            AND x.dat < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id;

        /* Anzahl Nullbestand Tag_2 2 */
    UPDATE `_test_we_mbst2a_not_in` SET anz_null_tag2 = CAST(b.anz_null_tag2 AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(
                CASE
                    WHEN
                        xx.gewart_id = 'ST'
                        AND a.menge_lgbest_erp_frei_bme = 0
                        OR xx.gewart_id = 'KG'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                        OR xx.gewart_id = 'G'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                        THEN 1
                    ELSE 0
                END
            ) AS anz_null_tag2
        FROM dbp_data.marktbestand_erp_2 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.tag_2 AS b
                ON b.dat = DATE_ADD(a0.dat_von, INTERVAL '1' DAY) AND a0.dat_bis >= b.dat
            GROUP BY
                a0.werbetyp_id,
                a0.dat_von,
                a0.dat_bis,
                a0.wup_id,
                a0.mandant_id,
                a0.art_id,
                b.dat
        ) AS w
            ON
                a.mandant_id = w.mandant_id
                AND a.wup_id = w.wup_id
                AND a.art_id = w.art_id
                AND a.dat = w.dat
                AND a.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS xx
            ON w.mandant_id = xx.mandant_id AND w.art_id = xx.art_id
        GROUP BY
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a_not_in`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_not_in`.wup_id = b.wup_id
        AND `_test_we_mbst2a_not_in`.art_id = b.art_id
        AND `_test_we_mbst2a_not_in`.dat_von = b.dat_von
        AND `_test_we_mbst2a_not_in`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_not_in`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_2 3 */
    UPDATE `_test_we_mbst2a_not_in` SET anz_null_tag3 = CAST(b.anz_null_tag3 AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(
                CASE
                    WHEN
                        xx.gewart_id = 'ST'
                        AND a.menge_lgbest_erp_frei_bme = 0
                        OR xx.gewart_id = 'KG'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                        OR xx.gewart_id = 'G'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                        THEN 1
                    ELSE 0
                END
            ) AS anz_null_tag3
        FROM dbp_data.marktbestand_erp_2 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.tag_2 AS b
                ON b.dat = DATE_ADD(a0.dat_von, INTERVAL '2' DAY) AND a0.dat_bis >= b.dat
            GROUP BY
                a0.werbetyp_id,
                a0.dat_von,
                a0.dat_bis,
                a0.wup_id,
                a0.mandant_id,
                a0.art_id,
                b.dat
        ) AS w
            ON
                a.mandant_id = w.mandant_id
                AND a.wup_id = w.wup_id
                AND a.art_id = w.art_id
                AND a.dat = w.dat
                AND a.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS xx
            ON w.mandant_id = xx.mandant_id AND w.art_id = xx.art_id
        GROUP BY
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a_not_in`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_not_in`.wup_id = b.wup_id
        AND `_test_we_mbst2a_not_in`.art_id = b.art_id
        AND `_test_we_mbst2a_not_in`.dat_von = b.dat_von
        AND `_test_we_mbst2a_not_in`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_not_in`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_2 4 */
    UPDATE `_test_we_mbst2a_not_in` SET anz_null_tag4 = CAST(b.anz_null_tag4 AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(
                CASE
                    WHEN
                        xx.gewart_id = 'ST'
                        AND a.menge_lgbest_erp_frei_bme = 0
                        OR xx.gewart_id = 'KG'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                        OR xx.gewart_id = 'G'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                        THEN 1
                    ELSE 0
                END
            ) AS anz_null_tag4
        FROM dbp_data.marktbestand_erp_2 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.tag_2 AS b
                ON b.dat = DATE_ADD(a0.dat_von, INTERVAL '3' DAY) AND a0.dat_bis >= b.dat
            GROUP BY
                a0.werbetyp_id,
                a0.dat_von,
                a0.dat_bis,
                a0.wup_id,
                a0.mandant_id,
                a0.art_id,
                b.dat
        ) AS w
            ON
                a.mandant_id = w.mandant_id
                AND a.wup_id = w.wup_id
                AND a.art_id = w.art_id
                AND a.dat = w.dat
                AND a.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS xx
            ON w.mandant_id = xx.mandant_id AND w.art_id = xx.art_id
        GROUP BY
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a_not_in`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_not_in`.wup_id = b.wup_id
        AND `_test_we_mbst2a_not_in`.art_id = b.art_id
        AND `_test_we_mbst2a_not_in`.dat_von = b.dat_von
        AND `_test_we_mbst2a_not_in`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_not_in`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_2 5 */
    UPDATE `_test_we_mbst2a_not_in` SET anz_null_tag5 = CAST(b.anz_null_tag5 AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(
                CASE
                    WHEN
                        xx.gewart_id = 'ST'
                        AND a.menge_lgbest_erp_frei_bme = 0
                        OR xx.gewart_id = 'KG'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                        OR xx.gewart_id = 'G'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                        THEN 1
                    ELSE 0
                END
            ) AS anz_null_tag5
        FROM dbp_data.marktbestand_erp_2 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.tag_2 AS b
                ON b.dat = DATE_ADD(a0.dat_von, INTERVAL '4' DAY) AND a0.dat_bis >= b.dat
            GROUP BY
                a0.werbetyp_id,
                a0.dat_von,
                a0.dat_bis,
                a0.wup_id,
                a0.mandant_id,
                a0.art_id,
                b.dat
        ) AS w
            ON
                a.mandant_id = w.mandant_id
                AND a.wup_id = w.wup_id
                AND a.art_id = w.art_id
                AND a.dat = w.dat
                AND a.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS xx
            ON w.mandant_id = xx.mandant_id AND w.art_id = xx.art_id
        GROUP BY
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a_not_in`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_not_in`.wup_id = b.wup_id
        AND `_test_we_mbst2a_not_in`.art_id = b.art_id
        AND `_test_we_mbst2a_not_in`.dat_von = b.dat_von
        AND `_test_we_mbst2a_not_in`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_not_in`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_2 6 */
    UPDATE `_test_we_mbst2a_not_in` SET anz_null_tag6 = CAST(b.anz_null_tag6 AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(
                CASE
                    WHEN
                        xx.gewart_id = 'ST'
                        AND a.menge_lgbest_erp_frei_bme = 0
                        OR xx.gewart_id = 'KG'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                        OR xx.gewart_id = 'G'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                        THEN 1
                    ELSE 0
                END
            ) AS anz_null_tag6
        FROM dbp_data.marktbestand_erp_2 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.tag_2 AS b
                ON b.dat = DATE_ADD(a0.dat_von, INTERVAL '5' DAY) AND a0.dat_bis >= b.dat
            GROUP BY
                a0.werbetyp_id,
                a0.dat_von,
                a0.dat_bis,
                a0.wup_id,
                a0.mandant_id,
                a0.art_id,
                b.dat
        ) AS w
            ON
                a.mandant_id = w.mandant_id
                AND a.wup_id = w.wup_id
                AND a.art_id = w.art_id
                AND a.dat = w.dat
                AND a.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS xx
            ON w.mandant_id = xx.mandant_id AND w.art_id = xx.art_id
        GROUP BY
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a_not_in`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_not_in`.wup_id = b.wup_id
        AND `_test_we_mbst2a_not_in`.art_id = b.art_id
        AND `_test_we_mbst2a_not_in`.dat_von = b.dat_von
        AND `_test_we_mbst2a_not_in`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_not_in`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_2 7 */
    UPDATE `_test_we_mbst2a_not_in` SET anz_null_tag7 = CAST(b.anz_null_tag7 AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(
                CASE
                    WHEN
                        xx.gewart_id = 'ST'
                        AND a.menge_lgbest_erp_frei_bme = 0
                        OR xx.gewart_id = 'KG'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                        OR xx.gewart_id = 'G'
                        AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                        THEN 1
                    ELSE 0
                END
            ) AS anz_null_tag7
        FROM dbp_data.marktbestand_erp_2 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_2` AS a0
            INNER JOIN dbp_data.tag_2 AS b
                ON b.dat = DATE_ADD(a0.dat_von, INTERVAL '6' DAY) AND a0.dat_bis >= b.dat
            GROUP BY
                a0.werbetyp_id,
                a0.dat_von,
                a0.dat_bis,
                a0.wup_id,
                a0.mandant_id,
                a0.art_id,
                b.dat
        ) AS w
            ON
                a.mandant_id = w.mandant_id
                AND a.wup_id = w.wup_id
                AND a.art_id = w.art_id
                AND a.dat = w.dat
                AND a.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS xx
            ON w.mandant_id = xx.mandant_id AND w.art_id = xx.art_id
        GROUP BY
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a_not_in`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_not_in`.wup_id = b.wup_id
        AND `_test_we_mbst2a_not_in`.art_id = b.art_id
        AND `_test_we_mbst2a_not_in`.dat_von = b.dat_von
        AND `_test_we_mbst2a_not_in`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_not_in`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2b_not_in AS
    SELECT
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        SUM(
            CASE
                WHEN
                    xx.gewart_id = 'ST'
                    AND x.menge_lgbest_erp_frei_bme = 0
                    OR xx.gewart_id = 'KG'
                    AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090
                    OR xx.gewart_id = 'G'
                    AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END
        ) AS anz_null_tag1_bis_tag3,
        SUM(
            CASE
                WHEN
                    xx.gewart_id = 'ST'
                    AND x.menge_lgbest_erp_frei_bme < 0
                    OR xx.gewart_id = 'KG'
                    AND x.menge_lgbest_erp_frei_bme < 0.000
                    OR xx.gewart_id = 'G'
                    AND x.menge_lgbest_erp_frei_bme < 0.000
                    THEN 1
                ELSE 0
            END
        ) AS anz_minus_tag1_bis_tag3
    FROM `_ff_we4_not_in` AS v
    INNER JOIN (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von,
            a.dat_bis,
            b.dat,
            a.kjwo
        FROM `_werbeartikel_1_2` AS a
        INNER JOIN dbp_data.tag_2 AS b
            ON
                b.dat BETWEEN a.dat_von AND a.dat_bis
                AND b.dat BETWEEN a.dat_von AND (
                    DATE_ADD(a.dat_von, INTERVAL '2' DAY)
                )
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_von,
            a.dat_bis,
            b.dat,
            a.kjwo
    ) AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.werbetyp_id = w.werbetyp_id
            AND (
                v.kjwo = w.kjwo OR v.kjwo = w.kjwo - 1
            )
    INNER JOIN dbp_data.art_2 AS xx
        ON v.mandant_id = xx.mandant_id AND v.art_id = xx.art_id
    LEFT JOIN dbp_data.marktbestand_erp_2 AS x
        ON
            w.mandant_id = x.mandant_id
            AND w.wup_id = x.wup_id
            AND w.art_id = x.art_id
            AND w.dat = x.dat
            AND x.dat < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we5_not_in AS
    SELECT
        a.kjwo,
        a.werbetyp_id,
        a.dat_von,
        a.dat_bis,
        a.mandant_id,
        a.wup_id,
        a.art_id,
        SUM(a.we_menge) AS we_menge,
        SUM(a.we_menge_2) AS we_menge_ab_vorwoche,
        SUM(a.menge_aktionsstart) AS menge_aktionsstart,
        SUM(b.menge_endbestand) AS menge_endbestand
    FROM `_ff_we4_not_in` AS a
    INNER JOIN `_test_we_mbst1_not_in` AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.kjwo = b.kjwo
            AND a.wup_id = b.wup_id
            AND a.art_id = b.art_id
            AND a.werbetyp_id = b.werbetyp_id
    GROUP BY
        a.kjwo,
        a.werbetyp_id,
        a.dat_von,
        a.dat_bis,
        a.mandant_id,
        a.wup_id,
        a.art_id;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew1_not_in (
        kjwo INT64 NOT NULL,
        werbetyp_id INT64 NOT NULL,
        dat_von DATE NOT NULL,
        dat_bis DATE NOT NULL,
        wup_id INT64 NOT NULL,
        mandant_id INT64 NOT NULL,
        art_id INT64 NOT NULL,
        nb_id INT64 NOT NULL,
        posten_id STRING(2) NOT NULL,
        umsatz_netto_mo INTEGER NOT NULL,
        umsatz_netto_di INTEGER NOT NULL,
        umsatz_netto_mi INTEGER NOT NULL,
        umsatz_netto_do INTEGER NOT NULL,
        umsatz_netto_fr INTEGER NOT NULL,
        umsatz_netto_sa INTEGER NOT NULL,
        umsatz_netto_so INTEGER NOT NULL,
        umsatz_netto_wo NUMERIC(29, 4) NOT NULL,
        menge_mo INTEGER NOT NULL,
        menge_di INTEGER NOT NULL,
        menge_mi INTEGER NOT NULL,
        menge_do INTEGER NOT NULL,
        menge_fr INTEGER NOT NULL,
        menge_sa INTEGER NOT NULL,
        menge_so INTEGER NOT NULL,
        menge_wo NUMERIC(29, 3) NOT NULL,
        menge_sa2 INTEGER NOT NULL,
        tage_menge_0 INT64 NOT NULL,
        we_menge NUMERIC(29, 3) NOT NULL,
        menge_aktionsstart NUMERIC(29, 3) NOT NULL,
        we_menge_ab_vorwoche NUMERIC(29, 3) NOT NULL,
        menge_endbestand NUMERIC(29, 3) NOT NULL,
        min_sicherh_bestand NUMERIC(29, 3) NOT NULL,
        faktor_flaki NUMERIC(29, 3) NOT NULL,
        anzahl_nullbestand INTEGER NOT NULL,
        anzahl_tage_aktion INTEGER NOT NULL,
        menge_historie_af NUMERIC(29, 3) NOT NULL,
        sollbestand NUMERIC(29, 3) NOT NULL,
        lager_prozent INTEGER NOT NULL,
        mhd_zeitraum INTEGER NOT NULL,
        menge_bestand_soll_max NUMERIC(29, 3) NOT NULL,
        menge_tag1_7bis13h NUMERIC(29, 3) NOT NULL,
        menge_nur_tag1 NUMERIC(29, 3) NOT NULL,
        bezugsweg_id INTEGER NOT NULL,
        we_menge_vor_aktion NUMERIC(29, 3) NOT NULL,
        anzahl_nullbestand_tag1 INTEGER NOT NULL,
        anzahl_nullbestand_tag2 INTEGER NOT NULL,
        anzahl_nullbestand_tag3 INTEGER NOT NULL,
        anzahl_nullbestand_tag4 INTEGER NOT NULL,
        anzahl_nullbestand_tag5 INTEGER NOT NULL,
        anzahl_nullbestand_tag6 INTEGER NOT NULL,
        anzahl_nullbestand_tag7 INTEGER NOT NULL,
        anzahl_nullbestand_tag1bis3 INTEGER NOT NULL,
        anzahl_minusbestand INTEGER NOT NULL,
        anzahl_minusbestand_tag1 INTEGER NOT NULL,
        anzahl_minusbestand_tag1bis3 INTEGER NOT NULL
    );

    INSERT INTO `_ff_we_artbew1_not_in` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        nb_id,
        posten_id,
        umsatz_netto_mo,
        umsatz_netto_di,
        umsatz_netto_mi,
        umsatz_netto_do,
        umsatz_netto_fr,
        umsatz_netto_sa,
        umsatz_netto_so,
        umsatz_netto_wo,
        menge_mo,
        menge_di,
        menge_mi,
        menge_do,
        menge_fr,
        menge_sa,
        menge_so,
        menge_wo,
        tage_menge_0,
        we_menge,
        menge_aktionsstart,
        we_menge_ab_vorwoche,
        menge_endbestand,
        min_sicherh_bestand,
        faktor_flaki,
        anzahl_nullbestand,
        anzahl_tage_aktion,
        menge_historie_af,
        sollbestand,
        lager_prozent,
        mhd_zeitraum,
        menge_bestand_soll_max,
        menge_tag1_7bis13h,
        menge_nur_tag1,
        bezugsweg_id,
        we_menge_vor_aktion,
        anzahl_nullbestand_tag1,
        anzahl_nullbestand_tag2,
        anzahl_nullbestand_tag3,
        anzahl_nullbestand_tag4,
        anzahl_nullbestand_tag5,
        anzahl_nullbestand_tag6,
        anzahl_nullbestand_tag7,
        anzahl_nullbestand_tag1bis3,
        anzahl_minusbestand,
        anzahl_minusbestand_tag1,
        anzahl_minusbestand_tag1bis3
    )
    (
        SELECT
            kjwo,
            werbetyp_id,
            dat_von,
            dat_bis,
            wup_id,
            mandant_id,
            art_id,
            0 AS nb_id,
            '' AS posten_id,
            0 AS umsatz_netto_mo,
            0 AS umsatz_netto_di,
            0 AS umsatz_netto_mi,
            0 AS umsatz_netto_do,
            0 AS umsatz_netto_fr,
            0 AS umsatz_netto_sa,
            0 AS umsatz_netto_so,
            0 AS umsatz_netto_wo,
            0 AS menge_mo,
            0 AS menge_di,
            0 AS menge_mi,
            0 AS menge_do,
            0 AS menge_fr,
            0 AS menge_sa,
            0 AS menge_so,
            0 AS menge_wo,
            CASE WHEN werbetyp_id IN (1, 2) THEN 6 WHEN werbetyp_id IN (18, 28) THEN 2 ELSE 3 END AS tage_menge_0,
            0 AS we_menge,
            0 AS menge_aktionsstart,
            0 AS we_menge_ab_vorwoche,
            0 AS menge_endbestand,
            0 AS min_sicherh_bestand,
            1 AS faktor_flaki,
            0 AS anzahl_nullbestand,
            0 AS anzahl_tage_aktion,
            0 AS menge_historie_af,
            0 AS sollbestand,
            0 AS lager_prozent,
            0 AS mhd_zeitraum,
            0 AS menge_bestand_soll_max,
            0 AS menge_tag1_7bis13h,
            0 AS menge_nur_tag1,
            -1 AS bezugsweg_id,
            0 AS we_menge_vor_aktion,
            0 AS anzahl_nullbestand_tag1,
            0 AS anzahl_nullbestand_tag2,
            0 AS anzahl_nullbestand_tag3,
            0 AS anzahl_nullbestand_tag4,
            0 AS anzahl_nullbestand_tag5,
            0 AS anzahl_nullbestand_tag6,
            0 AS anzahl_nullbestand_tag7,
            0 AS anzahl_nullbestand_tag1bis3,
            0 AS anzahl_minusbestand,
            0 AS anzahl_minusbestand_tag1,
            0 AS anzahl_minusbestand_tag1bis3
        FROM `_not_in1`
    );

    UPDATE `_ff_we_artbew1_not_in` SET we_menge = CAST(b.we_menge AS INT64), we_menge_ab_vorwoche = CAST(b.we_menge_ab_vorwoche AS INT64), we_menge_vor_aktion = CAST(b.we_menge_ab_vorwoche AS INT64), menge_aktionsstart = CAST(b.menge_aktionsstart AS INT64), menge_endbestand = CAST(b.menge_endbestand AS INT64), min_sicherh_bestand = CAST(b.min_sicherh_bestand AS INT64), sollbestand = CAST(b.sollbestand AS INT64), bezugsweg_id = CAST(b.bezugsweg_id AS INT64)
    FROM (
        SELECT
            a.kjwo,
            a.werbetyp_id,
            a.dat_von,
            a.dat_bis,
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.we_menge,
            a.we_menge_ab_vorwoche,
            a.menge_aktionsstart,
            a.menge_endbestand,
            f.min_sicherh_bestand,
            f.sollbestand,
            f.bezugsweg_id
        FROM `_ff_we5_not_in` AS a
        LEFT JOIN dbp_data.art_wup_status_per_2 AS f
            ON
                a.mandant_id = f.mandant_id
                AND a.wup_id = f.wup_id
                AND a.art_id = f.art_id
                AND f.dat_bis = CAST('9999-12-31' AS DATE)
    ) AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_not_in`.art_id = b.art_id
        AND `_ff_we_artbew1_not_in`.kjwo = b.kjwo
        AND `_ff_we_artbew1_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_not_in` SET mhd_zeitraum = CAST(b.mhd_zeitraum AS INT64), lager_prozent = CAST(b.lager_prozent AS INT64)
    FROM (
        SELECT
            a.kjwo,
            a.werbetyp_id,
            a.dat_von,
            a.dat_bis,
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.we_menge,
            a.we_menge_ab_vorwoche,
            a.menge_aktionsstart,
            a.menge_endbestand,
            f.mhd_zeitraum,
            f.lager_prozent
        FROM `_ff_we5_not_in` AS a
        LEFT JOIN dbp_data.art_2 AS f
            ON a.mandant_id = f.mandant_id AND a.art_id = f.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_not_in`.art_id = b.art_id
        AND `_ff_we_artbew1_not_in`.kjwo = b.kjwo
        AND `_ff_we_artbew1_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_not_in` SET menge_bestand_soll_max = CAST(b.menge_bestand_soll_max AS INT64)
    FROM (
        SELECT
            a.kjwo,
            a.werbetyp_id,
            a.dat_von,
            a.dat_bis,
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.we_menge,
            a.we_menge_ab_vorwoche,
            a.menge_aktionsstart,
            a.menge_endbestand,
            f.menge_bestand_soll_max
        FROM `_ff_we5_not_in` AS a
        LEFT JOIN dbp_data.art_wup_nachschub_per_2 AS f
            ON
                a.mandant_id = f.mandant_id
                AND a.wup_id = f.wup_id
                AND a.art_id = f.art_id
                AND f.dat_bis = CAST('9999-12-31' AS DATE)
    ) AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_not_in`.art_id = b.art_id
        AND `_ff_we_artbew1_not_in`.kjwo = b.kjwo
        AND `_ff_we_artbew1_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_not_in` SET anzahl_nullbestand = CAST(b.anz_tage_null AS INT64), anzahl_minusbestand = CAST(b.anz_tage_minus AS INT64)
    FROM `_test_we_mbst2_not_in` AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_not_in`.art_id = b.art_id
        AND `_ff_we_artbew1_not_in`.kjwo = b.kjwo
        AND `_ff_we_artbew1_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_not_in` SET anzahl_nullbestand_tag1 = CAST(b.anz_null_tag1 AS INT64), anzahl_minusbestand_tag1 = CAST(b.anz_minus_tag1 AS INT64), anzahl_nullbestand_tag2 = CAST(b.anz_null_tag2 AS INT64), anzahl_nullbestand_tag3 = CAST(b.anz_null_tag3 AS INT64), anzahl_nullbestand_tag4 = CAST(b.anz_null_tag4 AS INT64), anzahl_nullbestand_tag5 = CAST(b.anz_null_tag5 AS INT64), anzahl_nullbestand_tag6 = CAST(b.anz_null_tag6 AS INT64), anzahl_nullbestand_tag7 = CAST(b.anz_null_tag7 AS INT64)
    FROM `_test_we_mbst2a_not_in` AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_not_in`.art_id = b.art_id
        AND `_ff_we_artbew1_not_in`.kjwo = b.kjwo
        AND `_ff_we_artbew1_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_not_in` SET anzahl_nullbestand_tag1bis3 = b.anz_null_tag1_bis_tag3, anzahl_minusbestand_tag1bis3 = b.anz_minus_tag1_bis_tag3
    FROM `_test_we_mbst2b_not_in` AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_not_in`.art_id = b.art_id
        AND `_ff_we_artbew1_not_in`.kjwo = b.kjwo
        AND `_ff_we_artbew1_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_not_in` SET menge_historie_af = CAST(b.menge_historie_af AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            SUM(d.menge) / 36.000 AS menge_historie_af
        FROM `_ff_we_artbew1_not_in` AS a
        INNER JOIN dbp_data.woche_2 AS b
            ON a.kjwo = b.kjwo
        INNER JOIN dbp_data.woche_kj_kl_2 AS c
            ON c.akt_wo BETWEEN b.akt_wo - 6 AND (
                b.akt_wo - 1
            )
        INNER JOIN dbp_data.artbew_wo_sum_2 AS d
            ON
                a.mandant_id = d.mandant_id
                AND a.wup_id = d.wup_id
                AND a.art_id = d.art_id
                AND c.kjwo_kl = d.kjwo_kl
        WHERE
            d.bewart_id = 1001 AND d.menge >= 0
        GROUP BY
            a.wup_id,
            a.mandant_id,
            a.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_not_in`.art_id = b.art_id;

    UPDATE `_ff_we_artbew1_not_in` SET anzahl_tage_aktion = CAST(b.anz_tage_aktion AS INT64)
    FROM (
        SELECT
            mandant_id,
            werbetyp_id,
            MAX(anz_tage_aktion) AS anz_tage_aktion
        FROM `_werbetyp_tage`
        GROUP BY
            mandant_id,
            werbetyp_id
    ) AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_not_in` SET we_menge_ab_vorwoche = `_ff_we_artbew1_not_in`.we_menge + `_ff_we_artbew1_not_in`.we_menge_ab_vorwoche
    WHERE
        TRUE;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew2_not_in AS
    /* 14.09.2016, -dbay- */ /* Zuspielen der Mutter jetzt ueber die eingefrorenen Daten. */
    SELECT
        a.kjwo,
        a.werbetyp_id,
        a.dat_von,
        a.dat_bis,
        a.wup_id,
        a.mandant_id,
        a.art_id,
        a.nb_id,
        a.posten_id,
        a.umsatz_netto_mo,
        a.umsatz_netto_di,
        a.umsatz_netto_mi,
        a.umsatz_netto_do,
        a.umsatz_netto_fr,
        a.umsatz_netto_sa,
        a.umsatz_netto_so,
        a.umsatz_netto_wo,
        a.menge_mo,
        a.menge_di,
        a.menge_mi,
        a.menge_do,
        a.menge_fr,
        a.menge_sa,
        a.menge_so,
        a.menge_wo,
        a.menge_sa2,
        a.tage_menge_0,
        a.we_menge,
        a.menge_aktionsstart,
        a.we_menge_ab_vorwoche,
        a.menge_endbestand,
        a.min_sicherh_bestand,
        a.faktor_flaki,
        a.anzahl_nullbestand,
        a.anzahl_tage_aktion,
        a.menge_historie_af,
        a.sollbestand,
        a.lager_prozent,
        a.mhd_zeitraum,
        a.menge_bestand_soll_max,
        a.menge_tag1_7bis13h,
        a.menge_nur_tag1,
        a.bezugsweg_id,
        a.we_menge_vor_aktion,
        a.anzahl_nullbestand_tag1,
        a.anzahl_nullbestand_tag2,
        a.anzahl_nullbestand_tag3,
        a.anzahl_nullbestand_tag4,
        a.anzahl_nullbestand_tag5,
        a.anzahl_nullbestand_tag6,
        a.anzahl_nullbestand_tag7,
        a.anzahl_nullbestand_tag1bis3,
        a.anzahl_minusbestand,
        a.anzahl_minusbestand_tag1,
        a.anzahl_minusbestand_tag1bis3,
        b.wtag_id AS wtag_id_start,
        c.wtag_id AS wtag_id_ende,
        COALESCE(w.mutter_wb_id, d.mutter_wb_id) AS mutter_wb_id,
        w.avq_relevant_fg,
        w.vk_vor_aktion_brutto,
        w.vk_aktion_brutto,
        w.vk_kcard_brutto
    FROM `_ff_we_artbew1_not_in` AS a
    INNER JOIN dbp_data.tag_2 AS b
        ON CASE
            WHEN a.werbetyp_id = 1
                THEN DATE_ADD(a.dat_von, INTERVAL '1' DAY)
            ELSE a.dat_von
        END = b.dat
    INNER JOIN dbp_data.tag_2 AS c
        ON a.dat_bis = c.dat
    INNER JOIN `_werbeartikel_1_2` AS w
        ON
            a.mandant_id = w.mandant_id
            AND a.wup_id = w.wup_id
            AND a.art_id = w.art_id
            AND a.dat_von BETWEEN w.dat_von AND w.dat_bis
            AND a.werbetyp_id = w.werbetyp_id
    LEFT JOIN `_ff_mutter_art` AS d
        ON a.mandant_id = d.mandant_id AND a.art_id = d.art_id;

    DELETE FROM dbp_data.werbung_kennzahlen_woche_2
    WHERE
        (kjwo, werbe_typ_id, wup_id, art_id) IN (
            SELECT (kjwo, werbetyp_id, wup_id, art_id)
            FROM `_ff_we_artbew2_not_in`
        );

    INSERT INTO dbp_data.werbung_kennzahlen_woche_2 (
        mandant_id,
        kjwo,
        wup_id,
        nb_id,
        art_id,
        werbe_typ_id,
        menge_tag1,
        menge_tag2,
        menge_tag3,
        menge_tag4,
        menge_tag5,
        menge_tag6,
        menge_tag7,
        menge_nur_tag1,
        tage_menge_0,
        menge_endbestand,
        menge_aktionsstart,
        umsatz_netto_tag1,
        umsatz_netto_tag2,
        umsatz_netto_tag3,
        umsatz_netto_tag4,
        umsatz_netto_tag5,
        umsatz_netto_tag6,
        umsatz_netto_tag7,
        we_menge,
        min_sicherh_bestand,
        posten_id,
        we_menge_zentral,
        faktor_flaki,
        mutter_wb_id,
        wtag_id_start,
        wtag_id_ende,
        menge_historie_af,
        anzahl_nullbestand,
        anzahl_tage_aktion,
        menge_tag1_7bis13h,
        lager_prozent,
        mhd_zeitraum,
        sollbestand,
        menge_bestand_soll_max,
        werbenachvermarktung_fg,
        we_menge_vor_aktion,
        art_mutter_bezugsweg_id,
        anzahl_nullbestand_tag1,
        anzahl_nullbestand_tag2,
        anzahl_nullbestand_tag3,
        anzahl_nullbestand_tag4,
        anzahl_nullbestand_tag5,
        anzahl_nullbestand_tag6,
        anzahl_nullbestand_tag7,
        anzahl_nullbestand_tag1bis3,
        anzahl_minusbestand,
        anzahl_minusbestand_tag1,
        anzahl_minusbestand_tag1bis3,
        avq_relevant_fg,
        wrg_id,
        menge_sa,
        vk_vor_aktion_brutto,
        vk_aktion_brutto,
        vk_kcard_brutto,
        td_update,
        td_insert
    )
    (
        SELECT
            mandant_id,
            kjwo,
            wup_id,
            nb_id,
            art_id,
            werbetyp_id AS werbe_typ_id,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_mo
                WHEN werbetyp_id IN (26)
                    THEN menge_di
                WHEN werbetyp_id IN (27)
                    THEN menge_mi
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_do
                WHEN werbetyp_id IN (16)
                    THEN menge_sa
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_fr
                ELSE 0
            END AS NUMERIC) AS menge_tag1,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_di
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_fr
                WHEN werbetyp_id IN (16)
                    THEN menge_so
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_sa
                ELSE 0
            END AS NUMERIC) AS menge_tag2,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_mi
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_sa
                WHEN werbetyp_id IN (16)
                    THEN menge_mo
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_so
                ELSE 0
            END AS NUMERIC) AS menge_tag3,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_do
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_so
                WHEN werbetyp_id IN (16)
                    THEN menge_di
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_mo
                ELSE 0
            END AS NUMERIC) AS menge_tag4,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_fr
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_mo
                WHEN werbetyp_id IN (16)
                    THEN menge_mi
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_di
                ELSE 0
            END AS NUMERIC) AS menge_tag5,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_sa
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_di
                WHEN werbetyp_id IN (16)
                    THEN menge_do
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_mi
                ELSE 0
            END AS NUMERIC) AS menge_tag6,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN menge_so
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN menge_mi
                WHEN werbetyp_id IN (16)
                    THEN menge_fr
                WHEN werbetyp_id IN (18, 28)
                    THEN menge_do
                ELSE 0
            END AS NUMERIC) AS menge_tag7,
            menge_nur_tag1,
            tage_menge_0,
            menge_endbestand,
            menge_aktionsstart,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_mo
                WHEN werbetyp_id IN (26)
                    THEN umsatz_netto_di
                WHEN werbetyp_id IN (27)
                    THEN umsatz_netto_mi
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_do
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_sa
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_fr
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag1,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_di
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_fr
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_so
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_sa
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag2,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_mi
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_sa
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_mo
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_so
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag3,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_do
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_so
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_di
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_mo
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag4,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_fr
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_mo
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_mi
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_di
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag5,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_sa
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_di
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_do
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_mi
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag6,
            CAST(CASE
                WHEN werbetyp_id IN (1, 3, 25)
                    THEN umsatz_netto_so
                WHEN werbetyp_id IN (2, 4, 15)
                    THEN umsatz_netto_mi
                WHEN werbetyp_id IN (16)
                    THEN umsatz_netto_fr
                WHEN werbetyp_id IN (18, 28)
                    THEN umsatz_netto_do
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag7,
            we_menge,
            min_sicherh_bestand,
            posten_id,
            we_menge_ab_vorwoche AS we_menge_zentral,
            faktor_flaki,
            COALESCE(mutter_wb_id, art_id) AS mutter_wb_id,
            wtag_id_start,
            wtag_id_ende,
            menge_historie_af,
            CAST(CASE
                WHEN anzahl_tage_aktion < anzahl_nullbestand
                    THEN anzahl_tage_aktion
                ELSE anzahl_nullbestand
            END AS INT64) AS anzahl_nullbestand,
            CAST(anzahl_tage_aktion AS INT64) AS anzahl_tage_aktion,
            menge_tag1_7bis13h,
            CAST(lager_prozent AS INT64) AS lager_prozent,
            CAST(mhd_zeitraum AS INT64) AS mhd_zeitraum,
            sollbestand,
            menge_bestand_soll_max,
            0 AS werbenachvermarktung_fg,
            we_menge_vor_aktion,
            CAST(bezugsweg_id AS INT64) AS bezugsweg_id,
            CAST(anzahl_nullbestand_tag1 AS INT64) AS anzahl_nullbestand_tag1,
            CAST(anzahl_nullbestand_tag2 AS INT64) AS anzahl_nullbestand_tag2,
            CAST(anzahl_nullbestand_tag3 AS INT64) AS anzahl_nullbestand_tag3,
            CAST(anzahl_nullbestand_tag4 AS INT64) AS anzahl_nullbestand_tag4,
            CAST(anzahl_nullbestand_tag5 AS INT64) AS anzahl_nullbestand_tag5,
            CAST(anzahl_nullbestand_tag6 AS INT64) AS anzahl_nullbestand_tag6,
            CAST(anzahl_nullbestand_tag7 AS INT64) AS anzahl_nullbestand_tag7,
            CAST(anzahl_nullbestand_tag1bis3 AS INT64) AS anzahl_nullbestand_tag1bis3,
            CAST(anzahl_minusbestand AS INT64) AS anzahl_minusbestand,
            CAST(anzahl_minusbestand_tag1 AS INT64) AS anzahl_minusbestand_tag1,
            CAST(anzahl_minusbestand_tag1bis3 AS INT64) AS anzahl_minusbestand_tag1bis3,
            avq_relevant_fg,
            'EUR' AS wrg_id,
            CAST(COALESCE(menge_sa, 0) AS NUMERIC) AS menge_sa,
            vk_vor_aktion_brutto,
            vk_aktion_brutto,
            vk_kcard_brutto,
            CURRENT_TIMESTAMP(),
            CURRENT_TIMESTAMP()
        FROM `_ff_we_artbew2_not_in`
    );

    CREATE OR REPLACE TEMPORARY TABLE _preis_mutter AS
    SELECT
        a.mandant_id,
        a.kjwo,
        a.wup_id,
        a.werbe_typ_id,
        a.mutter_wb_id,
        x.vk_brutto AS preis
    FROM dbp_data.werbung_kennzahlen_woche_2 AS a
    INNER JOIN `_werbeartikel_1_2` AS x
        ON
            a.kjwo = x.kjwo
            AND a.werbe_typ_id = x.werbetyp_id
            AND a.mandant_id = x.mandant_id
            AND a.wup_id = x.wup_id
            AND a.mutter_wb_id = x.art_id
    INNER JOIN dbp_data.art_wg_zu_per_2 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.mutter_wb_id = b.art_id
            AND b.dat_bis = CAST('9999-12-31' AS DATE)
            AND b.arthiertyp_id = 2
    WHERE
        a.mutter_wb_id = a.art_id
        AND b.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 31 AND mandant_id = 1
        )
        AND a.kjwo IN (
            SELECT kjwo
            FROM dbp_data.tag_2
            WHERE
                akt_wo = wkw
        )
        AND x.vk_brutto <> 0;

    CREATE OR REPLACE TEMPORARY TABLE _preis_kind AS
    SELECT
        a.mandant_id,
        a.kjwo,
        a.werbe_typ_id,
        a.wup_id,
        a.art_id,
        a.mutter_wb_id,
        x.vk_brutto AS preis_kind,
        b.preis AS preis_mutter,
        CAST(COALESCE(
            CAST(b.preis AS NUMERIC) / IF(CAST(x.vk_brutto AS NUMERIC) = 0, NULL, CAST(x.vk_brutto AS NUMERIC)),
            1
        ) AS NUMERIC) AS faktor
    FROM dbp_data.werbung_kennzahlen_woche_2 AS a
    INNER JOIN `_werbeartikel_1_2` AS x
        ON
            a.kjwo = x.kjwo
            AND a.werbe_typ_id = x.werbetyp_id
            AND a.mandant_id = x.mandant_id
            AND a.wup_id = x.wup_id
            AND a.art_id = x.art_id
    INNER JOIN `_preis_mutter` AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.mutter_wb_id = b.mutter_wb_id
            AND a.wup_id = b.wup_id
            AND a.kjwo = b.kjwo
            AND a.werbe_typ_id = b.werbe_typ_id;

    UPDATE dbp_data.werbung_kennzahlen_woche_2 SET faktor_flaki = CAST(b.faktor AS INT64)
    FROM (
        SELECT *
        FROM `_preis_kind`
        GROUP BY
            mandant_id,
            kjwo,
            werbe_typ_id,
            wup_id,
            art_id,
            mutter_wb_id,
            preis_kind,
            preis_mutter,
            faktor
    ) AS b
    WHERE
        werbung_kennzahlen_woche.mandant_id = b.mandant_id
        AND werbung_kennzahlen_woche.wup_id = b.wup_id
        AND werbung_kennzahlen_woche.kjwo = b.kjwo
        AND werbung_kennzahlen_woche.art_id = b.art_id
        AND werbung_kennzahlen_woche.mutter_wb_id = b.mutter_wb_id
        AND werbung_kennzahlen_woche.werbe_typ_id = b.werbe_typ_id;

    DELETE FROM dbp_data.werbung_kennzahlen_woche_2
    WHERE
        (mandant_id, art_id) IN (
            SELECT (mandant_id, kopf_art)
            FROM `_stpo`
        )
        AND menge_tag1 + menge_tag2 + menge_tag3 + menge_tag4 + menge_tag5 + menge_tag6 + menge_tag7 = 0
        AND kjwo IN (
            SELECT kjwo
            FROM dbp_data.tag_2
            WHERE
                akt_wo = wkw
        );

    CREATE OR REPLACE TEMPORARY TABLE _raus_xxx AS
    SELECT
        mandant_id,
        kjwo,
        wup_id,
        nb_id,
        art_id,
        werbe_typ_id,
        menge_tag1,
        menge_tag2,
        menge_tag3,
        menge_tag4,
        menge_tag5,
        menge_tag6,
        menge_tag7,
        menge_nur_tag1,
        tage_menge_0,
        menge_endbestand,
        menge_aktionsstart,
        umsatz_netto_tag1,
        umsatz_netto_tag2,
        umsatz_netto_tag3,
        umsatz_netto_tag4,
        umsatz_netto_tag5,
        umsatz_netto_tag6,
        umsatz_netto_tag7,
        we_menge,
        min_sicherh_bestand,
        posten_id,
        we_menge_zentral,
        faktor_flaki,
        mutter_wb_id,
        wtag_id_start,
        wtag_id_ende,
        menge_historie_af,
        anzahl_nullbestand,
        anzahl_tage_aktion,
        menge_tag1_7bis13h,
        lager_prozent,
        mhd_zeitraum,
        sollbestand,
        menge_bestand_soll_max,
        werbenachvermarktung_fg,
        we_menge_vor_aktion,
        art_mutter_bezugsweg_id,
        anzahl_nullbestand_tag1,
        anzahl_nullbestand_tag2,
        anzahl_nullbestand_tag3,
        anzahl_nullbestand_tag4,
        anzahl_nullbestand_tag5,
        anzahl_nullbestand_tag6,
        anzahl_nullbestand_tag7,
        anzahl_nullbestand_tag1bis3,
        anzahl_minusbestand,
        anzahl_minusbestand_tag1,
        anzahl_minusbestand_tag1bis3,
        avq_relevant_fg,
        wrg_id,
        menge_sa,
        vk_vor_aktion_brutto,
        vk_aktion_brutto,
        vk_kcard_brutto,
        td_update,
        td_insert
    FROM dbp_data.werbung_kennzahlen_woche_2 AS a
    WHERE
        mandant_id = 1
        AND kjwo IN (
            SELECT kjwo
            FROM dbp_data.tag_2
            WHERE
                akt_wo = wkw
        )
        AND menge_tag1 + menge_tag2 + menge_tag3 + menge_tag4 + menge_tag5 + menge_tag6 + menge_tag7 = 0
        AND we_menge_zentral <> 0
        AND (mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl_process.art_gtin_2
            GROUP BY
                art_id,
                mandant_id
            HAVING
                COUNT(DISTINCT gtin_typ_id) = 1 AND MAX(gtin_typ_id) = 'IE'
        );

    DELETE FROM dbp_data.werbung_kennzahlen_woche_2
    WHERE
        (kjwo, mandant_id, wup_id, art_id, werbe_typ_id) IN (
            SELECT (kjwo, mandant_id, wup_id, art_id, werbe_typ_id)
            FROM `_raus_xxx`
        );

    CREATE OR REPLACE TEMPORARY TABLE _we_upd_candidates AS
    SELECT
        t7.kjwo,
        t7.werbe_typ_id,
        t7.mandant_id,
        t7.wup_id,
        t7.art_id,
        t7.mutter_wb_id,
        t7.we_menge_zentral,
        t7.menge_
    FROM (
        SELECT
            a.kjwo,
            a.werbe_typ_id,
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.mutter_wb_id,
            SUM(a.we_menge_zentral) AS we_menge_zentral,
            SUM(
                a.menge_tag1 + a.menge_tag2 + a.menge_tag3 + a.menge_tag4 + a.menge_tag5 + a.menge_tag6 + a.menge_tag7
            ) AS menge_,
            SUM(a.we_menge_zentral) AS z0
        FROM dbp_data.werbung_kennzahlen_woche_2 AS a
        INNER JOIN dbp_data.art_wg_zu_per_2 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.art_id = b.art_id
                AND b.arthiertyp_id = 2
                AND b.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            b.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 44 AND mandant_id = 1
            )
            AND a.mandant_id = 1
            AND a.kjwo IN (
                SELECT kjwo
                FROM dbp_data.tag_2
                WHERE
                    akt_wo = wkw
            )
        GROUP BY
            a.kjwo,
            a.werbe_typ_id,
            a.mandant_id,
            a.wup_id,
            a.art_id,
            a.mutter_wb_id
        HAVING
            we_menge_zentral = 0 AND menge_ <> 0
    ) AS t7;

    CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art_we_upd AS
    SELECT
        mandant_id,
        art_id,
        COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
    FROM dbp_data.art_2 AS a
    WHERE
        dat_bis = CAST('9999-12-31' AS DATE) AND mandant_id = 1
    GROUP BY
        mandant_id,
        art_id,
        a.mutter_wb_id;

    CREATE OR REPLACE TEMPORARY TABLE _singles AS
    SELECT mutter_wb_id
    FROM `_ff_mutter_art_we_upd`
    GROUP BY
        mutter_wb_id
    HAVING
        COUNT(*) = 1;

    DELETE FROM `_we_upd_candidates`
    WHERE
        mutter_wb_id IN (
            SELECT mutter_wb_id
            FROM `_singles`
        );

    CREATE OR REPLACE TEMPORARY TABLE _multiples AS
    SELECT
        mutter_wb_id,
        COUNT(*) AS anzahl
    FROM `_ff_mutter_art_we_upd`
    GROUP BY
        mutter_wb_id
    HAVING
        anzahl > 1;

    DELETE FROM `_we_upd_candidates`
    WHERE
        (mandant_id, kjwo, werbe_typ_id, mutter_wb_id) IN (
            SELECT (a.mandant_id, a.kjwo, a.werbe_typ_id, a.mutter_wb_id)
            FROM dbp_data.werbung_kennzahlen_woche_2 AS a
            INNER JOIN `_multiples` AS b
                ON a.mutter_wb_id = b.mutter_wb_id
            WHERE
                a.mandant_id = 1
                AND a.kjwo IN (
                    SELECT kjwo
                    FROM dbp_data.tag_2
                    WHERE
                        akt_wo = wkw
                )
            GROUP BY
                a.mandant_id,
                a.kjwo,
                a.werbe_typ_id,
                a.mutter_wb_id
            HAVING
                SUM(a.we_menge_zentral) = 0
        );

    UPDATE dbp_data.werbung_kennzahlen_woche_2 SET we_menge_zentral = 0.001
    FROM `_we_upd_candidates` AS b
    WHERE
        werbung_kennzahlen_woche.kjwo = b.kjwo
        AND werbung_kennzahlen_woche.werbe_typ_id = b.werbe_typ_id
        AND werbung_kennzahlen_woche.mandant_id = b.mandant_id
        AND werbung_kennzahlen_woche.wup_id = b.wup_id
        AND werbung_kennzahlen_woche.art_id = b.art_id
        AND werbung_kennzahlen_woche.we_menge_zentral = 0;

    CREATE OR REPLACE TEMPORARY TABLE _murks_2 AS
    SELECT
        kjwo,
        wup_id,
        mandant_id,
        art_id,
        werbe_typ_id,
        MAX(posten_id) AS posten_id,
        COUNT(*) AS anz
    FROM dbp_data.werbung_kennzahlen_woche_2
    WHERE
        NOT we_menge_zentral IN (0, 0.001)
    GROUP BY
        mandant_id,
        kjwo,
        wup_id,
        art_id,
        werbe_typ_id
    HAVING
        anz > 1;

    CREATE OR REPLACE TEMPORARY TABLE _track01 AS
    SELECT DISTINCT
        a.mandant_id,
        a.kjwo,
        a.wup_id,
        a.nb_id,
        a.art_id,
        a.werbe_typ_id,
        a.menge_tag1,
        a.menge_tag2,
        a.menge_tag3,
        a.menge_tag4,
        a.menge_tag5,
        a.menge_tag6,
        a.menge_tag7,
        a.menge_nur_tag1,
        a.tage_menge_0,
        a.menge_endbestand,
        a.menge_aktionsstart,
        a.umsatz_netto_tag1,
        a.umsatz_netto_tag2,
        a.umsatz_netto_tag3,
        a.umsatz_netto_tag4,
        a.umsatz_netto_tag5,
        a.umsatz_netto_tag6,
        a.umsatz_netto_tag7,
        a.we_menge,
        a.min_sicherh_bestand,
        a.posten_id,
        a.we_menge_zentral,
        a.faktor_flaki,
        a.mutter_wb_id,
        a.wtag_id_start,
        a.wtag_id_ende,
        a.menge_historie_af,
        a.anzahl_nullbestand,
        a.anzahl_tage_aktion,
        a.menge_tag1_7bis13h,
        a.lager_prozent,
        a.mhd_zeitraum,
        a.sollbestand,
        a.menge_bestand_soll_max,
        a.werbenachvermarktung_fg,
        a.we_menge_vor_aktion,
        a.art_mutter_bezugsweg_id,
        a.anzahl_nullbestand_tag1,
        a.anzahl_nullbestand_tag2,
        a.anzahl_nullbestand_tag3,
        a.anzahl_nullbestand_tag4,
        a.anzahl_nullbestand_tag5,
        a.anzahl_nullbestand_tag6,
        a.anzahl_nullbestand_tag7,
        a.anzahl_nullbestand_tag1bis3,
        a.anzahl_minusbestand,
        a.anzahl_minusbestand_tag1,
        a.anzahl_minusbestand_tag1bis3,
        a.avq_relevant_fg,
        a.wrg_id,
        a.menge_sa,
        a.vk_vor_aktion_brutto,
        a.vk_aktion_brutto,
        a.vk_kcard_brutto,
        a.td_update,
        a.td_insert
    FROM dbp_data.werbung_kennzahlen_woche_2 AS a
    INNER JOIN `_murks_2` AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.wup_id = b.wup_id
            AND a.werbe_typ_id = b.werbe_typ_id
            AND a.kjwo = b.kjwo
            AND a.posten_id = b.posten_id
            AND a.art_id = b.art_id;

    DELETE FROM dbp_data.werbung_kennzahlen_woche_2
    WHERE
        (kjwo, wup_id, mandant_id, art_id, werbe_typ_id) IN (
            SELECT (kjwo, wup_id, mandant_id, art_id, werbe_typ_id)
            FROM `_track01`
        );

    INSERT INTO dbp_data.werbung_kennzahlen_woche_2
    (
        SELECT
            mandant_id,
            kjwo,
            wup_id,
            nb_id,
            art_id,
            werbe_typ_id,
            menge_tag1,
            menge_tag2,
            menge_tag3,
            menge_tag4,
            menge_tag5,
            menge_tag6,
            menge_tag7,
            menge_nur_tag1,
            tage_menge_0,
            menge_endbestand,
            menge_aktionsstart,
            umsatz_netto_tag1,
            umsatz_netto_tag2,
            umsatz_netto_tag3,
            umsatz_netto_tag4,
            umsatz_netto_tag5,
            umsatz_netto_tag6,
            umsatz_netto_tag7,
            we_menge,
            min_sicherh_bestand,
            posten_id,
            we_menge_zentral,
            faktor_flaki,
            mutter_wb_id,
            wtag_id_start,
            wtag_id_ende,
            menge_historie_af,
            anzahl_nullbestand,
            anzahl_tage_aktion,
            menge_tag1_7bis13h,
            lager_prozent,
            mhd_zeitraum,
            sollbestand,
            menge_bestand_soll_max,
            werbenachvermarktung_fg,
            we_menge_vor_aktion,
            art_mutter_bezugsweg_id,
            anzahl_nullbestand_tag1,
            anzahl_nullbestand_tag2,
            anzahl_nullbestand_tag3,
            anzahl_nullbestand_tag4,
            anzahl_nullbestand_tag5,
            anzahl_nullbestand_tag6,
            anzahl_nullbestand_tag7,
            anzahl_nullbestand_tag1bis3,
            anzahl_minusbestand,
            anzahl_minusbestand_tag1,
            anzahl_minusbestand_tag1bis3,
            avq_relevant_fg,
            wrg_id,
            menge_sa,
            vk_vor_aktion_brutto,
            vk_aktion_brutto,
            vk_kcard_brutto,
            td_update,
            td_insert
        FROM `_track01`
    );

    DELETE FROM dbp_data.werbung_kennzahlen_woche_2
    WHERE
        (mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl_process.avq_obsolete_artikel_2
        );

    DELETE FROM dbp_data.avq_aktualisierung_2
    WHERE
        (mandant_id, kjwo) IN (
            SELECT (mandant_id, kjwo)
            FROM `_werbeartikel_1_2`
        );

    INSERT INTO dbp_data.avq_aktualisierung_2 (
        mandant_id,
        kjwo,
        dat_letzte_aktualisierung
    )
    (
        SELECT
            mandant_id,
            kjwo,
            CAST(CURRENT_TIMESTAMP() AS DATETIME)
        FROM `_werbeartikel_1_2`
        GROUP BY
            mandant_id,
            kjwo,
            3
    );

END;
