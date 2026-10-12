BEGIN
    DECLARE wkw INT64 ;
    SET wkw = ${WKW};

    CREATE OR REPLACE TEMPORARY TABLE _werbeartikel_1_kmo (
        kjwo INT64,
        werbetyp_id INT64,
        dat_von DATE,
        dat_bis DATE,
        wup_id INT64,
        mandant_id INT64,
        art_id INT64,
        akt_wo INT64,
        vk_brutto NUMERIC(29, 2),
        stkl_kopf_fg INT64,
        komponente INT64,
        mutter_wb_id INT64,
        avq_relevant_fg INT64,
        grund_sperrung STRING(1)
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            CASE WHEN c.werbetyp_id = 8 AND x1.wtag_id = 7 THEN x2.kjwo ELSE x1.kjwo END AS kjwo,
            c.werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN (
            SELECT
                mandant_id,
                dat_von,
                dat_bis,
                werbe_typ_id AS werbetyp_id
            FROM dbp_data.ts_avq_werbezeitraum_abw_1
            WHERE
                mandant_id > 1
        ) AS c
            ON
                akt.mandant_id = c.mandant_id
                AND akt.dat_von = c.dat_von
                AND akt.dat_bis = c.dat_bis
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat
        INNER JOIN dbp_data.tag_1 AS x2
            ON akt.dat_bis = x2.dat
        WHERE
            (
                akt.mandant_id IN (2, 5, 6)
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (3)
                AND x1.akt_wo = (
                    wkw
                )
                AND NOT SUBSTR(akt.aktion_id, 9, 2) IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK')
                OR akt.mandant_id IN (7, 4)
                AND SUBSTR(akt.aktion_id, 9, 2) IN ('MM_1', 'HG', 'NF', 'HA', 'HB', 'LD', 'TV', 'VD')
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (7, 4)
                AND x1.akt_wo = (
                    wkw
                )
                AND NOT ROUND(SAFE_CAST(akt.aktion_id AS BIGNUMERIC), 0) IS NULL
                OR akt.mandant_id IN (8)
                AND INSTR(akt.aktion_id, 'D1') = 0
                AND INSTR(akt.aktion_id, 'D2') = 0
                AND INSTR(akt.aktion_id, 'DS') = 0
                AND (
                    RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
                )
                AND x1.akt_wo = (
                    wkw
                )
            )
            AND NOT (x2.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, c.werbetyp_id) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            kjwo,
            c.werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            a.kjwo,
            a.werbe_typ_id,
            CASE
                WHEN a.werbe_typ_id = 5 AND b.wtag_id = 1
                    THEN DATE_ADD(b.dat, INTERVAL '3' DAY)
                WHEN a.werbe_typ_id = 6 AND b.wtag_id = 1
                    THEN DATE_ADD(b.dat, INTERVAL '2' DAY)
                WHEN a.werbe_typ_id = 7 AND b.wtag_id = 1
                    THEN b.dat
                ELSE NULL
            END AS dat_von_,
            CASE
                WHEN a.werbe_typ_id = 5 AND b.wtag_id = 1
                    THEN DATE_ADD(b.dat, INTERVAL '9' DAY)
                WHEN a.werbe_typ_id = 6 AND b.wtag_id = 1
                    THEN DATE_ADD(b.dat, INTERVAL '8' DAY)
                WHEN a.werbe_typ_id = 7 AND b.wtag_id = 1
                    THEN DATE_ADD(b.dat, INTERVAL '6' DAY)
                ELSE NULL
            END AS dat_bis_,
            a.wup_id,
            a.mandant_id,
            a.art_id,
            b.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            a.mutter_wb_id,
            a.avq_relevant_fg,
            ' ' AS grund_sperrung
        FROM dbp_process.werbung_kennzahlen_kopf_1 AS a
        INNER JOIN dbp_data.tag_1 AS b
            ON a.kjwo = b.kjwo
        WHERE
            b.akt_wo = (
                wkw
            )
            AND a.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
            AND NOT (a.kjwo, a.wup_id, a.mandant_id, a.art_id) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id)
                FROM `_werbeartikel_1_kmo`
            )
            AND NOT CASE
                WHEN a.werbe_typ_id = 5 AND b.wtag_id = 1
                    THEN DATE_ADD(b.dat, INTERVAL '3' DAY)
                WHEN a.werbe_typ_id = 6 AND b.wtag_id = 1
                    THEN DATE_ADD(b.dat, INTERVAL '2' DAY)
                WHEN a.werbe_typ_id = 7 AND b.wtag_id = 1
                    THEN b.dat
                ELSE NULL
            END IS NULL
            AND NOT CASE
                WHEN a.werbe_typ_id = 5 AND b.wtag_id = 1
                    THEN DATE_ADD(b.dat, INTERVAL '9' DAY)
                WHEN a.werbe_typ_id = 6 AND b.wtag_id = 1
                    THEN DATE_ADD(b.dat, INTERVAL '8' DAY)
                WHEN a.werbe_typ_id = 7 AND b.wtag_id = 1
                    THEN DATE_ADD(b.dat, INTERVAL '6' DAY)
                ELSE NULL
            END IS NULL
        GROUP BY
            a.kjwo,
            a.werbe_typ_id,
            dat_von_,
            dat_bis_,
            a.wup_id,
            a.mandant_id,
            a.art_id,
            b.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            a.mutter_wb_id,
            a.avq_relevant_fg,
            grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            CASE
                WHEN
                    akt.mandant_id = 2
                    AND akt.dat_bis >= CAST('2019-02-27' AS DATE)
                    OR akt.mandant_id IN (4, 7)
                    THEN 6
                WHEN akt.mandant_id = 8
                    THEN 7
                ELSE 5
            END AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON
                akt.dat_von = x1.dat
                AND x1.wtag_id = CASE
                    WHEN
                        akt.mandant_id = 2
                        AND akt.dat_bis >= CAST('2019-02-27' AS DATE)
                        OR akt.mandant_id IN (4, 7)
                        THEN 3
                    WHEN akt.mandant_id = 8
                        THEN 1
                    ELSE 4
                END
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = CASE
                    WHEN
                        akt.mandant_id = 2
                        AND akt.dat_bis >= CAST('2019-02-27' AS DATE)
                        OR akt.mandant_id IN (4, 7)
                        THEN 2
                    WHEN akt.mandant_id = 8
                        THEN 7
                    ELSE 3
                END
                AND DATE_SUB(x2.dat, INTERVAL '6' DAY) = x1.dat
        WHERE
            (
                akt.mandant_id IN (2, 5, 6)
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (3)
                AND x1.akt_wo = (
                    wkw
                )
                AND NOT SUBSTR(akt.aktion_id, 9, 2) IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK')
                OR akt.mandant_id IN (4, 7)
                AND CASE
                    WHEN akt.mandant_id = 4
                        THEN 1
                    WHEN akt.mandant_id = 7 AND akta.wrg_id = ''
                        THEN 0
                    ELSE 1
                END = 1
                AND CASE
                    WHEN
                        akt.mandant_id IN (4, 7)
                        AND NOT ROUND(SAFE_CAST(akt.aktion_id AS BIGNUMERIC), 0) IS NULL
                        THEN 1
                    WHEN SUBSTR(akt.aktion_id, 9, 2) IN ('MM_1', 'HG', 'NF', 'HA', 'HB', 'LD')
                        THEN 1
                    ELSE 0
                END = 1
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (8)
                AND INSTR(akt.aktion_id, 'D1') = 0
                AND INSTR(akt.aktion_id, 'D2') = 0
                AND INSTR(akt.aktion_id, 'DS') = 0
                AND (
                    RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
                )
                AND x1.akt_wo = (
                    wkw
                )
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            8 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 1
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 3
                AND DATE_SUB(x2.dat, INTERVAL '2' DAY) = x1.dat
        WHERE
            (
                akt.mandant_id IN (2, 4, 5, 6, 7)
                AND CASE
                    WHEN akt.mandant_id = 4
                        THEN 1
                    WHEN akt.mandant_id IN (2, 5, 6, 7) AND akta.wrg_id = ''
                        THEN 0
                    ELSE 1
                END = 1
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (3)
                AND x1.akt_wo = (
                    wkw
                )
                AND NOT SUBSTR(akt.aktion_id, 9, 2) IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK')
                OR akt.mandant_id IN (8)
                AND INSTR(akt.aktion_id, 'DS') = 0
                AND (
                    RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
                )
                AND x1.akt_wo = (
                    wkw
                )
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 8) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            9 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 6
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 7
                AND DATE_SUB(x2.dat, INTERVAL '1' DAY) = x1.dat
        WHERE
            (
                akt.mandant_id IN (2, 6)
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (7, 4)
                AND CASE
                    WHEN akt.mandant_id = 4
                        THEN 1
                    WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                        THEN 0
                    ELSE 1
                END = 1
                AND SUBSTR(akt.aktion_id, 9, 2) IN ('MM_1', 'HG', 'NF', 'HA', 'HB', 'LD', 'TV', 'VD')
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (7, 4)
                AND CASE
                    WHEN akt.mandant_id = 4
                        THEN 1
                    WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                        THEN 0
                    ELSE 1
                END = 1
                AND x1.akt_wo = (
                    wkw
                )
                AND NOT ROUND(SAFE_CAST(akt.aktion_id AS BIGNUMERIC), 0) IS NULL
                OR akt.mandant_id IN (3)
                AND x1.akt_wo = (
                    wkw
                )
                AND NOT SUBSTR(akt.aktion_id, 9, 2) IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK')
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 9) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung,
            stkl_kopf_fg
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            10 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 5
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 1
                AND DATE_SUB(x2.dat, INTERVAL '3' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (4, 7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (2, 5, 6, 7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 10) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            4 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 4
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 7
                AND DATE_SUB(x2.dat, INTERVAL '3' DAY) = x1.dat
        WHERE
            (
                akt.mandant_id IN (2, 3, 4, 6)
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (8)
                AND INSTR(akt.aktion_id, 'DS') = 0
                AND (
                    RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
                )
                AND x1.akt_wo = (
                    wkw
                )
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 4) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            6 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 3
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 2
                AND DATE_SUB(x2.dat, INTERVAL '6' DAY) = x1.dat
        WHERE
            (
                akt.mandant_id IN (6)
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (8)
                AND INSTR(akt.aktion_id, 'DS') = 0
                AND (
                    RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
                )
                AND x1.akt_wo = (
                    wkw
                )
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 6) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            7 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 1
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 7
                AND DATE_SUB(x2.dat, INTERVAL '6' DAY) = x1.dat
        WHERE
            (
                akt.mandant_id IN (2, 5, 6)
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (3)
                AND x1.akt_wo = (
                    wkw
                )
                AND NOT SUBSTR(akt.aktion_id, 9, 2) IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK')
                OR akt.mandant_id IN (4, 7)
                AND CASE
                    WHEN akt.mandant_id = 4
                        THEN 1
                    WHEN akt.mandant_id IN (2, 5, 6, 7) AND akta.wrg_id = ''
                        THEN 0
                    ELSE 1
                END = 1
                AND CASE
                    WHEN NOT ROUND(SAFE_CAST(akt.aktion_id AS BIGNUMERIC), 0) IS NULL
                        THEN 1
                    WHEN SUBSTR(akt.aktion_id, 9, 2) IN ('MM_1', 'HG', 'NF', 'HA', 'HB', 'LD')
                        THEN 1
                    ELSE 0
                END = 1
                AND x1.akt_wo = (
                    wkw
                )
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 7) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            5 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 4
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 3
                AND DATE_SUB(x2.dat, INTERVAL '6' DAY) = x1.dat
        WHERE
            (
                akt.mandant_id IN (4)
                OR akt.mandant_id IN (8)
                AND INSTR(akt.aktion_id, 'D1') = 0
                AND INSTR(akt.aktion_id, 'D2') = 0
                AND INSTR(akt.aktion_id, 'DS') = 0
                AND (
                    RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
                )
            )
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 5) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            12 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 1
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 2
                AND DATE_SUB(x2.dat, INTERVAL '1' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (2, 4, 6, 7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (2, 5, 6, 7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND CASE
                WHEN akt.mandant_id IN (2, 6)
                    THEN 1
                WHEN NOT ROUND(SAFE_CAST(akt.aktion_id AS BIGNUMERIC), 0) IS NULL
                    THEN 1
                WHEN SUBSTR(akt.aktion_id, 9, 2) IN ('LM')
                    THEN 1
                ELSE 0
            END = 1
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 12) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            13 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 5
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 7
                AND DATE_SUB(x2.dat, INTERVAL '2' DAY) = x1.dat
        WHERE
            (
                akt.mandant_id IN (4, 7)
                AND CASE
                    WHEN akt.mandant_id = 4
                        THEN 1
                    WHEN akt.mandant_id IN (2, 5, 6, 7) AND akta.wrg_id = ''
                        THEN 0
                    ELSE 1
                END = 1
                AND CASE
                    WHEN NOT ROUND(SAFE_CAST(akt.aktion_id AS BIGNUMERIC), 0) IS NULL
                        THEN 1
                    WHEN akt.mandant_id = 7 AND SUBSTR(akt.aktion_id, 9, 2) IN ('VD', 'TV')
                        THEN 1
                    WHEN akt.mandant_id = 4 AND SUBSTR(akt.aktion_id, 9, 2) IN ('VD', 'TV')
                        THEN 1
                    ELSE 0
                END = 1
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (2, 6)
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (8)
                AND INSTR(akt.aktion_id, 'D1') = 0
                AND INSTR(akt.aktion_id, 'D2') = 0
                AND INSTR(akt.aktion_id, 'DS') = 0
                AND (
                    RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
                )
                AND x1.akt_wo = (
                    wkw
                )
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 13) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            11 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 3
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 6
                AND DATE_SUB(x2.dat, INTERVAL '3' DAY) = x1.dat
        WHERE
            (
                akt.mandant_id IN (8)
                AND INSTR(akt.aktion_id, 'D1') = 0
                AND INSTR(akt.aktion_id, 'D2') = 0
                AND INSTR(akt.aktion_id, 'DS') = 0
                AND (
                    RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
                )
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (2)
                AND x1.akt_wo = (
                    wkw
                )
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 11) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            14 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 7
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 7
                AND DATE_SUB(x2.dat, INTERVAL '0' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (5)
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 14) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            16 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 6
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 6
                AND DATE_SUB(x2.dat, INTERVAL '0' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (3)
            AND x1.akt_wo = (
                wkw
            )
            AND NOT SUBSTR(akt.aktion_id, 9, 2) IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK')
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 16) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            16 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 6
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 6
                AND DATE_SUB(x2.dat, INTERVAL '0' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (8)
            AND INSTR(akt.aktion_id, 'D1') = 0
            AND INSTR(akt.aktion_id, 'D2') = 0
            AND INSTR(akt.aktion_id, 'DS') = 0
            AND (
                RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
            )
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 16) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            15 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 1
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 7
                AND DATE_SUB(x2.dat, INTERVAL '13' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (8)
            AND INSTR(akt.aktion_id, 'D1') = 0
            AND INSTR(akt.aktion_id, 'D2') = 0
            AND INSTR(akt.aktion_id, 'DS') = 0
            AND (
                RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
            )
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 15) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    /* 21.09.2022, -dbay- */ /* new promotion type for bulgaria */
    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            18 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 5
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 6
                AND DATE_SUB(x2.dat, INTERVAL '1' DAY) = x1.dat
        WHERE
            (
                akt.mandant_id IN (8)
                AND INSTR(akt.aktion_id, 'D1') = 0
                AND INSTR(akt.aktion_id, 'D2') = 0
                AND INSTR(akt.aktion_id, 'DS') = 0
                AND (
                    RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
                )
                AND x1.akt_wo = (
                    wkw
                )
                OR akt.mandant_id IN (2, 6)
                AND x1.akt_wo = (
                    wkw
                )
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 18) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            17 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 2
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 7
                AND DATE_SUB(x2.dat, INTERVAL '5' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (8)
            AND INSTR(akt.aktion_id, 'D1') = 0
            AND INSTR(akt.aktion_id, 'D2') = 0
            AND INSTR(akt.aktion_id, 'DS') = 0
            AND (
                RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
            )
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 17) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            19 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 7 AND x1.akt_wo = (
                wkw
            ) - 1
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 3
                AND DATE_SUB(x2.dat, INTERVAL '3' DAY) = x1.dat
                AND x2.akt_wo = (
                    wkw
                )
        WHERE
            akt.mandant_id IN (5)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (2, 5, 6, 7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND x2.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 19) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            20 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 3
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 5
                AND DATE_SUB(x2.dat, INTERVAL '2' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (4, 7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 20) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            21 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 4
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 6
                AND DATE_SUB(x2.dat, INTERVAL '2' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (3)
            AND x1.akt_wo = (
                wkw
            )
            AND NOT SUBSTR(akt.aktion_id, 9, 2) IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK')
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 21) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            22 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 4
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 4
                AND DATE_SUB(x2.dat, INTERVAL '0' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (4)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 22) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    /* 04.04.2025, neuer Werbetyp fuer HR (Mo. bis Sa.) */
    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            1 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 1
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 6
                AND DATE_SUB(x2.dat, INTERVAL '5' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (6)
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 1) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    /* TV-Werbung RO (Mi. bis So.) */
    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            23 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 3
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 7
                AND DATE_SUB(x2.dat, INTERVAL '4' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 23) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    /* TV-Werbung RO (Mi. bis Do.) */
    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            24 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 3
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 4
                AND DATE_SUB(x2.dat, INTERVAL '1' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 24) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    /* TV-Werbung RO (Fr. bis Di.) */
    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            29 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 5
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 2
                AND DATE_SUB(x2.dat, INTERVAL '4' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 29) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    /* TV-Werbung RO (Sa. bis Di.) */
    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        vk_brutto,
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung
    )
    (
        SELECT
            x1.kjwo,
            30 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (
            SELECT
                aktion_id,
                mandant_id,
                bewart_id,
                aktionsart_id,
                werbe_kat_id,
                dat_von,
                dat_bis,
                preisaktiviert_fg,
                kjwo_von,
                aktion_typ_id,
                td_update,
                td_insert,
                CASE WHEN NOT aktion_typ_id IS NULL THEN 0 ELSE 1 END AS avq_relevant_fg
            FROM dbp_data.aktion_1 AS a
            WHERE
                mandant_id > 1
        ) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_1
            WHERE
                mandant_id > 1 AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id
        INNER JOIN dbp_data.tag_1 AS x1
            ON akt.dat_von = x1.dat AND x1.wtag_id = 6
        INNER JOIN dbp_data.tag_1 AS x2
            ON
                akt.dat_bis = x2.dat
                AND x2.wtag_id = 2
                AND DATE_SUB(x2.dat, INTERVAL '3' DAY) = x1.dat
        WHERE
            akt.mandant_id IN (7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND x1.akt_wo = (
                wkw
            )
            AND NOT (x1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 30) IN (
                SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
                FROM `_werbeartikel_1_kmo`
            )
        GROUP BY
            x1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            x1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );

    CREATE OR REPLACE TEMPORARY TABLE _pp AS
    SELECT *
    FROM `_werbeartikel_1_kmo`;

    TRUNCATE TABLE `_werbeartikel_1_kmo`;

    INSERT INTO `_werbeartikel_1_kmo`
    (
        SELECT
            kjwo,
            werbetyp_id,
            MIN(dat_von) AS dat_von,
            MAX(dat_bis) AS dat_bis,
            wup_id,
            mandant_id,
            art_id,
            akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            MAX(mutter_wb_id) AS mutter_wb_id,
            MAX(avq_relevant_fg) AS avq_relevant_fg,
            MIN(grund_sperrung) AS grund_sperrung
        FROM `_pp`
        GROUP BY
            kjwo,
            werbetyp_id,
            wup_id,
            mandant_id,
            art_id,
            akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente
    );

    CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art_kmo AS
    SELECT
        mandant_id,
        art_id,
        COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
    FROM dbp_data.art_1 AS a
    WHERE
        dat_bis = CAST('9999-12-31' AS DATE)
        AND (mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM `_werbeartikel_1_kmo`
            GROUP BY
                mandant_id,
            art_id
        )
    GROUP BY
        mandant_id,
        art_id,
        a.mutter_wb_id;

    UPDATE `_werbeartikel_1_kmo` SET mutter_wb_id = b.mutter_wb_id
    FROM `_ff_mutter_art_kmo` AS b
    WHERE
        `_werbeartikel_1_kmo`.mandant_id = b.mandant_id
        AND `_werbeartikel_1_kmo`.art_id = b.art_id
        AND `_werbeartikel_1_kmo`.mutter_wb_id = -999;

    UPDATE `_werbeartikel_1_kmo` SET mutter_wb_id = `_werbeartikel_1_kmo`.art_id
    WHERE
        mutter_wb_id = -999;

    DELETE FROM `_werbeartikel_1_kmo`
    WHERE
        (mandant_id, wup_id, art_id) IN (
            SELECT (b.mandant_id, b.wup_id, b.art_id)
            FROM `_werbeartikel_1_kmo` AS a
            INNER JOIN dbp_data.artbew_stueckliste_zu_1 AS b
                ON
                    a.mandant_id = b.mandant_id
                    AND a.art_id = b.komponente_art_id
                    AND a.wup_id = b.wup_id
                    AND b.dat BETWEEN a.dat_von AND a.dat_bis
        );

    CREATE OR REPLACE TEMPORARY TABLE _matchings AS
    SELECT
        kjwo,
        MIN(dat_von) AS dat_von,
        MAX(dat_bis) AS dat_bis,
        mandant_id,
        akt_wo,
        werbetyp_id
    FROM `_werbeartikel_1_kmo`
    GROUP BY
        kjwo,
        mandant_id,
        akt_wo,
        werbetyp_id;

   
    INSERT INTO _werbeartikel_1_kmo (
        kjwo,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        akt_wo,
        werbetyp_id,
        stkl_kopf_fg,
        komponente,
        vk_brutto,
        avq_relevant_fg,
        grund_sperrung
    )
    SELECT
        c.kjwo,
        MIN(c.dat_von) AS dat_von,
        MAX(a.dat_bis) AS dat_bis,
        b.wup_id,
        c.mandant_id,
        b.art_id,
        c.akt_wo,
        c.werbetyp_id,
        1 AS stkl_kopf_fg,
        b.komponente_art_id,
        0 AS vk_brutto,
        a.avq_relevant_fg,
        a.grund_sperrung
    FROM _werbeartikel_1_kmo AS a
    INNER JOIN dbp_data.artbew_stueckliste_zu_1 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.art_id = b.komponente_art_id
            AND a.wup_id = b.wup_id
            AND b.dat BETWEEN a.dat_von AND a.dat_bis
    INNER JOIN (
        SELECT *
        FROM dbp_data.art_wg_zu_per_1 AS art_wg_zu_per_inner
        WHERE
            NOT wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 46 AND mandant_id > 1
            )
    ) AS b1
        ON
            a.mandant_id = b1.mandant_id
            AND b.art_id = b1.art_id
            AND b1.arthiertyp_id = 2
            AND b1.dat_bis = '9999-12-31'
            AND CASE
                WHEN
                    a.mandant_id IN (4, 7)
                    AND (
                        b1.wg_id = 30
                        OR b1.wg_id = 161
                        OR b1.wg_id = 162
                        OR b1.wg_id = 163
                        OR b1.wg_id = 164
                        OR b1.wg_id = 165
                        OR b1.wg_id = 166
                    )
                    THEN 0
                ELSE 1
            END = 1
    INNER JOIN _matchings AS c
        ON a.mandant_id = c.mandant_id AND a.werbetyp_id = c.werbetyp_id
    GROUP BY
        1,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13;

       
    CREATE OR REPLACE TEMPORARY TABLE _double_check AS
    SELECT
        c.kjwo,
        c.dat_von,
        a.dat_bis,
        b.wup_id,
        c.mandant_id,
        b.art_id,
        c.akt_wo,
        c.werbetyp_id,
        1 AS stkl_kopf_fg,
        b.komponente_art_id,
        0 AS vk_brutto,
        a.avq_relevant_fg,
        a.grund_sperrung
    FROM _werbeartikel_1_kmo AS a
    INNER JOIN dbp_data.artbew_stueckliste_zu_1 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.art_id = b.art_id
            AND a.wup_id = b.wup_id
            AND b.dat BETWEEN a.dat_von AND a.dat_bis
    INNER JOIN (
        SELECT *
        FROM dbp_data.art_wg_zu_per_1 AS art_wg_zu_per_inner
        WHERE
            NOT wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 46 AND mandant_id > 1
            )
    ) AS b1
        ON
            a.mandant_id = b1.mandant_id
            AND b.art_id = b1.art_id
            AND b1.arthiertyp_id = 2
            AND b1.dat_bis = '9999-12-31'
            AND CASE
                WHEN
                    a.mandant_id IN (4, 7)
                    AND (
                        b1.wg_id = 30
                        OR b1.wg_id = 161
                        OR b1.wg_id = 162
                        OR b1.wg_id = 163
                        OR b1.wg_id = 164
                        OR b1.wg_id = 165
                        OR b1.wg_id = 166
                    )
                    THEN 0
                ELSE 1
            END = 1
    INNER JOIN _matchings AS c
        ON a.mandant_id = c.mandant_id AND a.werbetyp_id = c.werbetyp_id
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
        13;

    MERGE INTO _werbeartikel_1_kmo AS a
    USING (
        SELECT *
        FROM _double_check
        WHERE
            (kjwo, mandant_id, dat_von, dat_bis, wup_id, art_id, werbetyp_id) IN (
                SELECT AS STRUCT
                    kjwo,
                    mandant_id,
                    dat_von,
                    dat_bis,
                    wup_id,
                    art_id,
                    werbetyp_id
                FROM _double_check AS _double_check_0
                GROUP BY
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7
                HAVING
                    COUNT(*) = 1
            )
    ) AS b
        ON
            a.kjwo = b.kjwo
            AND a.mandant_id = b.mandant_id
            AND a.dat_von = b.dat_von
            AND a.dat_bis = b.dat_bis
            AND a.wup_id = b.wup_id
            AND a.art_id = b.art_id
            AND a.werbetyp_id = b.werbetyp_id
    WHEN MATCHED THEN
        UPDATE SET
            komponente = b.komponente_art_id,
            stkl_kopf_fg = 1
    WHEN NOT MATCHED THEN
        INSERT (
            kjwo,
            werbetyp_id,
            dat_von,
            dat_bis,
            wup_id,
            mandant_id,
            art_id,
            akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            avq_relevant_fg,
            grund_sperrung
        ) VALUES (
            b.kjwo,
            b.werbetyp_id,
            b.dat_von,
            b.dat_bis,
            b.wup_id,
            b.mandant_id,
            b.art_id,
            b.akt_wo,
            b.vk_brutto,
            b.stkl_kopf_fg,
            b.komponente_art_id,
            NULL,
            b.avq_relevant_fg,
            b.grund_sperrung
        ) ;
    MERGE INTO _werbeartikel_1_kmo AS a
    USING (
        SELECT *
        FROM _double_check
        WHERE
            (kjwo, mandant_id, dat_von, dat_bis, wup_id, art_id, werbetyp_id) IN (
                SELECT AS STRUCT
                    kjwo,
                    mandant_id,
                    dat_von,
                    dat_bis,
                    wup_id,
                    komponente_art_id,
                    werbetyp_id
                FROM _double_check AS _double_check_0
                GROUP BY
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7
                HAVING
                    COUNT(*) = 1
            )
    ) AS b
        ON
            a.kjwo = b.kjwo
            AND a.mandant_id = b.mandant_id
            AND a.dat_von = b.dat_von
            AND a.dat_bis = b.dat_bis
            AND a.wup_id = b.wup_id
            AND a.art_id = b.komponente_art_id
            AND a.werbetyp_id = b.werbetyp_id
    WHEN MATCHED THEN
        UPDATE SET
            stkl_kopf_fg = 3
    WHEN NOT MATCHED THEN
        INSERT (
            kjwo,
            werbetyp_id,
            dat_von,
            dat_bis,
            wup_id,
            mandant_id,
            art_id,
            akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            avq_relevant_fg,
            grund_sperrung
        ) VALUES (
            b.kjwo,
            b.werbetyp_id,
            b.dat_von,
            b.dat_bis,
            b.wup_id,
            b.mandant_id,
            b.komponente_art_id,
            b.akt_wo,
            b.vk_brutto,
            0,
            0,
            -999,
            b.avq_relevant_fg,
            b.grund_sperrung
        ) ;

    UPDATE `_werbeartikel_1_kmo` SET mutter_wb_id = b.mutter_wb_id
    FROM `_ff_mutter_art_kmo` AS b
    WHERE
        `_werbeartikel_1_kmo`.mandant_id = b.mandant_id
        AND `_werbeartikel_1_kmo`.art_id = b.art_id
        AND `_werbeartikel_1_kmo`.mutter_wb_id = -999;

    UPDATE `_werbeartikel_1_kmo` SET mutter_wb_id = `_werbeartikel_1_kmo`.art_id
    WHERE
        mutter_wb_id = -999;

    CREATE OR REPLACE TEMPORARY TABLE _kompo_tracking AS
    SELECT
        komponente,
        COUNT(DISTINCT art_id) AS anzahl
    FROM `_werbeartikel_1_kmo`
    WHERE
        stkl_kopf_fg = 1
    GROUP BY
        komponente
    HAVING
        anzahl > 1;

    UPDATE `_werbeartikel_1_kmo` SET stkl_kopf_fg = 2
    FROM `_kompo_tracking` AS b
    WHERE
        `_werbeartikel_1_kmo`.komponente = b.komponente;

    CREATE OR REPLACE TEMPORARY TABLE _pp AS
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
        stkl_kopf_fg,
        komponente,
        mutter_wb_id,
        avq_relevant_fg,
        grund_sperrung,
        0 AS vk_vor_aktion_brutto,
        0 AS vk_aktion_brutto,
        0 AS vk_kcard_brutto
    FROM `_werbeartikel_1_kmo` AS a;

    CREATE OR REPLACE TEMPORARY TABLE _werbeartikel_1_kmo AS
    SELECT *
    FROM `_pp`;

    UPDATE `_werbeartikel_1_kmo` SET vk_brutto = b.vk_brutto
    FROM (
        SELECT
            a.art_id,
            a.mandant_id,
            a.wup_id,
            b.werbetyp_id,
            MAX(a.vk_brutto) AS vk_brutto
        FROM dbp_data.art_wup_vk_per_1 AS a
        INNER JOIN `_werbeartikel_1_kmo` AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.art_id = b.art_id
                AND a.wup_id = b.wup_id
                AND b.dat_von BETWEEN a.dat_von AND a.dat_bis
        GROUP BY
            a.art_id,
            a.mandant_id,
            a.wup_id,
            b.werbetyp_id
    ) AS b
    WHERE
        `_werbeartikel_1_kmo`.mandant_id = b.mandant_id
        AND `_werbeartikel_1_kmo`.wup_id = b.wup_id
        AND `_werbeartikel_1_kmo`.art_id = b.art_id
        AND `_werbeartikel_1_kmo`.werbetyp_id = b.werbetyp_id;

    UPDATE `_werbeartikel_1_kmo` SET vk_vor_aktion_brutto = CAST(b.vk_vor_aktion_brutto AS INT64), vk_aktion_brutto = CAST(b.vk_aktion_brutto AS INT64)
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
        FROM dbp_data.aktion_1 AS c
        INNER JOIN dbp_data.aktion_art_wup_zu_1 AS a
            ON c.mandant_id = a.mandant_id AND c.aktion_id = a.aktion_id
        INNER JOIN `_werbeartikel_1_kmo` AS b
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
        `_werbeartikel_1_kmo`.mandant_id = b.mandant_id
        AND `_werbeartikel_1_kmo`.wup_id = b.wup_id
        AND `_werbeartikel_1_kmo`.art_id = b.art_id
        AND `_werbeartikel_1_kmo`.werbetyp_id = b.werbetyp_id;

    UPDATE `_werbeartikel_1_kmo` AS `_werbeartikel_1_kmo0` SET avq_relevant_fg = 9
    FROM (
        SELECT
            b.mandant_id,
            b.wup_id,
            b.art_id,
            a.dat_von,
            a.dat_bis,
            MIN(b.vk_aktion_brutto) AS min_vk_aktion_brutto,
            MAX(b.vk_aktion_brutto) AS max_vk_aktion_brutto,
            MIN(a.aktion_id) AS min_aktion_id,
            MAX(a.aktion_id) AS max_aktion_id,
            COUNT(DISTINCT a.aktion_id) AS anz_aktion_id,
            MIN(COALESCE(x.flag, 0)) AS min_flag,
            MAX(COALESCE(x.flag, 0)) AS max_flag
        FROM dbp_data.aktion_1 AS a
        INNER JOIN dbp_data.aktion_art_wup_zu_1 AS b
            ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
        LEFT JOIN (
            SELECT
                mandant_id,
                aktion_id,
                1 AS flag
            FROM dbp_data.l_bonuskauf_1
            GROUP BY
                mandant_id,
                aktion_id,
                flag
        ) AS x
            ON a.aktion_id = x.aktion_id AND a.mandant_id = x.mandant_id
        INNER JOIN (
            SELECT
                mandant_id,
                dat_von,
                dat_bis
            FROM `_werbeartikel_1_kmo`
            GROUP BY
                dat_von,
                dat_bis,
                mandant_id
        ) AS c
            ON a.mandant_id = c.mandant_id AND a.dat_von = c.dat_von AND a.dat_bis = c.dat_bis
        WHERE
            COALESCE(b.geloescht_sap_fg, 0) <> 1
        GROUP BY
            b.mandant_id,
            b.wup_id,
            b.art_id,
            a.dat_von,
            a.dat_bis
        HAVING
            min_vk_aktion_brutto = 0
            AND max_vk_aktion_brutto = 0
            AND max_flag = 1
            AND min_flag = 1
    ) AS b
    WHERE
        `_werbeartikel_1_kmo0`.mandant_id = b.mandant_id
        AND `_werbeartikel_1_kmo0`.wup_id = b.wup_id
        AND `_werbeartikel_1_kmo0`.art_id = b.art_id
        AND `_werbeartikel_1_kmo0`.dat_von = b.dat_von
        AND `_werbeartikel_1_kmo0`.dat_bis = b.dat_bis
        AND `_werbeartikel_1_kmo0`.avq_relevant_fg = 1;

    UPDATE `_werbeartikel_1_kmo` SET vk_kcard_brutto = CAST(b.vk_kcard_brutto AS INT64)
    FROM (
        SELECT
            a.art_id,
            a.mandant_id,
            a.wup_id,
            b.werbetyp_id,
            MIN(d.preis_aktion) AS vk_kcard_brutto
        FROM dbp_data.aktion_1 AS c
        INNER JOIN dbp_data.aktion_art_wup_zu_1 AS a
            ON c.mandant_id = a.mandant_id AND c.aktion_id = a.aktion_id
        INNER JOIN dbp_data.pmr_angebot_art_wup_zu_1 AS d
            ON
                0 <> a.mandant_id
                AND 0 <> d.mandant_id
                AND a.wup_id = d.wup_id
                AND a.art_id = d.art_id
                AND a.aktion_id = d.aktion_id
        INNER JOIN `_werbeartikel_1_kmo` AS b
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
        `_werbeartikel_1_kmo`.mandant_id = b.mandant_id
        AND `_werbeartikel_1_kmo`.wup_id = b.wup_id
        AND `_werbeartikel_1_kmo`.art_id = b.art_id
        AND `_werbeartikel_1_kmo`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _pp AS
    SELECT *
    FROM `_werbeartikel_1_kmo`;

    TRUNCATE TABLE `_werbeartikel_1_kmo`;

    INSERT INTO `_werbeartikel_1_kmo`
    (
        SELECT
            kjwo,
            werbetyp_id,
            MIN(dat_von) AS dat_von,
            MAX(dat_bis) AS dat_bis,
            wup_id,
            mandant_id,
            art_id,
            akt_wo,
            vk_brutto,
            MIN(stkl_kopf_fg) AS stkl_kopf_fg,
            MIN(komponente) AS komponente,
            MAX(mutter_wb_id) AS mutter_wb_id,
            MAX(avq_relevant_fg) AS avq_relevant_fg,
            MIN(grund_sperrung) AS grund_sperrung,
            MAX(vk_vor_aktion_brutto) AS vk_vor_aktion_brutto,
            MAX(vk_aktion_brutto) AS vk_aktion_brutto,
            MAX(vk_kcard_brutto) AS vk_kcard_brutto
        FROM `_pp`
        GROUP BY
            kjwo,
            werbetyp_id,
            wup_id,
            mandant_id,
            art_id,
            akt_wo,
            vk_brutto
    );

    /* kunftige und abgeschlossene aktionen volle anzahl tage */
    CREATE OR REPLACE TEMPORARY TABLE _werbetyp_tage_kmo AS
    SELECT
        mandant_id,
        werbetyp_id,
        CASE
            WHEN dat_von >= CURRENT_DATE("Europe/Berlin") OR dat_bis < CURRENT_DATE("Europe/Berlin")
                THEN DATE_DIFF(dat_bis, dat_von, DAY) + 1 /* laufende aktionen anzahl tage start bis heute */
            ELSE DATE_DIFF(CURRENT_DATE("Europe/Berlin"), dat_von, DAY)
        END AS anz_tage_aktion
    FROM `_werbeartikel_1_kmo` AS b
    GROUP BY
        mandant_id,
        werbetyp_id,
        anz_tage_aktion;

    CREATE OR REPLACE TEMPORARY TABLE _die_tage_kmo AS
    SELECT
        b.mandant_id,
        a.dat
    FROM dbp_data.tag_1 AS a
    INNER JOIN `_werbeartikel_1_kmo` AS b
        ON a.dat BETWEEN b.dat_von AND b.dat_bis
    GROUP BY
        b.mandant_id,
        a.dat;

    CREATE OR REPLACE TEMPORARY TABLE _test1_ff_kmo AS
    SELECT
        t3.kjwo,
        t3.werbetyp_id,
        t3.dat_von,
        t3.dat_bis,
        t3.wup_id,
        t3.mandant_id,
        t3.art_id,
        t3.nb_id,
        t3.grund_sperrung,
        t3.umsatz_netto,
        t3.menge_,
        6 - t3.z0 AS tage_menge_0
    FROM (
        SELECT
            w.kjwo,
            w.werbetyp_id,
            w.dat_von,
            w.dat_bis,
            v.wup_id,
            v.mandant_id,
            v.art_id,
            v.nb_id,
            w.grund_sperrung,
            SUM(v.umsatz_netto) AS umsatz_netto,
            SUM(v.menge) AS menge_,
            COUNT(DISTINCT v.dat) AS z0
        FROM dbp_data.artbew_1 AS v
        INNER JOIN `_werbeartikel_1_kmo` AS w
            ON
                v.mandant_id = w.mandant_id
                AND v.wup_id = w.wup_id
                AND v.art_id = w.art_id
                AND v.dat BETWEEN w.dat_von AND w.dat_bis
        WHERE
            v.bewart_id = 1002
            AND (v.mandant_id, v.dat) IN (
                SELECT (mandant_id, dat)
                FROM `_die_tage_kmo`
            )
        GROUP BY
            v.mandant_id,
            v.wup_id,
            v.nb_id,
            v.art_id,
            w.kjwo,
            w.werbetyp_id,
            w.dat_von,
            w.dat_bis,
            w.grund_sperrung
        HAVING
            menge_ > 0
    ) AS t3;

    INSERT INTO `_test1_ff_kmo`
    (
        SELECT
            t5.kjwo,
            t5.werbetyp_id,
            t5.dat_von,
            t5.dat_bis,
            t5.wup_id,
            t5.mandant_id,
            t5.art_id,
            t5.nb_id,
            t5.grund_sperrung,
            t5.umsatz_netto,
            t5.menge_,
            6 - t5.z0 AS tage_menge_0
        FROM (
            SELECT
                w.kjwo,
                w.werbetyp_id,
                w.dat_von,
                w.dat_bis,
                v.wup_id,
                v.mandant_id,
                v.art_id,
                v.nb_id,
                w.grund_sperrung,
                SUM(v.umsatz_netto) AS umsatz_netto,
                SUM(v.menge) AS menge_,
                COUNT(DISTINCT v.dat) AS z0
            FROM dbp_data.artbew_1 AS v
            INNER JOIN (
                SELECT *
                FROM `_werbeartikel_1_kmo`
                WHERE
                    stkl_kopf_fg = 3
                    AND NOT (kjwo, werbetyp_id, mandant_id, art_id) IN (
                        SELECT (kjwo, werbetyp_id, mandant_id, art_id)
                        FROM `_test1_ff_kmo`
                    )
            ) AS w
                ON
                    v.mandant_id = w.mandant_id
                    AND v.wup_id = w.wup_id
                    AND v.art_id = w.art_id
                    AND v.dat BETWEEN w.dat_von AND w.dat_bis
            WHERE
                v.bewart_id = 1001
                AND (v.mandant_id, v.dat) IN (
                    SELECT (mandant_id, dat)
                    FROM `_die_tage_kmo`
                )
            GROUP BY
                v.mandant_id,
                v.wup_id,
                v.nb_id,
                v.art_id,
                w.kjwo,
                w.werbetyp_id,
                w.dat_von,
                w.dat_bis,
                w.grund_sperrung
            HAVING
                menge_ > 0
        ) AS t5
    );

    CREATE OR REPLACE TEMPORARY TABLE _ff_we1_kmo AS
    SELECT
        a.mandant_id,
        a.kjwo,
        a.dat_von,
        a.dat_bis,
        a.werbetyp_id,
        a.wup_id,
        a.nb_id,
        a.art_id
    FROM `_test1_ff_kmo` AS a
    INNER JOIN dbp_data.art_wg_zu_per_1 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.art_id = b.art_id
            AND b.arthiertyp_id = 2
            AND b.dat_bis = CAST('9999-12-31' AS DATE);

    CREATE OR REPLACE TEMPORARY TABLE _ff_we2_kmo AS
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
    FROM `_ff_we1_kmo` AS a
    INNER JOIN (
        SELECT
            a0.mandant_id,
            a0.kjwo,
            a0.werbetyp_id,
            CASE WHEN b.dat BETWEEN a0.dat_von AND a0.dat_bis THEN b.dat ELSE NULL END AS dat,
            CASE WHEN NOT b.dat BETWEEN a0.dat_von AND a0.dat_bis THEN b.dat ELSE NULL END AS dat_2
        FROM `_ff_we1_kmo` AS a0
        INNER JOIN dbp_data.tag_1 AS b
            ON b.dat BETWEEN DATE_SUB(a0.dat_von, INTERVAL '7' DAY) AND a0.dat_bis
        GROUP BY
            a0.mandant_id,
            a0.kjwo,
            a0.werbetyp_id,
            dat,
            dat_2
    ) AS b
        ON a.kjwo = b.kjwo AND a.werbetyp_id = b.werbetyp_id AND a.mandant_id = b.mandant_id;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we3_kmo AS
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
    FROM `_ff_we2_kmo` AS a
    LEFT JOIN (
        SELECT
            b.mandant_id,
            b.wup_id,
            c.werbetyp_id,
            b.art_id,
            b.dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_1 AS a
        INNER JOIN dbp_data.lagerbew_det_1 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_kmo`
            WHERE
                NOT dat IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_1 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_1 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id IN ('WE', 'WL')
            AND CASE
                WHEN
                    a.mandant_id IN (4)
                    AND c1.bestellart_id IN (
                        'UBPX',
                        'UBP',
                        'UBP1',
                        'NBP',
                        'NBBG',
                        'UB2',
                        'UBE',
                        'NBCZ',
                        'NBPL',
                        'NBSK',
                        'NBHR',
                        'NBRO',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'NZP',
                        'NZP1',
                        'NBMD',
                        'UBP0',
                        'ZUBZ'
                    )
                    OR a.mandant_id IN (2, 3, 5, 6, 7, 8)
                    AND c1.bestellart_id IN (
                        'UBPX',
                        'UBP',
                        'UBP1',
                        'NBP',
                        'NBBG',
                        'UB2',
                        'UBE',
                        'NBCZ',
                        'NBPL',
                        'NBSK',
                        'NBHR',
                        'NBRO',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'NZP',
                        'NZP1',
                        'NBMD',
                        'UBP0'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND a.mandant_id > 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_kmo`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN ('301', '302', '311', '312', '641', '642', '647', '648')
            AND NOT x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 26 AND mandant_id > 1
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
            b.wup_id,
            c.werbetyp_id,
            b.art_id,
            b.dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_1 AS a
        INNER JOIN dbp_data.lagerbew_det_1 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_kmo`
            WHERE
                NOT dat IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_1 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_1 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id IN ('WE', 'WL')
            AND x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 26 AND mandant_id > 1
            )
            AND a.mandant_id > 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_kmo`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN ('301', '302', '311', '312', '641', '642', '647', '648')
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
        FROM dbp_data.lagerbew_1 AS a
        INNER JOIN dbp_data.lagerbew_det_1 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_kmo`
            WHERE
                NOT dat_2 IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_1 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_1 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id IN ('WE', 'WL')
            AND CASE
                WHEN
                    a.mandant_id IN (4)
                    AND c1.bestellart_id IN (
                        'UBPX',
                        'UBP',
                        'UBP1',
                        'NBP',
                        'NBBG',
                        'UB2',
                        'UBE',
                        'NBCZ',
                        'NBPL',
                        'NBSK',
                        'NBHR',
                        'NBRO',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'NZP',
                        'NZP1',
                        'NBMD',
                        'UBP0',
                        'ZUBZ'
                    )
                    OR a.mandant_id IN (2, 3, 5, 6, 7, 8)
                    AND c1.bestellart_id IN (
                        'UBPX',
                        'UBP',
                        'UBP1',
                        'NBP',
                        'NBBG',
                        'UB2',
                        'UBE',
                        'NBCZ',
                        'NBPL',
                        'NBSK',
                        'NBHR',
                        'NBRO',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'NZP',
                        'NZP1',
                        'NBMD',
                        'UBP0'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND a.mandant_id > 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_kmo`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN ('301', '302', '311', '312', '641', '642', '647', '648')
            AND NOT x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 26 AND mandant_id > 1
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
        FROM dbp_data.lagerbew_1 AS a
        INNER JOIN dbp_data.lagerbew_det_1 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_kmo`
            WHERE
                NOT dat_2 IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            a.vorgangsart_id IN ('WE', 'WL')
            AND x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 26 AND mandant_id > 1
            )
            AND a.mandant_id > 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_kmo`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN ('301', '302', '311', '312', '641', '642', '647', '648')
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
        FROM dbp_data.lagerbew_1 AS a
        INNER JOIN dbp_data.lagerbew_det_1 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_kmo`
            WHERE
                NOT dat_2 IS NULL
        ) AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = DATE_SUB(c.dat_2, INTERVAL '7' DAY)
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            a.vorgangsart_id IN ('WE', 'WL')
            AND (x.mandant_id, x.wg_id) IN (
                SELECT (mandant_id, wg_id)
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 30 AND mandant_id > 1
            )
            AND a.mandant_id > 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_kmo`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo`
                WHERE
                    NOT dat IS NULL
            )
            AND NOT b.lager_bewart_id IN ('301', '302', '311', '312', '641', '642', '647', '648')
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

    CREATE OR REPLACE TEMPORARY TABLE _stpo_kmo AS
    SELECT
        mandant_id,
        stueckliste_id,
        art_id AS kopf_art
    FROM dbp_data.stueckliste_1 AS a
    WHERE
        dat_bis = CAST('9999-12-31' AS DATE) AND mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    GROUP BY
        mandant_id,
        stueckliste_id,
        kopf_art;

    CREATE OR REPLACE TEMPORARY TABLE _x_ray_kmo AS
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
        FROM `_ff_we2_kmo`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            dat,
            dat_2
    ) AS a
    INNER JOIN (
        SELECT kopf_art
        FROM `_stpo_kmo`
        GROUP BY
            kopf_art
    ) AS b
        ON TRUE;

    CREATE OR REPLACE TEMPORARY TABLE _help_me1_kmo AS
    SELECT
        mandant_id,
        dat
    FROM `_x_ray_kmo`
    WHERE
        NOT dat IS NULL
    GROUP BY
        mandant_id,
        dat;

    CREATE OR REPLACE TEMPORARY TABLE _help_me2_kmo AS
    SELECT
        mandant_id,
        dat_2
    FROM `_x_ray_kmo`
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
    FROM dbp_data.lagerbew_1 AS a
    INNER JOIN dbp_data.lagerbew_det_1 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
            AND a.dat_buch = b.dat_buch
    INNER JOIN dbp_data.besch_best_1 AS c1
        ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
    INNER JOIN dbp_data.besch_best_det_1 AS c2
        ON
            b.mandant_id = c2.mandant_id
            AND b.wup_id = c2.wup_id
            AND c1.dat_best_beleg = c2.dat_best_beleg
            AND b.best_beleg_id = c2.best_beleg_id
            AND b.best_beleg_pos_id = c2.best_beleg_pos_id
            AND b.art_id = c2.art_id
    WHERE
        a.vorgangsart_id IN ('WE', 'WL')
        AND CASE
            WHEN
                a.mandant_id IN (4)
                AND c1.bestellart_id IN (
                    'UBPX',
                    'UBP',
                    'UBP1',
                    'NBP',
                    'NBBG',
                    'UB2',
                    'UBE',
                    'NBCZ',
                    'NBPL',
                    'NBSK',
                    'NBHR',
                    'NBRO',
                    'UBGK',
                    'UBG1',
                    'UBG2',
                    'NZP',
                    'NZP1',
                    'NBMD',
                    'UBP0',
                    'ZUBZ'
                )
                OR a.mandant_id IN (2, 3, 5, 6, 7, 8)
                AND c1.bestellart_id IN (
                    'UBPX',
                    'UBP',
                    'UBP1',
                    'NBP',
                    'NBBG',
                    'UB2',
                    'UBE',
                    'NBCZ',
                    'NBPL',
                    'NBSK',
                    'NBHR',
                    'NBRO',
                    'UBGK',
                    'UBG1',
                    'UBG2',
                    'NZP',
                    'NZP1',
                    'NBMD',
                    'UBP0'
                )
                THEN 1
            ELSE 0
        END = 1
        AND a.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me1_kmo`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me2_kmo`
            ) AS t3
        )
        AND a.mandant_id > 1
        AND NOT b.lager_bewart_id IN ('301', '302', '311', '312', '641', '642', '647', '648');

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
    FROM dbp_data.lagerbew_1 AS a
    INNER JOIN dbp_data.lagerbew_det_1 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
            AND a.dat_buch = b.dat_buch
    INNER JOIN dbp_data.besch_best_1 AS c1
        ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
    INNER JOIN dbp_data.besch_best_det_1 AS c2
        ON
            b.mandant_id = c2.mandant_id
            AND b.wup_id = c2.wup_id
            AND c1.dat_best_beleg = c2.dat_best_beleg
            AND b.best_beleg_id = c2.best_beleg_id
            AND b.best_beleg_pos_id = c2.best_beleg_pos_id
            AND b.art_id = c2.art_id
    WHERE
        a.vorgangsart_id IN ('WE', 'WL')
        AND a.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me1_kmo`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me2_kmo`
            ) AS t3
        )
        AND a.mandant_id > 1
        AND NOT b.lager_bewart_id IN ('301', '302', '311', '312', '641', '642', '647', '648');

    CREATE OR REPLACE TEMPORARY TABLE _x_track1_kmo AS
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
        FROM `_x_ray_kmo`
        WHERE
            NOT dat IS NULL
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat
    INNER JOIN dbp_data.art_wg_zu_per_1 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat)
            FROM `_help_me1_kmo`
        )
        AND NOT x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_1
            WHERE
                wg_filter_id = 26 AND mandant_id > 1
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
        FROM `_x_ray_kmo`
        WHERE
            NOT dat IS NULL
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat
    INNER JOIN dbp_data.art_wg_zu_per_1 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat)
            FROM `_help_me1_kmo`
        )
        AND x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_1
            WHERE
                wg_filter_id = 26 AND mandant_id > 1
        )
    GROUP BY
        a.mandant_id,
        a.lagerbew_beleg_id,
        a.art_id,
        a.wup_id,
        a.dat_buch,
        c.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _x_track2_kmo AS
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
        FROM `_x_ray_kmo`
        WHERE
            NOT dat_2 IS NULL
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per_1 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat_2)
            FROM `_help_me2_kmo`
        )
        AND NOT x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_1
            WHERE
                wg_filter_id = 26 AND mandant_id > 1
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
        FROM `_x_ray_kmo`
        WHERE
            NOT dat_2 IS NULL
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per_1 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_1
            WHERE
                wg_filter_id = 26 AND mandant_id > 1
        )
        AND (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat_2)
            FROM `_help_me2_kmo`
        )
    GROUP BY
        a.mandant_id,
        a.lagerbew_beleg_id,
        a.art_id,
        a.wup_id,
        a.dat_buch,
        c.werbetyp_id;

        
    CREATE OR REPLACE TEMPORARY TABLE `_display_update_kmo` AS
    SELECT
        b.mandant_id,
        c_sub.werbetyp_id,
        b.wup_id,
        b.art_id,
        b.dat_buch,
        SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM dbp_data.lagerbew_1 AS a
    JOIN dbp_data.lagerbew_det_1 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
            AND a.dat_buch = b.dat_buch
    JOIN (
        SELECT
            c.mandant_id,
            c.werbetyp_id,
            c.lagerbew_beleg_id,
            c.wup_id,
            b.art_id,
            c.dat_buch
        FROM dbp_data.stueckliste_1 AS a
        JOIN dbp_data.stueckliste_det_1 AS b
            ON a.mandant_id = b.mandant_id AND a.stueckliste_id = b.stueckliste_id
        JOIN (
            SELECT
                mandant_id,
                werbetyp_id,
                lagerbew_beleg_id,
                wup_id,
                art_id,
                dat_buch
            FROM `_x_track1_kmo`
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
            FROM `_x_track2_kmo`
            GROUP BY
                mandant_id,
                werbetyp_id,
                lagerbew_beleg_id,
                wup_id,
                art_id,
                dat_buch
        ) AS c
            ON a.mandant_id = c.mandant_id AND a.art_id = c.art_id
        WHERE
            a.dat_bis = CAST('9999-12-31' AS DATE)
        GROUP BY
            c.mandant_id,
            c.werbetyp_id,
            c.lagerbew_beleg_id,
            c.wup_id,
            b.art_id,
            c.dat_buch
    ) AS c_sub
        ON
            b.mandant_id = c_sub.mandant_id
            AND b.wup_id = c_sub.wup_id
            AND b.art_id = c_sub.art_id
            AND b.lagerbew_beleg_id = c_sub.lagerbew_beleg_id
    CROSS JOIN (
        SELECT
            MIN(dat) - 7 AS min_dat,
            MAX(dat) AS max_dat
        FROM `_ff_we3_kmo`
        WHERE
            NOT dat IS NULL
    ) AS date_range
    WHERE
        a.vorgangsart_id IN ('WE', 'WL')
        AND NOT b.lager_bewart_id IN ('301', '302', '311', '312', '641', '642', '647', '648')
        AND b.dat_buch BETWEEN date_range.min_dat AND date_range.max_dat
    GROUP BY
        b.mandant_id,
        c_sub.werbetyp_id,
        b.wup_id,
        b.art_id,
        b.dat_buch;

        
    UPDATE _ff_we3_kmo SET we_menge = b.menge_lagerbew_bme + _ff_we3_kmo.we_menge
    FROM (
        SELECT *
        FROM _display_update_kmo
    ) AS b
    WHERE
        _ff_we3_kmo.mandant_id = b.mandant_id
        AND _ff_we3_kmo.wup_id = b.wup_id
        AND _ff_we3_kmo.art_id = b.art_id
        AND _ff_we3_kmo.werbetyp_id = b.werbetyp_id
        AND _ff_we3_kmo.dat = b.dat_buch
        AND _ff_we3_kmo.dat BETWEEN _ff_we3_kmo.dat_von AND _ff_we3_kmo.dat_bis;

        
    UPDATE _ff_we3_kmo SET we_menge_2 = b.menge_lagerbew_bme + _ff_we3_kmo.we_menge_2
    FROM (
        SELECT *
        FROM _display_update_kmo
    ) AS b
    WHERE
        _ff_we3_kmo.mandant_id = b.mandant_id
        AND _ff_we3_kmo.wup_id = b.wup_id
        AND _ff_we3_kmo.art_id = b.art_id
        AND _ff_we3_kmo.werbetyp_id = b.werbetyp_id
        AND _ff_we3_kmo.dat = b.dat_buch
        AND NOT _ff_we3_kmo.dat BETWEEN _ff_we3_kmo.dat_von AND _ff_we3_kmo.dat_bis;

    UPDATE `_ff_we3_kmo` SET we_menge_2 = 0
    FROM (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.kjwo,
            a.wup_id,
            a.art_id,
            DATE_SUB(a.dat_von, INTERVAL '3' DAY) AS min_dat
        FROM `_ff_we3_kmo` AS a
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                a.mandant_id = x.mandant_id
                AND a.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            (x.mandant_id, x.wg_id) IN (
                SELECT (mandant_id, wg_id)
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 27 AND mandant_id > 1
            )
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.kjwo,
            a.wup_id,
            a.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3_kmo`.mandant_id = b.mandant_id
        AND `_ff_we3_kmo`.wup_id = b.wup_id
        AND `_ff_we3_kmo`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_kmo`.art_id = b.art_id
        AND `_ff_we3_kmo`.kjwo = b.kjwo
        AND `_ff_we3_kmo`.dat < b.min_dat;

    UPDATE `_ff_we3_kmo` SET we_menge_2 = 0
    FROM (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.kjwo,
            a.wup_id,
            a.art_id,
            DATE_SUB(a.dat_von, INTERVAL '1' DAY) AS min_dat
        FROM `_ff_we3_kmo` AS a
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                a.mandant_id = x.mandant_id
                AND a.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            (x.mandant_id, x.wg_id) IN (
                SELECT (mandant_id, wg_id)
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 28 AND mandant_id > 1
            )
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.kjwo,
            a.wup_id,
            a.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3_kmo`.mandant_id = b.mandant_id
        AND `_ff_we3_kmo`.wup_id = b.wup_id
        AND `_ff_we3_kmo`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_kmo`.art_id = b.art_id
        AND `_ff_we3_kmo`.kjwo = b.kjwo
        AND `_ff_we3_kmo`.dat < b.min_dat;

    UPDATE `_ff_we3_kmo` SET we_menge_2 = 0
    FROM (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.kjwo,
            a.wup_id,
            a.art_id,
            a.dat_von AS min_dat
        FROM `_ff_we3_kmo` AS a
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                a.mandant_id = x.mandant_id
                AND a.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            (x.mandant_id, x.wg_id) IN (
                SELECT (mandant_id, wg_id)
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 50 AND mandant_id > 1
            )
        GROUP BY
            a.mandant_id,
            a.werbetyp_id,
            a.kjwo,
            a.wup_id,
            a.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3_kmo`.mandant_id = b.mandant_id
        AND `_ff_we3_kmo`.wup_id = b.wup_id
        AND `_ff_we3_kmo`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_kmo`.art_id = b.art_id
        AND `_ff_we3_kmo`.kjwo = b.kjwo
        AND `_ff_we3_kmo`.dat < b.min_dat;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we4_kmo AS
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
    FROM `_ff_we3_kmo` AS a
    GROUP BY
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        nb_id;

    CREATE OR REPLACE TEMPORARY TABLE _mbst_we1_kmo AS
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
    FROM `_ff_we4_kmo` AS v
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            DATE_SUB(dat_von, INTERVAL '1' DAY) AS dat_von,
            kjwo
        FROM `_werbeartikel_1_kmo`
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
    LEFT JOIN dbp_data.marktbestand_erp_1 AS u
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

    UPDATE `_ff_we4_kmo` SET menge_aktionsstart = CAST(b.menge_aktionsstart AS INT64)
    FROM (
        SELECT *
        FROM `_mbst_we1_kmo`
        WHERE
            menge_aktionsstart <> 0
    ) AS b
    WHERE
        `_ff_we4_kmo`.mandant_id = b.mandant_id
        AND `_ff_we4_kmo`.wup_id = b.wup_id
        AND `_ff_we4_kmo`.nb_id = b.nb_id
        AND `_ff_we4_kmo`.art_id = b.art_id
        AND `_ff_we4_kmo`.kjwo = b.kjwo
        AND `_ff_we4_kmo`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _wup_kalender_kmo AS
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
        FROM `_werbeartikel_1_kmo`
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
        FROM dbp_data.wupcal_1
        WHERE
            (mandant_id, dat) IN (
                SELECT (mandant_id, dat)
                FROM `_die_tage_kmo`
            )
    ) AS b
        ON
            a.wup_id = b.wup_id
            AND a.mandant_id = b.mandant_id
            AND b.dat BETWEEN a.dat_von AND a.dat_bis
    GROUP BY
        a.kjwo,
        a.werbetyp_id,
        a.mandant_id,
        a.wup_id;

        /* Start Protokollierung Umrechnungsfaktor -- */
    DELETE FROM dbp_etl_process.avq_protokoll_umrechnung_1
    WHERE
        (kjwo, mandant_id, art_id) IN (
            SELECT (kjwo, mandant_id, art_id)
            FROM `_werbeartikel_1_kmo`
        );

    INSERT INTO dbp_etl_process.avq_protokoll_umrechnung_1 (
        kjwo,
        mandant_id,
        art_id,
        komponente_art_id,
        komponentenmenge_einh_id,
        stueckliste_id
    )
    (
        SELECT
            w.kjwo,
            v.mandant_id,
            v.art_id,
            v.komponente_art_id,
            v.komponentenmenge_einh_id,
            v.stueckliste_id
        FROM (
            SELECT
                a.mandant_id,
                a.wup_id,
                a.nb_id,
                a.dat,
                a.bewart_id,
                a.gp_id,
                a.art_id,
                a.aktion_id,
                a.promo_fg,
                a.ean_kasse,
                a.standard_aktion_id,
                a.einkaufsorganisation_id,
                a.herst_id,
                a.mwst_id,
                a.menge,
                a.wrg_1,
                a.umsatz_netto,
                a.diff_umsatz_netto_konz,
                a.umsatz_mwst_betrag,
                a.diff_umsatz_mwst_betrag_konz,
                a.ek_brutto,
                a.diff_ek_brutto_konz,
                a.ek_netto,
                a.diff_ek_netto_konz,
                a.ek_nettonetto,
                a.diff_ek_nettonetto_konz,
                a.ek_kal_basis,
                a.diff_ek_kal_basis_konz,
                a.ek_mep,
                a.diff_ek_mep_konz,
                a.ek_mep_vor_fwu,
                a.ek_mep_vor_fwu_konz,
                a.einstandspreis,
                a.diff_einstandspreis_konz,
                a.logkostenzuschlag,
                a.diff_logkostenzuschlag_konz,
                a.bezugsweg_id,
                a.ek_netto_bnk,
                a.diff_ek_netto_bnk_konz,
                a.ek_netto_bnk_sachk,
                a.diff_ek_netto_bnk_sachk_konz,
                a.posten_id,
                a.bq_findung_id,
                a.ek_gld,
                a.diff_ek_gld_konz,
                a.bonusbasis,
                a.bonusbasis_konz,
                a.bewart_det_id,
                a.wup_bereinigt_fg,
                a.pv_aktion,
                a.pv_aktion_konz,
                a.pv_bby,
                a.pv_bby_konz,
                a.pv_kdn_bby,
                a.pv_kdn_bby_konz,
                a.pv_kdp_bby,
                a.pv_kdp_bby_konz,
                a.pv_aktion_bby,
                a.pv_aktion_bby_konz,
                a.pv_aktion_kdn_bby,
                a.pv_aktion_kdn_bby_konz,
                a.pv_aktion_kdp_bby,
                a.pv_aktion_kdp_bby_konz,
                a.pv_bonrabatt_bby,
                a.pv_bonrabatt_bby_konz,
                a.td_update,
                a.td_insert,
                a.umrechnungskurs_hist,
                a.aktionsart_id_liste_txt,
                a.aktionsart_bez_liste_txt,
                a.aktion_typ_id_liste_txt,
                a.aktion_typ_bez_liste_txt,
                b.stueckliste_id,
                b.komponente_art_id,
                b.komponentenmenge_einh_id,
                ROUND(CAST(COALESCE(c.umrech_faktor, 9999999999) AS NUMERIC), 3) AS menge_
            FROM dbp_data.artbew_1 AS a
            INNER JOIN (
                SELECT
                    a0.mandant_id,
                    a0.stueckliste_id,
                    a0.art_id,
                    b.art_id AS komponente_art_id,
                    b.komponentenmenge,
                    b.komponentenmenge_einh_id,
                    b.dat_von,
                    b.dat_bis
                FROM dbp_data.stueckliste_1 AS a0
                INNER JOIN dbp_data.stueckliste_det_1 AS b
                    ON a0.mandant_id = b.mandant_id AND a0.stueckliste_id = b.stueckliste_id
                INNER JOIN (
                    SELECT
                        mandant_id,
                        art_id,
                        komponente
                    FROM `_werbeartikel_1_kmo`
                    WHERE
                        stkl_kopf_fg IN (1, 2)
                    GROUP BY
                        mandant_id,
                        art_id,
                        komponente
                ) AS c
                    ON a0.mandant_id = c.mandant_id AND a0.art_id = c.art_id AND b.art_id = c.komponente
                WHERE
                    a0.stueckliste_verwendung_id = 3 AND b.stueckliste_typ_id = 'M'
            ) AS b
                ON
                    a.mandant_id = b.mandant_id
                    AND a.art_id = b.art_id
                    AND a.dat BETWEEN b.dat_von AND b.dat_bis
            LEFT JOIN dbp_data.art_umrechnung_faktor_per_1 AS c
                ON
                    b.mandant_id = c.mandant_id
                    AND b.art_id = c.art_id
                    AND b.komponentenmenge_einh_id = c.altnv_menge_einh_id
                    AND c.dat_bis = CAST('9999-12-31' AS DATE)
            WHERE
                (a.mandant_id, a.dat) IN (
                    SELECT (mandant_id, dat)
                    FROM `_die_tage_kmo`
                )
                AND a.umsatz_netto > 0
        ) AS v
        INNER JOIN (
            SELECT
                mandant_id,
                kjwo,
                werbetyp_id,
                wup_id,
                art_id,
                dat_von,
                dat_bis
            FROM `_werbeartikel_1_kmo`
            GROUP BY
                kjwo,
                werbetyp_id,
                dat_von,
                dat_bis,
                wup_id,
                mandant_id,
                art_id
        ) AS w
            ON
                v.mandant_id = w.mandant_id
                AND v.wup_id = w.wup_id
                AND v.art_id = w.art_id
                AND v.dat BETWEEN w.dat_von AND w.dat_bis
        WHERE
            v.menge_ = 9999999999
        GROUP BY
            v.mandant_id,
            v.art_id,
            v.stueckliste_id,
            v.komponente_art_id,
            v.komponentenmenge_einh_id,
            w.kjwo
    );

    /* Ende Protokollierung Umrechnungsfaktor -- */
    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew_kmo AS
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
        SUM(CASE WHEN x.wtag_id = 1 THEN v.menge_ ELSE 0 END) AS menge_mo,
        SUM(CASE WHEN x.wtag_id = 2 THEN v.menge_ ELSE 0 END) AS menge_di,
        SUM(CASE WHEN x.wtag_id = 3 THEN v.menge_ ELSE 0 END) AS menge_mi,
        SUM(CASE WHEN x.wtag_id = 4 THEN v.menge_ ELSE 0 END) AS menge_do,
        SUM(CASE WHEN x.wtag_id = 5 THEN v.menge_ ELSE 0 END) AS menge_fr,
        SUM(CASE WHEN x.wtag_id = 6 THEN v.menge_ ELSE 0 END) AS menge_sa,
        SUM(CASE WHEN x.wtag_id = 7 THEN v.menge_ ELSE 0 END) AS menge_so,
        SUM(v.menge_) AS menge_wo,
        SUM(CASE WHEN v.bewart_id = 1002 THEN v.menge_ ELSE 0 END) AS menge_sa2,
        MAX(z.anz_offen) - COUNT(DISTINCT v.dat) AS tage_menge_0,
        SUM(0) AS we_menge,
        SUM(0) AS menge_aktionsstart,
        SUM(0) AS we_menge_ab_vorwoche,
        0 AS hilfe
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.nb_id,
            a.dat,
            a.bewart_id,
            a.gp_id,
            a.art_id,
            a.aktion_id,
            a.promo_fg,
            a.ean_kasse,
            a.standard_aktion_id,
            a.einkaufsorganisation_id,
            a.herst_id,
            a.mwst_id,
            a.menge,
            a.wrg_1,
            a.umsatz_netto,
            a.diff_umsatz_netto_konz,
            a.umsatz_mwst_betrag,
            a.diff_umsatz_mwst_betrag_konz,
            a.ek_brutto,
            a.diff_ek_brutto_konz,
            a.ek_netto,
            a.diff_ek_netto_konz,
            a.ek_nettonetto,
            a.diff_ek_nettonetto_konz,
            a.ek_kal_basis,
            a.diff_ek_kal_basis_konz,
            a.ek_mep,
            a.diff_ek_mep_konz,
            a.ek_mep_vor_fwu,
            a.ek_mep_vor_fwu_konz,
            a.einstandspreis,
            a.diff_einstandspreis_konz,
            a.logkostenzuschlag,
            a.diff_logkostenzuschlag_konz,
            a.bezugsweg_id,
            a.ek_netto_bnk,
            a.diff_ek_netto_bnk_konz,
            a.ek_netto_bnk_sachk,
            a.diff_ek_netto_bnk_sachk_konz,
            a.posten_id,
            a.bq_findung_id,
            a.ek_gld,
            a.diff_ek_gld_konz,
            a.bonusbasis,
            a.bonusbasis_konz,
            a.bewart_det_id,
            a.wup_bereinigt_fg,
            a.pv_aktion,
            a.pv_aktion_konz,
            a.pv_bby,
            a.pv_bby_konz,
            a.pv_kdn_bby,
            a.pv_kdn_bby_konz,
            a.pv_kdp_bby,
            a.pv_kdp_bby_konz,
            a.pv_aktion_bby,
            a.pv_aktion_bby_konz,
            a.pv_aktion_kdn_bby,
            a.pv_aktion_kdn_bby_konz,
            a.pv_aktion_kdp_bby,
            a.pv_aktion_kdp_bby_konz,
            a.pv_bonrabatt_bby,
            a.pv_bonrabatt_bby_konz,
            a.td_update,
            a.td_insert,
            a.umrechnungskurs_hist,
            a.aktionsart_id_liste_txt,
            a.aktionsart_bez_liste_txt,
            a.aktion_typ_id_liste_txt,
            a.aktion_typ_bez_liste_txt,
            COALESCE(
                ROUND(
                    CAST(CAST(a.menge AS FLOAT64) * CAST(b.komponentenmenge AS FLOAT64) / COALESCE(c.umrech_faktor, 1000.0000) AS NUMERIC),
                    3
                ),
                a.menge
            ) AS menge_
        FROM dbp_data.artbew_1 AS a
        LEFT JOIN (
            SELECT
                a0.mandant_id,
                a0.art_id,
                b.art_id AS komponente_art_id,
                b.komponentenmenge,
                b.komponentenmenge_einh_id,
                b.dat_von,
                b.dat_bis
            FROM dbp_data.stueckliste_1 AS a0
            INNER JOIN dbp_data.stueckliste_det_1 AS b
                ON a0.mandant_id = b.mandant_id AND a0.stueckliste_id = b.stueckliste_id
            INNER JOIN (
                SELECT
                    mandant_id,
                    art_id,
                    komponente
                FROM `_werbeartikel_1_kmo`
                WHERE
                    stkl_kopf_fg IN (1, 2)
                GROUP BY
                    mandant_id,
                    art_id,
                    komponente
            ) AS c
                ON a0.mandant_id = c.mandant_id AND a0.art_id = c.art_id AND b.art_id = c.komponente
            WHERE
                a0.stueckliste_verwendung_id = 3 AND b.stueckliste_typ_id = 'M'
        ) AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.art_id = b.art_id
                AND a.dat BETWEEN b.dat_von AND b.dat_bis
        LEFT JOIN dbp_data.art_umrechnung_faktor_per_1 AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.art_id = c.art_id
                AND b.komponentenmenge_einh_id = c.altnv_menge_einh_id
                AND c.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            (a.mandant_id, a.dat) IN (
                SELECT (mandant_id, dat)
                FROM `_die_tage_kmo`
            )
            AND a.umsatz_netto > 0
    ) AS v
    INNER JOIN (
        SELECT
            mandant_id,
            kjwo,
            werbetyp_id,
            wup_id,
            art_id,
            dat_von,
            dat_bis
        FROM `_werbeartikel_1_kmo`
        GROUP BY
            mandant_id,
            kjwo,
            werbetyp_id,
            wup_id,
            art_id,
            dat_von,
            dat_bis
    ) AS w
        ON
            v.mandant_id = w.mandant_id
            AND v.wup_id = w.wup_id
            AND v.art_id = w.art_id
            AND v.dat BETWEEN w.dat_von AND w.dat_bis
    INNER JOIN dbp_data.tag_1 AS x
        ON v.dat = x.dat
    INNER JOIN `_wup_kalender_kmo` AS z
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

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst1_kmo AS
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
    FROM `_ff_we4_kmo` AS v
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_bis,
            kjwo
        FROM `_werbeartikel_1_kmo`
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
    LEFT JOIN dbp_data.marktbestand_erp_1 AS u
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

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2_kmo AS
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
    FROM `_ff_we4_kmo` AS v
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
        FROM `_werbeartikel_1_kmo` AS a
        INNER JOIN dbp_data.tag_1 AS b
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
    INNER JOIN dbp_data.art_1 AS xx
        ON v.mandant_id = xx.mandant_id AND v.art_id = xx.art_id
    LEFT JOIN dbp_data.marktbestand_erp_1 AS x
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

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2a_kmo AS
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
    FROM `_ff_we4_kmo` AS v
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
        FROM `_werbeartikel_1_kmo` AS a
        INNER JOIN dbp_data.tag_1 AS b
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
    INNER JOIN dbp_data.art_1 AS xx
        ON v.mandant_id = xx.mandant_id AND v.art_id = xx.art_id
    LEFT JOIN dbp_data.marktbestand_erp_1 AS x
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

        /* Anzahl Nullbestand Tag_1 2 */
    UPDATE `_test_we_mbst2a_kmo` SET anz_null_tag2 = b.anz_null_tag2
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
        FROM dbp_data.marktbestand_erp_1 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.tag_1 AS b
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
        INNER JOIN dbp_data.art_1 AS xx
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
        `_test_we_mbst2a_kmo`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_kmo`.wup_id = b.wup_id
        AND `_test_we_mbst2a_kmo`.art_id = b.art_id
        AND `_test_we_mbst2a_kmo`.dat_von = b.dat_von
        AND `_test_we_mbst2a_kmo`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_kmo`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_1 3 */
    UPDATE `_test_we_mbst2a_kmo` SET anz_null_tag3 = b.anz_null_tag3
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
        FROM dbp_data.marktbestand_erp_1 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.tag_1 AS b
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
        INNER JOIN dbp_data.art_1 AS xx
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
        `_test_we_mbst2a_kmo`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_kmo`.wup_id = b.wup_id
        AND `_test_we_mbst2a_kmo`.art_id = b.art_id
        AND `_test_we_mbst2a_kmo`.dat_von = b.dat_von
        AND `_test_we_mbst2a_kmo`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_kmo`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_1 4 */
    UPDATE `_test_we_mbst2a_kmo` SET anz_null_tag4 = b.anz_null_tag4
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
        FROM dbp_data.marktbestand_erp_1 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.tag_1 AS b
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
        INNER JOIN dbp_data.art_1 AS xx
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
        `_test_we_mbst2a_kmo`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_kmo`.wup_id = b.wup_id
        AND `_test_we_mbst2a_kmo`.art_id = b.art_id
        AND `_test_we_mbst2a_kmo`.dat_von = b.dat_von
        AND `_test_we_mbst2a_kmo`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_kmo`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_1 5 */
    UPDATE `_test_we_mbst2a_kmo` SET anz_null_tag5 = b.anz_null_tag5
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
        FROM dbp_data.marktbestand_erp_1 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.tag_1 AS b
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
        INNER JOIN dbp_data.art_1 AS xx
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
        `_test_we_mbst2a_kmo`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_kmo`.wup_id = b.wup_id
        AND `_test_we_mbst2a_kmo`.art_id = b.art_id
        AND `_test_we_mbst2a_kmo`.dat_von = b.dat_von
        AND `_test_we_mbst2a_kmo`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_kmo`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_1 6 */
    UPDATE `_test_we_mbst2a_kmo` SET anz_null_tag6 = b.anz_null_tag6
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
        FROM dbp_data.marktbestand_erp_1 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.tag_1 AS b
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
        INNER JOIN dbp_data.art_1 AS xx
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
        `_test_we_mbst2a_kmo`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_kmo`.wup_id = b.wup_id
        AND `_test_we_mbst2a_kmo`.art_id = b.art_id
        AND `_test_we_mbst2a_kmo`.dat_von = b.dat_von
        AND `_test_we_mbst2a_kmo`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_kmo`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_1 7 */
    UPDATE `_test_we_mbst2a_kmo` SET anz_null_tag7 = b.anz_null_tag7
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
        FROM dbp_data.marktbestand_erp_1 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.tag_1 AS b
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
        INNER JOIN dbp_data.art_1 AS xx
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
        `_test_we_mbst2a_kmo`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_kmo`.wup_id = b.wup_id
        AND `_test_we_mbst2a_kmo`.art_id = b.art_id
        AND `_test_we_mbst2a_kmo`.dat_von = b.dat_von
        AND `_test_we_mbst2a_kmo`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_kmo`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2b_kmo AS
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
    FROM `_ff_we4_kmo` AS v
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
        FROM `_werbeartikel_1_kmo` AS a
        INNER JOIN dbp_data.tag_1 AS b
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
    INNER JOIN dbp_data.art_1 AS xx
        ON v.mandant_id = xx.mandant_id AND v.art_id = xx.art_id
    LEFT JOIN dbp_data.marktbestand_erp_1 AS x
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

    CREATE OR REPLACE TEMPORARY TABLE _ff_we5_kmo AS
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
    FROM `_ff_we4_kmo` AS a
    INNER JOIN `_test_we_mbst1_kmo` AS b
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

    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew1_kmo AS
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
        hilfe,
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
    FROM `_ff_we_artbew_kmo` AS a;

    UPDATE `_ff_we_artbew1_kmo` SET we_menge = CAST(b.we_menge AS INT64), we_menge_ab_vorwoche = CAST(b.we_menge_ab_vorwoche AS INT64), we_menge_vor_aktion = CAST(b.we_menge_ab_vorwoche AS INT64), menge_aktionsstart = b.menge_aktionsstart, menge_endbestand = CAST(b.menge_endbestand AS INT64), min_sicherh_bestand = CAST(b.min_sicherh_bestand AS INT64), sollbestand = CAST(b.sollbestand AS INT64), bezugsweg_id = b.bezugsweg_id
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
        FROM `_ff_we5_kmo` AS a
        LEFT JOIN dbp_data.art_wup_status_per_1 AS f
            ON
                a.mandant_id = f.mandant_id
                AND a.wup_id = f.wup_id
                AND a.nb_id = f.nb_id
                AND a.art_id = f.art_id
                AND f.dat_bis = CAST('9999-12-31' AS DATE)
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo`.nb_id = b.nb_id
        AND `_ff_we_artbew1_kmo`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo` SET mhd_zeitraum = b.mhd_zeitraum, lager_prozent = b.lager_prozent
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
        FROM `_ff_we5_kmo` AS a
        LEFT JOIN dbp_data.art_1 AS f
            ON a.mandant_id = f.mandant_id AND a.art_id = f.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo`.nb_id = b.nb_id
        AND `_ff_we_artbew1_kmo`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo` SET menge_bestand_soll_max = CAST(b.menge_bestand_soll_max AS INT64)
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
        FROM `_ff_we5_kmo` AS a
        LEFT JOIN dbp_data.art_wup_nachschub_per_1 AS f
            ON
                a.mandant_id = f.mandant_id
                AND a.wup_id = f.wup_id
                AND a.nb_id = f.nb_id
                AND a.art_id = f.art_id
                AND f.dat_bis = CAST('9999-12-31' AS DATE)
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo`.nb_id = b.nb_id
        AND `_ff_we_artbew1_kmo`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _fix_it_kmo AS
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
        FROM dbp_ods.ods_bon_verkauf_1 AS a
        INNER JOIN `_werbeartikel_1_kmo` AS b
            ON
                a.mandant_id = b.mandant_id
                AND DATE(a.start_bon_zeile) = b.dat_von
                AND a.wup_id = b.wup_id
                AND b.art_id / 10 = a.kl_art_id
                AND CAST(a.start_bon_zeile AS TIME) BETWEEN CAST('07:00:00' AS TIME) AND CAST('13:00:00' AS TIME)
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.wup_id,
                a0.werbetyp_id
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.wupcal_1 AS b0
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
            a.mandant_id > 1
        GROUP BY
            b.kjwo,
            b.werbetyp_id,
            b.wup_id,
            b.mandant_id,
            b.art_id
        HAVING
            menge_tag1_7bis13h > 0
    ) AS t5;

    INSERT INTO `_fix_it_kmo`
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
            FROM dbp_ods.ods_bon_verkauf_1 AS a
            INNER JOIN `_werbeartikel_1_kmo` AS b
                ON
                    a.mandant_id = b.mandant_id
                    AND DATE(a.start_bon_zeile) BETWEEN b.dat_von AND b.dat_bis
                    AND a.wup_id = b.wup_id
                    AND b.art_id / 10 = a.kl_art_id
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
                    FROM `_werbeartikel_1_kmo` AS a0
                    INNER JOIN dbp_data.wupcal_1 AS b0
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
                INNER JOIN dbp_data.wupcal_1 AS b1
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
                a.mandant_id > 1
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

    UPDATE `_ff_we_artbew1_kmo` SET menge_tag1_7bis13h = CAST(b.menge_tag1_7bis13h AS INT64)
    FROM (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            kjwo,
            MAX(menge_tag1_7bis13h) AS menge_tag1_7bis13h
        FROM `_fix_it_kmo`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            kjwo
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _fix_it_kmo2 AS
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
        FROM dbp_ods.ods_bon_verkauf_1 AS a
        INNER JOIN `_werbeartikel_1_kmo` AS b
            ON
                a.mandant_id = b.mandant_id
                AND DATE(a.start_bon_zeile) = b.dat_von
                AND a.wup_id = b.wup_id
                AND b.art_id / 10 = a.kl_art_id
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.wup_id,
                a0.werbetyp_id
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.wupcal_1 AS b0
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
            a.mandant_id > 1
        GROUP BY
            b.kjwo,
            b.werbetyp_id,
            b.wup_id,
            b.mandant_id,
            b.art_id
        HAVING
            menge_nur_tag1 > 0
    ) AS t5;

    INSERT INTO `_fix_it_kmo2`
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
            FROM dbp_ods.ods_bon_verkauf_1 AS a
            INNER JOIN `_werbeartikel_1_kmo` AS b
                ON
                    a.mandant_id = b.mandant_id
                    AND DATE(a.start_bon_zeile) BETWEEN b.dat_von AND b.dat_bis
                    AND a.wup_id = b.wup_id
                    AND b.art_id / 10 = a.kl_art_id
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
                    FROM `_werbeartikel_1_kmo` AS a0
                    INNER JOIN dbp_data.wupcal_1 AS b0
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
                INNER JOIN dbp_data.wupcal_1 AS b1
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
                a.mandant_id > 1
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

    UPDATE `_ff_we_artbew1_kmo` SET menge_nur_tag1 = CAST(b.menge_nur_tag1 AS INT64)
    FROM (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            kjwo,
            MAX(menge_nur_tag1) AS menge_nur_tag1
        FROM `_fix_it_kmo2`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            kjwo
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo` SET anzahl_nullbestand = b.anz_tage_null, anzahl_minusbestand = b.anz_tage_minus
    FROM `_test_we_mbst2_kmo` AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo`.nb_id = b.nb_id
        AND `_ff_we_artbew1_kmo`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo` SET anzahl_nullbestand_tag1 = b.anz_null_tag1, anzahl_nullbestand_tag2 = b.anz_null_tag2, anzahl_nullbestand_tag3 = b.anz_null_tag3, anzahl_nullbestand_tag4 = b.anz_null_tag4, anzahl_nullbestand_tag5 = b.anz_null_tag5, anzahl_nullbestand_tag6 = b.anz_null_tag6, anzahl_nullbestand_tag7 = b.anz_null_tag7, anzahl_minusbestand_tag1 = b.anz_minus_tag1
    FROM `_test_we_mbst2a_kmo` AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo`.nb_id = b.nb_id
        AND `_ff_we_artbew1_kmo`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo` SET anzahl_nullbestand_tag1bis3 = b.anz_null_tag1_bis_tag3, anzahl_minusbestand_tag1bis3 = b.anz_minus_tag1_bis_tag3
    FROM `_test_we_mbst2b_kmo` AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo`.nb_id = b.nb_id
        AND `_ff_we_artbew1_kmo`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo` SET menge_historie_af = CAST(b.menge_historie_af AS INT64)
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            SUM(d.menge) / 42.000 AS menge_historie_af
        FROM `_ff_we_artbew1_kmo` AS a
        INNER JOIN dbp_data.woche_1 AS b
            ON a.kjwo = b.kjwo
        INNER JOIN dbp_data.woche_kj_kl_1 AS c
            ON c.akt_wo BETWEEN b.akt_wo - 6 AND (
                b.akt_wo - 1
            )
        INNER JOIN dbp_data.artbew_wo_sum_1 AS d
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
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo`.art_id = b.art_id;

    UPDATE `_ff_we_artbew1_kmo` SET anzahl_tage_aktion = b.anz_tage_aktion
    FROM (
        SELECT
            mandant_id,
            werbetyp_id,
            MAX(anz_tage_aktion) AS anz_tage_aktion
        FROM `_werbetyp_tage_kmo`
        GROUP BY
            mandant_id,
            werbetyp_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo` SET we_menge_ab_vorwoche = `_ff_we_artbew1_kmo`.we_menge
    WHERE
        TRUE;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew2_kmo AS
    SELECT DISTINCT
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
        a.hilfe,
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
    FROM `_ff_we_artbew1_kmo` AS a
    INNER JOIN dbp_data.tag_1 AS b
        ON CASE
            WHEN a.werbetyp_id = 1
                THEN DATE_ADD(a.dat_von, INTERVAL '1' DAY)
            ELSE a.dat_von
        END = b.dat
    INNER JOIN dbp_data.tag_1 AS c
        ON a.dat_bis = c.dat
    INNER JOIN `_werbeartikel_1_kmo` AS w
        ON
            a.mandant_id = w.mandant_id
            AND a.wup_id = w.wup_id
            AND a.art_id = w.art_id
            AND a.dat_von BETWEEN w.dat_von AND w.dat_bis
            AND a.werbetyp_id = w.werbetyp_id;

    UPDATE `_ff_we_artbew2_kmo` SET
        mutter_wb_id = b.max_komponente, we_menge_ab_vorwoche = CAST(CASE
            WHEN `_ff_we_artbew2_kmo`.we_menge_ab_vorwoche = 0
                THEN 0.001
            ELSE `_ff_we_artbew2_kmo`.we_menge_ab_vorwoche
        END AS INT64), art_id = b.max_komponente, hilfe = 99
    FROM (
        SELECT
            mandant_id,
            art_id,
            MAX(komponente) AS max_komponente
        FROM `_werbeartikel_1_kmo`
        WHERE
            stkl_kopf_fg IN (1, 2) AND mandant_id <> 4
        GROUP BY
            mandant_id,
            art_id
    ) AS b
    WHERE
        `_ff_we_artbew2_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew2_kmo`.art_id = b.art_id;

    UPDATE `_ff_we_artbew2_kmo` SET
        mutter_wb_id = b.max_komponente, we_menge_ab_vorwoche = CAST(CASE
            WHEN `_ff_we_artbew2_kmo`.we_menge_ab_vorwoche = 0
                THEN 0.001
            ELSE `_ff_we_artbew2_kmo`.we_menge_ab_vorwoche
        END AS INT64), art_id = b.max_komponente, hilfe = 99, anzahl_nullbestand_tag1 = b.anzahl_nullbestand_tag1, anzahl_nullbestand_tag1bis3 = b.anzahl_nullbestand_tag1bis3, anzahl_nullbestand = b.anzahl_nullbestand
    FROM (
        SELECT
            a.mandant_id,
            a.art_id,
            MAX(a.komponente) AS max_komponente,
            MIN(b.anzahl_nullbestand_tag1) AS anzahl_nullbestand_tag1,
            MIN(b.anzahl_nullbestand_tag1bis3) AS anzahl_nullbestand_tag1bis3,
            MIN(b.anzahl_nullbestand) AS anzahl_nullbestand
        FROM `_werbeartikel_1_kmo` AS a
        INNER JOIN `_ff_we_artbew2_kmo` AS b
            ON a.mandant_id = b.mandant_id AND a.komponente = b.art_id
        WHERE
            a.stkl_kopf_fg IN (1, 2) AND a.mandant_id = 4
        GROUP BY
            a.mandant_id,
            a.art_id
    ) AS b
    WHERE
        `_ff_we_artbew2_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew2_kmo`.art_id = b.art_id;

    UPDATE `_ff_we_artbew2_kmo` SET we_menge_ab_vorwoche = CAST(CASE WHEN we_menge_ab_vorwoche = 0.001 THEN 0.0 ELSE we_menge_ab_vorwoche END AS INT64)
    FROM (
        SELECT
            mandant_id,
            komponente AS max_komponente
        FROM `_werbeartikel_1_kmo`
        WHERE
            stkl_kopf_fg IN (2)
        GROUP BY
            mandant_id,
            max_komponente
    ) AS b
    WHERE
        `_ff_we_artbew2_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew2_kmo`.art_id = b.max_komponente;

    UPDATE `_ff_we_artbew2_kmo` SET mutter_wb_id = b.komponente, hilfe = CAST(CASE WHEN `_ff_we_artbew2_kmo`.hilfe = 0 THEN 98 ELSE `_ff_we_artbew2_kmo`.hilfe END AS INT64)
    FROM (
        SELECT
            mandant_id,
            komponente
        FROM `_werbeartikel_1_kmo`
        WHERE
            stkl_kopf_fg IN (1, 2)
        GROUP BY
            mandant_id,
            komponente
    ) AS b
    WHERE
        `_ff_we_artbew2_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew2_kmo`.art_id = b.komponente;

    UPDATE `_ff_we_artbew2_kmo` SET mutter_wb_id = b.mutter_wb_id
    FROM (
        SELECT
            a.mandant_id,
            a.art_id,
            MAX(COALESCE(a.mutter_wb_id, a.art_id)) AS mutter_wb_id
        FROM dbp_data.art_1 AS a
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                MAX(komponente) AS komponente
            FROM `_werbeartikel_1_kmo`
            WHERE
                stkl_kopf_fg IN (1, 2)
            GROUP BY
                mandant_id,
                art_id
        ) AS b
            ON a.mandant_id = b.mandant_id AND a.art_id = b.komponente
        GROUP BY
            a.mandant_id,
            a.art_id
    ) AS b
    WHERE
        `_ff_we_artbew2_kmo`.mandant_id = b.mandant_id
        AND `_ff_we_artbew2_kmo`.art_id = b.art_id
        AND `_ff_we_artbew2_kmo`.hilfe IN (98, 99);

    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew3_kmo AS
    SELECT
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        nb_id,
        MAX(posten_id) AS posten_id,
        SUM(umsatz_netto_mo) AS umsatz_netto_mo,
        SUM(umsatz_netto_di) AS umsatz_netto_di,
        SUM(umsatz_netto_mi) AS umsatz_netto_mi,
        SUM(umsatz_netto_do) AS umsatz_netto_do,
        SUM(umsatz_netto_fr) AS umsatz_netto_fr,
        SUM(umsatz_netto_sa) AS umsatz_netto_sa,
        SUM(umsatz_netto_so) AS umsatz_netto_so,
        SUM(umsatz_netto_wo) AS umsatz_netto_wo,
        SUM(menge_mo) AS menge_mo,
        SUM(menge_di) AS menge_di,
        SUM(menge_mi) AS menge_mi,
        SUM(menge_do) AS menge_do,
        SUM(menge_fr) AS menge_fr,
        SUM(menge_sa) AS menge_sa,
        SUM(menge_so) AS menge_so,
        SUM(menge_wo) AS menge_wo,
        SUM(menge_sa2) AS menge_sa2,
        SUM(CASE WHEN hilfe <> 99 THEN CAST(tage_menge_0 AS INT64) ELSE 0 END) AS tage_menge_0,
        SUM(we_menge) AS we_menge,
        SUM(menge_aktionsstart) AS menge_aktionsstart,
        SUM(we_menge_ab_vorwoche) AS we_menge_ab_vorwoche,
        MAX(hilfe) AS hilfe,
        SUM(menge_endbestand) AS menge_endbestand,
        MAX(min_sicherh_bestand) AS min_sicherh_bestand,
        MAX(faktor_flaki) AS faktor_flaki,
        MAX(wtag_id_start) AS wtag_id_start,
        MAX(wtag_id_ende) AS wtag_id_ende,
        MAX(mutter_wb_id) AS mutter_wb_id,
        SUM(CASE WHEN hilfe <> 99 THEN anzahl_nullbestand ELSE 0 END) AS anzahl_nullbestand,
        MAX(anzahl_tage_aktion) AS anzahl_tage_aktion,
        SUM(menge_historie_af) AS menge_historie_af,
        MAX(sollbestand) AS sollbestand,
        MAX(lager_prozent) AS lager_prozent,
        MAX(mhd_zeitraum) AS mhd_zeitraum,
        MAX(menge_bestand_soll_max) AS menge_bestand_soll_max,
        SUM(menge_tag1_7bis13h) AS menge_tag1_7bis13h,
        SUM(menge_nur_tag1) AS menge_nur_tag1,
        MAX(bezugsweg_id) AS bezugsweg_id,
        SUM(we_menge_vor_aktion) AS we_menge_vor_aktion,
        SUM(CASE WHEN hilfe <> 99 THEN anzahl_minusbestand ELSE 0 END) AS anzahl_minusbestand,
        MAX(anzahl_nullbestand_tag1) AS anzahl_nullbestand_tag1,
        MAX(anzahl_nullbestand_tag1bis3) AS anzahl_nullbestand_tag1bis3,
        MAX(anzahl_minusbestand_tag1) AS anzahl_minusbestand_tag1,
        MAX(anzahl_minusbestand_tag1bis3) AS anzahl_minusbestand_tag1bis3,
        MAX(avq_relevant_fg) AS avq_relevant_fg,
        MAX(anzahl_nullbestand_tag2) AS anzahl_nullbestand_tag2,
        MAX(anzahl_nullbestand_tag3) AS anzahl_nullbestand_tag3,
        MAX(anzahl_nullbestand_tag4) AS anzahl_nullbestand_tag4,
        MAX(anzahl_nullbestand_tag5) AS anzahl_nullbestand_tag5,
        MAX(anzahl_nullbestand_tag6) AS anzahl_nullbestand_tag6,
        MAX(anzahl_nullbestand_tag7) AS anzahl_nullbestand_tag7,
        MAX(vk_vor_aktion_brutto) AS vk_vor_aktion_brutto,
        MAX(vk_aktion_brutto) AS vk_aktion_brutto,
        MAX(vk_kcard_brutto) AS vk_kcard_brutto
    FROM `_ff_we_artbew2_kmo`
    GROUP BY
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id,
        nb_id;

    UPDATE `_ff_we_artbew3_kmo` AS `_ff_we_artbew3_kmo0` SET menge_aktionsstart = CAST(b.menge AS INT64)
    FROM (
        SELECT
            mandant_id,
            art_id,
            wup_id,
            DATE_ADD(dat, INTERVAL '1' DAY) AS dat_,
            SUM(menge_lgbest_erp_frei_bme) AS menge
        FROM dbp_data.marktbestand_erp_1
        WHERE
            (mandant_id, art_id, wup_id, dat) IN (
                SELECT (mandant_id, art_id, wup_id, DATE_SUB(dat_von, INTERVAL '1' DAY))
                FROM `_ff_we_artbew3_kmo`
                WHERE
                    menge_aktionsstart = 0
            )
            AND menge_lgbest_erp_frei_bme <> 0
        GROUP BY
            mandant_id,
            art_id,
            wup_id,
            dat_
    ) AS b
    WHERE
        `_ff_we_artbew3_kmo0`.mandant_id = b.mandant_id
        AND `_ff_we_artbew3_kmo0`.art_id = b.art_id
        AND `_ff_we_artbew3_kmo0`.wup_id = b.wup_id
        AND `_ff_we_artbew3_kmo0`.dat_von = b.dat_;

    DELETE FROM `_ff_we_artbew3_kmo`
    WHERE
        (mandant_id, mutter_wb_id) IN (
            SELECT (akt.mandant_id, akta.art_id)
            FROM dbp_data.aktion_1 AS akt
            INNER JOIN dbp_data.aktion_art_wup_zu_1 AS akta
                ON akt.mandant_id = akta.mandant_id AND akt.aktion_id = akta.aktion_id
            INNER JOIN dbp_data.tag_1 AS x1
                ON akt.dat_von = x1.dat
            WHERE
                akta.grund_sperrung IS NULL
                AND akt.mandant_id IN (8)
                AND INSTR(akt.aktion_id, 'J') > 0
                AND LENGTH(TRIM(akt.aktion_id)) = 9
                AND x1.akt_wo = (
                    wkw
                )
            GROUP BY
                akt.mandant_id,
            akta.art_id
        );

    DELETE FROM dbp_data.werbung_kennzahlen_woche_1
    WHERE
        (kjwo, werbe_typ_id, wup_id, art_id, mandant_id) IN (
            SELECT (kjwo, werbetyp_id, wup_id, art_id, mandant_id)
            FROM `_ff_we_artbew3_kmo`
        );

    INSERT INTO dbp_data.werbung_kennzahlen_woche_1 (
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
            x1.mandant_id,
            x1.kjwo,
            x1.wup_id,
            x1.nb_id,
            x1.art_id,
            x1.werbetyp_id AS werbe_typ_id,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_mo
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_di
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_mi
                WHEN x1.werbetyp_id IN (4, 5, 21, 22)
                    THEN x1.menge_do
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_fr
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.menge_sa
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_so
                ELSE 0
            END AS NUMERIC) AS menge_tag1,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_di
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_mi
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_do
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_fr
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_sa
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.menge_so
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_mo
                ELSE 0
            END AS NUMERIC) AS menge_tag2,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_mi
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_do
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_fr
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_sa
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_so
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.menge_mo
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_di
                ELSE 0
            END AS NUMERIC) AS menge_tag3,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_do
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_fr
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_sa
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_so
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_mo
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.menge_di
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_mi
                ELSE 0
            END AS NUMERIC) AS menge_tag4,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_fr
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_sa
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_so
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_mo
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_di
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.menge_mi
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_do
                ELSE 0
            END AS NUMERIC) AS menge_tag5,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_sa
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_so
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_mo
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_di
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_mi
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.menge_do
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_fr
                ELSE 0
            END AS NUMERIC) AS menge_tag6,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_so
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_mo
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_di
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_mi
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_do
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.menge_fr
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_sa
                ELSE 0
            END AS NUMERIC) AS menge_tag7,
            x1.menge_nur_tag1,
            x1.tage_menge_0,
            x1.menge_endbestand,
            x1.menge_aktionsstart,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_mo
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_di
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_mi
                WHEN x1.werbetyp_id IN (4, 5, 21, 22)
                    THEN x1.umsatz_netto_do
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_fr
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.umsatz_netto_sa
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_so
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag1,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_di
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_mi
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_do
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_fr
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_sa
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.umsatz_netto_so
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_mo
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag2,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_mi
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_do
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_fr
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_sa
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_so
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.umsatz_netto_mo
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_di
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag3,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_do
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_fr
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_sa
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_so
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_mo
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.umsatz_netto_di
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_mi
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag4,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_fr
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_sa
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_so
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_mo
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_di
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.umsatz_netto_mi
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_do
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag5,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_sa
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_so
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_mo
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_di
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_mi
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.umsatz_netto_do
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_fr
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag6,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_so
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_mo
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_di
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_mi
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_do
                WHEN x1.werbetyp_id IN (9, 16, 30)
                    THEN x1.umsatz_netto_fr
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_sa
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag7,
            x1.we_menge,
            x1.min_sicherh_bestand,
            x1.posten_id,
            x1.we_menge_ab_vorwoche AS we_menge_zentral,
            x1.faktor_flaki,
            COALESCE(x1.mutter_wb_id, x1.art_id) AS mutter_wb_id,
            x1.wtag_id_start,
            x1.wtag_id_ende,
            x1.menge_historie_af,
            CAST(CASE
                WHEN x1.anzahl_tage_aktion < x1.anzahl_nullbestand
                    THEN x1.anzahl_tage_aktion
                ELSE x1.anzahl_nullbestand
            END AS INT64) AS anzahl_nullbestand,
            CAST(x1.anzahl_tage_aktion AS INT64) AS anzahl_tage_aktion,
            x1.menge_tag1_7bis13h,
            CAST(x1.lager_prozent AS INT64),
            CAST(x1.mhd_zeitraum AS INT64),
            x1.sollbestand,
            x1.menge_bestand_soll_max,
            0 AS werbenachvermarktung_fg,
            x1.we_menge_vor_aktion,
            CAST(x1.bezugsweg_id AS INT64),
            CAST(x1.anzahl_nullbestand_tag1 AS INT64) AS anzahl_nullbestand_tag1,
            CAST(x1.anzahl_nullbestand_tag2 AS INT64) AS anzahl_nullbestand_tag2,
            CAST(x1.anzahl_nullbestand_tag3 AS INT64) AS anzahl_nullbestand_tag3,
            CAST(x1.anzahl_nullbestand_tag4 AS INT64) AS anzahl_nullbestand_tag4,
            CAST(x1.anzahl_nullbestand_tag5 AS INT64) AS anzahl_nullbestand_tag5,
            CAST(x1.anzahl_nullbestand_tag6 AS INT64) AS anzahl_nullbestand_tag6,
            CAST(x1.anzahl_nullbestand_tag7 AS INT64) AS anzahl_nullbestand_tag7,
            CAST(x1.anzahl_nullbestand_tag1bis3 AS INT64) AS anzahl_nullbestand_tag1bis3,
            CAST(x1.anzahl_minusbestand AS INT64) AS anzahl_minusbestand,
            CAST(x1.anzahl_minusbestand_tag1 AS INT64) AS anzahl_minusbestand_tag1,
            CAST(x1.anzahl_minusbestand_tag1bis3 AS INT64) AS anzahl_minusbestand_tag1bis3,
            x1.avq_relevant_fg,
            x2.default_wrg AS wrg_id,
            CAST(x1.menge_sa2 AS NUMERIC) AS menge_sa2,
            x1.vk_vor_aktion_brutto,
            x1.vk_aktion_brutto,
            x1.vk_kcard_brutto,
            CURRENT_TIMESTAMP(),
            CURRENT_TIMESTAMP()
        FROM `_ff_we_artbew3_kmo` AS x1
        INNER JOIN dbp_data.mandant_1 AS x2
            ON x1.mandant_id = x2.mandant_id
        GROUP BY
            x1.kjwo,
            x1.wup_id,
            x1.nb_id,
            x1.mandant_id,
            x1.art_id,
            werbe_typ_id,
            menge_tag1,
            menge_tag2,
            menge_tag3,
            menge_tag4,
            menge_tag5,
            menge_tag6,
            menge_tag7,
            x1.tage_menge_0,
            x1.menge_endbestand,
            x1.menge_aktionsstart,
            umsatz_netto_tag1,
            umsatz_netto_tag2,
            umsatz_netto_tag3,
            umsatz_netto_tag4,
            umsatz_netto_tag5,
            umsatz_netto_tag6,
            umsatz_netto_tag7,
            x1.we_menge,
            x1.min_sicherh_bestand,
            x1.posten_id,
            we_menge_zentral,
            x1.faktor_flaki,
            mutter_wb_id,
            x1.wtag_id_start,
            x1.wtag_id_ende,
            x1.menge_historie_af,
            anzahl_nullbestand,
            x1.anzahl_tage_aktion,
            x1.menge_tag1_7bis13h,
            x1.menge_nur_tag1,
            x1.lager_prozent,
            x1.mhd_zeitraum,
            x1.sollbestand,
            x1.menge_bestand_soll_max,
            werbenachvermarktung_fg,
            x1.bezugsweg_id,
            x1.we_menge_vor_aktion,
            x1.anzahl_nullbestand_tag1,
            x1.anzahl_nullbestand_tag1bis3,
            x1.anzahl_minusbestand,
            x1.anzahl_minusbestand_tag1,
            x1.anzahl_minusbestand_tag1bis3,
            x1.avq_relevant_fg,
            wrg_id,
            x1.anzahl_nullbestand_tag2,
            x1.anzahl_nullbestand_tag3,
            x1.anzahl_nullbestand_tag4,
            x1.anzahl_nullbestand_tag5,
            x1.anzahl_nullbestand_tag6,
            x1.anzahl_nullbestand_tag7,
            x1.vk_vor_aktion_brutto,
            x1.vk_aktion_brutto,
            x1.vk_kcard_brutto,
            x1.menge_sa2,
            CURRENT_TIMESTAMP()
    );

    CREATE OR REPLACE TEMPORARY TABLE _not_in1_kmo AS
    SELECT *
    FROM `_werbeartikel_1_kmo`
    WHERE
        NOT (kjwo, wup_id, mandant_id, art_id, werbetyp_id) IN (
            SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
            FROM `_ff_we_artbew2_kmo`
        );

    CREATE OR REPLACE TEMPORARY TABLE _ff_we1_kmo_not_in AS
    SELECT
        a.mandant_id,
        a.kjwo,
        a.dat_von,
        a.dat_bis,
        a.werbetyp_id,
        a.wup_id,
        a.art_id
    FROM `_not_in1_kmo` AS a
    INNER JOIN dbp_data.art_wg_zu_per_1 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.art_id = b.art_id
            AND b.arthiertyp_id = 2
            AND b.dat_bis = CAST('9999-12-31' AS DATE);

    CREATE OR REPLACE TEMPORARY TABLE _ff_we2_kmo_not_in AS
    SELECT
        a.mandant_id,
        a.kjwo,
        a.dat_von,
        a.dat_bis,
        a.werbetyp_id,
        a.wup_id,
        a.art_id,
        b.dat,
        DATE_SUB(b.dat, INTERVAL '7' DAY) AS dat_2
    FROM `_ff_we1_kmo_not_in` AS a
    INNER JOIN (
        SELECT
            a0.kjwo,
            a0.werbetyp_id,
            b.dat
        FROM `_ff_we1_kmo_not_in` AS a0
        INNER JOIN dbp_data.tag_1 AS b
            ON b.dat BETWEEN a0.dat_von AND a0.dat_bis
        GROUP BY
            a0.kjwo,
            a0.werbetyp_id,
            b.dat
    ) AS b
        ON a.kjwo = b.kjwo AND a.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we3_kmo_not_in AS
    SELECT
        a.mandant_id,
        a.werbetyp_id,
        a.dat_von,
        a.dat_bis,
        a.kjwo,
        a.dat,
        a.wup_id,
        a.art_id,
        COALESCE(b.menge_lagerbew_bme, 0) AS we_menge,
        COALESCE(c.menge_lagerbew_bme, 0) AS we_menge_2
    FROM `_ff_we2_kmo_not_in` AS a
    LEFT JOIN (
        SELECT
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            b.dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_1 AS a
        INNER JOIN dbp_data.lagerbew_det_1 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN `_ff_we2_kmo_not_in` AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_1 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_1 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id IN ('WE', 'WL')
            AND CASE
                WHEN
                    a.mandant_id IN (4)
                    AND c1.bestellart_id IN (
                        'UBPX',
                        'UBP',
                        'UBP1',
                        'NBP',
                        'NBBG',
                        'UB2',
                        'UBE',
                        'NBCZ',
                        'NBPL',
                        'NBSK',
                        'NBHR',
                        'NBRO',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'NZP',
                        'NZP1',
                        'NBMD',
                        'UBP0',
                        'ZUBZ'
                    )
                    OR a.mandant_id IN (2, 3, 5, 6, 7, 8)
                    AND c1.bestellart_id IN (
                        'UBPX',
                        'UBP',
                        'UBP1',
                        'NBP',
                        'NBBG',
                        'UB2',
                        'UBE',
                        'NBCZ',
                        'NBPL',
                        'NBSK',
                        'NBHR',
                        'NBRO',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'NZP',
                        'NZP1',
                        'NBMD',
                        'UBP0'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND a.mandant_id > 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_kmo_not_in`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo_not_in`
                WHERE
                    NOT dat IS NULL
            )
            AND /* b.betrag_einstandspreis IS NULL AND */ NOT b.lager_bewart_id /* rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten. */ /* Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten */ /* "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_1 */ /* Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes */ /* -dbay-, 25.05.2018 */ IN ('301', '302', '311', '312', '641', '642', '647', '648')
            AND NOT x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 26 AND mandant_id > 1
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
        FROM dbp_data.lagerbew_1 AS a
        INNER JOIN dbp_data.lagerbew_det_1 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN `_ff_we2_kmo_not_in` AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_1 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_1 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id IN ('WE', 'WL')
            AND x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 26 AND mandant_id > 1
            )
            AND a.mandant_id > 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_kmo_not_in`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo_not_in`
                WHERE
                    NOT dat IS NULL
            )
            AND /* b.betrag_einstandspreis IS NULL AND */ NOT b.lager_bewart_id /* rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten. */ /* Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten */ /* "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_1 */ /* Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes */ /* -dbay-, 25.05.2018 */ IN ('301', '302', '311', '312', '641', '642', '647', '648')
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
        FROM dbp_data.lagerbew_1 AS a
        INNER JOIN dbp_data.lagerbew_det_1 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN `_ff_we2_kmo_not_in` AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_1 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_1 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id IN ('WE', 'WL')
            AND CASE
                WHEN
                    a.mandant_id IN (4)
                    AND c1.bestellart_id IN (
                        'UBPX',
                        'UBP',
                        'UBP1',
                        'NBP',
                        'NBBG',
                        'UB2',
                        'UBE',
                        'NBCZ',
                        'NBPL',
                        'NBSK',
                        'NBHR',
                        'NBRO',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'NZP',
                        'NZP1',
                        'NBMD',
                        'UBP0',
                        'ZUBZ'
                    )
                    OR a.mandant_id IN (2, 3, 5, 6, 7, 8)
                    AND c1.bestellart_id IN (
                        'UBPX',
                        'UBP',
                        'UBP1',
                        'NBP',
                        'NBBG',
                        'UB2',
                        'UBE',
                        'NBCZ',
                        'NBPL',
                        'NBSK',
                        'NBHR',
                        'NBRO',
                        'UBGK',
                        'UBG1',
                        'UBG2',
                        'NZP',
                        'NZP1',
                        'NBMD',
                        'UBP0'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND a.mandant_id > 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_kmo_not_in`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo_not_in`
                WHERE
                    NOT dat IS NULL
            )
            AND /* b.betrag_einstandspreis IS NULL AND */ NOT b.lager_bewart_id /* rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten. */ /* Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten */ /* "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_1 */ /* Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes */ /* -dbay-, 25.05.2018 */ IN ('301', '302', '311', '312', '641', '642', '647', '648')
            AND NOT x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 26 AND mandant_id > 1
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
        FROM dbp_data.lagerbew_1 AS a
        INNER JOIN dbp_data.lagerbew_det_1 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN `_ff_we2_kmo_not_in` AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_1 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_1 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id IN ('WE', 'WL')
            AND x.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 26 AND mandant_id > 1
            )
            AND a.mandant_id > 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_kmo_not_in`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo_not_in`
                WHERE
                    NOT dat IS NULL
            )
            AND /* b.betrag_einstandspreis IS NULL AND */ NOT b.lager_bewart_id /* rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten. */ /* Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten */ /* "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_1 */ /* Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes */ /* -dbay-, 25.05.2018 */ IN ('301', '302', '311', '312', '641', '642', '647', '648')
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
        FROM dbp_data.lagerbew_1 AS a
        INNER JOIN dbp_data.lagerbew_det_1 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
                AND a.dat_buch = b.dat_buch
        INNER JOIN `_ff_we2_kmo_not_in` AS c
            ON
                b.mandant_id = c.mandant_id
                AND b.wup_id = c.wup_id
                AND b.art_id = c.art_id
                AND b.dat_buch = DATE_SUB(c.dat_2, INTERVAL '7' DAY)
        INNER JOIN dbp_data.art_wg_zu_per_1 AS x
            ON
                b.mandant_id = x.mandant_id
                AND b.art_id = x.art_id
                AND x.arthiertyp_id = 2
                AND x.dat_bis = CAST('9999-12-31' AS DATE)
        INNER JOIN dbp_data.besch_best_1 AS c1
            ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
        INNER JOIN dbp_data.besch_best_det_1 AS c2
            ON
                b.mandant_id = c2.mandant_id
                AND b.wup_id = c2.wup_id
                AND c1.dat_best_beleg = c2.dat_best_beleg
                AND b.best_beleg_id = c2.best_beleg_id
                AND b.best_beleg_pos_id = c2.best_beleg_pos_id
                AND b.art_id = c2.art_id
        WHERE
            a.vorgangsart_id IN ('WE', 'WL')
            AND (x.mandant_id, x.wg_id) IN (
                SELECT (mandant_id, wg_id)
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 30 AND mandant_id > 1
            )
            AND a.mandant_id > 1
            AND a.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL '7' DAY)
                FROM `_ff_we2_kmo_not_in`
                WHERE
                    NOT dat_2 IS NULL
            ) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo_not_in`
                WHERE
                    NOT dat IS NULL
            )
            AND /* b.betrag_einstandspreis IS NULL AND */ NOT b.lager_bewart_id /* rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten. */ /* Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten */ /* "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_1 */ /* Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes */ /* -dbay-, 25.05.2018 */ IN ('301', '302', '311', '312', '641', '642', '647', '648')
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
            AND a.dat = DATE_ADD(c.dat_buch, INTERVAL '7' DAY)
            AND a.werbetyp_id = c.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _x_ray_kmo_not_in AS
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
        FROM `_ff_we2_kmo_not_in`
        GROUP BY
            mandant_id,
            werbetyp_id,
            wup_id,
            dat,
            dat_2
    ) AS a
    INNER JOIN (
        SELECT kopf_art
        FROM `_stpo_kmo`
        WHERE
            NOT kopf_art IN (
                SELECT art_id
                FROM `_ff_we_artbew2_kmo`
            )
        GROUP BY
            kopf_art
    ) AS b
        ON TRUE;

    CREATE OR REPLACE TEMPORARY TABLE _help_me11_kmo AS
    SELECT
        mandant_id,
        dat
    FROM `_x_ray_kmo_not_in`
    GROUP BY
        mandant_id,
        dat;

    CREATE OR REPLACE TEMPORARY TABLE _help_me22_kmo AS
    SELECT
        mandant_id,
        dat_2
    FROM `_x_ray_kmo_not_in`
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
    FROM dbp_data.lagerbew_1 AS a
    INNER JOIN dbp_data.lagerbew_det_1 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
            AND a.dat_buch = b.dat_buch
    INNER JOIN dbp_data.besch_best_1 AS c1
        ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
    INNER JOIN dbp_data.besch_best_det_1 AS c2
        ON
            b.mandant_id = c2.mandant_id
            AND b.wup_id = c2.wup_id
            AND c1.dat_best_beleg = c2.dat_best_beleg
            AND b.best_beleg_id = c2.best_beleg_id
            AND b.best_beleg_pos_id = c2.best_beleg_pos_id
            AND b.art_id = c2.art_id
    WHERE
        a.vorgangsart_id IN ('WE', 'WL')
        AND CASE
            WHEN
                a.mandant_id IN (4)
                AND c1.bestellart_id IN (
                    'UBPX',
                    'UBP',
                    'UBP1',
                    'NBP',
                    'NBBG',
                    'UB2',
                    'UBE',
                    'NBCZ',
                    'NBPL',
                    'NBSK',
                    'NBHR',
                    'NBRO',
                    'UBGK',
                    'UBG1',
                    'UBG2',
                    'NZP',
                    'NZP1',
                    'NBMD',
                    'UBP0',
                    'ZUBZ'
                )
                OR a.mandant_id IN (2, 3, 5, 6, 7, 8)
                AND c1.bestellart_id IN (
                    'UBPX',
                    'UBP',
                    'UBP1',
                    'NBP',
                    'NBBG',
                    'UB2',
                    'UBE',
                    'NBCZ',
                    'NBPL',
                    'NBSK',
                    'NBHR',
                    'NBRO',
                    'UBGK',
                    'UBG1',
                    'UBG2',
                    'NZP',
                    'NZP1',
                    'NBMD',
                    'UBP0'
                )
                THEN 1
            ELSE 0
        END = 1
        AND a.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me11_kmo`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me22_kmo`
            ) AS t3
        )
        AND a.mandant_id > 1
        AND NOT b.lager_bewart_id IN ('301', '302', '311', '312', '641', '642', '647', '648');

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
    FROM dbp_data.lagerbew_1 AS a
    INNER JOIN dbp_data.lagerbew_det_1 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
            AND a.dat_buch = b.dat_buch
    INNER JOIN dbp_data.besch_best_1 AS c1
        ON b.mandant_id = c1.mandant_id AND b.best_beleg_id = c1.best_beleg_id
    INNER JOIN dbp_data.besch_best_det_1 AS c2
        ON
            b.mandant_id = c2.mandant_id
            AND b.wup_id = c2.wup_id
            AND c1.dat_best_beleg = c2.dat_best_beleg
            AND b.best_beleg_id = c2.best_beleg_id
            AND b.best_beleg_pos_id = c2.best_beleg_pos_id
            AND b.art_id = c2.art_id
    WHERE
        a.vorgangsart_id IN ('WE', 'WL')
        AND a.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me11_kmo`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me22_kmo`
            ) AS t3
        )
        AND a.mandant_id > 1
        AND NOT b.lager_bewart_id IN ('301', '302', '311', '312', '641', '642', '647', '648');

    CREATE OR REPLACE TEMPORARY TABLE _x_track1_kmo_not_in AS
    SELECT
        a.mandant_id,
        c.werbetyp_id,
        a.lagerbew_beleg_id,
        a.wup_id,
        a.art_id,
        a.dat_buch,
        SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_ekpo_not_in` AS a
    INNER JOIN `_x_ray_kmo_not_in` AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat
    INNER JOIN dbp_data.art_wg_zu_per_1 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat)
            FROM `_help_me11_kmo`
        )
        AND NOT x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_1
            WHERE
                wg_filter_id = 26 AND mandant_id > 1
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
    INNER JOIN `_x_ray_kmo_not_in` AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat
    INNER JOIN dbp_data.art_wg_zu_per_1 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_1
            WHERE
                wg_filter_id = 26 AND mandant_id > 1
        )
        AND (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat)
            FROM `_help_me11_kmo`
        )
    GROUP BY
        a.mandant_id,
        a.lagerbew_beleg_id,
        a.art_id,
        a.wup_id,
        a.dat_buch,
        c.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _x_track2_kmo_not_in AS
    SELECT
        a.mandant_id,
        c.werbetyp_id,
        a.lagerbew_beleg_id,
        a.wup_id,
        a.art_id,
        a.dat_buch,
        SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_ekpo_not_in` AS a
    INNER JOIN `_x_ray_kmo_not_in` AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per_1 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat_2)
            FROM `_help_me22_kmo`
        )
        AND NOT x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_1
            WHERE
                wg_filter_id = 26 AND mandant_id > 1
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
    INNER JOIN `_x_ray_kmo_not_in` AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.art_id = c.art_id
            AND a.dat_buch = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per_1 AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.art_id = x.art_id
            AND x.arthiertyp_id = 2
            AND x.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        x.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_1
            WHERE
                wg_filter_id = 26 AND mandant_id > 1
        )
        AND (a.mandant_id, a.dat_buch) IN (
            SELECT (mandant_id, dat_2)
            FROM `_help_me22_kmo`
        )
    GROUP BY
        a.mandant_id,
        a.lagerbew_beleg_id,
        a.art_id,
        a.wup_id,
        a.dat_buch,
        c.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _murks_display_not_in AS
    SELECT
        c.mandant_id,
        c.werbetyp_id,
        c.lagerbew_beleg_id,
        c.wup_id,
        b.art_id,
        c.dat_buch
    FROM dbp_data.stueckliste_1 AS a
    INNER JOIN dbp_data.stueckliste_det_1 AS b
        ON a.mandant_id = b.mandant_id AND a.stueckliste_id = b.stueckliste_id
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            lagerbew_beleg_id,
            wup_id,
            art_id,
            dat_buch
        FROM `_x_track1_kmo_not_in`
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
        FROM `_x_track2_kmo_not_in`
        GROUP BY
            mandant_id,
            werbetyp_id,
            lagerbew_beleg_id,
            wup_id,
            art_id,
            dat_buch
    ) AS c
        ON a.mandant_id = c.mandant_id AND a.art_id = c.art_id
    WHERE
        a.dat_bis = CAST('9999-12-31' AS DATE)
    GROUP BY
        c.mandant_id,
        c.werbetyp_id,
        c.lagerbew_beleg_id,
        c.wup_id,
        b.art_id,
        c.dat_buch;

    CREATE OR REPLACE TEMPORARY TABLE _display_update_kmo_not_in AS
    SELECT
        b.mandant_id,
        c.werbetyp_id,
        b.wup_id,
        b.art_id,
        b.dat_buch,
        SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM dbp_data.lagerbew_1 AS a
    INNER JOIN dbp_data.lagerbew_det_1 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.lagerbew_beleg_id = b.lagerbew_beleg_id
            AND a.dat_buch = b.dat_buch
    INNER JOIN `_murks_display_not_in` AS c
        ON
            b.mandant_id = c.mandant_id
            AND b.wup_id = c.wup_id
            AND b.art_id = c.art_id
            AND b.dat_buch = c.dat_buch
    WHERE
        a.vorgangsart_id IN ('WE', 'WL')
        AND a.dat_buch >= (
            SELECT MIN(dat_buch)
            FROM `_murks_display_not_in`
        )
        AND /* b.betrag_einstandspreis IS NULL AND */ NOT b.lager_bewart_id /* rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten. */ /* Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten */ /* "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_1 */ /* Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes */ /* -dbay-, 25.05.2018 */ IN ('301', '302', '311', '312', '641', '642', '647', '648')
    GROUP BY
        b.mandant_id,
        c.werbetyp_id,
        b.wup_id,
        b.art_id,
        b.dat_buch;

    UPDATE `_ff_we3_kmo_not_in` SET we_menge = b.menge_lagerbew_bme + `_ff_we3_kmo_not_in`.we_menge
    FROM (
        SELECT
            a.mandant_id,
            a.werbetyp_id,
            a.wup_id,
            a.art_id,
            a.dat_buch,
            a.menge_lagerbew_bme
        FROM `_display_update_kmo_not_in` AS a
        INNER JOIN (
            SELECT
                mandant_id,
                werbetyp_id,
                MIN(dat_von) AS dat_von,
                MAX(dat_bis) AS dat_bis
            FROM `_werbeartikel_1_kmo`
            GROUP BY
                werbetyp_id,
                mandant_id
        ) AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.werbetyp_id = b.werbetyp_id
                AND a.dat_buch BETWEEN b.dat_von AND b.dat_bis
    ) AS b
    WHERE
        `_ff_we3_kmo_not_in`.mandant_id = b.mandant_id
        AND `_ff_we3_kmo_not_in`.wup_id = b.wup_id
        AND `_ff_we3_kmo_not_in`.art_id = b.art_id
        AND `_ff_we3_kmo_not_in`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_kmo_not_in`.dat = b.dat_buch;

    UPDATE `_ff_we3_kmo_not_in` SET we_menge_2 = b.menge_lagerbew_bme + `_ff_we3_kmo_not_in`.we_menge_2
    FROM `_display_update_kmo_not_in` AS b
    WHERE
        `_ff_we3_kmo_not_in`.mandant_id = b.mandant_id
        AND `_ff_we3_kmo_not_in`.wup_id = b.wup_id
        AND `_ff_we3_kmo_not_in`.art_id = b.art_id
        AND `_ff_we3_kmo_not_in`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_kmo_not_in`.dat = DATE_ADD(b.dat_buch, INTERVAL '7' DAY);

    CREATE OR REPLACE TEMPORARY TABLE _ff_we4_kmo_not_in AS
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
    FROM `_ff_we3_kmo_not_in` AS a
    GROUP BY
        kjwo,
        werbetyp_id,
        dat_von,
        dat_bis,
        wup_id,
        mandant_id,
        art_id;

    CREATE OR REPLACE TEMPORARY TABLE _mbst_we1_kmo_not_in AS
    SELECT
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        SUM(COALESCE(u.menge_lgbest_erp_frei_bme, 0)) AS menge_aktionsstart
    FROM `_ff_we4_kmo_not_in` AS v
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            DATE_SUB(dat_von, INTERVAL '1' DAY) AS dat_von,
            kjwo
        FROM `_werbeartikel_1_kmo`
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
    LEFT JOIN dbp_data.marktbestand_erp_1 AS u
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

    UPDATE `_ff_we4_kmo_not_in` SET menge_aktionsstart = CAST(b.menge_aktionsstart AS INT64)
    FROM (
        SELECT *
        FROM `_mbst_we1_kmo_not_in`
        WHERE
            menge_aktionsstart <> 0
    ) AS b
    WHERE
        `_ff_we4_kmo_not_in`.mandant_id = b.mandant_id
        AND `_ff_we4_kmo_not_in`.wup_id = b.wup_id
        AND `_ff_we4_kmo_not_in`.art_id = b.art_id
        AND `_ff_we4_kmo_not_in`.kjwo = b.kjwo
        AND `_ff_we4_kmo_not_in`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art_kmo_not_in AS
    SELECT
        mandant_id,
        art_id,
        COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
    FROM dbp_data.art_1 AS a
    WHERE
        dat_bis = CAST('9999-12-31' AS DATE)
        AND (mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM `_not_in1_kmo`
            GROUP BY
                mandant_id,
            art_id
        )
    GROUP BY
        mandant_id,
        art_id,
        a.mutter_wb_id;

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst1_kmo_not_in AS
    SELECT
        v.kjwo,
        v.werbetyp_id,
        v.dat_von,
        v.dat_bis,
        v.wup_id,
        v.mandant_id,
        v.art_id,
        SUM(COALESCE(u.menge_lgbest_erp_frei_bme, 0)) AS menge_endbestand
    FROM `_ff_we4_kmo_not_in` AS v
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            dat_bis,
            kjwo
        FROM `_werbeartikel_1_kmo`
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
    LEFT JOIN dbp_data.marktbestand_erp_1 AS u
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

    CREATE OR REPLACE TEMPORARY TABLE _ff_we5_kmo_not_in AS
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
    FROM `_ff_we4_kmo_not_in` AS a
    INNER JOIN `_test_we_mbst1_kmo_not_in` AS b
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

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2_kmo_not_in AS
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
    FROM `_ff_we4_kmo_not_in` AS v
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
        FROM `_werbeartikel_1_kmo` AS a
        INNER JOIN dbp_data.tag_1 AS b
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
    INNER JOIN dbp_data.art_1 AS xx
        ON v.mandant_id = xx.mandant_id AND v.art_id = xx.art_id
    LEFT JOIN dbp_data.marktbestand_erp_1 AS x
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

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2a_kmo_not_in AS
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
    FROM `_ff_we4_kmo_not_in` AS v
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
        FROM `_werbeartikel_1_kmo` AS a
        INNER JOIN dbp_data.tag_1 AS b
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
    INNER JOIN dbp_data.art_1 AS xx
        ON v.mandant_id = xx.mandant_id AND v.art_id = xx.art_id
    LEFT JOIN dbp_data.marktbestand_erp_1 AS x
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

        /* Anzahl Nullbestand Tag_1 2 */
    UPDATE `_test_we_mbst2a_kmo_not_in` SET anz_null_tag2 = b.anz_null_tag2
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
        FROM dbp_data.marktbestand_erp_1 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.tag_1 AS b
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
        INNER JOIN dbp_data.art_1 AS xx
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
        `_test_we_mbst2a_kmo_not_in`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_kmo_not_in`.wup_id = b.wup_id
        AND `_test_we_mbst2a_kmo_not_in`.art_id = b.art_id
        AND `_test_we_mbst2a_kmo_not_in`.dat_von = b.dat_von
        AND `_test_we_mbst2a_kmo_not_in`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_kmo_not_in`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_1 3 */
    UPDATE `_test_we_mbst2a_kmo_not_in` SET anz_null_tag3 = b.anz_null_tag3
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
        FROM dbp_data.marktbestand_erp_1 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.tag_1 AS b
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
        INNER JOIN dbp_data.art_1 AS xx
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
        `_test_we_mbst2a_kmo_not_in`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_kmo_not_in`.wup_id = b.wup_id
        AND `_test_we_mbst2a_kmo_not_in`.art_id = b.art_id
        AND `_test_we_mbst2a_kmo_not_in`.dat_von = b.dat_von
        AND `_test_we_mbst2a_kmo_not_in`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_kmo_not_in`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_1 4 */
    UPDATE `_test_we_mbst2a_kmo_not_in` SET anz_null_tag4 = b.anz_null_tag4
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
        FROM dbp_data.marktbestand_erp_1 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.tag_1 AS b
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
        INNER JOIN dbp_data.art_1 AS xx
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
        `_test_we_mbst2a_kmo_not_in`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_kmo_not_in`.wup_id = b.wup_id
        AND `_test_we_mbst2a_kmo_not_in`.art_id = b.art_id
        AND `_test_we_mbst2a_kmo_not_in`.dat_von = b.dat_von
        AND `_test_we_mbst2a_kmo_not_in`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_kmo_not_in`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_1 5 */
    UPDATE `_test_we_mbst2a_kmo_not_in` SET anz_null_tag5 = b.anz_null_tag5
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
        FROM dbp_data.marktbestand_erp_1 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.tag_1 AS b
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
        INNER JOIN dbp_data.art_1 AS xx
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
        `_test_we_mbst2a_kmo_not_in`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_kmo_not_in`.wup_id = b.wup_id
        AND `_test_we_mbst2a_kmo_not_in`.art_id = b.art_id
        AND `_test_we_mbst2a_kmo_not_in`.dat_von = b.dat_von
        AND `_test_we_mbst2a_kmo_not_in`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_kmo_not_in`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_1 6 */
    UPDATE `_test_we_mbst2a_kmo_not_in` SET anz_null_tag6 = b.anz_null_tag6
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
        FROM dbp_data.marktbestand_erp_1 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.tag_1 AS b
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
        INNER JOIN dbp_data.art_1 AS xx
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
        `_test_we_mbst2a_kmo_not_in`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_kmo_not_in`.wup_id = b.wup_id
        AND `_test_we_mbst2a_kmo_not_in`.art_id = b.art_id
        AND `_test_we_mbst2a_kmo_not_in`.dat_von = b.dat_von
        AND `_test_we_mbst2a_kmo_not_in`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_kmo_not_in`.werbetyp_id = b.werbetyp_id;

        /* Anzahl Nullbestand Tag_1 7 */
    UPDATE `_test_we_mbst2a_kmo_not_in` SET anz_null_tag7 = b.anz_null_tag7
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
        FROM dbp_data.marktbestand_erp_1 AS a
        INNER JOIN (
            SELECT
                a0.mandant_id,
                a0.werbetyp_id,
                a0.wup_id,
                a0.art_id,
                a0.dat_von,
                a0.dat_bis,
                b.dat
            FROM `_werbeartikel_1_kmo` AS a0
            INNER JOIN dbp_data.tag_1 AS b
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
        INNER JOIN dbp_data.art_1 AS xx
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
        `_test_we_mbst2a_kmo_not_in`.mandant_id = b.mandant_id
        AND `_test_we_mbst2a_kmo_not_in`.wup_id = b.wup_id
        AND `_test_we_mbst2a_kmo_not_in`.art_id = b.art_id
        AND `_test_we_mbst2a_kmo_not_in`.dat_von = b.dat_von
        AND `_test_we_mbst2a_kmo_not_in`.dat_bis = b.dat_bis
        AND `_test_we_mbst2a_kmo_not_in`.werbetyp_id = b.werbetyp_id;

    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2b_kmo_not_in AS
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
    FROM `_ff_we4_kmo_not_in` AS v
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
        FROM `_werbeartikel_1_kmo` AS a
        INNER JOIN dbp_data.tag_1 AS b
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
    INNER JOIN dbp_data.art_1 AS xx
        ON v.mandant_id = xx.mandant_id AND v.art_id = xx.art_id
    LEFT JOIN dbp_data.marktbestand_erp_1 AS x
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

    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew1_kmo_not_in (
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
        hilfe NUMERIC(29, 3) NOT NULL,
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

    INSERT INTO `_ff_we_artbew1_kmo_not_in` (
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
        anzahl_nullbestand_tag1bis3
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
            7 AS tage_menge_0,
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
            0 AS anzahl_nullbestand_tag1bis3
        FROM `_not_in1_kmo`
    );

    UPDATE `_ff_we_artbew1_kmo_not_in` SET we_menge = b.we_menge, we_menge_ab_vorwoche = b.we_menge_ab_vorwoche, we_menge_vor_aktion = b.we_menge_vor_aktion, bezugsweg_id = b.bezugsweg_id, menge_aktionsstart = b.menge_aktionsstart, menge_endbestand = b.menge_endbestand, min_sicherh_bestand = b.min_sicherh_bestand, sollbestand = b.sollbestand
    FROM (
        SELECT
            a.kjwo,
            a.werbetyp_id,
            MIN(a.dat_von) AS dat_von,
            MAX(a.dat_bis) AS dat_bis,
            a.mandant_id,
            a.wup_id,
            a.art_id,
            MAX(a.we_menge) AS we_menge,
            MAX(a.we_menge_ab_vorwoche) AS we_menge_ab_vorwoche,
            MAX(a.we_menge_ab_vorwoche) AS we_menge_vor_aktion,
            MAX(a.menge_aktionsstart) AS menge_aktionsstart,
            MAX(a.menge_endbestand) AS menge_endbestand,
            MAX(f.min_sicherh_bestand) AS min_sicherh_bestand,
            MAX(f.sollbestand) AS sollbestand,
            MAX(f.bezugsweg_id) AS bezugsweg_id
        FROM `_ff_we5_kmo_not_in` AS a
        LEFT JOIN dbp_data.art_wup_status_per_1 AS f
            ON
                a.mandant_id = f.mandant_id
                AND a.wup_id = f.wup_id
                AND a.art_id = f.art_id
                AND f.dat_bis = CAST('9999-12-31' AS DATE)
        GROUP BY
            a.kjwo,
            a.werbetyp_id,
            a.mandant_id,
            a.wup_id,
            a.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo_not_in`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo_not_in` SET mhd_zeitraum = b.mhd_zeitraum, lager_prozent = b.lager_prozent
    FROM (
        SELECT
            a.kjwo,
            a.werbetyp_id,
            MIN(a.dat_von) AS dat_von,
            MAX(a.dat_bis) AS dat_bis,
            a.mandant_id,
            a.wup_id,
            a.art_id,
            MAX(f.mhd_zeitraum) AS mhd_zeitraum,
            MAX(f.lager_prozent) AS lager_prozent
        FROM `_ff_we5_kmo_not_in` AS a
        LEFT JOIN dbp_data.art_1 AS f
            ON a.mandant_id = f.mandant_id AND a.art_id = f.art_id
        GROUP BY
            a.kjwo,
            a.werbetyp_id,
            a.mandant_id,
            a.wup_id,
            a.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo_not_in`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo_not_in` SET menge_bestand_soll_max = b.menge_bestand_soll_max
    FROM (
        SELECT
            a.kjwo,
            a.werbetyp_id,
            MIN(a.dat_von) AS dat_von,
            MAX(a.dat_bis) AS dat_bis,
            a.mandant_id,
            a.wup_id,
            a.art_id,
            MAX(f.menge_bestand_soll_max) AS menge_bestand_soll_max
        FROM `_ff_we5_kmo_not_in` AS a
        LEFT JOIN dbp_data.art_wup_nachschub_per_1 AS f
            ON
                a.mandant_id = f.mandant_id
                AND a.wup_id = f.wup_id
                AND a.art_id = f.art_id
                AND f.dat_bis = CAST('9999-12-31' AS DATE)
        GROUP BY
            a.kjwo,
            a.werbetyp_id,
            a.mandant_id,
            a.wup_id,
            a.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo_not_in`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo_not_in` SET anzahl_nullbestand = b.anz_tage_null, anzahl_minusbestand = b.anz_tage_minus
    FROM (
        SELECT
            kjwo,
            werbetyp_id,
            wup_id,
            mandant_id,
            art_id,
            MIN(dat_von) AS dat_von,
            MAX(dat_bis) AS dat_bis,
            MAX(anz_tage_null) AS anz_tage_null,
            MAX(anz_tage_minus) AS anz_tage_minus
        FROM `_test_we_mbst2_kmo_not_in`
        GROUP BY
            kjwo,
            werbetyp_id,
            wup_id,
            mandant_id,
            art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo_not_in`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo_not_in` SET anzahl_nullbestand_tag1 = b.anz_null_tag1, anzahl_minusbestand_tag1 = b.anz_minus_tag1, anzahl_nullbestand_tag2 = b.anz_null_tag2, anzahl_nullbestand_tag3 = b.anz_null_tag3, anzahl_nullbestand_tag4 = b.anz_null_tag4, anzahl_nullbestand_tag5 = b.anz_null_tag5, anzahl_nullbestand_tag6 = b.anz_null_tag6, anzahl_nullbestand_tag7 = b.anz_null_tag7
    FROM (
        SELECT
            kjwo,
            werbetyp_id,
            wup_id,
            mandant_id,
            art_id,
            MIN(dat_von) AS dat_von,
            MAX(dat_bis) AS dat_bis,
            MAX(anz_null_tag1) AS anz_null_tag1,
            MAX(anz_minus_tag1) AS anz_minus_tag1,
            MAX(anz_null_tag2) AS anz_null_tag2,
            MAX(anz_null_tag3) AS anz_null_tag3,
            MAX(anz_null_tag4) AS anz_null_tag4,
            MAX(anz_null_tag5) AS anz_null_tag5,
            MAX(anz_null_tag6) AS anz_null_tag6,
            MAX(anz_null_tag7) AS anz_null_tag7
        FROM `_test_we_mbst2a_kmo_not_in`
        GROUP BY
            kjwo,
            werbetyp_id,
            wup_id,
            mandant_id,
            art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo_not_in`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo_not_in` SET anzahl_nullbestand_tag1bis3 = b.anz_null_tag1_bis_tag3, anzahl_minusbestand_tag1bis3 = b.anz_minus_tag1_bis_tag3
    FROM (
        SELECT
            kjwo,
            werbetyp_id,
            wup_id,
            mandant_id,
            art_id,
            MIN(dat_von) AS dat_von,
            MAX(dat_bis) AS dat_bis,
            MAX(anz_null_tag1_bis_tag3) AS anz_null_tag1_bis_tag3,
            MAX(anz_minus_tag1_bis_tag3) AS anz_minus_tag1_bis_tag3
        FROM `_test_we_mbst2b_kmo_not_in`
        GROUP BY
            kjwo,
            werbetyp_id,
            wup_id,
            mandant_id,
            art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id
        AND `_ff_we_artbew1_kmo_not_in`.kjwo = b.kjwo
        AND `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo_not_in` SET menge_historie_af = b.menge_historie_af
    FROM (
        SELECT
            a.mandant_id,
            a.wup_id,
            a.art_id,
            SUM(d.menge) / 42.000 AS menge_historie_af
        FROM `_ff_we_artbew1_kmo_not_in` AS a
        INNER JOIN dbp_data.woche_1 AS b
            ON a.kjwo = b.kjwo
        INNER JOIN dbp_data.woche_kj_kl_1 AS c
            ON c.akt_wo BETWEEN b.akt_wo - 6 AND (
                b.akt_wo - 1
            )
        INNER JOIN dbp_data.artbew_wo_sum_1 AS d
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
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id
        AND `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id;

    UPDATE `_ff_we_artbew1_kmo_not_in` SET anzahl_tage_aktion = b.anz_tage_aktion
    FROM (
        SELECT
            mandant_id,
            werbetyp_id,
            MAX(anz_tage_aktion) AS anz_tage_aktion
        FROM `_werbetyp_tage_kmo`
        GROUP BY
            mandant_id,
            werbetyp_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id
        AND `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;

    UPDATE `_ff_we_artbew1_kmo_not_in` SET we_menge_ab_vorwoche = `_ff_we_artbew1_kmo_not_in`.we_menge
    WHERE
        TRUE;

    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew2_kmo_not_in AS
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
        a.hilfe,
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
    FROM `_ff_we_artbew1_kmo_not_in` AS a
    INNER JOIN dbp_data.tag_1 AS b
        ON a.dat_von = b.dat
    INNER JOIN dbp_data.tag_1 AS c
        ON a.dat_bis = c.dat
    INNER JOIN `_werbeartikel_1_kmo` AS w
        ON
            a.mandant_id = w.mandant_id
            AND a.wup_id = w.wup_id
            AND a.art_id = w.art_id
            AND a.dat_von BETWEEN w.dat_von AND w.dat_bis
            AND a.werbetyp_id = w.werbetyp_id
    LEFT JOIN `_ff_mutter_art_kmo` AS d
        ON a.mandant_id = d.mandant_id AND a.art_id = d.art_id;

    DELETE FROM `_ff_we_artbew2_kmo_not_in`
    WHERE
        (mandant_id, mutter_wb_id) IN (
            SELECT (akt.mandant_id, akta.art_id)
            FROM dbp_data.aktion_1 AS akt
            INNER JOIN dbp_data.aktion_art_wup_zu_1 AS akta
                ON akt.mandant_id = akta.mandant_id AND akt.aktion_id = akta.aktion_id
            INNER JOIN dbp_data.tag_1 AS x1
                ON akt.dat_von = x1.dat
            WHERE
                akta.grund_sperrung IS NULL
                AND akt.mandant_id IN (8)
                AND INSTR(akt.aktion_id, 'J') > 0
                AND LENGTH(TRIM(akt.aktion_id)) = 9
                AND x1.akt_wo = (
                    wkw
                )
            GROUP BY
                akt.mandant_id,
            akta.art_id
        );

    DELETE FROM dbp_data.werbung_kennzahlen_woche_1
    WHERE
        (kjwo, werbe_typ_id, wup_id, art_id, mandant_id) IN (
            SELECT (kjwo, werbetyp_id, wup_id, art_id, mandant_id)
            FROM `_ff_we_artbew2_kmo_not_in`
        )
        AND menge_tag1 + menge_tag2 + menge_tag3 + menge_tag4 + menge_tag5 + menge_tag6 + menge_tag7 = 0;

    INSERT INTO dbp_data.werbung_kennzahlen_woche_1 (
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
            x1.mandant_id,
            x1.kjwo,
            x1.wup_id,
            x1.nb_id,
            x1.art_id,
            x1.werbetyp_id AS werbe_typ_id,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_mo
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_di
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_mi
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_do
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_fr
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.menge_sa
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_so
                ELSE 0
            END AS NUMERIC) AS menge_tag1,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_di
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_mi
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_do
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_fr
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_sa
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.menge_so
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_mo
                ELSE 0
            END AS NUMERIC) AS menge_tag2,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_mi
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_do
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_fr
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_sa
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_so
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.menge_mo
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_di
                ELSE 0
            END AS NUMERIC) AS menge_tag3,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_do
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_fr
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_sa
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_so
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_mo
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.menge_di
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_mi
                ELSE 0
            END AS NUMERIC) AS menge_tag4,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_fr
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_sa
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_so
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_mo
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_di
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.menge_mi
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_do
                ELSE 0
            END AS NUMERIC) AS menge_tag5,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_sa
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_so
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_mo
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_di
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_mi
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.menge_do
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_fr
                ELSE 0
            END AS NUMERIC) AS menge_tag6,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.menge_so
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.menge_mo
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.menge_di
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.menge_mi
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.menge_do
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.menge_fr
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.menge_sa
                ELSE 0
            END AS NUMERIC) AS menge_tag7,
            x1.menge_nur_tag1,
            x1.tage_menge_0,
            x1.menge_endbestand,
            x1.menge_aktionsstart,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_mo
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_di
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_mi
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_do
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_fr
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.umsatz_netto_sa
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_so
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag1,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_di
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_mi
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_do
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_fr
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_sa
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.umsatz_netto_so
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_mo
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag2,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_mi
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_do
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_fr
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_sa
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_so
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.umsatz_netto_mo
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_di
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag3,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_do
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_fr
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_sa
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_so
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_mo
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.umsatz_netto_di
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_mi
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag4,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_fr
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_sa
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_so
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_mo
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_di
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.umsatz_netto_mi
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_do
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag5,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_sa
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_so
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_mo
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_di
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_mi
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.umsatz_netto_do
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_fr
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag6,
            CAST(CASE
                WHEN x1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN x1.umsatz_netto_so
                WHEN x1.werbetyp_id IN (17)
                    THEN x1.umsatz_netto_mo
                WHEN x1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN x1.umsatz_netto_di
                WHEN x1.werbetyp_id IN (4, 5, 21)
                    THEN x1.umsatz_netto_mi
                WHEN x1.werbetyp_id IN (10, 13, 18, 29)
                    THEN x1.umsatz_netto_do
                WHEN x1.werbetyp_id IN (9, 30)
                    THEN x1.umsatz_netto_fr
                WHEN x1.werbetyp_id IN (14, 19)
                    THEN x1.umsatz_netto_sa
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag7,
            x1.we_menge,
            x1.min_sicherh_bestand,
            x1.posten_id,
            x1.we_menge_ab_vorwoche AS we_menge_zentral,
            x1.faktor_flaki,
            COALESCE(x1.mutter_wb_id, x1.art_id) AS mutter_wb_id,
            x1.wtag_id_start,
            x1.wtag_id_ende,
            x1.menge_historie_af,
            CAST(CASE
                WHEN x1.anzahl_tage_aktion < x1.anzahl_nullbestand
                    THEN x1.anzahl_tage_aktion
                ELSE x1.anzahl_nullbestand
            END AS INT64) AS anzahl_nullbestand,
            CAST(x1.anzahl_tage_aktion AS INT64) AS anzahl_tage_aktion,
            x1.menge_tag1_7bis13h,
            CAST(x1.lager_prozent AS INT64) AS lager_prozent,
            CAST(x1.mhd_zeitraum AS INT64) AS mhd_zeitraum,
            x1.sollbestand,
            x1.menge_bestand_soll_max,
            0 AS werbenachvermarktung_fg,
            x1.we_menge_vor_aktion,
            CAST(x1.bezugsweg_id AS INT64) AS bezugsweg_id,
            CAST(x1.anzahl_nullbestand_tag1 AS INT64) AS anzahl_nullbestand_tag1,
            CAST(x1.anzahl_nullbestand_tag2 AS INT64) AS anzahl_nullbestand_tag2,
            CAST(x1.anzahl_nullbestand_tag3 AS INT64) AS anzahl_nullbestand_tag3,
            CAST(x1.anzahl_nullbestand_tag4 AS INT64) AS anzahl_nullbestand_tag4,
            CAST(x1.anzahl_nullbestand_tag5 AS INT64) AS anzahl_nullbestand_tag5,
            CAST(x1.anzahl_nullbestand_tag6 AS INT64) AS anzahl_nullbestand_tag6,
            CAST(x1.anzahl_nullbestand_tag7 AS INT64) AS anzahl_nullbestand_tag7,
            CAST(x1.anzahl_nullbestand_tag1bis3 AS INT64) AS anzahl_nullbestand_tag1bis3,
            CAST(x1.anzahl_minusbestand AS INT64) AS anzahl_minusbestand,
            CAST(x1.anzahl_minusbestand_tag1 AS INT64) AS anzahl_minusbestand_tag1,
            CAST(x1.anzahl_minusbestand_tag1bis3 AS INT64) AS anzahl_minusbestand_tag1bis3,
            x1.avq_relevant_fg,
            x2.default_wrg AS wrg_id,
            CAST(x1.menge_sa AS NUMERIC) AS menge_sa,
            x1.vk_vor_aktion_brutto,
            x1.vk_aktion_brutto,
            x1.vk_kcard_brutto,
            CURRENT_TIMESTAMP(),
            CURRENT_TIMESTAMP()
        FROM `_ff_we_artbew2_kmo_not_in` AS x1
        INNER JOIN dbp_data.mandant_1 AS x2
            ON x1.mandant_id = x2.mandant_id
    );

    CREATE OR REPLACE TEMPORARY TABLE _preis_mutter_kmo AS
    SELECT
        a.mandant_id,
        a.kjwo,
        a.wup_id,
        a.werbe_typ_id,
        a.mutter_wb_id,
        x.vk_brutto AS preis
    FROM dbp_data.werbung_kennzahlen_woche_1 AS a
    INNER JOIN `_werbeartikel_1_kmo` AS x
        ON
            a.kjwo = x.kjwo
            AND a.werbe_typ_id = x.werbetyp_id
            AND a.mandant_id = x.mandant_id
            AND a.wup_id = x.wup_id
            AND a.mutter_wb_id = x.art_id
    INNER JOIN dbp_data.art_wg_zu_per_1 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.mutter_wb_id = b.art_id
            AND b.dat_bis = CAST('9999-12-31' AS DATE)
            AND b.arthiertyp_id = 2
    WHERE
        a.mutter_wb_id = a.art_id
        AND b.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_1
            WHERE
                wg_filter_id = 44 AND mandant_id > 1
        )
        AND a.kjwo IN (
            SELECT kjwo
            FROM dbp_data.tag_1
            WHERE
                akt_wo = (
                    wkw
                )
        )
        AND x.vk_brutto <> 0;

    CREATE OR REPLACE TEMPORARY TABLE _preis_kind_kmo AS
    SELECT
        a.mandant_id,
        a.kjwo,
        a.werbe_typ_id,
        a.wup_id,
        a.art_id,
        a.mutter_wb_id,
        x.vk_brutto AS preis_kind,
        b.preis AS preis_mutter,
        CAST(COALESCE(ROUND(b.preis / IF(x.vk_brutto = 0, NULL, x.vk_brutto), 2), 1) AS NUMERIC) AS faktor
    FROM dbp_data.werbung_kennzahlen_woche_1 AS a
    INNER JOIN `_werbeartikel_1_kmo` AS x
        ON
            a.kjwo = x.kjwo
            AND a.werbe_typ_id = x.werbetyp_id
            AND a.mandant_id = x.mandant_id
            AND a.wup_id = x.wup_id
            AND a.art_id = x.art_id
    INNER JOIN `_preis_mutter_kmo` AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.mutter_wb_id = b.mutter_wb_id
            AND a.wup_id = b.wup_id
            AND a.kjwo = b.kjwo
            AND a.werbe_typ_id = b.werbe_typ_id;

    UPDATE dbp_data.werbung_kennzahlen_woche_1 SET faktor_flaki = b.faktor
    FROM (
        SELECT
            mandant_id,
            kjwo,
            werbe_typ_id,
            wup_id,
            art_id,
            mutter_wb_id,
            MAX(preis_kind) AS preis_kind,
            MAX(preis_mutter) AS preis_mutter,
            MAX(faktor) AS faktor
        FROM `_preis_kind_kmo`
        GROUP BY
            mandant_id,
            kjwo,
            werbe_typ_id,
            wup_id,
            art_id,
            mutter_wb_id
    ) AS b
    WHERE
        werbung_kennzahlen_woche.mandant_id = b.mandant_id
        AND werbung_kennzahlen_woche.wup_id = b.wup_id
        AND werbung_kennzahlen_woche.kjwo = b.kjwo
        AND werbung_kennzahlen_woche.art_id = b.art_id
        AND werbung_kennzahlen_woche.mutter_wb_id = b.mutter_wb_id
        AND werbung_kennzahlen_woche.werbe_typ_id = b.werbe_typ_id;

    UPDATE dbp_data.werbung_kennzahlen_woche_1 SET faktor_flaki = 1
    WHERE
        faktor_flaki = 0;

    DELETE FROM dbp_data.werbung_kennzahlen_woche_1
    WHERE
        (mandant_id, art_id) IN (
            SELECT (mandant_id, kopf_art)
            FROM `_stpo_kmo`
        )
        AND menge_tag1 + menge_tag2 + menge_tag3 + menge_tag4 + menge_tag5 + menge_tag6 + menge_tag7 = 0
        AND kjwo IN (
            SELECT kjwo
            FROM dbp_data.tag_1
            WHERE
                akt_wo = (
                    wkw
                )
        );

    CREATE OR REPLACE TEMPORARY TABLE _upd_werbung AS
    SELECT
        a.kjwo,
        a.mandant_id,
        a.art_id,
        MIN(b.posten_id) AS posten_id_neu
    FROM dbp_data.werbung_kennzahlen_woche_1 AS a
    INNER JOIN dbp_data.art_1 AS b
        ON
            a.mandant_id = b.mandant_id
            AND /* a.art_id = b.art_id AND (alt) */ a.mutter_wb_id /* Zuspielen des Postenkennzeichens jetzt auf Mutterebene!!! */ /* 14.09.2016, -dbay- */ = b.art_id
            AND b.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        a.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
        AND a.kjwo IN (
            SELECT kjwo
            FROM dbp_data.tag_1
            WHERE
                akt_wo = (
                    wkw
                )
        )
    GROUP BY
        a.kjwo,
        a.mandant_id,
        a.art_id;

    UPDATE dbp_data.werbung_kennzahlen_woche_1 SET posten_id = b.posten_id_neu
    FROM `_upd_werbung` AS b
    WHERE
        werbung_kennzahlen_woche.mandant_id = b.mandant_id
        AND werbung_kennzahlen_woche.art_id = b.art_id
        AND werbung_kennzahlen_woche.kjwo = b.kjwo;

    CREATE OR REPLACE TEMPORARY TABLE _we_upd_candidates_kmo AS
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
        FROM dbp_data.werbung_kennzahlen_woche_1 AS a
        INNER JOIN dbp_data.art_wg_zu_per_1 AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.art_id = b.art_id
                AND b.arthiertyp_id = 2
                AND b.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            b.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_1
                WHERE
                    wg_filter_id = 44 AND mandant_id > 1
            )
            AND a.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
            AND a.kjwo IN (
                SELECT kjwo
                FROM dbp_data.tag_1
                WHERE
                    akt_wo = (
                        wkw
                    )
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

    CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art_we_upd_kmo AS
    SELECT
        mandant_id,
        art_id,
        COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
    FROM dbp_data.art_1 AS a
    WHERE
        dat_bis = CAST('9999-12-31' AS DATE) AND mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    GROUP BY
        mandant_id,
        art_id,
        a.mutter_wb_id;

    CREATE OR REPLACE TEMPORARY TABLE _singles_kmo AS
    SELECT mutter_wb_id
    FROM `_ff_mutter_art_we_upd_kmo`
    GROUP BY
        mutter_wb_id
    HAVING
        COUNT(*) = 1;

    DELETE FROM `_we_upd_candidates_kmo`
    WHERE
        mutter_wb_id IN (
            SELECT mutter_wb_id
            FROM `_singles_kmo`
        );

    CREATE OR REPLACE TEMPORARY TABLE _multiples_kmo AS
    SELECT
        mutter_wb_id,
        COUNT(*) AS anzahl
    FROM `_ff_mutter_art_we_upd_kmo`
    GROUP BY
        mutter_wb_id
    HAVING
        anzahl > 1;

    DELETE FROM `_we_upd_candidates_kmo`
    WHERE
        (mandant_id, kjwo, werbe_typ_id, mutter_wb_id) IN (
            SELECT (a.mandant_id, a.kjwo, a.werbe_typ_id, a.mutter_wb_id)
            FROM dbp_data.werbung_kennzahlen_woche_1 AS a
            INNER JOIN `_multiples_kmo` AS b
                ON a.mutter_wb_id = b.mutter_wb_id
            WHERE
                a.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
                AND a.kjwo IN (
                    SELECT kjwo
                    FROM dbp_data.tag_1
                    WHERE
                        akt_wo = (
                            wkw
                        )
                )
            GROUP BY
                a.mandant_id,
                a.kjwo,
                a.werbe_typ_id,
                a.mutter_wb_id
            HAVING
                SUM(a.we_menge_zentral) = 0
        );

    UPDATE dbp_data.werbung_kennzahlen_woche_1 SET we_menge_zentral = 0.001
    FROM `_we_upd_candidates_kmo` AS b
    WHERE
        werbung_kennzahlen_woche.kjwo = b.kjwo
        AND werbung_kennzahlen_woche.werbe_typ_id = b.werbe_typ_id
        AND werbung_kennzahlen_woche.mandant_id = b.mandant_id
        AND werbung_kennzahlen_woche.wup_id = b.wup_id
        AND werbung_kennzahlen_woche.art_id = b.art_id
        AND werbung_kennzahlen_woche.we_menge_zentral = 0;

    DELETE FROM dbp_data.werbung_kennzahlen_woche_1
    WHERE
        (mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl_process.avq_obsolete_artikel_1
        );

    UPDATE dbp_data.werbung_kennzahlen_woche_1 SET tage_menge_0 = 1
    WHERE
        werbe_typ_id = 22 AND mandant_id = 4 AND tage_menge_0 = 7;

    DELETE FROM dbp_data.avq_aktualisierung_1
    WHERE
        (mandant_id, kjwo) IN (
            SELECT (mandant_id, kjwo)
            FROM `_werbeartikel_1_kmo`
        );

    INSERT INTO dbp_data.avq_aktualisierung_1 (
        mandant_id,
        kjwo,
        dat_letzte_aktualisierung
    )
    (
        SELECT
            mandant_id,
            kjwo,
            CAST(CURRENT_TIMESTAMP() AS DATETIME)
        FROM `_werbeartikel_1_kmo`
        GROUP BY
            mandant_id,
            kjwo,
            3
    );

END;
