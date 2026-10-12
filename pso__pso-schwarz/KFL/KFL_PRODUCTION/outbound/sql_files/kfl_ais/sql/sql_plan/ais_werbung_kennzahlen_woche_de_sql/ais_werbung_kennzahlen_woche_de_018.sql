BEGIN
    DECLARE wkw INT64;
    SET wkw = ${WKW};
    CREATE OR REPLACE TEMPORARY TABLE _werbeartikel_1 (
        kjwo INTEGER,
        werbetyp_id INTEGER,
        aktion_id STRING(10),
        dat_von DATE,
        dat_bis DATE,
        wup_id INTEGER,
        mandant_id INTEGER,
        art_id INTEGER,
        akt_wo INTEGER,
        vk_brutto NUMERIC(29, 2),
        mutter_wb_id INTEGER,
        avq_relevant_fg INTEGER,
        dat_sperrung DATE
    );


    INSERT INTO `_werbeartikel_1` (
        kjwo, werbetyp_id, aktion_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo,
        vk_brutto, mutter_wb_id, avq_relevant_fg, dat_sperrung
    )
    (
        SELECT
            X1.kjwo,
            2 AS werbetyp_id,
            AKTA.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(CASE
                WHEN AKTA.dat_sperrung IS NULL OR AKTA.dat_sperrung >= akt.dat_von
                    THEN akt.avq_relevant_fg
                ELSE 0
            END) AS avq_relevant_fg,
            MAX(COALESCE(AKTA.dat_sperrung, DATE '9999-12-31')) AS dat_sperrung
        FROM (
            SELECT
                A.aktion_id,
                A.mandant_id,
                A.bewart_id,
                A.aktionsart_id,
                A.werbe_kat_id,
                A.dat_von,
                A.dat_bis,
                A.preisaktiviert_fg,
                A.kjwo_von,
                A.aktion_typ_id,
                A.td_update,
                A.td_insert,
                CASE
                    WHEN A.preisaktiviert_fg = 1
                        THEN 1
                    WHEN b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion AS A
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf
                WHERE mandant_id = 1
            ) AS b
                ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
            WHERE
                A.mandant_id = 1
                AND (A.preisaktiviert_fg = 1 OR b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0)
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu AS AKTA
            ON
                akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
                AKTA.mandant_id
        INNER JOIN dbp_data.tag AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 4
        INNER JOIN dbp_data.tag AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 3 AND DATE_SUB(
                X2.dat, INTERVAL
                6 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, AKTA.wup_id, AKTA.mandant_id, AKTA.art_id, 2) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            AKTA.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );


    INSERT INTO `_werbeartikel_1` (
        kjwo, werbetyp_id, aktion_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo,
        vk_brutto, mutter_wb_id, avq_relevant_fg, dat_sperrung
    )
    (
        SELECT
            X1.kjwo,
            3 AS werbetyp_id,
            AKTA.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(CASE
                WHEN AKTA.dat_sperrung IS NULL OR AKTA.dat_sperrung >= akt.dat_von
                    THEN akt.avq_relevant_fg
                ELSE 0
            END) AS avq_relevant_fg,
            MAX(COALESCE(AKTA.dat_sperrung, DATE '9999-12-31')) AS dat_sperrung
        FROM (
            SELECT
                A.aktion_id,
                A.mandant_id,
                A.bewart_id,
                A.aktionsart_id,
                A.werbe_kat_id,
                A.dat_von,
                A.dat_bis,
                A.preisaktiviert_fg,
                A.kjwo_von,
                A.aktion_typ_id,
                A.td_update,
                A.td_insert,
                CASE
                    WHEN A.preisaktiviert_fg = 1
                        THEN 1
                    WHEN b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion AS A
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf
                WHERE mandant_id = 1
            ) AS b
                ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
            WHERE
                A.mandant_id = 1
                AND (A.preisaktiviert_fg = 1 OR b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0)
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu AS AKTA
            ON
                akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
                AKTA.mandant_id
        INNER JOIN dbp_data.tag AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 1
        INNER JOIN dbp_data.tag AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 3 AND DATE_SUB(
                X2.dat, INTERVAL
                2 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, AKTA.wup_id, AKTA.mandant_id, AKTA.art_id, 3) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            AKTA.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );


    INSERT INTO `_werbeartikel_1` (
        kjwo, werbetyp_id, aktion_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo,
        vk_brutto, mutter_wb_id, avq_relevant_fg, dat_sperrung
    )
    (
        SELECT
            X2.kjwo,
            3 AS werbetyp_id,
            AKTA.aktion_id,
            DATE_ADD(akt.dat_von, INTERVAL 1 DAY) AS dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X2.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(CASE
                WHEN AKTA.dat_sperrung IS NULL OR AKTA.dat_sperrung >= akt.dat_von
                    THEN akt.avq_relevant_fg
                ELSE 0
            END) AS avq_relevant_fg,
            MAX(COALESCE(AKTA.dat_sperrung, DATE '9999-12-31')) AS dat_sperrung
        FROM (
            SELECT
                A.aktion_id,
                A.mandant_id,
                A.bewart_id,
                A.aktionsart_id,
                A.werbe_kat_id,
                A.dat_von,
                A.dat_bis,
                A.preisaktiviert_fg,
                A.kjwo_von,
                A.aktion_typ_id,
                A.td_update,
                A.td_insert,
                CASE
                    WHEN A.preisaktiviert_fg = 1
                        THEN 1
                    WHEN b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion AS A
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf
                WHERE mandant_id = 1
            ) AS b
                ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
            WHERE
                A.mandant_id = 1
                AND (A.preisaktiviert_fg = 1 OR b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0)
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu AS AKTA
            ON
                akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
                AKTA.mandant_id
        INNER JOIN dbp_data.tag AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 7 AND X1.akt_wo = wkw - 1
        INNER JOIN dbp_data.tag AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 3 AND DATE_SUB(
                X2.dat, INTERVAL
                3 DAY
            ) = X1.dat AND X2.akt_wo = wkw
        WHERE
            akt.mandant_id = 1
            AND X1.akt_wo = wkw - 1
            AND AKTA.aktion_thema_id IN ('1072', '1075', '1310', '4001', '1300', '1311', '1312', '1320', '1330')
            AND (X1.kjwo, AKTA.wup_id, AKTA.mandant_id, AKTA.art_id, 3) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1`)
        GROUP BY
            X2.kjwo,
            werbetyp_id,
            AKTA.aktion_id,
            dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X2.akt_wo,
            vk_brutto,
            mutter_wb_id
    );


    INSERT INTO `_werbeartikel_1` (
        kjwo, werbetyp_id, aktion_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo,
        vk_brutto, mutter_wb_id, avq_relevant_fg, dat_sperrung
    )
    (
        SELECT
            X1.kjwo,
            c.werbetyp_id,
            AKTA.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(CASE
                WHEN AKTA.dat_sperrung IS NULL OR AKTA.dat_sperrung >= akt.dat_von
                    THEN akt.avq_relevant_fg
                ELSE 0
            END) AS avq_relevant_fg,
            MAX(COALESCE(AKTA.dat_sperrung, DATE '9999-12-31')) AS dat_sperrung
        FROM (
            SELECT
                A.aktion_id,
                A.mandant_id,
                A.bewart_id,
                A.aktionsart_id,
                A.werbe_kat_id,
                A.dat_von,
                A.dat_bis,
                A.preisaktiviert_fg,
                A.kjwo_von,
                A.aktion_typ_id,
                A.td_update,
                A.td_insert,
                CASE
                    WHEN A.preisaktiviert_fg = 1
                        THEN 1
                    WHEN b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion AS A
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf
                WHERE mandant_id = 1
            ) AS b
                ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
            WHERE
                A.mandant_id = 1
                AND (A.preisaktiviert_fg = 1 OR b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0)
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu AS AKTA
            ON
                akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
                AKTA.mandant_id
        INNER JOIN (SELECT
            mandant_id,
            dat_von,
            dat_bis,
            werbe_typ_id AS werbetyp_id
        FROM dbp_data.ts_avq_werbezeitraum_abw
        WHERE mandant_id = 1) AS c ON akt.mandant_id = c.mandant_id AND akt.dat_von = c.dat_von AND akt.dat_bis = c.dat_bis
        INNER JOIN dbp_data.tag AS X1 ON akt.dat_von = X1.dat
        WHERE
            akt.mandant_id = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, AKTA.wup_id, AKTA.mandant_id, AKTA.art_id, c.werbetyp_id) NOT IN (SELECT (
                kjwo, wup_id, mandant_id,
                art_id, werbetyp_id
            )
            FROM `_werbeartikel_1`)
        GROUP BY
            X1.kjwo,
            c.werbetyp_id,
            AKTA.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );


    INSERT INTO `_werbeartikel_1` (
        kjwo, werbetyp_id, aktion_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo,
        vk_brutto, mutter_wb_id, avq_relevant_fg, dat_sperrung
    )
    (
        SELECT
            X1.kjwo,
            15 AS werbetyp_id,
            AKTA.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(CASE
                WHEN AKTA.dat_sperrung IS NULL OR AKTA.dat_sperrung >= akt.dat_von
                    THEN akt.avq_relevant_fg
                ELSE 0
            END) AS avq_relevant_fg,
            MAX(COALESCE(AKTA.dat_sperrung, DATE '9999-12-31')) AS dat_sperrung
        FROM (
            SELECT
                A.aktion_id,
                A.mandant_id,
                A.bewart_id,
                A.aktionsart_id,
                A.werbe_kat_id,
                A.dat_von,
                A.dat_bis,
                A.preisaktiviert_fg,
                A.kjwo_von,
                A.aktion_typ_id,
                A.td_update,
                A.td_insert,
                CASE
                    WHEN A.preisaktiviert_fg = 1
                        THEN 1
                    WHEN b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion AS A
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf
                WHERE mandant_id = 1
            ) AS b
                ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
            WHERE
                A.mandant_id = 1
                AND (A.preisaktiviert_fg = 1 OR b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0)
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu AS AKTA
            ON
                akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
                AKTA.mandant_id
        INNER JOIN dbp_data.tag AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 4
        INNER JOIN dbp_data.tag AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 6 AND DATE_SUB(
                X2.dat, INTERVAL
                9 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, AKTA.wup_id, AKTA.mandant_id, AKTA.art_id, 15) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            AKTA.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );


    INSERT INTO `_werbeartikel_1` (
        kjwo, werbetyp_id, aktion_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo,
        vk_brutto, mutter_wb_id, avq_relevant_fg, dat_sperrung
    )
    (
        SELECT
            X1.kjwo,
            16 AS werbetyp_id,
            AKTA.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(CASE
                WHEN AKTA.dat_sperrung IS NULL OR AKTA.dat_sperrung >= akt.dat_von
                    THEN akt.avq_relevant_fg
                ELSE 0
            END) AS avq_relevant_fg,
            MAX(COALESCE(AKTA.dat_sperrung, DATE '9999-12-31')) AS dat_sperrung
        FROM (
            SELECT
                A.aktion_id,
                A.mandant_id,
                A.bewart_id,
                A.aktionsart_id,
                A.werbe_kat_id,
                A.dat_von,
                A.dat_bis,
                A.preisaktiviert_fg,
                A.kjwo_von,
                A.aktion_typ_id,
                A.td_update,
                A.td_insert,
                CASE
                    WHEN A.preisaktiviert_fg = 1
                        THEN 1
                    WHEN b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion AS A
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf
                WHERE mandant_id = 1
            ) AS b
                ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
            WHERE
                A.mandant_id = 1
                AND (A.preisaktiviert_fg = 1 OR b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0)
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu AS AKTA
            ON
                akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
                AKTA.mandant_id
        INNER JOIN dbp_data.tag AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 6
        INNER JOIN dbp_data.tag AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 6 AND DATE_SUB(
                X2.dat, INTERVAL
                0 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, AKTA.wup_id, AKTA.mandant_id, AKTA.art_id, 16) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            AKTA.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );


    INSERT INTO `_werbeartikel_1` (
        kjwo, werbetyp_id, aktion_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo,
        vk_brutto, mutter_wb_id, avq_relevant_fg, dat_sperrung
    )
    (
        SELECT
            X1.kjwo,
            18 AS werbetyp_id,
            AKTA.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            -999 AS mutter_wb_id,
            MAX(CASE
                WHEN AKTA.dat_sperrung IS NULL OR AKTA.dat_sperrung >= akt.dat_von
                    THEN akt.avq_relevant_fg
                ELSE 0
            END) AS avq_relevant_fg,
            MAX(COALESCE(AKTA.dat_sperrung, DATE '9999-12-31')) AS dat_sperrung
        FROM (
            SELECT
                A.aktion_id,
                A.mandant_id,
                A.bewart_id,
                A.aktionsart_id,
                A.werbe_kat_id,
                A.dat_von,
                A.dat_bis,
                A.preisaktiviert_fg,
                A.kjwo_von,
                A.aktion_typ_id,
                A.td_update,
                A.td_insert,
                CASE
                    WHEN A.preisaktiviert_fg = 1
                        THEN 1
                    WHEN b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0
                        THEN 0
                    ELSE NULL
                END AS avq_relevant_fg
            FROM dbp_data.aktion AS A
            LEFT JOIN (
                SELECT *
                FROM dbp_data.l_bonuskauf
                WHERE mandant_id = 1
            ) AS b
                ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
            WHERE
                A.mandant_id = 1
                AND (A.preisaktiviert_fg = 1 OR b.bonuskauf_id IS NOT NULL AND A.preisaktiviert_fg = 0)
        ) AS akt
        INNER JOIN dbp_data.aktion_art_wup_zu AS AKTA
            ON
                akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
                AKTA.mandant_id
        INNER JOIN dbp_data.tag AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 5
        INNER JOIN dbp_data.tag AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 6 AND DATE_SUB(
                X2.dat, INTERVAL
                1 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, AKTA.wup_id, AKTA.mandant_id, AKTA.art_id, 18) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            AKTA.aktion_id,
            akt.dat_von,
            akt.dat_bis,
            AKTA.wup_id,
            AKTA.mandant_id,
            AKTA.art_id,
            X1.akt_wo,
            vk_brutto,
            mutter_wb_id
    );


    CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art AS
    SELECT
        mandant_id,
        art_id,
        COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
    FROM dbp_data.art AS A
    WHERE
        dat_bis = DATE '9999-12-31'
        AND (
            mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM `_werbeartikel_1`
            GROUP BY mandant_id,
            art_id
        )
    GROUP BY
        mandant_id,
        art_id,
        mutter_wb_id;


    UPDATE `_werbeartikel_1` SET
        mutter_wb_id = b.mutter_wb_id
    FROM `_ff_mutter_art` AS b
    WHERE
        `_werbeartikel_1`.mandant_id = b.mandant_id AND `_werbeartikel_1`.art_id = b.art_id AND `_werbeartikel_1`.mutter_wb_id
        = -999;


    UPDATE `_werbeartikel_1` SET
        mutter_wb_id = `_werbeartikel_1`.art_id
    WHERE mutter_wb_id = -999;


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
        CAST(0 AS NUMERIC) AS vk_vor_aktion_brutto,
        CAST(0 AS NUMERIC) AS vk_aktion_brutto,
        CAST(0 AS NUMERIC) AS vk_kcard_brutto
    FROM `_werbeartikel_1` AS A;


    CREATE OR REPLACE TEMPORARY TABLE _werbeartikel_1 AS
    SELECT *
    FROM `_pp`;


    UPDATE `_werbeartikel_1` SET
        vk_brutto = b.vk_brutto FROM (
        SELECT
            A.art_id,
            A.mandant_id,
            A.wup_id,
            MAX(A.vk_brutto) AS vk_brutto
        FROM dbp_data.art_wup_vk_per AS A
        INNER JOIN `_werbeartikel_1` AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.wup_id = B.wup_id AND
                B.dat_von BETWEEN A.dat_von AND A.dat_bis
        GROUP BY
            A.art_id,
            A.mandant_id,
            A.wup_id
    ) AS b
    WHERE
        `_werbeartikel_1`.mandant_id = b.mandant_id AND `_werbeartikel_1`.wup_id = b.wup_id AND `_werbeartikel_1`.art_id =
        b.art_id;


    UPDATE `_werbeartikel_1` SET
        vk_vor_aktion_brutto = b.vk_vor_aktion_brutto,
        vk_aktion_brutto = b.vk_aktion_brutto FROM (
        SELECT
            A.art_id,
            A.mandant_id,
            A.wup_id,
            B.werbetyp_id,
            MAX(A.vk_vor_aktion_brutto) AS vk_vor_aktion_brutto,
            MIN(CASE
                WHEN A.vk_aktion_brutto > 0
                    THEN A.vk_aktion_brutto
                ELSE A.vk_vor_aktion_brutto
            END) AS vk_aktion_brutto
        FROM dbp_data.aktion AS C
        INNER JOIN dbp_data.aktion_art_wup_zu AS A ON C.mandant_id = A.mandant_id AND C.aktion_id = A.aktion_id

        INNER JOIN `_werbeartikel_1` AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.wup_id = B.wup_id AND
                B.dat_von BETWEEN C.dat_von AND C.dat_bis
        GROUP BY
            A.art_id,
            A.mandant_id,
            A.wup_id,
            B.werbetyp_id
    ) AS b
    WHERE
        `_werbeartikel_1`.mandant_id = b.mandant_id AND `_werbeartikel_1`.wup_id = b.wup_id AND `_werbeartikel_1`.art_id =
        b.art_id AND `_werbeartikel_1`.werbetyp_id = b.werbetyp_id;


    UPDATE `_werbeartikel_1` SET
        vk_kcard_brutto = t1.vk_kcard_brutto FROM (
        SELECT
            A.art_id,
            A.mandant_id,
            A.wup_id,
            B.werbetyp_id,
            MIN(D.preis_aktion) AS vk_kcard_brutto
        FROM dbp_data.aktion AS C
        INNER JOIN dbp_data.aktion_art_wup_zu AS A ON C.mandant_id = A.mandant_id AND C.aktion_id = A.aktion_id

        INNER JOIN dbp_data.pmr_angebot_art_wup_zu AS D
            ON
                0 <> A.mandant_id AND 0 <> D.mandant_id AND A.wup_id
                = D.wup_id AND A.art_id = D.art_id AND A.aktion_id = D.aktion_id
        INNER JOIN `_werbeartikel_1` AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.wup_id = B.wup_id AND
                C.dat_von = B.dat_von AND C.dat_bis = B.dat_bis
        WHERE
            D.preis_aktion <> 0
            AND C.aktion_typ_id <> 'KDP'
        GROUP BY
            A.mandant_id,
            A.art_id,
            A.wup_id,
            B.werbetyp_id
    ) AS t1
    WHERE
        `_werbeartikel_1`.mandant_id = t1.mandant_id AND `_werbeartikel_1`.wup_id = t1.wup_id AND `_werbeartikel_1`.art_id
        = t1.art_id AND `_werbeartikel_1`.werbetyp_id = t1.werbetyp_id;


    DELETE FROM `_werbeartikel_1`
    WHERE wup_id IN (
        SELECT wup_id
        FROM dbp_data.wup
        WHERE
            mandant_id = 1
            AND wup_name_v LIKE '%online%'
    );


    CREATE OR REPLACE TEMPORARY TABLE _werbeartikel_1 AS
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
    FROM `_werbeartikel_1` AS A
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


    CREATE OR REPLACE TEMPORARY TABLE _werbetyp_tage AS
    SELECT
        mandant_id,
        werbetyp_id,
        CASE
            WHEN dat_von >= CURRENT_DATE("Europe/Berlin") OR dat_bis < CURRENT_DATE("Europe/Berlin")
                THEN DATE_DIFF(dat_bis, dat_von, DAY) + 1
            ELSE DATE_DIFF(CURRENT_DATE("Europe/Berlin"), dat_von, DAY)
        END AS anz_tage_aktion
    FROM `_werbeartikel_1` AS B
    GROUP BY
        mandant_id,
        werbetyp_id,
        anz_tage_aktion;


    CREATE OR REPLACE TEMPORARY TABLE _die_tage AS
    SELECT
        B.mandant_id,
        A.dat
    FROM dbp_data.tag AS A
    INNER JOIN `_werbeartikel_1` AS B ON A.dat BETWEEN B.dat_von AND B.dat_bis
    GROUP BY
        B.mandant_id,
        A.dat;


    CREATE OR REPLACE TEMPORARY TABLE _test1_ff AS
    SELECT
        W.kjwo,
        W.werbetyp_id,
        CASE
            WHEN W.werbetyp_id = 1
                THEN DATE_ADD(W.dat_von, INTERVAL 1 DAY)
            ELSE W.dat_von
        END AS dat_von,
        W.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id,
        SUM(V.umsatz_netto) AS umsatz_netto,
        SUM(V.menge) AS menge_,
        6 - COUNT(DISTINCT V.dat) AS tage_menge_0
    FROM dbp_data.artbew AS V
    INNER JOIN `_werbeartikel_1` AS W ON V.mandant_id = W.mandant_id AND V.wup_id = W.wup_id AND V.art_id = W.art_id AND V.dat BETWEEN W.dat_von AND W.dat_bis
    WHERE (
        V.mandant_id, V.dat) IN (
        SELECT (mandant_id, dat)
        FROM `_die_tage`
    )
    GROUP BY
        W.kjwo,
        W.werbetyp_id,
        dat_von,
        W.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id
    HAVING menge_ > 0;


    CREATE OR REPLACE TEMPORARY TABLE _ff_we1 AS
    SELECT
        A.mandant_id,
        A.kjwo,
        A.dat_von,
        A.dat_bis,
        A.werbetyp_id,
        A.wup_id,
        A.nb_id,
        A.art_id
    FROM `_test1_ff` AS A
    INNER JOIN dbp_data.art_wg_zu_per
        AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
    = 2 AND B.dat_bis = DATE '9999-12-31';


    CREATE OR REPLACE TEMPORARY TABLE _ff_we2 AS
    SELECT
        A.mandant_id,
        A.kjwo,
        A.dat_von,
        A.dat_bis,
        A.werbetyp_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        b.dat,
        b.dat_2
    FROM `_ff_we1` AS A
    INNER JOIN (
        SELECT
            A0.kjwo,
            A0.werbetyp_id,
            CASE
                WHEN B.dat BETWEEN A0.dat_von AND A0.dat_bis
                    THEN B.dat
                ELSE NULL
            END AS dat,
            CASE
                WHEN B.dat NOT BETWEEN A0.dat_von AND A0.dat_bis
                    THEN B.dat
                ELSE NULL
            END AS dat_2
        FROM `_ff_we1` AS A0
        INNER JOIN dbp_data.tag AS B ON B.dat BETWEEN DATE_SUB(A0.dat_von, INTERVAL 7 DAY) AND A0.dat_bis
        GROUP BY
            A0.kjwo,
            A0.werbetyp_id,
            dat,
            dat_2
    ) AS b ON A.kjwo = b.kjwo AND A.werbetyp_id = b.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _track_feuerwerk AS
    SELECT
        A.mandant_id,
        A.art_id
    FROM `_ff_we2` AS A
    INNER JOIN dbp_data.art_wg_zu_per AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    WHERE B.wg_id = 805
    GROUP BY
        A.mandant_id,
        A.art_id;


    DELETE FROM `_ff_we2`
    WHERE (
        mandant_id, art_id) IN (
        SELECT (mandant_id, art_id)
        FROM `_track_feuerwerk`
    ) AND dat IS NULL;


    INSERT INTO `_ff_we2`
    (
        SELECT
            A.mandant_id,
            A.kjwo,
            A.dat_von,
            A.dat_bis,
            A.werbetyp_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            CAST(NULL AS DATE) AS dat,
            C.dat AS dat_2
        FROM `_ff_we2` AS A
        INNER JOIN `_track_feuerwerk` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
        INNER JOIN dbp_data.tag AS C ON TRUE
        WHERE
            A.dat IS NOT NULL
            AND C.dat BETWEEN DATE_SUB(A.dat_von, INTERVAL 45 DAY) AND (DATE_SUB(A.dat_von, INTERVAL 1 DAY))
        GROUP BY
            A.mandant_id,
            A.kjwo,
            A.dat_von,
            A.dat_bis,
            A.werbetyp_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            dat,
            dat_2
    );


    CREATE OR REPLACE TEMPORARY TABLE _ff_we3 AS
    SELECT
        A.mandant_id,
        A.werbetyp_id,
        A.dat_von,
        A.dat_bis,
        A.kjwo,
        COALESCE(A.dat, A.dat_2) AS dat,
        A.wup_id,
        A.nb_id,
        A.art_id,
        COALESCE(b.menge_lagerbew_bme, 0) AS we_menge,
        COALESCE(c.menge_lagerbew_bme, 0) AS we_menge_2
    FROM `_ff_we2` AS A
    LEFT JOIN (
        SELECT
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew AS A
        INNER JOIN dbp_data.lagerbew_det AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2`
            WHERE dat IS NOT NULL
        ) AS c
            ON
                B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch
                = c.dat
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id = 'WE'
            AND CASE
                WHEN
                    B.dat_buch < DATE '2020-02-01' AND C1.bestellart_id IN (
                        'ZLNS', 'ZLN', 'UBE', 'ZDZA', 'ZLLA', 'ZLA', 'ZLAS',
                        'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL') OR B.dat_buch >= DATE '2020-02-01' AND C1.bestellart_id IN (
                        'UBE',
                        'ZDZA', 'ZLLA', 'ZLA', 'ZLAS', 'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND A.mandant_id = 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu
                WHERE
                    mandant_id = 1
                    AND spr_id = 22
                    AND lager_bewart_bez LIKE '%Retoure%'
            )
            AND X.wg_id NOT IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 25
                    AND mandant_id = 1
            )
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            c.werbetyp_id
        UNION ALL
        SELECT
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew AS A
        INNER JOIN dbp_data.lagerbew_det AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2`
            WHERE dat IS NOT NULL
        ) AS c
            ON
                B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch
                = c.dat
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id = 'WE'
            AND X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 25
                    AND mandant_id = 1
            )
            AND A.mandant_id = 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu
                WHERE
                    mandant_id = 1
                    AND spr_id = 22
                    AND lager_bewart_bez LIKE '%Retoure%'
            )
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            c.werbetyp_id
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.art_id = b.art_id AND A.dat = b.dat_buch
            AND A.werbetyp_id = b.werbetyp_id
    LEFT JOIN (
        SELECT
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew AS A
        INNER JOIN dbp_data.lagerbew_det AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2`
            WHERE dat_2 IS NOT NULL
        ) AS c
            ON B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id = 'WE'
            AND CASE
                WHEN
                    B.dat_buch < DATE '2020-02-01' AND C1.bestellart_id IN (
                        'ZLNS', 'ZLN', 'UBE', 'ZDZA', 'ZLLA', 'ZLA', 'ZLAS',
                        'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL') OR B.dat_buch >= DATE '2020-02-01' AND C1.bestellart_id IN (
                        'UBE',
                        'ZDZA', 'ZLLA', 'ZLA', 'ZLAS', 'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND A.mandant_id = 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu
                WHERE
                    mandant_id = 1
                    AND spr_id = 22
                    AND lager_bewart_bez LIKE '%Retoure%'
            )
            AND X.wg_id NOT IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 25
                    AND mandant_id = 1
            )
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            c.werbetyp_id
        UNION ALL
        SELECT
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew AS A
        INNER JOIN dbp_data.lagerbew_det AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2`
            WHERE dat_2 IS NOT NULL
        ) AS c
            ON B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id = 'WE'
            AND X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 25
                    AND mandant_id = 1
            )
            AND A.mandant_id = 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu
                WHERE
                    mandant_id = 1
                    AND spr_id = 22
                    AND lager_bewart_bez LIKE '%Retoure%'
            )
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            c.werbetyp_id
        UNION ALL
        SELECT
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            c.dat_2 AS dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew AS A
        INNER JOIN dbp_data.lagerbew_det AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2`
            WHERE dat_2 IS NOT NULL
        ) AS c
            ON B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch = DATE_SUB(c.dat_2, INTERVAL 7 DAY)
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id = 'WE'
            AND CASE
                WHEN
                    B.dat_buch < DATE '2020-02-01' AND C1.bestellart_id IN (
                        'ZLNS', 'ZLN', 'UBE', 'ZDZA', 'ZLLA', 'ZLA', 'ZLAS',
                        'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL') OR B.dat_buch >= DATE '2020-02-01' AND C1.bestellart_id IN (
                        'UBE',
                        'ZDZA', 'ZLLA', 'ZLA', 'ZLAS', 'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 30
                    AND mandant_id = 1
            )
            AND A.mandant_id = 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu
                WHERE
                    mandant_id = 1
                    AND spr_id = 22
                    AND lager_bewart_bez LIKE '%Retoure%'
            )
        GROUP BY
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            dat_buch
    )
        AS c ON A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_2 = c.dat_buch
    AND A.werbetyp_id = c.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _stpo AS
    SELECT
        mandant_id,
        stueckliste_id,
        art_id AS kopf_art
    FROM dbp_data.stueckliste AS A
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id = 1
    GROUP BY
        mandant_id,
        stueckliste_id,
        kopf_art;


    CREATE OR REPLACE TEMPORARY TABLE _x_ray AS
    SELECT
        t0.mandant_id,
        t0.wup_id,
        t0.werbetyp_id,
        b.kopf_art AS art_id,
        t0.dat,
        t0.dat_2
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
    ) AS t0
    INNER JOIN (
        SELECT kopf_art
        FROM `_stpo`
        GROUP BY kopf_art
    ) AS b
        ON TRUE;


    CREATE OR REPLACE TEMPORARY TABLE _help_me1 AS
    SELECT
        mandant_id,
        dat
    FROM `_x_ray`
    WHERE dat IS NOT NULL
    GROUP BY
        mandant_id,
        dat;


    CREATE OR REPLACE TEMPORARY TABLE _help_me2 AS
    SELECT
        mandant_id,
        dat_2
    FROM `_x_ray`
    WHERE dat_2 IS NOT NULL
    GROUP BY
        mandant_id,
        dat_2;


    CREATE OR REPLACE TEMPORARY TABLE _mseg_package_ekpo AS
    SELECT
        B.mandant_id,
        B.lagerbew_beleg_id,
        B.lagerbew_beleg_pos_id,
        B.kj,
        B.grund_id,
        B.lager_bewart_id,
        B.art_id,
        B.wup_id,
        B.nb_id,
        B.auto_fg,
        B.lagerort_id,
        B.gp_id,
        B.einkaufsorganisation_id,
        B.soll_haben_kz,
        B.wrg_id,
        B.best_beleg_id,
        B.best_beleg_pos_id,
        B.betrag_lagerbew,
        B.betrag_verkauf,
        B.erfsngs_menge_einh_id,
        B.lagerplatz_id,
        B.kunde_id,
        B.menge_lagerbew_kolli,
        B.menge_lagerbew_bme,
        B.menge_lagerbew_palette,
        B.menge_lieferschein,
        B.menge_lief,
        B.menge_erf,
        B.empfaenger_id,
        B.dat_buch,
        B.lagerbew_beleg_storno_id,
        B.lagerbew_beleg_pos_storno_id,
        B.lagerbew_beleg_storno_kj,
        B.betrag_vk_netto,
        B.system_id,
        B.betrag_belegfluss_wg_art,
        B.mandant_id_kunde,
        B.mandant_id_empfaenger,
        B.bw_vorgang_id,
        B.betrag_verkauf_ist,
        B.betrag_vk_netto_vz,
        B.betrag_verkauf_ist_netto,
        B.betrag_einstandspreis,
        B.gp_id_zl,
        B.bq_findung_id,
        B.lagerbew_beleg_pos_mutter_id,
        B.line_id,
        B.display_art_id,
        B.td_update,
        B.td_insert
    FROM dbp_data.lagerbew AS A
    INNER JOIN dbp_data.lagerbew_det AS B
        ON
            A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
            AND A.dat_buch = B.dat_buch
    INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

    INNER JOIN dbp_data.besch_best_det AS C2
        ON
            B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
            AND B.art_id = C2.art_id
    WHERE
        A.vorgangsart_id = 'WE'
        AND CASE
            WHEN
                B.dat_buch < DATE '2020-02-01' AND C1.bestellart_id IN (
                    'ZLNS', 'ZLN', 'UBE', 'ZDZA', 'ZLLA', 'ZLA', 'ZLAS',
                    'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL') OR B.dat_buch >= DATE '2020-02-01' AND C1.bestellart_id IN (
                    'UBE',
                    'ZDZA', 'ZLLA', 'ZLA', 'ZLAS', 'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL'
                )
                THEN 1
            ELSE 0
        END = 1
        AND A.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me1`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me2`
            ) AS t1
        )
        AND A.mandant_id = 1
        AND B.lager_bewart_id NOT IN (
            SELECT lager_bewart_id
            FROM dbp_data.lager_bewart_spr_zu
            WHERE
                mandant_id = 1
                AND spr_id = 22
                AND lager_bewart_bez LIKE '%Retoure%'
        );


    CREATE OR REPLACE TEMPORARY TABLE _mseg_package_not_ekpo AS
    SELECT
        B.mandant_id,
        B.lagerbew_beleg_id,
        B.lagerbew_beleg_pos_id,
        B.kj,
        B.grund_id,
        B.lager_bewart_id,
        B.art_id,
        B.wup_id,
        B.nb_id,
        B.auto_fg,
        B.lagerort_id,
        B.gp_id,
        B.einkaufsorganisation_id,
        B.soll_haben_kz,
        B.wrg_id,
        B.best_beleg_id,
        B.best_beleg_pos_id,
        B.betrag_lagerbew,
        B.betrag_verkauf,
        B.erfsngs_menge_einh_id,
        B.lagerplatz_id,
        B.kunde_id,
        B.menge_lagerbew_kolli,
        B.menge_lagerbew_bme,
        B.menge_lagerbew_palette,
        B.menge_lieferschein,
        B.menge_lief,
        B.menge_erf,
        B.empfaenger_id,
        B.dat_buch,
        B.lagerbew_beleg_storno_id,
        B.lagerbew_beleg_pos_storno_id,
        B.lagerbew_beleg_storno_kj,
        B.betrag_vk_netto,
        B.system_id,
        B.betrag_belegfluss_wg_art,
        B.mandant_id_kunde,
        B.mandant_id_empfaenger,
        B.bw_vorgang_id,
        B.betrag_verkauf_ist,
        B.betrag_vk_netto_vz,
        B.betrag_verkauf_ist_netto,
        B.betrag_einstandspreis,
        B.gp_id_zl,
        B.bq_findung_id,
        B.lagerbew_beleg_pos_mutter_id,
        B.line_id,
        B.display_art_id,
        B.td_update,
        B.td_insert
    FROM dbp_data.lagerbew AS A
    INNER JOIN dbp_data.lagerbew_det AS B
        ON
            A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
            AND A.dat_buch = B.dat_buch
    INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

    INNER JOIN dbp_data.besch_best_det AS C2
        ON
            B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
            AND B.art_id = C2.art_id
    WHERE
        A.vorgangsart_id = 'WE'
        AND A.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me1`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me2`
            ) AS t1
        )
        AND A.mandant_id = 1
        AND B.lager_bewart_id NOT IN (
            SELECT lager_bewart_id
            FROM dbp_data.lager_bewart_spr_zu
            WHERE
                mandant_id = 1
                AND spr_id = 22
                AND lager_bewart_bez LIKE '%Retoure%'
        );


    CREATE OR REPLACE TEMPORARY TABLE _x_track1 AS
    SELECT
        A.mandant_id,
        c.werbetyp_id,
        A.lagerbew_beleg_id,
        A.wup_id,
        A.art_id,
        A.dat_buch,
        SUM(A.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_ekpo` AS A
    INNER JOIN (
        SELECT *
        FROM `_x_ray`
        WHERE dat IS NOT NULL
    ) AS c
        ON
            A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_buch
            = c.dat
    INNER JOIN dbp_data.art_wg_zu_per AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE (
        A.mandant_id, A.dat_buch) IN (
        SELECT (mandant_id, dat)
        FROM `_help_me1`
    )
    AND X.wg_id NOT IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu
        WHERE
            wg_filter_id = 25
            AND mandant_id = 1
    )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        c.werbetyp_id
    UNION ALL
    SELECT
        A.mandant_id,
        c.werbetyp_id,
        A.lagerbew_beleg_id,
        A.wup_id,
        A.art_id,
        A.dat_buch,
        SUM(A.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_not_ekpo` AS A
    INNER JOIN (
        SELECT *
        FROM `_x_ray`
        WHERE dat IS NOT NULL
    ) AS c
        ON
            A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_buch
            = c.dat
    INNER JOIN dbp_data.art_wg_zu_per AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE
        X.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu
            WHERE
                wg_filter_id = 25
                AND mandant_id = 1
        )
        AND (
            A.mandant_id, A.dat_buch) IN (
            SELECT (mandant_id, dat)
            FROM `_help_me1`
        )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        c.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _x_track2 AS
    SELECT
        A.mandant_id,
        c.werbetyp_id,
        A.lagerbew_beleg_id,
        A.wup_id,
        A.art_id,
        A.dat_buch,
        SUM(A.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_ekpo` AS A
    INNER JOIN (
        SELECT *
        FROM `_x_ray`
        WHERE dat_2 IS NOT NULL
    ) AS c
        ON
            A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_buch
            = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE (
        A.mandant_id, A.dat_buch) IN (
        SELECT (mandant_id, dat_2)
        FROM `_help_me2`
    )
    AND X.wg_id NOT IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu
        WHERE
            wg_filter_id = 25
            AND mandant_id = 1
    )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        c.werbetyp_id
    UNION ALL
    SELECT
        A.mandant_id,
        c.werbetyp_id,
        A.lagerbew_beleg_id,
        A.wup_id,
        A.art_id,
        A.dat_buch,
        SUM(A.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_not_ekpo` AS A
    INNER JOIN (
        SELECT *
        FROM `_x_ray`
        WHERE dat_2 IS NOT NULL
    ) AS c
        ON
            A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_buch
            = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE
        X.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu
            WHERE
                wg_filter_id = 25
                AND mandant_id = 1
        )
        AND (
            A.mandant_id, A.dat_buch) IN (
            SELECT (mandant_id, dat_2)
            FROM `_help_me2`
        )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        c.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _display_update AS
    SELECT
        B.mandant_id,
        c.werbetyp_id,
        B.wup_id,
        B.art_id,
        B.dat_buch,
        SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM dbp_data.lagerbew AS A
    INNER JOIN dbp_data.lagerbew_det AS B
        ON
            A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
            AND A.dat_buch = B.dat_buch
    INNER JOIN (
        SELECT
            c.mandant_id,
            c.werbetyp_id,
            c.lagerbew_beleg_id,
            c.wup_id,
            B0.art_id,
            c.dat_buch
        FROM dbp_data.stueckliste AS A0
        INNER JOIN dbp_data.stueckliste_det AS B0 ON A0.mandant_id = B0.mandant_id AND A0.stueckliste_id = B0.stueckliste_id
        INNER JOIN (
            SELECT
                A.mandant_id,
                A.werbetyp_id,
                C.lagerbew_beleg_id,
                A.wup_id,
                A.art_id,
                A.dat_buch
            FROM `_x_track1` AS A
            INNER JOIN dbp_data.lagerbew AS B
                ON
                    A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                    AND A.dat_buch = B.dat_buch
            INNER JOIN dbp_data.lagerbew AS C
                ON
                    A.mandant_id = C.mandant_id AND B.ref_lagerbew_beleg_id = C.ref_lagerbew_beleg_id
                    AND B.dat_buch = C.dat_buch
            GROUP BY
                A.mandant_id,
                A.werbetyp_id,
                C.lagerbew_beleg_id,
                A.wup_id,
                A.art_id,
                A.dat_buch
            UNION ALL
            SELECT
                A.mandant_id,
                A.werbetyp_id,
                C.lagerbew_beleg_id,
                A.wup_id,
                A.art_id,
                A.dat_buch
            FROM `_x_track2` AS A
            INNER JOIN dbp_data.lagerbew AS B
                ON
                    A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                    AND A.dat_buch = B.dat_buch
            INNER JOIN dbp_data.lagerbew AS C
                ON
                    A.mandant_id = C.mandant_id AND B.ref_lagerbew_beleg_id = C.ref_lagerbew_beleg_id
                    AND B.dat_buch = C.dat_buch
            GROUP BY
                A.mandant_id,
                A.werbetyp_id,
                C.lagerbew_beleg_id,
                A.wup_id,
                A.art_id,
                A.dat_buch
        ) AS c ON A0.mandant_id = c.mandant_id AND A0.art_id = c.art_id
        WHERE A0.dat_bis = DATE '9999-12-31'
        GROUP BY
            c.mandant_id,
            c.werbetyp_id,
            c.lagerbew_beleg_id,
            c.wup_id,
            B0.art_id,
            c.dat_buch
    ) AS c
        ON
            B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch = c.dat_buch
            AND B.lagerbew_beleg_id = c.lagerbew_beleg_id
    WHERE
        A.vorgangsart_id IN ('WA', 'WE')
        AND B.lager_bewart_id NOT IN (
            SELECT lager_bewart_id
            FROM dbp_data.lager_bewart_spr_zu
            WHERE
                mandant_id = 1
                AND spr_id = 22
                AND lager_bewart_bez LIKE '%Retoure%'
        )
    GROUP BY
        B.mandant_id,
        c.werbetyp_id,
        B.wup_id,
        B.art_id,
        B.dat_buch;


    UPDATE `_ff_we3` SET
        we_menge = b.menge_lagerbew_bme + `_ff_we3`.we_menge
    FROM `_display_update` AS b
    WHERE
        `_ff_we3`.mandant_id = b.mandant_id AND `_ff_we3`.wup_id = b.wup_id AND `_ff_we3`.art_id = b.art_id AND `_ff_we3`
        .werbetyp_id = b.werbetyp_id AND `_ff_we3`.dat = b.dat_buch AND `_ff_we3`.dat BETWEEN `_ff_we3`.dat_von AND `_ff_we3`
        .dat_bis;


    UPDATE `_ff_we3` SET
        we_menge_2 = b.menge_lagerbew_bme + `_ff_we3`.we_menge_2
    FROM `_display_update` AS b
    WHERE
        `_ff_we3`.mandant_id = b.mandant_id AND `_ff_we3`.wup_id = b.wup_id AND `_ff_we3`.art_id = b.art_id AND `_ff_we3`
        .werbetyp_id = b.werbetyp_id AND `_ff_we3`.dat = b.dat_buch AND `_ff_we3`.dat NOT BETWEEN `_ff_we3`.dat_von AND
        `_ff_we3`.dat_bis;


    UPDATE `_ff_we3` SET
        we_menge_2 = 0 FROM (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            DATE_SUB(A.dat_von, INTERVAL 3 DAY) AS min_dat
        FROM `_ff_we3` AS A
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        WHERE
            X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 27
                    AND mandant_id = 1
            )
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3`.mandant_id = b.mandant_id AND `_ff_we3`.wup_id = b.wup_id AND `_ff_we3`.werbetyp_id = b.werbetyp_id AND
        `_ff_we3`.art_id = b.art_id AND `_ff_we3`.dat < b.min_dat;


    UPDATE `_ff_we3` SET
        we_menge_2 = 0 FROM (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            CASE
                WHEN A.werbetyp_id = 3
                    THEN DATE_SUB(A.dat_von, INTERVAL 3 DAY)
                ELSE DATE_SUB(A.dat_von, INTERVAL 1 DAY)
            END AS min_dat
        FROM `_ff_we3` AS A
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        WHERE
            X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 28
                    AND mandant_id = 1
            )
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3`.mandant_id = b.mandant_id AND `_ff_we3`.wup_id = b.wup_id AND `_ff_we3`.werbetyp_id = b.werbetyp_id AND
        `_ff_we3`.art_id = b.art_id AND `_ff_we3`.dat < b.min_dat;


    UPDATE `_ff_we3` SET
        we_menge_2 = 0 FROM (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von AS min_dat
        FROM `_ff_we3` AS A
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        WHERE
            X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 50
                    AND mandant_id = 1
            )
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3`.mandant_id = b.mandant_id AND `_ff_we3`.wup_id = b.wup_id AND `_ff_we3`.werbetyp_id = b.werbetyp_id AND
        `_ff_we3`.art_id = b.art_id AND `_ff_we3`.dat < b.min_dat;


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
    FROM `_ff_we3` AS A
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
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id,
        SUM(COALESCE(U.menge_lgbest_erp_frei_bme, 0)) AS menge_aktionsstart
    FROM `_ff_we4` AS V
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            CASE
                WHEN werbetyp_id = 1
                    THEN dat_von
                ELSE DATE_SUB(dat_von, INTERVAL 1 DAY)
            END AS dat_von,
            kjwo
        FROM `_werbeartikel_1`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_von,
            kjwo
    ) AS w
        ON
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    LEFT JOIN dbp_data.marktbestand_erp AS U
        ON
            w.mandant_id = U.mandant_id AND w.wup_id = U.wup_id AND w.art_id
            = U.art_id AND w.dat_von = U.dat
    GROUP BY
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id;


    UPDATE `_ff_we4` SET
        menge_aktionsstart = CAST(
            b.menge_aktionsstart AS INTEGER) FROM (
        SELECT *
        FROM `_mbst_we1`
        WHERE menge_aktionsstart <> 0
    ) AS b
    WHERE
        `_ff_we4`.mandant_id = b.mandant_id AND `_ff_we4`.wup_id = b.wup_id AND `_ff_we4`.nb_id = b.nb_id AND `_ff_we4`.art_id
        = b.art_id AND `_ff_we4`.kjwo = b.kjwo AND `_ff_we4`.werbetyp_id = b.werbetyp_id;


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
        FROM `_werbeartikel_1`
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
        FROM dbp_data.wupcal
        WHERE (
            mandant_id, dat) IN (SELECT (mandant_id, dat)
        FROM `_die_tage`)
    ) AS b
        ON a.wup_id = b.wup_id AND a.mandant_id = b.mandant_id AND b.dat BETWEEN CASE
            WHEN a.werbetyp_id = 1
                THEN DATE_ADD(a.dat_von, INTERVAL 1 DAY)
            ELSE a.dat_von
        END AND a.dat_bis
    GROUP BY
        a.kjwo,
        a.werbetyp_id,
        a.mandant_id,
        a.wup_id;


    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew AS
    SELECT
        W.kjwo,
        W.werbetyp_id,
        W.dat_von,
        W.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id,
        MAX(v.posten_id) AS posten_id,
        SUM(CASE
            WHEN X.wtag_id = 1
                THEN v.umsatz_netto
            ELSE 0
        END) AS umsatz_netto_mo,
        SUM(CASE
            WHEN X.wtag_id = 2
                THEN v.umsatz_netto
            ELSE 0
        END) AS umsatz_netto_di,
        SUM(CASE
            WHEN X.wtag_id = 3
                THEN v.umsatz_netto
            ELSE 0
        END) AS umsatz_netto_mi,
        SUM(CASE
            WHEN X.wtag_id = 4
                THEN v.umsatz_netto
            ELSE 0
        END) AS umsatz_netto_do,
        SUM(CASE
            WHEN X.wtag_id = 5
                THEN v.umsatz_netto
            ELSE 0
        END) AS umsatz_netto_fr,
        SUM(CASE
            WHEN X.wtag_id = 6
                THEN v.umsatz_netto
            ELSE 0
        END) AS umsatz_netto_sa,
        SUM(CASE
            WHEN X.wtag_id = 7
                THEN v.umsatz_netto
            ELSE 0
        END) AS umsatz_netto_so,
        SUM(v.umsatz_netto) AS umsatz_netto_wo,
        SUM(CASE
            WHEN X.wtag_id = 1
                THEN v.menge
            ELSE 0
        END) AS menge_mo,
        SUM(CASE
            WHEN X.wtag_id = 2
                THEN v.menge
            ELSE 0
        END) AS menge_di,
        SUM(CASE
            WHEN X.wtag_id = 3
                THEN v.menge
            ELSE 0
        END) AS menge_mi,
        SUM(CASE
            WHEN X.wtag_id = 4
                THEN v.menge
            ELSE 0
        END) AS menge_do,
        SUM(CASE
            WHEN X.wtag_id = 5
                THEN v.menge
            ELSE 0
        END) AS menge_fr,
        SUM(CASE
            WHEN X.wtag_id = 6
                THEN v.menge
            ELSE 0
        END) AS menge_sa,
        SUM(CASE
            WHEN X.wtag_id = 7
                THEN v.menge
            ELSE 0
        END) AS menge_so,
        SUM(v.menge) AS menge_wo,
        SUM(CASE
            WHEN v.bewart_id = 1002
                THEN v.menge
            ELSE 0
        END) AS menge_sa2,
        MAX(Z.anz_offen) - COUNT(DISTINCT v.dat) AS tage_menge_0,
        SUM(0) AS we_menge,
        SUM(0) AS menge_aktionsstart,
        SUM(0) AS we_menge_ab_vorwoche
    FROM (
        SELECT *
        FROM dbp_data.artbew AS A
        WHERE (
            mandant_id, dat) IN (
            SELECT (mandant_id, dat)
            FROM `_die_tage`
        )
        AND umsatz_netto > 0
    ) AS v
    INNER JOIN `_werbeartikel_1` AS W
        ON v.mandant_id = W.mandant_id AND v.wup_id = W.wup_id AND v.art_id = W.art_id AND v.dat BETWEEN CASE
            WHEN W.werbetyp_id = 1
                THEN DATE_ADD(W.dat_von, INTERVAL 1 DAY)
            ELSE W.dat_von
        END AND W.dat_bis
    INNER JOIN dbp_data.tag AS X ON v.dat = X.dat
    INNER JOIN `_wup_kalender` AS Z
        ON
            W.kjwo = Z.kjwo AND v.wup_id = Z.wup_id AND v.mandant_id = Z.mandant_id AND W.werbetyp_id
            = Z.werbetyp_id
    GROUP BY
        W.kjwo,
        W.werbetyp_id,
        W.dat_von,
        W.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        v.nb_id;


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst1 AS
    SELECT
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id,
        SUM(COALESCE(U.menge_lgbest_erp_frei_bme, 0)) AS menge_endbestand
    FROM `_ff_we4` AS V
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_bis,
            kjwo
        FROM `_werbeartikel_1`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_bis,
            kjwo
    ) AS w
        ON
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    LEFT JOIN dbp_data.marktbestand_erp AS U
        ON
            w.mandant_id = U.mandant_id AND w.wup_id = U.wup_id AND w.art_id
            = U.art_id AND w.dat_bis = U.dat AND U.menge_lgbest_erp_frei_bme >= 0
    GROUP BY
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id;


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2 AS
    SELECT
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id,
        SUM(CASE
            WHEN
                XX.gewart_id = 'ST' AND X.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND X.menge_lgbest_erp_frei_bme
                BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND X.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                THEN 1
            ELSE 0
        END) AS anz_tage_null,
        SUM(CASE
            WHEN
                XX.gewart_id = 'ST' AND X.menge_lgbest_erp_frei_bme < 0 OR XX.gewart_id = 'KG' AND X.menge_lgbest_erp_frei_bme <
                0.000 OR XX.gewart_id = 'G' AND X.menge_lgbest_erp_frei_bme < 0.000
                THEN 1
            ELSE 0
        END) AS anz_tage_minus
    FROM `_ff_we4` AS V
    INNER JOIN (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von,
            A.dat_bis,
            B.dat,
            A.kjwo
        FROM `_werbeartikel_1` AS A
        INNER JOIN dbp_data.tag AS B ON B.dat BETWEEN A.dat_von AND A.dat_bis
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von,
            A.dat_bis,
            B.dat,
            A.kjwo
    ) AS w
        ON
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    INNER JOIN dbp_data.art AS XX ON V.mandant_id = XX.mandant_id AND V.art_id = XX.art_id
    LEFT JOIN dbp_data.marktbestand_erp AS X
        ON
            w.mandant_id = X.mandant_id AND w.wup_id = X.wup_id AND w.art_id
            = X.art_id AND w.dat = X.dat AND X.dat < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id;


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2a AS
    SELECT
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id,
        MAX(CASE
            WHEN
                XX.gewart_id = 'ST' AND X.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND X.menge_lgbest_erp_frei_bme
                BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND X.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                THEN 1
            ELSE 0
        END) AS anz_null_tag1,
        0 AS anz_null_tag2,
        0 AS anz_null_tag3,
        0 AS anz_null_tag4,
        0 AS anz_null_tag5,
        0 AS anz_null_tag6,
        0 AS anz_null_tag7,
        MAX(CASE
            WHEN
                XX.gewart_id = 'ST' AND X.menge_lgbest_erp_frei_bme < 0 OR XX.gewart_id = 'KG' AND X.menge_lgbest_erp_frei_bme <
                0.000 OR XX.gewart_id = 'G' AND X.menge_lgbest_erp_frei_bme < 0.000
                THEN 1
            ELSE 0
        END) AS anz_minus_tag1
    FROM `_ff_we4` AS V
    INNER JOIN (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von,
            A.dat_bis,
            B.dat,
            A.kjwo
        FROM `_werbeartikel_1` AS A
        INNER JOIN dbp_data.tag AS B ON A.dat_von = B.dat
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von,
            A.dat_bis,
            B.dat,
            A.kjwo
    ) AS w
        ON
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    INNER JOIN dbp_data.art AS XX ON V.mandant_id = XX.mandant_id AND V.art_id = XX.art_id
    LEFT JOIN dbp_data.marktbestand_erp AS X
        ON
            w.mandant_id = X.mandant_id AND w.wup_id = X.wup_id AND w.art_id
            = X.art_id AND w.dat = X.dat AND X.dat < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id;


    UPDATE `_test_we_mbst2a` SET
        anz_null_tag2 = b.anz_null_tag2 FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(CASE
                WHEN
                    XX.gewart_id = 'ST' AND A.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND A.menge_lgbest_erp_frei_bme
                    BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND A.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END) AS anz_null_tag2
        FROM dbp_data.marktbestand_erp AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.tag AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 1 DAY) AND A0.dat_bis >= B.dat

            GROUP BY
                A0.werbetyp_id,
                A0.dat_von,
                A0.dat_bis,
                A0.wup_id,
                A0.mandant_id,
                A0.art_id,
                B.dat
        ) AS w
            ON
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin"
                )
        INNER JOIN dbp_data.art AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a`.mandant_id = b.mandant_id AND `_test_we_mbst2a`.wup_id = b.wup_id AND `_test_we_mbst2a`.art_id =
        b.art_id AND `_test_we_mbst2a`.dat_von = b.dat_von AND `_test_we_mbst2a`.dat_bis = b.dat_bis AND `_test_we_mbst2a`
        .werbetyp_id = b.werbetyp_id;


    UPDATE `_test_we_mbst2a` SET
        anz_null_tag3 = b.anz_null_tag3 FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(CASE
                WHEN
                    XX.gewart_id = 'ST' AND A.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND A.menge_lgbest_erp_frei_bme
                    BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND A.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END) AS anz_null_tag3
        FROM dbp_data.marktbestand_erp AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.tag AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 2 DAY) AND A0.dat_bis >= B.dat

            GROUP BY
                A0.werbetyp_id,
                A0.dat_von,
                A0.dat_bis,
                A0.wup_id,
                A0.mandant_id,
                A0.art_id,
                B.dat
        ) AS w
            ON
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin"
                )
        INNER JOIN dbp_data.art AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a`.mandant_id = b.mandant_id AND `_test_we_mbst2a`.wup_id = b.wup_id AND `_test_we_mbst2a`.art_id =
        b.art_id AND `_test_we_mbst2a`.dat_von = b.dat_von AND `_test_we_mbst2a`.dat_bis = b.dat_bis AND `_test_we_mbst2a`
        .werbetyp_id = b.werbetyp_id;


    UPDATE `_test_we_mbst2a` SET
        anz_null_tag4 = b.anz_null_tag4 FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(CASE
                WHEN
                    XX.gewart_id = 'ST' AND A.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND A.menge_lgbest_erp_frei_bme
                    BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND A.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END) AS anz_null_tag4
        FROM dbp_data.marktbestand_erp AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.tag AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 3 DAY) AND A0.dat_bis >= B.dat

            GROUP BY
                A0.werbetyp_id,
                A0.dat_von,
                A0.dat_bis,
                A0.wup_id,
                A0.mandant_id,
                A0.art_id,
                B.dat
        ) AS w
            ON
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin"
                )
        INNER JOIN dbp_data.art AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a`.mandant_id = b.mandant_id AND `_test_we_mbst2a`.wup_id = b.wup_id AND `_test_we_mbst2a`.art_id =
        b.art_id AND `_test_we_mbst2a`.dat_von = b.dat_von AND `_test_we_mbst2a`.dat_bis = b.dat_bis AND `_test_we_mbst2a`
        .werbetyp_id = b.werbetyp_id;


    UPDATE `_test_we_mbst2a` SET
        anz_null_tag5 = b.anz_null_tag5 FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(CASE
                WHEN
                    XX.gewart_id = 'ST' AND A.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND A.menge_lgbest_erp_frei_bme
                    BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND A.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END) AS anz_null_tag5
        FROM dbp_data.marktbestand_erp AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.tag AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 4 DAY) AND A0.dat_bis >= B.dat

            GROUP BY
                A0.werbetyp_id,
                A0.dat_von,
                A0.dat_bis,
                A0.wup_id,
                A0.mandant_id,
                A0.art_id,
                B.dat
        ) AS w
            ON
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin"
                )
        INNER JOIN dbp_data.art AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a`.mandant_id = b.mandant_id AND `_test_we_mbst2a`.wup_id = b.wup_id AND `_test_we_mbst2a`.art_id =
        b.art_id AND `_test_we_mbst2a`.dat_von = b.dat_von AND `_test_we_mbst2a`.dat_bis = b.dat_bis AND `_test_we_mbst2a`
        .werbetyp_id = b.werbetyp_id;


    UPDATE `_test_we_mbst2a` SET
        anz_null_tag6 = b.anz_null_tag6 FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(CASE
                WHEN
                    XX.gewart_id = 'ST' AND A.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND A.menge_lgbest_erp_frei_bme
                    BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND A.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END) AS anz_null_tag6
        FROM dbp_data.marktbestand_erp AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.tag AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 5 DAY) AND A0.dat_bis >= B.dat

            GROUP BY
                A0.werbetyp_id,
                A0.dat_von,
                A0.dat_bis,
                A0.wup_id,
                A0.mandant_id,
                A0.art_id,
                B.dat
        ) AS w
            ON
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin"
                )
        INNER JOIN dbp_data.art AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a`.mandant_id = b.mandant_id AND `_test_we_mbst2a`.wup_id = b.wup_id AND `_test_we_mbst2a`.art_id =
        b.art_id AND `_test_we_mbst2a`.dat_von = b.dat_von AND `_test_we_mbst2a`.dat_bis = b.dat_bis AND `_test_we_mbst2a`
        .werbetyp_id = b.werbetyp_id;


    UPDATE `_test_we_mbst2a` SET
        anz_null_tag7 = b.anz_null_tag7 FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(CASE
                WHEN
                    XX.gewart_id = 'ST' AND A.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND A.menge_lgbest_erp_frei_bme
                    BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND A.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END) AS anz_null_tag7
        FROM dbp_data.marktbestand_erp AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.tag AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 6 DAY) AND A0.dat_bis >= B.dat

            GROUP BY
                A0.werbetyp_id,
                A0.dat_von,
                A0.dat_bis,
                A0.wup_id,
                A0.mandant_id,
                A0.art_id,
                B.dat
        ) AS w
            ON
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin"
                )
        INNER JOIN dbp_data.art AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a`.mandant_id = b.mandant_id AND `_test_we_mbst2a`.wup_id = b.wup_id AND `_test_we_mbst2a`.art_id =
        b.art_id AND `_test_we_mbst2a`.dat_von = b.dat_von AND `_test_we_mbst2a`.dat_bis = b.dat_bis AND `_test_we_mbst2a`
        .werbetyp_id = b.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2b AS
    SELECT
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id,
        SUM(CASE
            WHEN
                XX.gewart_id = 'ST' AND X.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND X.menge_lgbest_erp_frei_bme
                BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND X.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                THEN 1
            ELSE 0
        END) AS anz_null_tag1_bis_tag3,
        SUM(CASE
            WHEN
                XX.gewart_id = 'ST' AND X.menge_lgbest_erp_frei_bme < 0 OR XX.gewart_id = 'KG' AND X.menge_lgbest_erp_frei_bme <
                0.000 OR XX.gewart_id = 'G' AND X.menge_lgbest_erp_frei_bme < 0.000
                THEN 1
            ELSE 0
        END) AS anz_minus_tag1_bis_tag3
    FROM `_ff_we4` AS V
    INNER JOIN (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von,
            A.dat_bis,
            B.dat,
            A.kjwo
        FROM `_werbeartikel_1` AS A
        INNER JOIN dbp_data.tag AS B
            ON
                B.dat BETWEEN A.dat_von AND A.dat_bis AND B.dat BETWEEN A.dat_von AND
                (DATE_ADD(A.dat_von, INTERVAL 2 DAY))
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von,
            A.dat_bis,
            B.dat,
            A.kjwo
    ) AS w
        ON
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    INNER JOIN dbp_data.art AS XX ON V.mandant_id = XX.mandant_id AND V.art_id = XX.art_id
    LEFT JOIN dbp_data.marktbestand_erp AS X
        ON
            w.mandant_id = X.mandant_id AND w.wup_id = X.wup_id AND w.art_id
            = X.art_id AND w.dat = X.dat AND X.dat < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id;


    CREATE OR REPLACE TEMPORARY TABLE _ff_we5 AS
    SELECT
        A.kjwo,
        A.werbetyp_id,
        A.dat_von,
        A.dat_bis,
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        SUM(A.we_menge) AS we_menge,
        SUM(A.we_menge_2) AS we_menge_ab_vorwoche,
        SUM(A.menge_aktionsstart) AS menge_aktionsstart,
        SUM(B.menge_endbestand) AS menge_endbestand
    FROM `_ff_we4` AS A
    INNER JOIN `_test_we_mbst1` AS B
        ON
            A.mandant_id = B.mandant_id AND A.kjwo = B.kjwo AND A.wup_id = B.wup_id AND A.nb_id
            = B.nb_id AND A.art_id = B.art_id AND A.werbetyp_id = B.werbetyp_id
    GROUP BY
        A.kjwo,
        A.werbetyp_id,
        A.dat_von,
        A.dat_bis,
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id;


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
    FROM `_ff_we_artbew` AS A;


    UPDATE `_ff_we_artbew1` SET
        we_menge = CAST(b.we_menge AS INTEGER),
        we_menge_ab_vorwoche = CAST(b.we_menge_ab_vorwoche AS INTEGER),
        we_menge_vor_aktion = CAST(b.we_menge_ab_vorwoche AS INTEGER),
        menge_aktionsstart = CAST(b.menge_aktionsstart AS INTEGER),
        menge_endbestand = CAST(b.menge_endbestand AS INTEGER),
        min_sicherh_bestand = CAST(b.min_sicherh_bestand AS INTEGER),
        sollbestand = CAST(b.sollbestand AS INTEGER),
        bezugsweg_id = b.bezugsweg_id FROM (
        SELECT
            A.kjwo,
            A.werbetyp_id,
            A.dat_von,
            A.dat_bis,
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            A.we_menge,
            A.we_menge_ab_vorwoche,
            A.menge_aktionsstart,
            A.menge_endbestand,
            F.min_sicherh_bestand,
            F.sollbestand,
            F.bezugsweg_id
        FROM `_ff_we5` AS A
        LEFT JOIN
            dbp_data.art_wup_status_per
                AS F
            ON
                A.mandant_id = F.mandant_id AND A.wup_id = F.wup_id AND
                A.nb_id = F.nb_id AND A.art_id = F.art_id AND F.dat_bis = DATE '9999-12-31'
    ) AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id AND `_ff_we_artbew1`.wup_id = b.wup_id AND `_ff_we_artbew1`.nb_id = b.nb_id
        AND `_ff_we_artbew1`.art_id = b.art_id AND `_ff_we_artbew1`.kjwo = b.kjwo AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1` SET
        mhd_zeitraum = b.mhd_zeitraum,
        lager_prozent = b.lager_prozent FROM (
        SELECT
            A.kjwo,
            A.werbetyp_id,
            A.dat_von,
            A.dat_bis,
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            A.we_menge,
            A.we_menge_ab_vorwoche,
            A.menge_aktionsstart,
            A.menge_endbestand,
            F.mhd_zeitraum,
            F.lager_prozent
        FROM `_ff_we5` AS A
        LEFT JOIN dbp_data.art AS F ON A.mandant_id = F.mandant_id AND A.art_id = F.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id AND `_ff_we_artbew1`.wup_id = b.wup_id AND `_ff_we_artbew1`.nb_id = b.nb_id
        AND `_ff_we_artbew1`.art_id = b.art_id AND `_ff_we_artbew1`.kjwo = b.kjwo AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1` SET
        menge_bestand_soll_max = CAST(b.menge_bestand_soll_max AS INTEGER) FROM (
        SELECT
            A.kjwo,
            A.werbetyp_id,
            A.dat_von,
            A.dat_bis,
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            A.we_menge,
            A.we_menge_ab_vorwoche,
            A.menge_aktionsstart,
            A.menge_endbestand,
            F.menge_bestand_soll_max
        FROM `_ff_we5` AS A
        LEFT JOIN
            dbp_data.art_wup_nachschub_per
                AS F
            ON
                A.mandant_id = F.mandant_id AND A.wup_id = F.wup_id
                AND A.nb_id = F.nb_id AND A.art_id = F.art_id AND F.dat_bis = DATE '9999-12-31'
    ) AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id AND `_ff_we_artbew1`.wup_id = b.wup_id AND `_ff_we_artbew1`.nb_id = b.nb_id
        AND `_ff_we_artbew1`.art_id = b.art_id AND `_ff_we_artbew1`.kjwo = b.kjwo AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;


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
            B.kjwo,
            B.werbetyp_id,
            B.wup_id AS wup_id0,
            B.mandant_id AS mandant_id0,
            B.art_id,
            SUM(A.menge) AS menge_tag1_7bis13h
        FROM dbp_ods.ods_bon_verkauf AS A
        INNER JOIN `_werbeartikel_1` AS B
            ON
                A.mandant_id = B.mandant_id AND DATE(A.start_bon_zeile) = B.dat_von AND A.wup_id
                = B.wup_id AND CAST(B.art_id / 100 AS INTEGER) = A.kl_art_id AND CAST(A.start_bon_zeile AS TIME) BETWEEN
                TIME '07:00:00' AND TIME '13:00:00'
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.wup_id,
                A0.werbetyp_id
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.wupcal AS B0
                ON
                    A0.mandant_id = B0.mandant_id AND A0.wup_id = B0.wup_id AND A0.dat_von
                    = B0.dat
            WHERE B0.offen = 1
            GROUP BY
                A0.werbetyp_id,
                A0.wup_id,
                A0.mandant_id
        ) AS x ON A.mandant_id = x.mandant_id AND A.wup_id = x.wup_id AND B.werbetyp_id = x.werbetyp_id
        WHERE A.mandant_id = 1
        GROUP BY
            B.kjwo,
            B.werbetyp_id,
            B.wup_id,
            B.mandant_id,
            B.art_id
        HAVING menge_tag1_7bis13h > 0
    ) AS t5;


    INSERT INTO `_fix_it_de`
    (SELECT
        t7.mandant_id0 AS mandant_id,
        t7.werbetyp_id,
        t7.wup_id0 AS wup_id,
        t7.art_id,
        t7.kjwo,
        t7.menge_tag1_7bis13h
    FROM (
        SELECT
            B.kjwo,
            B.werbetyp_id,
            B.wup_id AS wup_id0,
            B.mandant_id AS mandant_id0,
            B.art_id,
            SUM(A.menge) AS menge_tag1_7bis13h
        FROM dbp_ods.ods_bon_verkauf AS A
        INNER JOIN `_werbeartikel_1` AS B
            ON
                A.mandant_id = B.mandant_id AND DATE(A.start_bon_zeile) BETWEEN B.dat_von AND B.dat_bis AND A.wup_id = B.wup_id AND CAST(B.art_id / 100 AS INTEGER) = A.kl_art_id AND CAST(A.start_bon_zeile AS TIME)
                BETWEEN TIME '07:00:00' AND TIME '13:00:00'
        INNER JOIN (
            SELECT
                a.mandant_id,
                a.wup_id,
                a.werbetyp_id,
                MIN(B1.dat) AS min_dat
            FROM (
                SELECT
                    A0.mandant_id,
                    A0.wup_id,
                    A0.werbetyp_id,
                    A0.dat_von,
                    A0.dat_bis
                FROM `_werbeartikel_1` AS A0
                INNER JOIN dbp_data.wupcal AS B0
                    ON
                        A0.mandant_id = B0.mandant_id AND A0.wup_id = B0.wup_id AND
                        A0.dat_von = B0.dat
                WHERE B0.offen = 0
                GROUP BY
                    A0.werbetyp_id,
                    A0.dat_von,
                    A0.dat_bis,
                    A0.wup_id,
                    A0.mandant_id
            ) AS a
            INNER JOIN dbp_data.wupcal AS B1
                ON
                    a.mandant_id = B1.mandant_id AND a.wup_id = B1.wup_id AND B1.dat
                    BETWEEN a.dat_von AND a.dat_bis
            WHERE B1.offen = 1
            GROUP BY
                a.mandant_id,
                a.wup_id,
                a.werbetyp_id
        ) AS x
            ON
                A.mandant_id = x.mandant_id AND A.wup_id = x.wup_id AND B.werbetyp_id = x.werbetyp_id AND
                DATE(A.start_bon_zeile) = x.min_dat
        WHERE A.mandant_id = 1
        GROUP BY
            B.kjwo,
            B.werbetyp_id,
            B.wup_id,
            B.mandant_id,
            B.art_id
        HAVING menge_tag1_7bis13h > 0
    ) AS t7);


    UPDATE `_ff_we_artbew1` SET
        menge_tag1_7bis13h = CAST(
            b.menge_tag1_7bis13h AS INTEGER) FROM (
        SELECT DISTINCT *
        FROM `_fix_it_de`
    ) AS b
    WHERE `_ff_we_artbew1`.mandant_id = b.mandant_id AND `_ff_we_artbew1`.wup_id = b.wup_id AND `_ff_we_artbew1`.art_id = b.art_id AND `_ff_we_artbew1`.kjwo = b.kjwo AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;


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
            B.kjwo,
            B.werbetyp_id,
            B.wup_id AS wup_id0,
            B.mandant_id AS mandant_id0,
            B.art_id,
            SUM(A.menge) AS menge_nur_tag1
        FROM dbp_ods.ods_bon_verkauf AS A
        INNER JOIN `_werbeartikel_1` AS B
            ON
                A.mandant_id = B.mandant_id AND DATE(A.start_bon_zeile) = B.dat_von AND A.wup_id
                = B.wup_id AND CAST(B.art_id / 100 AS INTEGER) = A.kl_art_id
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.wup_id,
                A0.werbetyp_id
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.wupcal AS B0
                ON
                    A0.mandant_id = B0.mandant_id AND A0.wup_id = B0.wup_id AND A0.dat_von
                    = B0.dat
            WHERE B0.offen = 1
            GROUP BY
                A0.werbetyp_id,
                A0.wup_id,
                A0.mandant_id
        ) AS x ON A.mandant_id = x.mandant_id AND A.wup_id = x.wup_id AND B.werbetyp_id = x.werbetyp_id
        WHERE A.mandant_id = 1
        GROUP BY
            B.kjwo,
            B.werbetyp_id,
            B.wup_id,
            B.mandant_id,
            B.art_id
        HAVING menge_nur_tag1 > 0
    ) AS t5;


    INSERT INTO `_fix_it_de2`
    (SELECT
        t7.mandant_id0 AS mandant_id,
        t7.werbetyp_id,
        t7.wup_id0 AS wup_id,
        t7.art_id,
        t7.kjwo,
        t7.menge_nur_tag1
    FROM (
        SELECT
            B.kjwo,
            B.werbetyp_id,
            B.wup_id AS wup_id0,
            B.mandant_id AS mandant_id0,
            B.art_id,
            SUM(A.menge) AS menge_nur_tag1
        FROM dbp_ods.ods_bon_verkauf AS A
        INNER JOIN `_werbeartikel_1` AS B ON A.mandant_id = B.mandant_id AND DATE(A.start_bon_zeile) BETWEEN B.dat_von AND B.dat_bis AND A.wup_id = B.wup_id AND CAST(B.art_id / 100 AS INTEGER) = A.kl_art_id
        INNER JOIN (
            SELECT
                a.mandant_id,
                a.wup_id,
                a.werbetyp_id,
                MIN(B1.dat) AS min_dat
            FROM (
                SELECT
                    A0.mandant_id,
                    A0.wup_id,
                    A0.werbetyp_id,
                    A0.dat_von,
                    A0.dat_bis
                FROM `_werbeartikel_1` AS A0
                INNER JOIN dbp_data.wupcal AS B0
                    ON
                        A0.mandant_id = B0.mandant_id AND A0.wup_id = B0.wup_id AND
                        A0.dat_von = B0.dat
                WHERE B0.offen = 0
                GROUP BY
                    A0.werbetyp_id,
                    A0.dat_von,
                    A0.dat_bis,
                    A0.wup_id,
                    A0.mandant_id
            ) AS a
            INNER JOIN dbp_data.wupcal AS B1
                ON
                    a.mandant_id = B1.mandant_id AND a.wup_id = B1.wup_id AND B1.dat
                    BETWEEN a.dat_von AND a.dat_bis
            WHERE B1.offen = 1
            GROUP BY
                a.mandant_id,
                a.wup_id,
                a.werbetyp_id
        ) AS x
            ON
                A.mandant_id = x.mandant_id AND A.wup_id = x.wup_id AND B.werbetyp_id = x.werbetyp_id AND
                DATE(A.start_bon_zeile) = x.min_dat
        WHERE A.mandant_id = 1
        GROUP BY
            B.kjwo,
            B.werbetyp_id,
            B.wup_id,
            B.mandant_id,
            B.art_id
        HAVING menge_nur_tag1 > 0
    ) AS t7);


    UPDATE `_ff_we_artbew1` SET
        menge_nur_tag1 = CAST(
            b.menge_nur_tag1 AS INTEGER) FROM (
        SELECT DISTINCT *
        FROM `_fix_it_de2`
    ) AS b
    WHERE `_ff_we_artbew1`.mandant_id = b.mandant_id AND `_ff_we_artbew1`.wup_id = b.wup_id AND `_ff_we_artbew1`.art_id = b.art_id AND `_ff_we_artbew1`.kjwo = b.kjwo AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1` SET
        anzahl_nullbestand = b.anz_tage_null,
        anzahl_minusbestand = b.anz_tage_minus
    FROM `_test_we_mbst2` AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id AND `_ff_we_artbew1`.wup_id = b.wup_id AND `_ff_we_artbew1`.nb_id = b.nb_id
        AND `_ff_we_artbew1`.art_id = b.art_id AND `_ff_we_artbew1`.kjwo = b.kjwo AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1` SET
        anzahl_nullbestand_tag1 = b.anz_null_tag1,
        anzahl_nullbestand_tag2 = b.anz_null_tag2,
        anzahl_nullbestand_tag3 = b.anz_null_tag3,
        anzahl_nullbestand_tag4 = b.anz_null_tag4,
        anzahl_nullbestand_tag5 = b.anz_null_tag5,
        anzahl_nullbestand_tag6 = b.anz_null_tag6,
        anzahl_nullbestand_tag7 = b.anz_null_tag7,
        anzahl_minusbestand_tag1 = b.anz_minus_tag1
    FROM `_test_we_mbst2a` AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id AND `_ff_we_artbew1`.wup_id = b.wup_id AND `_ff_we_artbew1`.nb_id = b.nb_id
        AND `_ff_we_artbew1`.art_id = b.art_id AND `_ff_we_artbew1`.kjwo = b.kjwo AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1` SET
        anzahl_nullbestand_tag1bis3 = b.anz_null_tag1_bis_tag3,
        anzahl_minusbestand_tag1bis3 = b.anz_minus_tag1_bis_tag3
    FROM `_test_we_mbst2b` AS b
    WHERE
        `_ff_we_artbew1`.mandant_id = b.mandant_id AND `_ff_we_artbew1`.wup_id = b.wup_id AND `_ff_we_artbew1`.nb_id = b.nb_id
        AND `_ff_we_artbew1`.art_id = b.art_id AND `_ff_we_artbew1`.kjwo = b.kjwo AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1` SET
        menge_historie_af = CAST(b.menge_historie_af AS INTEGER) FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            SUM(D.menge) / 36.000 AS menge_historie_af
        FROM `_ff_we_artbew1` AS A
        INNER JOIN dbp_data.woche AS B ON A.kjwo = B.kjwo
        INNER JOIN dbp_data.woche_kj_kl AS C ON C.akt_wo BETWEEN B.akt_wo - 6 AND (B.akt_wo - 1)
        INNER JOIN dbp_data.artbew_wo_sum AS D
            ON
                A.mandant_id = D.mandant_id AND A.wup_id = D.wup_id AND A.art_id
                = D.art_id AND C.kjwo_kl = D.kjwo_kl
        WHERE
            D.bewart_id = 1001
            AND D.menge >= 0
        GROUP BY
            A.wup_id,
            A.mandant_id,
            A.art_id
    ) AS b
    WHERE `_ff_we_artbew1`.mandant_id = b.mandant_id AND `_ff_we_artbew1`.wup_id = b.wup_id AND `_ff_we_artbew1`.art_id = b.art_id;


    UPDATE `_ff_we_artbew1` SET
        anzahl_tage_aktion = b.anz_tage_aktion FROM (
        SELECT
            mandant_id,
            werbetyp_id,
            MAX(anz_tage_aktion) AS anz_tage_aktion
        FROM `_werbetyp_tage`
        GROUP BY
            mandant_id,
            werbetyp_id
    ) AS b
    WHERE `_ff_we_artbew1`.mandant_id = b.mandant_id AND `_ff_we_artbew1`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1` SET
        we_menge_ab_vorwoche = `_ff_we_artbew1`.we_menge + `_ff_we_artbew1`.we_menge_ab_vorwoche
    WHERE TRUE;


    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew2 AS
    SELECT
        A.kjwo,
        A.werbetyp_id,
        A.dat_von,
        A.dat_bis,
        A.wup_id,
        A.mandant_id,
        A.art_id,
        A.nb_id,
        A.posten_id,
        A.umsatz_netto_mo,
        A.umsatz_netto_di,
        A.umsatz_netto_mi,
        A.umsatz_netto_do,
        A.umsatz_netto_fr,
        A.umsatz_netto_sa,
        A.umsatz_netto_so,
        A.umsatz_netto_wo,
        A.menge_mo,
        A.menge_di,
        A.menge_mi,
        A.menge_do,
        A.menge_fr,
        A.menge_sa,
        A.menge_so,
        A.menge_wo,
        A.menge_sa2,
        A.tage_menge_0,
        A.we_menge,
        A.menge_aktionsstart,
        A.we_menge_ab_vorwoche,
        A.menge_endbestand,
        A.min_sicherh_bestand,
        A.faktor_flaki,
        A.anzahl_nullbestand,
        A.anzahl_tage_aktion,
        A.menge_historie_af,
        A.sollbestand,
        A.lager_prozent,
        A.mhd_zeitraum,
        A.menge_bestand_soll_max,
        A.menge_tag1_7bis13h,
        A.menge_nur_tag1,
        A.bezugsweg_id,
        A.we_menge_vor_aktion,
        A.anzahl_nullbestand_tag1,
        A.anzahl_nullbestand_tag2,
        A.anzahl_nullbestand_tag3,
        A.anzahl_nullbestand_tag4,
        A.anzahl_nullbestand_tag5,
        A.anzahl_nullbestand_tag6,
        A.anzahl_nullbestand_tag7,
        A.anzahl_nullbestand_tag1bis3,
        A.anzahl_minusbestand,
        A.anzahl_minusbestand_tag1,
        A.anzahl_minusbestand_tag1bis3,
        B.wtag_id AS wtag_id_start,
        C.wtag_id AS wtag_id_ende,
        W.mutter_wb_id,
        W.avq_relevant_fg,
        W.vk_vor_aktion_brutto,
        W.vk_aktion_brutto,
        W.vk_kcard_brutto
    FROM `_ff_we_artbew1` AS A
    INNER JOIN dbp_data.tag AS B
        ON CASE
            WHEN A.werbetyp_id = 1
                THEN DATE_ADD(A.dat_von, INTERVAL 1 DAY)
            ELSE A.dat_von
        END = B.dat
    INNER JOIN dbp_data.tag AS C ON A.dat_bis = C.dat
    INNER JOIN `_werbeartikel_1` AS W ON A.mandant_id = W.mandant_id AND A.wup_id = W.wup_id AND A.art_id = W.art_id AND A.dat_von BETWEEN W.dat_von AND W.dat_bis AND A.werbetyp_id = W.werbetyp_id;


    DELETE FROM dbp_data.werbung_kennzahlen_woche
    WHERE (mandant_id, wup_id, nb_id, art_id, kjwo, werbe_typ_id) IN (SELECT (
        mandant_id, wup_id, nb_id, art_id, kjwo,
        werbetyp_id
    )
    FROM `_ff_we_artbew2`);


    INSERT INTO dbp_data.werbung_kennzahlen_woche (
        mandant_id, kjwo, wup_id, nb_id, art_id, werbe_typ_id,
        menge_tag1, menge_tag2, menge_tag3, menge_tag4, menge_tag5, menge_tag6, menge_tag7, menge_nur_tag1, tage_menge_0,
        menge_endbestand, menge_aktionsstart, umsatz_netto_tag1, umsatz_netto_tag2, umsatz_netto_tag3, umsatz_netto_tag4,
        umsatz_netto_tag5, umsatz_netto_tag6, umsatz_netto_tag7, we_menge, min_sicherh_bestand, posten_id, we_menge_zentral,
        faktor_flaki, mutter_wb_id, wtag_id_start, wtag_id_ende, menge_historie_af, anzahl_nullbestand, anzahl_tage_aktion,
        menge_tag1_7bis13h, lager_prozent, mhd_zeitraum, sollbestand, menge_bestand_soll_max, werbenachvermarktung_fg,
        we_menge_vor_aktion, art_mutter_bezugsweg_id, anzahl_nullbestand_tag1, anzahl_nullbestand_tag2, anzahl_nullbestand_tag3,
        anzahl_nullbestand_tag4, anzahl_nullbestand_tag5, anzahl_nullbestand_tag6, anzahl_nullbestand_tag7,
        anzahl_nullbestand_tag1bis3, anzahl_minusbestand, anzahl_minusbestand_tag1, anzahl_minusbestand_tag1bis3,
        avq_relevant_fg, wrg_id, menge_sa, vk_vor_aktion_brutto, vk_aktion_brutto, vk_kcard_brutto, td_update, td_insert
    )
    (SELECT
        mandant_id,
        kjwo,
        wup_id,
        nb_id,
        art_id,
        werbetyp_id AS werbe_typ_id,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_mo
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_do
            WHEN werbetyp_id IN (16)
                THEN menge_sa
            WHEN werbetyp_id IN (18)
                THEN menge_fr
            ELSE 0
        END AS NUMERIC) AS menge_tag1,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_di
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_fr
            WHEN werbetyp_id IN (16)
                THEN menge_so
            WHEN werbetyp_id IN (18)
                THEN menge_sa
            ELSE 0
        END AS NUMERIC) AS menge_tag2,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_mi
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_sa
            WHEN werbetyp_id IN (16)
                THEN menge_mo
            WHEN werbetyp_id IN (18)
                THEN menge_so
            ELSE 0
        END AS NUMERIC) AS menge_tag3,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_do
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_so
            WHEN werbetyp_id IN (16)
                THEN menge_di
            WHEN werbetyp_id IN (18)
                THEN menge_mo
            ELSE 0
        END AS NUMERIC) AS menge_tag4,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_fr
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_mo
            WHEN werbetyp_id IN (16)
                THEN menge_mi
            WHEN werbetyp_id IN (18)
                THEN menge_di
            ELSE 0
        END AS NUMERIC) AS menge_tag5,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_sa
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_di
            WHEN werbetyp_id IN (16)
                THEN menge_do
            WHEN werbetyp_id IN (18)
                THEN menge_mi
            ELSE 0
        END AS NUMERIC) AS menge_tag6,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_so
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_mi
            WHEN werbetyp_id IN (16)
                THEN menge_fr
            WHEN werbetyp_id IN (18)
                THEN menge_do
            ELSE 0
        END AS NUMERIC) AS menge_tag7,
        menge_nur_tag1,
        tage_menge_0,
        menge_endbestand,
        menge_aktionsstart,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_mo
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_do
            WHEN werbetyp_id IN (16)
                THEN umsatz_netto_sa
            WHEN werbetyp_id IN (18)
                THEN umsatz_netto_fr
            ELSE 0
        END AS NUMERIC) AS umsatz_netto_tag1,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_di
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_fr
            WHEN werbetyp_id IN (16)
                THEN umsatz_netto_so
            WHEN werbetyp_id IN (18)
                THEN umsatz_netto_sa
            ELSE 0
        END AS NUMERIC) AS umsatz_netto_tag2,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_mi
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_sa
            WHEN werbetyp_id IN (16)
                THEN umsatz_netto_mo
            WHEN werbetyp_id IN (18)
                THEN umsatz_netto_so
            ELSE 0
        END AS NUMERIC) AS umsatz_netto_tag3,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_do
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_so
            WHEN werbetyp_id IN (16)
                THEN umsatz_netto_di
            WHEN werbetyp_id IN (18)
                THEN umsatz_netto_mo
            ELSE 0
        END AS NUMERIC) AS umsatz_netto_tag4,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_fr
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_mo
            WHEN werbetyp_id IN (16)
                THEN umsatz_netto_mi
            WHEN werbetyp_id IN (18)
                THEN umsatz_netto_di
            ELSE 0
        END AS NUMERIC) AS umsatz_netto_tag5,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_sa
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_di
            WHEN werbetyp_id IN (16)
                THEN umsatz_netto_do
            WHEN werbetyp_id IN (18)
                THEN umsatz_netto_mi
            ELSE 0
        END AS NUMERIC) AS umsatz_netto_tag6,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_so
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_mi
            WHEN werbetyp_id IN (16)
                THEN umsatz_netto_fr
            WHEN werbetyp_id IN (18)
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
        END AS INTEGER) AS anzahl_nullbestand,
        CAST(anzahl_tage_aktion AS INTEGER) AS anzahl_tage_aktion,
        menge_tag1_7bis13h,
        CAST(lager_prozent AS INTEGER) AS lager_prozent,
        CAST(mhd_zeitraum AS INTEGER) AS mhd_zeitraum,
        sollbestand,
        menge_bestand_soll_max,
        0 AS werbenachvermarktung_fg,
        we_menge_vor_aktion,
        CAST(bezugsweg_id AS INTEGER) AS bezugsweg_id,
        CAST(anzahl_nullbestand_tag1 AS INTEGER) AS anzahl_nullbestand_tag1,
        CAST(anzahl_nullbestand_tag2 AS INTEGER) AS anzahl_nullbestand_tag2,
        CAST(anzahl_nullbestand_tag3 AS INTEGER) AS anzahl_nullbestand_tag3,
        CAST(anzahl_nullbestand_tag4 AS INTEGER) AS anzahl_nullbestand_tag4,
        CAST(anzahl_nullbestand_tag5 AS INTEGER) AS anzahl_nullbestand_tag5,
        CAST(anzahl_nullbestand_tag6 AS INTEGER) AS anzahl_nullbestand_tag6,
        CAST(anzahl_nullbestand_tag7 AS INTEGER) AS anzahl_nullbestand_tag7,
        CAST(anzahl_nullbestand_tag1bis3 AS INTEGER) AS anzahl_nullbestand_tag1bis3,
        CAST(anzahl_minusbestand AS INTEGER) AS anzahl_minusbestand,
        CAST(anzahl_minusbestand_tag1 AS INTEGER) AS anzahl_minusbestand_tag1,
        CAST(anzahl_minusbestand_tag1bis3 AS INTEGER) AS anzahl_minusbestand_tag1bis3,
        avq_relevant_fg,
        'EUR' AS wrg_id,
        CAST(menge_sa2 AS NUMERIC) AS menge_sa2,
        vk_vor_aktion_brutto,
        vk_aktion_brutto,
        vk_kcard_brutto,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM `_ff_we_artbew2`);


    CREATE OR REPLACE TEMPORARY TABLE _not_in1 AS
    SELECT *
    FROM `_werbeartikel_1`
    WHERE (
        kjwo, wup_id, mandant_id, art_id, werbetyp_id) NOT IN (
        SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
        FROM `_ff_we_artbew2`
    );


    CREATE OR REPLACE TEMPORARY TABLE _ff_we1_not_in AS
    SELECT
        A.mandant_id,
        A.kjwo,
        A.dat_von,
        A.dat_bis,
        A.werbetyp_id,
        A.wup_id,
        A.art_id
    FROM `_not_in1` AS A
    INNER JOIN dbp_data.art_wg_zu_per
        AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
    = 2 AND B.dat_bis = DATE '9999-12-31';


    CREATE OR REPLACE TEMPORARY TABLE _ff_we2_not_in AS
    SELECT
        A.mandant_id,
        A.kjwo,
        A.dat_von,
        A.dat_bis,
        A.werbetyp_id,
        A.wup_id,
        A.art_id,
        b.dat,
        b.dat_2
    FROM `_ff_we1_not_in` AS A
    INNER JOIN (
        SELECT
            A0.kjwo,
            A0.werbetyp_id,
            CASE
                WHEN B.dat BETWEEN A0.dat_von AND A0.dat_bis
                    THEN B.dat
                ELSE NULL
            END AS dat,
            CASE
                WHEN B.dat NOT BETWEEN A0.dat_von AND A0.dat_bis
                    THEN B.dat
                ELSE NULL
            END AS dat_2
        FROM `_ff_we1_not_in` AS A0
        INNER JOIN dbp_data.tag AS B ON B.dat BETWEEN DATE_SUB(A0.dat_von, INTERVAL 7 DAY) AND A0.dat_bis
        GROUP BY
            A0.kjwo,
            A0.werbetyp_id,
            dat,
            dat_2
    ) AS b ON A.kjwo = b.kjwo AND A.werbetyp_id = b.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _ff_we3_not_in AS
    SELECT
        A.mandant_id,
        A.werbetyp_id,
        A.dat_von,
        A.dat_bis,
        A.kjwo,
        COALESCE(A.dat, A.dat_2) AS dat,
        A.wup_id,
        A.art_id,
        COALESCE(b.menge_lagerbew_bme, 0) AS we_menge,
        COALESCE(c.menge_lagerbew_bme, 0) AS we_menge_2
    FROM `_ff_we2_not_in` AS A
    LEFT JOIN (
        SELECT
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew AS A
        INNER JOIN dbp_data.lagerbew_det AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_not_in`
            WHERE dat IS NOT NULL
        ) AS c
            ON
                B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch
                = c.dat
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id = 'WE'
            AND CASE
                WHEN
                    B.dat_buch < DATE '2020-02-01' AND C1.bestellart_id IN (
                        'ZLNS', 'ZLN', 'UBE', 'ZDZA', 'ZLLA', 'ZLA', 'ZLAS',
                        'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL') OR B.dat_buch >= DATE '2020-02-01' AND C1.bestellart_id IN (
                        'UBE',
                        'ZDZA', 'ZLLA', 'ZLA', 'ZLAS', 'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND A.mandant_id = 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_not_in`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_not_in`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu
                WHERE
                    mandant_id = 1
                    AND spr_id = 22
                    AND lager_bewart_bez LIKE '%Retoure%'
            )
            AND X.wg_id NOT IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 25
                    AND mandant_id = 1
            )
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            c.werbetyp_id
        UNION ALL
        SELECT
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew AS A
        INNER JOIN dbp_data.lagerbew_det AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_not_in`
            WHERE dat IS NOT NULL
        ) AS c
            ON
                B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch
                = c.dat
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id = 'WE'
            AND X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 25
                    AND mandant_id = 1
            )
            AND A.mandant_id = 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_not_in`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_not_in`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu
                WHERE
                    mandant_id = 1
                    AND spr_id = 22
                    AND lager_bewart_bez LIKE '%Retoure%'
            )
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            c.werbetyp_id
        UNION ALL
        SELECT
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            c.dat_2 AS dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew AS A
        INNER JOIN dbp_data.lagerbew_det AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_not_in`
            WHERE dat_2 IS NOT NULL
        ) AS c
            ON B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch = DATE_SUB(c.dat_2, INTERVAL 7 DAY)
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id = 'WE'
            AND CASE
                WHEN
                    B.dat_buch < DATE '2020-02-01' AND C1.bestellart_id IN (
                        'ZLNS', 'ZLN', 'UBE', 'ZDZA', 'ZLLA', 'ZLA', 'ZLAS',
                        'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL') OR B.dat_buch >= DATE '2020-02-01' AND C1.bestellart_id IN (
                        'UBE',
                        'ZDZA', 'ZLLA', 'ZLA', 'ZLAS', 'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 30
                    AND mandant_id = 1
            )
            AND A.mandant_id = 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_not_in`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_not_in`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu
                WHERE
                    mandant_id = 1
                    AND spr_id = 22
                    AND lager_bewart_bez LIKE '%Retoure%'
            )
        GROUP BY
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            dat_buch
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.art_id = b.art_id AND A.dat = b.dat_buch
            AND A.werbetyp_id = b.werbetyp_id
    LEFT JOIN (
        SELECT
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew AS A
        INNER JOIN dbp_data.lagerbew_det AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_not_in`
            WHERE dat_2 IS NOT NULL
        ) AS c
            ON B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id = 'WE'
            AND CASE
                WHEN
                    B.dat_buch < DATE '2020-02-01' AND C1.bestellart_id IN (
                        'ZLNS', 'ZLN', 'UBE', 'ZDZA', 'ZLLA', 'ZLA', 'ZLAS',
                        'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL') OR B.dat_buch >= DATE '2020-02-01' AND C1.bestellart_id IN (
                        'UBE',
                        'ZDZA', 'ZLLA', 'ZLA', 'ZLAS', 'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND A.mandant_id = 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_not_in`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_not_in`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu
                WHERE
                    mandant_id = 1
                    AND spr_id = 22
                    AND lager_bewart_bez LIKE '%Retoure%'
            )
            AND X.wg_id NOT IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 25
                    AND mandant_id = 1
            )
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            c.werbetyp_id
        UNION ALL
        SELECT
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew AS A
        INNER JOIN dbp_data.lagerbew_det AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_not_in`
            WHERE dat_2 IS NOT NULL
        ) AS c
            ON B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id = 'WE'
            AND X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 25
                    AND mandant_id = 1
            )
            AND A.mandant_id = 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_not_in`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_not_in`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN (
                SELECT lager_bewart_id
                FROM dbp_data.lager_bewart_spr_zu
                WHERE
                    mandant_id = 1
                    AND spr_id = 22
                    AND lager_bewart_bez LIKE '%Retoure%'
            )
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            c.werbetyp_id
    )
        AS c ON A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_2 = c.dat_buch
    AND A.werbetyp_id = c.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _x_ray_not_in AS
    SELECT
        t0.mandant_id,
        t0.wup_id,
        t0.werbetyp_id,
        b.kopf_art AS art_id,
        t0.dat,
        t0.dat_2
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
    ) AS t0
    INNER JOIN (
        SELECT kopf_art
        FROM `_stpo`
        GROUP BY kopf_art
    ) AS b
        ON TRUE;


    CREATE OR REPLACE TEMPORARY TABLE _help_me11 AS
    SELECT
        mandant_id,
        dat
    FROM `_x_ray_not_in`
    WHERE dat IS NOT NULL
    GROUP BY
        mandant_id,
        dat;


    CREATE OR REPLACE TEMPORARY TABLE _help_me22 AS
    SELECT
        mandant_id,
        dat_2
    FROM `_x_ray_not_in`
    WHERE dat_2 IS NOT NULL
    GROUP BY
        mandant_id,
        dat_2;


    CREATE OR REPLACE TEMPORARY TABLE _mseg_package_ekpo_not_in AS
    SELECT
        B.mandant_id,
        B.lagerbew_beleg_id,
        B.lagerbew_beleg_pos_id,
        B.kj,
        B.grund_id,
        B.lager_bewart_id,
        B.art_id,
        B.wup_id,
        B.nb_id,
        B.auto_fg,
        B.lagerort_id,
        B.gp_id,
        B.einkaufsorganisation_id,
        B.soll_haben_kz,
        B.wrg_id,
        B.best_beleg_id,
        B.best_beleg_pos_id,
        B.betrag_lagerbew,
        B.betrag_verkauf,
        B.erfsngs_menge_einh_id,
        B.lagerplatz_id,
        B.kunde_id,
        B.menge_lagerbew_kolli,
        B.menge_lagerbew_bme,
        B.menge_lagerbew_palette,
        B.menge_lieferschein,
        B.menge_lief,
        B.menge_erf,
        B.empfaenger_id,
        B.dat_buch,
        B.lagerbew_beleg_storno_id,
        B.lagerbew_beleg_pos_storno_id,
        B.lagerbew_beleg_storno_kj,
        B.betrag_vk_netto,
        B.system_id,
        B.betrag_belegfluss_wg_art,
        B.mandant_id_kunde,
        B.mandant_id_empfaenger,
        B.bw_vorgang_id,
        B.betrag_verkauf_ist,
        B.betrag_vk_netto_vz,
        B.betrag_verkauf_ist_netto,
        B.betrag_einstandspreis,
        B.gp_id_zl,
        B.bq_findung_id,
        B.lagerbew_beleg_pos_mutter_id,
        B.line_id,
        B.display_art_id,
        B.td_update,
        B.td_insert
    FROM dbp_data.lagerbew AS A
    INNER JOIN dbp_data.lagerbew_det AS B
        ON
            A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
            AND A.dat_buch = B.dat_buch
    INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

    INNER JOIN dbp_data.besch_best_det AS C2
        ON
            B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
            AND B.art_id = C2.art_id
    WHERE
        A.vorgangsart_id = 'WE'
        AND CASE
            WHEN
                B.dat_buch < DATE '2020-02-01' AND C1.bestellart_id IN (
                    'ZLNS', 'ZLN', 'UBE', 'ZDZA', 'ZLLA', 'ZLA', 'ZLAS',
                    'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL') OR B.dat_buch >= DATE '2020-02-01' AND C1.bestellart_id IN (
                    'UBE',
                    'ZDZA', 'ZLLA', 'ZLA', 'ZLAS', 'ZAME', 'ZWRP', 'UBGK', 'UBG1', 'UBG2', 'ZWWL'
                )
                THEN 1
            ELSE 0
        END = 1
        AND A.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me11`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me22`
            ) AS t1
        )
        AND A.mandant_id = 1
        AND B.lager_bewart_id NOT IN (
            SELECT lager_bewart_id
            FROM dbp_data.lager_bewart_spr_zu
            WHERE
                mandant_id = 1
                AND spr_id = 22
                AND lager_bewart_bez LIKE '%Retoure%'
        );


    CREATE OR REPLACE TEMPORARY TABLE _mseg_package_not_ekpo_not_in AS
    SELECT
        B.mandant_id,
        B.lagerbew_beleg_id,
        B.lagerbew_beleg_pos_id,
        B.kj,
        B.grund_id,
        B.lager_bewart_id,
        B.art_id,
        B.wup_id,
        B.nb_id,
        B.auto_fg,
        B.lagerort_id,
        B.gp_id,
        B.einkaufsorganisation_id,
        B.soll_haben_kz,
        B.wrg_id,
        B.best_beleg_id,
        B.best_beleg_pos_id,
        B.betrag_lagerbew,
        B.betrag_verkauf,
        B.erfsngs_menge_einh_id,
        B.lagerplatz_id,
        B.kunde_id,
        B.menge_lagerbew_kolli,
        B.menge_lagerbew_bme,
        B.menge_lagerbew_palette,
        B.menge_lieferschein,
        B.menge_lief,
        B.menge_erf,
        B.empfaenger_id,
        B.dat_buch,
        B.lagerbew_beleg_storno_id,
        B.lagerbew_beleg_pos_storno_id,
        B.lagerbew_beleg_storno_kj,
        B.betrag_vk_netto,
        B.system_id,
        B.betrag_belegfluss_wg_art,
        B.mandant_id_kunde,
        B.mandant_id_empfaenger,
        B.bw_vorgang_id,
        B.betrag_verkauf_ist,
        B.betrag_vk_netto_vz,
        B.betrag_verkauf_ist_netto,
        B.betrag_einstandspreis,
        B.gp_id_zl,
        B.bq_findung_id,
        B.lagerbew_beleg_pos_mutter_id,
        B.line_id,
        B.display_art_id,
        B.td_update,
        B.td_insert
    FROM dbp_data.lagerbew AS A
    INNER JOIN dbp_data.lagerbew_det AS B
        ON
            A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
            AND A.dat_buch = B.dat_buch
    INNER JOIN dbp_data.besch_best AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

    INNER JOIN dbp_data.besch_best_det AS C2
        ON
            B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
            AND B.art_id = C2.art_id
    WHERE
        A.vorgangsart_id = 'WE'
        AND A.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me11`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me22`
            ) AS t1
        )
        AND A.mandant_id = 1
        AND B.lager_bewart_id NOT IN (
            SELECT lager_bewart_id
            FROM dbp_data.lager_bewart_spr_zu
            WHERE
                mandant_id = 1
                AND spr_id = 22
                AND lager_bewart_bez LIKE '%Retoure%'
        );


    CREATE OR REPLACE TEMPORARY TABLE _x_track1_not_in AS
    SELECT
        A.mandant_id,
        c.werbetyp_id,
        A.lagerbew_beleg_id,
        A.wup_id,
        A.art_id,
        A.dat_buch,
        SUM(A.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_ekpo_not_in` AS A
    INNER JOIN (
        SELECT *
        FROM `_x_ray_not_in`
        WHERE dat IS NOT NULL
    ) AS c
        ON
            A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_buch
            = c.dat
    INNER JOIN dbp_data.art_wg_zu_per AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE (
        A.mandant_id, A.dat_buch) IN (
        SELECT (mandant_id, dat)
        FROM `_help_me11`
    )
    AND X.wg_id NOT IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu
        WHERE
            wg_filter_id = 25
            AND mandant_id = 1
    )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        c.werbetyp_id
    UNION ALL
    SELECT
        A.mandant_id,
        c.werbetyp_id,
        A.lagerbew_beleg_id,
        A.wup_id,
        A.art_id,
        A.dat_buch,
        SUM(A.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_not_ekpo_not_in` AS A
    INNER JOIN (
        SELECT *
        FROM `_x_ray_not_in`
        WHERE dat IS NOT NULL
    ) AS c
        ON
            A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_buch
            = c.dat
    INNER JOIN dbp_data.art_wg_zu_per AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE
        X.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu
            WHERE
                wg_filter_id = 25
                AND mandant_id = 1
        )
        AND (
            A.mandant_id, A.dat_buch) IN (
            SELECT (mandant_id, dat)
            FROM `_help_me11`
        )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        c.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _x_track2_not_in AS
    SELECT
        A.mandant_id,
        c.werbetyp_id,
        A.lagerbew_beleg_id,
        A.wup_id,
        A.art_id,
        A.dat_buch,
        SUM(A.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_ekpo_not_in` AS A
    INNER JOIN (
        SELECT *
        FROM `_x_ray_not_in`
        WHERE dat_2 IS NOT NULL
    ) AS c
        ON
            A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_buch
            = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE (
        A.mandant_id, A.dat_buch) IN (
        SELECT (mandant_id, dat_2)
        FROM `_help_me22`
    )
    AND X.wg_id NOT IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu
        WHERE
            wg_filter_id = 25
            AND mandant_id = 1
    )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        c.werbetyp_id
    UNION ALL
    SELECT
        A.mandant_id,
        c.werbetyp_id,
        A.lagerbew_beleg_id,
        A.wup_id,
        A.art_id,
        A.dat_buch,
        SUM(A.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_not_ekpo_not_in` AS A
    INNER JOIN (
        SELECT *
        FROM `_x_ray_not_in`
        WHERE dat_2 IS NOT NULL
    ) AS c
        ON
            A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_buch
            = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE
        X.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu
            WHERE
                wg_filter_id = 25
                AND mandant_id = 1
        )
        AND (
            A.mandant_id, A.dat_buch) IN (
            SELECT (mandant_id, dat_2)
            FROM `_help_me22`
        )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        c.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _display_update_not_in AS
    SELECT
        B.mandant_id,
        c.werbetyp_id,
        B.wup_id,
        B.art_id,
        B.dat_buch,
        SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM dbp_data.lagerbew AS A
    INNER JOIN dbp_data.lagerbew_det AS B
        ON
            A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
            AND A.dat_buch = B.dat_buch
    INNER JOIN (
        SELECT
            c.mandant_id,
            c.werbetyp_id,
            c.lagerbew_beleg_id,
            c.wup_id,
            B0.art_id,
            c.dat_buch
        FROM dbp_data.stueckliste AS A0
        INNER JOIN dbp_data.stueckliste_det AS B0 ON A0.mandant_id = B0.mandant_id AND A0.stueckliste_id = B0.stueckliste_id
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
        ) AS c ON A0.mandant_id = c.mandant_id AND A0.art_id = c.art_id
        WHERE A0.dat_bis = DATE '9999-12-31'
        GROUP BY
            c.mandant_id,
            c.werbetyp_id,
            c.lagerbew_beleg_id,
            c.wup_id,
            B0.art_id,
            c.dat_buch
    ) AS c
        ON
            B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch = c.dat_buch
            AND B.lagerbew_beleg_id = c.lagerbew_beleg_id
    WHERE
        A.vorgangsart_id = 'WE'
        AND B.lager_bewart_id NOT IN (
            SELECT lager_bewart_id
            FROM dbp_data.lager_bewart_spr_zu
            WHERE
                mandant_id = 1
                AND spr_id = 22
                AND lager_bewart_bez LIKE '%Retoure%'
        )
    GROUP BY
        B.mandant_id,
        c.werbetyp_id,
        B.wup_id,
        B.art_id,
        B.dat_buch;


    UPDATE `_ff_we3_not_in` SET
        we_menge = b.menge_lagerbew_bme + `_ff_we3_not_in`.we_menge
    FROM `_display_update_not_in` AS b
    WHERE
        `_ff_we3_not_in`.mandant_id = b.mandant_id AND `_ff_we3_not_in`.wup_id = b.wup_id AND `_ff_we3_not_in`.art_id = b.art_id AND `_ff_we3_not_in`.werbetyp_id = b.werbetyp_id AND `_ff_we3_not_in`.dat = b.dat_buch AND `_ff_we3_not_in`
        .dat BETWEEN `_ff_we3_not_in`.dat_von AND `_ff_we3_not_in`.dat_bis;


    UPDATE `_ff_we3_not_in` SET
        we_menge_2 = b.menge_lagerbew_bme + `_ff_we3_not_in`.we_menge_2
    FROM `_display_update_not_in` AS b
    WHERE
        `_ff_we3_not_in`.mandant_id = b.mandant_id AND `_ff_we3_not_in`.wup_id = b.wup_id AND `_ff_we3_not_in`.art_id = b.art_id AND `_ff_we3_not_in`.werbetyp_id = b.werbetyp_id AND `_ff_we3_not_in`.dat = b.dat_buch AND `_ff_we3_not_in`
        .dat NOT BETWEEN `_ff_we3_not_in`.dat_von AND `_ff_we3_not_in`.dat_bis;


    UPDATE `_ff_we3_not_in` SET
        we_menge_2 = 0 FROM (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            DATE_SUB(A.dat_von, INTERVAL 3 DAY) AS min_dat
        FROM `_ff_we3_not_in` AS A
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        WHERE
            X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 27
                    AND mandant_id = 1
            )
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3_not_in`.mandant_id = b.mandant_id AND `_ff_we3_not_in`.wup_id = b.wup_id AND `_ff_we3_not_in`.werbetyp_id
        = b.werbetyp_id AND `_ff_we3_not_in`.art_id = b.art_id AND `_ff_we3_not_in`.dat < b.min_dat;


    UPDATE `_ff_we3_not_in` SET
        we_menge_2 = 0 FROM (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            CASE
                WHEN A.werbetyp_id = 3
                    THEN DATE_SUB(A.dat_von, INTERVAL 3 DAY)
                ELSE DATE_SUB(A.dat_von, INTERVAL 1 DAY)
            END AS min_dat
        FROM `_ff_we3_not_in` AS A
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        WHERE
            X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 28
                    AND mandant_id = 1
            )
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3_not_in`.mandant_id = b.mandant_id AND `_ff_we3_not_in`.wup_id = b.wup_id AND `_ff_we3_not_in`.werbetyp_id
        = b.werbetyp_id AND `_ff_we3_not_in`.art_id = b.art_id AND `_ff_we3_not_in`.dat < b.min_dat;


    UPDATE `_ff_we3_not_in` SET
        we_menge_2 = 0 FROM (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von AS min_dat
        FROM `_ff_we3_not_in` AS A
        INNER JOIN dbp_data.art_wg_zu_per AS X
            ON
                A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        WHERE
            X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 12
                    AND mandant_id = 1
            )
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3_not_in`.mandant_id = b.mandant_id AND `_ff_we3_not_in`.wup_id = b.wup_id AND `_ff_we3_not_in`.werbetyp_id
        = b.werbetyp_id AND `_ff_we3_not_in`.art_id = b.art_id AND `_ff_we3_not_in`.dat < b.min_dat;


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
    FROM `_ff_we3_not_in` AS A
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
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        SUM(COALESCE(U.menge_lgbest_erp_frei_bme, 0)) AS menge_aktionsstart
    FROM `_ff_we4_not_in` AS V
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            CASE
                WHEN werbetyp_id = 1
                    THEN dat_von
                ELSE DATE_SUB(dat_von, INTERVAL 1 DAY)
            END AS dat_von,
            kjwo
        FROM `_werbeartikel_1`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_von,
            kjwo
    ) AS w
        ON
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    LEFT JOIN dbp_data.marktbestand_erp AS U
        ON
            w.mandant_id = U.mandant_id AND w.wup_id = U.wup_id AND w.art_id
            = U.art_id AND w.dat_von = U.dat
    GROUP BY
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id;


    UPDATE `_ff_we4_not_in` SET
        menge_aktionsstart = CAST(
            b.menge_aktionsstart AS INTEGER) FROM (
        SELECT *
        FROM `_mbst_we1_not_in`
        WHERE menge_aktionsstart <> 0
    ) AS b
    WHERE `_ff_we4_not_in`.mandant_id = b.mandant_id AND `_ff_we4_not_in`.wup_id = b.wup_id AND `_ff_we4_not_in`.art_id = b.art_id AND `_ff_we4_not_in`.kjwo = b.kjwo AND `_ff_we4_not_in`.werbetyp_id = b.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art_not_in AS
    SELECT
        mandant_id,
        art_id,
        COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
    FROM dbp_data.art AS A
    WHERE
        dat_bis = DATE '9999-12-31'
        AND (
            mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM `_ff_we4_not_in`
            GROUP BY mandant_id,
            art_id
        )
    GROUP BY
        mandant_id,
        art_id,
        mutter_wb_id;


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst1_not_in AS
    SELECT
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        SUM(COALESCE(U.menge_lgbest_erp_frei_bme, 0)) AS menge_endbestand
    FROM `_ff_we4_not_in` AS V
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_bis,
            kjwo
        FROM `_werbeartikel_1`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_bis,
            kjwo
    ) AS w
        ON
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    LEFT JOIN dbp_data.marktbestand_erp AS U
        ON
            w.mandant_id = U.mandant_id AND w.wup_id = U.wup_id AND w.art_id
            = U.art_id AND w.dat_bis = U.dat AND U.menge_lgbest_erp_frei_bme >= 0
    GROUP BY
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id;


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2_not_in AS
    SELECT
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        SUM(CASE
            WHEN
                XX.gewart_id = 'ST' AND X.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND X.menge_lgbest_erp_frei_bme
                BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND X.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                THEN 1
            ELSE 0
        END) AS anz_tage_null,
        SUM(CASE
            WHEN
                XX.gewart_id = 'ST' AND X.menge_lgbest_erp_frei_bme < 0 OR XX.gewart_id = 'KG' AND X.menge_lgbest_erp_frei_bme <
                0.000 OR XX.gewart_id = 'G' AND X.menge_lgbest_erp_frei_bme < 0.000
                THEN 1
            ELSE 0
        END) AS anz_tage_minus
    FROM `_ff_we4_not_in` AS V
    INNER JOIN (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von,
            A.dat_bis,
            B.dat,
            A.kjwo
        FROM `_werbeartikel_1` AS A
        INNER JOIN dbp_data.tag AS B ON B.dat BETWEEN A.dat_von AND A.dat_bis
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von,
            A.dat_bis,
            B.dat,
            A.kjwo
    ) AS w
        ON
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    INNER JOIN dbp_data.art AS XX ON V.mandant_id = XX.mandant_id AND V.art_id = XX.art_id
    LEFT JOIN dbp_data.marktbestand_erp AS X
        ON
            w.mandant_id = X.mandant_id AND w.wup_id = X.wup_id AND w.art_id
            = X.art_id AND w.dat = X.dat AND X.dat < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id;


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2a_not_in AS
    SELECT
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        MAX(CASE
            WHEN
                XX.gewart_id = 'ST' AND X.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND X.menge_lgbest_erp_frei_bme
                BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND X.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                THEN 1
            ELSE 0
        END) AS anz_null_tag1,
        0 AS anz_null_tag2,
        0 AS anz_null_tag3,
        0 AS anz_null_tag4,
        0 AS anz_null_tag5,
        0 AS anz_null_tag6,
        0 AS anz_null_tag7,
        MAX(CASE
            WHEN
                XX.gewart_id = 'ST' AND X.menge_lgbest_erp_frei_bme < 0 OR XX.gewart_id = 'KG' AND X.menge_lgbest_erp_frei_bme <
                0.000 OR XX.gewart_id = 'G' AND X.menge_lgbest_erp_frei_bme < 0.000
                THEN 1
            ELSE 0
        END) AS anz_minus_tag1
    FROM `_ff_we4_not_in` AS V
    INNER JOIN (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von,
            A.dat_bis,
            B.dat,
            A.kjwo
        FROM `_werbeartikel_1` AS A
        INNER JOIN dbp_data.tag AS B ON A.dat_von = B.dat
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von,
            A.dat_bis,
            B.dat,
            A.kjwo
    ) AS w
        ON
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    INNER JOIN dbp_data.art AS XX ON V.mandant_id = XX.mandant_id AND V.art_id = XX.art_id
    LEFT JOIN dbp_data.marktbestand_erp AS X
        ON
            w.mandant_id = X.mandant_id AND w.wup_id = X.wup_id AND w.art_id
            = X.art_id AND w.dat = X.dat AND X.dat < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id;


    UPDATE `_test_we_mbst2a_not_in` SET
        anz_null_tag2 = b.anz_null_tag2 FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(CASE
                WHEN
                    XX.gewart_id = 'ST' AND A.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND A.menge_lgbest_erp_frei_bme
                    BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND A.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END) AS anz_null_tag2
        FROM dbp_data.marktbestand_erp AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.tag AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 1 DAY) AND A0.dat_bis >= B.dat

            GROUP BY
                A0.werbetyp_id,
                A0.dat_von,
                A0.dat_bis,
                A0.wup_id,
                A0.mandant_id,
                A0.art_id,
                B.dat
        ) AS w
            ON
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin"
                )
        INNER JOIN dbp_data.art AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a_not_in`.mandant_id = b.mandant_id AND `_test_we_mbst2a_not_in`.wup_id = b.wup_id AND
        `_test_we_mbst2a_not_in`.art_id = b.art_id AND `_test_we_mbst2a_not_in`.dat_von = b.dat_von AND
        `_test_we_mbst2a_not_in`.dat_bis = b.dat_bis AND `_test_we_mbst2a_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_test_we_mbst2a_not_in` SET
        anz_null_tag3 = b.anz_null_tag3 FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(CASE
                WHEN
                    XX.gewart_id = 'ST' AND A.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND A.menge_lgbest_erp_frei_bme
                    BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND A.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END) AS anz_null_tag3
        FROM dbp_data.marktbestand_erp AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.tag AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 2 DAY) AND A0.dat_bis >= B.dat

            GROUP BY
                A0.werbetyp_id,
                A0.dat_von,
                A0.dat_bis,
                A0.wup_id,
                A0.mandant_id,
                A0.art_id,
                B.dat
        ) AS w
            ON
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin"
                )
        INNER JOIN dbp_data.art AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a_not_in`.mandant_id = b.mandant_id AND `_test_we_mbst2a_not_in`.wup_id = b.wup_id AND
        `_test_we_mbst2a_not_in`.art_id = b.art_id AND `_test_we_mbst2a_not_in`.dat_von = b.dat_von AND
        `_test_we_mbst2a_not_in`.dat_bis = b.dat_bis AND `_test_we_mbst2a_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_test_we_mbst2a_not_in` SET
        anz_null_tag4 = b.anz_null_tag4 FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(CASE
                WHEN
                    XX.gewart_id = 'ST' AND A.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND A.menge_lgbest_erp_frei_bme
                    BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND A.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END) AS anz_null_tag4
        FROM dbp_data.marktbestand_erp AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.tag AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 3 DAY) AND A0.dat_bis >= B.dat

            GROUP BY
                A0.werbetyp_id,
                A0.dat_von,
                A0.dat_bis,
                A0.wup_id,
                A0.mandant_id,
                A0.art_id,
                B.dat
        ) AS w
            ON
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin"
                )
        INNER JOIN dbp_data.art AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a_not_in`.mandant_id = b.mandant_id AND `_test_we_mbst2a_not_in`.wup_id = b.wup_id AND
        `_test_we_mbst2a_not_in`.art_id = b.art_id AND `_test_we_mbst2a_not_in`.dat_von = b.dat_von AND
        `_test_we_mbst2a_not_in`.dat_bis = b.dat_bis AND `_test_we_mbst2a_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_test_we_mbst2a_not_in` SET
        anz_null_tag5 = b.anz_null_tag5 FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(CASE
                WHEN
                    XX.gewart_id = 'ST' AND A.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND A.menge_lgbest_erp_frei_bme
                    BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND A.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END) AS anz_null_tag5
        FROM dbp_data.marktbestand_erp AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.tag AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 4 DAY) AND A0.dat_bis >= B.dat

            GROUP BY
                A0.werbetyp_id,
                A0.dat_von,
                A0.dat_bis,
                A0.wup_id,
                A0.mandant_id,
                A0.art_id,
                B.dat
        ) AS w
            ON
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin"
                )
        INNER JOIN dbp_data.art AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a_not_in`.mandant_id = b.mandant_id AND `_test_we_mbst2a_not_in`.wup_id = b.wup_id AND
        `_test_we_mbst2a_not_in`.art_id = b.art_id AND `_test_we_mbst2a_not_in`.dat_von = b.dat_von AND
        `_test_we_mbst2a_not_in`.dat_bis = b.dat_bis AND `_test_we_mbst2a_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_test_we_mbst2a_not_in` SET
        anz_null_tag6 = b.anz_null_tag6 FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(CASE
                WHEN
                    XX.gewart_id = 'ST' AND A.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND A.menge_lgbest_erp_frei_bme
                    BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND A.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END) AS anz_null_tag6
        FROM dbp_data.marktbestand_erp AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.tag AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 5 DAY) AND A0.dat_bis >= B.dat

            GROUP BY
                A0.werbetyp_id,
                A0.dat_von,
                A0.dat_bis,
                A0.wup_id,
                A0.mandant_id,
                A0.art_id,
                B.dat
        ) AS w
            ON
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin"
                )
        INNER JOIN dbp_data.art AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a_not_in`.mandant_id = b.mandant_id AND `_test_we_mbst2a_not_in`.wup_id = b.wup_id AND
        `_test_we_mbst2a_not_in`.art_id = b.art_id AND `_test_we_mbst2a_not_in`.dat_von = b.dat_von AND
        `_test_we_mbst2a_not_in`.dat_bis = b.dat_bis AND `_test_we_mbst2a_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_test_we_mbst2a_not_in` SET
        anz_null_tag7 = b.anz_null_tag7 FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id,
            MAX(CASE
                WHEN
                    XX.gewart_id = 'ST' AND A.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND A.menge_lgbest_erp_frei_bme
                    BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND A.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                    THEN 1
                ELSE 0
            END) AS anz_null_tag7
        FROM dbp_data.marktbestand_erp AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1` AS A0
            INNER JOIN dbp_data.tag AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 6 DAY) AND A0.dat_bis >= B.dat

            GROUP BY
                A0.werbetyp_id,
                A0.dat_von,
                A0.dat_bis,
                A0.wup_id,
                A0.mandant_id,
                A0.art_id,
                B.dat
        ) AS w
            ON
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin"
                )
        INNER JOIN dbp_data.art AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.dat,
            w.dat_von,
            w.dat_bis,
            w.werbetyp_id
    ) AS b
    WHERE
        `_test_we_mbst2a_not_in`.mandant_id = b.mandant_id AND `_test_we_mbst2a_not_in`.wup_id = b.wup_id AND
        `_test_we_mbst2a_not_in`.art_id = b.art_id AND `_test_we_mbst2a_not_in`.dat_von = b.dat_von AND
        `_test_we_mbst2a_not_in`.dat_bis = b.dat_bis AND `_test_we_mbst2a_not_in`.werbetyp_id = b.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2b_not_in AS
    SELECT
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        SUM(CASE
            WHEN
                XX.gewart_id = 'ST' AND X.menge_lgbest_erp_frei_bme = 0 OR XX.gewart_id = 'KG' AND X.menge_lgbest_erp_frei_bme
                BETWEEN 0.000 AND 0.090 OR XX.gewart_id = 'G' AND X.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000
                THEN 1
            ELSE 0
        END) AS anz_null_tag1_bis_tag3,
        SUM(CASE
            WHEN
                XX.gewart_id = 'ST' AND X.menge_lgbest_erp_frei_bme < 0 OR XX.gewart_id = 'KG' AND X.menge_lgbest_erp_frei_bme <
                0.000 OR XX.gewart_id = 'G' AND X.menge_lgbest_erp_frei_bme < 0.000
                THEN 1
            ELSE 0
        END) AS anz_minus_tag1_bis_tag3
    FROM `_ff_we4_not_in` AS V
    INNER JOIN (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von,
            A.dat_bis,
            B.dat,
            A.kjwo
        FROM `_werbeartikel_1` AS A
        INNER JOIN dbp_data.tag AS B
            ON
                B.dat BETWEEN A.dat_von AND A.dat_bis AND B.dat BETWEEN A.dat_von AND
                (DATE_ADD(A.dat_von, INTERVAL 2 DAY))
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_von,
            A.dat_bis,
            B.dat,
            A.kjwo
    ) AS w
        ON
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    INNER JOIN dbp_data.art AS XX ON V.mandant_id = XX.mandant_id AND V.art_id = XX.art_id
    LEFT JOIN dbp_data.marktbestand_erp AS X
        ON
            w.mandant_id = X.mandant_id AND w.wup_id = X.wup_id AND w.art_id
            = X.art_id AND w.dat = X.dat AND X.dat < CURRENT_DATE("Europe/Berlin")
    GROUP BY
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id;


    CREATE OR REPLACE TEMPORARY TABLE _ff_we5_not_in AS
    SELECT
        A.kjwo,
        A.werbetyp_id,
        A.dat_von,
        A.dat_bis,
        A.mandant_id,
        A.wup_id,
        A.art_id,
        SUM(A.we_menge) AS we_menge,
        SUM(A.we_menge_2) AS we_menge_ab_vorwoche,
        SUM(A.menge_aktionsstart) AS menge_aktionsstart,
        SUM(B.menge_endbestand) AS menge_endbestand
    FROM `_ff_we4_not_in` AS A
    INNER JOIN `_test_we_mbst1_not_in` AS B
        ON
            A.mandant_id = B.mandant_id AND A.kjwo = B.kjwo AND A.wup_id = B.wup_id AND
            A.art_id = B.art_id AND A.werbetyp_id = B.werbetyp_id
    GROUP BY
        A.kjwo,
        A.werbetyp_id,
        A.dat_von,
        A.dat_bis,
        A.mandant_id,
        A.wup_id,
        A.art_id;


    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew1_not_in (
        kjwo INTEGER NOT NULL,
        werbetyp_id INTEGER NOT NULL,
        dat_von DATE NOT NULL,
        dat_bis DATE NOT NULL,
        wup_id INTEGER NOT NULL,
        mandant_id INTEGER NOT NULL,
        art_id INTEGER NOT NULL,
        nb_id INTEGER NOT NULL,
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
        tage_menge_0 BIGINT NOT NULL,
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
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, nb_id, posten_id,
        umsatz_netto_mo, umsatz_netto_di, umsatz_netto_mi, umsatz_netto_do, umsatz_netto_fr, umsatz_netto_sa, umsatz_netto_so,
        umsatz_netto_wo, menge_mo, menge_di, menge_mi, menge_do, menge_fr, menge_sa, menge_so, menge_wo, tage_menge_0, we_menge,
        menge_aktionsstart, we_menge_ab_vorwoche, menge_endbestand, min_sicherh_bestand, faktor_flaki, anzahl_nullbestand,
        anzahl_tage_aktion, menge_historie_af, sollbestand, lager_prozent, mhd_zeitraum, menge_bestand_soll_max,
        menge_tag1_7bis13h, menge_nur_tag1, bezugsweg_id, we_menge_vor_aktion, anzahl_nullbestand_tag1, anzahl_nullbestand_tag2,
        anzahl_nullbestand_tag3, anzahl_nullbestand_tag4, anzahl_nullbestand_tag5, anzahl_nullbestand_tag6,
        anzahl_nullbestand_tag7, anzahl_nullbestand_tag1bis3, anzahl_minusbestand, anzahl_minusbestand_tag1,
        anzahl_minusbestand_tag1bis3
    )
    (SELECT
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
        CASE
            WHEN werbetyp_id IN (1, 2)
                THEN 6
            WHEN werbetyp_id IN (18)
                THEN 2
            ELSE 3
        END AS tage_menge_0,
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
    FROM `_not_in1`);


    UPDATE `_ff_we_artbew1_not_in` SET
        we_menge = b.we_menge,
        we_menge_ab_vorwoche = b.we_menge_ab_vorwoche,
        we_menge_vor_aktion = b.we_menge_ab_vorwoche,
        menge_aktionsstart = b.menge_aktionsstart,
        menge_endbestand = b.menge_endbestand,
        min_sicherh_bestand = b.min_sicherh_bestand,
        sollbestand = b.sollbestand,
        bezugsweg_id = b.bezugsweg_id FROM (
        SELECT
            A.kjwo,
            A.werbetyp_id,
            A.dat_von,
            A.dat_bis,
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.we_menge,
            A.we_menge_ab_vorwoche,
            A.menge_aktionsstart,
            A.menge_endbestand,
            F.min_sicherh_bestand,
            F.sollbestand,
            F.bezugsweg_id
        FROM `_ff_we5_not_in` AS A
        LEFT JOIN
            dbp_data.art_wup_status_per
                AS F
            ON
                A.mandant_id = F.mandant_id AND A.wup_id = F.wup_id AND
                A.art_id = F.art_id AND F.dat_bis = DATE '9999-12-31'
    ) AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_not_in`.art_id = b.art_id AND `_ff_we_artbew1_not_in`.kjwo = b.kjwo AND `_ff_we_artbew1_not_in`.werbetyp_id
        = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_not_in` SET
        mhd_zeitraum = b.mhd_zeitraum,
        lager_prozent = b.lager_prozent FROM (
        SELECT
            A.kjwo,
            A.werbetyp_id,
            A.dat_von,
            A.dat_bis,
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.we_menge,
            A.we_menge_ab_vorwoche,
            A.menge_aktionsstart,
            A.menge_endbestand,
            F.mhd_zeitraum,
            F.lager_prozent
        FROM `_ff_we5_not_in` AS A
        LEFT JOIN dbp_data.art AS F ON A.mandant_id = F.mandant_id AND A.art_id = F.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_not_in`.art_id = b.art_id AND `_ff_we_artbew1_not_in`.kjwo = b.kjwo AND `_ff_we_artbew1_not_in`.werbetyp_id
        = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_not_in` SET
        menge_bestand_soll_max = b.menge_bestand_soll_max FROM (
        SELECT
            A.kjwo,
            A.werbetyp_id,
            A.dat_von,
            A.dat_bis,
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.we_menge,
            A.we_menge_ab_vorwoche,
            A.menge_aktionsstart,
            A.menge_endbestand,
            F.menge_bestand_soll_max
        FROM `_ff_we5_not_in` AS A
        LEFT JOIN
            dbp_data.art_wup_nachschub_per
                AS F
            ON
                A.mandant_id = F.mandant_id AND A.wup_id = F.wup_id
                AND A.art_id = F.art_id AND F.dat_bis = DATE '9999-12-31'
    ) AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_not_in`.art_id = b.art_id AND `_ff_we_artbew1_not_in`.kjwo = b.kjwo AND `_ff_we_artbew1_not_in`.werbetyp_id
        = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_not_in` SET
        anzahl_nullbestand = b.anz_tage_null,
        anzahl_minusbestand = b.anz_tage_minus
    FROM `_test_we_mbst2_not_in` AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_not_in`.art_id = b.art_id AND `_ff_we_artbew1_not_in`.kjwo = b.kjwo AND `_ff_we_artbew1_not_in`.werbetyp_id
        = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_not_in` SET
        anzahl_nullbestand_tag1 = b.anz_null_tag1,
        anzahl_minusbestand_tag1 = b.anz_minus_tag1,
        anzahl_nullbestand_tag2 = b.anz_null_tag2,
        anzahl_nullbestand_tag3 = b.anz_null_tag3,
        anzahl_nullbestand_tag4 = b.anz_null_tag4,
        anzahl_nullbestand_tag5 = b.anz_null_tag5,
        anzahl_nullbestand_tag6 = b.anz_null_tag6,
        anzahl_nullbestand_tag7 = b.anz_null_tag7
    FROM `_test_we_mbst2a_not_in` AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_not_in`.art_id = b.art_id AND `_ff_we_artbew1_not_in`.kjwo = b.kjwo AND `_ff_we_artbew1_not_in`.werbetyp_id
        = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_not_in` SET
        anzahl_nullbestand_tag1bis3 = b.anz_null_tag1_bis_tag3,
        anzahl_minusbestand_tag1bis3 = b.anz_minus_tag1_bis_tag3
    FROM `_test_we_mbst2b_not_in` AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_not_in`.art_id = b.art_id AND `_ff_we_artbew1_not_in`.kjwo = b.kjwo AND `_ff_we_artbew1_not_in`.werbetyp_id
        = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_not_in` SET
        menge_historie_af = b.menge_historie_af FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            SUM(D.menge) / 36.000 AS menge_historie_af
        FROM `_ff_we_artbew1_not_in` AS A
        INNER JOIN dbp_data.woche AS B ON A.kjwo = B.kjwo
        INNER JOIN dbp_data.woche_kj_kl AS C ON C.akt_wo BETWEEN B.akt_wo - 6 AND (B.akt_wo - 1)
        INNER JOIN dbp_data.artbew_wo_sum AS D
            ON
                A.mandant_id = D.mandant_id AND A.wup_id = D.wup_id AND A.art_id
                = D.art_id AND C.kjwo_kl = D.kjwo_kl
        WHERE
            D.bewart_id = 1001
            AND D.menge >= 0
        GROUP BY
            A.wup_id,
            A.mandant_id,
            A.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_not_in`.art_id = b.art_id;


    UPDATE `_ff_we_artbew1_not_in` SET
        anzahl_tage_aktion = b.anz_tage_aktion FROM (
        SELECT
            mandant_id,
            werbetyp_id,
            MAX(anz_tage_aktion) AS anz_tage_aktion
        FROM `_werbetyp_tage`
        GROUP BY
            mandant_id,
            werbetyp_id
    ) AS b
    WHERE `_ff_we_artbew1_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_not_in` SET
        we_menge_ab_vorwoche = `_ff_we_artbew1_not_in`.we_menge + `_ff_we_artbew1_not_in`.we_menge_ab_vorwoche
    WHERE TRUE;


    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew2_not_in AS
    SELECT
        A.kjwo,
        A.werbetyp_id,
        A.dat_von,
        A.dat_bis,
        A.wup_id,
        A.mandant_id,
        A.art_id,
        A.nb_id,
        A.posten_id,
        A.umsatz_netto_mo,
        A.umsatz_netto_di,
        A.umsatz_netto_mi,
        A.umsatz_netto_do,
        A.umsatz_netto_fr,
        A.umsatz_netto_sa,
        A.umsatz_netto_so,
        A.umsatz_netto_wo,
        A.menge_mo,
        A.menge_di,
        A.menge_mi,
        A.menge_do,
        A.menge_fr,
        A.menge_sa,
        A.menge_so,
        A.menge_wo,
        A.menge_sa2,
        A.tage_menge_0,
        A.we_menge,
        A.menge_aktionsstart,
        A.we_menge_ab_vorwoche,
        A.menge_endbestand,
        A.min_sicherh_bestand,
        A.faktor_flaki,
        A.anzahl_nullbestand,
        A.anzahl_tage_aktion,
        A.menge_historie_af,
        A.sollbestand,
        A.lager_prozent,
        A.mhd_zeitraum,
        A.menge_bestand_soll_max,
        A.menge_tag1_7bis13h,
        A.menge_nur_tag1,
        A.bezugsweg_id,
        A.we_menge_vor_aktion,
        A.anzahl_nullbestand_tag1,
        A.anzahl_nullbestand_tag2,
        A.anzahl_nullbestand_tag3,
        A.anzahl_nullbestand_tag4,
        A.anzahl_nullbestand_tag5,
        A.anzahl_nullbestand_tag6,
        A.anzahl_nullbestand_tag7,
        A.anzahl_nullbestand_tag1bis3,
        A.anzahl_minusbestand,
        A.anzahl_minusbestand_tag1,
        A.anzahl_minusbestand_tag1bis3,
        B.wtag_id AS wtag_id_start,
        C.wtag_id AS wtag_id_ende,
        COALESCE(W.mutter_wb_id, D.mutter_wb_id) AS mutter_wb_id,
        W.avq_relevant_fg,
        W.vk_vor_aktion_brutto,
        W.vk_aktion_brutto,
        W.vk_kcard_brutto
    FROM `_ff_we_artbew1_not_in` AS A
    INNER JOIN dbp_data.tag AS B
        ON CASE
            WHEN A.werbetyp_id = 1
                THEN DATE_ADD(A.dat_von, INTERVAL 1 DAY)
            ELSE A.dat_von
        END = B.dat
    INNER JOIN dbp_data.tag AS C ON A.dat_bis = C.dat
    INNER JOIN `_werbeartikel_1` AS W ON A.mandant_id = W.mandant_id AND A.wup_id = W.wup_id AND A.art_id = W.art_id AND A.dat_von BETWEEN W.dat_von AND W.dat_bis AND A.werbetyp_id = W.werbetyp_id
    LEFT JOIN `_ff_mutter_art` AS D ON A.mandant_id = D.mandant_id AND A.art_id = D.art_id;


    DELETE FROM dbp_data.werbung_kennzahlen_woche
    WHERE (
        kjwo, werbe_typ_id, wup_id, art_id) IN (
        SELECT (kjwo, werbetyp_id, wup_id, art_id)
        FROM `_ff_we_artbew2_not_in`
    );


    INSERT INTO dbp_data.werbung_kennzahlen_woche (
        mandant_id, kjwo, wup_id, nb_id, art_id, werbe_typ_id,
        menge_tag1, menge_tag2, menge_tag3, menge_tag4, menge_tag5, menge_tag6, menge_tag7, menge_nur_tag1, tage_menge_0,
        menge_endbestand, menge_aktionsstart, umsatz_netto_tag1, umsatz_netto_tag2, umsatz_netto_tag3, umsatz_netto_tag4,
        umsatz_netto_tag5, umsatz_netto_tag6, umsatz_netto_tag7, we_menge, min_sicherh_bestand, posten_id, we_menge_zentral,
        faktor_flaki, mutter_wb_id, wtag_id_start, wtag_id_ende, menge_historie_af, anzahl_nullbestand, anzahl_tage_aktion,
        menge_tag1_7bis13h, lager_prozent, mhd_zeitraum, sollbestand, menge_bestand_soll_max, werbenachvermarktung_fg,
        we_menge_vor_aktion, art_mutter_bezugsweg_id, anzahl_nullbestand_tag1, anzahl_nullbestand_tag2, anzahl_nullbestand_tag3,
        anzahl_nullbestand_tag4, anzahl_nullbestand_tag5, anzahl_nullbestand_tag6, anzahl_nullbestand_tag7,
        anzahl_nullbestand_tag1bis3, anzahl_minusbestand, anzahl_minusbestand_tag1, anzahl_minusbestand_tag1bis3,
        avq_relevant_fg, wrg_id, menge_sa, vk_vor_aktion_brutto, vk_aktion_brutto, vk_kcard_brutto, td_update, td_insert
    )
    (SELECT
        mandant_id,
        kjwo,
        wup_id,
        nb_id,
        art_id,
        werbetyp_id AS werbe_typ_id,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_mo
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_do
            ELSE 0
        END AS NUMERIC) AS menge_tag1,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_di
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_fr
            ELSE 0
        END AS NUMERIC) AS menge_tag2,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_mi
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_sa
            ELSE 0
        END AS NUMERIC) AS menge_tag3,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_do
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_so
            ELSE 0
        END AS NUMERIC) AS menge_tag4,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_fr
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_mo
            ELSE 0
        END AS NUMERIC) AS menge_tag5,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_sa
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_di
            ELSE 0
        END AS NUMERIC) AS menge_tag6,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN menge_so
            WHEN werbetyp_id IN (2, 4, 15)
                THEN menge_mi
            ELSE 0
        END AS NUMERIC) AS menge_tag7,
        menge_nur_tag1,
        tage_menge_0,
        menge_endbestand,
        menge_aktionsstart,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_mo
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_do
            ELSE 0
        END AS NUMERIC) AS umsatz_netto_tag1,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_di
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_fr
            ELSE 0
        END AS NUMERIC) AS umsatz_netto_tag2,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_mi
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_sa
            ELSE 0
        END AS NUMERIC) AS umsatz_netto_tag3,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_do
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_so
            ELSE 0
        END AS NUMERIC) AS umsatz_netto_tag4,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_fr
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_mo
            ELSE 0
        END AS NUMERIC) AS umsatz_netto_tag5,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_sa
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_di
            ELSE 0
        END AS NUMERIC) AS umsatz_netto_tag6,
        CAST(CASE
            WHEN werbetyp_id IN (1, 3)
                THEN umsatz_netto_so
            WHEN werbetyp_id IN (2, 4, 15)
                THEN umsatz_netto_mi
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
        END AS INTEGER) AS anzahl_nullbestand,
        CAST(anzahl_tage_aktion AS INTEGER) AS anzahl_tage_aktion,
        menge_tag1_7bis13h,
        CAST(lager_prozent AS INTEGER) AS lager_prozent,
        CAST(mhd_zeitraum AS INTEGER) AS mhd_zeitraum,
        sollbestand,
        menge_bestand_soll_max,
        0 AS werbenachvermarktung_fg,
        we_menge_vor_aktion,
        CAST(bezugsweg_id AS INTEGER) AS bezugsweg_id,
        CAST(anzahl_nullbestand_tag1 AS INTEGER) AS anzahl_nullbestand_tag1,
        CAST(anzahl_nullbestand_tag2 AS INTEGER) AS anzahl_nullbestand_tag2,
        CAST(anzahl_nullbestand_tag3 AS INTEGER) AS anzahl_nullbestand_tag3,
        CAST(anzahl_nullbestand_tag4 AS INTEGER) AS anzahl_nullbestand_tag4,
        CAST(anzahl_nullbestand_tag5 AS INTEGER) AS anzahl_nullbestand_tag5,
        CAST(anzahl_nullbestand_tag6 AS INTEGER) AS anzahl_nullbestand_tag6,
        CAST(anzahl_nullbestand_tag7 AS INTEGER) AS anzahl_nullbestand_tag7,
        CAST(anzahl_nullbestand_tag1bis3 AS INTEGER) AS anzahl_nullbestand_tag1bis3,
        CAST(anzahl_minusbestand AS INTEGER) AS anzahl_minusbestand,
        CAST(anzahl_minusbestand_tag1 AS INTEGER) AS anzahl_minusbestand_tag1,
        CAST(anzahl_minusbestand_tag1bis3 AS INTEGER) AS anzahl_minusbestand_tag1bis3,
        avq_relevant_fg,
        'EUR' AS wrg_id,
        CAST(COALESCE(menge_sa, 0) AS NUMERIC) AS menge_sa,
        vk_vor_aktion_brutto,
        vk_aktion_brutto,
        vk_kcard_brutto,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM `_ff_we_artbew2_not_in`);


    CREATE OR REPLACE TEMPORARY TABLE _preis_mutter AS
    SELECT
        A.mandant_id,
        A.kjwo,
        A.wup_id,
        A.werbe_typ_id,
        A.mutter_wb_id,
        X.vk_brutto AS preis
    FROM dbp_data.werbung_kennzahlen_woche AS A
    INNER JOIN `_werbeartikel_1` AS X
        ON
            A.kjwo = X.kjwo AND A.werbe_typ_id = X.werbetyp_id AND A.mandant_id = X.mandant_id
            AND A.wup_id = X.wup_id AND A.mutter_wb_id = X.art_id
    INNER JOIN dbp_data.art_wg_zu_per AS B
        ON
            A.mandant_id = B.mandant_id AND A.mutter_wb_id = B.art_id AND
            B.dat_bis = DATE '9999-12-31' AND B.arthiertyp_id = 2
    WHERE
        A.mutter_wb_id = A.art_id
        AND B.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu
            WHERE
                wg_filter_id = 31
                AND mandant_id = 1
        )
        AND A.kjwo IN (
            SELECT kjwo
            FROM dbp_data.tag
            WHERE akt_wo = wkw
        )
        AND X.vk_brutto <> 0;


    CREATE OR REPLACE TEMPORARY TABLE _preis_kind AS
    SELECT
        A.mandant_id,
        A.kjwo,
        A.werbe_typ_id,
        A.wup_id,
        A.art_id,
        A.mutter_wb_id,
        X.vk_brutto AS preis_kind,
        B.preis AS preis_mutter,
        CAST(COALESCE(CAST(B.preis AS NUMERIC) / IF(CAST(X.vk_brutto AS NUMERIC) = 0, NULL, CAST(X.vk_brutto AS NUMERIC)), 1) AS NUMERIC)
            AS faktor
    FROM dbp_data.werbung_kennzahlen_woche AS A
    INNER JOIN `_werbeartikel_1` AS X
        ON
            A.kjwo = X.kjwo AND A.werbe_typ_id = X.werbetyp_id AND A.mandant_id = X.mandant_id
            AND A.wup_id = X.wup_id AND A.art_id = X.art_id
    INNER JOIN `_preis_mutter`
        AS B ON A.mandant_id = B.mandant_id AND A.mutter_wb_id = B.mutter_wb_id AND A.wup_id = B.wup_id
    AND A.kjwo = B.kjwo AND A.werbe_typ_id = B.werbe_typ_id;


    UPDATE dbp_data.werbung_kennzahlen_woche SET
        faktor_flaki = b.faktor FROM (
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
        werbung_kennzahlen_woche.mandant_id = b.mandant_id AND werbung_kennzahlen_woche.wup_id = b.wup_id AND
        werbung_kennzahlen_woche.kjwo = b.kjwo AND werbung_kennzahlen_woche.art_id = b.art_id AND werbung_kennzahlen_woche.mutter_wb_id = b.mutter_wb_id AND werbung_kennzahlen_woche.werbe_typ_id = b.werbe_typ_id;


    DELETE FROM dbp_data.werbung_kennzahlen_woche
    WHERE (
        mandant_id, art_id) IN (
        SELECT (mandant_id, kopf_art)
        FROM `_stpo`
    ) AND menge_tag1 + menge_tag2 + menge_tag3 + menge_tag4 + menge_tag5 + menge_tag6 + menge_tag7 = 0 AND
    kjwo IN (
        SELECT kjwo
        FROM dbp_data.tag
        WHERE akt_wo = wkw
    );


    CREATE OR REPLACE TEMPORARY TABLE _raus_xxx AS
    SELECT *
    FROM dbp_data.werbung_kennzahlen_woche AS A
    WHERE
        mandant_id = 1
        AND kjwo IN (
            SELECT kjwo
            FROM dbp_data.tag
            WHERE akt_wo = wkw
        )
        AND menge_tag1 + menge_tag2 + menge_tag3 + menge_tag4 + menge_tag5 + menge_tag6 + menge_tag7 = 0
        AND we_menge_zentral <> 0
        AND (
            mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl_process.art_gtin
            GROUP BY
                art_id,
                mandant_id
            HAVING COUNT(DISTINCT gtin_typ_id) = 1 AND MAX(gtin_typ_id) = 'IE'
        );


    DELETE FROM dbp_data.werbung_kennzahlen_woche
    WHERE (
        kjwo, mandant_id, wup_id, art_id, werbe_typ_id) IN (
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
            A.kjwo,
            A.werbe_typ_id,
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.mutter_wb_id,
            SUM(A.we_menge_zentral) AS we_menge_zentral,
            SUM(A.menge_tag1 + A.menge_tag2 + A.menge_tag3 + A.menge_tag4 + A.menge_tag5 + A.menge_tag6 + A.menge_tag7) AS menge_
            ,
            SUM(A.we_menge_zentral) AS z0
        FROM dbp_data.werbung_kennzahlen_woche AS A
        INNER JOIN dbp_data.art_wg_zu_per AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
                = 2 AND B.dat_bis = DATE '9999-12-31'
        WHERE
            B.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu
                WHERE
                    wg_filter_id = 44
                    AND mandant_id = 1
            )
            AND A.mandant_id = 1
            AND A.kjwo IN (
                SELECT kjwo
                FROM dbp_data.tag
                WHERE akt_wo = wkw
            )
        GROUP BY
            A.kjwo,
            A.werbe_typ_id,
            A.mandant_id,
            A.wup_id,
            A.art_id,
            A.mutter_wb_id
        HAVING we_menge_zentral = 0 AND menge_ <> 0
    ) AS t7;


    CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art_we_upd AS
    SELECT
        mandant_id,
        art_id,
        COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
    FROM dbp_data.art AS A
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id = 1
    GROUP BY
        mandant_id,
        art_id,
        mutter_wb_id;


    CREATE OR REPLACE TEMPORARY TABLE _singles AS
    SELECT mutter_wb_id
    FROM `_ff_mutter_art_we_upd`
    GROUP BY mutter_wb_id
    HAVING COUNT(*) = 1;


    DELETE FROM `_we_upd_candidates`
    WHERE mutter_wb_id IN (
        SELECT mutter_wb_id
        FROM `_singles`
    );


    CREATE OR REPLACE TEMPORARY TABLE _multiples AS
    SELECT
        mutter_wb_id,
        COUNT(*) AS anzahl
    FROM `_ff_mutter_art_we_upd`
    GROUP BY mutter_wb_id
    HAVING anzahl > 1;


    DELETE FROM `_we_upd_candidates`
    WHERE (
        mandant_id, kjwo, werbe_typ_id, mutter_wb_id) IN (
        SELECT (A.mandant_id, A.kjwo, A.werbe_typ_id, A.mutter_wb_id)
        FROM dbp_data.werbung_kennzahlen_woche AS A
        INNER JOIN `_multiples` AS B ON A.mutter_wb_id = B.mutter_wb_id
        WHERE
            A.mandant_id = 1
            AND A.kjwo IN (
                SELECT kjwo
                FROM dbp_data.tag
                WHERE akt_wo = wkw
            )
        GROUP BY
            A.mandant_id,
            A.kjwo,
            A.werbe_typ_id,
            A.mutter_wb_id
        HAVING SUM(A.we_menge_zentral) = 0
    );


    UPDATE dbp_data.werbung_kennzahlen_woche SET
        we_menge_zentral = 0.001
    FROM `_we_upd_candidates` AS b
    WHERE
        werbung_kennzahlen_woche.kjwo = b.kjwo AND werbung_kennzahlen_woche.werbe_typ_id = b.werbe_typ_id AND
        werbung_kennzahlen_woche.mandant_id = b.mandant_id AND werbung_kennzahlen_woche.wup_id = b.wup_id AND
        werbung_kennzahlen_woche.art_id = b.art_id AND werbung_kennzahlen_woche.we_menge_zentral = 0;


    CREATE OR REPLACE TEMPORARY TABLE _murks AS
    SELECT
        kjwo,
        wup_id,
        mandant_id,
        art_id,
        werbe_typ_id,
        MAX(posten_id) AS posten_id,
        COUNT(*) AS anz
    FROM dbp_data.werbung_kennzahlen_woche
    WHERE we_menge_zentral NOT IN (0, 0.001)
    GROUP BY
        mandant_id,
        kjwo,
        wup_id,
        art_id,
        werbe_typ_id
    HAVING anz > 1;


    CREATE OR REPLACE TEMPORARY TABLE _track01 AS
    SELECT DISTINCT
        A.mandant_id,
        A.kjwo,
        A.wup_id,
        A.nb_id,
        A.art_id,
        A.werbe_typ_id,
        A.menge_tag1,
        A.menge_tag2,
        A.menge_tag3,
        A.menge_tag4,
        A.menge_tag5,
        A.menge_tag6,
        A.menge_tag7,
        A.menge_nur_tag1,
        A.tage_menge_0,
        A.menge_endbestand,
        A.menge_aktionsstart,
        A.umsatz_netto_tag1,
        A.umsatz_netto_tag2,
        A.umsatz_netto_tag3,
        A.umsatz_netto_tag4,
        A.umsatz_netto_tag5,
        A.umsatz_netto_tag6,
        A.umsatz_netto_tag7,
        A.we_menge,
        A.min_sicherh_bestand,
        A.posten_id,
        A.we_menge_zentral,
        A.faktor_flaki,
        A.mutter_wb_id,
        A.wtag_id_start,
        A.wtag_id_ende,
        A.menge_historie_af,
        A.anzahl_nullbestand,
        A.anzahl_tage_aktion,
        A.menge_tag1_7bis13h,
        A.lager_prozent,
        A.mhd_zeitraum,
        A.sollbestand,
        A.menge_bestand_soll_max,
        A.werbenachvermarktung_fg,
        A.we_menge_vor_aktion,
        A.art_mutter_bezugsweg_id,
        A.anzahl_nullbestand_tag1,
        A.anzahl_nullbestand_tag2,
        A.anzahl_nullbestand_tag3,
        A.anzahl_nullbestand_tag4,
        A.anzahl_nullbestand_tag5,
        A.anzahl_nullbestand_tag6,
        A.anzahl_nullbestand_tag7,
        A.anzahl_nullbestand_tag1bis3,
        A.anzahl_minusbestand,
        A.anzahl_minusbestand_tag1,
        A.anzahl_minusbestand_tag1bis3,
        A.avq_relevant_fg,
        A.wrg_id,
        A.menge_sa,
        A.vk_vor_aktion_brutto,
        A.vk_aktion_brutto,
        A.vk_kcard_brutto,
        A.td_update,
        A.td_insert
    FROM dbp_data.werbung_kennzahlen_woche AS A
    INNER JOIN `_murks`
        AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.werbe_typ_id = B.werbe_typ_id AND
    A.kjwo = B.kjwo AND A.posten_id = B.posten_id AND A.art_id = B.art_id;


    DELETE FROM dbp_data.werbung_kennzahlen_woche
    WHERE (
        kjwo, wup_id, mandant_id, art_id, werbe_typ_id) IN (
        SELECT (kjwo, wup_id, mandant_id, art_id, werbe_typ_id)
        FROM `_track01`
    );


    INSERT INTO dbp_data.werbung_kennzahlen_woche
    (
        SELECT *
        FROM `_track01`
    );


    DELETE FROM dbp_data.werbung_kennzahlen_woche
    WHERE (
        mandant_id, art_id) IN (
        SELECT (mandant_id, art_id)
        FROM dbp_etl_process.avq_obsolete_artikel
    );


    DELETE FROM dbp_data.avq_aktualisierung
    WHERE (
        mandant_id, kjwo) IN (
        SELECT (mandant_id, kjwo)
        FROM `_werbeartikel_1`
    );


    INSERT INTO dbp_data.avq_aktualisierung (mandant_id, kjwo, dat_letzte_aktualisierung)
    (
        SELECT
            mandant_id,
            kjwo,
            CAST(CURRENT_TIMESTAMP() AS DATETIME)
        FROM `_werbeartikel_1`
        GROUP BY
            mandant_id,
            kjwo,
            3
    );

END;
