BEGIN
    DECLARE wkw INT64;
    SET wkw = WKW;


    CREATE OR REPLACE TEMPORARY TABLE _werbeartikel_1_kmo (
        kjwo INTEGER,
        werbetyp_id INTEGER,
        dat_von DATE,
        dat_bis DATE,
        wup_id INTEGER,
        mandant_id INTEGER,
        art_id INTEGER,
        akt_wo INTEGER,
        vk_brutto NUMERIC(29, 2),
        stkl_kopf_fg INTEGER,
        komponente INTEGER,
        mutter_wb_id INTEGER,
        avq_relevant_fg INTEGER,
        grund_sperrung STRING(1)
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            CASE
                WHEN c.werbetyp_id = 8 AND X1.wtag_id = 7
                    THEN X2.kjwo
                ELSE X1.kjwo
            END AS kjwo,
            c.werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN (SELECT
            mandant_id,
            dat_von,
            dat_bis,
            werbe_typ_id AS werbetyp_id
        FROM dbp_data.ts_avq_werbezeitraum_abw_2
        WHERE mandant_id > 1) AS c ON akt.mandant_id = c.mandant_id AND akt.dat_von = c.dat_von AND akt.dat_bis = c.dat_bis
        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat
        INNER JOIN dbp_data.tag_2 AS X2 ON akt.dat_bis = X2.dat
        WHERE (akt.mandant_id IN (
            2, 5, 6) AND X1.akt_wo = wkw OR akt.mandant_id IN (3) AND X1.akt_wo = wkw AND SUBSTR(akt.aktion_id, 9, 2) NOT IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK') OR akt.mandant_id IN (7, 4) AND SUBSTR(
            akt.aktion_id,
            9, 2
        ) IN ('MM_2', 'HG', 'NF', 'HA', 'HB', 'LD', 'TV', 'VD'
        ) AND X1.akt_wo = wkw OR akt.mandant_id IN (7, 4
        ) AND X1.akt_wo = wkw AND ROUND(SAFE_CAST(akt.aktion_id AS BIGNUMERIC), 0) IS NOT NULL OR akt.mandant_id IN
        (8) AND INSTR(akt.aktion_id, 'D1') = 0 AND INSTR(akt.aktion_id, 'D2') = 0 AND INSTR(akt.aktion_id, 'DS') = 0
        AND (RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND X1.akt_wo = wkw)
        AND (X2.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, c.werbetyp_id) NOT IN (SELECT (
            kjwo, wup_id, mandant_id,
            art_id, werbetyp_id
        )
        FROM `_werbeartikel_1_kmo`)
        GROUP BY
            kjwo,
            c.werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            A.kjwo,
            A.werbe_typ_id,
            CASE
                WHEN A.werbe_typ_id = 5 AND B.wtag_id = 1
                    THEN DATE_ADD(B.dat, INTERVAL 3 DAY)
                WHEN A.werbe_typ_id = 6 AND B.wtag_id = 1
                    THEN DATE_ADD(B.dat, INTERVAL 2 DAY)
                WHEN A.werbe_typ_id = 7 AND B.wtag_id = 1
                    THEN B.dat
                ELSE NULL
            END AS dat_von_,
            CASE
                WHEN A.werbe_typ_id = 5 AND B.wtag_id = 1
                    THEN DATE_ADD(B.dat, INTERVAL 9 DAY)
                WHEN A.werbe_typ_id = 6 AND B.wtag_id = 1
                    THEN DATE_ADD(B.dat, INTERVAL 8 DAY)
                WHEN A.werbe_typ_id = 7 AND B.wtag_id = 1
                    THEN DATE_ADD(B.dat, INTERVAL 6 DAY)
                ELSE NULL
            END AS dat_bis_,
            A.wup_id,
            A.mandant_id,
            A.art_id,
            B.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            A.mutter_wb_id,
            A.avq_relevant_fg,
            ' ' AS grund_sperrung
        FROM dbp_process.werbung_kennzahlen_kopf_2 AS A
        INNER JOIN dbp_data.tag_2 AS B ON A.kjwo = B.kjwo
        WHERE
            B.akt_wo = wkw
            AND A.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
            AND (
                A.kjwo, A.wup_id, A.mandant_id, A.art_id) NOT IN (
                SELECT (kjwo, wup_id, mandant_id, art_id)
                FROM `_werbeartikel_1_kmo`
            )
            AND CASE
                WHEN A.werbe_typ_id = 5 AND B.wtag_id = 1
                    THEN DATE_ADD(B.dat, INTERVAL 3 DAY)
                WHEN A.werbe_typ_id = 6 AND B.wtag_id = 1
                    THEN DATE_ADD(B.dat, INTERVAL 2 DAY)
                WHEN A.werbe_typ_id = 7 AND B.wtag_id = 1
                    THEN B.dat
                ELSE NULL
            END IS NOT NULL
            AND CASE
                WHEN A.werbe_typ_id = 5 AND B.wtag_id = 1
                    THEN DATE_ADD(B.dat, INTERVAL 9 DAY)
                WHEN A.werbe_typ_id = 6 AND B.wtag_id = 1
                    THEN DATE_ADD(B.dat, INTERVAL 8 DAY)
                WHEN A.werbe_typ_id = 7 AND B.wtag_id = 1
                    THEN DATE_ADD(B.dat, INTERVAL 6 DAY)
                ELSE NULL
            END IS NOT NULL
        GROUP BY
            A.kjwo,
            A.werbe_typ_id,
            dat_von_,
            dat_bis_,
            A.wup_id,
            A.mandant_id,
            A.art_id,
            B.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            A.mutter_wb_id,
            A.avq_relevant_fg,
            grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            CASE
                WHEN akt.mandant_id = 2 AND akt.dat_bis >= DATE '2019-02-27' OR akt.mandant_id IN (4, 7)
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
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1
            ON akt.dat_von = X1.dat AND X1.wtag_id = CASE
                WHEN akt.mandant_id = 2 AND akt.dat_bis >= DATE '2019-02-27' OR akt.mandant_id IN (4, 7)
                    THEN 3
                WHEN akt.mandant_id = 8
                    THEN 1
                ELSE 4
            END
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = CASE
                WHEN akt.mandant_id = 2 AND akt.dat_bis >= DATE '2019-02-27' OR akt.mandant_id IN (4, 7)
                    THEN 2
                WHEN akt.mandant_id = 8
                    THEN 7
                ELSE 3
            END AND DATE_SUB(X2.dat, INTERVAL 6 DAY) = X1.dat
        WHERE (akt.mandant_id IN (
            2, 5, 6) AND X1.akt_wo = wkw OR akt.mandant_id IN (3) AND X1.akt_wo = wkw AND SUBSTR(akt.aktion_id, 9, 2) NOT IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK') OR akt.mandant_id IN (4, 7) AND CASE
            WHEN akt.mandant_id = 4
                THEN 1
            WHEN akt.mandant_id = 7 AND akta.wrg_id = ''
                THEN 0
            ELSE 1
        END = 1 AND CASE
            WHEN akt.mandant_id IN (4, 7) AND ROUND(SAFE_CAST(akt.aktion_id AS BIGNUMERIC), 0) IS NOT NULL
                THEN 1
            WHEN SUBSTR(akt.aktion_id, 9, 2) IN ('MM_2', 'HG', 'NF', 'HA', 'HB', 'LD')
                THEN 1
            ELSE 0
        END = 1 AND X1.akt_wo = wkw OR akt.mandant_id IN (
            8) AND INSTR(akt.aktion_id, 'D1') = 0 AND INSTR(akt.aktion_id,
        'D2') = 0 AND INSTR(akt.aktion_id, 'DS') = 0 AND (
            RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) =
            10
        ) AND X1.akt_wo = wkw)
        AND (
            X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id) NOT IN (
            SELECT (kjwo, wup_id, mandant_id, art_id)
            FROM `_werbeartikel_1_kmo`
        )
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            8 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 1
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 3 AND DATE_SUB(
                X2.dat, INTERVAL
                2 DAY
            ) = X1.dat
        WHERE (akt.mandant_id IN (2, 4, 5, 6, 7) AND CASE
            WHEN akt.mandant_id = 4
                THEN 1
            WHEN akt.mandant_id IN (2, 5, 6, 7) AND akta.wrg_id = ''
                THEN 0
            ELSE 1
        END = 1 AND X1.akt_wo = wkw OR akt.mandant_id IN (3) AND X1.akt_wo = wkw AND SUBSTR(akt.aktion_id, 9, 2)
        NOT IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK') OR akt.mandant_id IN (8) AND INSTR(akt.aktion_id, 'DS') = 0 AND (RIGHT(
            akt.aktion_id, 1
        ) <> 'J' OR LENGTH(akt.aktion_id
        ) = 10) AND X1.akt_wo = wkw)
        AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 8) NOT IN (SELECT (
            kjwo, wup_id, mandant_id, art_id,
            werbetyp_id
        )
        FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            9 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 6
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 7 AND DATE_SUB(
                X2.dat, INTERVAL
                1 DAY
            ) = X1.dat
        WHERE (akt.mandant_id IN (2, 6) AND X1.akt_wo = wkw OR akt.mandant_id IN (7, 4) AND CASE
            WHEN akt.mandant_id = 4
                THEN 1
            WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                THEN 0
            ELSE 1
        END = 1 AND SUBSTR(akt.aktion_id, 9, 2) IN ('MM_2', 'HG', 'NF', 'HA', 'HB', 'LD', 'TV', 'VD') AND X1.akt_wo =
        wkw OR akt.mandant_id IN (7, 4) AND CASE
            WHEN akt.mandant_id = 4
                THEN 1
            WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                THEN 0
            ELSE 1
        END = 1 AND X1.akt_wo = wkw AND ROUND(SAFE_CAST(akt.aktion_id AS BIGNUMERIC), 0) IS NOT NULL OR akt.mandant_id
        IN (3) AND X1.akt_wo = wkw AND SUBSTR(akt.aktion_id, 9, 2) NOT IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK'))
        AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 9) NOT IN (SELECT (
            kjwo, wup_id, mandant_id, art_id,
            werbetyp_id
        )
        FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung,
            stkl_kopf_fg
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            10 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 5
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 1 AND DATE_SUB(
                X2.dat, INTERVAL
                3 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (4, 7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (2, 5, 6, 7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 10) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            4 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 4
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 7 AND DATE_SUB(
                X2.dat, INTERVAL
                3 DAY
            ) = X1.dat
        WHERE (
            akt.mandant_id IN (2, 3, 4, 6) AND X1.akt_wo = wkw OR akt.mandant_id IN (8) AND INSTR(akt.aktion_id, 'DS') =
            0 AND (RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND X1.akt_wo = wkw
        )
        AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 4) NOT IN (SELECT (
            kjwo, wup_id, mandant_id, art_id,
            werbetyp_id
        )
        FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            6 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 3
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 2 AND DATE_SUB(
                X2.dat, INTERVAL
                6 DAY
            ) = X1.dat
        WHERE (akt.mandant_id IN (6) AND X1.akt_wo = wkw OR akt.mandant_id IN (8) AND INSTR(akt.aktion_id, 'DS') = 0 AND (RIGHT(
            akt.aktion_id, 1
        ) <> 'J' OR LENGTH(akt.aktion_id
        ) = 10) AND X1.akt_wo = wkw)
        AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 6) NOT IN (SELECT (
            kjwo, wup_id, mandant_id, art_id,
            werbetyp_id
        )
        FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            7 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 1
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 7 AND DATE_SUB(
                X2.dat, INTERVAL
                6 DAY
            ) = X1.dat
        WHERE (akt.mandant_id IN (
            2, 5, 6) AND X1.akt_wo = wkw OR akt.mandant_id IN (3) AND X1.akt_wo = wkw AND SUBSTR(akt.aktion_id, 9, 2) NOT IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK') OR akt.mandant_id IN (4, 7) AND CASE
            WHEN akt.mandant_id = 4
                THEN 1
            WHEN akt.mandant_id IN (2, 5, 6, 7) AND akta.wrg_id = ''
                THEN 0
            ELSE 1
        END = 1 AND CASE
            WHEN ROUND(SAFE_CAST(akt.aktion_id AS BIGNUMERIC), 0) IS NOT NULL
                THEN 1
            WHEN SUBSTR(akt.aktion_id, 9, 2) IN ('MM_2', 'HG', 'NF', 'HA', 'HB', 'LD')
                THEN 1
            ELSE 0
        END = 1 AND X1.akt_wo = wkw)
        AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 7) NOT IN (SELECT (
            kjwo, wup_id, mandant_id, art_id,
            werbetyp_id
        )
        FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            5 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 4
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 3 AND DATE_SUB(
                X2.dat, INTERVAL
                6 DAY
            ) = X1.dat
        WHERE (
            akt.mandant_id IN (4) OR akt.mandant_id IN (8) AND INSTR(akt.aktion_id, 'D1') = 0 AND INSTR(akt.aktion_id, 'D2'
            ) = 0 AND INSTR(akt.aktion_id, 'DS') = 0 AND (RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10)
        )
        AND X1.akt_wo = wkw
        AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 5) NOT IN (SELECT (
            kjwo, wup_id, mandant_id, art_id,
            werbetyp_id
        )
        FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            12 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 1
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 2 AND DATE_SUB(
                X2.dat, INTERVAL
                1 DAY
            ) = X1.dat
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
                WHEN ROUND(SAFE_CAST(akt.aktion_id AS BIGNUMERIC), 0) IS NOT NULL
                    THEN 1
                WHEN SUBSTR(akt.aktion_id, 9, 2) IN ('LM')
                    THEN 1
                ELSE 0
            END = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 12) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            13 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 5
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 7 AND DATE_SUB(
                X2.dat, INTERVAL
                2 DAY
            ) = X1.dat
        WHERE (akt.mandant_id IN (4, 7) AND CASE
            WHEN akt.mandant_id = 4
                THEN 1
            WHEN akt.mandant_id IN (2, 5, 6, 7) AND akta.wrg_id = ''
                THEN 0
            ELSE 1
        END = 1 AND CASE
            WHEN ROUND(SAFE_CAST(akt.aktion_id AS BIGNUMERIC), 0) IS NOT NULL
                THEN 1
            WHEN akt.mandant_id = 7 AND SUBSTR(akt.aktion_id, 9, 2) IN ('VD', 'TV')
                THEN 1
            WHEN akt.mandant_id = 4 AND SUBSTR(akt.aktion_id, 9, 2) IN ('VD', 'TV')
                THEN 1
            ELSE 0
        END = 1 AND X1.akt_wo = wkw OR akt.mandant_id IN (2, 6) AND X1.akt_wo = wkw OR akt.mandant_id IN (8) AND
        INSTR(akt.aktion_id, 'D1') = 0 AND INSTR(akt.aktion_id, 'D2') = 0 AND INSTR(akt.aktion_id, 'DS') = 0 AND (RIGHT(
            akt.aktion_id, 1
        ) <> 'J' OR LENGTH(akt.aktion_id
        ) = 10) AND X1.akt_wo = wkw)
        AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 13) NOT IN (SELECT (
            kjwo, wup_id, mandant_id, art_id,
            werbetyp_id
        )
        FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            11 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 3
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 6 AND DATE_SUB(
                X2.dat, INTERVAL
                3 DAY
            ) = X1.dat
        WHERE (akt.mandant_id IN (
            8) AND INSTR(akt.aktion_id, 'D1') = 0 AND INSTR(akt.aktion_id, 'D2') = 0 AND INSTR(
            akt.aktion_id,
            'DS'
        ) = 0 AND (RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
        ) AND X1.akt_wo = wkw OR akt.mandant_id
        IN (2) AND X1.akt_wo = wkw)
        AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 11) NOT IN (SELECT (
            kjwo, wup_id, mandant_id, art_id,
            werbetyp_id
        )
        FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            14 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 7
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 7 AND DATE_SUB(
                X2.dat, INTERVAL
                0 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (5)
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 14) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            16 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 6
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 6 AND DATE_SUB(
                X2.dat, INTERVAL
                0 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (3)
            AND X1.akt_wo = wkw
            AND SUBSTR(akt.aktion_id, 9, 2) NOT IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK')
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 16) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            16 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 6
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 6 AND DATE_SUB(
                X2.dat, INTERVAL
                0 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (8)
            AND INSTR(akt.aktion_id, 'D1') = 0
            AND INSTR(akt.aktion_id, 'D2') = 0
            AND INSTR(akt.aktion_id, 'DS') = 0
            AND (RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10)
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 16) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            15 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 1
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 7 AND DATE_SUB(
                X2.dat, INTERVAL
                13 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (8)
            AND INSTR(akt.aktion_id, 'D1') = 0
            AND INSTR(akt.aktion_id, 'D2') = 0
            AND INSTR(akt.aktion_id, 'DS') = 0
            AND (RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10)
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 15) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    -- 21.09.2022, -dbay-
    --
    -- new promotion type for bulgaria


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            18 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 5
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 6 AND DATE_SUB(
                X2.dat, INTERVAL
                1 DAY
            ) = X1.dat
        WHERE (akt.mandant_id IN (
            8) AND INSTR(akt.aktion_id, 'D1') = 0 AND INSTR(akt.aktion_id, 'D2') = 0 AND INSTR(
            akt.aktion_id,
            'DS'
        ) = 0 AND (RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10
        ) AND X1.akt_wo = wkw OR akt.mandant_id
        IN (2, 6) AND X1.akt_wo = wkw)
        AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 18) NOT IN (SELECT (
            kjwo, wup_id, mandant_id, art_id,
            werbetyp_id
        )
        FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            17 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 2
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 7 AND DATE_SUB(
                X2.dat, INTERVAL
                5 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (8)
            AND INSTR(akt.aktion_id, 'D1') = 0
            AND INSTR(akt.aktion_id, 'D2') = 0
            AND INSTR(akt.aktion_id, 'DS') = 0
            AND (RIGHT(akt.aktion_id, 1) <> 'J' OR LENGTH(akt.aktion_id) = 10)
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 17) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            19 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 7 AND X1.akt_wo = wkw - 1
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 3 AND DATE_SUB(
                X2.dat, INTERVAL
                3 DAY
            ) = X1.dat AND X2.akt_wo = wkw
        WHERE
            akt.mandant_id IN (5)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (2, 5, 6, 7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND X2.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 19) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            20 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 3
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 5 AND DATE_SUB(
                X2.dat, INTERVAL
                2 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (4, 7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 20) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            21 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 4
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 6 AND DATE_SUB(
                X2.dat, INTERVAL
                2 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (3)
            AND X1.akt_wo = wkw
            AND SUBSTR(akt.aktion_id, 9, 2) NOT IN ('DN', 'DV', 'DP', 'DW', 'DS', 'DK')
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 21) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            22 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 4
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 4 AND DATE_SUB(
                X2.dat, INTERVAL
                0 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (4)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 22) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    -- 04.04.2025, neuer Werbetyp fuer HR (Mo. bis Sa.)


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            1 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 1
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 6 AND DATE_SUB(
                X2.dat, INTERVAL
                5 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (6)
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 1) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    -- TV-Werbung RO (Mi. bis So.)


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            23 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 3
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 7 AND DATE_SUB(
                X2.dat, INTERVAL
                4 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 23) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    -- TV-Werbung RO (Mi. bis Do.)


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            24 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 3
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 4 AND DATE_SUB(
                X2.dat, INTERVAL
                1 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 24) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    -- TV-Werbung RO (Fr. bis Di.)


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            29 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 5
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 2 AND DATE_SUB(
                X2.dat, INTERVAL
                4 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 29) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            vk_brutto,
            stkl_kopf_fg,
            komponente,
            mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
    );


    -- TV-Werbung RO (Sa. bis Di.)


    INSERT INTO `_werbeartikel_1_kmo` (
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, vk_brutto,
        stkl_kopf_fg, komponente, mutter_wb_id, avq_relevant_fg, grund_sperrung
    )
    (
        SELECT
            X1.kjwo,
            30 AS werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
            0 AS vk_brutto,
            0 AS stkl_kopf_fg,
            0 AS komponente,
            -999 AS mutter_wb_id,
            akt.avq_relevant_fg,
            akta.grund_sperrung
        FROM (SELECT
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
            CASE
                WHEN aktion_typ_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_2 AS A
        WHERE mandant_id > 1) AS akt
        INNER JOIN (
            SELECT *
            FROM dbp_data.aktion_art_wup_zu_2
            WHERE
                mandant_id > 1
                AND COALESCE(geloescht_sap_fg, 0) <> 1
        ) AS akta
            ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

        INNER JOIN dbp_data.tag_2 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 6
        INNER JOIN dbp_data.tag_2 AS X2
            ON akt.dat_bis = X2.dat AND X2.wtag_id = 2 AND DATE_SUB(
                X2.dat, INTERVAL
                3 DAY
            ) = X1.dat
        WHERE
            akt.mandant_id IN (7)
            AND CASE
                WHEN akt.mandant_id = 4
                    THEN 1
                WHEN akt.mandant_id IN (7) AND akta.wrg_id = ''
                    THEN 0
                ELSE 1
            END = 1
            AND X1.akt_wo = wkw
            AND (X1.kjwo, akta.wup_id, akta.mandant_id, akta.art_id, 30) NOT IN (SELECT (
                kjwo, wup_id, mandant_id, art_id,
                werbetyp_id
            )
            FROM `_werbeartikel_1_kmo`)
        GROUP BY
            X1.kjwo,
            werbetyp_id,
            akt.dat_von,
            akt.dat_bis,
            akta.wup_id,
            akta.mandant_id,
            akta.art_id,
            X1.akt_wo,
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
    FROM dbp_data.art_2 AS A
    WHERE
        dat_bis = DATE '9999-12-31'
        AND (
            mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM `_werbeartikel_1_kmo`
            GROUP BY mandant_id,
            art_id
        )
    GROUP BY
        mandant_id,
        art_id,
        A.mutter_wb_id;


    UPDATE `_werbeartikel_1_kmo` SET
        mutter_wb_id = b.mutter_wb_id
    FROM `_ff_mutter_art_kmo` AS b
    WHERE
        `_werbeartikel_1_kmo`.mandant_id = b.mandant_id AND `_werbeartikel_1_kmo`.art_id = b.art_id AND
        `_werbeartikel_1_kmo`.mutter_wb_id = -999;


    UPDATE `_werbeartikel_1_kmo` SET
        mutter_wb_id = `_werbeartikel_1_kmo`.art_id
    WHERE mutter_wb_id = -999;


    DELETE FROM `_werbeartikel_1_kmo`
    WHERE (
        mandant_id, wup_id, art_id) IN (
        SELECT (B.mandant_id, B.wup_id, B.art_id)
        FROM `_werbeartikel_1_kmo` AS A
        INNER JOIN
            dbp_data.artbew_stueckliste_zu_2
                AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id = B.komponente_art_id
                AND A.wup_id = B.wup_id AND B.dat BETWEEN A.dat_von AND A.dat_bis
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


    INSERT INTO `_werbeartikel_1_kmo` (
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
    FROM `_werbeartikel_1_kmo` a
    JOIN dbp_data.artbew_stueckliste_zu_2 b
        ON
            a.mandant_id = b.mandant_id AND
            a.art_id = b.komponente_art_id AND
            a.wup_id = b.wup_id AND
            b.dat BETWEEN a.dat_von AND a.dat_bis
    JOIN dbp_data.art_wg_zu_per_2 b1
        ON
            a.mandant_id = b1.mandant_id AND
            b.art_id = b1.art_id AND
            b1.arthiertyp_id = 2 AND
            b1.dat_bis = DATE '9999-12-31'
    JOIN `_matchings` c
        ON
            a.mandant_id = c.mandant_id AND
            a.werbetyp_id = c.werbetyp_id
    WHERE
        b1.wg_id NOT IN (
            SELECT wg_id FROM dbp_data.wg_filter_zu_2
            WHERE wg_filter_id = 46 AND mandant_id > 1
        ) AND
        CASE
            WHEN
                a.mandant_id IN (4, 7) AND
                (
                    b1.wg_id = 30 OR
                    b1.wg_id = 161 OR
                    b1.wg_id = 162 OR
                    b1.wg_id = 163 OR
                    b1.wg_id = 164 OR
                    b1.wg_id = 165 OR
                    b1.wg_id = 166
                )
                THEN 0
            ELSE 1
        END = 1
    GROUP BY 1, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13;


    CREATE OR REPLACE TEMPORARY TABLE _double_check AS (
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
        FROM `_werbeartikel_1_kmo` a
        JOIN dbp_data.artbew_stueckliste_zu_2 b
            ON
                a.mandant_id = b.mandant_id AND
                a.art_id = b.art_id AND
                a.wup_id = b.wup_id AND
                b.dat BETWEEN a.dat_von AND a.dat_bis
        JOIN dbp_data.art_wg_zu_per_2 b1
            ON
                a.mandant_id = b1.mandant_id AND
                b.art_id = b1.art_id AND
                b1.arthiertyp_id = 2 AND
                b1.dat_bis = DATE '9999-12-31'
        JOIN `_matchings` c
            ON
                a.mandant_id = c.mandant_id AND
                a.werbetyp_id = c.werbetyp_id
        WHERE
            b1.wg_id NOT IN (
                SELECT wg_id FROM dbp_data.wg_filter_zu_2
                WHERE wg_filter_id = 46 AND mandant_id > 1
            ) AND
            CASE
                WHEN
                    a.mandant_id IN (4, 7) AND
                    (
                        b1.wg_id = 30 OR
                        b1.wg_id = 161 OR
                        b1.wg_id = 162 OR
                        b1.wg_id = 163 OR
                        b1.wg_id = 164 OR
                        b1.wg_id = 165 OR
                        b1.wg_id = 166
                    )
                    THEN 0
                ELSE 1
            END = 1
        GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
    );


    UPDATE `_werbeartikel_1_kmo` a
    SET
        komponente = b.komponente_art_id,
        stkl_kopf_fg = 1
    FROM (
        SELECT dc.*
        FROM `_double_check` dc
        INNER JOIN (
            SELECT
                kjwo,
                mandant_id,
                dat_von,
                dat_bis,
                wup_id,
                art_id,
                werbetyp_id
            FROM `_double_check`
            GROUP BY 1, 2, 3, 4, 5, 6, 7
            HAVING COUNT(*) = 1
        ) sub
            ON
                dc.kjwo = sub.kjwo AND
                dc.mandant_id = sub.mandant_id AND
                dc.dat_von = sub.dat_von AND
                dc.dat_bis = sub.dat_bis AND
                dc.wup_id = sub.wup_id AND
                dc.art_id = sub.art_id AND
                dc.werbetyp_id = sub.werbetyp_id
    ) b
    WHERE
        a.kjwo = b.kjwo AND
        a.mandant_id = b.mandant_id AND
        a.dat_von = b.dat_von AND
        a.dat_bis = b.dat_bis AND
        a.wup_id = b.wup_id AND
        a.art_id = b.art_id AND
        a.werbetyp_id = b.werbetyp_id;


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
    SELECT
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
    FROM (
        SELECT dc.*
        FROM `_double_check` dc
        INNER JOIN (
            SELECT
                kjwo,
                mandant_id,
                dat_von,
                dat_bis,
                wup_id,
                art_id,
                werbetyp_id
            FROM `_double_check`
            GROUP BY 1, 2, 3, 4, 5, 6, 7
            HAVING COUNT(*) = 1
        ) sub
            ON
                dc.kjwo = sub.kjwo AND
                dc.mandant_id = sub.mandant_id AND
                dc.dat_von = sub.dat_von AND
                dc.dat_bis = sub.dat_bis AND
                dc.wup_id = sub.wup_id AND
                dc.art_id = sub.art_id AND
                dc.werbetyp_id = sub.werbetyp_id
    ) b
    WHERE NOT EXISTS (
        SELECT 1
        FROM `_werbeartikel_1_kmo` a
        WHERE
            a.kjwo = b.kjwo AND
            a.mandant_id = b.mandant_id AND
            a.dat_von = b.dat_von AND
            a.dat_bis = b.dat_bis AND
            a.wup_id = b.wup_id AND
            a.art_id = b.art_id AND
            a.werbetyp_id = b.werbetyp_id
    );


    UPDATE `_werbeartikel_1_kmo` a
    SET stkl_kopf_fg = 3
    FROM (
        SELECT dc.*
        FROM `_double_check` dc
        INNER JOIN (
            SELECT
                kjwo,
                mandant_id,
                dat_von,
                dat_bis,
                wup_id,
                komponente_art_id,
                werbetyp_id
            FROM `_double_check`
            GROUP BY 1, 2, 3, 4, 5, 6, 7
            HAVING COUNT(*) = 1
        ) sub
            ON
                dc.kjwo = sub.kjwo AND
                dc.mandant_id = sub.mandant_id AND
                dc.dat_von = sub.dat_von AND
                dc.dat_bis = sub.dat_bis AND
                dc.wup_id = sub.wup_id AND
                dc.art_id = sub.komponente_art_id AND
                dc.werbetyp_id = sub.werbetyp_id
    ) b
    WHERE
        a.kjwo = b.kjwo AND
        a.mandant_id = b.mandant_id AND
        a.dat_von = b.dat_von AND
        a.dat_bis = b.dat_bis AND
        a.wup_id = b.wup_id AND
        a.art_id = b.komponente_art_id AND
        a.werbetyp_id = b.werbetyp_id;


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
    SELECT
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
    FROM (
        SELECT dc.*
        FROM `_double_check` dc
        INNER JOIN (
            SELECT
                kjwo,
                mandant_id,
                dat_von,
                dat_bis,
                wup_id,
                komponente_art_id,
                werbetyp_id
            FROM `_double_check`
            GROUP BY 1, 2, 3, 4, 5, 6, 7
            HAVING COUNT(*) = 1
        ) sub
            ON
                dc.kjwo = sub.kjwo AND
                dc.mandant_id = sub.mandant_id AND
                dc.dat_von = sub.dat_von AND
                dc.dat_bis = sub.dat_bis AND
                dc.wup_id = sub.wup_id AND
                dc.art_id = sub.komponente_art_id AND
                dc.werbetyp_id = sub.werbetyp_id
    ) b
    WHERE NOT EXISTS (
        SELECT 1
        FROM `_werbeartikel_1_kmo` a
        WHERE
            a.kjwo = b.kjwo AND
            a.mandant_id = b.mandant_id AND
            a.dat_von = b.dat_von AND
            a.dat_bis = b.dat_bis AND
            a.wup_id = b.wup_id AND
            a.art_id = b.komponente_art_id AND
            a.werbetyp_id = b.werbetyp_id
    );


    UPDATE `_werbeartikel_1_kmo` SET
        mutter_wb_id = b.mutter_wb_id
    FROM `_ff_mutter_art_kmo` AS b
    WHERE
        `_werbeartikel_1_kmo`.mandant_id = b.mandant_id AND `_werbeartikel_1_kmo`.art_id = b.art_id AND
        `_werbeartikel_1_kmo`.mutter_wb_id = -999;


    UPDATE `_werbeartikel_1_kmo` SET
        mutter_wb_id = `_werbeartikel_1_kmo`.art_id
    WHERE mutter_wb_id = -999;


    CREATE OR REPLACE TEMPORARY TABLE _kompo_tracking AS
    SELECT
        komponente,
        COUNT(DISTINCT art_id) AS anzahl
    FROM `_werbeartikel_1_kmo`
    WHERE stkl_kopf_fg = 1
    GROUP BY komponente
    HAVING anzahl > 1;


    UPDATE `_werbeartikel_1_kmo` SET
        stkl_kopf_fg = 2
    FROM `_kompo_tracking` AS b
    WHERE `_werbeartikel_1_kmo`.komponente = b.komponente;


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
        CAST(0 AS NUMERIC) AS vk_vor_aktion_brutto,
        CAST(0 AS NUMERIC) AS vk_aktion_brutto,
        CAST(0 AS NUMERIC) AS vk_kcard_brutto
    FROM `_werbeartikel_1_kmo` AS A;


    CREATE OR REPLACE TEMPORARY TABLE _werbeartikel_1_kmo AS
    SELECT *
    FROM `_pp`;


    UPDATE `_werbeartikel_1_kmo` SET
        vk_brutto = b.vk_brutto FROM (
        SELECT
            A.art_id,
            A.mandant_id,
            A.wup_id,
            B.werbetyp_id,
            MAX(A.vk_brutto) AS vk_brutto
        FROM dbp_data.art_wup_vk_per_2 AS A
        INNER JOIN `_werbeartikel_1_kmo` AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.wup_id = B.wup_id
                AND B.dat_von BETWEEN A.dat_von AND A.dat_bis
        GROUP BY
            A.art_id,
            A.mandant_id,
            A.wup_id,
            B.werbetyp_id
    ) AS b
    WHERE
        `_werbeartikel_1_kmo`.mandant_id = b.mandant_id AND `_werbeartikel_1_kmo`.wup_id = b.wup_id AND
        `_werbeartikel_1_kmo`.art_id = b.art_id AND `_werbeartikel_1_kmo`.werbetyp_id = b.werbetyp_id;


    UPDATE `_werbeartikel_1_kmo` SET
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
        FROM dbp_data.aktion_2 AS C
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS A ON C.mandant_id = A.mandant_id AND C.aktion_id = A.aktion_id

        INNER JOIN `_werbeartikel_1_kmo` AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.wup_id = B.wup_id
                AND B.dat_von BETWEEN C.dat_von AND C.dat_bis
        GROUP BY
            A.art_id,
            A.mandant_id,
            A.wup_id,
            B.werbetyp_id
    ) AS b
    WHERE
        `_werbeartikel_1_kmo`.mandant_id = b.mandant_id AND `_werbeartikel_1_kmo`.wup_id = b.wup_id AND
        `_werbeartikel_1_kmo`.art_id = b.art_id AND `_werbeartikel_1_kmo`.werbetyp_id = b.werbetyp_id;


    UPDATE `_werbeartikel_1_kmo` AS `_werbeartikel_1_kmo0` SET
        avq_relevant_fg = 9 FROM (
        SELECT
            B.mandant_id,
            B.wup_id,
            B.art_id,
            A.dat_von,
            A.dat_bis,
            MIN(B.vk_aktion_brutto) AS min_vk_aktion_brutto,
            MAX(B.vk_aktion_brutto) AS max_vk_aktion_brutto,
            MIN(A.aktion_id) AS min_aktion_id,
            MAX(A.aktion_id) AS max_aktion_id,
            COUNT(DISTINCT A.aktion_id) AS anz_aktion_id,
            MIN(COALESCE(x.flag, 0)) AS min_flag,
            MAX(COALESCE(x.flag, 0)) AS max_flag
        FROM dbp_data.aktion_2 AS A
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS B ON A.mandant_id = B.mandant_id AND A.aktion_id = B.aktion_id

        LEFT JOIN (
            SELECT
                mandant_id,
                aktion_id,
                1 AS flag
            FROM dbp_data.l_bonuskauf_2
            GROUP BY
                mandant_id,
                aktion_id,
                flag
        ) AS x ON A.aktion_id = x.aktion_id AND A.mandant_id = x.mandant_id
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
        ) AS c ON A.mandant_id = c.mandant_id AND A.dat_von = c.dat_von AND A.dat_bis = c.dat_bis
        WHERE COALESCE(B.geloescht_sap_fg, 0) <> 1
        GROUP BY
            B.mandant_id,
            B.wup_id,
            B.art_id,
            A.dat_von,
            A.dat_bis
        HAVING min_vk_aktion_brutto = 0 AND max_vk_aktion_brutto = 0 AND max_flag = 1 AND min_flag = 1
    ) AS b
    WHERE
        `_werbeartikel_1_kmo0`.mandant_id = b.mandant_id AND `_werbeartikel_1_kmo0`.wup_id = b.wup_id AND
        `_werbeartikel_1_kmo0`.art_id = b.art_id AND `_werbeartikel_1_kmo0`.dat_von = b.dat_von AND `_werbeartikel_1_kmo0`
        .dat_bis = b.dat_bis AND `_werbeartikel_1_kmo0`.avq_relevant_fg = 1;


    UPDATE `_werbeartikel_1_kmo` SET
        vk_kcard_brutto = b.vk_kcard_brutto FROM (
        SELECT
            A.art_id,
            A.mandant_id,
            A.wup_id,
            B.werbetyp_id,
            MIN(D.preis_aktion) AS vk_kcard_brutto
        FROM dbp_data.aktion_2 AS C
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS A ON C.mandant_id = A.mandant_id AND C.aktion_id = A.aktion_id

        INNER JOIN dbp_data.pmr_angebot_art_wup_zu_2 AS D
            ON
                0 <> A.mandant_id AND 0 <> D.mandant_id AND A.wup_id
                = D.wup_id AND A.art_id = D.art_id AND A.aktion_id = D.aktion_id
        INNER JOIN `_werbeartikel_1_kmo` AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.wup_id = B.wup_id
                AND C.dat_von = B.dat_von AND C.dat_bis = B.dat_bis
        WHERE
            D.preis_aktion <> 0
            AND C.aktion_typ_id <> 'KDP'
        GROUP BY
            A.mandant_id,
            A.art_id,
            A.wup_id,
            B.werbetyp_id
    ) AS b
    WHERE
        `_werbeartikel_1_kmo`.mandant_id = b.mandant_id AND `_werbeartikel_1_kmo`.wup_id = b.wup_id AND
        `_werbeartikel_1_kmo`.art_id = b.art_id AND `_werbeartikel_1_kmo`.werbetyp_id = b.werbetyp_id;


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


    -- kunftige und abgeschlossene aktionen volle anzahl tage
    CREATE OR REPLACE TEMPORARY TABLE _werbetyp_tage_kmo AS
    SELECT
        mandant_id,
        werbetyp_id,
        CASE
            WHEN dat_von >= CURRENT_DATE("Europe/Berlin") OR dat_bis < CURRENT_DATE("Europe/Berlin")
                THEN DATE_DIFF(dat_bis, dat_von, DAY) + 1 -- laufende aktionen anzahl tage start bis heute

            ELSE DATE_DIFF(CURRENT_DATE("Europe/Berlin"), dat_von, DAY)
        END AS anz_tage_aktion
    FROM `_werbeartikel_1_kmo` AS B
    GROUP BY
        mandant_id,
        werbetyp_id,
        anz_tage_aktion;


    CREATE OR REPLACE TEMPORARY TABLE _die_tage_kmo AS
    SELECT
        B.mandant_id,
        A.dat
    FROM dbp_data.tag_2 AS A
    INNER JOIN `_werbeartikel_1_kmo` AS B ON A.dat BETWEEN B.dat_von AND B.dat_bis
    GROUP BY
        B.mandant_id,
        A.dat;


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
            W.kjwo,
            W.werbetyp_id,
            W.dat_von,
            W.dat_bis,
            V.wup_id,
            V.mandant_id,
            V.art_id,
            V.nb_id,
            W.grund_sperrung,
            SUM(V.umsatz_netto) AS umsatz_netto,
            SUM(V.menge) AS menge_,
            COUNT(DISTINCT V.dat) AS z0
        FROM dbp_data.artbew_2 AS V
        INNER JOIN `_werbeartikel_1_kmo` AS W
            ON
                V.mandant_id = W.mandant_id AND V.wup_id = W.wup_id AND V.art_id = W.art_id
                AND V.dat BETWEEN W.dat_von AND W.dat_bis
        WHERE
            V.bewart_id = 1002
            AND (
                V.mandant_id, V.dat) IN (
                SELECT (mandant_id, dat)
                FROM `_die_tage_kmo`
            )
        GROUP BY
            V.mandant_id,
            V.wup_id,
            V.nb_id,
            V.art_id,
            W.kjwo,
            W.werbetyp_id,
            W.dat_von,
            W.dat_bis,
            W.grund_sperrung
        HAVING menge_ > 0
    ) AS t3;


    INSERT INTO `_test1_ff_kmo`
    (SELECT
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
            V.wup_id,
            V.mandant_id,
            V.art_id,
            V.nb_id,
            w.grund_sperrung,
            SUM(V.umsatz_netto) AS umsatz_netto,
            SUM(V.menge) AS menge_,
            COUNT(DISTINCT V.dat) AS z0
        FROM dbp_data.artbew_2 AS V
        INNER JOIN (
            SELECT *
            FROM `_werbeartikel_1_kmo`
            WHERE
                stkl_kopf_fg = 3
                AND (
                    kjwo, werbetyp_id, mandant_id, art_id) NOT IN (SELECT (kjwo, werbetyp_id, mandant_id, art_id)
                FROM `_test1_ff_kmo`)
        ) AS w
            ON
                V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.dat BETWEEN w.dat_von AND w.dat_bis
        WHERE
            V.bewart_id = 1001
            AND (
                V.mandant_id, V.dat) IN (
                SELECT (mandant_id, dat)
                FROM `_die_tage_kmo`
            )
        GROUP BY
            V.mandant_id,
            V.wup_id,
            V.nb_id,
            V.art_id,
            w.kjwo,
            w.werbetyp_id,
            w.dat_von,
            w.dat_bis,
            w.grund_sperrung
        HAVING menge_ > 0
    ) AS t5);


    CREATE OR REPLACE TEMPORARY TABLE _ff_we1_kmo AS
    SELECT
        A.mandant_id,
        A.kjwo,
        A.dat_von,
        A.dat_bis,
        A.werbetyp_id,
        A.wup_id,
        A.nb_id,
        A.art_id
    FROM `_test1_ff_kmo` AS A
    INNER JOIN dbp_data.art_wg_zu_per_2
        AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
    = 2 AND B.dat_bis = DATE '9999-12-31';


    CREATE OR REPLACE TEMPORARY TABLE _ff_we2_kmo AS
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
    FROM `_ff_we1_kmo` AS A
    INNER JOIN (
        SELECT
            A0.mandant_id,
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
        FROM `_ff_we1_kmo` AS A0
        INNER JOIN dbp_data.tag_2 AS B ON B.dat BETWEEN DATE_SUB(A0.dat_von, INTERVAL 7 DAY) AND A0.dat_bis
        GROUP BY
            A0.mandant_id,
            A0.kjwo,
            A0.werbetyp_id,
            dat,
            dat_2
    ) AS b ON A.kjwo = b.kjwo AND A.werbetyp_id = b.werbetyp_id AND A.mandant_id = b.mandant_id;


    CREATE OR REPLACE TEMPORARY TABLE _ff_we3_kmo AS
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
    FROM `_ff_we2_kmo` AS A
    LEFT JOIN (
        SELECT
            B.mandant_id,
            B.wup_id,
            c.werbetyp_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS A
        INNER JOIN dbp_data.lagerbew_det_2 AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_kmo`
            WHERE dat IS NOT NULL
        ) AS c
            ON
                B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch
                = c.dat
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best_2 AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det_2 AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id IN ('WE', 'WL')
            AND CASE
                WHEN
                    A.mandant_id IN (
                        4) AND C1.bestellart_id IN (
                        'UBPX', 'UBP', 'UBP1', 'NBP', 'NBBG', 'UB2', 'UBE', 'NBCZ',
                        'NBPL', 'NBSK', 'NBHR', 'NBRO', 'UBGK', 'UBG1', 'UBG2', 'NZP', 'NZP1', 'NBMD', 'UBP0', 'ZUBZ'
                    ) OR A.mandant_id
                    IN (
                        2, 3, 5, 6, 7, 8) AND C1.bestellart_id IN (
                        'UBPX', 'UBP', 'UBP1', 'NBP', 'NBBG', 'UB2', 'UBE', 'NBCZ',
                        'NBPL', 'NBSK', 'NBHR', 'NBRO', 'UBGK', 'UBG1', 'UBG2', 'NZP', 'NZP1', 'NBMD', 'UBP0'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND A.mandant_id > 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_kmo`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648')
            AND X.wg_id NOT IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 26
                    AND mandant_id > 1
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
            B.wup_id,
            c.werbetyp_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS A
        INNER JOIN dbp_data.lagerbew_det_2 AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_kmo`
            WHERE dat IS NOT NULL
        ) AS c
            ON
                B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch
                = c.dat
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best_2 AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det_2 AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id IN ('WE', 'WL')
            AND X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 26
                    AND mandant_id > 1
            )
            AND A.mandant_id > 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_kmo`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648')
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
        FROM dbp_data.lagerbew_2 AS A
        INNER JOIN dbp_data.lagerbew_det_2 AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_kmo`
            WHERE dat_2 IS NOT NULL
        ) AS c
            ON
                B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best_2 AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det_2 AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id IN ('WE', 'WL')
            AND CASE
                WHEN
                    A.mandant_id IN (
                        4) AND C1.bestellart_id IN (
                        'UBPX', 'UBP', 'UBP1', 'NBP', 'NBBG', 'UB2', 'UBE', 'NBCZ',
                        'NBPL', 'NBSK', 'NBHR', 'NBRO', 'UBGK', 'UBG1', 'UBG2', 'NZP', 'NZP1', 'NBMD', 'UBP0', 'ZUBZ'
                    ) OR A.mandant_id
                    IN (
                        2, 3, 5, 6, 7, 8) AND C1.bestellart_id IN (
                        'UBPX', 'UBP', 'UBP1', 'NBP', 'NBBG', 'UB2', 'UBE', 'NBCZ',
                        'NBPL', 'NBSK', 'NBHR', 'NBRO', 'UBGK', 'UBG1', 'UBG2', 'NZP', 'NZP1', 'NBMD', 'UBP0'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND A.mandant_id > 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_kmo`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648')
            AND X.wg_id NOT IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 26
                    AND mandant_id > 1
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
        FROM dbp_data.lagerbew_2 AS A
        INNER JOIN dbp_data.lagerbew_det_2 AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_kmo`
            WHERE dat_2 IS NOT NULL
        ) AS c
            ON
                B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch = c.dat_2
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        WHERE
            A.vorgangsart_id IN ('WE', 'WL')
            AND X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 26
                    AND mandant_id > 1
            )
            AND A.mandant_id > 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_kmo`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648')
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
        FROM dbp_data.lagerbew_2 AS A
        INNER JOIN dbp_data.lagerbew_det_2 AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN (
            SELECT *
            FROM `_ff_we2_kmo`
            WHERE dat_2 IS NOT NULL
        ) AS c
            ON
                B.mandant_id = c.mandant_id AND B.wup_id = c.wup_id AND B.art_id = c.art_id AND B.dat_buch = DATE_SUB(c.dat_2, INTERVAL 7 DAY)
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        WHERE
            A.vorgangsart_id IN ('WE', 'WL')
            AND (
                X.mandant_id, X.wg_id) IN (
                SELECT (mandant_id, wg_id)
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 30
                    AND mandant_id > 1
            )
            AND A.mandant_id > 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_kmo`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo`
                WHERE dat IS NOT NULL
            )
            AND B.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648')
        GROUP BY
            B.mandant_id,
            c.werbetyp_id,
            B.wup_id,
            B.art_id,
            dat_buch
    )
        AS c ON A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_2 = c.dat_buch
    AND A.werbetyp_id = c.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _stpo_kmo AS
    SELECT
        mandant_id,
        stueckliste_id,
        art_id AS kopf_art
    FROM dbp_data.stueckliste_2 AS A
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id IN (2, 3, 4, 5, 6, 7, 8)
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
        GROUP BY kopf_art
    ) AS b
        ON TRUE;


    CREATE OR REPLACE TEMPORARY TABLE _help_me1_kmo AS
    SELECT
        mandant_id,
        dat
    FROM `_x_ray_kmo`
    WHERE dat IS NOT NULL
    GROUP BY
        mandant_id,
        dat;


    CREATE OR REPLACE TEMPORARY TABLE _help_me2_kmo AS
    SELECT
        mandant_id,
        dat_2
    FROM `_x_ray_kmo`
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
    FROM dbp_data.lagerbew_2 AS A
    INNER JOIN dbp_data.lagerbew_det_2 AS B
        ON
            A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
            AND A.dat_buch = B.dat_buch
    INNER JOIN dbp_data.besch_best_2 AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

    INNER JOIN dbp_data.besch_best_det_2 AS C2
        ON
            B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
            AND B.art_id = C2.art_id
    WHERE
        A.vorgangsart_id IN ('WE', 'WL')
        AND CASE
            WHEN
                A.mandant_id IN (
                    4) AND C1.bestellart_id IN ('UBPX', 'UBP', 'UBP1', 'NBP', 'NBBG', 'UB2', 'UBE', 'NBCZ', 'NBPL',
                'NBSK', 'NBHR', 'NBRO', 'UBGK', 'UBG1', 'UBG2', 'NZP', 'NZP1', 'NBMD', 'UBP0', 'ZUBZ') OR A.mandant_id IN (2, 3,
                5, 6, 7, 8) AND C1.bestellart_id IN (
                    'UBPX', 'UBP', 'UBP1', 'NBP', 'NBBG', 'UB2', 'UBE', 'NBCZ', 'NBPL', 'NBSK',
                    'NBHR', 'NBRO', 'UBGK', 'UBG1', 'UBG2', 'NZP', 'NZP1', 'NBMD', 'UBP0'
                )
                THEN 1
            ELSE 0
        END = 1
        AND A.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me1_kmo`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me2_kmo`
            ) AS t3
        )
        AND A.mandant_id > 1
        AND B.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648');


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
    FROM dbp_data.lagerbew_2 AS A
    INNER JOIN dbp_data.lagerbew_det_2 AS B
        ON
            A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
            AND A.dat_buch = B.dat_buch
    INNER JOIN dbp_data.besch_best_2 AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

    INNER JOIN dbp_data.besch_best_det_2 AS C2
        ON
            B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
            AND B.art_id = C2.art_id
    WHERE
        A.vorgangsart_id IN ('WE', 'WL')
        AND A.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me1_kmo`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me2_kmo`
            ) AS t3
        )
        AND A.mandant_id > 1
        AND B.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648');


    CREATE OR REPLACE TEMPORARY TABLE _x_track1_kmo AS
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
        FROM `_x_ray_kmo`
        WHERE dat IS NOT NULL
    ) AS c
        ON
            A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_buch
            = c.dat
    INNER JOIN dbp_data.art_wg_zu_per_2 AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE (
        A.mandant_id, A.dat_buch) IN (
        SELECT (mandant_id, dat)
        FROM `_help_me1_kmo`
    )
    AND X.wg_id NOT IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 26
            AND mandant_id > 1
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
        FROM `_x_ray_kmo`
        WHERE dat IS NOT NULL
    ) AS c
        ON
            A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_buch
            = c.dat
    INNER JOIN dbp_data.art_wg_zu_per_2 AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE (
        A.mandant_id, A.dat_buch) IN (
        SELECT (mandant_id, dat)
        FROM `_help_me1_kmo`
    )
    AND X.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 26
            AND mandant_id > 1
    )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        c.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _x_track2_kmo AS
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
        FROM `_x_ray_kmo`
        WHERE dat_2 IS NOT NULL
    ) AS c
        ON
            A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_buch
            = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per_2 AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE (
        A.mandant_id, A.dat_buch) IN (
        SELECT (mandant_id, dat_2)
        FROM `_help_me2_kmo`
    )
    AND X.wg_id NOT IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 26
            AND mandant_id > 1
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
        FROM `_x_ray_kmo`
        WHERE dat_2 IS NOT NULL
    ) AS c
        ON
            A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat_buch
            = c.dat_2
    INNER JOIN dbp_data.art_wg_zu_per_2 AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE
        X.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 26
                AND mandant_id > 1
        )
        AND (
            A.mandant_id, A.dat_buch) IN (
            SELECT (mandant_id, dat_2)
            FROM `_help_me2_kmo`
        )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        c.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE `_display_update_kmo` AS (
        SELECT
            b.mandant_id,
            c.werbetyp_id,
            b.wup_id,
            b.art_id,
            b.dat_buch,
            SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 a
        JOIN dbp_data.lagerbew_det_2 b
            ON
                a.mandant_id = b.mandant_id AND
                a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
                a.dat_buch = b.dat_buch
        JOIN (
            SELECT
                c.mandant_id,
                c.werbetyp_id,
                c.lagerbew_beleg_id,
                c.wup_id,
                b.art_id,
                c.dat_buch
            FROM dbp_data.stueckliste_2 a
            JOIN dbp_data.stueckliste_det_2 b
                ON
                    a.mandant_id = b.mandant_id AND
                    a.stueckliste_id = b.stueckliste_id
            JOIN (SELECT
                mandant_id,
                werbetyp_id,
                lagerbew_beleg_id,
                wup_id,
                art_id,
                dat_buch
            FROM `_x_track1_kmo`
            GROUP BY 1, 2, 3, 4, 5, 6
            UNION ALL
            SELECT
                mandant_id,
                werbetyp_id,
                lagerbew_beleg_id,
                wup_id,
                art_id,
                dat_buch
            FROM `_x_track2_kmo`
            GROUP BY 1, 2, 3, 4, 5, 6) c
                ON
                    a.mandant_id = c.mandant_id AND
                    a.art_id = c.art_id
            WHERE a.dat_bis = DATE '9999-12-31'
            GROUP BY 1, 2, 3, 4, 5, 6
        ) c
            ON
                b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
                b.art_id = c.art_id AND
                b.lagerbew_beleg_id = c.lagerbew_beleg_id
        WHERE
            a.vorgangsart_id IN ('WE', 'WL') AND
            b.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648') AND
            b.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat), INTERVAL 7 DAY) FROM `_ff_we3_kmo`
                WHERE dat IS NOT NULL) AND (
                SELECT MAX(dat) FROM `_ff_we3_kmo`
                WHERE dat IS NOT NULL
            )
        GROUP BY 1, 2, 3, 4, 5
    );


    UPDATE `_ff_we3_kmo`
    SET we_menge = b.menge_lagerbew_bme + `_ff_we3_kmo`.we_menge
    FROM (
        SELECT *
        FROM `_display_update_kmo`
    ) b
    WHERE
        `_ff_we3_kmo`.mandant_id = b.mandant_id AND
        `_ff_we3_kmo`.wup_id = b.wup_id AND
        `_ff_we3_kmo`.art_id = b.art_id AND
        `_ff_we3_kmo`.werbetyp_id = b.werbetyp_id AND
        `_ff_we3_kmo`.dat = b.dat_buch AND
        `_ff_we3_kmo`.dat BETWEEN `_ff_we3_kmo`.dat_von AND `_ff_we3_kmo`.dat_bis;


    UPDATE `_ff_we3_kmo`
    SET we_menge_2 = b.menge_lagerbew_bme + `_ff_we3_kmo`.we_menge_2
    FROM (
        SELECT *
        FROM `_display_update_kmo`
    ) b
    WHERE
        `_ff_we3_kmo`.mandant_id = b.mandant_id AND
        `_ff_we3_kmo`.wup_id = b.wup_id AND
        `_ff_we3_kmo`.art_id = b.art_id AND
        `_ff_we3_kmo`.werbetyp_id = b.werbetyp_id AND
        `_ff_we3_kmo`.dat = b.dat_buch AND
        `_ff_we3_kmo`.dat NOT BETWEEN `_ff_we3_kmo`.dat_von AND `_ff_we3_kmo`.dat_bis;


    UPDATE `_ff_we3_kmo` SET
        we_menge_2 = 0 FROM (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.kjwo,
            A.wup_id,
            A.art_id,
            DATE_SUB(A.dat_von, INTERVAL 3 DAY) AS min_dat
        FROM `_ff_we3_kmo` AS A
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        WHERE (
            X.mandant_id, X.wg_id) IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 27
                AND mandant_id > 1
        )
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.kjwo,
            A.wup_id,
            A.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3_kmo`.mandant_id = b.mandant_id AND `_ff_we3_kmo`.wup_id = b.wup_id AND `_ff_we3_kmo`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_kmo`.art_id = b.art_id AND `_ff_we3_kmo`.kjwo = b.kjwo AND `_ff_we3_kmo`.dat < b.min_dat;


    UPDATE `_ff_we3_kmo` SET
        we_menge_2 = 0 FROM (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.kjwo,
            A.wup_id,
            A.art_id,
            DATE_SUB(A.dat_von, INTERVAL 1 DAY) AS min_dat
        FROM `_ff_we3_kmo` AS A
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        WHERE (
            X.mandant_id, X.wg_id) IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 28
                AND mandant_id > 1
        )
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.kjwo,
            A.wup_id,
            A.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3_kmo`.mandant_id = b.mandant_id AND `_ff_we3_kmo`.wup_id = b.wup_id AND `_ff_we3_kmo`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_kmo`.art_id = b.art_id AND `_ff_we3_kmo`.kjwo = b.kjwo AND `_ff_we3_kmo`.dat < b.min_dat;


    UPDATE `_ff_we3_kmo` SET
        we_menge_2 = 0 FROM (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.kjwo,
            A.wup_id,
            A.art_id,
            A.dat_von AS min_dat
        FROM `_ff_we3_kmo` AS A
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        WHERE (
            X.mandant_id, X.wg_id) IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 50
                AND mandant_id > 1
        )
        GROUP BY
            A.mandant_id,
            A.werbetyp_id,
            A.kjwo,
            A.wup_id,
            A.art_id,
            min_dat
    ) AS b
    WHERE
        `_ff_we3_kmo`.mandant_id = b.mandant_id AND `_ff_we3_kmo`.wup_id = b.wup_id AND `_ff_we3_kmo`.werbetyp_id = b.werbetyp_id
        AND `_ff_we3_kmo`.art_id = b.art_id AND `_ff_we3_kmo`.kjwo = b.kjwo AND `_ff_we3_kmo`.dat < b.min_dat;


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
        SUM(CAST(0 AS NUMERIC)) AS menge_aktionsstart
    FROM `_ff_we3_kmo` AS A
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
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id,
        SUM(COALESCE(U.menge_lgbest_erp_frei_bme, 0)) AS menge_aktionsstart
    FROM `_ff_we4_kmo` AS V
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            DATE_SUB(dat_von, INTERVAL 1 DAY) AS dat_von,
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
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    LEFT JOIN dbp_data.marktbestand_erp_2 AS U
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


    UPDATE `_ff_we4_kmo` SET
        menge_aktionsstart = b.menge_aktionsstart FROM (
        SELECT *
        FROM `_mbst_we1_kmo`
        WHERE menge_aktionsstart <> 0
    ) AS b
    WHERE
        `_ff_we4_kmo`.mandant_id = b.mandant_id AND `_ff_we4_kmo`.wup_id = b.wup_id AND `_ff_we4_kmo`.nb_id = b.nb_id AND
        `_ff_we4_kmo`.art_id = b.art_id AND `_ff_we4_kmo`.kjwo = b.kjwo AND `_ff_we4_kmo`.werbetyp_id = b.werbetyp_id;


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
        FROM dbp_data.wupcal_2
        WHERE (
            mandant_id, dat) IN (SELECT (mandant_id, dat)
        FROM `_die_tage_kmo`)
    ) AS b
        ON
            a.wup_id = b.wup_id AND a.mandant_id = b.mandant_id AND b.dat BETWEEN a.dat_von AND
            a.dat_bis
    GROUP BY
        a.kjwo,
        a.werbetyp_id,
        a.mandant_id,
        a.wup_id;


    -- Start Protokollierung Umrechnungsfaktor --


    DELETE FROM dbp_etl_process.avq_protokoll_umrechnung_2
    WHERE (
        kjwo, mandant_id, art_id) IN (
        SELECT (kjwo, mandant_id, art_id)
        FROM `_werbeartikel_1_kmo`
    );


    INSERT INTO dbp_etl_process.avq_protokoll_umrechnung_2 (
        kjwo, mandant_id, art_id, komponente_art_id,
        komponentenmenge_einh_id, stueckliste_id
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
                A.mandant_id,
                A.wup_id,
                A.nb_id,
                A.dat,
                A.bewart_id,
                A.gp_id,
                A.art_id,
                A.aktion_id,
                A.promo_fg,
                A.ean_kasse,
                A.standard_aktion_id,
                A.einkaufsorganisation_id,
                A.herst_id,
                A.mwst_id,
                A.menge,
                A.wrg_2,
                A.umsatz_netto,
                A.diff_umsatz_netto_konz,
                A.umsatz_mwst_betrag,
                A.diff_umsatz_mwst_betrag_konz,
                A.ek_brutto,
                A.diff_ek_brutto_konz,
                A.ek_netto,
                A.diff_ek_netto_konz,
                A.ek_nettonetto,
                A.diff_ek_nettonetto_konz,
                A.ek_kal_basis,
                A.diff_ek_kal_basis_konz,
                A.ek_mep,
                A.diff_ek_mep_konz,
                A.ek_mep_vor_fwu,
                A.ek_mep_vor_fwu_konz,
                A.einstandspreis,
                A.diff_einstandspreis_konz,
                A.logkostenzuschlag,
                A.diff_logkostenzuschlag_konz,
                A.bezugsweg_id,
                A.ek_netto_bnk,
                A.diff_ek_netto_bnk_konz,
                A.ek_netto_bnk_sachk,
                A.diff_ek_netto_bnk_sachk_konz,
                A.posten_id,
                A.bq_findung_id,
                A.ek_gld,
                A.diff_ek_gld_konz,
                A.bonusbasis,
                A.bonusbasis_konz,
                A.bewart_det_id,
                A.wup_bereinigt_fg,
                A.pv_aktion,
                A.pv_aktion_konz,
                A.pv_bby,
                A.pv_bby_konz,
                A.pv_kdn_bby,
                A.pv_kdn_bby_konz,
                A.pv_kdp_bby,
                A.pv_kdp_bby_konz,
                A.pv_aktion_bby,
                A.pv_aktion_bby_konz,
                A.pv_aktion_kdn_bby,
                A.pv_aktion_kdn_bby_konz,
                A.pv_aktion_kdp_bby,
                A.pv_aktion_kdp_bby_konz,
                A.pv_bonrabatt_bby,
                A.pv_bonrabatt_bby_konz,
                A.td_update,
                A.td_insert,
                A.umrechnungskurs_hist,
                A.aktionsart_id_liste_txt,
                A.aktionsart_bez_liste_txt,
                A.aktion_typ_id_liste_txt,
                A.aktion_typ_bez_liste_txt,
                b.stueckliste_id,
                b.komponente_art_id,
                b.komponentenmenge_einh_id,
                ROUND(CAST(COALESCE(C.umrech_faktor, 9999999999) AS NUMERIC), 3) AS menge_
            FROM dbp_data.artbew_2 AS A
            INNER JOIN (
                SELECT
                    A0.mandant_id,
                    A0.stueckliste_id,
                    A0.art_id,
                    B.art_id AS komponente_art_id,
                    B.komponentenmenge,
                    B.komponentenmenge_einh_id,
                    B.dat_von,
                    B.dat_bis
                FROM dbp_data.stueckliste_2 AS A0
                INNER JOIN dbp_data.stueckliste_det_2 AS B
                    ON
                        A0.mandant_id = B.mandant_id AND A0.stueckliste_id = B.stueckliste_id
                INNER JOIN (
                    SELECT
                        mandant_id,
                        art_id,
                        komponente
                    FROM `_werbeartikel_1_kmo`
                    WHERE stkl_kopf_fg IN (1, 2)
                    GROUP BY
                        mandant_id,
                        art_id,
                        komponente
                ) AS c ON A0.mandant_id = c.mandant_id AND A0.art_id = c.art_id AND B.art_id = c.komponente
                WHERE
                    A0.stueckliste_verwendung_id = 3
                    AND B.stueckliste_typ_id = 'M'
            ) AS b
                ON
                    A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.dat BETWEEN b.dat_von
                    AND b.dat_bis
            LEFT JOIN dbp_data.art_umrechnung_faktor_per_2 AS C
                ON
                    b.mandant_id = C.mandant_id AND b.art_id = C.art_id
                    AND b.komponentenmenge_einh_id = C.altnv_menge_einh_id AND C.dat_bis = DATE '9999-12-31'
            WHERE (
                A.mandant_id, A.dat) IN (
                SELECT (mandant_id, dat)
                FROM `_die_tage_kmo`
            )
            AND A.umsatz_netto > 0
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
                v.mandant_id = w.mandant_id AND v.wup_id = w.wup_id AND v.art_id = w.art_id AND v.dat BETWEEN w.dat_von
                AND w.dat_bis
        WHERE v.menge_ = 9999999999
        GROUP BY
            v.mandant_id,
            v.art_id,
            v.stueckliste_id,
            v.komponente_art_id,
            v.komponentenmenge_einh_id,
            w.kjwo
    );


    -- Ende Protokollierung Umrechnungsfaktor --


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
                THEN v.menge_
            ELSE 0
        END) AS menge_mo,
        SUM(CASE
            WHEN X.wtag_id = 2
                THEN v.menge_
            ELSE 0
        END) AS menge_di,
        SUM(CASE
            WHEN X.wtag_id = 3
                THEN v.menge_
            ELSE 0
        END) AS menge_mi,
        SUM(CASE
            WHEN X.wtag_id = 4
                THEN v.menge_
            ELSE 0
        END) AS menge_do,
        SUM(CASE
            WHEN X.wtag_id = 5
                THEN v.menge_
            ELSE 0
        END) AS menge_fr,
        SUM(CASE
            WHEN X.wtag_id = 6
                THEN v.menge_
            ELSE 0
        END) AS menge_sa,
        SUM(CASE
            WHEN X.wtag_id = 7
                THEN v.menge_
            ELSE 0
        END) AS menge_so,
        SUM(v.menge_) AS menge_wo,
        SUM(CASE
            WHEN v.bewart_id = 1002
                THEN v.menge_
            ELSE 0
        END) AS menge_sa2,
        MAX(Z.anz_offen) - COUNT(DISTINCT v.dat) AS tage_menge_0,
        SUM(-- 14.09.2016, -dbay-
            -- aufnahme einer hilfsvariablen zur identifikation von displaykoepfen.
            CAST(0 AS NUMERIC)
        ) AS we_menge,
        SUM(-- 14.09.2016, -dbay-
            -- aufnahme einer hilfsvariablen zur identifikation von displaykoepfen.
            CAST(0 AS NUMERIC)) AS
        menge_aktionsstart,
        SUM(-- 14.09.2016, -dbay-
            -- aufnahme einer hilfsvariablen zur identifikation von displaykoepfen.
            CAST(0 AS NUMERIC)) AS
        we_menge_ab_vorwoche,
        CAST(0 AS NUMERIC) AS hilfe
    FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.dat,
            A.bewart_id,
            A.gp_id,
            A.art_id,
            A.aktion_id,
            A.promo_fg,
            A.ean_kasse,
            A.standard_aktion_id,
            A.einkaufsorganisation_id,
            A.herst_id,
            A.mwst_id,
            A.menge,
            A.wrg_2,
            A.umsatz_netto,
            A.diff_umsatz_netto_konz,
            A.umsatz_mwst_betrag,
            A.diff_umsatz_mwst_betrag_konz,
            A.ek_brutto,
            A.diff_ek_brutto_konz,
            A.ek_netto,
            A.diff_ek_netto_konz,
            A.ek_nettonetto,
            A.diff_ek_nettonetto_konz,
            A.ek_kal_basis,
            A.diff_ek_kal_basis_konz,
            A.ek_mep,
            A.diff_ek_mep_konz,
            A.ek_mep_vor_fwu,
            A.ek_mep_vor_fwu_konz,
            A.einstandspreis,
            A.diff_einstandspreis_konz,
            A.logkostenzuschlag,
            A.diff_logkostenzuschlag_konz,
            A.bezugsweg_id,
            A.ek_netto_bnk,
            A.diff_ek_netto_bnk_konz,
            A.ek_netto_bnk_sachk,
            A.diff_ek_netto_bnk_sachk_konz,
            A.posten_id,
            A.bq_findung_id,
            A.ek_gld,
            A.diff_ek_gld_konz,
            A.bonusbasis,
            A.bonusbasis_konz,
            A.bewart_det_id,
            A.wup_bereinigt_fg,
            A.pv_aktion,
            A.pv_aktion_konz,
            A.pv_bby,
            A.pv_bby_konz,
            A.pv_kdn_bby,
            A.pv_kdn_bby_konz,
            A.pv_kdp_bby,
            A.pv_kdp_bby_konz,
            A.pv_aktion_bby,
            A.pv_aktion_bby_konz,
            A.pv_aktion_kdn_bby,
            A.pv_aktion_kdn_bby_konz,
            A.pv_aktion_kdp_bby,
            A.pv_aktion_kdp_bby_konz,
            A.pv_bonrabatt_bby,
            A.pv_bonrabatt_bby_konz,
            A.td_update,
            A.td_insert,
            A.umrechnungskurs_hist,
            A.aktionsart_id_liste_txt,
            A.aktionsart_bez_liste_txt,
            A.aktion_typ_id_liste_txt,
            A.aktion_typ_bez_liste_txt,
            COALESCE(ROUND(
                CAST(CAST(A.menge AS FLOAT64) * CAST(b.komponentenmenge AS FLOAT64) / COALESCE(C.umrech_faktor, 1000.0000) AS NUMERIC),
                3
            ), A.menge) AS menge_
        FROM dbp_data.artbew_2 AS A
        LEFT JOIN (
            SELECT
                A0.mandant_id,
                A0.art_id,
                B.art_id AS komponente_art_id,
                B.komponentenmenge,
                B.komponentenmenge_einh_id,
                B.dat_von,
                B.dat_bis
            FROM dbp_data.stueckliste_2 AS A0
            INNER JOIN dbp_data.stueckliste_det_2 AS B ON A0.mandant_id = B.mandant_id AND A0.stueckliste_id = B.stueckliste_id

            INNER JOIN (
                SELECT
                    mandant_id,
                    art_id,
                    komponente
                FROM `_werbeartikel_1_kmo`
                WHERE stkl_kopf_fg IN (1, 2)
                GROUP BY
                    mandant_id,
                    art_id,
                    komponente
            ) AS c ON A0.mandant_id = c.mandant_id AND A0.art_id = c.art_id AND B.art_id = c.komponente
            WHERE
                A0.stueckliste_verwendung_id = 3
                AND B.stueckliste_typ_id = 'M'
        ) AS b
            ON
                A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.dat BETWEEN b.dat_von
                AND b.dat_bis
        LEFT JOIN dbp_data.art_umrechnung_faktor_per_2 AS C
            ON
                b.mandant_id = C.mandant_id AND b.art_id = C.art_id
                AND b.komponentenmenge_einh_id = C.altnv_menge_einh_id AND C.dat_bis = DATE '9999-12-31'
        WHERE (
            A.mandant_id, A.dat) IN (
            SELECT (mandant_id, dat)
            FROM `_die_tage_kmo`
        )
        AND A.umsatz_netto > 0
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
            v.mandant_id = w.mandant_id AND v.wup_id = w.wup_id AND v.art_id = w.art_id AND v.dat BETWEEN w.dat_von
            AND w.dat_bis
    INNER JOIN dbp_data.tag_2 AS X ON v.dat = X.dat
    INNER JOIN `_wup_kalender_kmo` AS Z
        ON
            w.kjwo = Z.kjwo AND v.wup_id = Z.wup_id AND v.mandant_id = Z.mandant_id AND w.werbetyp_id
            = Z.werbetyp_id
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
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        V.nb_id,
        SUM(COALESCE(U.menge_lgbest_erp_frei_bme, 0)) AS menge_endbestand
    FROM `_ff_we4_kmo` AS V
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
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    LEFT JOIN dbp_data.marktbestand_erp_2 AS U
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


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2_kmo AS
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
    FROM `_ff_we4_kmo` AS V
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
        FROM `_werbeartikel_1_kmo` AS A
        INNER JOIN dbp_data.tag_2 AS B ON B.dat BETWEEN A.dat_von AND A.dat_bis
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
    INNER JOIN dbp_data.art_2 AS XX ON V.mandant_id = XX.mandant_id AND V.art_id = XX.art_id
    LEFT JOIN dbp_data.marktbestand_erp_2 AS X
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


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2a_kmo AS
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
    FROM `_ff_we4_kmo` AS V
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
        FROM `_werbeartikel_1_kmo` AS A
        INNER JOIN dbp_data.tag_2 AS B ON A.dat_von = B.dat
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
    INNER JOIN dbp_data.art_2 AS XX ON V.mandant_id = XX.mandant_id AND V.art_id = XX.art_id
    LEFT JOIN dbp_data.marktbestand_erp_2 AS X
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


    -- Anzahl Nullbestand Tag_2 2


    UPDATE `_test_we_mbst2a_kmo` SET
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
        FROM dbp_data.marktbestand_erp_2 AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.tag_2 AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 1 DAY) AND A0.dat_bis >= B.dat

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
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
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
        `_test_we_mbst2a_kmo`.mandant_id = b.mandant_id AND `_test_we_mbst2a_kmo`.wup_id = b.wup_id AND
        `_test_we_mbst2a_kmo`.art_id = b.art_id AND `_test_we_mbst2a_kmo`.dat_von = b.dat_von AND `_test_we_mbst2a_kmo`.dat_bis
        = b.dat_bis AND `_test_we_mbst2a_kmo`.werbetyp_id = b.werbetyp_id;


    -- Anzahl Nullbestand Tag_2 3


    UPDATE `_test_we_mbst2a_kmo` SET
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
        FROM dbp_data.marktbestand_erp_2 AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.tag_2 AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 2 DAY) AND A0.dat_bis >= B.dat

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
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
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
        `_test_we_mbst2a_kmo`.mandant_id = b.mandant_id AND `_test_we_mbst2a_kmo`.wup_id = b.wup_id AND
        `_test_we_mbst2a_kmo`.art_id = b.art_id AND `_test_we_mbst2a_kmo`.dat_von = b.dat_von AND `_test_we_mbst2a_kmo`.dat_bis
        = b.dat_bis AND `_test_we_mbst2a_kmo`.werbetyp_id = b.werbetyp_id;


    -- Anzahl Nullbestand Tag_2 4


    UPDATE `_test_we_mbst2a_kmo` SET
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
        FROM dbp_data.marktbestand_erp_2 AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.tag_2 AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 3 DAY) AND A0.dat_bis >= B.dat

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
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
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
        `_test_we_mbst2a_kmo`.mandant_id = b.mandant_id AND `_test_we_mbst2a_kmo`.wup_id = b.wup_id AND
        `_test_we_mbst2a_kmo`.art_id = b.art_id AND `_test_we_mbst2a_kmo`.dat_von = b.dat_von AND `_test_we_mbst2a_kmo`.dat_bis
        = b.dat_bis AND `_test_we_mbst2a_kmo`.werbetyp_id = b.werbetyp_id;


    -- Anzahl Nullbestand Tag_2 5


    UPDATE `_test_we_mbst2a_kmo` SET
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
        FROM dbp_data.marktbestand_erp_2 AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.tag_2 AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 4 DAY) AND A0.dat_bis >= B.dat

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
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
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
        `_test_we_mbst2a_kmo`.mandant_id = b.mandant_id AND `_test_we_mbst2a_kmo`.wup_id = b.wup_id AND
        `_test_we_mbst2a_kmo`.art_id = b.art_id AND `_test_we_mbst2a_kmo`.dat_von = b.dat_von AND `_test_we_mbst2a_kmo`.dat_bis
        = b.dat_bis AND `_test_we_mbst2a_kmo`.werbetyp_id = b.werbetyp_id;


    -- Anzahl Nullbestand Tag_2 6


    UPDATE `_test_we_mbst2a_kmo` SET
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
        FROM dbp_data.marktbestand_erp_2 AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.tag_2 AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 5 DAY) AND A0.dat_bis >= B.dat

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
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
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
        `_test_we_mbst2a_kmo`.mandant_id = b.mandant_id AND `_test_we_mbst2a_kmo`.wup_id = b.wup_id AND
        `_test_we_mbst2a_kmo`.art_id = b.art_id AND `_test_we_mbst2a_kmo`.dat_von = b.dat_von AND `_test_we_mbst2a_kmo`.dat_bis
        = b.dat_bis AND `_test_we_mbst2a_kmo`.werbetyp_id = b.werbetyp_id;


    -- Anzahl Nullbestand Tag_2 7


    UPDATE `_test_we_mbst2a_kmo` SET
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
        FROM dbp_data.marktbestand_erp_2 AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.tag_2 AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 6 DAY) AND A0.dat_bis >= B.dat

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
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
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
        `_test_we_mbst2a_kmo`.mandant_id = b.mandant_id AND `_test_we_mbst2a_kmo`.wup_id = b.wup_id AND
        `_test_we_mbst2a_kmo`.art_id = b.art_id AND `_test_we_mbst2a_kmo`.dat_von = b.dat_von AND `_test_we_mbst2a_kmo`.dat_bis
        = b.dat_bis AND `_test_we_mbst2a_kmo`.werbetyp_id = b.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2b_kmo AS
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
    FROM `_ff_we4_kmo` AS V
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
        FROM `_werbeartikel_1_kmo` AS A
        INNER JOIN dbp_data.tag_2 AS B
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
    INNER JOIN dbp_data.art_2 AS XX ON V.mandant_id = XX.mandant_id AND V.art_id = XX.art_id
    LEFT JOIN dbp_data.marktbestand_erp_2 AS X
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


    CREATE OR REPLACE TEMPORARY TABLE _ff_we5_kmo AS
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
    FROM `_ff_we4_kmo` AS A
    INNER JOIN `_test_we_mbst1_kmo` AS B
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
        CAST(0 AS NUMERIC) AS menge_endbestand,
        CAST(0 AS NUMERIC) AS min_sicherh_bestand,
        CAST(1 AS NUMERIC) AS faktor_flaki,
        0 AS anzahl_nullbestand,
        0 AS anzahl_tage_aktion,
        CAST(0 AS NUMERIC) AS menge_historie_af,
        CAST(0 AS NUMERIC) AS sollbestand,
        0 AS lager_prozent,
        0 AS mhd_zeitraum,
        CAST(0 AS NUMERIC) AS menge_bestand_soll_max,
        CAST(0 AS NUMERIC) AS menge_tag1_7bis13h,
        CAST(0 AS NUMERIC) AS menge_nur_tag1,
        CAST(-1 AS INTEGER) AS bezugsweg_id,
        CAST(0 AS NUMERIC) AS we_menge_vor_aktion,
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
    FROM `_ff_we_artbew_kmo` AS A;


    UPDATE `_ff_we_artbew1_kmo` SET
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
            A.nb_id,
            A.art_id,
            A.we_menge,
            A.we_menge_ab_vorwoche,
            A.menge_aktionsstart,
            A.menge_endbestand,
            F.min_sicherh_bestand,
            F.sollbestand,
            F.bezugsweg_id
        FROM `_ff_we5_kmo` AS A
        LEFT JOIN
            dbp_data.art_wup_status_per_2
                AS F
            ON
                A.mandant_id = F.mandant_id AND A.wup_id = F.wup_id AND
                A.nb_id = F.nb_id AND A.art_id = F.art_id AND F.dat_bis = DATE '9999-12-31'
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id AND `_ff_we_artbew1_kmo`
        .nb_id = b.nb_id AND `_ff_we_artbew1_kmo`.art_id = b.art_id AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo AND
        `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo` SET
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
        FROM `_ff_we5_kmo` AS A
        LEFT JOIN dbp_data.art_2 AS F ON A.mandant_id = F.mandant_id AND A.art_id = F.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id AND `_ff_we_artbew1_kmo`
        .nb_id = b.nb_id AND `_ff_we_artbew1_kmo`.art_id = b.art_id AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo AND
        `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo` SET
        menge_bestand_soll_max = b.menge_bestand_soll_max FROM (
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
        FROM `_ff_we5_kmo` AS A
        LEFT JOIN
            dbp_data.art_wup_nachschub_per_2
                AS F
            ON
                A.mandant_id = F.mandant_id AND A.wup_id = F.wup_id
                AND A.nb_id = F.nb_id AND A.art_id = F.art_id AND F.dat_bis = DATE '9999-12-31'
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id AND `_ff_we_artbew1_kmo`
        .nb_id = b.nb_id AND `_ff_we_artbew1_kmo`.art_id = b.art_id AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo AND
        `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;


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
            B.kjwo,
            B.werbetyp_id,
            B.wup_id AS wup_id0,
            B.mandant_id AS mandant_id0,
            B.art_id,
            SUM(A.menge) AS menge_tag1_7bis13h
        FROM dbp_ods.ods_bon_verkauf_2 AS A
        INNER JOIN `_werbeartikel_1_kmo` AS B
            ON
                A.mandant_id = B.mandant_id AND DATE(A.start_bon_zeile) = B.dat_von AND A.wup_id
                = B.wup_id AND B.art_id / 10 = A.kl_art_id AND CAST(A.start_bon_zeile AS TIME) BETWEEN TIME '07:00:00' AND
                TIME '13:00:00'
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.wup_id,
                A0.werbetyp_id
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.wupcal_2 AS B0
                ON
                    A0.mandant_id = B0.mandant_id AND A0.wup_id = B0.wup_id AND A0.dat_von
                    = B0.dat
            WHERE B0.offen = 1
            GROUP BY
                A0.werbetyp_id,
                A0.wup_id,
                A0.mandant_id
        ) AS x ON A.mandant_id = x.mandant_id AND A.wup_id = x.wup_id AND B.werbetyp_id = x.werbetyp_id
        WHERE A.mandant_id > 1
        GROUP BY
            B.kjwo,
            B.werbetyp_id,
            B.wup_id,
            B.mandant_id,
            B.art_id
        HAVING menge_tag1_7bis13h > 0
    ) AS t5;


    INSERT INTO `_fix_it_kmo`
    (SELECT
        t8.mandant_id0 AS mandant_id,
        t8.werbetyp_id,
        t8.wup_id0 AS wup_id,
        t8.art_id,
        t8.kjwo,
        t8.menge_tag1_7bis13h
    FROM (
        SELECT
            B.kjwo,
            B.werbetyp_id,
            B.wup_id AS wup_id0,
            B.mandant_id AS mandant_id0,
            B.art_id,
            SUM(A.menge) AS menge_tag1_7bis13h
        FROM dbp_ods.ods_bon_verkauf_2 AS A
        INNER JOIN `_werbeartikel_1_kmo` AS B
            ON
                A.mandant_id = B.mandant_id AND DATE(A.start_bon_zeile) BETWEEN B.dat_von
                AND B.dat_bis AND A.wup_id = B.wup_id AND B.art_id / 10 = A.kl_art_id AND CAST(A.start_bon_zeile AS TIME)
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
                FROM `_werbeartikel_1_kmo` AS A0
                INNER JOIN dbp_data.wupcal_2 AS B0
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
            INNER JOIN dbp_data.wupcal_2 AS B1
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
        WHERE A.mandant_id > 1
        GROUP BY
            B.kjwo,
            B.werbetyp_id,
            B.wup_id,
            B.mandant_id,
            B.art_id
        HAVING menge_tag1_7bis13h > 0
    ) AS t8);


    UPDATE `_ff_we_artbew1_kmo` SET
        menge_tag1_7bis13h = b.menge_tag1_7bis13h FROM (
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
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id AND `_ff_we_artbew1_kmo`
        .art_id = b.art_id AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo AND `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;


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
            B.kjwo,
            B.werbetyp_id,
            B.wup_id AS wup_id0,
            B.mandant_id AS mandant_id0,
            B.art_id,
            SUM(A.menge) AS menge_nur_tag1
        FROM dbp_ods.ods_bon_verkauf_2 AS A
        INNER JOIN `_werbeartikel_1_kmo` AS B
            ON
                A.mandant_id = B.mandant_id AND DATE(A.start_bon_zeile) = B.dat_von AND A.wup_id
                = B.wup_id AND B.art_id / 10 = A.kl_art_id
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.wup_id,
                A0.werbetyp_id
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.wupcal_2 AS B0
                ON
                    A0.mandant_id = B0.mandant_id AND A0.wup_id = B0.wup_id AND A0.dat_von
                    = B0.dat
            WHERE B0.offen = 1
            GROUP BY
                A0.werbetyp_id,
                A0.wup_id,
                A0.mandant_id
        ) AS x ON A.mandant_id = x.mandant_id AND A.wup_id = x.wup_id AND B.werbetyp_id = x.werbetyp_id
        WHERE A.mandant_id > 1
        GROUP BY
            B.kjwo,
            B.werbetyp_id,
            B.wup_id,
            B.mandant_id,
            B.art_id
        HAVING menge_nur_tag1 > 0
    ) AS t5;


    INSERT INTO `_fix_it_kmo2`
    (SELECT
        t8.mandant_id0 AS mandant_id,
        t8.werbetyp_id,
        t8.wup_id0 AS wup_id,
        t8.art_id,
        t8.kjwo,
        t8.menge_nur_tag1
    FROM (
        SELECT
            B.kjwo,
            B.werbetyp_id,
            B.wup_id AS wup_id0,
            B.mandant_id AS mandant_id0,
            B.art_id,
            SUM(A.menge) AS menge_nur_tag1
        FROM dbp_ods.ods_bon_verkauf_2 AS A
        INNER JOIN `_werbeartikel_1_kmo` AS B
            ON
                A.mandant_id = B.mandant_id AND DATE(A.start_bon_zeile) BETWEEN B.dat_von
                AND B.dat_bis AND A.wup_id = B.wup_id AND B.art_id / 10 = A.kl_art_id
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
                FROM `_werbeartikel_1_kmo` AS A0
                INNER JOIN dbp_data.wupcal_2 AS B0
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
            INNER JOIN dbp_data.wupcal_2 AS B1
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
        WHERE A.mandant_id > 1
        GROUP BY
            B.kjwo,
            B.werbetyp_id,
            B.wup_id,
            B.mandant_id,
            B.art_id
        HAVING menge_nur_tag1 > 0
    ) AS t8);


    UPDATE `_ff_we_artbew1_kmo` SET
        menge_nur_tag1 = b.menge_nur_tag1 FROM (
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
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id AND `_ff_we_artbew1_kmo`
        .art_id = b.art_id AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo AND `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo` SET
        anzahl_nullbestand = b.anz_tage_null,
        anzahl_minusbestand = b.anz_tage_minus
    FROM `_test_we_mbst2_kmo` AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id AND `_ff_we_artbew1_kmo`
        .nb_id = b.nb_id AND `_ff_we_artbew1_kmo`.art_id = b.art_id AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo AND
        `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo` SET
        anzahl_nullbestand_tag1 = b.anz_null_tag1,
        anzahl_nullbestand_tag2 = b.anz_null_tag2,
        anzahl_nullbestand_tag3 = b.anz_null_tag3,
        anzahl_nullbestand_tag4 = b.anz_null_tag4,
        anzahl_nullbestand_tag5 = b.anz_null_tag5,
        anzahl_nullbestand_tag6 = b.anz_null_tag6,
        anzahl_nullbestand_tag7 = b.anz_null_tag7,
        anzahl_minusbestand_tag1 = b.anz_minus_tag1
    FROM `_test_we_mbst2a_kmo` AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id AND `_ff_we_artbew1_kmo`
        .nb_id = b.nb_id AND `_ff_we_artbew1_kmo`.art_id = b.art_id AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo AND
        `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo` SET
        anzahl_nullbestand_tag1bis3 = b.anz_null_tag1_bis_tag3,
        anzahl_minusbestand_tag1bis3 = b.anz_minus_tag1_bis_tag3
    FROM `_test_we_mbst2b_kmo` AS b
    WHERE
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id AND `_ff_we_artbew1_kmo`
        .nb_id = b.nb_id AND `_ff_we_artbew1_kmo`.art_id = b.art_id AND `_ff_we_artbew1_kmo`.kjwo = b.kjwo AND
        `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo` SET
        menge_historie_af = b.menge_historie_af FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            SUM(D.menge) / 42.000 AS menge_historie_af
        FROM `_ff_we_artbew1_kmo` AS A
        INNER JOIN dbp_data.woche_2 AS B ON A.kjwo = B.kjwo
        INNER JOIN dbp_data.woche_kj_kl_2 AS C ON C.akt_wo BETWEEN B.akt_wo - 6 AND (B.akt_wo - 1)
        INNER JOIN dbp_data.artbew_wo_sum_2 AS D
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
        `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo`.wup_id = b.wup_id AND `_ff_we_artbew1_kmo`
        .art_id = b.art_id;


    UPDATE `_ff_we_artbew1_kmo` SET
        anzahl_tage_aktion = b.anz_tage_aktion FROM (
        SELECT
            mandant_id,
            werbetyp_id,
            MAX(anz_tage_aktion) AS anz_tage_aktion
        FROM `_werbetyp_tage_kmo`
        GROUP BY
            mandant_id,
            werbetyp_id
    ) AS b
    WHERE `_ff_we_artbew1_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo` SET
        we_menge_ab_vorwoche = `_ff_we_artbew1_kmo`.we_menge
    WHERE TRUE;


    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew2_kmo AS
    SELECT DISTINCT
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
        A.hilfe,
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
        -- Zuspielen der Mutter jetzt ueber die eingefrorenen Daten.
        -- 14.09.2016, -dbay-
        W.mutter_wb_id,
        W.avq_relevant_fg,
        W.vk_vor_aktion_brutto,
        W.vk_aktion_brutto,
        W.vk_kcard_brutto
    FROM `_ff_we_artbew1_kmo` AS A
    INNER JOIN dbp_data.tag_2 AS B
        ON CASE
            WHEN A.werbetyp_id = 1
                THEN DATE_ADD(A.dat_von, INTERVAL 1 DAY)
            ELSE A.dat_von
        END = B.dat
    INNER JOIN dbp_data.tag_2 AS C ON A.dat_bis = C.dat
    INNER JOIN `_werbeartikel_1_kmo`
        AS W ON A.mandant_id = W.mandant_id AND A.wup_id = W.wup_id AND A.art_id = W.art_id
    AND A.dat_von BETWEEN W.dat_von AND W.dat_bis AND A.werbetyp_id = W.werbetyp_id;


    UPDATE `_ff_we_artbew2_kmo` SET
        mutter_wb_id = b.max_komponente,
        we_menge_ab_vorwoche = CASE
            WHEN `_ff_we_artbew2_kmo`.we_menge_ab_vorwoche = 0
                THEN 0.001
            ELSE `_ff_we_artbew2_kmo`.we_menge_ab_vorwoche
        END,
        art_id = b.max_komponente,
        hilfe = 99 FROM (
        SELECT
            mandant_id,
            art_id,
            MAX(komponente) AS max_komponente
        FROM `_werbeartikel_1_kmo`
        WHERE
            stkl_kopf_fg IN (1, 2)
            AND mandant_id <> 4
        GROUP BY
            mandant_id,
            art_id
    ) AS b
    WHERE `_ff_we_artbew2_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew2_kmo`.art_id = b.art_id;


    UPDATE `_ff_we_artbew2_kmo` SET
        mutter_wb_id = b.max_komponente,
        we_menge_ab_vorwoche = CASE
            WHEN `_ff_we_artbew2_kmo`.we_menge_ab_vorwoche = 0
                THEN 0.001
            ELSE `_ff_we_artbew2_kmo`.we_menge_ab_vorwoche
        END,
        art_id = b.max_komponente,
        hilfe = 99,
        anzahl_nullbestand_tag1 = b.anzahl_nullbestand_tag1,
        anzahl_nullbestand_tag1bis3 = b.anzahl_nullbestand_tag1bis3,
        anzahl_nullbestand = b.anzahl_nullbestand FROM (
        SELECT
            A.mandant_id,
            A.art_id,
            MAX(A.komponente) AS max_komponente,
            MIN(B.anzahl_nullbestand_tag1) AS anzahl_nullbestand_tag1,
            MIN(B.anzahl_nullbestand_tag1bis3) AS anzahl_nullbestand_tag1bis3,
            MIN(B.anzahl_nullbestand) AS anzahl_nullbestand
        FROM `_werbeartikel_1_kmo` AS A
        INNER JOIN `_ff_we_artbew2_kmo` AS B ON A.mandant_id = B.mandant_id AND A.komponente = B.art_id
        WHERE
            A.stkl_kopf_fg IN (1, 2)
            AND A.mandant_id = 4
        GROUP BY
            A.mandant_id,
            A.art_id
    ) AS b
    WHERE `_ff_we_artbew2_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew2_kmo`.art_id = b.art_id;


    UPDATE `_ff_we_artbew2_kmo` SET
        we_menge_ab_vorwoche = CASE
            WHEN `_ff_we_artbew2_kmo`.we_menge_ab_vorwoche = 0.001
                THEN 0.0
            ELSE `_ff_we_artbew2_kmo`.we_menge_ab_vorwoche
        END FROM (
        SELECT
            mandant_id,
            komponente AS max_komponente
        FROM `_werbeartikel_1_kmo`
        WHERE stkl_kopf_fg IN (2)
        GROUP BY
            mandant_id,
            max_komponente
    ) AS b
    WHERE `_ff_we_artbew2_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew2_kmo`.art_id = b.max_komponente;


    UPDATE `_ff_we_artbew2_kmo` SET
        mutter_wb_id = b.komponente,
        hilfe = CAST(CASE
            WHEN `_ff_we_artbew2_kmo`.hilfe = 0
                THEN 98
            ELSE `_ff_we_artbew2_kmo`.hilfe
        END AS NUMERIC) FROM (
        SELECT
            mandant_id,
            komponente
        FROM `_werbeartikel_1_kmo`
        WHERE stkl_kopf_fg IN (1, 2)
        GROUP BY
            mandant_id,
            komponente
    ) AS b
    WHERE `_ff_we_artbew2_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew2_kmo`.art_id = b.komponente;


    UPDATE `_ff_we_artbew2_kmo` SET
        mutter_wb_id = b.mutter_wb_id FROM (
        SELECT
            A.mandant_id,
            A.art_id,
            MAX(COALESCE(A.mutter_wb_id, A.art_id)) AS mutter_wb_id
        FROM dbp_data.art_2 AS A
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                MAX(komponente) AS komponente
            FROM `_werbeartikel_1_kmo`
            WHERE stkl_kopf_fg IN (1, 2)
            GROUP BY
                mandant_id,
                art_id
        ) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.komponente
        GROUP BY
            A.mandant_id,
            A.art_id
    ) AS b
    WHERE
        `_ff_we_artbew2_kmo`.mandant_id = b.mandant_id AND `_ff_we_artbew2_kmo`.art_id = b.art_id AND `_ff_we_artbew2_kmo`
        .hilfe IN (98, 99);


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
        SUM(CASE
            WHEN hilfe <> 99
                THEN CAST(tage_menge_0 AS INTEGER)
            ELSE 0
        END) AS tage_menge_0,
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
        SUM(CASE
            WHEN hilfe <> 99
                THEN anzahl_nullbestand
            ELSE 0
        END) AS anzahl_nullbestand,
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
        SUM(CASE
            WHEN hilfe <> 99
                THEN anzahl_minusbestand
            ELSE 0
        END) AS anzahl_minusbestand,
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


    UPDATE `_ff_we_artbew3_kmo` AS `_ff_we_artbew3_kmo0` SET
        menge_aktionsstart = b.menge FROM (
        SELECT
            mandant_id,
            art_id,
            wup_id,
            DATE_ADD(dat, INTERVAL 1 DAY) AS dat_,
            SUM(menge_lgbest_erp_frei_bme) AS menge
        FROM dbp_data.marktbestand_erp_2
        WHERE (
            mandant_id, art_id, wup_id, dat) IN (
            SELECT (mandant_id, art_id, wup_id, DATE_SUB(dat_von, INTERVAL 1 DAY))
            FROM `_ff_we_artbew3_kmo`
            WHERE menge_aktionsstart = 0
        )
        AND menge_lgbest_erp_frei_bme <> 0
        GROUP BY
            mandant_id,
            art_id,
            wup_id,
            dat_
    ) AS b
    WHERE
        `_ff_we_artbew3_kmo0`.mandant_id = b.mandant_id AND `_ff_we_artbew3_kmo0`.art_id = b.art_id AND
        `_ff_we_artbew3_kmo0`.wup_id = b.wup_id AND `_ff_we_artbew3_kmo0`.dat_von = b.dat_;


    DELETE FROM `_ff_we_artbew3_kmo`
    WHERE (
        mandant_id, mutter_wb_id) IN (
        SELECT (AKT.mandant_id, AKTA.art_id)
        FROM dbp_data.aktion_2 AS AKT
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS AKTA
            ON
                AKT.mandant_id = AKTA.mandant_id AND AKT.aktion_id =
                AKTA.aktion_id
        INNER JOIN dbp_data.tag_2 AS X1 ON AKT.dat_von = X1.dat
        WHERE
            AKTA.grund_sperrung IS NULL
            AND AKT.mandant_id IN (8)
            AND STRPOS(AKT.aktion_id, 'J') > 0
            AND LENGTH(TRIM(AKT.aktion_id)) = 9
            AND X1.akt_wo = wkw
        GROUP BY AKT.mandant_id,
        AKTA.art_id
    );


    DELETE FROM dbp_data.werbung_kennzahlen_woche_2
    WHERE (
        kjwo, werbe_typ_id, wup_id, art_id, mandant_id) IN (
        SELECT (kjwo, werbetyp_id, wup_id, art_id, mandant_id)
        FROM `_ff_we_artbew3_kmo`
    );


    INSERT INTO dbp_data.werbung_kennzahlen_woche_2 (
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
    (
        SELECT
            X1.mandant_id,
            X1.kjwo,
            X1.wup_id,
            X1.nb_id,
            X1.art_id,
            X1.werbetyp_id AS werbe_typ_id,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_mo
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_di
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_mi
                WHEN X1.werbetyp_id IN (4, 5, 21, 22)
                    THEN X1.menge_do
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_fr
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.menge_sa
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_so
                ELSE 0
            END AS NUMERIC) AS menge_tag1,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_di
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_mi
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_do
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_fr
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_sa
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.menge_so
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_mo
                ELSE 0
            END AS NUMERIC) AS menge_tag2,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_mi
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_do
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_fr
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_sa
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_so
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.menge_mo
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_di
                ELSE 0
            END AS NUMERIC) AS menge_tag3,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_do
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_fr
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_sa
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_so
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_mo
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.menge_di
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_mi
                ELSE 0
            END AS NUMERIC) AS menge_tag4,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_fr
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_sa
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_so
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_mo
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_di
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.menge_mi
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_do
                ELSE 0
            END AS NUMERIC) AS menge_tag5,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_sa
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_so
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_mo
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_di
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_mi
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.menge_do
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_fr
                ELSE 0
            END AS NUMERIC) AS menge_tag6,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_so
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_mo
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_di
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_mi
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_do
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.menge_fr
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_sa
                ELSE 0
            END AS NUMERIC) AS menge_tag7,
            X1.menge_nur_tag1,
            X1.tage_menge_0,
            X1.menge_endbestand,
            X1.menge_aktionsstart,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_mo
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_di
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_mi
                WHEN X1.werbetyp_id IN (4, 5, 21, 22)
                    THEN X1.umsatz_netto_do
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_fr
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.umsatz_netto_sa
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_so
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag1,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_di
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_mi
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_do
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_fr
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_sa
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.umsatz_netto_so
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_mo
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag2,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_mi
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_do
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_fr
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_sa
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_so
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.umsatz_netto_mo
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_di
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag3,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_do
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_fr
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_sa
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_so
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_mo
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.umsatz_netto_di
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_mi
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag4,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_fr
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_sa
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_so
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_mo
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_di
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.umsatz_netto_mi
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_do
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag5,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_sa
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_so
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_mo
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_di
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_mi
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.umsatz_netto_do
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_fr
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag6,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_so
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_mo
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_di
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_mi
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_do
                WHEN X1.werbetyp_id IN (9, 16, 30)
                    THEN X1.umsatz_netto_fr
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_sa
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag7,
            X1.we_menge,
            X1.min_sicherh_bestand,
            X1.posten_id,
            X1.we_menge_ab_vorwoche AS we_menge_zentral,
            X1.faktor_flaki,
            COALESCE(X1.mutter_wb_id, X1.art_id) AS mutter_wb_id,
            X1.wtag_id_start,
            X1.wtag_id_ende,
            X1.menge_historie_af,
            CAST(CASE
                WHEN X1.anzahl_tage_aktion < X1.anzahl_nullbestand
                    THEN X1.anzahl_tage_aktion
                ELSE X1.anzahl_nullbestand
            END AS INTEGER) AS anzahl_nullbestand,
            CAST(X1.anzahl_tage_aktion AS INTEGER) AS anzahl_tage_aktion,
            X1.menge_tag1_7bis13h,
            CAST(X1.lager_prozent AS INTEGER),
            CAST(X1.mhd_zeitraum AS INTEGER),
            X1.sollbestand,
            X1.menge_bestand_soll_max,
            0 AS werbenachvermarktung_fg,
            X1.we_menge_vor_aktion,
            CAST(X1.bezugsweg_id AS INTEGER),
            CAST(X1.anzahl_nullbestand_tag1 AS INTEGER) AS anzahl_nullbestand_tag1,
            CAST(X1.anzahl_nullbestand_tag2 AS INTEGER) AS anzahl_nullbestand_tag2,
            CAST(X1.anzahl_nullbestand_tag3 AS INTEGER) AS anzahl_nullbestand_tag3,
            CAST(X1.anzahl_nullbestand_tag4 AS INTEGER) AS anzahl_nullbestand_tag4,
            CAST(X1.anzahl_nullbestand_tag5 AS INTEGER) AS anzahl_nullbestand_tag5,
            CAST(X1.anzahl_nullbestand_tag6 AS INTEGER) AS anzahl_nullbestand_tag6,
            CAST(X1.anzahl_nullbestand_tag7 AS INTEGER) AS anzahl_nullbestand_tag7,
            CAST(X1.anzahl_nullbestand_tag1bis3 AS INTEGER) AS anzahl_nullbestand_tag1bis3,
            CAST(X1.anzahl_minusbestand AS INTEGER) AS anzahl_minusbestand,
            CAST(X1.anzahl_minusbestand_tag1 AS INTEGER) AS anzahl_minusbestand_tag1,
            CAST(X1.anzahl_minusbestand_tag1bis3 AS INTEGER) AS anzahl_minusbestand_tag1bis3,
            X1.avq_relevant_fg,
            X2.default_wrg AS wrg_id,
            CAST(X1.menge_sa2 AS NUMERIC) AS menge_sa2,
            X1.vk_vor_aktion_brutto,
            X1.vk_aktion_brutto,
            X1.vk_kcard_brutto,
            CURRENT_TIMESTAMP(),
            CURRENT_TIMESTAMP()
        FROM `_ff_we_artbew3_kmo` AS X1
        INNER JOIN dbp_data.mandant_2 AS X2 ON X1.mandant_id = X2.mandant_id
        GROUP BY
            X1.kjwo,
            X1.wup_id,
            X1.nb_id,
            X1.mandant_id,
            X1.art_id,
            werbe_typ_id,
            menge_tag1,
            menge_tag2,
            menge_tag3,
            menge_tag4,
            menge_tag5,
            menge_tag6,
            menge_tag7,
            X1.tage_menge_0,
            X1.menge_endbestand,
            X1.menge_aktionsstart,
            umsatz_netto_tag1,
            umsatz_netto_tag2,
            umsatz_netto_tag3,
            umsatz_netto_tag4,
            umsatz_netto_tag5,
            umsatz_netto_tag6,
            umsatz_netto_tag7,
            X1.we_menge,
            X1.min_sicherh_bestand,
            X1.posten_id,
            we_menge_zentral,
            X1.faktor_flaki,
            mutter_wb_id,
            X1.wtag_id_start,
            X1.wtag_id_ende,
            X1.menge_historie_af,
            anzahl_nullbestand,
            X1.anzahl_tage_aktion,
            X1.menge_tag1_7bis13h,
            X1.menge_nur_tag1,
            X1.lager_prozent,
            X1.mhd_zeitraum,
            X1.sollbestand,
            X1.menge_bestand_soll_max,
            werbenachvermarktung_fg,
            X1.bezugsweg_id,
            X1.we_menge_vor_aktion,
            X1.anzahl_nullbestand_tag1,
            X1.anzahl_nullbestand_tag1bis3,
            X1.anzahl_minusbestand,
            X1.anzahl_minusbestand_tag1,
            X1.anzahl_minusbestand_tag1bis3,
            X1.avq_relevant_fg,
            wrg_id,
            X1.anzahl_nullbestand_tag2,
            X1.anzahl_nullbestand_tag3,
            X1.anzahl_nullbestand_tag4,
            X1.anzahl_nullbestand_tag5,
            X1.anzahl_nullbestand_tag6,
            X1.anzahl_nullbestand_tag7,
            X1.vk_vor_aktion_brutto,
            X1.vk_aktion_brutto,
            X1.vk_kcard_brutto,
            X1.menge_sa2,
            CURRENT_TIMESTAMP()
    );


    CREATE OR REPLACE TEMPORARY TABLE _not_in1_kmo AS
    SELECT *
    FROM `_werbeartikel_1_kmo`
    WHERE (
        kjwo, wup_id, mandant_id, art_id, werbetyp_id) NOT IN (
        SELECT (kjwo, wup_id, mandant_id, art_id, werbetyp_id)
        FROM `_ff_we_artbew2_kmo`
    );


    CREATE OR REPLACE TEMPORARY TABLE _ff_we1_kmo_not_in AS
    SELECT
        A.mandant_id,
        A.kjwo,
        A.dat_von,
        A.dat_bis,
        A.werbetyp_id,
        A.wup_id,
        A.art_id
    FROM `_not_in1_kmo` AS A
    INNER JOIN dbp_data.art_wg_zu_per_2
        AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
    = 2 AND B.dat_bis = DATE '9999-12-31';


    CREATE OR REPLACE TEMPORARY TABLE _ff_we2_kmo_not_in AS
    SELECT
        A.mandant_id,
        A.kjwo,
        A.dat_von,
        A.dat_bis,
        A.werbetyp_id,
        A.wup_id,
        A.art_id,
        b.dat,
        DATE_SUB(b.dat, INTERVAL 7 DAY) AS dat_2
    FROM `_ff_we1_kmo_not_in` AS A
    INNER JOIN (
        SELECT
            A0.kjwo,
            A0.werbetyp_id,
            B.dat
        FROM `_ff_we1_kmo_not_in` AS A0
        INNER JOIN dbp_data.tag_2 AS B ON B.dat BETWEEN A0.dat_von AND A0.dat_bis
        GROUP BY
            A0.kjwo,
            A0.werbetyp_id,
            B.dat
    ) AS b ON A.kjwo = b.kjwo AND A.werbetyp_id = b.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _ff_we3_kmo_not_in AS
    SELECT
        A.mandant_id,
        A.werbetyp_id,
        A.dat_von,
        A.dat_bis,
        A.kjwo,
        A.dat,
        A.wup_id,
        A.art_id,
        COALESCE(b.menge_lagerbew_bme, 0) AS we_menge,
        COALESCE(c.menge_lagerbew_bme, 0) AS we_menge_2
    FROM `_ff_we2_kmo_not_in` AS A
    LEFT JOIN (
        SELECT
            B.mandant_id,
            C.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS A
        INNER JOIN dbp_data.lagerbew_det_2 AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN `_ff_we2_kmo_not_in` AS C
            ON
                B.mandant_id = C.mandant_id AND B.wup_id = C.wup_id AND B.art_id = C.art_id
                AND B.dat_buch = C.dat
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best_2 AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det_2 AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id IN ('WE', 'WL')
            AND CASE
                WHEN
                    A.mandant_id IN (
                        4) AND C1.bestellart_id IN (
                        'UBPX', 'UBP', 'UBP1', 'NBP', 'NBBG', 'UB2', 'UBE', 'NBCZ',
                        'NBPL', 'NBSK', 'NBHR', 'NBRO', 'UBGK', 'UBG1', 'UBG2', 'NZP', 'NZP1', 'NBMD', 'UBP0', 'ZUBZ'
                    ) OR A.mandant_id
                    IN (
                        2, 3, 5, 6, 7, 8) AND C1.bestellart_id IN (
                        'UBPX', 'UBP', 'UBP1', 'NBP', 'NBBG', 'UB2', 'UBE', 'NBCZ',
                        'NBPL', 'NBSK', 'NBHR', 'NBRO', 'UBGK', 'UBG1', 'UBG2', 'NZP', 'NZP1', 'NBMD', 'UBP0'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND A.mandant_id > 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_kmo_not_in`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo_not_in`
                WHERE dat IS NOT NULL
            )
            AND -- b.betrag_einstandspreis IS NULL AND

            -- rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten.

            -- Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten

            -- "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_2

            -- Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes
            -- -dbay-, 25.05.2018
            B.lager_bewart_id
            NOT IN ('301', '302', '311', '312', '641', '642', '647', '648')
            AND X.wg_id NOT IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 26
                    AND mandant_id > 1
            )
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            C.werbetyp_id
        UNION ALL
        SELECT
            B.mandant_id,
            C.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS A
        INNER JOIN dbp_data.lagerbew_det_2 AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN `_ff_we2_kmo_not_in` AS C
            ON
                B.mandant_id = C.mandant_id AND B.wup_id = C.wup_id AND B.art_id = C.art_id
                AND B.dat_buch = C.dat
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best_2 AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det_2 AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id IN ('WE', 'WL')
            AND X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 26
                    AND mandant_id > 1
            )
            AND A.mandant_id > 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_kmo_not_in`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo_not_in`
                WHERE dat IS NOT NULL
            )
            AND -- b.betrag_einstandspreis IS NULL AND

            -- rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten.

            -- Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten

            -- "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_2

            -- Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes
            -- -dbay-, 25.05.2018
            B.lager_bewart_id
            NOT IN ('301', '302', '311', '312', '641', '642', '647', '648')
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            C.werbetyp_id
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.art_id = b.art_id AND A.dat = b.dat_buch
            AND A.werbetyp_id = b.werbetyp_id
    LEFT JOIN (
        SELECT
            B.mandant_id,
            C.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS A
        INNER JOIN dbp_data.lagerbew_det_2 AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN `_ff_we2_kmo_not_in` AS C
            ON
                B.mandant_id = C.mandant_id AND B.wup_id = C.wup_id AND B.art_id = C.art_id
                AND B.dat_buch = C.dat_2
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best_2 AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det_2 AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id IN ('WE', 'WL')
            AND CASE
                WHEN
                    A.mandant_id IN (
                        4) AND C1.bestellart_id IN (
                        'UBPX', 'UBP', 'UBP1', 'NBP', 'NBBG', 'UB2', 'UBE', 'NBCZ',
                        'NBPL', 'NBSK', 'NBHR', 'NBRO', 'UBGK', 'UBG1', 'UBG2', 'NZP', 'NZP1', 'NBMD', 'UBP0', 'ZUBZ'
                    ) OR A.mandant_id
                    IN (
                        2, 3, 5, 6, 7, 8) AND C1.bestellart_id IN (
                        'UBPX', 'UBP', 'UBP1', 'NBP', 'NBBG', 'UB2', 'UBE', 'NBCZ',
                        'NBPL', 'NBSK', 'NBHR', 'NBRO', 'UBGK', 'UBG1', 'UBG2', 'NZP', 'NZP1', 'NBMD', 'UBP0'
                    )
                    THEN 1
                ELSE 0
            END = 1
            AND A.mandant_id > 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_kmo_not_in`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo_not_in`
                WHERE dat IS NOT NULL
            )
            AND -- b.betrag_einstandspreis IS NULL AND

            -- rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten.

            -- Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten

            -- "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_2

            -- Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes
            -- -dbay-, 25.05.2018
            B.lager_bewart_id
            NOT IN ('301', '302', '311', '312', '641', '642', '647', '648')
            AND X.wg_id NOT IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 26
                    AND mandant_id > 1
            )
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            C.werbetyp_id
        UNION ALL
        SELECT
            B.mandant_id,
            C.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS A
        INNER JOIN dbp_data.lagerbew_det_2 AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN `_ff_we2_kmo_not_in` AS C
            ON
                B.mandant_id = C.mandant_id AND B.wup_id = C.wup_id AND B.art_id = C.art_id
                AND B.dat_buch = C.dat_2
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best_2 AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det_2 AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id IN ('WE', 'WL')
            AND X.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 26
                    AND mandant_id > 1
            )
            AND A.mandant_id > 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_kmo_not_in`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo_not_in`
                WHERE dat IS NOT NULL
            )
            AND -- b.betrag_einstandspreis IS NULL AND

            -- rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten.

            -- Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten

            -- "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_2

            -- Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes
            -- -dbay-, 25.05.2018
            B.lager_bewart_id
            NOT IN ('301', '302', '311', '312', '641', '642', '647', '648')
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            C.werbetyp_id
        UNION ALL
        SELECT
            B.mandant_id,
            C.werbetyp_id,
            B.wup_id,
            B.art_id,
            B.dat_buch,
            SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
        FROM dbp_data.lagerbew_2 AS A
        INNER JOIN dbp_data.lagerbew_det_2 AS B
            ON
                A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
                AND A.dat_buch = B.dat_buch
        INNER JOIN `_ff_we2_kmo_not_in` AS C
            ON
                B.mandant_id = C.mandant_id AND B.wup_id = C.wup_id AND B.art_id = C.art_id
                AND B.dat_buch = DATE_SUB(C.dat_2, INTERVAL 7 DAY)
        INNER JOIN dbp_data.art_wg_zu_per_2 AS X
            ON
                B.mandant_id = X.mandant_id AND B.art_id = X.art_id AND X.arthiertyp_id
                = 2 AND X.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.besch_best_2 AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

        INNER JOIN dbp_data.besch_best_det_2 AS C2
            ON
                B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND
                C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
                AND B.art_id = C2.art_id
        WHERE
            A.vorgangsart_id IN ('WE', 'WL')
            AND (
                X.mandant_id, X.wg_id) IN (
                SELECT (mandant_id, wg_id)
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 30
                    AND mandant_id > 1
            )
            AND A.mandant_id > 1
            AND A.dat_buch BETWEEN (
                SELECT DATE_SUB(MIN(dat_2), INTERVAL 7 DAY)
                FROM `_ff_we2_kmo_not_in`
                WHERE dat_2 IS NOT NULL) AND (
                SELECT MAX(dat)
                FROM `_ff_we2_kmo_not_in`
                WHERE dat IS NOT NULL
            )
            AND -- b.betrag_einstandspreis IS NULL AND

            -- rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten.

            -- Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten

            -- "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_2

            -- Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes
            -- -dbay-, 25.05.2018
            B.lager_bewart_id
            NOT IN ('301', '302', '311', '312', '641', '642', '647', '648')
        GROUP BY
            B.mandant_id,
            B.art_id,
            B.wup_id,
            B.dat_buch,
            C.werbetyp_id
    )
        AS c ON A.mandant_id = c.mandant_id AND A.wup_id = c.wup_id AND A.art_id = c.art_id AND A.dat =
    DATE_ADD(c.dat_buch, INTERVAL 7 DAY) AND A.werbetyp_id = c.werbetyp_id;


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
            kopf_art NOT IN (
                SELECT art_id
                FROM `_ff_we_artbew2_kmo`
            )
        GROUP BY kopf_art
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
    FROM dbp_data.lagerbew_2 AS A
    INNER JOIN dbp_data.lagerbew_det_2 AS B
        ON
            A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
            AND A.dat_buch = B.dat_buch
    INNER JOIN dbp_data.besch_best_2 AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

    INNER JOIN dbp_data.besch_best_det_2 AS C2
        ON
            B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
            AND B.art_id = C2.art_id
    WHERE
        A.vorgangsart_id IN ('WE', 'WL')
        AND CASE
            WHEN
                A.mandant_id IN (
                    4) AND C1.bestellart_id IN ('UBPX', 'UBP', 'UBP1', 'NBP', 'NBBG', 'UB2', 'UBE', 'NBCZ', 'NBPL',
                'NBSK', 'NBHR', 'NBRO', 'UBGK', 'UBG1', 'UBG2', 'NZP', 'NZP1', 'NBMD', 'UBP0', 'ZUBZ') OR A.mandant_id IN (2, 3,
                5, 6, 7, 8) AND C1.bestellart_id IN (
                    'UBPX', 'UBP', 'UBP1', 'NBP', 'NBBG', 'UB2', 'UBE', 'NBCZ', 'NBPL', 'NBSK',
                    'NBHR', 'NBRO', 'UBGK', 'UBG1', 'UBG2', 'NZP', 'NZP1', 'NBMD', 'UBP0'
                )
                THEN 1
            ELSE 0
        END = 1
        AND A.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me11_kmo`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me22_kmo`
            ) AS t3
        )
        AND A.mandant_id > 1
        AND B.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648');


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
    FROM dbp_data.lagerbew_2 AS A
    INNER JOIN dbp_data.lagerbew_det_2 AS B
        ON
            A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
            AND A.dat_buch = B.dat_buch
    INNER JOIN dbp_data.besch_best_2 AS C1 ON B.mandant_id = C1.mandant_id AND B.best_beleg_id = C1.best_beleg_id

    INNER JOIN dbp_data.besch_best_det_2 AS C2
        ON
            B.mandant_id = C2.mandant_id AND B.wup_id = C2.wup_id AND C1.dat_best_beleg = C2.dat_best_beleg AND B.best_beleg_id = C2.best_beleg_id AND B.best_beleg_pos_id = C2.best_beleg_pos_id
            AND B.art_id = C2.art_id
    WHERE
        A.vorgangsart_id IN ('WE', 'WL')
        AND A.dat_buch >= (
            SELECT MIN(dat)
            FROM (
                SELECT MIN(dat) AS dat
                FROM `_help_me11_kmo`
                UNION DISTINCT
                SELECT MIN(dat_2) AS dat
                FROM `_help_me22_kmo`
            ) AS t3
        )
        AND A.mandant_id > 1
        AND B.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648');


    CREATE OR REPLACE TEMPORARY TABLE _x_track1_kmo_not_in AS
    SELECT
        A.mandant_id,
        C.werbetyp_id,
        A.lagerbew_beleg_id,
        A.wup_id,
        A.art_id,
        A.dat_buch,
        SUM(A.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_ekpo_not_in` AS A
    INNER JOIN `_x_ray_kmo_not_in` AS C
        ON
            A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id AND A.art_id = C.art_id AND
            A.dat_buch = C.dat
    INNER JOIN dbp_data.art_wg_zu_per_2 AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE (
        A.mandant_id, A.dat_buch) IN (
        SELECT (mandant_id, dat)
        FROM `_help_me11_kmo`
    )
    AND X.wg_id NOT IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 26
            AND mandant_id > 1
    )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        C.werbetyp_id
    UNION ALL
    SELECT
        A.mandant_id,
        C.werbetyp_id,
        A.lagerbew_beleg_id,
        A.wup_id,
        A.art_id,
        A.dat_buch,
        SUM(A.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_not_ekpo_not_in` AS A
    INNER JOIN `_x_ray_kmo_not_in` AS C
        ON
            A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id AND A.art_id = C.art_id AND
            A.dat_buch = C.dat
    INNER JOIN dbp_data.art_wg_zu_per_2 AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE
        X.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 26
                AND mandant_id > 1
        )
        AND (
            A.mandant_id, A.dat_buch) IN (
            SELECT (mandant_id, dat)
            FROM `_help_me11_kmo`
        )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        C.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _x_track2_kmo_not_in AS
    SELECT
        A.mandant_id,
        C.werbetyp_id,
        A.lagerbew_beleg_id,
        A.wup_id,
        A.art_id,
        A.dat_buch,
        SUM(A.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_ekpo_not_in` AS A
    INNER JOIN `_x_ray_kmo_not_in` AS C
        ON
            A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id AND A.art_id = C.art_id AND
            A.dat_buch = C.dat_2
    INNER JOIN dbp_data.art_wg_zu_per_2 AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE (
        A.mandant_id, A.dat_buch) IN (
        SELECT (mandant_id, dat_2)
        FROM `_help_me22_kmo`
    )
    AND X.wg_id NOT IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_2
        WHERE
            wg_filter_id = 26
            AND mandant_id > 1
    )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        C.werbetyp_id
    UNION ALL
    SELECT
        A.mandant_id,
        C.werbetyp_id,
        A.lagerbew_beleg_id,
        A.wup_id,
        A.art_id,
        A.dat_buch,
        SUM(A.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM `_mseg_package_not_ekpo_not_in` AS A
    INNER JOIN `_x_ray_kmo_not_in` AS C
        ON
            A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id AND A.art_id = C.art_id AND
            A.dat_buch = C.dat_2
    INNER JOIN dbp_data.art_wg_zu_per_2 AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND X.arthiertyp_id
            = 2 AND X.dat_bis = DATE '9999-12-31'
    WHERE
        X.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 26
                AND mandant_id > 1
        )
        AND (
            A.mandant_id, A.dat_buch) IN (
            SELECT (mandant_id, dat_2)
            FROM `_help_me22_kmo`
        )
    GROUP BY
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.art_id,
        A.wup_id,
        A.dat_buch,
        C.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _murks_display_not_in AS
    SELECT
        c.mandant_id,
        c.werbetyp_id,
        c.lagerbew_beleg_id,
        c.wup_id,
        B.art_id,
        c.dat_buch
    FROM dbp_data.stueckliste_2 AS A
    INNER JOIN dbp_data.stueckliste_det_2 AS B ON A.mandant_id = B.mandant_id AND A.stueckliste_id = B.stueckliste_id

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
    ) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.art_id
    WHERE A.dat_bis = DATE '9999-12-31'
    GROUP BY
        c.mandant_id,
        c.werbetyp_id,
        c.lagerbew_beleg_id,
        c.wup_id,
        B.art_id,
        c.dat_buch;


    CREATE OR REPLACE TEMPORARY TABLE _display_update_kmo_not_in AS
    SELECT
        B.mandant_id,
        C.werbetyp_id,
        B.wup_id,
        B.art_id,
        B.dat_buch,
        SUM(B.menge_lagerbew_bme) AS menge_lagerbew_bme
    FROM dbp_data.lagerbew_2 AS A
    INNER JOIN dbp_data.lagerbew_det_2 AS B
        ON
            A.mandant_id = B.mandant_id AND A.lagerbew_beleg_id = B.lagerbew_beleg_id
            AND A.dat_buch = B.dat_buch
    INNER JOIN `_murks_display_not_in` AS C
        ON
            B.mandant_id = C.mandant_id AND B.wup_id = C.wup_id AND B.art_id = C.art_id
            AND B.dat_buch = C.dat_buch
    WHERE
        A.vorgangsart_id IN ('WE', 'WL')
        AND A.dat_buch >= (
            SELECT MIN(dat_buch)
            FROM `_murks_display_not_in`
        )
        AND -- b.betrag_einstandspreis IS NULL AND

        -- rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten.

        -- Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten

        -- "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_2

        -- Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes
        -- -dbay-, 25.05.2018
        B.lager_bewart_id
        NOT IN ('301', '302', '311', '312', '641', '642', '647', '648')
    GROUP BY
        B.mandant_id,
        C.werbetyp_id,
        B.wup_id,
        B.art_id,
        B.dat_buch;


    UPDATE `_ff_we3_kmo_not_in` SET
        we_menge = b.menge_lagerbew_bme + `_ff_we3_kmo_not_in`.we_menge FROM (
        SELECT
            A.mandant_id,
            A.werbetyp_id,
            A.wup_id,
            A.art_id,
            A.dat_buch,
            A.menge_lagerbew_bme
        FROM `_display_update_kmo_not_in` AS A
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
                A.mandant_id = b.mandant_id AND A.werbetyp_id = b.werbetyp_id AND A.dat_buch BETWEEN b.dat_von
                AND b.dat_bis
    ) AS b
    WHERE
        `_ff_we3_kmo_not_in`.mandant_id = b.mandant_id AND `_ff_we3_kmo_not_in`.wup_id = b.wup_id AND `_ff_we3_kmo_not_in`
        .art_id = b.art_id AND `_ff_we3_kmo_not_in`.werbetyp_id = b.werbetyp_id AND `_ff_we3_kmo_not_in`.dat = b.dat_buch;


    UPDATE `_ff_we3_kmo_not_in` SET
        we_menge_2 = b.menge_lagerbew_bme + `_ff_we3_kmo_not_in`.we_menge_2
    FROM `_display_update_kmo_not_in` AS b
    WHERE
        `_ff_we3_kmo_not_in`.mandant_id = b.mandant_id AND `_ff_we3_kmo_not_in`.wup_id = b.wup_id AND `_ff_we3_kmo_not_in`
        .art_id = b.art_id AND `_ff_we3_kmo_not_in`.werbetyp_id = b.werbetyp_id AND `_ff_we3_kmo_not_in`.dat = DATE_ADD(
            b.dat_buch,
            INTERVAL 7 DAY
        );


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
        SUM(CAST(0 AS NUMERIC)) AS menge_aktionsstart
    FROM `_ff_we3_kmo_not_in` AS A
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
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        SUM(COALESCE(U.menge_lgbest_erp_frei_bme, 0)) AS menge_aktionsstart
    FROM `_ff_we4_kmo_not_in` AS V
    INNER JOIN (
        SELECT
            mandant_id,
            werbetyp_id,
            wup_id,
            art_id,
            DATE_SUB(dat_von, INTERVAL 1 DAY) AS dat_von,
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
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    LEFT JOIN dbp_data.marktbestand_erp_2 AS U
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


    UPDATE `_ff_we4_kmo_not_in` SET
        menge_aktionsstart = b.menge_aktionsstart FROM (
        SELECT *
        FROM `_mbst_we1_kmo_not_in`
        WHERE menge_aktionsstart <> 0
    ) AS b
    WHERE
        `_ff_we4_kmo_not_in`.mandant_id = b.mandant_id AND `_ff_we4_kmo_not_in`.wup_id = b.wup_id AND `_ff_we4_kmo_not_in`
        .art_id = b.art_id AND `_ff_we4_kmo_not_in`.kjwo = b.kjwo AND `_ff_we4_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art_kmo_not_in AS
    SELECT
        mandant_id,
        art_id,
        COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
    FROM dbp_data.art_2 AS A
    WHERE
        dat_bis = DATE '9999-12-31'
        AND (
            mandant_id, art_id) IN (
            SELECT (mandant_id, art_id)
            FROM `_not_in1_kmo`
            GROUP BY mandant_id,
            art_id
        )
    GROUP BY
        mandant_id,
        art_id,
        A.mutter_wb_id;


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst1_kmo_not_in AS
    SELECT
        V.kjwo,
        V.werbetyp_id,
        V.dat_von,
        V.dat_bis,
        V.wup_id,
        V.mandant_id,
        V.art_id,
        SUM(COALESCE(U.menge_lgbest_erp_frei_bme, 0)) AS menge_endbestand
    FROM `_ff_we4_kmo_not_in` AS V
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
            V.mandant_id = w.mandant_id AND V.wup_id = w.wup_id AND V.art_id = w.art_id AND V.werbetyp_id = w.werbetyp_id
            AND (V.kjwo = w.kjwo OR V.kjwo = w.kjwo - 1)
    LEFT JOIN dbp_data.marktbestand_erp_2 AS U
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


    CREATE OR REPLACE TEMPORARY TABLE _ff_we5_kmo_not_in AS
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
    FROM `_ff_we4_kmo_not_in` AS A
    INNER JOIN `_test_we_mbst1_kmo_not_in` AS B
        ON
            A.mandant_id = B.mandant_id AND A.kjwo = B.kjwo AND A.wup_id = B.wup_id
            AND A.art_id = B.art_id AND A.werbetyp_id = B.werbetyp_id
    GROUP BY
        A.kjwo,
        A.werbetyp_id,
        A.dat_von,
        A.dat_bis,
        A.mandant_id,
        A.wup_id,
        A.art_id;


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2_kmo_not_in AS
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
    FROM `_ff_we4_kmo_not_in` AS V
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
        FROM `_werbeartikel_1_kmo` AS A
        INNER JOIN dbp_data.tag_2 AS B ON B.dat BETWEEN A.dat_von AND A.dat_bis
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
    INNER JOIN dbp_data.art_2 AS XX ON V.mandant_id = XX.mandant_id AND V.art_id = XX.art_id
    LEFT JOIN dbp_data.marktbestand_erp_2 AS X
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


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2a_kmo_not_in AS
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
    FROM `_ff_we4_kmo_not_in` AS V
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
        FROM `_werbeartikel_1_kmo` AS A
        INNER JOIN dbp_data.tag_2 AS B ON A.dat_von = B.dat
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
    INNER JOIN dbp_data.art_2 AS XX ON V.mandant_id = XX.mandant_id AND V.art_id = XX.art_id
    LEFT JOIN dbp_data.marktbestand_erp_2 AS X
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


    -- Anzahl Nullbestand Tag_2 2


    UPDATE `_test_we_mbst2a_kmo_not_in` SET
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
        FROM dbp_data.marktbestand_erp_2 AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.tag_2 AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 1 DAY) AND A0.dat_bis >= B.dat

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
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
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
        `_test_we_mbst2a_kmo_not_in`.mandant_id = b.mandant_id AND `_test_we_mbst2a_kmo_not_in`.wup_id = b.wup_id AND
        `_test_we_mbst2a_kmo_not_in`.art_id = b.art_id AND `_test_we_mbst2a_kmo_not_in`.dat_von = b.dat_von AND
        `_test_we_mbst2a_kmo_not_in`.dat_bis = b.dat_bis AND `_test_we_mbst2a_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    -- Anzahl Nullbestand Tag_2 3


    UPDATE `_test_we_mbst2a_kmo_not_in` SET
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
        FROM dbp_data.marktbestand_erp_2 AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.tag_2 AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 2 DAY) AND A0.dat_bis >= B.dat

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
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
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
        `_test_we_mbst2a_kmo_not_in`.mandant_id = b.mandant_id AND `_test_we_mbst2a_kmo_not_in`.wup_id = b.wup_id AND
        `_test_we_mbst2a_kmo_not_in`.art_id = b.art_id AND `_test_we_mbst2a_kmo_not_in`.dat_von = b.dat_von AND
        `_test_we_mbst2a_kmo_not_in`.dat_bis = b.dat_bis AND `_test_we_mbst2a_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    -- Anzahl Nullbestand Tag_2 4


    UPDATE `_test_we_mbst2a_kmo_not_in` SET
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
        FROM dbp_data.marktbestand_erp_2 AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.tag_2 AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 3 DAY) AND A0.dat_bis >= B.dat

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
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
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
        `_test_we_mbst2a_kmo_not_in`.mandant_id = b.mandant_id AND `_test_we_mbst2a_kmo_not_in`.wup_id = b.wup_id AND
        `_test_we_mbst2a_kmo_not_in`.art_id = b.art_id AND `_test_we_mbst2a_kmo_not_in`.dat_von = b.dat_von AND
        `_test_we_mbst2a_kmo_not_in`.dat_bis = b.dat_bis AND `_test_we_mbst2a_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    -- Anzahl Nullbestand Tag_2 5


    UPDATE `_test_we_mbst2a_kmo_not_in` SET
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
        FROM dbp_data.marktbestand_erp_2 AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.tag_2 AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 4 DAY) AND A0.dat_bis >= B.dat

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
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
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
        `_test_we_mbst2a_kmo_not_in`.mandant_id = b.mandant_id AND `_test_we_mbst2a_kmo_not_in`.wup_id = b.wup_id AND
        `_test_we_mbst2a_kmo_not_in`.art_id = b.art_id AND `_test_we_mbst2a_kmo_not_in`.dat_von = b.dat_von AND
        `_test_we_mbst2a_kmo_not_in`.dat_bis = b.dat_bis AND `_test_we_mbst2a_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    -- Anzahl Nullbestand Tag_2 6


    UPDATE `_test_we_mbst2a_kmo_not_in` SET
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
        FROM dbp_data.marktbestand_erp_2 AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.tag_2 AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 5 DAY) AND A0.dat_bis >= B.dat

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
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
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
        `_test_we_mbst2a_kmo_not_in`.mandant_id = b.mandant_id AND `_test_we_mbst2a_kmo_not_in`.wup_id = b.wup_id AND
        `_test_we_mbst2a_kmo_not_in`.art_id = b.art_id AND `_test_we_mbst2a_kmo_not_in`.dat_von = b.dat_von AND
        `_test_we_mbst2a_kmo_not_in`.dat_bis = b.dat_bis AND `_test_we_mbst2a_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    -- Anzahl Nullbestand Tag_2 7


    UPDATE `_test_we_mbst2a_kmo_not_in` SET
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
        FROM dbp_data.marktbestand_erp_2 AS A
        INNER JOIN (
            SELECT
                A0.mandant_id,
                A0.werbetyp_id,
                A0.wup_id,
                A0.art_id,
                A0.dat_von,
                A0.dat_bis,
                B.dat
            FROM `_werbeartikel_1_kmo` AS A0
            INNER JOIN dbp_data.tag_2 AS B ON B.dat = DATE_ADD(A0.dat_von, INTERVAL 6 DAY) AND A0.dat_bis >= B.dat

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
                A.mandant_id = w.mandant_id AND A.wup_id = w.wup_id AND A.art_id = w.art_id AND A.dat = w.dat AND A.dat < CURRENT_DATE("Europe/Berlin")
        INNER JOIN dbp_data.art_2 AS XX ON w.mandant_id = XX.mandant_id AND w.art_id = XX.art_id
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
        `_test_we_mbst2a_kmo_not_in`.mandant_id = b.mandant_id AND `_test_we_mbst2a_kmo_not_in`.wup_id = b.wup_id AND
        `_test_we_mbst2a_kmo_not_in`.art_id = b.art_id AND `_test_we_mbst2a_kmo_not_in`.dat_von = b.dat_von AND
        `_test_we_mbst2a_kmo_not_in`.dat_bis = b.dat_bis AND `_test_we_mbst2a_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    CREATE OR REPLACE TEMPORARY TABLE _test_we_mbst2b_kmo_not_in AS
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
    FROM `_ff_we4_kmo_not_in` AS V
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
        FROM `_werbeartikel_1_kmo` AS A
        INNER JOIN dbp_data.tag_2 AS B
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
    INNER JOIN dbp_data.art_2 AS XX ON V.mandant_id = XX.mandant_id AND V.art_id = XX.art_id
    LEFT JOIN dbp_data.marktbestand_erp_2 AS X
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


    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew1_kmo_not_in (
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
        kjwo, werbetyp_id, dat_von, dat_bis, wup_id, mandant_id, art_id, nb_id,
        posten_id, umsatz_netto_mo, umsatz_netto_di, umsatz_netto_mi, umsatz_netto_do, umsatz_netto_fr, umsatz_netto_sa,
        umsatz_netto_so, umsatz_netto_wo, menge_mo, menge_di, menge_mi, menge_do, menge_fr, menge_sa, menge_so, menge_wo,
        tage_menge_0, we_menge, menge_aktionsstart, we_menge_ab_vorwoche, menge_endbestand, min_sicherh_bestand, faktor_flaki,
        anzahl_nullbestand, anzahl_tage_aktion, menge_historie_af, sollbestand, lager_prozent, mhd_zeitraum,
        menge_bestand_soll_max, menge_tag1_7bis13h, menge_nur_tag1, bezugsweg_id, we_menge_vor_aktion, anzahl_nullbestand_tag1,
        anzahl_nullbestand_tag2, anzahl_nullbestand_tag3, anzahl_nullbestand_tag4, anzahl_nullbestand_tag5,
        anzahl_nullbestand_tag6, anzahl_nullbestand_tag7, anzahl_nullbestand_tag1bis3
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
    FROM `_not_in1_kmo`);


    UPDATE `_ff_we_artbew1_kmo_not_in` SET
        we_menge = b.we_menge,
        we_menge_ab_vorwoche = b.we_menge_ab_vorwoche,
        we_menge_vor_aktion = b.we_menge_vor_aktion,
        bezugsweg_id = b.bezugsweg_id,
        menge_aktionsstart = b.menge_aktionsstart,
        menge_endbestand = b.menge_endbestand,
        min_sicherh_bestand = b.min_sicherh_bestand,
        sollbestand = b.sollbestand FROM (
        SELECT
            A.kjwo,
            A.werbetyp_id,
            MIN(A.dat_von) AS dat_von,
            MAX(A.dat_bis) AS dat_bis,
            A.mandant_id,
            A.wup_id,
            A.art_id,
            MAX(A.we_menge) AS we_menge,
            MAX(A.we_menge_ab_vorwoche) AS we_menge_ab_vorwoche,
            MAX(A.we_menge_ab_vorwoche) AS we_menge_vor_aktion,
            MAX(A.menge_aktionsstart) AS menge_aktionsstart,
            MAX(A.menge_endbestand) AS menge_endbestand,
            MAX(F.min_sicherh_bestand) AS min_sicherh_bestand,
            MAX(F.sollbestand) AS sollbestand,
            MAX(F.bezugsweg_id) AS bezugsweg_id
        FROM `_ff_we5_kmo_not_in` AS A
        LEFT JOIN dbp_data.art_wup_status_per_2 AS F
            ON
                A.mandant_id = F.mandant_id AND A.wup_id = F.wup_id AND
                A.art_id = F.art_id AND F.dat_bis = DATE '9999-12-31'
        GROUP BY
            A.kjwo,
            A.werbetyp_id,
            A.mandant_id,
            A.wup_id,
            A.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id AND `_ff_we_artbew1_kmo_not_in`.kjwo = b.kjwo AND
        `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo_not_in` SET
        mhd_zeitraum = b.mhd_zeitraum,
        lager_prozent = b.lager_prozent FROM (
        SELECT
            A.kjwo,
            A.werbetyp_id,
            MIN(A.dat_von) AS dat_von,
            MAX(A.dat_bis) AS dat_bis,
            A.mandant_id,
            A.wup_id,
            A.art_id,
            MAX(F.mhd_zeitraum) AS mhd_zeitraum,
            MAX(F.lager_prozent) AS lager_prozent
        FROM `_ff_we5_kmo_not_in` AS A
        LEFT JOIN dbp_data.art_2 AS F ON A.mandant_id = F.mandant_id AND A.art_id = F.art_id
        GROUP BY
            A.kjwo,
            A.werbetyp_id,
            A.mandant_id,
            A.wup_id,
            A.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id AND `_ff_we_artbew1_kmo_not_in`.kjwo = b.kjwo AND
        `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo_not_in` SET
        menge_bestand_soll_max = b.menge_bestand_soll_max FROM (
        SELECT
            A.kjwo,
            A.werbetyp_id,
            MIN(A.dat_von) AS dat_von,
            MAX(A.dat_bis) AS dat_bis,
            A.mandant_id,
            A.wup_id,
            A.art_id,
            MAX(F.menge_bestand_soll_max) AS menge_bestand_soll_max
        FROM `_ff_we5_kmo_not_in` AS A
        LEFT JOIN dbp_data.art_wup_nachschub_per_2 AS F
            ON
                A.mandant_id = F.mandant_id AND A.wup_id = F.wup_id
                AND A.art_id = F.art_id AND F.dat_bis = DATE '9999-12-31'
        GROUP BY
            A.kjwo,
            A.werbetyp_id,
            A.mandant_id,
            A.wup_id,
            A.art_id
    ) AS b
    WHERE
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id AND `_ff_we_artbew1_kmo_not_in`.kjwo = b.kjwo AND
        `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo_not_in` SET
        anzahl_nullbestand = b.anz_tage_null,
        anzahl_minusbestand = b.anz_tage_minus FROM (
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
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id AND `_ff_we_artbew1_kmo_not_in`.kjwo = b.kjwo AND
        `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo_not_in` SET
        anzahl_nullbestand_tag1 = b.anz_null_tag1,
        anzahl_minusbestand_tag1 = b.anz_minus_tag1,
        anzahl_nullbestand_tag2 = b.anz_null_tag2,
        anzahl_nullbestand_tag3 = b.anz_null_tag3,
        anzahl_nullbestand_tag4 = b.anz_null_tag4,
        anzahl_nullbestand_tag5 = b.anz_null_tag5,
        anzahl_nullbestand_tag6 = b.anz_null_tag6,
        anzahl_nullbestand_tag7 = b.anz_null_tag7 FROM (
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
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id AND `_ff_we_artbew1_kmo_not_in`.kjwo = b.kjwo AND
        `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo_not_in` SET
        anzahl_nullbestand_tag1bis3 = b.anz_null_tag1_bis_tag3,
        anzahl_minusbestand_tag1bis3 = b.anz_minus_tag1_bis_tag3 FROM (
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
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id AND `_ff_we_artbew1_kmo_not_in`.kjwo = b.kjwo AND
        `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo_not_in` SET
        menge_historie_af = b.menge_historie_af FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            SUM(D.menge) / 42.000 AS menge_historie_af
        FROM `_ff_we_artbew1_kmo_not_in` AS A
        INNER JOIN dbp_data.woche_2 AS B ON A.kjwo = B.kjwo
        INNER JOIN dbp_data.woche_kj_kl_2 AS C ON C.akt_wo BETWEEN B.akt_wo - 6 AND (B.akt_wo - 1)
        INNER JOIN dbp_data.artbew_wo_sum_2 AS D
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
        `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo_not_in`.wup_id = b.wup_id AND
        `_ff_we_artbew1_kmo_not_in`.art_id = b.art_id;


    UPDATE `_ff_we_artbew1_kmo_not_in` SET
        anzahl_tage_aktion = b.anz_tage_aktion FROM (
        SELECT
            mandant_id,
            werbetyp_id,
            MAX(anz_tage_aktion) AS anz_tage_aktion
        FROM `_werbetyp_tage_kmo`
        GROUP BY
            mandant_id,
            werbetyp_id
    ) AS b
    WHERE `_ff_we_artbew1_kmo_not_in`.mandant_id = b.mandant_id AND `_ff_we_artbew1_kmo_not_in`.werbetyp_id = b.werbetyp_id;


    UPDATE `_ff_we_artbew1_kmo_not_in` SET
        we_menge_ab_vorwoche = `_ff_we_artbew1_kmo_not_in`.we_menge
    WHERE TRUE;


    CREATE OR REPLACE TEMPORARY TABLE _ff_we_artbew2_kmo_not_in AS
    -- 14.09.2016, -dbay-
    -- Zuspielen der Mutter jetzt ueber die eingefrorenen Daten.
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
        A.hilfe,
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
    FROM `_ff_we_artbew1_kmo_not_in` AS A
    INNER JOIN dbp_data.tag_2 AS B ON A.dat_von = B.dat
    INNER JOIN dbp_data.tag_2 AS C ON A.dat_bis = C.dat
    INNER JOIN `_werbeartikel_1_kmo` AS W
        ON
            A.mandant_id = W.mandant_id AND A.wup_id = W.wup_id AND A.art_id = W.art_id
            AND A.dat_von BETWEEN W.dat_von AND W.dat_bis AND A.werbetyp_id = W.werbetyp_id
    LEFT JOIN `_ff_mutter_art_kmo` AS D ON A.mandant_id = D.mandant_id AND A.art_id = D.art_id;


    DELETE FROM `_ff_we_artbew2_kmo_not_in`
    WHERE (
        mandant_id, mutter_wb_id) IN (
        SELECT (AKT.mandant_id, AKTA.art_id)
        FROM dbp_data.aktion_2 AS AKT
        INNER JOIN dbp_data.aktion_art_wup_zu_2 AS AKTA
            ON
                AKT.mandant_id = AKTA.mandant_id AND AKT.aktion_id =
                AKTA.aktion_id
        INNER JOIN dbp_data.tag_2 AS X1 ON AKT.dat_von = X1.dat
        WHERE
            AKTA.grund_sperrung IS NULL
            AND AKT.mandant_id IN (8)
            AND STRPOS(AKT.aktion_id, 'J') > 0
            AND LENGTH(TRIM(AKT.aktion_id)) = 9
            AND X1.akt_wo = wkw
        GROUP BY AKT.mandant_id,
        AKTA.art_id
    );


    DELETE FROM dbp_data.werbung_kennzahlen_woche_2
    WHERE (
        kjwo, werbe_typ_id, wup_id, art_id, mandant_id) IN (
        SELECT (kjwo, werbetyp_id, wup_id, art_id, mandant_id)
        FROM `_ff_we_artbew2_kmo_not_in`
    ) AND menge_tag1 + menge_tag2 + menge_tag3 + menge_tag4 + menge_tag5 + menge_tag6 +
    menge_tag7 = 0;


    INSERT INTO dbp_data.werbung_kennzahlen_woche_2 (
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
    (
        SELECT
            X1.mandant_id,
            X1.kjwo,
            X1.wup_id,
            X1.nb_id,
            X1.art_id,
            X1.werbetyp_id AS werbe_typ_id,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_mo
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_di
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_mi
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_do
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_fr
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.menge_sa
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_so
                ELSE 0
            END AS NUMERIC) AS menge_tag1,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_di
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_mi
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_do
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_fr
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_sa
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.menge_so
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_mo
                ELSE 0
            END AS NUMERIC) AS menge_tag2,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_mi
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_do
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_fr
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_sa
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_so
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.menge_mo
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_di
                ELSE 0
            END AS NUMERIC) AS menge_tag3,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_do
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_fr
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_sa
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_so
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_mo
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.menge_di
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_mi
                ELSE 0
            END AS NUMERIC) AS menge_tag4,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_fr
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_sa
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_so
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_mo
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_di
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.menge_mi
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_do
                ELSE 0
            END AS NUMERIC) AS menge_tag5,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_sa
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_so
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_mo
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_di
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_mi
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.menge_do
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_fr
                ELSE 0
            END AS NUMERIC) AS menge_tag6,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.menge_so
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.menge_mo
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.menge_di
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.menge_mi
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.menge_do
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.menge_fr
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.menge_sa
                ELSE 0
            END AS NUMERIC) AS menge_tag7,
            X1.menge_nur_tag1,
            X1.tage_menge_0,
            X1.menge_endbestand,
            X1.menge_aktionsstart,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_mo
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_di
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_mi
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_do
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_fr
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.umsatz_netto_sa
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_so
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag1,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_di
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_mi
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_do
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_fr
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_sa
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.umsatz_netto_so
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_mo
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag2,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_mi
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_do
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_fr
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_sa
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_so
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.umsatz_netto_mo
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_di
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag3,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_do
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_fr
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_sa
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_so
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_mo
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.umsatz_netto_di
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_mi
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag4,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_fr
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_sa
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_so
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_mo
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_di
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.umsatz_netto_mi
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_do
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag5,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_sa
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_so
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_mo
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_di
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_mi
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.umsatz_netto_do
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_fr
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag6,
            CAST(CASE
                WHEN X1.werbetyp_id IN (1, 7, 8, 12, 15)
                    THEN X1.umsatz_netto_so
                WHEN X1.werbetyp_id IN (17)
                    THEN X1.umsatz_netto_mo
                WHEN X1.werbetyp_id IN (6, 11, 20, 23, 24)
                    THEN X1.umsatz_netto_di
                WHEN X1.werbetyp_id IN (4, 5, 21)
                    THEN X1.umsatz_netto_mi
                WHEN X1.werbetyp_id IN (10, 13, 18, 29)
                    THEN X1.umsatz_netto_do
                WHEN X1.werbetyp_id IN (9, 30)
                    THEN X1.umsatz_netto_fr
                WHEN X1.werbetyp_id IN (14, 19)
                    THEN X1.umsatz_netto_sa
                ELSE 0
            END AS NUMERIC) AS umsatz_netto_tag7,
            X1.we_menge,
            X1.min_sicherh_bestand,
            X1.posten_id,
            X1.we_menge_ab_vorwoche AS we_menge_zentral,
            X1.faktor_flaki,
            COALESCE(X1.mutter_wb_id, X1.art_id) AS mutter_wb_id,
            X1.wtag_id_start,
            X1.wtag_id_ende,
            X1.menge_historie_af,
            CASE
                WHEN X1.anzahl_tage_aktion < X1.anzahl_nullbestand
                    THEN X1.anzahl_tage_aktion
                ELSE X1.anzahl_nullbestand
            END AS anzahl_nullbestand,
            X1.anzahl_tage_aktion AS anzahl_tage_aktion,
            X1.menge_tag1_7bis13h,
            X1.lager_prozent AS lager_prozent,
            X1.mhd_zeitraum AS mhd_zeitraum,
            X1.sollbestand,
            X1.menge_bestand_soll_max,
            0 AS werbenachvermarktung_fg,
            X1.we_menge_vor_aktion,
            X1.bezugsweg_id AS bezugsweg_id,
            X1.anzahl_nullbestand_tag1 AS anzahl_nullbestand_tag1,
            X1.anzahl_nullbestand_tag2 AS anzahl_nullbestand_tag2,
            X1.anzahl_nullbestand_tag3 AS anzahl_nullbestand_tag3,
            X1.anzahl_nullbestand_tag4 AS anzahl_nullbestand_tag4,
            X1.anzahl_nullbestand_tag5 AS anzahl_nullbestand_tag5,
            X1.anzahl_nullbestand_tag6 AS anzahl_nullbestand_tag6,
            X1.anzahl_nullbestand_tag7 AS anzahl_nullbestand_tag7,
            X1.anzahl_nullbestand_tag1bis3 AS anzahl_nullbestand_tag1bis3,
            X1.anzahl_minusbestand AS anzahl_minusbestand,
            X1.anzahl_minusbestand_tag1 AS anzahl_minusbestand_tag1,
            X1.anzahl_minusbestand_tag1bis3 AS anzahl_minusbestand_tag1bis3,
            X1.avq_relevant_fg,
            X2.default_wrg AS wrg_id,
            X1.menge_sa AS menge_sa,
            X1.vk_vor_aktion_brutto,
            X1.vk_aktion_brutto,
            X1.vk_kcard_brutto,
            CURRENT_TIMESTAMP(),
            CURRENT_TIMESTAMP()
        FROM `_ff_we_artbew2_kmo_not_in` AS X1
        INNER JOIN dbp_data.mandant_2 AS X2 ON X1.mandant_id = X2.mandant_id
    );


    CREATE OR REPLACE TEMPORARY TABLE _preis_mutter_kmo AS
    SELECT
        A.mandant_id,
        A.kjwo,
        A.wup_id,
        A.werbe_typ_id,
        A.mutter_wb_id,
        X.vk_brutto AS preis
    FROM dbp_data.werbung_kennzahlen_woche_2 AS A
    INNER JOIN `_werbeartikel_1_kmo` AS X
        ON
            A.kjwo = X.kjwo AND A.werbe_typ_id = X.werbetyp_id AND A.mandant_id = X.mandant_id
            AND A.wup_id = X.wup_id AND A.mutter_wb_id = X.art_id
    INNER JOIN dbp_data.art_wg_zu_per_2 AS B
        ON
            A.mandant_id = B.mandant_id AND A.mutter_wb_id = B.art_id AND
            B.dat_bis = DATE '9999-12-31' AND B.arthiertyp_id = 2
    WHERE
        A.mutter_wb_id = A.art_id
        AND B.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                wg_filter_id = 44
                AND mandant_id > 1
        )
        AND A.kjwo IN (
            SELECT kjwo
            FROM dbp_data.tag_2
            WHERE akt_wo = wkw
        )
        AND X.vk_brutto <> 0;


    CREATE OR REPLACE TEMPORARY TABLE _preis_kind_kmo AS
    SELECT
        A.mandant_id,
        A.kjwo,
        A.werbe_typ_id,
        A.wup_id,
        A.art_id,
        A.mutter_wb_id,
        X.vk_brutto AS preis_kind,
        B.preis AS preis_mutter,
        CAST(COALESCE(ROUND(B.preis / IF(X.vk_brutto = 0, NULL, X.vk_brutto), 2), 1) AS NUMERIC) AS faktor
    FROM dbp_data.werbung_kennzahlen_woche_2 AS A
    INNER JOIN `_werbeartikel_1_kmo` AS X
        ON
            A.kjwo = X.kjwo AND A.werbe_typ_id = X.werbetyp_id AND A.mandant_id = X.mandant_id
            AND A.wup_id = X.wup_id AND A.art_id = X.art_id
    INNER JOIN
        `_preis_mutter_kmo`
            AS B
        ON A.mandant_id = B.mandant_id AND A.mutter_wb_id = B.mutter_wb_id AND A.wup_id = B.wup_id AND A.kjwo = B.kjwo AND A.werbe_typ_id = B.werbe_typ_id;


    UPDATE dbp_data.werbung_kennzahlen_woche_2 SET
        faktor_flaki = b.faktor FROM (
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
        werbung_kennzahlen_woche.mandant_id = b.mandant_id AND werbung_kennzahlen_woche.wup_id = b.wup_id AND
        werbung_kennzahlen_woche.kjwo = b.kjwo AND werbung_kennzahlen_woche.art_id = b.art_id AND werbung_kennzahlen_woche.mutter_wb_id = b.mutter_wb_id AND werbung_kennzahlen_woche.werbe_typ_id = b.werbe_typ_id;


    UPDATE dbp_data.werbung_kennzahlen_woche_2 SET
        faktor_flaki = 1
    WHERE faktor_flaki = 0;


    DELETE FROM dbp_data.werbung_kennzahlen_woche_2
    WHERE (
        mandant_id, art_id) IN (
        SELECT (mandant_id, kopf_art)
        FROM `_stpo_kmo`
    ) AND menge_tag1 + menge_tag2 + menge_tag3 + menge_tag4 + menge_tag5 + menge_tag6 + menge_tag7 = 0
    AND kjwo IN (
        SELECT kjwo
        FROM dbp_data.tag_2
        WHERE akt_wo = wkw
    );


    CREATE OR REPLACE TEMPORARY TABLE _upd_werbung AS
    SELECT
        A.kjwo,
        A.mandant_id,
        A.art_id,
        MIN(B.posten_id) AS posten_id_neu
    FROM dbp_data.werbung_kennzahlen_woche_2 AS A
    INNER JOIN dbp_data.art_2 AS B
        ON A.mandant_id = B.mandant_id AND -- a.art_id = b.art_id AND (alt)

        -- Zuspielen des Postenkennzeichens jetzt auf Mutterebene!!!
        -- 14.09.2016, -dbay-
        A.mutter_wb_id = B.art_id AND B.dat_bis = DATE '9999-12-31'
    WHERE
        A.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
        AND A.kjwo IN (
            SELECT kjwo
            FROM dbp_data.tag_2
            WHERE akt_wo = wkw
        )
    GROUP BY
        A.kjwo,
        A.mandant_id,
        A.art_id;


    UPDATE dbp_data.werbung_kennzahlen_woche_2 SET
        posten_id = b.posten_id_neu
    FROM `_upd_werbung` AS b
    WHERE
        werbung_kennzahlen_woche.mandant_id = b.mandant_id AND werbung_kennzahlen_woche.art_id = b.art_id AND
        werbung_kennzahlen_woche.kjwo = b.kjwo;


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
        FROM dbp_data.werbung_kennzahlen_woche_2 AS A
        INNER JOIN dbp_data.art_wg_zu_per_2 AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
                = 2 AND B.dat_bis = DATE '9999-12-31'
        WHERE
            B.wg_id IN (
                SELECT wg_id
                FROM dbp_data.wg_filter_zu_2
                WHERE
                    wg_filter_id = 44
                    AND mandant_id > 1
            )
            AND A.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
            AND A.kjwo IN (
                SELECT kjwo
                FROM dbp_data.tag_2
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


    CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art_we_upd_kmo AS
    SELECT
        mandant_id,
        art_id,
        COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
    FROM dbp_data.art_2 AS A
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    GROUP BY
        mandant_id,
        art_id,
        A.mutter_wb_id;


    CREATE OR REPLACE TEMPORARY TABLE _singles_kmo AS
    SELECT mutter_wb_id
    FROM `_ff_mutter_art_we_upd_kmo`
    GROUP BY mutter_wb_id
    HAVING COUNT(*) = 1;


    DELETE FROM `_we_upd_candidates_kmo`
    WHERE mutter_wb_id IN (
        SELECT mutter_wb_id
        FROM `_singles_kmo`
    );


    CREATE OR REPLACE TEMPORARY TABLE _multiples_kmo AS
    SELECT
        mutter_wb_id,
        COUNT(*) AS anzahl
    FROM `_ff_mutter_art_we_upd_kmo`
    GROUP BY mutter_wb_id
    HAVING anzahl > 1;


    DELETE FROM `_we_upd_candidates_kmo`
    WHERE (
        mandant_id, kjwo, werbe_typ_id, mutter_wb_id) IN (
        SELECT (A.mandant_id, A.kjwo, A.werbe_typ_id, A.mutter_wb_id)
        FROM dbp_data.werbung_kennzahlen_woche_2 AS A
        INNER JOIN `_multiples_kmo` AS B ON A.mutter_wb_id = B.mutter_wb_id
        WHERE
            A.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
            AND A.kjwo IN (
                SELECT kjwo
                FROM dbp_data.tag_2
                WHERE akt_wo = wkw
            )
        GROUP BY
            A.mandant_id,
            A.kjwo,
            A.werbe_typ_id,
            A.mutter_wb_id
        HAVING SUM(A.we_menge_zentral) = 0
    );


    UPDATE dbp_data.werbung_kennzahlen_woche_2 SET
        we_menge_zentral = 0.001
    FROM `_we_upd_candidates_kmo` AS b
    WHERE
        werbung_kennzahlen_woche.kjwo = b.kjwo AND werbung_kennzahlen_woche.werbe_typ_id = b.werbe_typ_id AND
        werbung_kennzahlen_woche.mandant_id = b.mandant_id AND werbung_kennzahlen_woche.wup_id = b.wup_id AND
        werbung_kennzahlen_woche.art_id = b.art_id AND werbung_kennzahlen_woche.we_menge_zentral = 0;


    DELETE FROM dbp_data.werbung_kennzahlen_woche_2
    WHERE (
        mandant_id, art_id) IN (
        SELECT (mandant_id, art_id)
        FROM dbp_etl_process.avq_obsolete_artikel_2
    );


    UPDATE dbp_data.werbung_kennzahlen_woche_2 SET
        tage_menge_0 = 1
    WHERE werbe_typ_id = 22 AND mandant_id = 4 AND tage_menge_0 = 7;


    DELETE FROM dbp_data.avq_aktualisierung_2
    WHERE (
        mandant_id, kjwo) IN (
        SELECT (mandant_id, kjwo)
        FROM `_werbeartikel_1_kmo`
    );


    INSERT INTO dbp_data.avq_aktualisierung_2 (mandant_id, kjwo, dat_letzte_aktualisierung)
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
