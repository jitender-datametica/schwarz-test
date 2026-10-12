BEGIN
    DECLARE shopperzeit INT64;

    SET shopperzeit = ${SHOPWO};


    CREATE OR REPLACE TEMPORARY TABLE _dat_von_dat_bis AS
    SELECT
        A.mandant_id,
        b.dat_von,
        c.dat_bis
    FROM dbp_data.mandant_1 AS A
    INNER JOIN (SELECT
        mandant_id,
        MIN(dat) AS dat_von
    FROM dbp_data.werbewoche_kl_1
    WHERE
        akt_kjwo_ww = shopperzeit - 53
        AND mandant_id > 1
    GROUP BY mandant_id) AS b ON A.mandant_id = b.mandant_id
    INNER JOIN (SELECT
        mandant_id,
        MAX(dat) AS dat_bis
    FROM dbp_data.werbewoche_kl_1
    WHERE
        akt_kjwo_ww = shopperzeit
        AND mandant_id > 1
    GROUP BY mandant_id) AS c ON A.mandant_id = c.mandant_id
    WHERE A.mandant_id > 1;


    CREATE OR REPLACE TEMPORARY TABLE _ods_bon_verkauf_summit AS
    SELECT
        Z.bon_id,
        Z.bon_zeile,
        Z.kl_art_id,
        Z.ean_kasse,
        Z.wg_id,
        Z.menge,
        Z.einh_id,
        Z.umsatz_brutto,
        Z.mwst_id,
        Z.erfassung_id,
        Z.aktion_id,
        Z.mandant_id,
        Z.wup_id,
        Z.talon_id,
        Z.start_bon_zeile,
        Z.bon_nr_extern,
        Z.kpos_erfassung_id,
        Z.umsatz_brutto_norm,
        Z.vk_brutto_obb,
        Z.bon_vorgang_id,
        Z.barcode_string,
        Z.bon_dat,
        K.wrg_id
    FROM dbp_spezial.v_ods_bon_verkauf_union_1 AS Z
    INNER JOIN dbp_spezial.v_ods_bon_kopf_union_1 AS K
        ON
            Z.mandant_id = K.mandant_id AND Z.bon_id = K.bon_id
            AND Z.wup_id = K.wup_id
    WHERE
        Z.mandant_id > 1
        AND Z.bon_dat BETWEEN (
            SELECT MIN(dat_von)
            FROM `_dat_von_dat_bis`) AND (
            SELECT MAX(dat_bis)
            FROM `_dat_von_dat_bis`
        );


    UPDATE `_ods_bon_verkauf_summit` SET
        umsatz_brutto = `_ods_bon_verkauf_summit`.umsatz_brutto / b.umrechnungskurs FROM (
        SELECT *
        FROM dbp_data.mandant_wrg_zu_per_1
        WHERE
            CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
            AND von_wrg_id IS NOT NULL
    ) AS b
    WHERE `_ods_bon_verkauf_summit`.mandant_id = b.mandant_id AND `_ods_bon_verkauf_summit`.wrg_id = b.von_wrg_id;


    CREATE OR REPLACE TEMPORARY TABLE _ods_bon_kopf_summit AS
    SELECT *
    FROM dbp_spezial.v_ods_bon_kopf_union_1
    WHERE
        mandant_id > 1
        AND bon_dat BETWEEN (
            SELECT MIN(dat_von)
            FROM `_dat_von_dat_bis`) AND (
            SELECT MAX(dat_bis)
            FROM `_dat_von_dat_bis`
        );


    UPDATE `_ods_bon_kopf_summit` SET
        umsatz_brutto = `_ods_bon_kopf_summit`.umsatz_brutto / b.umrechnungskurs,
        umsatz_mwst = `_ods_bon_kopf_summit`.umsatz_mwst / b.umrechnungskurs FROM (
        SELECT *
        FROM dbp_data.mandant_wrg_zu_per_1
        WHERE
            CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
            AND von_wrg_id IS NOT NULL
    ) AS b
    WHERE `_ods_bon_kopf_summit`.mandant_id = b.mandant_id AND `_ods_bon_kopf_summit`.wrg_id = b.von_wrg_id;


    CREATE OR REPLACE TEMPORARY TABLE _bon_for_missing_aktion_id AS
    SELECT
        A.bon_id,
        A.mandant_id,
        A.kl_art_id,
        MAX(B.aktion_id) AS aktion_id
    FROM dbp_spezial.v_ods_promotion_union_1 AS A
    INNER JOIN dbp_data.l_bonuskauf_1 AS B ON A.bonuskauf_id = B.bonuskauf_id AND A.mandant_id = B.mandant_id
    GROUP BY
        A.bon_id,
        A.mandant_id,
        A.kl_art_id;


    --update only missing_aktion_id


    UPDATE `_ods_bon_verkauf_summit` SET
        aktion_id = b.aktion_id
    FROM `_bon_for_missing_aktion_id` AS b
    WHERE
        `_ods_bon_verkauf_summit`.bon_id = b.bon_id AND `_ods_bon_verkauf_summit`.mandant_id = b.mandant_id AND
        `_ods_bon_verkauf_summit`.kl_art_id = b.kl_art_id AND TRIM(`_ods_bon_verkauf_summit`.aktion_id) = '';


    CREATE OR REPLACE TEMPORARY TABLE _woche AS
    SELECT
        A.mandant_id,
        b.akt_kjwo_ww,
        b.woche_1,
        b.dat_von,
        b.dat_bis,
        c.woche_wn1,
        d.woche_wn2,
        e.woche_wn3
    FROM dbp_data.mandant_1 AS A
    INNER JOIN (
        SELECT
            mandant_id,
            akt_kjwo_ww,
            kjwo_ww AS woche_1,
            MIN(dat) AS dat_von,
            MAX(dat) AS dat_bis
        FROM dbp_data.werbewoche_kl_1
        WHERE
            akt_kjwo_ww = shopperzeit
            AND mandant_id > 1
        GROUP BY
            mandant_id,
            akt_kjwo_ww,
            woche_1
    ) AS b ON A.mandant_id = b.mandant_id
    INNER JOIN (
        SELECT
            mandant_id,
            kjwo_ww AS woche_wn1
        FROM dbp_data.werbewoche_kl_1
        WHERE
            akt_kjwo_ww = shopperzeit - 1
            AND mandant_id > 1
        GROUP BY
            mandant_id,
            woche_wn1
    ) AS c ON A.mandant_id = c.mandant_id
    INNER JOIN (
        SELECT
            mandant_id,
            kjwo_ww AS woche_wn2
        FROM dbp_data.werbewoche_kl_1
        WHERE
            akt_kjwo_ww = shopperzeit - 2
            AND mandant_id > 1
        GROUP BY
            mandant_id,
            woche_wn2
    ) AS d ON A.mandant_id = d.mandant_id
    INNER JOIN (
        SELECT
            mandant_id,
            kjwo_ww AS woche_wn3
        FROM dbp_data.werbewoche_kl_1
        WHERE
            akt_kjwo_ww = shopperzeit - 3
            AND mandant_id > 1
        GROUP BY
            mandant_id,
            woche_wn3
    ) AS e ON A.mandant_id = e.mandant_id
    WHERE A.mandant_id > 1;


    CREATE OR REPLACE TEMPORARY TABLE _akt_dat_von_dat_bis AS
    SELECT
        A.mandant_id,
        b.akt_dat_von,
        c.akt_dat_bis
    FROM dbp_data.mandant_1 AS A
    INNER JOIN (SELECT
        mandant_id,
        MIN(dat) AS akt_dat_von
    FROM dbp_data.werbewoche_kl_1
    WHERE
        akt_kjwo_ww = shopperzeit - 1
        AND mandant_id > 1
    GROUP BY mandant_id) AS b ON A.mandant_id = b.mandant_id
    INNER JOIN (SELECT
        mandant_id,
        MAX(dat) AS akt_dat_bis
    FROM dbp_data.werbewoche_kl_1
    WHERE
        akt_kjwo_ww = shopperzeit
        AND mandant_id > 1
    GROUP BY mandant_id) AS c ON A.mandant_id = c.mandant_id
    WHERE A.mandant_id > 1;


    CREATE OR REPLACE TEMPORARY TABLE _bl_dat_von_dat_bis AS
    SELECT
        A.mandant_id,
        b.bl_dat_von,
        c.bl_dat_bis
    FROM dbp_data.mandant_1 AS A
    INNER JOIN (SELECT
        mandant_id,
        MIN(dat) AS bl_dat_von
    FROM dbp_data.werbewoche_kl_1
    WHERE
        akt_kjwo_ww = shopperzeit - 53
        AND mandant_id > 1
    GROUP BY mandant_id) AS b ON A.mandant_id = b.mandant_id
    INNER JOIN (SELECT
        mandant_id,
        MAX(dat) AS bl_dat_bis
    FROM dbp_data.werbewoche_kl_1
    WHERE
        akt_kjwo_ww = shopperzeit - 2
        AND mandant_id > 1
    GROUP BY mandant_id) AS c ON A.mandant_id = c.mandant_id
    WHERE A.mandant_id > 1;


    CREATE OR REPLACE TEMPORARY TABLE _perf_01 AS
    SELECT
        AKT.mandant_id,
        AKTA.art_id,
        AKTA.wup_id,
        AKT.dat_von,
        AKT.dat_bis,
        AKTA.aktion_thema_id
    FROM dbp_data.aktion_1 AS AKT
    INNER JOIN dbp_data.aktion_art_wup_zu_1 AS AKTA
        ON
            AKT.aktion_id = AKTA.aktion_id AND AKT.mandant_id =
            AKTA.mandant_id
    INNER JOIN `_woche` AS X ON AKT.dat_bis BETWEEN X.dat_von AND X.dat_bis AND AKT.mandant_id = X.mandant_id
    WHERE
        AKTA.grund_sperrung IS NULL
        AND AKT.mandant_id > 1;


    CREATE OR REPLACE TEMPORARY TABLE _hit_the_actions AS
    SELECT
        Y.mandant_id,
        W.wup_id,
        X.woche_1 AS kjwo,
        -1 AS aktion_thema_gruppe_id,
        Y.art_id,
        A.kl_art_id,
        'W' AS muki,
        Y.dat_bis,
        1 AS mengen_faktor,
        A.posten_id,
        0 AS vk_brutto
    FROM `_perf_01` AS Y
    INNER JOIN dbp_data.art_1 AS A ON Y.mandant_id = A.mandant_id AND A.mutter_wb_id IS NULL AND Y.art_id = A.art_id
    INNER JOIN dbp_data.wup_1 AS W
        ON
            Y.wup_id = W.wup_id AND Y.mandant_id = W.mandant_id AND W.nb_id = 0 AND
            Y.dat_von BETWEEN W.dat_von AND W.dat_bis
    INNER JOIN dbp_data.art_wg_zu_per_1 AS AW ON Y.art_id = AW.art_id AND Y.mandant_id = AW.mandant_id AND AW.arthiertyp_id = 2 AND AW.dat_bis = DATE '9999-12-31'
    INNER JOIN dbp_data.wg_per_1 AS WP
        ON
            AW.mandant_id = WP.mandant_id AND AW.arthiertyp_id = WP.arthiertyp_id
            AND AW.wg_id = WP.wg_id AND WP.dat_bis = DATE '9999-12-31'
    INNER JOIN `_woche` AS X ON Y.dat_bis BETWEEN X.dat_von AND X.dat_bis AND Y.mandant_id = X.mandant_id
    GROUP BY
        Y.mandant_id,
        W.wup_id,
        kjwo,
        aktion_thema_gruppe_id,
        Y.art_id,
        A.kl_art_id,
        muki,
        Y.dat_bis,
        mengen_faktor,
        A.posten_id,
        vk_brutto;


    INSERT INTO `_hit_the_actions`
    (
        SELECT
            Y.mandant_id,
            W.wup_id,
            X.woche_1 AS kjwo,
            -1 AS aktion_thema_gruppe_id,
            Y.art_id,
            A.kl_art_id,
            'M' AS muki,
            Y.dat_bis,
            1 AS mengen_faktor,
            A.posten_id,
            0 AS vk_brutto
        FROM `_perf_01` AS Y
        INNER JOIN dbp_data.art_1 AS A ON Y.mandant_id = A.mandant_id AND Y.art_id = A.mutter_wb_id
        INNER JOIN dbp_data.wup_1 AS W
            ON
                Y.wup_id = W.wup_id AND Y.mandant_id = W.mandant_id AND W.nb_id = 0 AND
                Y.dat_von BETWEEN W.dat_von AND W.dat_bis
        INNER JOIN dbp_data.art_wg_zu_per_1 AS AW ON Y.art_id = AW.art_id AND Y.mandant_id = AW.mandant_id AND AW.arthiertyp_id = 2 AND AW.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.wg_per_1 AS WP
            ON
                AW.mandant_id = WP.mandant_id AND AW.arthiertyp_id = WP.arthiertyp_id
                AND AW.wg_id = WP.wg_id AND WP.dat_bis = DATE '9999-12-31'
        INNER JOIN `_woche` AS X ON Y.dat_bis BETWEEN X.dat_von AND X.dat_bis AND Y.mandant_id = X.mandant_id
        GROUP BY
            Y.mandant_id,
            W.wup_id,
            kjwo,
            aktion_thema_gruppe_id,
            Y.art_id,
            A.kl_art_id,
            muki,
            Y.dat_bis,
            mengen_faktor,
            A.posten_id,
            vk_brutto
    );


    UPDATE `_hit_the_actions` AS `_hit_the_actions0` SET
        vk_brutto = CAST(t2.vk_brutto AS INTEGER) FROM (
        SELECT
            t0.kl_art_id,
            A.mandant_id,
            A.wup_id,
            MAX(A.vk_brutto) AS vk_brutto
        FROM dbp_data.art_wup_vk_per_1 AS A
        INNER JOIN (
            SELECT
                mandant_id,
                kl_art_id,
                wup_id,
                dat_bis
            FROM `_hit_the_actions`
            GROUP BY
                mandant_id,
                wup_id,
                kl_art_id,
                dat_bis
        ) AS t0
            ON
                A.mandant_id = t0.mandant_id AND CAST(FLOOR(A.art_id / 10) AS INTEGER) = t0.kl_art_id AND A.wup_id
                = t0.wup_id AND DATE '9999-12-31' BETWEEN A.dat_von AND A.dat_bis
        GROUP BY
            A.mandant_id,
            A.wup_id,
            t0.kl_art_id
    ) AS t2
    WHERE
        `_hit_the_actions0`.mandant_id = t2.mandant_id AND `_hit_the_actions0`.wup_id = t2.wup_id AND `_hit_the_actions0`
        .kl_art_id = t2.kl_art_id;


    UPDATE `_hit_the_actions` SET
        mengen_faktor = CAST(b.mengen_faktor AS INTEGER) FROM (
        SELECT
            H.kjwo,
            H.mandant_id,
            H.wup_id,
            H.art_id AS mu,
            H.kl_art_id AS kind,
            MAX(W.vk_brutto) AS k_br,
            MAX(X.vk_brutto) AS m_br,
            CAST(MAX(X.vk_brutto) AS NUMERIC) / CAST(MAX(W.vk_brutto) AS NUMERIC) AS mengen_faktor
        FROM `_hit_the_actions` AS H
        INNER JOIN dbp_data.art_1 AS A
            ON
                H.mandant_id = A.mandant_id AND H.kl_art_id = A.kl_art_id AND A.dat_bis
                = DATE '9999-12-31'
        INNER JOIN dbp_data.art_wg_zu_per_1 AS WG
            ON
                H.mandant_id = WG.mandant_id AND H.kl_art_id = CAST(FLOOR(WG.art_id / 10) AS INTEGER)
                AND WG.arthiertyp_id = 2 AND WG.dat_bis = DATE '9999-12-31'
        INNER JOIN dbp_data.art_wup_vk_per_1 AS W
            ON
                H.wup_id = W.wup_id AND H.mandant_id = W.mandant_id AND A.art_id
                = W.art_id AND H.dat_bis BETWEEN W.dat_von AND W.dat_bis
        INNER JOIN dbp_data.art_wup_vk_per_1 AS X
            ON
                H.mandant_id = X.mandant_id AND H.art_id = X.art_id AND W.wup_id
                = X.wup_id AND H.dat_bis BETWEEN X.dat_von AND X.dat_bis
        WHERE (
            WG.mandant_id, WG.wg_id) IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu_1
            WHERE
                mandant_id > 1
                AND wg_filter_id = 31
        )
        GROUP BY
            H.kjwo,
            H.mandant_id,
            H.wup_id,
            mu,
            kind
    ) AS b
    WHERE
        `_hit_the_actions`.kjwo = b.kjwo AND `_hit_the_actions`.wup_id = b.wup_id AND `_hit_the_actions`.art_id = b.mu AND
        `_hit_the_actions`.kl_art_id = b.kind AND `_hit_the_actions`.mandant_id = b.mandant_id;


    DELETE FROM dbp_process.bf_hit_the_actions_kmo_1
    WHERE (
        mandant_id, wup_id, kjwo) IN (
        SELECT (mandant_id, wup_id, kjwo)
        FROM `_hit_the_actions`
    );


    INSERT INTO dbp_process.bf_hit_the_actions_kmo_1
    (SELECT
        mandant_id,
        wup_id,
        kjwo,
        aktion_thema_gruppe_id,
        art_id,
        kl_art_id,
        muki,
        dat_bis,
        mengen_faktor,
        posten_id,
        vk_brutto,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM `_hit_the_actions` AS A);


    CREATE OR REPLACE TEMPORARY TABLE _kl_art AS
    SELECT
        mandant_id,
        kl_art_id,
        art_id
    FROM `_hit_the_actions`
    GROUP BY
        mandant_id,
        art_id,
        kl_art_id
    UNION DISTINCT
    SELECT
        mandant_id,
        kl_art_id,
        art_id
    FROM dbp_data.art_1
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id > 1
        AND wg_art_fg = 1
    GROUP BY
        mandant_id,
        art_id,
        kl_art_id;


    CREATE OR REPLACE TEMPORARY TABLE _aktuelle_wg AS
    SELECT
        A.mandant_id,
        CAST(FLOOR(B.art_id / 10) AS INTEGER) AS kl_art_id,
        A.wg_id
    FROM dbp_data.art_wg_zu_per_1 AS A
    INNER JOIN dbp_data.art_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
    WHERE
        A.mandant_id > 1
        AND B.art_id > 0
        AND A.arthiertyp_id = 2
        AND A.dat_bis = DATE '9999-12-31'
        AND B.dat_bis = DATE '9999-12-31';


    CREATE OR REPLACE TEMPORARY TABLE _mutter_art AS
    SELECT
        A.mandant_id,
        A.kl_art_id,
        A.art_id,
        COALESCE(A.mutter_wb_id, A.art_id) AS mutter_wb_id,
        B.wg_id
    FROM dbp_data.art_1 AS A
    INNER JOIN dbp_data.art_wg_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    WHERE
        A.mandant_id > 1
        AND A.dat_bis = DATE '9999-12-31'
        AND (
            A.mandant_id, A.kl_art_id) IN (
            SELECT (mandant_id, kl_art_id)
            FROM `_kl_art`
        );


    CREATE OR REPLACE TEMPORARY TABLE _mutter_wg AS
    SELECT
        mandant_id,
        mutter_wb_id,
        MAX(wg_id) AS wg_id
    FROM `_mutter_art`
    GROUP BY
        mandant_id,
        mutter_wb_id;


    CREATE OR REPLACE TEMPORARY TABLE _wochen AS
    SELECT
        A.mandant_id,
        A.dat
    FROM dbp_data.werbewoche_kl_1 AS A
    INNER JOIN `_woche` AS B ON A.mandant_id = B.mandant_id AND A.akt_kjwo_ww = B.akt_kjwo_ww
    GROUP BY
        A.mandant_id,
        A.dat;


    INSERT INTO dbp_etl_process.shopper_maerkte_1
    (
        SELECT
            mandant_id,
            wup_id,
            CURRENT_TIMESTAMP(),
            CURRENT_TIMESTAMP()
        FROM dbp_ods.ods_bon_kopf_1
        WHERE
            mandant_id > 1
            AND (
                mandant_id, wup_id) NOT IN (
                SELECT (mandant_id, wup_id)
                FROM dbp_etl_process.shopper_maerkte_1
            )
        GROUP BY
            mandant_id,
            wup_id
    );


    CREATE OR REPLACE TEMPORARY TABLE _test_upd AS
    SELECT
        x3.aktion_id,
        x3.mandant_id,
        CAST(FLOOR(X4.art_id / 10) AS INTEGER) AS kl_art_id,
        X4.wup_id,
        x3.dat_von,
        x3.dat_bis
    FROM (
        SELECT
            X1.mandant_id,
            X1.aktion_id,
            X1.dat_von,
            X1.dat_bis
        FROM dbp_data.aktion_1 AS X1
        INNER JOIN dbp_data.werbewoche_kl_1 AS X2
            ON
                X2.dat BETWEEN X1.dat_von AND X1.dat_bis AND X1.mandant_id
                = X2.mandant_id
        INNER JOIN `_dat_von_dat_bis` AS X ON X2.mandant_id = X.mandant_id AND X2.dat BETWEEN X.dat_von AND X.dat_bis
        GROUP BY
            X1.mandant_id,
            X1.aktion_id,
            X1.dat_von,
            X1.dat_bis
    ) AS x3
    INNER JOIN dbp_data.aktion_art_wup_zu_1 AS X4 ON x3.aktion_id = X4.aktion_id AND x3.mandant_id = X4.mandant_id

    WHERE X4.grund_sperrung IS NULL
    GROUP BY
        x3.aktion_id,
        x3.mandant_id,
        kl_art_id,
        X4.wup_id,
        x3.dat_von,
        x3.dat_bis;


    CREATE OR REPLACE TEMPORARY TABLE _test_upd_kopf AS
    SELECT
        X1.mandant_id,
        X1.aktion_id,
        X1.dat_von,
        X1.dat_bis
    FROM dbp_data.aktion_1 AS X1
    INNER JOIN dbp_data.werbewoche_kl_1 AS X2
        ON
            X2.dat BETWEEN X1.dat_von AND X1.dat_bis AND X1.mandant_id =
            X2.mandant_id
    INNER JOIN `_dat_von_dat_bis` AS X ON X2.mandant_id = X.mandant_id AND X2.dat BETWEEN X.dat_von AND X.dat_bis
    GROUP BY
        X1.mandant_id,
        X1.aktion_id,
        X1.dat_von,
        X1.dat_bis;


    CREATE OR REPLACE TEMPORARY TABLE _artbew_complete AS
    SELECT
        M.mandant_id,
        M.dat,
        M.wup_id,
        M.art_id,
        M.aktion_id,
        M.umsatz_netto,
        M.menge,
        M.ek_mep,
        M.einstandspreis
    FROM dbp_data.artbew_1 AS M
    INNER JOIN `_dat_von_dat_bis` AS X ON M.mandant_id = X.mandant_id AND M.dat BETWEEN X.dat_von AND X.dat_bis
    WHERE (
        M.art_id, M.mandant_id) IN (
        SELECT (art_id, mandant_id)
        FROM `_mutter_art`
    )
    AND M.menge > 0;


    CREATE OR REPLACE TEMPORARY TABLE _bon_snapshot AS
    SELECT
        v.bon_id,
        v.kl_art_id,
        B.wg_id,
        COALESCE(v.menge / x0.mengen_faktor, v.menge) AS menge,
        v.umsatz_brutto,
        v.aktion_id,
        v.mandant_id,
        v.wup_id,
        v.talon_id,
        v.start_bon_zeile,
        k.bon_nr,
        k.bon_dat,
        k.kasse_nr,
        k.turnover_fg
    FROM (SELECT
        bon_id,
        kl_art_id,
        wg_id,
        menge,
        umsatz_brutto,
        aktion_id,
        mandant_id,
        wup_id,
        talon_id,
        start_bon_zeile
    FROM `_ods_bon_verkauf_summit` AS A) AS v
    INNER JOIN (SELECT
        bon_id,
        bon_dat,
        kasse_nr,
        turnover_fg,
        wup_id,
        bon_nr,
        mandant_id
    FROM `_ods_bon_kopf_summit` AS A) AS k ON v.mandant_id = k.mandant_id AND v.wup_id = k.wup_id AND v.bon_id = k.bon_id
    INNER JOIN `_aktuelle_wg` AS B ON v.mandant_id = B.mandant_id AND v.kl_art_id = B.kl_art_id
    LEFT JOIN (
        SELECT
            mandant_id,
            wup_id,
            kl_art_id,
            MIN(mengen_faktor) AS mengen_faktor
        FROM `_hit_the_actions`
        GROUP BY
            mandant_id,
            wup_id,
            kl_art_id
        UNION ALL
        SELECT
            mandant_id,
            wup_id,
            kl_art_id,
            AVG(mengen_faktor) AS mengen_faktor
        FROM dbp_process.bf_hit_the_actions_kmo_1
        WHERE (
            mandant_id, wup_id, kl_art_id) NOT IN (
            SELECT (mandant_id, wup_id, kl_art_id)
            FROM `_hit_the_actions`
        )
        GROUP BY
            mandant_id,
            wup_id,
            kl_art_id
    ) AS x0 ON v.mandant_id = x0.mandant_id AND v.kl_art_id = x0.kl_art_id AND v.wup_id = x0.wup_id
    WHERE (
        v.kl_art_id, v.mandant_id) IN (
        SELECT (CAST(kl_art_id AS INTEGER), CAST(mandant_id AS INTEGER))
        FROM `_mutter_art`
    )
    AND v.wg_id <> 980
    AND (
        k.bon_id, k.bon_dat) NOT IN (
        SELECT (bon_id, bon_dat)
        FROM dbp_spezial.v_ods_bon_storno_union_1
    );


    CREATE OR REPLACE TEMPORARY TABLE _bon_keys AS
    SELECT
        mandant_id,
        bon_id
    FROM `_bon_snapshot`
    WHERE (
        mandant_id, kl_art_id) IN (
        SELECT (CAST(mandant_id AS INTEGER), CAST(kl_art_id AS INTEGER))
        FROM `_kl_art`
    )
    GROUP BY
        mandant_id,
        bon_id;


    CREATE OR REPLACE TEMPORARY TABLE _aktionen_bon_snapshot AS
    SELECT
        V.bon_id,
        V.kl_art_id,
        V.wg_id,
        V.menge,
        V.umsatz_brutto,
        V.aktion_id,
        V.mandant_id,
        V.wup_id,
        V.talon_id,
        V.start_bon_zeile,
        V.bon_nr,
        V.bon_dat,
        V.kasse_nr,
        V.turnover_fg
    FROM `_bon_snapshot` AS V
    INNER JOIN `_test_upd_kopf` AS Y
        ON
            V.aktion_id = Y.aktion_id AND V.bon_dat BETWEEN Y.dat_von AND Y.dat_bis AND V.mandant_id
            = Y.mandant_id
    WHERE
        V.aktion_id <> ''
        AND (
            V.mandant_id, V.kl_art_id) IN (
            SELECT (mandant_id, kl_art_id)
            FROM `_mutter_art`
        );


    CREATE OR REPLACE TEMPORARY TABLE _aktionen AS
    SELECT
        V.bon_id,
        V.kl_art_id,
        V.wg_id,
        V.menge,
        V.umsatz_brutto,
        V.aktion_id,
        V.mandant_id,
        V.wup_id,
        V.talon_id,
        V.start_bon_zeile,
        V.bon_nr,
        V.bon_dat,
        V.kasse_nr,
        V.turnover_fg
    FROM `_aktionen_bon_snapshot` AS V
    INNER JOIN `_test_upd` AS Z ON V.aktion_id = Z.aktion_id AND V.mandant_id = Z.mandant_id AND V.wup_id = Z.wup_id AND V.kl_art_id = Z.kl_art_id;


    CREATE OR REPLACE TEMPORARY TABLE _bon_snapshot2 AS
    SELECT
        v.bon_id,
        v.kl_art_id,
        v.wg_id,
        COALESCE(v.menge / x0.mengen_faktor, v.menge) AS menge,
        v.umsatz_brutto,
        v.aktion_id,
        v.mandant_id,
        v.wup_id,
        v.talon_id,
        v.start_bon_zeile,
        k.bon_nr,
        k.bon_dat,
        k.kasse_nr,
        k.turnover_fg
    FROM (SELECT
        bon_id,
        kl_art_id,
        wg_id,
        menge,
        umsatz_brutto,
        aktion_id,
        mandant_id,
        wup_id,
        talon_id,
        start_bon_zeile
    FROM `_ods_bon_verkauf_summit` AS A
    WHERE (
        mandant_id, bon_id) IN (
        SELECT (mandant_id, bon_id)
        FROM `_bon_keys`
    )) AS v
    INNER JOIN (SELECT
        bon_id,
        bon_dat,
        kasse_nr,
        turnover_fg,
        wup_id,
        bon_nr,
        mandant_id
    FROM `_ods_bon_kopf_summit` AS A
    WHERE (
        mandant_id, bon_id) IN (
        SELECT (mandant_id, bon_id)
        FROM `_bon_keys`
    )) AS k ON v.mandant_id = k.mandant_id AND v.wup_id = k.wup_id AND v.bon_id = k.bon_id
    INNER JOIN `_aktuelle_wg` AS B ON v.mandant_id = B.mandant_id AND v.kl_art_id = B.kl_art_id
    LEFT JOIN (
        SELECT
            mandant_id,
            wup_id,
            kl_art_id,
            MIN(mengen_faktor) AS mengen_faktor
        FROM `_hit_the_actions`
        GROUP BY
            mandant_id,
            wup_id,
            kl_art_id
        UNION ALL
        SELECT
            mandant_id,
            wup_id,
            kl_art_id,
            AVG(mengen_faktor) AS mengen_faktor
        FROM dbp_process.bf_hit_the_actions_kmo_1
        WHERE (
            mandant_id, wup_id, kl_art_id) NOT IN (
            SELECT (mandant_id, wup_id, kl_art_id)
            FROM `_hit_the_actions`
        )
        GROUP BY
            mandant_id,
            wup_id,
            kl_art_id
    ) AS x0 ON v.mandant_id = x0.mandant_id AND v.kl_art_id = x0.kl_art_id AND v.wup_id = x0.wup_id
    WHERE
        v.wg_id <> 980
        AND (
            k.bon_id, k.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_spezial.v_ods_bon_storno_union_1
        );


    -- 27.10.2016, -dbay-
    --
    -- Wichtige Ergaenzung auf Marktebene! Damit uns bei gesplitteten Artikelwerbewochen
    -- mit verschiedenen Maerkten (!) selbige nicht mit Aktionsabsatz in die Shoppersuppe
    -- spucken, muessen wir fuer die Kalkulation der aktionsrelevanten Zahlen aus dem 
    -- Marktpool nur diese der jeweiligen Shopperwoche (Hit The Actions) ziehen, die tat-
    -- saechlich eine_1 Aktionsreferenz haben! Sonst darf NUR AF bewertet werden!!!


    CREATE OR REPLACE TEMPORARY TABLE _markets_hta AS
    SELECT
        mandant_id,
        wup_id,
        kl_art_id
    FROM `_hit_the_actions`
    GROUP BY
        mandant_id,
        wup_id,
        kl_art_id;


    /*
    +-------------------------------------------------------------
    + 4. FALL 1 - Verarbeitung
    +-------------------------------------------------------------
    */


    CREATE OR REPLACE TABLE dbp_etl.bf_bons_kpicp_akt_kmo_tmp_1 LIKE dbp_etl.bf_bons_kpicp_akt_kmo;


    INSERT INTO dbp_etl.bf_bons_kpicp_akt_kmo_tmp_1
    (
        SELECT
            XXX.woche_1 AS shopperwoche,
            CAST(t1.mandant_id AS INTEGER) AS mandant_id,
            CAST(t1.wup_id AS INTEGER) AS wup_id,
            t1.bon_dat AS dat,
            CAST(t1.kasse_nr AS INTEGER) AS kasse_nr,
            CAST(t1.bon_nr AS INTEGER) AS bon_nr,
            t1.bon_id,
            CAST(CAST(FLOOR(X.mutter_wb_id / 10) AS INTEGER) AS INTEGER) AS kl_mutter_id_wb,
            X.mutter_wb_id AS mutter_id_wb,
            0 AS ges_umsatz_af,
            0 AS ges_umsatz_sa,
            0 AS ges_umsatz_akt,
            0 AS ges_absatz_af,
            0 AS ges_absatz_sa,
            0 AS ges_absatz_akt,
            CAST(SUM(CASE
                WHEN TRIM(t1.aktion_id) = ''
                    THEN t1.umsatz_brutto
                ELSE 0
            END) AS NUMERIC) AS a_umsatz_af,
            CAST(SUM(CASE
                WHEN TRIM(t1.aktion_id) <> ''
                    THEN t1.umsatz_brutto
                ELSE 0
            END) AS NUMERIC) AS a_umsatz_sa,
            0 AS a_umsatz_akt,
            SUM(CASE
                WHEN TRIM(t1.aktion_id) = ''
                    THEN t1.menge
                ELSE 0
            END) AS a_absatz_af,
            SUM(CASE
                WHEN TRIM(t1.aktion_id) <> ''
                    THEN t1.menge
                ELSE 0
            END) AS a_absatz_sa,
            0 AS a_absatz_akt,
            Y.wg_id,
            0 AS w_umsatz_af,
            0 AS w_umsatz_sa,
            0 AS w_umsatz_akt,
            0 AS w_absatz_af,
            0 AS w_absatz_sa,
            0 AS w_absatz_akt
        FROM (SELECT
            bon_id,
            mandant_id,
            wup_id,
            bon_dat,
            kasse_nr,
            bon_nr,
            kl_art_id,
            aktion_id,
            SUM(menge) AS menge,
            SUM(umsatz_brutto) AS umsatz_brutto
        FROM `_bon_snapshot`
        GROUP BY
            bon_id,
            kl_art_id,
            aktion_id,
            mandant_id,
            wup_id,
            bon_nr,
            bon_dat,
            kasse_nr
        HAVING umsatz_brutto > 0) AS t1_1
        INNER JOIN `_mutter_art` AS X ON t1.mandant_id = X.mandant_id AND t1.kl_art_id = X.kl_art_id
        INNER JOIN dbp_data.art_wg_zu_per_1 AS Y
            ON
                X.mandant_id = Y.mandant_id AND Y.arthiertyp_id = 2 AND Y.dat_bis
                = DATE '9999-12-31' AND X.mutter_wb_id = Y.art_id
        INNER JOIN `_woche` AS XXX_1 ON t1.mandant_id = XXX.mandant_id
        GROUP BY
            shopperwoche,
            t1.mandant_id,
            t1.wup_id,
            dat,
            t1.kasse_nr,
            t1.bon_nr,
            t1.bon_id,
            kl_mutter_id_wb,
            mutter_id_wb,
            Y.wg_id
    );


    -- 1. Update


    UPDATE dbp_etl.bf_bons_kpicp_akt_kmo_tmp_1 SET
        a_umsatz_akt = ods.`_a_umsatz_akt`,
        a_absatz_akt = ods.`_a_absatz_akt` FROM (
        SELECT
            V.mandant_id AS `_mandant_id`,
            V.wup_id AS `_wup_id`,
            V.bon_dat AS `_dat`,
            V.kasse_nr AS `_kasse_nr`,
            V.bon_nr AS `_bon_nr`,
            V.bon_id AS `_bon_id`,
            CAST(FLOOR(X.mutter_wb_id / 10) AS INTEGER) AS `_kl_mutter_id_wb`,
            X.mutter_wb_id AS `_mutter_id_wb`,
            SUM(V.umsatz_brutto) AS `_a_umsatz_akt`,
            SUM(V.menge) AS `_a_absatz_akt`
        FROM `_aktionen` AS V
        INNER JOIN `_mutter_art` AS X ON V.kl_art_id = X.kl_art_id AND V.mandant_id = X.mandant_id
        WHERE (V.mandant_id, V.wup_id, V.kl_art_id) IN (SELECT
            (mandant_id, wup_id, kl_art_id
            )
        FROM `_markets_hta`)
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kasse_nr`,
            `_bon_nr`,
            `_bon_id`,
            `_kl_mutter_id_wb`,
            `_mutter_id_wb`
    ) AS ods
    WHERE
        bf_bons_kpicp_akt_kmo_tmp.mandant_id = ods.`_mandant_id` AND bf_bons_kpicp_akt_kmo_tmp.wup_id = ods.`_wup_id` AND
        bf_bons_kpicp_akt_kmo_tmp.dat = ods.`_dat` AND bf_bons_kpicp_akt_kmo_tmp.kasse_nr = ods.`_kasse_nr` AND
        bf_bons_kpicp_akt_kmo_tmp.bon_nr = ods.`_bon_nr` AND bf_bons_kpicp_akt_kmo_tmp.bon_id = ods.`_bon_id` AND
        bf_bons_kpicp_akt_kmo_tmp.mutter_id_wb = ods.`_mutter_id_wb` AND (
            bf_bons_kpicp_akt_kmo_tmp.mandant_id,
            bf_bons_kpicp_akt_kmo_tmp.shopperwoche) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        );


    -- 2. Update


    UPDATE dbp_etl.bf_bons_kpicp_akt_kmo_tmp_1 AS bf_bons_kpicp_akt_kmo_tmp0 SET
        ges_umsatz_akt = ods.`_ges_umsatz_akt`,
        ges_absatz_akt = ods.`_ges_absatz_akt`,
        w_umsatz_akt = CAST(ods.`_w_umsatz_akt` AS NUMERIC),
        w_absatz_akt = ods.`_w_absatz_akt` FROM (
        SELECT
            t5.mandant_id AS `_mandant_id`,
            t5.wup_id AS `_wup_id`,
            t5.bon_dat AS `_dat`,
            t5.kasse_nr AS `_kasse_nr`,
            t5.bon_nr AS `_bon_nr`,
            t5.bon_id AS `_bon_id`,
            t5.mutter_id_wb AS `_mutter_id_wb`,
            SUM(t5.umsatz_brutto) AS `_ges_umsatz_akt`,
            SUM(t5.menge) AS `_ges_absatz_akt`,
            SUM(CASE
                WHEN t5.wg_id = t5.wg_id0
                    THEN t5.umsatz_brutto
                ELSE 0
            END) AS `_w_umsatz_akt`,
            SUM(CASE
                WHEN t5.wg_id = t5.wg_id0
                    THEN t5.menge
                ELSE 0
            END) AS `_w_absatz_akt`
        FROM (
            SELECT
                v.mandant_id AS mandant_id,
                v.wup_id,
                v.bon_dat,
                v.kasse_nr,
                v.bon_nr,
                v.bon_id,
                v.umsatz_brutto,
                v.menge,
                t4.mutter_id_wb,
                aktion_id,
                kl_art_id,
                v.wg_id,
                t4.wg_id as wg_id0
            FROM (
                SELECT *
                FROM `_bon_snapshot2`
                WHERE (mandant_id, wup_id, kl_art_id) IN (SELECT
                    (mandant_id, wup_id, kl_art_id
                    )
                FROM `_markets_hta`)
            ) AS v
            INNER JOIN (
                SELECT
                    mutter_id_wb,
                    mandant_id,
                    dat,
                    wup_id,
                    kasse_nr,
                    bon_nr,
                    wg_id
                FROM (
                    SELECT *
                    FROM dbp_etl.bf_bons_kpicp_akt_kmo_tmp_1
                    WHERE (mandant_id, kl_mutter_id_wb) IN (SELECT
                        (mandant_id, CAST(FLOOR(mutter_wb_id / 10) AS INTEGER)
                        )
                    FROM `_mutter_art`)
                ) AS bf
                WHERE (
                    mandant_id, CAST(shopperwoche AS INTEGER)) IN (
                    SELECT (mandant_id, woche_1)
                    FROM `_woche`
                )
            ) AS t4
                ON TRUE
            WHERE
                v.mandant_id = t4.mandant_id
                AND v.bon_dat = t4.dat
                AND v.wup_id = t4.wup_id
                AND v.kasse_nr = t4.kasse_nr
                AND v.bon_nr = t4.bon_nr
                AND v.turnover_fg = 1
        ) AS t5
        INNER JOIN `_test_upd` AS X
            ON
                t5.aktion_id = X.aktion_id AND t5.mandant_id = X.mandant_id AND t5.bon_dat BETWEEN X.dat_von
                AND X.dat_bis AND t5.wup_id = X.wup_id AND t5.kl_art_id = X.kl_art_id
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kasse_nr`,
            `_bon_nr`,
            `_bon_id`,
            `_mutter_id_wb`
    ) AS ods
    WHERE
        bf_bons_kpicp_akt_kmo_tmp0.mandant_id = ods.`_mandant_id` AND bf_bons_kpicp_akt_kmo_tmp0.wup_id = ods.`_wup_id`
        AND bf_bons_kpicp_akt_kmo_tmp0.kasse_nr = ods.`_kasse_nr` AND bf_bons_kpicp_akt_kmo_tmp0.bon_nr = ods.`_bon_nr` AND
        bf_bons_kpicp_akt_kmo_tmp0.bon_id = ods.`_bon_id` AND bf_bons_kpicp_akt_kmo_tmp0.mutter_id_wb = ods.`_mutter_id_wb`
        AND (
            bf_bons_kpicp_akt_kmo_tmp0.mandant_id, bf_bons_kpicp_akt_kmo_tmp0.shopperwoche) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        );


    -- 3. Update


    UPDATE dbp_etl.bf_bons_kpicp_akt_kmo_tmp_1 AS bf_bons_kpicp_akt_kmo_tmp0 SET
        ges_umsatz_af = CAST(ods.`_ges_umsatz_af` AS NUMERIC),
        ges_umsatz_sa = CAST(ods.`_ges_umsatz_sa` AS NUMERIC),
        ges_absatz_af = ods.`_ges_absatz_af`,
        ges_absatz_sa = ods.`_ges_absatz_sa`,
        w_umsatz_af = CAST(ods.`_w_umsatz_af` AS NUMERIC),
        w_umsatz_sa = CAST(ods.`_w_umsatz_sa` AS NUMERIC),
        w_absatz_af = ods.`_w_absatz_af`,
        w_absatz_sa = ods.`_w_absatz_sa` FROM (
        SELECT
            v.mandant_id AS `_mandant_id`,
            v.wup_id AS `_wup_id`,
            v.bon_dat AS `_dat`,
            v.kasse_nr AS `_kasse_nr`,
            v.bon_nr AS `_bon_nr`,
            v.bon_id AS `_bon_id`,
            t2.mutter_id_wb AS `_mutter_id_wb`,
            SUM(CASE
                WHEN TRIM(v.aktion_id) = ''
                    THEN v.umsatz_brutto
                ELSE 0
            END) AS `_ges_umsatz_af`,
            SUM(CASE
                WHEN TRIM(v.aktion_id) <> ''
                    THEN v.umsatz_brutto
                ELSE 0
            END) AS `_ges_umsatz_sa`,
            SUM(CASE
                WHEN TRIM(v.aktion_id) = ''
                    THEN v.menge
                ELSE 0
            END) AS `_ges_absatz_af`,
            SUM(CASE
                WHEN TRIM(v.aktion_id) <> ''
                    THEN v.menge
                ELSE 0
            END) AS `_ges_absatz_sa`,
            SUM(CASE
                WHEN v.wg_id = t2.wg_id AND TRIM(v.aktion_id) = ''
                    THEN v.umsatz_brutto
                ELSE 0
            END) AS `_w_umsatz_af`,
            SUM(CASE
                WHEN v.wg_id = t2.wg_id AND TRIM(v.aktion_id) <> ''
                    THEN v.umsatz_brutto
                ELSE 0
            END) AS `_w_umsatz_sa`,
            SUM(CASE
                WHEN v.wg_id = t2.wg_id AND TRIM(v.aktion_id) = ''
                    THEN v.menge
                ELSE 0
            END) AS `_w_absatz_af`,
            SUM(CASE
                WHEN v.wg_id = t2.wg_id AND TRIM(v.aktion_id) <> ''
                    THEN v.menge
                ELSE 0
            END) AS `_w_absatz_sa`
        FROM `_bon_snapshot2` AS v
        INNER JOIN (
            SELECT *
            FROM (
                SELECT *
                FROM dbp_etl.bf_bons_kpicp_akt_kmo_tmp_1
                WHERE (mandant_id, kl_mutter_id_wb) IN (SELECT
                    (mandant_id, CAST(FLOOR(mutter_wb_id / 10) AS INTEGER)
                    )
                FROM `_mutter_art`)
            ) AS bf
            WHERE (
                mandant_id, shopperwoche) IN (
                SELECT (mandant_id, woche_1)
                FROM `_woche`
            )
        ) AS t2
            ON TRUE
        WHERE
            v.mandant_id = t2.mandant_id
            AND v.bon_dat = t2.dat
            AND v.wup_id = t2.wup_id
            AND v.kasse_nr = t2.kasse_nr
            AND v.bon_nr = t2.bon_nr
            AND v.turnover_fg = 1
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kasse_nr`,
            `_bon_nr`,
            `_bon_id`,
            `_mutter_id_wb`
    ) AS ods
    WHERE
        bf_bons_kpicp_akt_kmo_tmp0.mandant_id = ods.`_mandant_id` AND bf_bons_kpicp_akt_kmo_tmp0.wup_id = ods.`_wup_id`
        AND bf_bons_kpicp_akt_kmo_tmp0.kasse_nr = ods.`_kasse_nr` AND bf_bons_kpicp_akt_kmo_tmp0.bon_nr = ods.`_bon_nr` AND
        bf_bons_kpicp_akt_kmo_tmp0.bon_id = ods.`_bon_id` AND bf_bons_kpicp_akt_kmo_tmp0.mutter_id_wb = ods.`_mutter_id_wb`
        AND (
            bf_bons_kpicp_akt_kmo_tmp0.mandant_id, bf_bons_kpicp_akt_kmo_tmp0.shopperwoche) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        );


    DELETE FROM dbp_etl.bf_bons_kpicp_akt_kmo
    WHERE (
        mandant_id, shopperwoche) IN (
        SELECT (mandant_id, woche_1)
        FROM `_woche`
    );


    INSERT INTO dbp_etl.bf_bons_kpicp_akt_kmo
    (
        SELECT *
        FROM dbp_etl.bf_bons_kpicp_akt_kmo_tmp_1
    );


    /*
    +-------------------------------------------------------------
    + 5. FALL 2 - Verarbeitung
    +-------------------------------------------------------------
    */


    CREATE OR REPLACE TABLE dbp_etl.bf_bons_kpia_akt_kmo_tmp_1 LIKE dbp_etl.bf_bons_kpia_akt_kmo;


    INSERT INTO dbp_etl.bf_bons_kpia_akt_kmo_tmp_1
    (
        SELECT
            XXX.woche_1 AS shopperwoche,
            CAST(x.`_mandant_id` AS INTEGER) AS `_mandant_id`,
            CAST(x.`_wup_id` AS INTEGER) AS `_wup_id`,
            x.`_dat`,
            CAST(CAST(FLOOR(Y.mutter_wb_id / 10) AS INTEGER) AS INTEGER) AS `_kl_mutter_id_wb`,
            Y.mutter_wb_id AS `_mutter_wb_id`,
            -- Artikelzeilen
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            MAX(Y.wg_id) AS wg_id,
            0 AS `_w_bons`,
            0 AS `_w_bon_zeilen`,
            0 AS `_w_umsatz_af`,
            0 AS `_w_umsatz_sa`,
            0,
            0 AS `_w_absatz_af`,
            0 AS `_w_absatz_sa`,
            0
        FROM (
            SELECT
                V.mandant_id AS `_mandant_id`,
                V.wup_id AS `_wup_id`,
                V.bon_dat AS `_dat`,
                -- Artikelzeilen
                0 AS eins,
                0 AS zwei,
                0 AS drei,
                0 AS vier,
                0 AS fuenf,
                0 AS sechs,
                0 AS sieben,
                0 AS acht,
                V.wg_id AS `_wg_id`,
                0 AS `_w_bons`,
                0 AS `_w_bon_zeilen`,
                0 AS `_w_umsatz_af`,
                0 AS `_w_umsatz_sa`,
                0 AS neun,
                0 AS `_w_absatz_af`,
                0 AS `_w_absatz_sa`,
                0 AS zehn
            FROM `_bon_snapshot` AS V
            INNER JOIN (
                SELECT
                    mandant_id,
                    wg_id
                FROM `_mutter_wg`
                GROUP BY
                    mandant_id,
                    wg_id
            ) AS x ON V.wg_id = x.wg_id AND V.mandant_id = x.mandant_id
            GROUP BY
                `_mandant_id`,
                `_wup_id`,
                `_dat`,
                `_wg_id`
        ) AS x
        INNER JOIN `_mutter_wg` AS Y ON x.`_wg_id` = Y.wg_id AND x.`_mandant_id` = Y.mandant_id
        INNER JOIN `_woche` AS XXX_1 ON x.`_mandant_id` = XXX.mandant_id
        GROUP BY
            shopperwoche,
            x.`_mandant_id`,
            x.`_wup_id`,
            x.`_dat`,
            `_kl_mutter_id_wb`,
            `_mutter_wb_id`,
            `_w_bons`
    );


    UPDATE dbp_etl.bf_bons_kpia_akt_kmo_tmp_1 SET
        a_bons = ods.`_a_bons`,
        a_umsatz_af = CAST(ods.`_a_umsatz_af` AS NUMERIC),
        a_umsatz_sa = CAST(ods.`_a_umsatz_sa` AS NUMERIC),
        a_absatz_af = ods.`_a_absatz_af`,
        a_absatz_sa = ods.`_a_absatz_sa` FROM (
        SELECT
            V.mandant_id AS `_mandant_id`,
            V.wup_id AS `_wup_id`,
            V.bon_dat AS `_dat`,
            CAST(FLOOR(X.mutter_wb_id / 10) AS INTEGER) AS `_kl_mutter_id_wb`,
            X.mutter_wb_id AS `_mutter_id_wb`,
            COUNT(DISTINCT V.bon_id) AS `_a_bons`,
            SUM(CASE
                WHEN TRIM(V.aktion_id) = ''
                    THEN V.menge
                ELSE 0
            END) AS `_a_absatz_af`,
            SUM(CASE
                WHEN TRIM(V.aktion_id) <> ''
                    THEN V.menge
                ELSE 0
            END) AS `_a_absatz_sa`,
            SUM(CASE
                WHEN TRIM(V.aktion_id) = ''
                    THEN V.umsatz_brutto
                ELSE 0
            END) AS `_a_umsatz_af`,
            SUM(CASE
                WHEN TRIM(V.aktion_id) <> ''
                    THEN V.umsatz_brutto
                ELSE 0
            END) AS `_a_umsatz_sa`
        FROM `_bon_snapshot` AS V
        INNER JOIN `_mutter_art` AS X ON V.kl_art_id = X.kl_art_id AND V.mandant_id = X.mandant_id
        INNER JOIN (
            SELECT *
            FROM dbp_etl.bf_bons_kpia_akt_kmo_tmp_1 AS BF
            WHERE (
                mandant_id, shopperwoche) IN (
                SELECT (mandant_id, woche_1)
                FROM `_woche`
            )
        ) AS t0
            ON TRUE
        WHERE
            V.mandant_id = t0.mandant_id
            AND V.bon_dat = t0.dat
            AND V.wup_id = t0.wup_id
            AND X.mutter_wb_id = t0.mutter_id_wb
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kl_mutter_id_wb`,
            `_mutter_id_wb`
    ) AS ods
    WHERE
        bf_bons_kpia_akt_kmo_tmp.mandant_id = ods.`_mandant_id` AND bf_bons_kpia_akt_kmo_tmp.wup_id = ods.`_wup_id` AND
        bf_bons_kpia_akt_kmo_tmp.dat = ods.`_dat` AND bf_bons_kpia_akt_kmo_tmp.mutter_id_wb = ods.`_mutter_id_wb` AND (
            bf_bons_kpia_akt_kmo_tmp.mandant_id, bf_bons_kpia_akt_kmo_tmp.shopperwoche) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        );


    UPDATE dbp_etl.bf_bons_kpia_akt_kmo_tmp_1 SET
        a_umsatz_akt = ods.`_a_umsatz_akt`,
        a_absatz_akt = ods.`_a_absatz_akt` FROM (
        SELECT
            v.mandant_id AS `_mandant_id`,
            v.wup_id AS `_wup_id`,
            v.bon_dat AS `_dat`,
            CAST(FLOOR(X.mutter_wb_id / 10) AS INTEGER) AS `_kl_mutter_id_wb`,
            X.mutter_wb_id AS `_mutter_id_wb`,
            SUM(v.menge) AS `_a_absatz_akt`,
            SUM(v.umsatz_brutto) AS `_a_umsatz_akt`
        FROM (
            SELECT *
            FROM `_aktionen`
            WHERE (mandant_id, wup_id, kl_art_id) IN (SELECT
                (mandant_id, wup_id, kl_art_id
                )
            FROM `_markets_hta`)
        ) AS v
        INNER JOIN `_mutter_art` AS X ON v.kl_art_id = X.kl_art_id AND v.mandant_id = X.mandant_id
        INNER JOIN (
            SELECT *
            FROM dbp_etl.bf_bons_kpia_akt_kmo_tmp_1 AS BF
            WHERE (
                mandant_id, shopperwoche) IN (
                SELECT (mandant_id, woche_1)
                FROM `_woche`
            )
        ) AS t2
            ON TRUE
        WHERE
            v.mandant_id = t2.mandant_id
            AND v.bon_dat = t2.dat
            AND v.wup_id = t2.wup_id
            AND X.mutter_wb_id = t2.mutter_id_wb
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kl_mutter_id_wb`,
            `_mutter_id_wb`
    ) AS ods
    WHERE
        bf_bons_kpia_akt_kmo_tmp.mandant_id = ods.`_mandant_id` AND bf_bons_kpia_akt_kmo_tmp.wup_id = ods.`_wup_id` AND
        bf_bons_kpia_akt_kmo_tmp.dat = ods.`_dat` AND bf_bons_kpia_akt_kmo_tmp.mutter_id_wb = ods.`_mutter_id_wb` AND (
            bf_bons_kpia_akt_kmo_tmp.mandant_id, bf_bons_kpia_akt_kmo_tmp.shopperwoche) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        );


    CREATE OR REPLACE TEMPORARY TABLE _lookie AS
    SELECT
        A.mandant_id,
        B.art_id,
        MIN(A.dat_von) AS dat_von,
        MAX(A.dat_bis) AS dat_bis
    FROM dbp_data.aktion_1 AS A
    INNER JOIN dbp_data.aktion_art_wup_zu_1 AS B ON A.aktion_id = B.aktion_id AND A.mandant_id = B.mandant_id
    WHERE
        A.mandant_id > 1
        AND B.grund_sperrung IS NULL
        AND A.aktion_typ_id IS NOT NULL
    GROUP BY
        A.mandant_id,
        B.art_id;


    UPDATE dbp_etl.bf_bons_kpia_akt_kmo_tmp_1 SET
        a_absatz_af = 0
    FROM `_lookie` AS b
    WHERE
        bf_bons_kpia_akt_kmo_tmp.mandant_id = b.mandant_id AND bf_bons_kpia_akt_kmo_tmp.mutter_id_wb = b.art_id AND
        bf_bons_kpia_akt_kmo_tmp.dat BETWEEN b.dat_von AND b.dat_bis AND bf_bons_kpia_akt_kmo_tmp.dat BETWEEN (
            SELECT DATE_ADD(MIN(akt_dat_von), INTERVAL 7 DAY)
            FROM `_akt_dat_von_dat_bis`) AND (
            SELECT MAX(akt_dat_bis)
            FROM `_akt_dat_von_dat_bis`
        );


    DELETE FROM dbp_etl.bf_bons_kpia_akt_kmo
    WHERE (
        mandant_id, shopperwoche) IN (
        SELECT (mandant_id, woche_1)
        FROM `_woche`
    );


    INSERT INTO dbp_etl.bf_bons_kpia_akt_kmo
    (
        SELECT *
        FROM dbp_etl.bf_bons_kpia_akt_kmo_tmp_1
    );


    /*
    +-------------------------------------------------------------
    + 6. FALL 3 - Verarbeitung
    +-------------------------------------------------------------
    */


    CREATE OR REPLACE TEMPORARY TABLE _artbew AS
    SELECT
        M.mandant_id,
        M.dat,
        M.wup_id,
        M.art_id,
        M.aktion_id,
        M.umsatz_netto,
        COALESCE(M.menge / x0.mengen_faktor, M.menge) AS menge,
        M.ek_mep,
        M.einstandspreis
    FROM `_artbew_complete` AS M
    LEFT JOIN (
        SELECT
            mandant_id,
            wup_id,
            kl_art_id,
            MIN(mengen_faktor) AS mengen_faktor
        FROM `_hit_the_actions`
        GROUP BY
            mandant_id,
            wup_id,
            kl_art_id
        UNION ALL
        SELECT
            mandant_id,
            wup_id,
            kl_art_id,
            AVG(mengen_faktor) AS mengen_faktor
        FROM dbp_process.bf_hit_the_actions_kmo_1
        WHERE (
            mandant_id, wup_id, kl_art_id) NOT IN (
            SELECT (mandant_id, wup_id, kl_art_id)
            FROM `_hit_the_actions`
        )
        GROUP BY
            mandant_id,
            wup_id,
            kl_art_id
    ) AS x0
        ON
            M.mandant_id = x0.mandant_id AND CAST(FLOOR(M.art_id / 10) AS INTEGER) = x0.kl_art_id AND M.wup_id
            = x0.wup_id
    INNER JOIN `_dat_von_dat_bis` AS B ON M.mandant_id = B.mandant_id AND M.dat BETWEEN B.dat_von AND B.dat_bis
    WHERE (
        M.art_id, M.mandant_id) IN (
        SELECT (art_id, mandant_id)
        FROM `_mutter_art`
    )
    AND M.menge > 0;


    DELETE FROM dbp_etl.bf_bons_kpi1x_kmo
    WHERE (
        mandant_id, shopperwoche) IN (
        SELECT (mandant_id, woche_1)
        FROM `_woche`
    );


    INSERT INTO dbp_etl.bf_bons_kpi1x_kmo
    (
        SELECT
            XXX.woche_1 AS shopperwoche,
            M.mandant_id,
            M.dat,
            M.wup_id,
            A.mutter_wb_id,
            MAX(A.wg_id) AS wg_id,
            COUNT(DISTINCT M.aktion_id) AS aktionen,
            CAST(SUM(CASE
                WHEN TRIM(M.aktion_id) = ''
                    THEN M.umsatz_netto
                ELSE 0
            END) AS NUMERIC) AS af_ums_netto,
            CAST(SUM(CASE
                WHEN TRIM(M.aktion_id) <> ''
                    THEN M.umsatz_netto
                ELSE 0
            END) AS NUMERIC) AS sa_ums_netto,
            0 AS akt_ums_netto,
            SUM(CASE
                WHEN TRIM(M.aktion_id) = ''
                    THEN M.menge
                ELSE 0
            END) AS af_absatz,
            SUM(CASE
                WHEN TRIM(M.aktion_id) <> ''
                    THEN M.menge
                ELSE 0
            END) AS sa_absatz,
            0 AS akt_absatz,
            CAST(SUM(CASE
                WHEN TRIM(M.aktion_id) = '' AND M.mandant_id IN (2, 5, 8) OR TRIM(M.aktion_id) = '' AND M.mandant_id IN (3, 6, 7)
                    THEN CAST(M.ek_mep AS NUMERIC)
                ELSE 0
            END) AS NUMERIC) AS af_mep,
            CAST(SUM(CASE
                WHEN M.aktion_id <> '' AND M.mandant_id IN (2, 5, 8) OR M.aktion_id <> '' AND M.mandant_id IN (3, 6, 7)
                    THEN CAST(M.ek_mep AS NUMERIC)
                ELSE 0
            END) AS NUMERIC) AS sa_mep,
            0 AS akt_mep,
            CAST(SUM(CASE
                WHEN TRIM(M.aktion_id) = ''
                    THEN M.umsatz_netto
                ELSE 0
            END) - SUM(CASE
                WHEN TRIM(M.aktion_id) = '' AND M.mandant_id IN (2, 5, 8) OR TRIM(M.aktion_id) = '' AND M.mandant_id IN (3, 6, 7)
                    THEN CAST(M.ek_mep AS NUMERIC)
                ELSE 0
            END) AS NUMERIC) AS af_ertrag,
            CAST(SUM(CASE
                WHEN TRIM(M.aktion_id) <> ''
                    THEN M.umsatz_netto
                ELSE 0
            END) - SUM(CASE
                WHEN M.aktion_id <> '' AND M.mandant_id IN (2, 5, 8) OR M.aktion_id <> '' AND M.mandant_id IN (3, 6, 7)
                    THEN CAST(M.ek_mep AS NUMERIC)
                ELSE 0
            END) AS NUMERIC) AS sa_ertrag,
            0 AS akt_ertrag
        FROM `_artbew` AS M
        INNER JOIN `_mutter_art` AS A ON M.mandant_id = A.mandant_id AND M.art_id = A.art_id
        INNER JOIN `_woche` AS XXX_1 ON M.mandant_id = XXX.mandant_id
        INNER JOIN `_dat_von_dat_bis` AS B ON M.mandant_id = B.mandant_id AND M.dat BETWEEN B.dat_von AND B.dat_bis
        WHERE M.menge > 0
        GROUP BY
            shopperwoche,
            M.mandant_id,
            M.dat,
            M.wup_id,
            A.mutter_wb_id
    );


    UPDATE dbp_etl.bf_bons_kpi1x_kmo SET
        akt_ums_netto = ak.`_ums_netto`,
        akt_absatz = ak.`_menge`,
        akt_mep = ak.`_mep`,
        akt_ertrag = ak.`_ertrag` FROM (
        SELECT
            m.mandant_id AS `_mandant_id`,
            m.dat AS `_dat`,
            m.wup_id AS `_wup_id`,
            X.mutter_wb_id AS `_mutter_wb_id`,
            SUM(m.umsatz_netto) AS `_ums_netto`,
            SUM(m.menge) AS `_menge`,
            SUM(m.ek_mep) AS `_mep`,
            SUM(m.umsatz_netto) - SUM(m.ek_mep) AS `_ertrag`
        FROM (
            SELECT
                mandant_id,
                art_id,
                dat,
                wup_id,
                aktion_id,
                SUM(menge) AS menge,
                SUM(umsatz_netto) AS umsatz_netto,
                SUM(CAST(ek_mep AS NUMERIC)) AS ek_mep
            FROM `_artbew`
            GROUP BY
                mandant_id,
                art_id,
                dat,
                wup_id,
                aktion_id
        ) AS m
        INNER JOIN `_test_upd` AS X1
            ON
                m.aktion_id = X1.aktion_id AND m.mandant_id = X1.mandant_id AND m.dat BETWEEN X1.dat_von
                AND X1.dat_bis AND m.wup_id = X1.wup_id AND CAST(FLOOR(m.art_id / 10) AS INTEGER) = X1.kl_art_id
        INNER JOIN `_mutter_art` AS X ON m.art_id = X.art_id AND m.mandant_id = X.mandant_id
        INNER JOIN `_dat_von_dat_bis` AS B ON m.mandant_id = B.mandant_id AND m.dat BETWEEN B.dat_von AND B.dat_bis
        WHERE (m.wup_id, CAST(FLOOR(
            m.art_id / 10) AS INTEGER), m.mandant_id) IN (SELECT (
            wup_id, CAST(kl_art_id AS INTEGER),
            mandant_id
        )
        FROM `_markets_hta`)
        GROUP BY
            `_mandant_id`,
            `_dat`,
            `_wup_id`,
            `_mutter_wb_id`
    ) AS ak
    WHERE bf_bons_kpi1x_kmo.mandant_id = ak.`_mandant_id` AND bf_bons_kpi1x_kmo.wup_id = ak.`_wup_id` AND bf_bons_kpi1x_kmo.dat = ak.`_dat` AND bf_bons_kpi1x_kmo.mutter_id_wb = ak.`_mutter_wb_id` AND (
        bf_bons_kpi1x_kmo.mandant_id,
        bf_bons_kpi1x_kmo.shopperwoche) IN (
        SELECT (mandant_id, woche_1)
        FROM `_woche`
    );


    /*
    +-------------------------------------------------------------
    + 7. FALL 4 - Verarbeitung
    +-------------------------------------------------------------
    */


    CREATE OR REPLACE TEMPORARY TABLE _ods_bon_verkauf_kpim AS
    SELECT *
    FROM `_ods_bon_verkauf_summit`
    WHERE bon_dat BETWEEN (
        SELECT MIN(dat)
        FROM `_wochen`) AND (
        SELECT MAX(dat)
        FROM `_wochen`
    );


    CREATE OR REPLACE TEMPORARY TABLE _ods_bon_kopf_kpim AS
    SELECT *
    FROM `_ods_bon_kopf_summit`
    WHERE bon_dat BETWEEN (
        SELECT MIN(dat)
        FROM `_wochen`) AND (
        SELECT MAX(dat)
        FROM `_wochen`
    );


    TRUNCATE TABLE dbp_etl.bf_bons_kpim_akt_kmo_1;


    INSERT INTO dbp_etl.bf_bons_kpim_akt_kmo_1
    (
        SELECT
            CAST(OK.mandant_id AS INTEGER) AS mandant_id,
            CAST(OK.wup_id AS INTEGER) AS wup_id,
            OK.bon_dat,
            COUNT(DISTINCT OK.bon_id) AS `_bons`,
            SUM(t2.zeilen) AS `_bon_zeilen`,
            COUNT(DISTINCT CASE
                WHEN TRIM(t2.aktion_id) = ''
                    THEN t2.bon_id
                ELSE NULL
            END) AS `_bons_af`,
            COUNT(DISTINCT CASE
                WHEN TRIM(t2.aktion_id) <> ''
                    THEN t2.bon_id
                ELSE NULL
            END) AS `_bons_sa`,
            0 AS `_bons_akt`,
            CAST(SUM(CASE
                WHEN TRIM(t2.aktion_id) = ''
                    THEN t2.umsatz_brutto
                ELSE 0
            END) AS NUMERIC) AS `_ges_umsatz_af`,
            CAST(SUM(CASE
                WHEN TRIM(t2.aktion_id) <> ''
                    THEN t2.umsatz_brutto
                ELSE 0
            END) AS NUMERIC) AS `_ges_umsatz_sa`,
            0 AS `_ges_umsatz_akt`
        FROM (SELECT
            bon_id,
            mandant_id,
            wup_id,
            kl_art_id,
            aktion_id,
            COUNT(*) AS zeilen,
            SUM(umsatz_brutto) AS umsatz_brutto
        FROM `_ods_bon_verkauf_kpim` AS V
        WHERE wg_id <> 980
        GROUP BY
            bon_id,
            kl_art_id,
            aktion_id,
            mandant_id,
            wup_id
        HAVING umsatz_brutto > 0) AS t2
        INNER JOIN `_ods_bon_kopf_kpim` AS OK ON t2.mandant_id = OK.mandant_id AND t2.wup_id = OK.wup_id AND t2.bon_id = OK.bon_id

        INNER JOIN `_wochen` AS X ON OK.bon_dat = X.dat AND OK.mandant_id = X.mandant_id
        WHERE
            OK.mandant_id > 1
            AND OK.turnover_fg = 1
            AND (
                OK.bon_id, OK.bon_dat) NOT IN (
                SELECT (bon_id, bon_dat)
                FROM dbp_spezial.v_ods_bon_storno_union_1
            )
        GROUP BY
            OK.mandant_id,
            OK.wup_id,
            OK.bon_dat
    );


    -- KPI  fortschreiben kpim_akt Bons-Summen noch nur echte aktionen


    UPDATE dbp_etl.bf_bons_kpim_akt_kmo_1 SET
        ges_umsatz_akt = ods.`_akt_umsatz_sa`,
        bons_akt = ods.`_bons_akt` FROM (
        SELECT
            OK.mandant_id AS `_mandant_id`,
            OK.wup_id AS `_wup_id`,
            OK.bon_dat AS `_dat`,
            COUNT(DISTINCT V.bon_id) AS `_bons_akt`,
            SUM(V.umsatz_brutto) AS `_akt_umsatz_sa`
        FROM `_ods_bon_verkauf_kpim` AS V
        INNER JOIN `_ods_bon_kopf_kpim` AS OK ON V.mandant_id = OK.mandant_id AND V.wup_id = OK.wup_id AND V.bon_id = OK.bon_id

        INNER JOIN `_wochen` AS X ON OK.bon_dat = X.dat AND OK.mandant_id = X.mandant_id
        INNER JOIN dbp_data.aktion_1 AS AKT
            ON
                V.aktion_id = AKT.aktion_id AND OK.bon_dat BETWEEN AKT.dat_von
                AND AKT.dat_bis AND OK.mandant_id = AKT.mandant_id
        INNER JOIN dbp_data.aktion_art_wup_zu_1 AS AKTA
            ON
                AKT.aktion_id = AKTA.aktion_id AND AKT.mandant_id =
                AKTA.mandant_id AND V.wup_id = AKTA.wup_id AND V.kl_art_id = CAST(FLOOR(AKTA.art_id / 10) AS INTEGER)
        WHERE
            OK.mandant_id > 1
            AND OK.turnover_fg = 1
            AND V.wg_id <> 980
            AND AKTA.grund_sperrung IS NULL
            AND (
                OK.bon_id, OK.bon_dat) NOT IN (
                SELECT (bon_id, bon_dat)
                FROM dbp_spezial.v_ods_bon_storno_union_1
            )
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`
    ) AS ods
    WHERE
        bf_bons_kpim_akt_kmo.mandant_id = ods.`_mandant_id` AND bf_bons_kpim_akt_kmo.wup_id = ods.`_wup_id` AND
        bf_bons_kpim_akt_kmo.dat = ods.`_dat`;


    DELETE FROM dbp_process.bf_bons_kpim_akt_kmo_1
    WHERE (
        mandant_id, dat) IN (
        SELECT (mandant_id, dat)
        FROM `_wochen`
    );


    INSERT INTO dbp_process.bf_bons_kpim_akt_kmo_1
    (SELECT
        mandant_id,
        wup_id,
        dat,
        bons,
        bon_zeilen,
        bons_af,
        bons_sa,
        bons_akt,
        ges_umsatz_af,
        ges_umsatz_sa,
        ges_umsatz_akt,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_etl.bf_bons_kpim_akt_kmo_1 AS A);


    /*
    +-------------------------------------------------------------
    + 7. F I N A L E
    +-------------------------------------------------------------
    */


    UPDATE dbp_etl.bf_bons_kpia_akt_kmo SET
        a_bons = xxx.`_a_bons` FROM (
        SELECT
            mandant_id AS `_mandant_id`,
            wup_id AS `_wup_id`,
            shopperwoche AS `_shopperwoche`,
            dat AS `_dat`,
            mutter_id_wb AS `_mutter_id_wb`,
            COUNT(*) AS `_a_bons`
        FROM dbp_etl.bf_bons_kpicp_akt_kmo AS C
        WHERE (
            mandant_id, shopperwoche) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        )
        AND a_absatz_af + a_absatz_sa > 0
        AND mandant_id > 1
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_shopperwoche`,
            `_dat`,
            `_mutter_id_wb`
    ) AS xxx_1
    WHERE
        bf_bons_kpia_akt_kmo.mandant_id = xxx.`_mandant_id` AND bf_bons_kpia_akt_kmo.mutter_id_wb = xxx.`_mutter_id_wb`
        AND bf_bons_kpia_akt_kmo.wup_id = xxx.`_wup_id` AND bf_bons_kpia_akt_kmo.dat = xxx.`_dat` AND bf_bons_kpia_akt_kmo.shopperwoche
        = xxx.`_shopperwoche`;


    CREATE OR REPLACE TEMPORARY TABLE _exclude_displays AS
    SELECT
        C.mandant_id,
        C.kl_art_id
    FROM dbp_data.stueckliste_1 AS A
    INNER JOIN dbp_data.stueckliste_det_1 AS B ON A.mandant_id = B.mandant_id AND A.stueckliste_id = B.stueckliste_id

    INNER JOIN dbp_process.bf_hit_the_actions_kmo_1 AS C
        ON
            A.mandant_id = C.mandant_id AND CAST(FLOOR(A.art_id / 10) AS INTEGER)
            = C.kl_art_id
    WHERE
        A.dat_bis = DATE '9999-12-31'
        AND (
            C.mandant_id, C.kjwo) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        )
        AND B.komponentenmenge <> 1
    GROUP BY
        C.mandant_id,
        C.kl_art_id;


    DELETE FROM dbp_etl.bf_shopper_front_kmo
    WHERE (
        mandant_id, shopperwoche) IN (
        SELECT (mandant_id, woche_1)
        FROM `_woche`
    );


    INSERT INTO dbp_etl.bf_shopper_front_kmo
    (
        SELECT
            M.mandant_id,
            W.aktuell_wup_id AS wup_id,
            W.nb_id,
            1 AS baseline,
            M.mutter_id_wb,
            M.shopperwoche,
            MIN(M.dat) AS min_tag_bl,
            MAX(M.dat) AS max_tag_bl,
            COUNT(DISTINCT M.wup_id) AS anz_af_maerkte,
            0 AS af_ums_netto,
            0 AS akt_ums_netto,
            0 AS af_absatz,
            0 AS akt_absatz,
            0 AS af_ertrag,
            0 AS akt_ertrag,
            0 AS bl_af_kaeufer,
            0 AS bl_akt_kaeufer,
            0 AS rw_tage,
            0 AS rw_akt_tage,
            0 AS bl_af_kd_rw,
            0 AS bl_akt_kd_rw,
            0 AS cp_kaeufer,
            0 AS cp_alle_70,
            0 AS restbon_af,
            0 AS restbon_gesamt,
            0 AS akt_np_umsatz,
            0 AS anz_markt_sa,
            0 AS anz_kaeufer_af,
            0 AS anz_kaeufer_sa,
            0 AS anz_bon_af,
            0 AS anz_bon_sa,
            0 AS anz_bon_aktion,
            0 AS ges_umsatz_ohne_art,
            0 AS ges_umsatz_inkl_wv
        FROM dbp_etl.bf_bons_kpi1x_kmo AS M
        INNER JOIN dbp_data.wup_1 AS W ON TRUE
        INNER JOIN dbp_data.werbewoche_kl_1 AS Z ON TRUE
        INNER JOIN `_bl_dat_von_dat_bis` AS XXX_1 ON TRUE
        WHERE
            M.mandant_id = XXX.mandant_id
            AND Z.dat BETWEEN XXX.bl_dat_von AND XXX.bl_dat_bis
            AND (
                M.mandant_id, M.shopperwoche) IN (
                SELECT (mandant_id, woche_1)
                FROM `_woche`
            )
            AND Z.mandant_id > 1
            AND Z.dat = M.dat
            AND M.mandant_id = Z.mandant_id
            AND M.mandant_id = W.mandant_id
            AND M.wup_id = W.wup_id
        GROUP BY
            M.mandant_id,
            wup_id,
            W.nb_id,
            baseline,
            M.mutter_id_wb,
            M.shopperwoche
    );


    -- 20.06.2016, -dbay-
    --
    -- Ergaenzung von MAKs ohne Baseline-Abverkauf!


    INSERT INTO dbp_etl.bf_shopper_front_kmo
    (
        SELECT DISTINCT
            M.mandant_id,
            W.aktuell_wup_id AS wup_id,
            W.nb_id,
            1 AS baseline,
            M.mutter_id_wb,
            M.shopperwoche,
            DATE('1900-01-01') AS min_tag_bl,
            DATE('1900-01-01') AS max_tag_bl,
            0 AS anz_af_maerkte,
            0 AS af_ums_netto,
            0 AS akt_ums_netto,
            0 AS af_absatz,
            0 AS akt_absatz,
            0 AS af_ertrag,
            0 AS akt_ertrag,
            0 AS bl_af_kaeufer,
            0 AS bl_akt_kaeufer,
            0 AS rw_tage,
            0 AS rw_akt_tage,
            0 AS bl_af_kd_rw,
            0 AS bl_akt_kd_rw,
            0 AS cp_kaeufer,
            0 AS cp_alle_70,
            0 AS restbon_af,
            0 AS restbon_gesamt,
            0 AS akt_np_umsatz,
            0 AS anz_markt_sa,
            0 AS anz_kaeufer_af,
            0 AS anz_kaeufer_sa,
            0 AS anz_bon_af,
            0 AS anz_bon_sa,
            0 AS anz_bon_aktion,
            0 AS ges_umsatz_ohne_art,
            0 AS ges_umsatz_inkl_wv
        FROM dbp_etl.bf_bons_kpi1x_kmo AS M
        INNER JOIN dbp_data.wup_1 AS W ON TRUE
        INNER JOIN dbp_data.werbewoche_kl_1 AS Z ON TRUE
        INNER JOIN `_akt_dat_von_dat_bis` AS XXX_1 ON TRUE
        WHERE
            M.mandant_id = XXX.mandant_id
            AND Z.dat BETWEEN XXX.akt_dat_von AND XXX.akt_dat_bis
            AND (
                M.mandant_id, M.shopperwoche) IN (
                SELECT (mandant_id, woche_1)
                FROM `_woche`
            )
            AND Z.mandant_id > 1
            AND Z.dat = M.dat
            AND M.mandant_id = Z.mandant_id
            AND M.mandant_id = W.mandant_id
            AND M.wup_id = W.wup_id
            AND (
                M.mandant_id, W.aktuell_wup_id, M.mutter_id_wb) NOT IN (
                SELECT (mandant_id, wup_id, mutter_id_wb)
                FROM dbp_etl.bf_shopper_front_kmo
                WHERE (
                    mandant_id, shopperwoche) IN (
                    SELECT (mandant_id, woche_1)
                    FROM `_woche`
                )
            )
    );


    UPDATE dbp_etl.bf_shopper_front_kmo SET
        af_ums_netto = xxx.`_af_ums_netto`,
        af_absatz = xxx.`_af_absatz`,
        af_ertrag = xxx.`_af_ertrag` FROM (
        SELECT
            M.mandant_id AS `_mandant_id`,
            W.aktuell_wup_id AS `_wup_id`,
            M.mutter_id_wb AS `_mutter_id_wb`,
            M.shopperwoche AS `_shopperwoche`,
            1 AS `_baseline`,
            SUM(M.af_ums_netto) AS `_af_ums_netto`,
            SUM(M.af_absatz) AS `_af_absatz`,
            SUM(M.af_ums_netto - M.af_mep) AS `_af_ertrag`
        FROM dbp_etl.bf_bons_kpi1x_kmo AS M
        INNER JOIN dbp_data.wup_1 AS W ON M.mandant_id = W.mandant_id AND M.wup_id = W.wup_id
        INNER JOIN dbp_data.werbewoche_kl_1 AS Z ON M.dat = Z.dat AND M.mandant_id = Z.mandant_id
        INNER JOIN `_bl_dat_von_dat_bis` AS XXX_1 ON M.mandant_id = XXX.mandant_id AND Z.dat BETWEEN XXX.bl_dat_von AND XXX.bl_dat_bis

        WHERE
            Z.mandant_id > 1
            AND M.af_absatz > 0
            AND M.sa_absatz = 0
            AND (
                M.mandant_id, M.shopperwoche) IN (
                SELECT (mandant_id, woche_1)
                FROM `_woche`
            )
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_mutter_id_wb`,
            `_shopperwoche`,
            `_baseline`
    ) AS xxx_1
    WHERE
        bf_shopper_front_kmo.mandant_id = xxx.`_mandant_id` AND bf_shopper_front_kmo.wup_id = xxx.`_wup_id` AND
        bf_shopper_front_kmo.mutter_id_wb = xxx.`_mutter_id_wb` AND bf_shopper_front_kmo.shopperwoche = xxx.`_shopperwoche`
        AND bf_shopper_front_kmo.baseline = xxx.`_baseline`;


    UPDATE dbp_etl.bf_shopper_front_kmo SET
        bl_af_kaeufer = CAST(xxx.`_bl_af_kaeufer` AS INTEGER),
        bl_af_kd_rw = CAST(xxx.`_bl_af_kd_rw` AS NUMERIC),
        rw_af_tage = xxx.`_rw_tage`,
        anz_kaeufer_af = xxx.`_anz_kaeufer_af`,
        anz_bon_af = xxx.`_anz_bon_af`,
        anz_bon_sa = 0 FROM (
        SELECT
            A.mandant_id AS `_mandant_id`,
            W.aktuell_wup_id AS `_wup_id`,
            A.mutter_id_wb AS `_mutter_id_wb`,
            A.shopperwoche AS `_shopperwoche`,
            1 AS `_baseline`,
            SUM(M.bons) AS `_anz_bon_af`,
            SUM(M.bons_sa) AS `_anz_bon_sa`,
            SUM(CASE
                WHEN A.a_absatz_af > 0 AND A.a_absatz_sa = 0
                    THEN A.a_bons
                ELSE 0
            END) AS `_anz_kaeufer_af`,
            SUM(CASE
                WHEN A.a_absatz_af > 0 AND A.a_absatz_sa = 0
                    THEN A.a_bons
                ELSE 0
            END) / COUNT(DISTINCT CAST(M.wup_id AS STRING) || CAST(M.dat AS STRING)) AS `_bl_af_kaeufer`,
            100.000 * SUM(CASE
                WHEN A.a_absatz_af > 0 AND A.a_absatz_sa = 0
                    THEN A.a_bons
                ELSE 0
            END) / SUM(M.bons) AS `_bl_af_kd_rw`,
            COUNT(DISTINCT CAST(M.wup_id AS STRING) || CAST(M.dat AS STRING)) AS `_rw_tage`
        FROM dbp_etl.bf_bons_kpia_akt_kmo AS A
        INNER JOIN dbp_process.bf_bons_kpim_akt_kmo_1 AS M
            ON
                A.mandant_id = M.mandant_id AND A.wup_id = M.wup_id
                AND A.dat = M.dat
        INNER JOIN dbp_data.wup_1 AS W ON M.mandant_id = W.mandant_id AND M.wup_id = W.wup_id
        INNER JOIN dbp_data.werbewoche_kl_1 AS Z ON M.mandant_id = Z.mandant_id AND M.dat = Z.dat
        INNER JOIN `_bl_dat_von_dat_bis` AS XXX_1 ON M.mandant_id = XXX.mandant_id AND Z.dat BETWEEN XXX.bl_dat_von AND XXX.bl_dat_bis

        WHERE
            A.mandant_id > 1
            AND Z.mandant_id > 1
            AND A.a_absatz_af > 0
            AND A.a_absatz_sa = 0
            AND W.nb_id = 0
            AND (
                A.mandant_id, A.shopperwoche) IN (
                SELECT (mandant_id, woche_1)
                FROM `_woche`
            )
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_mutter_id_wb`,
            `_shopperwoche`,
            `_baseline`
    ) AS xxx_1
    WHERE
        bf_shopper_front_kmo.mandant_id = xxx.`_mandant_id` AND bf_shopper_front_kmo.wup_id = xxx.`_wup_id` AND
        bf_shopper_front_kmo.mutter_id_wb = xxx.`_mutter_id_wb` AND bf_shopper_front_kmo.shopperwoche = xxx.`_shopperwoche`
        AND bf_shopper_front_kmo.baseline = xxx.`_baseline`;


    UPDATE dbp_etl.bf_shopper_front_kmo SET
        akt_ums_netto = xxx.`_akt_ums_netto`,
        akt_absatz = xxx.`_akt_absatz`,
        akt_ertrag = xxx.`_akt_ertrag` FROM (
        SELECT
            M.mandant_id AS `_mandant_id`,
            W.aktuell_wup_id AS `_wup_id`,
            M.mutter_id_wb AS `_mutter_id_wb`,
            M.shopperwoche AS `_shopperwoche`,
            1 AS `_baseline`,
            SUM(M.akt_ums_netto) AS `_akt_ums_netto`,
            SUM(M.akt_absatz) AS `_akt_absatz`,
            SUM(M.akt_ums_netto - M.akt_mep) AS `_akt_ertrag`
        FROM dbp_etl.bf_bons_kpi1x_kmo AS M
        INNER JOIN dbp_data.wup_1 AS W ON M.mandant_id = W.mandant_id AND M.wup_id = W.wup_id
        INNER JOIN dbp_data.werbewoche_kl_1 AS Z ON M.dat = Z.dat AND M.mandant_id = Z.mandant_id
        INNER JOIN `_akt_dat_von_dat_bis` AS XXX_1 ON M.mandant_id = XXX.mandant_id AND Z.dat BETWEEN XXX.akt_dat_von AND XXX.akt_dat_bis

        WHERE (
            M.mandant_id, M.shopperwoche) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        )
        AND Z.mandant_id > 1
        AND M.akt_absatz > 0
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_mutter_id_wb`,
            `_shopperwoche`,
            `_baseline`
    ) AS xxx_1
    WHERE
        bf_shopper_front_kmo.mandant_id = xxx.`_mandant_id` AND bf_shopper_front_kmo.wup_id = xxx.`_wup_id` AND
        bf_shopper_front_kmo.mutter_id_wb = xxx.`_mutter_id_wb` AND bf_shopper_front_kmo.shopperwoche = xxx.`_shopperwoche`
        AND bf_shopper_front_kmo.baseline = xxx.`_baseline`;


    UPDATE dbp_etl.bf_shopper_front_kmo SET
        bl_akt_kaeufer = CAST(xxx.`_bl_akt_kaeufer` AS INTEGER),
        bl_akt_kd_rw = CAST(xxx.`_bl_akt_kd_rw` AS NUMERIC),
        rw_akt_tage = xxx.`_rw_akt_tage`,
        anz_markt_sa = xxx.`_anz_markt_sa`,
        anz_kaeufer_sa = xxx.`_anz_kaeufer_sa`,
        anz_bon_aktion = xxx.`_anz_bon_aktion` FROM (
        SELECT
            M.mandant_id AS `_mandant_id`,
            W.aktuell_wup_id AS `_wup_id`,
            A.mutter_id_wb AS `_mutter_id_wb`,
            A.shopperwoche AS `_shopperwoche`,
            1 AS `_baseline`,
            SUM(M.bons) AS `_anz_bon_aktion`,
            SUM(CASE
                WHEN A.a_absatz_akt > 0 AND A.a_absatz_af = 0
                    THEN A.a_bons
                ELSE 0
            END) AS `_anz_kaeufer_sa`,
            SUM(CASE
                WHEN A.a_absatz_akt > 0 AND A.a_absatz_af = 0
                    THEN A.a_bons
                ELSE 0
            END) / COUNT(DISTINCT CAST(M.wup_id AS STRING) || CAST(M.dat AS STRING)) AS `_bl_akt_kaeufer`,
            100.000 * SUM(CASE
                WHEN A.a_absatz_akt > 0 AND A.a_absatz_af = 0
                    THEN A.a_bons
                ELSE 0
            END) / SUM(M.bons) AS `_bl_akt_kd_rw`,
            COUNT(DISTINCT CAST(M.wup_id AS STRING) || CAST(M.dat AS STRING)) AS `_rw_akt_tage`,
            COUNT(DISTINCT M.wup_id) AS `_anz_markt_sa`
        FROM dbp_etl.bf_bons_kpia_akt_kmo AS A
        INNER JOIN dbp_process.bf_bons_kpim_akt_kmo_1 AS M
            ON
                A.mandant_id = M.mandant_id AND A.wup_id = M.wup_id
                AND A.dat = M.dat
        INNER JOIN dbp_data.wup_1 AS W ON M.mandant_id = W.mandant_id AND M.wup_id = W.wup_id
        INNER JOIN dbp_data.werbewoche_kl_1 AS Z ON M.dat = Z.dat AND M.mandant_id = Z.mandant_id
        INNER JOIN `_akt_dat_von_dat_bis` AS XXX_1 ON M.mandant_id = XXX.mandant_id AND Z.dat BETWEEN XXX.akt_dat_von AND XXX.akt_dat_bis

        WHERE
            A.mandant_id > 1
            AND A.a_absatz_akt > 0
            AND A.a_absatz_af = 0
            AND Z.mandant_id > 1
            AND W.nb_id = 0
            AND (
                A.mandant_id, A.shopperwoche) IN (
                SELECT (mandant_id, woche_1)
                FROM `_woche`
            )
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_mutter_id_wb`,
            `_shopperwoche`,
            `_baseline`
    ) AS xxx_1
    WHERE
        bf_shopper_front_kmo.mandant_id = xxx.`_mandant_id` AND bf_shopper_front_kmo.wup_id = xxx.`_wup_id` AND
        bf_shopper_front_kmo.mutter_id_wb = xxx.`_mutter_id_wb` AND bf_shopper_front_kmo.shopperwoche = xxx.`_shopperwoche`
        AND bf_shopper_front_kmo.baseline = xxx.`_baseline`;


    UPDATE dbp_etl.bf_shopper_front_kmo SET
        cp_kaeufer = xxx.`_cp_kaeufer`,
        cp_alle_70 = xxx.`_cp_alle_70` FROM (
        SELECT
            W.mandant_id AS `_mandant_id`,
            W.aktuell_wup_id AS `_wup_id`,
            BF.mutter_id_wb AS `_mutter_id_wb`,
            BF.shopperwoche AS `_shopperwoche`,
            1 AS `_baseline`,
            COUNT(DISTINCT CAST(BF.wup_id AS STRING) || CAST(BF.dat AS STRING)) AS tage,
            SUM(CASE
                WHEN BF.a_absatz_akt > 0
                    THEN 1
                ELSE 0
            END) AS `_cp_kaeufer`,
            SUM(CASE
                WHEN (BF.a_umsatz_af + BF.a_umsatz_akt) / IF(BF.ges_umsatz_af + BF.ges_umsatz_akt = 0, NULL, BF.ges_umsatz_af + BF.ges_umsatz_akt) >= CASE
                    WHEN COALESCE(x.vk_brutto, 0) > 7.99
                        THEN 0.85
                    ELSE 0.70
                END OR (
                    BF.a_absatz_af + BF.a_absatz_akt) / IF(
                    BF.ges_absatz_af + BF.ges_absatz_akt = 0, NULL, BF.ges_absatz_af
                    + BF.ges_absatz_akt
                ) >= 0.7
                    THEN 1
                ELSE 0
            END) AS `_cp_alle_70`
        FROM dbp_etl.bf_bons_kpicp_akt_kmo AS BF
        INNER JOIN `_akt_dat_von_dat_bis` AS XXX_1 ON BF.mandant_id = XXX.mandant_id AND BF.dat BETWEEN XXX.akt_dat_von AND XXX.akt_dat_bis
        INNER JOIN dbp_data.werbewoche_kl_1 AS Z
            ON
                Z.dat BETWEEN XXX.akt_dat_von AND XXX.akt_dat_bis AND BF.dat
                = Z.dat AND XXX.mandant_id = Z.mandant_id AND BF.mandant_id = Z.mandant_id
        INNER JOIN dbp_data.wup_1 AS W ON BF.wup_id = W.wup_id AND BF.mandant_id = W.mandant_id
        LEFT JOIN (
            SELECT
                mandant_id,
                wup_id,
                art_id,
                MAX(vk_brutto) AS vk_brutto
            FROM dbp_process.bf_hit_the_actions_kmo_1
            WHERE (
                mandant_id, kjwo) IN (
                SELECT (mandant_id, woche_1)
                FROM `_woche`
            )
            AND (
                mandant_id, kl_art_id) NOT IN (
                SELECT (mandant_id, kl_art_id)
                FROM `_exclude_displays`
            )
            GROUP BY
                mandant_id,
                wup_id,
                art_id
        ) AS x ON BF.wup_id = x.wup_id AND BF.mutter_id_wb = x.art_id AND BF.mandant_id = x.mandant_id
        WHERE
            BF.a_absatz_akt > 0
            AND (
                BF.mandant_id, BF.shopperwoche) IN (
                SELECT (mandant_id, woche_1)
                FROM `_woche`
            )
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_mutter_id_wb`,
            `_shopperwoche`,
            `_baseline`
    ) AS xxx_1
    WHERE
        bf_shopper_front_kmo.mandant_id = xxx.`_mandant_id` AND bf_shopper_front_kmo.wup_id = xxx.`_wup_id` AND
        bf_shopper_front_kmo.mutter_id_wb = xxx.`_mutter_id_wb` AND bf_shopper_front_kmo.shopperwoche = xxx.`_shopperwoche`
        AND bf_shopper_front_kmo.baseline = xxx.`_baseline`;


    UPDATE dbp_etl.bf_shopper_front_kmo SET
        restbon_af = xxx.`_restbon_af`,
        restbon_gesamt = xxx.`_rb_errechnet`,
        akt_np_umsatz = xxx.`_akt_np_umsatz`,
        anz_bon_sa = xxx.`_anz_bon_sa` FROM (
        SELECT
            W.mandant_id AS `_mandant_id`,
            W.aktuell_wup_id AS `_wup_id`,
            BF.mutter_id_wb AS `_mutter_id_wb`,
            BF.shopperwoche AS `_shopperwoche`,
            1 AS `_baseline`,
            COUNT(DISTINCT CAST(W.wup_id AS STRING) || BF.bon_id) AS `_anz_bon_sa`,
            (
                SUM(BF.ges_umsatz_af + BF.ges_umsatz_sa) - SUM(BF.a_umsatz_af + BF.a_umsatz_sa)) / COUNT(
                DISTINCT CAST(W.wup_id AS STRING)
                || BF.bon_id
            ) AS `_rb_errechnet`,
            SUM(BF.ges_umsatz_af + BF.ges_umsatz_sa - BF.ges_umsatz_akt) / COUNT(DISTINCT CAST(W.wup_id AS STRING) || BF.bon_id
            ) AS `_restbon_af`,
            SUM(BF.ges_umsatz_af + BF.ges_umsatz_sa - BF.ges_umsatz_akt) / COUNT(DISTINCT CAST(W.wup_id AS STRING) || CAST(BF.dat AS STRING)
            ) AS `_akt_np_umsatz`
        FROM dbp_etl.bf_bons_kpicp_akt_kmo AS BF
        INNER JOIN dbp_data.werbewoche_kl_1 AS Z ON BF.dat = Z.dat AND BF.mandant_id = Z.mandant_id
        INNER JOIN dbp_data.wup_1 AS W ON BF.wup_id = W.wup_id AND BF.mandant_id = W.mandant_id
        INNER JOIN `_akt_dat_von_dat_bis` AS XXX_1 ON BF.mandant_id = XXX.mandant_id AND BF.dat BETWEEN XXX.akt_dat_von AND XXX.akt_dat_bis
        WHERE
            BF.a_absatz_akt > 0
            AND Z.mandant_id > 1
            AND (
                BF.mandant_id, BF.shopperwoche) IN (
                SELECT (mandant_id, woche_1)
                FROM `_woche`
            )
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_mutter_id_wb`,
            `_shopperwoche`,
            `_baseline`
    ) AS xxx_1
    WHERE
        bf_shopper_front_kmo.mandant_id = xxx.`_mandant_id` AND bf_shopper_front_kmo.wup_id = xxx.`_wup_id` AND
        bf_shopper_front_kmo.mutter_id_wb = xxx.`_mutter_id_wb` AND bf_shopper_front_kmo.shopperwoche = xxx.`_shopperwoche`
        AND bf_shopper_front_kmo.baseline = xxx.`_baseline`;


    -- Jetzt Gesamtumsatz ueber den Baseline-Zeitraum, nicht mehr
    -- ueber Aktionszeitraum.


    UPDATE dbp_etl.bf_shopper_front_kmo SET
        ges_umsatz_ohne_art = xxx.`_ums_gesamt_ausser_artikel`,
        ges_umsatz_inkl_wv = xxx.`_ums_gesamt_af_mit_wv` FROM (
        SELECT
            W.mandant_id AS `_mandant_id`,
            W.aktuell_wup_id AS `_wup_id`,
            BF.mutter_id_wb AS `_mutter_id_wb`,
            BF.shopperwoche AS `_shopperwoche`,
            1 AS `_baseline`,
            SUM(BF.ges_umsatz_af + BF.ges_umsatz_sa) - SUM(BF.a_umsatz_af + BF.a_umsatz_sa) AS `_ums_gesamt_ausser_artikel`,
            SUM(BF.ges_umsatz_af + BF.ges_umsatz_sa - BF.ges_umsatz_akt) AS `_ums_gesamt_af_mit_wv`
        FROM dbp_etl.bf_bons_kpicp_akt_kmo AS BF
        INNER JOIN dbp_data.werbewoche_kl_1 AS Z ON BF.dat = Z.dat AND BF.mandant_id = Z.mandant_id
        INNER JOIN dbp_data.wup_1 AS W ON BF.wup_id = W.wup_id AND BF.mandant_id = W.mandant_id
        INNER JOIN `_akt_dat_von_dat_bis` AS XXX_1 ON BF.mandant_id = XXX.mandant_id AND BF.dat BETWEEN XXX.akt_dat_von AND XXX.akt_dat_bis
        WHERE
            BF.a_absatz_akt > 0
            AND Z.mandant_id > 1
            AND (
                BF.mandant_id, BF.shopperwoche) IN (
                SELECT (mandant_id, woche_1)
                FROM `_woche`
            )
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_mutter_id_wb`,
            `_shopperwoche`,
            `_baseline`
    ) AS xxx_1
    WHERE
        bf_shopper_front_kmo.mandant_id = xxx.`_mandant_id` AND bf_shopper_front_kmo.wup_id = xxx.`_wup_id` AND
        bf_shopper_front_kmo.mutter_id_wb = xxx.`_mutter_id_wb` AND bf_shopper_front_kmo.shopperwoche = xxx.`_shopperwoche`
        AND bf_shopper_front_kmo.baseline = xxx.`_baseline`;


    DELETE FROM dbp_etl.bf_shopper_kmo
    WHERE (
        mandant_id, shopperwoche) IN (
        SELECT (mandant_id, woche_1)
        FROM `_woche`
    );


    INSERT INTO dbp_etl.bf_shopper_kmo
    (
        SELECT *
        FROM dbp_etl.bf_shopper_front_kmo
        WHERE (
            mandant_id, shopperwoche) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        )
    );


    -- Jetzt die Aufbereitung der SHOPPER_1-Tabelle!!!


    DELETE FROM dbp_data.shopper_1
    WHERE (
        mandant_id, kjwo_werbe_ende) IN (
        SELECT (mandant_id, woche_1)
        FROM `_woche`
    );


    INSERT INTO dbp_data.shopper_1 (
        wup_id, nb_id, mandant_id, art_id_werbung, baseline, kjwo_werbe_ende,
        dat_baseline_von, dat_baseline_bis, anz_markt_baseline_af, ums_netto_baseline_af, ums_netto_sa, menge_baseline_af,
        menge_sa, ertrag_baseline_af, ertrag_sa, anz_kaeufer_af, anz_kaeufer_sa, anz_bon_af, anz_bon_sa, anz_bon_aktion,
        anz_tage_baseline_af, anz_tage_sa, kaeufer_prozent_baseline_af, kaeufer_prozent_sa, anz_cp_kaeufer,
        anz_cp_kaeufer_70_prozent, ums_rest_bon_af, ums_rest_bon_gesamt, ums_aktivierter_normalpreis, wrg_id,
        aktion_thema_gruppe_id, medien_kz, menge_wo1, menge_wo2, menge_wo3, anz_tage_wo1, anz_tage_wo2, anz_tage_wo3,
        vk_brutto_af_mittel, vk_brutto_sa_mittel, ums_gesamt_ausser_artikel, ums_gesamt_af_mit_wv, anz_markt_sa
    )
    (
        SELECT
            A.wup_id,
            A.nb_id,
            A.mandant_id,
            A.mutter_id_wb AS art_id_werbung,
            A.baseline,
            A.shopperwoche AS kjwo_werbe_ende,
            A.min_dat_bl AS dat_baseline_von,
            A.max_dat_bl AS dat_baseline_bis,
            A.anz_af_maerkte AS anz_markt_baseline_af,
            A.af_ums_netto AS ums_netto_baseline_af,
            A.akt_ums_netto AS ums_netto_sa,
            A.af_absatz AS menge_baseline_af,
            A.akt_absatz AS menge_sa,
            A.af_ertrag AS ertrag_baseline_af,
            A.akt_ertrag AS ertrag_sa,
            A.anz_kaeufer_af,
            A.anz_bon_sa AS anz_kaeufer_sa,
            A.anz_bon_af,
            A.anz_bon_sa,
            A.anz_bon_aktion,
            A.rw_af_tage AS anz_tage_baseline_af,
            A.rw_akt_tage AS anz_tage_sa,
            A.bl_af_kd_rw AS kaeufer_prozent_baseline_af,
            A.bl_akt_kd_rw AS kaeufer_prozent_sa,
            A.cp_kaeufer AS anz_cp_kaeufer,
            A.cp_alle_70 AS anz_cp_kaeufer_70_prozent,
            A.restbon_af AS ums_rest_bon_af,
            A.restbon_gesamt AS ums_rest_bon_gesamt,
            A.akt_np_umsatz AS ums_aktivierter_normalpreis,
            B.default_wrg AS wrg_id,
            -1 AS aktion_thema_gruppe_id,
            '' AS medien_kz,
            0 AS menge_wo1,
            0 AS menge_wo2,
            0 AS menge_wo3,
            0 AS anz_tage_wo1,
            0 AS anz_tage_wo2,
            0 AS anz_tage_wo3,
            0 AS vk_brutto_af_mittel,
            0 AS vk_brutto_sa_mittel,
            A.ges_umsatz_ohne_art,
            A.ges_umsatz_inkl_wv,
            A.anz_markt_sa
        FROM dbp_etl.bf_shopper_kmo AS A
        INNER JOIN dbp_data.mandant_1 AS B ON A.mandant_id = B.mandant_id
        WHERE (
            A.mandant_id, A.shopperwoche) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        )
    );


    -- Updates fuer VK_1-Preise!


    UPDATE dbp_data.shopper_1 SET
        vk_brutto_af_mittel = b.vk_brutto_af_mittel,
        vk_brutto_sa_mittel = b.vk_brutto_sa_mittel FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id_werbung,
            A.kjwo_werbe_ende,
            A.baseline,
            CAST(IFNULL(A.ums_netto_baseline_af / IF(A.menge_baseline_af = 0, NULL, A.menge_baseline_af), 0) * (C.mwst / 100 + 1) AS NUMERIC)
                AS vk_brutto_af_mittel,
            CAST(IFNULL(A.ums_netto_sa / IF(A.menge_sa = 0, NULL, A.menge_sa), 0) * (C.mwst / 100 + 1) AS NUMERIC)
                AS
                vk_brutto_sa_mittel
        FROM dbp_data.shopper_1 AS A
        INNER JOIN (
            SELECT
                mandant_id,
                kjwo_ww AS kjwo,
                MAX(dat) AS dat
            FROM dbp_data.werbewoche_kl_1
            WHERE
                kjwo_ww >= 201601
                AND mandant_id > 1
            GROUP BY
                mandant_id,
                kjwo
        ) AS x ON A.kjwo_werbe_ende = x.kjwo AND A.mandant_id = x.mandant_id
        INNER JOIN dbp_data.art_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id_werbung = B.art_id
        INNER JOIN dbp_data.mwst_per_1 AS C
            ON
                A.mandant_id = C.mandant_id AND B.mwst_id = C.mwst_id AND x.dat
                BETWEEN C.dat_von AND C.dat_bis
        WHERE (
            A.mandant_id, A.kjwo_werbe_ende) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        )
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id_werbung,
            A.kjwo_werbe_ende,
            A.baseline,
            vk_brutto_af_mittel,
            vk_brutto_sa_mittel
    ) AS b
    WHERE
        shopper.mandant_id = b.mandant_id AND shopper.wup_id = b.wup_id AND shopper.art_id_werbung = b.art_id_werbung AND
        shopper.kjwo_werbe_ende = b.kjwo_werbe_ende AND shopper.baseline = b.baseline;


    CREATE OR REPLACE TEMPORARY TABLE _upd AS
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id_werbung,
        A.kjwo_werbe_ende,
        MAX(x1.vk_aktion_brutto) AS max_vk_brutto_sa
    FROM dbp_data.shopper_1 AS A
    INNER JOIN (
        SELECT
            mandant_id,
            kjwo_ww AS kjwo,
            MAX(dat) AS dat
        FROM dbp_data.werbewoche_kl_1
        WHERE
            kjwo_ww >= 201601
            AND mandant_id > 1
        GROUP BY
            mandant_id,
            kjwo
    ) AS x ON A.kjwo_werbe_ende = x.kjwo AND A.mandant_id = x.mandant_id
    INNER JOIN (
        SELECT
            AKT.mandant_id,
            AKT.dat_von,
            AKT.dat_bis,
            AKTA.wup_id,
            AKTA.art_id,
            AKTA.vk_aktion_brutto
        FROM dbp_data.aktion_1 AS AKT
        INNER JOIN dbp_data.aktion_art_wup_zu_1 AS AKTA
            ON
                AKT.aktion_id = AKTA.aktion_id AND AKT.mandant_id =
                AKTA.mandant_id
        WHERE
            AKTA.grund_sperrung IS NULL
            AND AKT.mandant_id > 1
    ) AS x1 ON A.mandant_id = x1.mandant_id AND A.wup_id = x1.wup_id AND A.art_id_werbung = x1.art_id

    INNER JOIN (
        SELECT
            mandant_id,
            kjwo_ww AS kjwo,
            MIN(dat) AS min_dat,
            MAX(dat) AS max_dat
        FROM dbp_data.werbewoche_kl_1
        WHERE (
            mandant_id, kjwo_ww) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        )
        GROUP BY
            mandant_id,
            kjwo
    ) AS x2 ON x1.dat_bis BETWEEN x2.min_dat AND x2.max_dat AND x1.mandant_id = x2.mandant_id
    WHERE (
        A.mandant_id, A.kjwo_werbe_ende) IN (
        SELECT (mandant_id, woche_1)
        FROM `_woche`
    )
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.art_id_werbung,
        A.kjwo_werbe_ende;


    UPDATE dbp_data.shopper_1 SET
        vk_brutto_sa_max = b.max_vk_brutto_sa
    FROM `_upd` AS b
    WHERE
        shopper.mandant_id = b.mandant_id AND shopper.wup_id = b.wup_id AND shopper.art_id_werbung = b.art_id_werbung AND
        shopper.kjwo_werbe_ende = b.kjwo_werbe_ende;


    -- Werbenachbetrachtung

    -- fuer 3. Woche_1


    UPDATE dbp_data.shopper_1 SET
        menge_wo3 = b.menge,
        anz_tage_wo3 = b.anz_mt FROM (
        SELECT
            A.mandant_id,
            t2.kjwo,
            D.aktuell_wup_id AS wup_id,
            t2.art_id AS art_id_werbung,
            SUM(COALESCE(A.menge / t2.mengen_faktor, A.menge)) AS menge,
            COUNT(DISTINCT A.dat) AS anz_mt
        FROM dbp_data.artbew_1 AS A
        INNER JOIN dbp_data.werbewoche_kl_1 AS B ON A.dat = B.dat AND B.mandant_id > 1 AND A.mandant_id = B.mandant_id

        INNER JOIN dbp_data.wup_1 AS D ON A.mandant_id = D.mandant_id AND A.wup_id = D.wup_id
        INNER JOIN (
            SELECT
                mandant_id,
                kjwo,
                wup_id,
                art_id,
                kl_art_id,
                MIN(mengen_faktor) AS mengen_faktor
            FROM dbp_process.bf_hit_the_actions_kmo_1
            WHERE (
                mandant_id, kjwo) IN (
                SELECT (mandant_id, woche_wn3)
                FROM `_woche`
            )
            GROUP BY
                mandant_id,
                wup_id,
                kjwo,
                art_id,
                kl_art_id
        ) AS t2
            ON
                A.mandant_id = t2.mandant_id AND CAST(FLOOR(A.art_id / 10) AS INTEGER) = t2.kl_art_id AND A.wup_id
                = t2.wup_id
        WHERE (
            A.mandant_id, B.kjwo_ww) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        )
        GROUP BY
            A.mandant_id,
            t2.kjwo,
            wup_id,
            art_id_werbung
    ) AS b
    WHERE
        shopper.mandant_id = b.mandant_id AND shopper.kjwo_werbe_ende = b.kjwo AND shopper.art_id_werbung = b.art_id_werbung
        AND shopper.wup_id = b.wup_id;


    -- fuer 2. Woche_1


    UPDATE dbp_data.shopper_1 SET
        menge_wo2 = b.menge,
        anz_tage_wo2 = b.anz_mt FROM (
        SELECT
            A.mandant_id,
            t2.kjwo,
            D.aktuell_wup_id AS wup_id,
            t2.art_id AS art_id_werbung,
            SUM(COALESCE(A.menge / t2.mengen_faktor, A.menge)) AS menge,
            COUNT(DISTINCT A.dat) AS anz_mt
        FROM dbp_data.artbew_1 AS A
        INNER JOIN dbp_data.werbewoche_kl_1 AS B ON A.dat = B.dat AND B.mandant_id > 1 AND A.mandant_id = B.mandant_id

        INNER JOIN dbp_data.wup_1 AS D ON A.mandant_id = D.mandant_id AND A.wup_id = D.wup_id
        INNER JOIN (
            SELECT
                mandant_id,
                kjwo,
                wup_id,
                art_id,
                kl_art_id,
                MIN(mengen_faktor) AS mengen_faktor
            FROM dbp_process.bf_hit_the_actions_kmo_1
            WHERE (
                mandant_id, kjwo) IN (
                SELECT (mandant_id, woche_wn2)
                FROM `_woche`
            )
            GROUP BY
                mandant_id,
                wup_id,
                kjwo,
                art_id,
                kl_art_id
        ) AS t2
            ON
                A.mandant_id = t2.mandant_id AND CAST(FLOOR(A.art_id / 10) AS INTEGER) = t2.kl_art_id AND A.wup_id
                = t2.wup_id
        WHERE (
            A.mandant_id, B.kjwo_ww) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        )
        GROUP BY
            A.mandant_id,
            t2.kjwo,
            wup_id,
            art_id_werbung
    ) AS b
    WHERE
        shopper.mandant_id = b.mandant_id AND shopper.kjwo_werbe_ende = b.kjwo AND shopper.art_id_werbung = b.art_id_werbung
        AND shopper.wup_id = b.wup_id;


    -- fuer 1. Woche_1


    UPDATE dbp_data.shopper_1 SET
        menge_wo1 = b.menge,
        anz_tage_wo1 = b.anz_mt FROM (
        SELECT
            A.mandant_id,
            t2.kjwo,
            D.aktuell_wup_id AS wup_id,
            t2.art_id AS art_id_werbung,
            SUM(COALESCE(A.menge / t2.mengen_faktor, A.menge)) AS menge,
            COUNT(DISTINCT A.dat) AS anz_mt
        FROM dbp_data.artbew_1 AS A
        INNER JOIN dbp_data.werbewoche_kl_1 AS B ON A.dat = B.dat AND B.mandant_id > 1 AND A.mandant_id = B.mandant_id

        INNER JOIN dbp_data.wup_1 AS D ON A.mandant_id = D.mandant_id AND A.wup_id = D.wup_id
        INNER JOIN (
            SELECT
                mandant_id,
                kjwo,
                wup_id,
                art_id,
                kl_art_id,
                MIN(mengen_faktor) AS mengen_faktor
            FROM dbp_process.bf_hit_the_actions_kmo_1
            WHERE (
                mandant_id, kjwo) IN (
                SELECT (mandant_id, woche_wn1)
                FROM `_woche`
            )
            GROUP BY
                mandant_id,
                wup_id,
                kjwo,
                art_id,
                kl_art_id
        ) AS t2
            ON
                A.mandant_id = t2.mandant_id AND CAST(FLOOR(A.art_id / 10) AS INTEGER) = t2.kl_art_id AND A.wup_id
                = t2.wup_id
        WHERE (
            A.mandant_id, B.kjwo_ww) IN (
            SELECT (mandant_id, woche_1)
            FROM `_woche`
        )
        GROUP BY
            A.mandant_id,
            t2.kjwo,
            wup_id,
            art_id_werbung
    ) AS b
    WHERE
        shopper.mandant_id = b.mandant_id AND shopper.kjwo_werbe_ende = b.kjwo AND shopper.art_id_werbung = b.art_id_werbung
        AND shopper.wup_id = b.wup_id;

END;
