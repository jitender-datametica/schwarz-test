DECLARE shopperzeit INT64;

SET shopperzeit = ${SHOPWO};


UPDATE dbp_process.tag_shopper_2 SET
    akt_wo = tag_shopper.akt_wo - 1 FROM (
    SELECT COUNT(*) AS anzahl
    FROM dbp_data.tag_2 AS A
    INNER JOIN dbp_process.tag_shopper_2
        AS B ON A.dat = B.dat AND A.wtag_id = 4 AND B.wtag_id = 4 AND A.akt_wo
    = -1 AND B.akt_wo = -1 AND A.kjwo = B.kjwo
) AS b
WHERE b.anzahl = 0;


CREATE OR REPLACE TEMPORARY TABLE _dat_von_dat_bis AS
SELECT
    A.mandant_id,
    b.dat_von,
    c.dat_bis
FROM dbp_data.mandant_2 AS A
INNER JOIN (SELECT
    mandant_id,
    MIN(dat) AS dat_von
FROM dbp_data.werbewoche_kl_2
WHERE
    akt_kjwo_ww = shopperzeit - 53
    AND mandant_id = 1
GROUP BY mandant_id) AS b ON A.mandant_id = b.mandant_id
INNER JOIN (SELECT
    mandant_id,
    MAX(dat) AS dat_bis
FROM dbp_data.werbewoche_kl_2
WHERE
    akt_kjwo_ww = shopperzeit
    AND mandant_id = 1
GROUP BY mandant_id) AS c ON A.mandant_id = c.mandant_id
WHERE A.mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _woche AS
SELECT
    A.mandant_id,
    b.akt_kjwo_ww,
    b.woche_2,
    b.dat_von,
    b.dat_bis,
    c.woche_wn1,
    d.woche_wn2,
    e.woche_wn3
FROM dbp_data.mandant_2 AS A
INNER JOIN (
    SELECT
        mandant_id,
        akt_kjwo_ww,
        kjwo_ww AS woche_2,
        MIN(dat) AS dat_von,
        MAX(dat) AS dat_bis
    FROM dbp_data.werbewoche_kl_2
    WHERE
        akt_kjwo_ww = shopperzeit
        AND mandant_id = 1
    GROUP BY
        mandant_id,
        akt_kjwo_ww,
        woche_2
) AS b ON A.mandant_id = b.mandant_id
INNER JOIN (
    SELECT
        mandant_id,
        kjwo_ww AS woche_wn1
    FROM dbp_data.werbewoche_kl_2
    WHERE
        akt_kjwo_ww = shopperzeit - 1
        AND mandant_id = 1
    GROUP BY
        mandant_id,
        woche_wn1
) AS c ON A.mandant_id = c.mandant_id
INNER JOIN (
    SELECT
        mandant_id,
        kjwo_ww AS woche_wn2
    FROM dbp_data.werbewoche_kl_2
    WHERE
        akt_kjwo_ww = shopperzeit - 2
        AND mandant_id = 1
    GROUP BY
        mandant_id,
        woche_wn2
) AS d ON A.mandant_id = d.mandant_id
INNER JOIN (
    SELECT
        mandant_id,
        kjwo_ww AS woche_wn3
    FROM dbp_data.werbewoche_kl_2
    WHERE
        akt_kjwo_ww = shopperzeit - 3
        AND mandant_id = 1
    GROUP BY
        mandant_id,
        woche_wn3
) AS e ON A.mandant_id = e.mandant_id
WHERE A.mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _akt_dat_von_dat_bis AS
SELECT
    A.mandant_id,
    b.akt_dat_von,
    c.akt_dat_bis
FROM dbp_data.mandant_2 AS A
INNER JOIN (SELECT
    mandant_id,
    MIN(dat) AS akt_dat_von
FROM dbp_data.werbewoche_kl_2
WHERE
    akt_kjwo_ww = shopperzeit - 1
    AND mandant_id = 1
GROUP BY mandant_id) AS b ON A.mandant_id = b.mandant_id
INNER JOIN (SELECT
    mandant_id,
    MAX(dat) AS akt_dat_bis
FROM dbp_data.werbewoche_kl_2
WHERE
    akt_kjwo_ww = shopperzeit
    AND mandant_id = 1
GROUP BY mandant_id) AS c ON A.mandant_id = c.mandant_id
WHERE A.mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _bl_dat_von_dat_bis AS
SELECT
    A.mandant_id,
    b.bl_dat_von,
    c.bl_dat_bis
FROM dbp_data.mandant_2 AS A
INNER JOIN (SELECT
    mandant_id,
    MIN(dat) AS bl_dat_von
FROM dbp_data.werbewoche_kl_2
WHERE
    akt_kjwo_ww = shopperzeit - 53
    AND mandant_id = 1
GROUP BY mandant_id) AS b ON A.mandant_id = b.mandant_id
INNER JOIN (SELECT
    mandant_id,
    MAX(dat) AS bl_dat_bis
FROM dbp_data.werbewoche_kl_2
WHERE
    akt_kjwo_ww = shopperzeit - 2
    AND mandant_id = 1
GROUP BY mandant_id) AS c ON A.mandant_id = c.mandant_id
WHERE A.mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _perf_01 AS
SELECT
    AKT.mandant_id,
    AKTA.art_id,
    AKTA.wup_id,
    AKT.dat_von,
    AKT.dat_bis,
    AKTA.aktion_thema_id
FROM dbp_data.aktion_2 AS AKT
INNER JOIN dbp_data.aktion_art_wup_zu_2 AS AKTA
    ON
        AKT.aktion_id = AKTA.aktion_id AND AKT.mandant_id =
        AKTA.mandant_id
INNER JOIN `_woche` AS X ON AKT.dat_bis BETWEEN X.dat_von AND X.dat_bis AND AKT.mandant_id = X.mandant_id
WHERE
    AKTA.dat_sperrung IS NULL
    AND AKT.preisaktiviert_fg = 1
    AND AKT.mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _hit_the_actions AS
SELECT
    Y.mandant_id,
    W.wup_id,
    X.woche_2 AS kjwo,
    COALESCE(xx.aktion_thema_gruppe_id, 6) AS aktion_thema_gruppe_id,
    Y.art_id,
    A.kl_art_id,
    'W' AS muki,
    Y.dat_bis,
    1 AS mengen_faktor,
    A.posten_id,
    0 AS vk_brutto
FROM `_perf_01` AS Y
LEFT JOIN (SELECT
    mandant_id,
    aktion_thema_id,
    aktion_thema_gruppe_id
FROM dbp_process.l_aktion_thema_2
WHERE aktion_thema_gruppe_id IS NOT NULL
UNION DISTINCT
SELECT
    mandant_id,
    aktion_thema_id,
    aktion_thema_gruppe_id
FROM dbp_etl.l_aktion_thema_2) AS xx ON Y.aktion_thema_id = xx.aktion_thema_id AND Y.mandant_id = xx.mandant_id

INNER JOIN dbp_data.art_2 AS A ON Y.mandant_id = A.mandant_id AND A.mutter_wb_id IS NULL AND Y.art_id = A.art_id
INNER JOIN dbp_data.wup_2 AS W
    ON
        Y.wup_id = W.wup_id AND Y.mandant_id = W.mandant_id AND W.nb_id = 0 AND
        Y.dat_von BETWEEN W.dat_von AND W.dat_bis
INNER JOIN dbp_data.art_wg_zu_per_2 AS AW ON Y.art_id = AW.art_id AND Y.mandant_id = AW.mandant_id AND AW.arthiertyp_id = 2 AND AW.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wg_per_2 AS WP
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
        X.woche_2 AS kjwo,
        COALESCE(xx.aktion_thema_gruppe_id, 6) AS aktion_thema_gruppe_id,
        Y.art_id,
        A.kl_art_id,
        'M' AS muki,
        Y.dat_bis,
        1 AS mengen_faktor,
        A.posten_id,
        0 AS vk_brutto
    FROM `_perf_01` AS Y
    LEFT JOIN (SELECT
        mandant_id,
        aktion_thema_id,
        aktion_thema_gruppe_id
    FROM dbp_process.l_aktion_thema_2
    WHERE aktion_thema_gruppe_id IS NOT NULL
    UNION DISTINCT
    SELECT
        mandant_id,
        aktion_thema_id,
        aktion_thema_gruppe_id
    FROM dbp_etl.l_aktion_thema_2) AS xx ON Y.aktion_thema_id = xx.aktion_thema_id AND Y.mandant_id = xx.mandant_id

    INNER JOIN dbp_data.art_2 AS A ON Y.mandant_id = A.mandant_id AND Y.art_id = A.mutter_wb_id
    INNER JOIN dbp_data.wup_2 AS W
        ON
            Y.wup_id = W.wup_id AND Y.mandant_id = W.mandant_id AND W.nb_id = 0 AND
            Y.dat_von BETWEEN W.dat_von AND W.dat_bis
    INNER JOIN dbp_data.art_wg_zu_per_2 AS AW ON Y.art_id = AW.art_id AND Y.mandant_id = AW.mandant_id AND AW.arthiertyp_id = 2 AND AW.dat_bis = DATE '9999-12-31'
    INNER JOIN dbp_data.wg_per_2 AS WP
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
    FROM dbp_data.art_wup_vk_per_2 AS A
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
            A.mandant_id = t0.mandant_id AND CAST(FLOOR(A.art_id / 100) AS INTEGER) = t0.kl_art_id AND A.wup_id
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
        H.wup_id,
        H.art_id AS mu,
        H.kl_art_id AS kind,
        W.vk_brutto AS k_br,
        X.vk_brutto AS m_br,
        CAST(X.vk_brutto AS NUMERIC) / CAST(W.vk_brutto AS NUMERIC) AS mengen_faktor
    FROM `_hit_the_actions` AS H
    INNER JOIN dbp_data.art_2 AS A
        ON
            H.mandant_id = A.mandant_id AND H.kl_art_id = A.kl_art_id AND A.dat_bis
            = DATE '9999-12-31'
    INNER JOIN dbp_data.art_wg_zu_per_2 AS WG
        ON
            H.mandant_id = WG.mandant_id AND H.kl_art_id = CAST(FLOOR(WG.art_id / 100) AS INTEGER)
            AND WG.arthiertyp_id = 2 AND WG.dat_bis = DATE '9999-12-31'
    INNER JOIN dbp_data.art_wup_vk_per_2 AS W
        ON
            H.wup_id = W.wup_id AND H.mandant_id = W.mandant_id AND A.art_id
            = W.art_id AND H.dat_bis BETWEEN W.dat_von AND W.dat_bis
    INNER JOIN dbp_data.art_wup_vk_per_2 AS X
        ON
            H.mandant_id = X.mandant_id AND H.art_id = X.art_id AND W.wup_id
            = X.wup_id AND H.dat_bis BETWEEN X.dat_von AND X.dat_bis
    WHERE
        WG.wg_id IN (
            SELECT wg_id
            FROM dbp_data.wg_filter_zu_2
            WHERE
                mandant_id = 1
                AND wg_filter_id = 31
        )
    GROUP BY
        H.kjwo,
        H.wup_id,
        mu,
        kind,
        k_br,
        m_br,
        mengen_faktor
) AS b
WHERE
    `_hit_the_actions`.kjwo = b.kjwo AND `_hit_the_actions`.wup_id = b.wup_id AND `_hit_the_actions`.art_id = b.mu AND
    `_hit_the_actions`.kl_art_id = b.kind;


DELETE FROM dbp_process.bf_hit_the_actions_2
WHERE (
    mandant_id, wup_id, kjwo) IN (
    SELECT (mandant_id, wup_id, kjwo)
    FROM `_hit_the_actions`
);


INSERT INTO dbp_process.bf_hit_the_actions_2
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
    kl_art_id,
    art_id
FROM `_hit_the_actions`
GROUP BY
    art_id,
    kl_art_id
UNION DISTINCT
SELECT
    kl_art_id,
    art_id
FROM dbp_data.art_2
WHERE
    dat_bis = DATE '9999-12-31'
    AND mandant_id = 1
    AND wg_art_fg = 1
GROUP BY
    art_id,
    kl_art_id;


CREATE OR REPLACE TEMPORARY TABLE _aktuelle_wg AS
SELECT
    A.mandant_id,
    CAST(FLOOR(B.art_id / 100) AS INTEGER) AS kl_art_id,
    A.wg_id
FROM dbp_data.art_wg_zu_per_2 AS A
INNER JOIN dbp_data.art_2 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
WHERE
    A.mandant_id = 1
    AND B.art_id > 0
    AND A.arthiertyp_id = 2
    AND A.dat_bis = DATE '9999-12-31'
    AND B.dat_bis = DATE '9999-12-31';


CREATE OR REPLACE TEMPORARY TABLE _mutter_art AS
SELECT
    A.kl_art_id,
    A.art_id,
    COALESCE(A.mutter_wb_id, A.art_id) AS mutter_wb_id,
    B.wg_id
FROM dbp_data.art_2 AS A
INNER JOIN dbp_data.art_wg_zu_per_2 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
WHERE
    A.mandant_id = 1
    AND A.dat_bis = DATE '9999-12-31'
    AND A.kl_art_id IN (
        SELECT kl_art_id
        FROM `_kl_art`
    );


CREATE OR REPLACE TEMPORARY TABLE _mutter_wg AS
SELECT
    mutter_wb_id,
    MAX(wg_id) AS wg_id
FROM `_mutter_art`
GROUP BY mutter_wb_id;


CREATE OR REPLACE TEMPORARY TABLE _wochen AS
SELECT A.dat
FROM dbp_data.werbewoche_kl_2 AS A
INNER JOIN `_woche` AS B ON A.mandant_id = B.mandant_id AND A.akt_kjwo_ww = B.akt_kjwo_ww
GROUP BY A.dat;


INSERT INTO dbp_etl_process.shopper_maerkte_2 (mandant_id, wup_id)
(
    SELECT
        mandant_id,
        wup_id
    FROM dbp_ods.ods_bon_kopf_2
    WHERE
        mandant_id = 1
        AND bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 90 DAY) AND (CURRENT_DATE("Europe/Berlin"))
        AND (
            mandant_id, wup_id) NOT IN (
            SELECT (mandant_id, wup_id)
            FROM dbp_etl_process.shopper_maerkte_2
        )
    GROUP BY
        mandant_id,
        wup_id
);


CREATE OR REPLACE TEMPORARY TABLE _bon_for_missing_aktion_id AS
SELECT
    A.bon_dat,
    A.mandant_id,
    A.wup_id,
    A.kl_art_id,
    MAX(B.aktion_id) AS aktion_id
FROM dbp_spezial.v_ods_promotion_union_2 AS A
INNER JOIN dbp_data.l_bonuskauf_2 AS B ON A.bonuskauf_id = B.bonuskauf_id AND A.mandant_id = B.mandant_id
GROUP BY
    A.bon_dat,
    A.mandant_id,
    A.wup_id,
    A.kl_art_id;


CREATE OR REPLACE TEMPORARY TABLE _test_upd AS
SELECT
    t5.aktion_id,
    t5.mandant_id,
    CAST(FLOOR(X4.art_id / 100) AS INTEGER) AS kl_art_id,
    X4.wup_id,
    t5.dat_von,
    t5.dat_bis
FROM (
    SELECT
        X1.mandant_id,
        X1.aktion_id,
        X1.dat_von,
        X1.dat_bis
    FROM dbp_data.aktion_2 AS X1
    INNER JOIN dbp_process.tag_shopper_2 AS X2
        ON
            X2.dat BETWEEN X1.dat_von AND X1.dat_bis AND X1.mandant_id
            = 1
    WHERE
        X2.dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 53) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
        )
        AND X1.preisaktiviert_fg = 1
    GROUP BY
        X1.aktion_id,
        X1.mandant_id,
        X1.dat_von,
        X1.dat_bis
) AS t5
INNER JOIN dbp_data.aktion_art_wup_zu_2 AS X4 ON t5.aktion_id = X4.aktion_id AND t5.mandant_id = X4.mandant_id

WHERE X4.dat_sperrung IS NULL;


DELETE FROM `_test_upd`
WHERE (aktion_id, mandant_id, kl_art_id, wup_id) IN (SELECT (
    aktion_id,
    mandant_id, kl_art_id, wup_id
)
FROM `_bon_for_missing_aktion_id`) AND dat_bis >= (SELECT akt_dat_von
FROM `_akt_dat_von_dat_bis`);


INSERT INTO `_test_upd`
(
    SELECT
        A.aktion_id,
        CAST(A.mandant_id AS INTEGER) AS mandant_id,
        A.kl_art_id AS kl_art_id,
        CAST(A.wup_id AS INTEGER) AS wup_id,
        B.akt_dat_von,
        B.akt_dat_bis
    FROM `_bon_for_missing_aktion_id` AS A
    INNER JOIN `_akt_dat_von_dat_bis` AS B ON A.mandant_id = B.mandant_id AND A.bon_dat BETWEEN B.akt_dat_von AND B.akt_dat_bis

    WHERE (A.aktion_id, A.mandant_id, A.kl_art_id, A.wup_id) NOT IN (SELECT (
        aktion_id, mandant_id,
        kl_art_id, wup_id
    )
    FROM `_test_upd`)
    GROUP BY
        A.aktion_id,
        mandant_id,
        kl_art_id,
        wup_id,
        B.akt_dat_von,
        B.akt_dat_bis
);


CREATE OR REPLACE TEMPORARY TABLE _test_upd_kopf AS
SELECT
    X1.mandant_id,
    X1.aktion_id,
    X1.dat_von,
    X1.dat_bis
FROM dbp_data.aktion_2 AS X1
INNER JOIN dbp_process.tag_shopper_2 AS X2
    ON
        X2.dat BETWEEN X1.dat_von AND X1.dat_bis AND X1.mandant_id =
        1
WHERE
    X2.dat BETWEEN (
        SELECT MIN(dat)
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit - 53) AND (
        SELECT MAX(dat)
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
    )
    AND X1.preisaktiviert_fg = 1
GROUP BY
    X1.mandant_id,
    X1.aktion_id,
    X1.dat_von,
    X1.dat_bis;


DELETE FROM `_test_upd_kopf`
WHERE (
    aktion_id, mandant_id) IN (SELECT (aktion_id, mandant_id)
FROM `_bon_for_missing_aktion_id`) AND dat_bis >= (
    SELECT akt_dat_von
    FROM `_akt_dat_von_dat_bis`
);


INSERT INTO `_test_upd_kopf`
(
    SELECT
        CAST(A.mandant_id AS INTEGER) AS mandant_id,
        A.aktion_id,
        B.akt_dat_von,
        B.akt_dat_bis
    FROM `_bon_for_missing_aktion_id` AS A
    INNER JOIN `_akt_dat_von_dat_bis` AS B ON A.mandant_id = B.mandant_id AND A.bon_dat BETWEEN B.akt_dat_von AND B.akt_dat_bis

    WHERE (
        A.aktion_id, A.mandant_id) NOT IN (
        SELECT (aktion_id, mandant_id)
        FROM `_test_upd`
    )
    GROUP BY
        mandant_id,
        A.aktion_id,
        B.akt_dat_von,
        B.akt_dat_bis
);


CREATE OR REPLACE TEMPORARY TABLE _artbew_complete AS
SELECT
    mandant_id,
    dat,
    wup_id,
    art_id,
    aktion_id,
    umsatz_netto,
    menge,
    ek_mep
FROM dbp_data.artbew_2 AS M
WHERE
    mandant_id = 1
    AND dat BETWEEN (
        SELECT MIN(dat)
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit - 53) AND (
        SELECT MAX(dat)
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
    )
    AND (
        mandant_id, wup_id) IN (
        SELECT (mandant_id, wup_id)
        FROM dbp_etl_process.shopper_maerkte_2
        WHERE mandant_id = 1
    )
    AND art_id IN (
        SELECT art_id
        FROM `_mutter_art`
    )
    AND menge > 0;


--update only missing_aktion_id
/*
UPDATE DBP_DATA._artbew_complete FROM (SELECT *
                              FROM DBP_DATA._bon_for_missing_aktion_id) b

SET aktion_id = b.aktion_id

WHERE DBP_DATA._artbew_complete.dat = b.bon_dat AND
      DBP_DATA._artbew_complete.mandant_id = b.mandant_id AND
      floor(DBP_DATA._artbew_complete.art_id/100) = b.kl_art_id AND
      DBP_DATA._artbew_complete.wup_id = b.wup_id and
      TRIM(DBP_DATA._artbew_complete.aktion_id) = ''
*/


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
FROM (
    SELECT
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
    FROM dbp_spezial.v_ods_bon_verkauf_union_2 AS A
    WHERE
        mandant_id = 1
        AND bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 53) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
        )
) AS v
INNER JOIN (
    SELECT
        bon_id,
        bon_dat,
        kasse_nr,
        turnover_fg,
        wup_id,
        bon_nr,
        mandant_id
    FROM dbp_spezial.v_ods_bon_kopf_union_2
    WHERE
        mandant_id = 1
        AND bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 53) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
        )
) AS k ON v.mandant_id = k.mandant_id AND v.wup_id = k.wup_id AND v.bon_id = k.bon_id
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
    FROM dbp_process.bf_hit_the_actions_2
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
WHERE v.kl_art_id IN (
    SELECT kl_art_id
    FROM `_mutter_art`
)
AND v.wg_id <> 980
AND (
    k.bon_id, k.bon_dat) NOT IN (
    SELECT (bon_id, bon_dat)
    FROM dbp_spezial.v_ods_bon_storno_union_2
);


CREATE OR REPLACE TEMPORARY TABLE _bon_for_missing_aktion_id AS
SELECT
    A.bon_id,
    A.mandant_id,
    A.kl_art_id,
    MAX(B.aktion_id) AS aktion_id
FROM dbp_spezial.v_ods_promotion_union_2 AS A
INNER JOIN dbp_data.l_bonuskauf_2 AS B ON A.bonuskauf_id = B.bonuskauf_id AND A.mandant_id = B.mandant_id
GROUP BY
    A.bon_id,
    A.mandant_id,
    A.kl_art_id;


--update only missing_aktion_id


UPDATE `_bon_snapshot` SET
    aktion_id = b.aktion_id
FROM `_bon_for_missing_aktion_id` AS b
WHERE `_bon_snapshot`.bon_id = b.bon_id AND `_bon_snapshot`.mandant_id = b.mandant_id AND `_bon_snapshot`.kl_art_id = b.kl_art_id AND TRIM(`_bon_snapshot`.aktion_id) = '';


CREATE OR REPLACE TEMPORARY TABLE _bon_keys_talon1 AS
SELECT
    mandant_id,
    wup_id,
    bon_id,
    bon_nr,
    kasse_nr,
    talon_id,
    DATE(start_bon_zeile) AS talon_dat
FROM `_bon_snapshot`
WHERE talon_id <> 0
GROUP BY
    mandant_id,
    wup_id,
    bon_id,
    bon_nr,
    kasse_nr,
    talon_id,
    talon_dat;


CREATE OR REPLACE TEMPORARY TABLE _bon_snapshot_talon AS
SELECT
    k.mandant_id,
    k.talon_id,
    v.talon_pos_id,
    k.wup_id,
    X.bon_id,
    X.bon_nr,
    X.kasse_nr,
    k.talon_dat,
    v.kl_art_id,
    v.umsatz_brutto,
    COALESCE(v.menge / x0.mengen_faktor, v.menge) AS menge,
    v.mwst AS mwst_id,
    B.wg_id,
    v.aktion_id
FROM (
    SELECT *
    FROM dbp_spezial.v_ods_talon_det_union_2 AS A
    WHERE
        mandant_id = 1
        AND (
            mandant_id, wup_id, talon_id) IN (
            SELECT (mandant_id, wup_id, CAST(talon_id AS NUMERIC))
            FROM `_bon_keys_talon1`
        )
) AS v
INNER JOIN (
    SELECT *
    FROM dbp_spezial.v_ods_talon_union_2
    WHERE
        mandant_id = 1
        AND (
            mandant_id, wup_id, talon_id, talon_dat) IN (
            SELECT (mandant_id, wup_id, CAST(talon_id AS NUMERIC), talon_dat)
            FROM `_bon_keys_talon1`
        )
) AS k
    ON v.mandant_id = k.mandant_id AND v.wup_id = k.wup_id AND v.talon_id = k.talon_id
INNER JOIN `_bon_keys_talon1` AS X
    ON
        k.mandant_id = X.mandant_id AND k.talon_id = X.talon_id AND k.wup_id = X.wup_id
        AND k.talon_dat = X.talon_dat
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
    FROM dbp_process.bf_hit_the_actions_2
    WHERE (
        mandant_id, wup_id, kl_art_id) NOT IN (
        SELECT (mandant_id, wup_id, kl_art_id)
        FROM `_hit_the_actions`
    )
    GROUP BY
        mandant_id,
        wup_id,
        kl_art_id
) AS x0 ON v.mandant_id = x0.mandant_id AND v.kl_art_id = x0.kl_art_id AND v.wup_id = x0.wup_id;


--update only missing_aktion_id


UPDATE `_bon_snapshot_talon` SET
    aktion_id = b.aktion_id
FROM `_bon_for_missing_aktion_id` AS b
WHERE
    `_bon_snapshot_talon`.bon_id = b.bon_id AND `_bon_snapshot_talon`.mandant_id = b.mandant_id AND
    `_bon_snapshot_talon`.kl_art_id = b.kl_art_id AND TRIM(`_bon_snapshot_talon`.aktion_id) = '';


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
WHERE V.kl_art_id IN (
    SELECT kl_art_id
    FROM `_mutter_art`
)
AND V.aktion_id NOT IN ('', '0');


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


CREATE OR REPLACE TEMPORARY TABLE _aktionen_talon_snapshot AS
SELECT
    V.mandant_id,
    V.talon_id,
    V.talon_pos_id,
    V.wup_id,
    V.bon_id,
    V.bon_nr,
    V.kasse_nr,
    V.talon_dat,
    V.kl_art_id,
    V.umsatz_brutto,
    V.menge,
    V.mwst_id,
    V.wg_id,
    V.aktion_id
FROM `_bon_snapshot_talon` AS V
INNER JOIN `_test_upd_kopf` AS Y
    ON
        V.aktion_id = Y.aktion_id AND V.talon_dat BETWEEN Y.dat_von AND Y.dat_bis AND V.mandant_id
        = Y.mandant_id
WHERE V.kl_art_id IN (
    SELECT kl_art_id
    FROM `_mutter_art`
)
AND V.aktion_id NOT IN ('', '0');


CREATE OR REPLACE TEMPORARY TABLE _aktionen_talon AS
SELECT
    V.mandant_id,
    V.talon_id,
    V.talon_pos_id,
    V.wup_id,
    V.bon_id,
    V.bon_nr,
    V.kasse_nr,
    V.talon_dat,
    V.kl_art_id,
    V.umsatz_brutto,
    V.menge,
    V.mwst_id,
    V.wg_id,
    V.aktion_id
FROM `_aktionen_talon_snapshot` AS V
INNER JOIN `_test_upd` AS Z ON V.aktion_id = Z.aktion_id AND V.mandant_id = Z.mandant_id AND V.wup_id = Z.wup_id AND V.kl_art_id = Z.kl_art_id;


CREATE OR REPLACE TEMPORARY TABLE _bon_keys AS
SELECT bon_id
FROM `_bon_snapshot`
WHERE
    kl_art_id IN (
        SELECT kl_art_id
        FROM `_kl_art`
    )
GROUP BY bon_id;


CREATE OR REPLACE TEMPORARY TABLE _bon_snapshot2 AS
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
FROM (
    SELECT
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
    FROM dbp_spezial.v_ods_bon_verkauf_union_2
    WHERE
        mandant_id = 1
        AND bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 53) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
        )
) AS v
INNER JOIN (
    SELECT
        bon_id,
        bon_dat,
        kasse_nr,
        turnover_fg,
        wup_id,
        bon_nr,
        mandant_id
    FROM dbp_spezial.v_ods_bon_kopf_union_2
    WHERE
        mandant_id = 1
        AND bon_dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 53) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
        )
) AS k ON v.mandant_id = k.mandant_id AND v.wup_id = k.wup_id AND v.bon_id = k.bon_id
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
    FROM dbp_process.bf_hit_the_actions_2
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
WHERE k.bon_id IN (
    SELECT bon_id
    FROM `_bon_keys`
)
AND v.bon_id IN (
    SELECT bon_id
    FROM `_bon_keys`
)
AND v.wg_id <> 980
AND (
    k.bon_id, k.bon_dat) NOT IN (
    SELECT (bon_id, bon_dat)
    FROM dbp_spezial.v_ods_bon_storno_union_2
);


UPDATE `_bon_snapshot2` SET
    aktion_id = b.aktion_id
FROM `_bon_for_missing_aktion_id` AS b
WHERE
    `_bon_snapshot2`.bon_id = b.bon_id AND `_bon_snapshot2`.mandant_id = b.mandant_id AND `_bon_snapshot2`.kl_art_id =
    b.kl_art_id AND TRIM(`_bon_snapshot2`.aktion_id) = '';


CREATE OR REPLACE TEMPORARY TABLE _bon_keys_talon2 AS
SELECT
    mandant_id,
    wup_id,
    bon_id,
    bon_nr,
    kasse_nr,
    talon_id,
    DATE(start_bon_zeile) AS talon_dat
FROM `_bon_snapshot2`
WHERE talon_id <> 0
GROUP BY
    mandant_id,
    wup_id,
    bon_id,
    bon_nr,
    kasse_nr,
    talon_id,
    talon_dat;


CREATE OR REPLACE TEMPORARY TABLE _bon_snapshot2_talon AS
SELECT
    k.mandant_id,
    k.talon_id,
    v.talon_pos_id,
    k.wup_id,
    X.bon_id,
    X.bon_nr,
    X.kasse_nr,
    k.talon_dat,
    v.kl_art_id,
    v.umsatz_brutto,
    COALESCE(v.menge / x0.mengen_faktor, v.menge) AS menge,
    v.mwst AS mwst_id,
    B.wg_id,
    v.aktion_id,
    v.turnover_fg
FROM (
    SELECT *
    FROM dbp_spezial.v_ods_talon_det_union_2 AS A
    WHERE
        mandant_id = 1
        AND (
            mandant_id, wup_id, talon_id) IN (
            SELECT (mandant_id, wup_id, CAST(talon_id AS NUMERIC))
            FROM `_bon_keys_talon2`
        )
) AS v
INNER JOIN (
    SELECT *
    FROM dbp_spezial.v_ods_talon_union_2
    WHERE
        mandant_id = 1
        AND (
            mandant_id, wup_id, talon_id, talon_dat) IN (
            SELECT (mandant_id, wup_id, CAST(talon_id AS NUMERIC), talon_dat)
            FROM `_bon_keys_talon2`
        )
) AS k
    ON v.mandant_id = k.mandant_id AND v.wup_id = k.wup_id AND v.talon_id = k.talon_id
INNER JOIN `_bon_keys_talon2` AS X
    ON
        k.mandant_id = X.mandant_id AND k.talon_id = X.talon_id AND k.wup_id = X.wup_id
        AND k.talon_dat = X.talon_dat
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
    FROM dbp_process.bf_hit_the_actions_2
    WHERE (
        mandant_id, wup_id, kl_art_id) NOT IN (
        SELECT (mandant_id, wup_id, kl_art_id)
        FROM `_hit_the_actions`
    )
    GROUP BY
        mandant_id,
        wup_id,
        kl_art_id
) AS x0 ON v.mandant_id = x0.mandant_id AND v.kl_art_id = x0.kl_art_id AND v.wup_id = x0.wup_id;


UPDATE `_bon_snapshot2_talon` SET
    aktion_id = b.aktion_id
FROM `_bon_for_missing_aktion_id` AS b
WHERE
    `_bon_snapshot2_talon`.bon_id = b.bon_id AND `_bon_snapshot2_talon`.mandant_id = b.mandant_id AND
    `_bon_snapshot2_talon`.kl_art_id = b.kl_art_id AND TRIM(`_bon_snapshot2_talon`.aktion_id) = '';


-- 27.10.2016, -dbay-
--
-- Wichtige Ergaenzung auf Marktebene! Damit uns bei gesplitteten Artikelwerbewochen
-- mit verschiedenen Maerkten (!) selbige nicht mit Aktionsabsatz in die Shoppersuppe
-- spucken, muessen wir fuer die Kalkulation der aktionsrelevanten Zahlen aus dem 
-- Marktpool nur diese der jeweiligen Shopperwoche (Hit The Actions) ziehen, die tat-
-- saechlich eine_2 Aktionsreferenz haben! Sonst darf NUR AF bewertet werden!!!


CREATE OR REPLACE TEMPORARY TABLE _markets_hta AS
SELECT
    wup_id,
    kl_art_id
FROM `_hit_the_actions`
GROUP BY
    wup_id,
    kl_art_id;

CREATE OR REPLACE TABLE dbp_etl.bf_bons_kpicp_akt_tmp_2 AS
SELECT *
FROM dbp_etl.bf_bons_kpicp_akt;


INSERT INTO dbp_etl.bf_bons_kpicp_akt_tmp_2
(
    SELECT
        (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        ) AS shopperwoche,
        CAST(v.mandant_id AS INTEGER) AS mandant_id,
        CAST(v.wup_id AS INTEGER) AS wup_id,
        v.bon_dat AS dat,
        CAST(v.kasse_nr AS INTEGER) AS kasse_nr,
        CAST(v.bon_nr AS INTEGER) AS bon_nr,
        v.bon_id,
        CAST(CAST(FLOOR(X.mutter_wb_id / 100) AS INTEGER) AS INTEGER) AS kl_mutter_id_wb,
        X.mutter_wb_id AS mutter_id_wb,
        0 AS ges_umsatz_af,
        0 AS ges_umsatz_sa,
        0 AS ges_umsatz_akt,
        0 AS ges_absatz_af,
        0 AS ges_absatz_sa,
        0 AS ges_absatz_akt,
        CAST(SUM(CASE
            WHEN v.aktion_id IN ('', '0')
                THEN v.umsatz_brutto
            ELSE 0
        END) AS NUMERIC) AS a_umsatz_af,
        CAST(SUM(CASE
            WHEN v.aktion_id NOT IN ('', '0')
                THEN v.umsatz_brutto
            ELSE 0
        END) AS NUMERIC) AS a_umsatz_sa,
        0 AS a_umsatz_akt,
        SUM(CASE
            WHEN v.aktion_id IN ('', '0')
                THEN v.menge
            ELSE 0
        END) AS a_absatz_af,
        SUM(CASE
            WHEN v.aktion_id NOT IN ('', '0')
                THEN v.menge
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
    FROM (
        SELECT
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
        WHERE talon_id = 0
        GROUP BY
            bon_id,
            kl_art_id,
            aktion_id,
            mandant_id,
            wup_id,
            bon_nr,
            bon_dat,
            kasse_nr
        HAVING umsatz_brutto > 0
        UNION ALL
        SELECT
            bon_id,
            mandant_id,
            wup_id,
            talon_dat AS bon_dat,
            kasse_nr,
            bon_nr,
            kl_art_id,
            aktion_id,
            SUM(menge) AS menge,
            SUM(umsatz_brutto) AS umsatz_brutto
        FROM `_bon_snapshot_talon`
        GROUP BY
            bon_id,
            mandant_id,
            wup_id,
            bon_dat,
            kasse_nr,
            bon_nr,
            kl_art_id,
            aktion_id
        HAVING umsatz_brutto > 0) AS x
        GROUP BY
            bon_id,
            mandant_id,
            wup_id,
            bon_dat,
            kasse_nr,
            bon_nr,
            kl_art_id,
            aktion_id
    ) AS v
    INNER JOIN `_mutter_art` AS X ON v.kl_art_id = X.kl_art_id
    INNER JOIN dbp_data.art_wg_zu_per_2 AS Y
        ON
            Y.mandant_id = 1 AND Y.arthiertyp_id = 2 AND Y.dat_bis =
            DATE '9999-12-31' AND X.mutter_wb_id = Y.art_id
    GROUP BY
        shopperwoche,
        v.mandant_id,
        v.wup_id,
        dat,
        v.kasse_nr,
        v.bon_nr,
        v.bon_id,
        kl_mutter_id_wb,
        mutter_id_wb,
        Y.wg_id
);


-- 1. Update


UPDATE dbp_etl.bf_bons_kpicp_akt_tmp_2 SET
    a_umsatz_akt = ods.`_a_umsatz_akt`,
    a_absatz_akt = ods.`_a_absatz_akt` FROM (
    SELECT
        `_mandant_id`,
        `_wup_id`,
        `_dat`,
        `_kasse_nr`,
        `_bon_nr`,
        `_bon_id`,
        `_kl_mutter_id_wb`,
        `_mutter_id_wb`,
        SUM(`_a_umsatz_akt`) AS `_a_umsatz_akt`,
        SUM(`_a_absatz_akt`) AS `_a_absatz_akt`
    FROM (
        SELECT
            V.mandant_id AS `_mandant_id`,
            V.wup_id AS `_wup_id`,
            V.bon_dat AS `_dat`,
            V.kasse_nr AS `_kasse_nr`,
            V.bon_nr AS `_bon_nr`,
            V.bon_id AS `_bon_id`,
            CAST(FLOOR(X.mutter_wb_id / 100) AS INTEGER) AS `_kl_mutter_id_wb`,
            X.mutter_wb_id AS `_mutter_id_wb`,
            SUM(V.umsatz_brutto) AS `_a_umsatz_akt`,
            SUM(V.menge) AS `_a_absatz_akt`
        FROM `_aktionen` AS V
        INNER JOIN `_mutter_art` AS X ON V.kl_art_id = X.kl_art_id
        WHERE
            V.talon_id = 0
            AND (
                V.wup_id, V.kl_art_id) IN (
                SELECT (wup_id, kl_art_id)
                FROM `_markets_hta`
            )
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kasse_nr`,
            `_bon_nr`,
            `_bon_id`,
            `_kl_mutter_id_wb`,
            `_mutter_id_wb`
        UNION ALL
        SELECT
            V.mandant_id AS `_mandant_id`,
            V.wup_id AS `_wup_id`,
            V.talon_dat AS `_dat`,
            V.kasse_nr AS `_kasse_nr`,
            V.bon_nr AS `_bon_nr`,
            V.bon_id AS `_bon_id`,
            CAST(FLOOR(X.mutter_wb_id / 100) AS INTEGER) AS `_kl_mutter_id_wb`,
            X.mutter_wb_id AS `_mutter_id_wb`,
            SUM(V.umsatz_brutto) AS `_a_umsatz_akt`,
            SUM(V.menge) AS `_a_absatz_akt`
        FROM `_aktionen_talon` AS V
        INNER JOIN `_mutter_art` AS X ON V.kl_art_id = X.kl_art_id
        WHERE (
            V.wup_id, V.kl_art_id) IN (
            SELECT (wup_id, kl_art_id)
            FROM `_markets_hta`
        )
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kasse_nr`,
            `_bon_nr`,
            `_bon_id`,
            `_kl_mutter_id_wb`,
            `_mutter_id_wb`
    ) AS x
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
    bf_bons_kpicp_akt_tmp.mandant_id = ods.`_mandant_id` AND bf_bons_kpicp_akt_tmp.wup_id = ods.`_wup_id` AND
    bf_bons_kpicp_akt_tmp.dat = ods.`_dat` AND bf_bons_kpicp_akt_tmp.kasse_nr = ods.`_kasse_nr` AND
    bf_bons_kpicp_akt_tmp.bon_nr = ods.`_bon_nr` AND bf_bons_kpicp_akt_tmp.bon_id = ods.`_bon_id` AND
    bf_bons_kpicp_akt_tmp.mutter_id_wb = ods.`_mutter_id_wb` AND bf_bons_kpicp_akt_tmp.shopperwoche IN (
        SELECT kjwo
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
        GROUP BY kjwo
    );


-- 2. Update


UPDATE dbp_etl.bf_bons_kpicp_akt_tmp_2 SET
    ges_umsatz_akt = ods.`_ges_umsatz_akt`,
    ges_absatz_akt = ods.`_ges_absatz_akt`,
    w_umsatz_akt = CAST(ods.`_w_umsatz_akt` AS NUMERIC),
    w_absatz_akt = ods.`_w_absatz_akt` FROM (
    SELECT
        `_mandant_id`,
        `_wup_id`,
        `_dat`,
        `_kasse_nr`,
        `_bon_nr`,
        `_bon_id`,
        `_mutter_id_wb`,
        SUM(`_ges_umsatz_akt`) AS `_ges_umsatz_akt`,
        SUM(`_ges_absatz_akt`) AS `_ges_absatz_akt`,
        SUM(`_w_umsatz_akt`) AS `_w_umsatz_akt`,
        SUM(`_w_absatz_akt`) AS `_w_absatz_akt`
    FROM (
        SELECT
            t3.mandant_id AS `_mandant_id`,
            t3.wup_id AS `_wup_id`,
            t3.bon_dat AS `_dat`,
            t3.kasse_nr AS `_kasse_nr`,
            t3.bon_nr AS `_bon_nr`,
            t3.bon_id AS `_bon_id`,
            t3.mutter_id_wb AS `_mutter_id_wb`,
            SUM(t3.umsatz_brutto) AS `_ges_umsatz_akt`,
            SUM(t3.menge) AS `_ges_absatz_akt`,
            SUM(CASE
                WHEN t3.wg_id = t3.wg_id0
                    THEN t3.umsatz_brutto
                ELSE 0
            END) AS `_w_umsatz_akt`,
            SUM(CASE
                WHEN t3.wg_id = t3.wg_id0
                    THEN t3.menge
                ELSE 0
            END) AS `_w_absatz_akt`
        FROM (
            SELECT
                v.mandant_id,
                v.wup_id,
                v.bon_dat,
                v.kasse_nr,
                v.bon_nr,
                v.bon_id,
                t2.mutter_id_wb,
                v.umsatz_brutto,
                v.menge,
                v.wg_id,
                t2.wg_id as wg_id0,
                v.turnover_fg,
                v.aktion_id,
                v.kl_art_id,
                t2.kl_mutter_id_wb,
                v.talon_id

            FROM `_bon_snapshot2` AS V
            INNER JOIN (
                SELECT *
                FROM dbp_etl.bf_bons_kpicp_akt_tmp_2 AS BF
                WHERE shopperwoche IN (
                    SELECT kjwo
                    FROM dbp_process.tag_shopper_2
                    WHERE akt_wo = shopperzeit
                    GROUP BY kjwo
                )
            ) AS t2
                ON TRUE
            WHERE
                V.mandant_id = t2.mandant_id
                AND V.bon_dat = t2.dat
                AND V.wup_id = t2.wup_id
                AND V.kasse_nr = t2.kasse_nr
                AND V.bon_nr = t2.bon_nr
                AND V.turnover_fg = 1
        ) AS t3
        INNER JOIN `_test_upd` AS X
            ON
                t3.aktion_id = X.aktion_id AND t3.mandant_id = X.mandant_id AND t3.bon_dat BETWEEN
                X.dat_von AND X.dat_bis AND t3.wup_id = X.wup_id AND t3.kl_art_id = X.kl_art_id
        WHERE
            t3.kl_mutter_id_wb IN (
                SELECT CAST(FLOOR(mutter_wb_id / 100) AS INTEGER) AS a1219484358
                FROM `_mutter_art`
            )
            AND (
                t3.wup_id, t3.kl_art_id) IN (
                SELECT (wup_id, kl_art_id)
                FROM `_markets_hta`
            )
            AND (t3.talon_id = 0 OR t3.talon_id <> 0 AND (
                CAST(t3.talon_id AS NUMERIC), t3.wup_id) NOT IN (
                SELECT (talon_id, wup_id)
                FROM `_bon_snapshot2_talon`
            ))
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kasse_nr`,
            `_bon_nr`,
            `_bon_id`,
            `_mutter_id_wb`
        UNION ALL
        SELECT
            t14.mandant_id AS `_mandant_id`,
            t14.wup_id AS `_wup_id`,
            t14.talon_dat AS `_dat`,
            t14.kasse_nr AS `_kasse_nr`,
            t14.bon_nr AS `_bon_nr`,
            t14.bon_id AS `_bon_id`,
            t14.mutter_id_wb AS `_mutter_id_wb`,
            SUM(t14.umsatz_brutto) AS `_ges_umsatz_akt`,
            SUM(t14.menge) AS `_ges_absatz_akt`,
            SUM(CASE
                WHEN t14.wg_id = t14.wg_id0
                    THEN t14.umsatz_brutto
                ELSE 0
            END) AS `_w_umsatz_akt`,
            SUM(CASE
                WHEN t14.wg_id = t14.wg_id0
                    THEN t14.menge
                ELSE 0
            END) AS `_w_absatz_akt`
        FROM (
            SELECT
                v.mandant_id,
                v.wup_id,
                v.talon_dat,
                v.kasse_nr,
                v.bon_nr,
                v.bon_id,
                t13.mutter_id_wb,
                v.umsatz_brutto,
                v.menge,
                v.wg_id,
                t13.wg_id as wg_id0,
                v.turnover_fg,
                v.aktion_id,
                v.kl_art_id,
                t13.kl_mutter_id_wb,
                v.talon_id
            FROM `_bon_snapshot2_talon` AS V
            INNER JOIN (
                SELECT *
                FROM dbp_etl.bf_bons_kpicp_akt_tmp_2 AS BF
                WHERE shopperwoche IN (
                    SELECT kjwo
                    FROM dbp_process.tag_shopper_2
                    WHERE akt_wo = shopperzeit
                    GROUP BY kjwo
                )
            ) AS t13
                ON TRUE
            WHERE
                V.mandant_id = t13.mandant_id
                AND V.talon_dat = t13.dat
                AND V.wup_id = t13.wup_id
                AND V.kasse_nr = t13.kasse_nr
                AND V.bon_nr = t13.bon_nr
                AND V.turnover_fg = 1
        ) AS t14
        INNER JOIN `_test_upd` AS X
            ON
                t14.aktion_id = X.aktion_id AND t14.mandant_id = X.mandant_id AND t14.talon_dat
                BETWEEN X.dat_von AND X.dat_bis AND t14.wup_id = X.wup_id AND t14.kl_art_id = X.kl_art_id
        WHERE
            t14.kl_mutter_id_wb IN (
                SELECT CAST(FLOOR(mutter_wb_id / 100) AS INTEGER) AS a1219484358
                FROM `_mutter_art`
            )
            AND (
                t14.wup_id, t14.kl_art_id) IN (
                SELECT (wup_id, kl_art_id)
                FROM `_markets_hta`
            )
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kasse_nr`,
            `_bon_nr`,
            `_bon_id`,
            `_mutter_id_wb`
    ) AS x
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
    bf_bons_kpicp_akt_tmp.mandant_id = ods.`_mandant_id` AND bf_bons_kpicp_akt_tmp.wup_id = ods.`_wup_id` AND
    bf_bons_kpicp_akt_tmp.kasse_nr = ods.`_kasse_nr` AND bf_bons_kpicp_akt_tmp.bon_nr = ods.`_bon_nr` AND
    bf_bons_kpicp_akt_tmp.bon_id = ods.`_bon_id` AND bf_bons_kpicp_akt_tmp.mutter_id_wb = ods.`_mutter_id_wb` AND
    bf_bons_kpicp_akt_tmp.shopperwoche IN (
        SELECT kjwo
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
        GROUP BY kjwo
    );


-- 3. Update


UPDATE dbp_etl.bf_bons_kpicp_akt_tmp_2 SET
    ges_umsatz_af = CAST(ods.`_ges_umsatz_af` AS NUMERIC),
    ges_umsatz_sa = CAST(ods.`_ges_umsatz_sa` AS NUMERIC),
    ges_absatz_af = ods.`_ges_absatz_af`,
    ges_absatz_sa = ods.`_ges_absatz_sa`,
    w_umsatz_af = CAST(ods.`_w_umsatz_af` AS NUMERIC),
    w_umsatz_sa = CAST(ods.`_w_umsatz_sa` AS NUMERIC),
    w_absatz_af = ods.`_w_absatz_af`,
    w_absatz_sa = ods.`_w_absatz_sa` FROM (
    SELECT
        `_mandant_id`,
        `_wup_id`,
        `_dat`,
        `_kasse_nr`,
        `_bon_nr`,
        `_bon_id`,
        `_mutter_id_wb`,
        SUM(`_ges_umsatz_af`) AS `_ges_umsatz_af`,
        SUM(`_ges_umsatz_sa`) AS `_ges_umsatz_sa`,
        SUM(`_ges_absatz_af`) AS `_ges_absatz_af`,
        SUM(`_ges_absatz_sa`) AS `_ges_absatz_sa`,
        SUM(`_w_umsatz_af`) AS `_w_umsatz_af`,
        SUM(`_w_umsatz_sa`) AS `_w_umsatz_sa`,
        SUM(`_w_absatz_af`) AS `_w_absatz_af`,
        SUM(`_w_absatz_sa`) AS `_w_absatz_sa`
    FROM (
        SELECT
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kasse_nr`,
            `_bon_nr`,
            `_bon_id`,
            `_mutter_id_wb`,
            SUM(`A118612`) AS `_ges_umsatz_af`,
            SUM(`A118613`) AS `_ges_umsatz_sa`,
            SUM(`A118614`) AS `_ges_absatz_af`,
            SUM(`A118615`) AS `_ges_absatz_sa`,
            SUM(`A118616`) AS `_w_umsatz_af`,
            SUM(`A118617`) AS `_w_umsatz_sa`,
            SUM(`A118618`) AS `_w_absatz_af`,
            SUM(`A118619`) AS `_w_absatz_sa`
        FROM (SELECT
            mandant_id AS `_mandant_id`,
            wup_id AS `_wup_id`,
            bon_dat AS `_dat`,
            kasse_nr AS `_kasse_nr`,
            bon_nr AS `_bon_nr`,
            bon_id AS `_bon_id`,
            mutter_id_wb AS `_mutter_id_wb`,
            CASE
                WHEN aktion_id IN ('', '0')
                    THEN umsatz_brutto
                ELSE 0
            END AS `A118612`,
            CASE
                WHEN aktion_id NOT IN ('', '0')
                    THEN umsatz_brutto
                ELSE 0
            END AS `A118613`,
            CASE
                WHEN aktion_id IN ('', '0')
                    THEN menge
                ELSE 0
            END AS `A118614`,
            CASE
                WHEN aktion_id NOT IN ('', '0')
                    THEN menge
                ELSE 0
            END AS `A118615`,
            CASE
                WHEN wg_id = wg_id0 AND aktion_id IN ('', '0')
                    THEN umsatz_brutto
                ELSE 0
            END AS `A118616`,
            CASE
                WHEN wg_id = wg_id0 AND aktion_id NOT IN ('', '0')
                    THEN umsatz_brutto
                ELSE 0
            END AS `A118617`,
            CASE
                WHEN wg_id = wg_id0 AND aktion_id IN ('', '0')
                    THEN menge
                ELSE 0
            END AS `A118618`,
            CASE
                WHEN wg_id = wg_id0 AND aktion_id NOT IN ('', '0')
                    THEN menge
                ELSE 0
            END AS `A118619`
        FROM (
            SELECT
                v.mandant_id,
                v.wup_id,
                v.bon_dat,
                v.kasse_nr,
                v.bon_nr,
                v.bon_id,
                t2.mutter_id_wb,
                v.umsatz_brutto,
                v.menge,
                v.wg_id,
                t2.wg_id as wg_id0,
                v.turnover_fg,
                v.aktion_id,
                v.kl_art_id,
                t2.kl_mutter_id_wb,
                v.talon_id
            FROM `_bon_snapshot2` AS V
            INNER JOIN (
                SELECT *
                FROM dbp_etl.bf_bons_kpicp_akt_tmp_2 AS BF
                WHERE shopperwoche IN (
                    SELECT kjwo
                    FROM dbp_process.tag_shopper_2
                    WHERE akt_wo = shopperzeit
                    GROUP BY kjwo
                )
            ) AS t2
                ON TRUE
            WHERE
                V.mandant_id = t2.mandant_id
                AND V.bon_dat = t2.dat
                AND V.wup_id = t2.wup_id
                AND V.kasse_nr = t2.kasse_nr
                AND V.bon_nr = t2.bon_nr
                AND V.turnover_fg = 1
        ) AS t3
        WHERE t3.kl_mutter_id_wb IN (
            SELECT CAST(FLOOR(mutter_wb_id / 100) AS INTEGER) AS a1219484358
            FROM `_mutter_art`
        )
        AND (t3.talon_id = 0 OR t3.talon_id <> 0 AND (
            CAST(t3.talon_id AS NUMERIC), t3.wup_id) NOT IN (
            SELECT (talon_id, wup_id)
            FROM `_bon_snapshot2_talon`
        ))) AS t7
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kasse_nr`,
            `_bon_nr`,
            `_bon_id`,
            `_mutter_id_wb`
        UNION ALL
        SELECT
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kasse_nr`,
            `_bon_nr`,
            `_bon_id`,
            `_mutter_id_wb`,
            SUM(`A118612`) AS `_ges_umsatz_af`,
            SUM(`A118613`) AS `_ges_umsatz_sa`,
            SUM(`A118614`) AS `_ges_absatz_af`,
            SUM(`A118615`) AS `_ges_absatz_sa`,
            SUM(`A118616`) AS `_w_umsatz_af`,
            SUM(`A118617`) AS `_w_umsatz_sa`,
            SUM(`A118618`) AS `_w_absatz_af`,
            SUM(`A118619`) AS `_w_absatz_sa`
        FROM (SELECT
            mandant_id AS `_mandant_id`,
            wup_id AS `_wup_id`,
            talon_dat AS `_dat`,
            kasse_nr AS `_kasse_nr`,
            bon_nr AS `_bon_nr`,
            bon_id AS `_bon_id`,
            mutter_id_wb AS `_mutter_id_wb`,
            CASE
                WHEN aktion_id IN ('', '0')
                    THEN umsatz_brutto
                ELSE 0
            END AS `A118612`,
            CASE
                WHEN aktion_id NOT IN ('', '0')
                    THEN umsatz_brutto
                ELSE 0
            END AS `A118613`,
            CASE
                WHEN aktion_id IN ('', '0')
                    THEN menge
                ELSE 0
            END AS `A118614`,
            CASE
                WHEN aktion_id NOT IN ('', '0')
                    THEN menge
                ELSE 0
            END AS `A118615`,
            CASE
                WHEN wg_id = wg_id0 AND aktion_id IN ('', '0')
                    THEN umsatz_brutto
                ELSE 0
            END AS `A118616`,
            CASE
                WHEN wg_id = wg_id0 AND aktion_id NOT IN ('', '0')
                    THEN umsatz_brutto
                ELSE 0
            END AS `A118617`,
            CASE
                WHEN wg_id = wg_id0 AND aktion_id IN ('', '0')
                    THEN menge
                ELSE 0
            END AS `A118618`,
            CASE
                WHEN wg_id = wg_id0 AND aktion_id NOT IN ('', '0')
                    THEN menge
                ELSE 0
            END AS `A118619`
        FROM (
            SELECT
                v.mandant_id,
                v.wup_id,
                v.talon_dat,
                v.kasse_nr,
                v.bon_nr,
                v.bon_id,
                t12.mutter_id_wb,
                v.umsatz_brutto,
                v.menge,
                v.wg_id,
                t12.wg_id as wg_id0,
                v.turnover_fg,
                v.aktion_id,
                v.kl_art_id,
                t12.kl_mutter_id_wb,
                v.talon_id
            FROM `_bon_snapshot2_talon` AS V
            INNER JOIN (
                SELECT *
                FROM dbp_etl.bf_bons_kpicp_akt_tmp_2 AS BF
                WHERE shopperwoche IN (
                    SELECT kjwo
                    FROM dbp_process.tag_shopper_2
                    WHERE akt_wo = shopperzeit
                    GROUP BY kjwo
                )
            ) AS t12
                ON TRUE
            WHERE
                V.mandant_id = t12.mandant_id
                AND V.talon_dat = t12.dat
                AND V.wup_id = t12.wup_id
                AND V.kasse_nr = t12.kasse_nr
                AND V.bon_nr = t12.bon_nr
                AND V.turnover_fg = 1
        ) AS t13
        WHERE t13.kl_mutter_id_wb IN (
            SELECT CAST(FLOOR(mutter_wb_id / 100) AS INTEGER) AS a1219484358
            FROM `_mutter_art`
        )) AS t16
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kasse_nr`,
            `_bon_nr`,
            `_bon_id`,
            `_mutter_id_wb`
    ) AS x
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
    bf_bons_kpicp_akt_tmp.mandant_id = ods.`_mandant_id` AND bf_bons_kpicp_akt_tmp.wup_id = ods.`_wup_id` AND
    bf_bons_kpicp_akt_tmp.kasse_nr = ods.`_kasse_nr` AND bf_bons_kpicp_akt_tmp.bon_nr = ods.`_bon_nr` AND
    bf_bons_kpicp_akt_tmp.bon_id = ods.`_bon_id` AND bf_bons_kpicp_akt_tmp.mutter_id_wb = ods.`_mutter_id_wb` AND
    bf_bons_kpicp_akt_tmp.shopperwoche IN (
        SELECT kjwo
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
        GROUP BY kjwo
    );

DELETE FROM dbp_etl.bf_bons_kpicp_akt
WHERE shopperwoche IN (
    SELECT kjwo
    FROM dbp_process.tag_shopper_2
    WHERE akt_wo = shopperzeit
    GROUP BY kjwo
);


INSERT INTO dbp_etl.bf_bons_kpicp_akt
(
    SELECT *
    FROM dbp_etl.bf_bons_kpicp_akt_tmp_2
);


/*
+-------------------------------------------------------------
+ 5. FALL 2 - Verarbeitung
+-------------------------------------------------------------
*/


CREATE OR REPLACE TABLE dbp_etl.bf_bons_kpia_akt_tmp_2 LIKE dbp_etl.bf_bons_kpia_akt;


INSERT INTO dbp_etl.bf_bons_kpia_akt_tmp_2
(
    SELECT
        (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        ) AS shopperwoche,
        CAST(x.`_mandant_id` AS INTEGER) AS `_mandant_id`,
        CAST(x.`_wup_id` AS INTEGER) AS `_wup_id`,
        x.`_dat`,
        CAST(CAST(FLOOR(Y.mutter_wb_id / 100) AS INTEGER) AS INTEGER) AS `_kl_mutter_id_wb`,
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
            V.kl_art_id,
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
            SELECT wg_id
            FROM `_mutter_wg`
            GROUP BY wg_id
        ) AS x
            ON V.wg_id = x.wg_id
        WHERE V.talon_id = 0
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            V.kl_art_id,
            `_wg_id`
        UNION ALL
        SELECT
            V.mandant_id AS `_mandant_id`,
            V.wup_id AS `_wup_id`,
            V.talon_dat AS `_dat`,
            V.kl_art_id,
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
        FROM `_bon_snapshot_talon` AS V
        INNER JOIN (
            SELECT wg_id
            FROM `_mutter_wg`
            GROUP BY wg_id
        ) AS x
            ON V.wg_id = x.wg_id
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            V.kl_art_id,
            `_wg_id`
    ) AS x
    INNER JOIN `_mutter_art` AS Y ON x.kl_art_id = Y.kl_art_id
    GROUP BY
        shopperwoche,
        x.`_mandant_id`,
        x.`_wup_id`,
        x.`_dat`,
        `_kl_mutter_id_wb`,
        `_mutter_wb_id`,
        `_w_bons`
);


UPDATE dbp_etl.bf_bons_kpia_akt_tmp_2 SET
    a_bons = ods.`_a_bons`,
    a_umsatz_af = CAST(ods.`_a_umsatz_af` AS NUMERIC),
    a_umsatz_sa = CAST(ods.`_a_umsatz_sa` AS NUMERIC),
    a_absatz_af = ods.`_a_absatz_af`,
    a_absatz_sa = ods.`_a_absatz_sa` FROM (
    SELECT
        `_mandant_id`,
        `_wup_id`,
        `_dat`,
        `_kl_mutter_id_wb`,
        `_mutter_id_wb`,
        MAX(`_a_bons`) AS `_a_bons`,
        SUM(`_a_absatz_af`) AS `_a_absatz_af`,
        SUM(`_a_absatz_sa`) AS `_a_absatz_sa`,
        SUM(`_a_umsatz_af`) AS `_a_umsatz_af`,
        SUM(`_a_umsatz_sa`) AS `_a_umsatz_sa`
    FROM (
        SELECT
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kl_mutter_id_wb`,
            `_mutter_id_wb`,
            COUNT(DISTINCT bon_id) AS `_a_bons`,
            SUM(`A11869`) AS `_a_absatz_af`,
            SUM(`A118610`) AS `_a_absatz_sa`,
            SUM(`A118611`) AS `_a_umsatz_af`,
            SUM(`A118612`) AS `_a_umsatz_sa`
        FROM (SELECT
            mandant_id AS `_mandant_id`,
            wup_id AS `_wup_id`,
            bon_dat AS `_dat`,
            CAST(FLOOR(mutter_wb_id / 100) AS INTEGER) AS `_kl_mutter_id_wb`,
            mutter_wb_id AS `_mutter_id_wb`,
            bon_id,
            CASE
                WHEN aktion_id IN ('', '0')
                    THEN menge
                ELSE 0
            END AS `A11869`,
            CASE
                WHEN aktion_id NOT IN ('', '0')
                    THEN menge
                ELSE 0
            END AS `A118610`,
            CASE
                WHEN aktion_id IN ('', '0')
                    THEN umsatz_brutto
                ELSE 0
            END AS `A118611`,
            CASE
                WHEN aktion_id NOT IN ('', '0')
                    THEN umsatz_brutto
                ELSE 0
            END AS `A118612`
        FROM (
            SELECT
                v.mandant_id,
                v.wup_id,
                v.bon_dat,
                v.kasse_nr,
                v.bon_nr,
                v.bon_id,
                x.mutter_wb_id,
                v.umsatz_brutto,
                v.menge,
                v.wg_id,
                t2.wg_id as wg_id0,
                v.turnover_fg,
                v.aktion_id,
                v.kl_art_id,
                t2.kl_mutter_id_wb,
                v.talon_id
            FROM `_bon_snapshot` AS V
            INNER JOIN `_mutter_art` AS X ON V.kl_art_id = X.kl_art_id
            INNER JOIN (
                SELECT *
                FROM dbp_etl.bf_bons_kpia_akt_tmp_2 AS BF
                WHERE shopperwoche IN (
                    SELECT kjwo
                    FROM dbp_process.tag_shopper_2
                    WHERE akt_wo = shopperzeit
                    GROUP BY kjwo
                )
            ) AS t2
                ON TRUE
            WHERE
                V.mandant_id = t2.mandant_id
                AND V.bon_dat = t2.dat
                AND V.wup_id = t2.wup_id
                AND X.mutter_wb_id = t2.mutter_id_wb
        ) AS t3
        WHERE t3.talon_id = 0) AS t5
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kl_mutter_id_wb`,
            `_mutter_id_wb`
        UNION ALL
        SELECT
            V.mandant_id AS `_mandant_id`,
            V.wup_id AS `_wup_id`,
            V.talon_dat AS `_dat`,
            CAST(FLOOR(X.mutter_wb_id / 100) AS INTEGER) AS `_kl_mutter_id_wb`,
            X.mutter_wb_id AS `_mutter_id_wb`,
            COUNT(DISTINCT V.bon_id) AS `_a_bons`,
            SUM(CASE
                WHEN V.aktion_id IN ('', '0')
                    THEN V.menge
                ELSE 0
            END) AS `_a_absatz_af`,
            SUM(CASE
                WHEN V.aktion_id NOT IN ('', '0')
                    THEN V.menge
                ELSE 0
            END) AS `_a_absatz_sa`,
            SUM(CASE
                WHEN V.aktion_id IN ('', '0')
                    THEN V.umsatz_brutto
                ELSE 0
            END) AS `_a_umsatz_af`,
            SUM(CASE
                WHEN V.aktion_id NOT IN ('', '0')
                    THEN V.umsatz_brutto
                ELSE 0
            END) AS `_a_umsatz_sa`
        FROM `_bon_snapshot_talon` AS V
        INNER JOIN `_mutter_art` AS X ON V.kl_art_id = X.kl_art_id
        INNER JOIN (
            SELECT *
            FROM dbp_etl.bf_bons_kpia_akt_tmp_2 AS BF
            WHERE shopperwoche IN (
                SELECT kjwo
                FROM dbp_process.tag_shopper_2
                WHERE akt_wo = shopperzeit
                GROUP BY kjwo
            )
        ) AS t10
            ON TRUE
        WHERE
            V.mandant_id = t10.mandant_id
            AND V.talon_dat = t10.dat
            AND V.wup_id = t10.wup_id
            AND X.mutter_wb_id = t10.mutter_id_wb
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kl_mutter_id_wb`,
            `_mutter_id_wb`
    ) AS x
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_dat`,
        `_kl_mutter_id_wb`,
        `_mutter_id_wb`
) AS ods
WHERE
    bf_bons_kpia_akt_tmp.mandant_id = ods.`_mandant_id` AND bf_bons_kpia_akt_tmp.wup_id = ods.`_wup_id` AND
    bf_bons_kpia_akt_tmp.dat = ods.`_dat` AND bf_bons_kpia_akt_tmp.mutter_id_wb = ods.`_mutter_id_wb` AND
    bf_bons_kpia_akt_tmp.shopperwoche IN (
        SELECT kjwo
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
        GROUP BY kjwo
    );


UPDATE dbp_etl.bf_bons_kpia_akt_tmp_2 SET
    a_umsatz_akt = ods.`_a_umsatz_akt`,
    a_absatz_akt = ods.`_a_absatz_akt` FROM (
    SELECT
        `_mandant_id`,
        `_wup_id`,
        `_dat`,
        `_kl_mutter_id_wb`,
        `_mutter_id_wb`,
        SUM(`_a_absatz_akt`) AS `_a_absatz_akt`,
        SUM(`_a_umsatz_akt`) AS `_a_umsatz_akt`
    FROM (
        SELECT
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kl_mutter_id_wb`,
            `_mutter_id_wb`,
            SUM(menge) AS `_a_absatz_akt`,
            SUM(umsatz_brutto) AS `_a_umsatz_akt`
        FROM (
            SELECT
                mandant_id AS `_mandant_id`,
                wup_id AS `_wup_id`,
                bon_dat AS `_dat`,
                CAST(FLOOR(mutter_wb_id / 100) AS INTEGER) AS `_kl_mutter_id_wb`,
                mutter_wb_id AS `_mutter_id_wb`,
                menge,
                umsatz_brutto
            FROM (
                SELECT
                    v.mandant_id,
                    v.wup_id,
                    v.bon_dat,
                    v.kasse_nr,
                    v.bon_nr,
                    v.bon_id,
                    x.mutter_wb_id,
                    v.umsatz_brutto,
                    v.menge,
                    v.wg_id,
                    t2.wg_id as wg_id0,
                    v.turnover_fg,
                    v.aktion_id,
                    v.kl_art_id,
                    t2.kl_mutter_id_wb,
                    v.talon_id
                FROM `_aktionen` AS V
                INNER JOIN `_mutter_art` AS X ON V.kl_art_id = X.kl_art_id
                INNER JOIN (
                    SELECT *
                    FROM dbp_etl.bf_bons_kpia_akt_tmp_2 AS BF
                    WHERE shopperwoche IN (
                        SELECT kjwo
                        FROM dbp_process.tag_shopper_2
                        WHERE akt_wo = shopperzeit
                        GROUP BY kjwo
                    )
                ) AS t2
                    ON TRUE
                WHERE
                    V.mandant_id = t2.mandant_id
                    AND V.bon_dat = t2.dat
                    AND V.wup_id = t2.wup_id
                    AND X.mutter_wb_id = t2.mutter_id_wb
            ) AS t3
            WHERE
                t3.talon_id = 0
                AND (
                    t3.wup_id, t3.kl_art_id) IN (
                    SELECT (wup_id, kl_art_id)
                    FROM `_markets_hta`
                )
        ) AS t6
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kl_mutter_id_wb`,
            `_mutter_id_wb`
        UNION ALL
        SELECT
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kl_mutter_id_wb`,
            `_mutter_id_wb`,
            SUM(menge) AS `_a_absatz_akt`,
            SUM(umsatz_brutto) AS `_a_umsatz_akt`
        FROM (SELECT
            mandant_id AS `_mandant_id`,
            wup_id AS `_wup_id`,
            talon_dat AS `_dat`,
            CAST(FLOOR(mutter_wb_id / 100) AS INTEGER) AS `_kl_mutter_id_wb`,
            mutter_wb_id AS `_mutter_id_wb`,
            menge,
            umsatz_brutto
        FROM (
            SELECT
                v.mandant_id,
                v.wup_id,
                v.talon_dat,
                v.kasse_nr,
                v.bon_nr,
                v.bon_id,
                x.mutter_wb_id,
                v.umsatz_brutto,
                v.menge,
                v.wg_id,
                t11.wg_id as wg_id0,
                v.aktion_id,
                v.kl_art_id,
                v.talon_id
            FROM `_aktionen_talon` AS V
            INNER JOIN `_mutter_art` AS X ON V.kl_art_id = X.kl_art_id
            INNER JOIN (
                SELECT *
                FROM dbp_etl.bf_bons_kpia_akt_tmp_2 AS BF
                WHERE shopperwoche IN (
                    SELECT kjwo
                    FROM dbp_process.tag_shopper_2
                    WHERE akt_wo = shopperzeit
                    GROUP BY kjwo
                )
            ) AS t11
                ON TRUE
            WHERE
                V.mandant_id = t11.mandant_id
                AND V.talon_dat = t11.dat
                AND V.wup_id = t11.wup_id
                AND X.mutter_wb_id = t11.mutter_id_wb
        ) AS t12
        WHERE (
            t12.wup_id, t12.kl_art_id) IN (
            SELECT (wup_id, kl_art_id)
            FROM `_markets_hta`
        )) AS t15
        GROUP BY
            `_mandant_id`,
            `_wup_id`,
            `_dat`,
            `_kl_mutter_id_wb`,
            `_mutter_id_wb`
    ) AS x
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_dat`,
        `_kl_mutter_id_wb`,
        `_mutter_id_wb`
) AS ods
WHERE
    bf_bons_kpia_akt_tmp.mandant_id = ods.`_mandant_id` AND bf_bons_kpia_akt_tmp.wup_id = ods.`_wup_id` AND
    bf_bons_kpia_akt_tmp.dat = ods.`_dat` AND bf_bons_kpia_akt_tmp.mutter_id_wb = ods.`_mutter_id_wb` AND
    bf_bons_kpia_akt_tmp.shopperwoche IN (
        SELECT kjwo
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
        GROUP BY kjwo
    );


DELETE FROM dbp_etl.bf_bons_kpia_akt
WHERE shopperwoche IN (
    SELECT kjwo
    FROM dbp_process.tag_shopper_2
    WHERE akt_wo = shopperzeit
    GROUP BY kjwo
);


INSERT INTO dbp_etl.bf_bons_kpia_akt
(
    SELECT *
    FROM dbp_etl.bf_bons_kpia_akt_tmp_2
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
    M.ek_mep
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
    FROM dbp_process.bf_hit_the_actions_2
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
        M.mandant_id = x0.mandant_id AND CAST(FLOOR(M.art_id / 100) AS INTEGER) = x0.kl_art_id AND M.wup_id
        = x0.wup_id
WHERE
    M.mandant_id = 1
    AND M.dat BETWEEN (
        SELECT MIN(dat)
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit - 53) AND (
        SELECT MAX(dat)
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
    )
    AND M.art_id IN (
        SELECT art_id
        FROM `_mutter_art`
    )
    AND M.menge > 0;


DELETE FROM dbp_etl.bf_bons_kpi1x
WHERE shopperwoche IN (
    SELECT kjwo
    FROM dbp_process.tag_shopper_2
    WHERE akt_wo = shopperzeit
    GROUP BY kjwo
);


INSERT INTO dbp_etl.bf_bons_kpi1x
(
    SELECT
        (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        ) AS shopperwoche,
        M.mandant_id,
        M.dat,
        M.wup_id,
        A.mutter_wb_id,
        MAX(A.wg_id) AS wg_id,
        COUNT(DISTINCT M.aktion_id) AS aktionen,
        CAST(SUM(CASE
            WHEN M.aktion_id IN ('', '0')
                THEN M.umsatz_netto
            ELSE 0
        END) AS NUMERIC) AS af_ums_netto,
        CAST(SUM(CASE
            WHEN M.aktion_id NOT IN ('', '0')
                THEN M.umsatz_netto
            ELSE 0
        END) AS NUMERIC) AS sa_ums_netto,
        0 AS akt_ums_netto,
        SUM(CASE
            WHEN M.aktion_id IN ('', '0')
                THEN M.menge
            ELSE 0
        END) AS af_absatz,
        SUM(CASE
            WHEN M.aktion_id NOT IN ('', '0')
                THEN M.menge
            ELSE 0
        END) AS sa_absatz,
        0 AS akt_absatz,
        CAST(SUM(CASE
            WHEN M.aktion_id IN ('', '0')
                THEN CAST(M.ek_mep AS NUMERIC)
            ELSE 0
        END) AS NUMERIC) AS af_mep,
        CAST(SUM(CASE
            WHEN M.aktion_id NOT IN ('', '0')
                THEN CAST(M.ek_mep AS NUMERIC)
            ELSE 0
        END) AS NUMERIC) AS sa_mep,
        0 AS akt_mep,
        CAST(SUM(CASE
            WHEN M.aktion_id IN ('', '0')
                THEN M.umsatz_netto
            ELSE 0
        END) - SUM(CASE
            WHEN M.aktion_id IN ('', '0')
                THEN CAST(M.ek_mep AS NUMERIC)
            ELSE 0
        END) AS NUMERIC) AS af_ertrag,
        CAST(SUM(CASE
            WHEN M.aktion_id NOT IN ('', '0')
                THEN M.umsatz_netto
            ELSE 0
        END) - SUM(CASE
            WHEN M.aktion_id NOT IN ('', '0')
                THEN CAST(M.ek_mep AS NUMERIC)
            ELSE 0
        END) AS NUMERIC) AS sa_ertrag,
        0 AS akt_ertrag
    FROM `_artbew` AS M
    INNER JOIN `_mutter_art` AS A ON M.mandant_id = 1 AND M.art_id = A.art_id
    WHERE
        M.mandant_id = 1
        AND M.dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 53) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
        )
        AND M.menge > 0
    GROUP BY
        shopperwoche,
        M.mandant_id,
        M.dat,
        M.wup_id,
        A.mutter_wb_id
);


UPDATE dbp_etl.bf_bons_kpi1x SET
    akt_ums_netto = ak.`_ums_netto`,
    akt_absatz = ak.`_menge`,
    akt_mep = ak.`_mep`,
    akt_ertrag = ak.`_ertrag` FROM (
    SELECT
        M.mandant_id AS `_mandant_id`,
        M.dat AS `_dat`,
        M.wup_id AS `_wup_id`,
        X.mutter_wb_id AS `_mutter_wb_id`,
        SUM(M.umsatz_netto) AS `_ums_netto`,
        SUM(M.menge) AS `_menge`,
        SUM(CAST(M.ek_mep AS NUMERIC)) AS `_mep`,
        SUM(M.umsatz_netto) - SUM(CAST(M.ek_mep AS NUMERIC)) AS `_ertrag`
    FROM `_artbew` AS M
    INNER JOIN `_test_upd` AS X1
        ON
            M.aktion_id = X1.aktion_id AND M.mandant_id = X1.mandant_id AND M.dat BETWEEN X1.dat_von
            AND X1.dat_bis AND M.wup_id = X1.wup_id AND CAST(FLOOR(M.art_id / 100) AS INTEGER) = X1.kl_art_id
    INNER JOIN `_mutter_art` AS X ON M.art_id = X.art_id
    WHERE
        M.mandant_id = 1
        AND M.dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 53) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
        )
        AND (
            M.wup_id, CAST(FLOOR(M.art_id / 100) AS INTEGER)) IN (
            SELECT (wup_id, kl_art_id)
            FROM `_markets_hta`
        )
    GROUP BY
        `_mandant_id`,
        `_dat`,
        `_wup_id`,
        `_mutter_wb_id`
) AS ak
WHERE
    bf_bons_kpi1x.mandant_id = ak.`_mandant_id` AND bf_bons_kpi1x.wup_id = ak.`_wup_id` AND bf_bons_kpi1x.dat = ak.`_dat`
    AND bf_bons_kpi1x.mutter_id_wb = ak.`_mutter_wb_id` AND bf_bons_kpi1x.shopperwoche IN (
        SELECT kjwo
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
        GROUP BY kjwo
    );


TRUNCATE TABLE dbp_etl.bf_bons_kpim_akt_2;


INSERT INTO dbp_etl.bf_bons_kpim_akt_2
(
    SELECT
        CAST(OK.mandant_id AS INTEGER) AS mandant_id,
        CAST(OK.wup_id AS INTEGER) AS wup_id,
        OK.bon_dat,
        COUNT(DISTINCT OK.bon_id) AS `_bons`,
        SUM(t3.zeilen) AS `_bon_zeilen`,
        COUNT(DISTINCT CASE
            WHEN t3.aktion_id IN ('', '0')
                THEN t3.bon_id
            ELSE NULL
        END) AS `_bons_af`,
        COUNT(DISTINCT CASE
            WHEN t3.aktion_id NOT IN ('', '0')
                THEN t3.bon_id
            ELSE NULL
        END) AS `_bons_sa`,
        0 AS `_bons_akt`,
        CAST(SUM(CASE
            WHEN t3.aktion_id IN ('', '0')
                THEN t3.umsatz_brutto
            ELSE 0
        END) AS NUMERIC) AS `_ges_umsatz_af`,
        CAST(SUM(CASE
            WHEN t3.aktion_id NOT IN ('', '0')
                THEN t3.umsatz_brutto
            ELSE 0
        END) AS NUMERIC) AS `_ges_umsatz_sa`,
        0 AS `_ges_umsatz_akt`
    FROM (SELECT
        bon_id,
        bon_dat,
        mandant_id,
        wup_id,
        kl_art_id,
        aktion_id,
        COUNT(*) AS zeilen,
        SUM(umsatz_brutto) AS umsatz_brutto
    FROM dbp_spezial.v_ods_bon_verkauf_union_2 AS V
    WHERE
        wg_id <> 980
        AND mandant_id = 1
        AND -- v.bon_dat between '2020-01-01' and CURRENT_DATE("Europe/Berlin")
        bon_dat IN (
            SELECT dat
            FROM `_wochen`
        )
    GROUP BY
        bon_id,
        kl_art_id,
        aktion_id,
        mandant_id,
        wup_id,
        bon_dat
    HAVING umsatz_brutto > 0) AS t3
    INNER JOIN dbp_spezial.v_ods_bon_kopf_union_2 AS OK
        ON
            t3.mandant_id = OK.mandant_id AND t3.wup_id = OK.wup_id
            AND t3.bon_id = OK.bon_id AND t3.bon_dat = OK.bon_dat
    WHERE
        OK.mandant_id = 1
        AND OK.turnover_fg = 1
        AND (
            OK.bon_id, OK.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_spezial.v_ods_bon_storno_union_2
        )
    GROUP BY
        OK.mandant_id,
        OK.wup_id,
        OK.bon_dat
);


UPDATE dbp_etl.bf_bons_kpim_akt_2 SET
    ges_umsatz_akt = ods.`_akt_umsatz_sa`,
    bons_akt = ods.`_bons_akt` FROM (
    SELECT
        OK.mandant_id AS `_mandant_id`,
        OK.wup_id AS `_wup_id`,
        OK.bon_dat AS `_dat`,
        COUNT(DISTINCT V.bon_id) AS `_bons_akt`,
        SUM(V.umsatz_brutto) AS `_akt_umsatz_sa`
    FROM dbp_spezial.v_ods_bon_verkauf_union_2 AS V
    INNER JOIN dbp_spezial.v_ods_bon_kopf_union_2 AS OK
        ON
            V.mandant_id = OK.mandant_id AND V.wup_id = OK.wup_id
            AND V.bon_id = OK.bon_id AND V.bon_dat = OK.bon_dat
    INNER JOIN `_wochen` AS X ON OK.bon_dat = X.dat
    INNER JOIN dbp_data.aktion_2 AS AKT
        ON
            V.aktion_id = AKT.aktion_id AND OK.bon_dat BETWEEN AKT.dat_von
            AND AKT.dat_bis AND OK.mandant_id = AKT.mandant_id
    INNER JOIN dbp_data.aktion_art_wup_zu_2 AS AKTA
        ON
            AKT.aktion_id = AKTA.aktion_id AND AKT.mandant_id =
            AKTA.mandant_id AND V.wup_id = AKTA.wup_id AND V.kl_art_id = CAST(FLOOR(AKTA.art_id / 100) AS INTEGER)
    WHERE
        OK.mandant_id = 1
        AND OK.turnover_fg = 1
        AND V.wg_id <> 980
        AND AKT.preisaktiviert_fg = 1
        AND AKTA.dat_sperrung IS NULL
        AND (
            OK.bon_id, OK.bon_dat) NOT IN (
            SELECT (bon_id, bon_dat)
            FROM dbp_spezial.v_ods_bon_storno_union_2
        )
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_dat`
) AS ods
WHERE
    bf_bons_kpim_akt.mandant_id = ods.`_mandant_id` AND bf_bons_kpim_akt.wup_id = ods.`_wup_id` AND bf_bons_kpim_akt.dat
    = ods.`_dat`;


DELETE FROM dbp_process.bf_bons_kpim_akt_2
WHERE dat IN (
    SELECT dat
    FROM `_wochen`
);


INSERT INTO dbp_process.bf_bons_kpim_akt_2
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
FROM dbp_etl.bf_bons_kpim_akt_2 AS A);


/*
+-------------------------------------------------------------
+ 8. Korrektur der Bonzeilen in der Artikeltabelle.
+-------------------------------------------------------------
*/


UPDATE dbp_etl.bf_bons_kpia_akt SET
    a_bons = xxx.`_a_bons` FROM (
    SELECT
        mandant_id AS `_mandant_id`,
        wup_id AS `_wup_id`,
        shopperwoche AS `_shopperwoche`,
        dat AS `_dat`,
        mutter_id_wb AS `_mutter_id_wb`,
        COUNT(*) AS `_a_bons`
    FROM dbp_etl.bf_bons_kpicp_akt AS C
    WHERE
        shopperwoche IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
        AND a_absatz_af + a_absatz_sa > 0
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_shopperwoche`,
        `_dat`,
        `_mutter_id_wb`
) AS xxx_2
WHERE
    bf_bons_kpia_akt.mandant_id = xxx.`_mandant_id` AND bf_bons_kpia_akt.mutter_id_wb = xxx.`_mutter_id_wb` AND
    bf_bons_kpia_akt.wup_id = xxx.`_wup_id` AND bf_bons_kpia_akt.dat = xxx.`_dat` AND bf_bons_kpia_akt.shopperwoche =
    xxx.`_shopperwoche`;


-- 08.09.2016
--
-- Jetzt werden die Displays fuer die CP-Grenze von 7,99 Euro
-- ausgeschlossen! Aufbau der statischen Tabelle fuer die je-
-- weilige Shopperwoche.


CREATE OR REPLACE TEMPORARY TABLE _exclude_displays AS
SELECT
    C.mandant_id,
    C.kl_art_id
FROM dbp_data.stueckliste_2 AS A
INNER JOIN dbp_data.stueckliste_det_2 AS B ON A.mandant_id = B.mandant_id AND A.stueckliste_id = B.stueckliste_id

INNER JOIN dbp_process.bf_hit_the_actions_2 AS C
    ON
        A.mandant_id = C.mandant_id AND CAST(FLOOR(A.art_id / 100) AS INTEGER)
        = C.kl_art_id
WHERE
    A.dat_bis = DATE '9999-12-31'
    AND C.kjwo IN (
        SELECT kjwo
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
        GROUP BY kjwo
    )
    AND B.komponentenmenge <= 1
GROUP BY
    C.mandant_id,
    C.kl_art_id;


CREATE OR REPLACE TEMPORARY TABLE _baselines (
    baseline INTEGER,
    bl_von DATE
);


INSERT INTO `_baselines`
(SELECT
    1,
    MIN(dat)
FROM dbp_process.tag_shopper_2
WHERE akt_wo = shopperzeit - 53);


DELETE FROM dbp_etl.bf_shopper_front
WHERE shopperwoche IN (
    SELECT kjwo
    FROM dbp_process.tag_shopper_2
    WHERE akt_wo = shopperzeit
    GROUP BY kjwo
);


INSERT INTO dbp_etl.bf_shopper_front
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
    FROM dbp_etl.bf_bons_kpi1x AS M
    INNER JOIN dbp_data.wup_2 AS W ON TRUE
    INNER JOIN dbp_process.tag_shopper_2 AS Z ON TRUE
    WHERE
        M.mandant_id = 1
        AND Z.dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 53) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 2
        )
        AND M.shopperwoche IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
        AND Z.dat = M.dat
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


INSERT INTO dbp_etl.bf_shopper_front
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
    FROM dbp_etl.bf_bons_kpi1x AS M
    INNER JOIN dbp_data.wup_2 AS W ON TRUE
    INNER JOIN dbp_process.tag_shopper_2 AS Z ON TRUE
    WHERE
        M.mandant_id = 1
        AND Z.dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 1) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
        )
        AND M.shopperwoche IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
        AND Z.dat = M.dat
        AND M.mandant_id = W.mandant_id
        AND M.wup_id = W.wup_id
        AND (
            M.mandant_id, W.aktuell_wup_id, M.mutter_id_wb) NOT IN (
            SELECT (mandant_id, wup_id, mutter_id_wb)
            FROM dbp_etl.bf_shopper_front
            WHERE
                shopperwoche IN (
                    SELECT kjwo
                    FROM dbp_process.tag_shopper_2
                    WHERE akt_wo = shopperzeit
                    GROUP BY kjwo
                )
        )
);


UPDATE dbp_etl.bf_shopper_front SET
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
    FROM dbp_etl.bf_bons_kpi1x AS M
    INNER JOIN dbp_data.wup_2 AS W ON M.mandant_id = W.mandant_id AND M.wup_id = W.wup_id
    INNER JOIN dbp_process.tag_shopper_2 AS Z ON M.dat = Z.dat
    WHERE
        M.mandant_id = 1
        AND Z.dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 53) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 2
        )
        AND M.af_absatz > 0
        AND M.sa_absatz = 0
        AND M.shopperwoche IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_mutter_id_wb`,
        `_shopperwoche`,
        `_baseline`
) AS xxx_2
WHERE
    bf_shopper_front.mandant_id = xxx.`_mandant_id` AND bf_shopper_front.wup_id = xxx.`_wup_id` AND bf_shopper_front.mutter_id_wb
    = xxx.`_mutter_id_wb` AND bf_shopper_front.shopperwoche = xxx.`_shopperwoche` AND bf_shopper_front.baseline = xxx.`_baseline`;


UPDATE dbp_etl.bf_shopper_front SET
    bl_af_kaeufer = CAST(xxx.`_bl_af_kaeufer` AS INTEGER),
    bl_af_kd_rw = CAST(xxx.`_bl_af_kd_rw` AS NUMERIC),
    rw_af_tage = xxx.`_rw_tage`,
    anz_kaeufer_af = xxx.`_anz_kaeufer_af` -- , anz_bon_af = _anz_bon_af
    ,
    anz_bon_af = xxx.`_anz_bon_af` -- , anz_bon_sa = _anz_bon_sa
    ,
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
    FROM dbp_etl.bf_bons_kpia_akt AS A
    INNER JOIN dbp_process.bf_bons_kpim_akt_2 AS M
        ON
            A.mandant_id = M.mandant_id AND A.wup_id = M.wup_id
            AND A.dat = M.dat
    INNER JOIN dbp_data.wup_2 AS W ON M.mandant_id = W.mandant_id AND M.wup_id = W.wup_id
    INNER JOIN dbp_process.tag_shopper_2 AS Z ON M.dat = Z.dat
    WHERE
        Z.dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 53) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 2
        )
        AND A.mandant_id = 1
        AND A.a_absatz_af > 0
        AND A.a_absatz_sa = 0
        AND W.nb_id = 0
        AND A.shopperwoche IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_mutter_id_wb`,
        `_shopperwoche`,
        `_baseline`
) AS xxx_2
WHERE
    bf_shopper_front.mandant_id = xxx.`_mandant_id` AND bf_shopper_front.wup_id = xxx.`_wup_id` AND bf_shopper_front.mutter_id_wb
    = xxx.`_mutter_id_wb` AND bf_shopper_front.shopperwoche = xxx.`_shopperwoche` AND bf_shopper_front.baseline = xxx.`_baseline`;


UPDATE dbp_etl.bf_shopper_front SET
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
    FROM dbp_etl.bf_bons_kpi1x AS M
    INNER JOIN dbp_data.wup_2 AS W ON M.mandant_id = W.mandant_id AND M.wup_id = W.wup_id
    INNER JOIN dbp_process.tag_shopper_2 AS Z ON M.dat = Z.dat
    WHERE
        M.mandant_id = 1
        AND Z.dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 1) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
        )
        AND M.akt_absatz > 0
        AND M.shopperwoche IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_mutter_id_wb`,
        `_shopperwoche`,
        `_baseline`
) AS xxx_2
WHERE
    bf_shopper_front.mandant_id = xxx.`_mandant_id` AND bf_shopper_front.wup_id = xxx.`_wup_id` AND bf_shopper_front.mutter_id_wb
    = xxx.`_mutter_id_wb` AND bf_shopper_front.shopperwoche = xxx.`_shopperwoche` AND bf_shopper_front.baseline = xxx.`_baseline`;


UPDATE dbp_etl.bf_shopper_front SET
    bl_akt_kaeufer = CAST(xxx.`_bl_akt_kaeufer` AS INTEGER),
    bl_akt_kd_rw = CAST(xxx.`_bl_akt_kd_rw` AS NUMERIC),
    rw_akt_tage = xxx.`_rw_akt_tage`,
    anz_markt_sa = xxx.`_anz_markt_sa`,
    anz_kaeufer_sa = xxx.`_anz_kaeufer_sa`,
    anz_bon_aktion = xxx.`_anz_bon_aktion` -- , anz_bon_aktion = -1
FROM (
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
    FROM dbp_etl.bf_bons_kpia_akt AS A
    INNER JOIN dbp_process.bf_bons_kpim_akt_2 AS M
        ON
            A.mandant_id = M.mandant_id AND A.wup_id = M.wup_id
            AND A.dat = M.dat
    INNER JOIN dbp_data.wup_2 AS W ON M.mandant_id = W.mandant_id AND M.wup_id = W.wup_id
    INNER JOIN dbp_process.tag_shopper_2 AS Z ON M.dat = Z.dat
    WHERE
        Z.dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 1) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
        )
        AND A.mandant_id = 1
        AND A.a_absatz_akt > 0
        AND A.a_absatz_af = 0
        AND W.nb_id = 0
        AND A.shopperwoche IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_mutter_id_wb`,
        `_shopperwoche`,
        `_baseline`
) AS xxx_2
WHERE
    bf_shopper_front.mandant_id = xxx.`_mandant_id` AND bf_shopper_front.wup_id = xxx.`_wup_id` AND bf_shopper_front.mutter_id_wb
    = xxx.`_mutter_id_wb` AND bf_shopper_front.shopperwoche = xxx.`_shopperwoche` AND bf_shopper_front.baseline = xxx.`_baseline`;


UPDATE dbp_etl.bf_shopper_front SET CP_KAEUFER = CAST(XXX._CP_KAEUFER AS INTEGER), CP_ALLE_70 = CAST(XXX._CP_ALLE_70 AS INTEGER) FROM (
    WITH date_range AS (
        SELECT AS STRUCT
            MIN(DAT) AS min_d,
            MAX(DAT) AS max_d
        FROM `dbp_process.tag_shopper_2`
        WHERE AKT_WO BETWEEN shopperzeit - 1 AND shopperzeit
    )

    SELECT
        W.MANDANT_ID AS _MANDANT_ID,
        W.AKTUELL_WUP_ID AS _WUP_ID,
        MUTTER_ID_WB AS _MUTTER_ID_WB,
        BF.SHOPPERWOCHE AS _SHOPPERWOCHE,
        NUMERIC '1' AS _BASELINE,
        CAST(count(DISTINCT concat(BF.WUP_ID, BF.DAT)) as BIGNUMERIC) AS TAGE,
        sum(CASE
            WHEN A_ABSATZ_AKT > NUMERIC '0' THEN NUMERIC '1'
            ELSE NUMERIC '0'
        END) AS _CP_KAEUFER,
        sum(CASE
            WHEN (A_UMSATZ_AF + A_UMSATZ_AKT) / nullif(GES_UMSATZ_AF + GES_UMSATZ_AKT, NUMERIC '0') >= CASE
                WHEN coalesce(X.VK_BRUTTO, NUMERIC '0') > NUMERIC '7.99' THEN NUMERIC '0.85'
                ELSE NUMERIC '0.7'
            END
            OR (A_ABSATZ_AF + A_ABSATZ_AKT) / nullif(GES_ABSATZ_AF + GES_ABSATZ_AKT, NUMERIC '0') >= NUMERIC '0.7' THEN NUMERIC '1'
            ELSE NUMERIC '0'
        END) AS _CP_ALLE_70
    FROM
        dbp_etl.bf_bons_kpicp_akt AS BF
    CROSS JOIN date_range AS t10
    INNER JOIN dbp_process.tag_shopper_2 AS Z
        ON
            Z.DAT BETWEEN t10.min_d AND t10.max_d
            AND Z.DAT = BF.DAT
    INNER JOIN dbp_data.wup_2 AS W
        ON
            BF.WUP_ID = W.WUP_ID
            AND BF.MANDANT_ID = W.MANDANT_ID
    LEFT OUTER JOIN (
        SELECT
            BF_HIT_THE_ACTIONS.WUP_ID,
            BF_HIT_THE_ACTIONS.ART_ID,
            max(BF_HIT_THE_ACTIONS.VK_BRUTTO) AS VK_BRUTTO
        FROM
            dbp_process.bf_hit_the_actions_2
        WHERE
            BF_HIT_THE_ACTIONS.KJWO IN (
                SELECT KJWO
                FROM
                    dbp_process.tag_shopper_2
                WHERE AKT_WO = shopperzeit
                GROUP BY 1
            )
            AND (BF_HIT_THE_ACTIONS.MANDANT_ID, BF_HIT_THE_ACTIONS.KL_ART_ID) NOT IN (
                SELECT AS STRUCT
                    _EXCLUDE_DISPLAYS.MANDANT_ID,
                    _EXCLUDE_DISPLAYS.KL_ART_ID
                FROM
                    _exclude_displays
            )
        GROUP BY 1, 2
    ) AS X
        ON
            BF.WUP_ID = X.WUP_ID
            AND BF.MUTTER_ID_WB = X.ART_ID
    WHERE
        A_ABSATZ_AKT > NUMERIC '0'
        AND BF.SHOPPERWOCHE IN (
            SELECT KJWO
            FROM
                dbp_process.tag_shopper_2
            WHERE AKT_WO = shopperzeit
            GROUP BY 1
        )
    GROUP BY 1, 2, 3, 4, 5
) AS XXX_2
WHERE
    MANDANT_ID = XXX._MANDANT_ID
    AND WUP_ID = XXX._WUP_ID
    AND MUTTER_ID_WB = XXX._MUTTER_ID_WB
    AND SHOPPERWOCHE = XXX._SHOPPERWOCHE
    AND BASELINE = XXX._BASELINE;


UPDATE dbp_etl.bf_shopper_front SET
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
    FROM dbp_etl.bf_bons_kpicp_akt AS BF
    INNER JOIN dbp_process.tag_shopper_2 AS Z ON BF.dat = Z.dat
    INNER JOIN dbp_data.wup_2 AS W ON BF.wup_id = W.wup_id AND BF.mandant_id = W.mandant_id
    WHERE
        BF.dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 1) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
        )
        AND BF.a_absatz_akt > 0
        AND BF.shopperwoche IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_mutter_id_wb`,
        `_shopperwoche`,
        `_baseline`
) AS xxx_2
WHERE
    bf_shopper_front.mandant_id = xxx.`_mandant_id` AND bf_shopper_front.wup_id = xxx.`_wup_id` AND bf_shopper_front.mutter_id_wb
    = xxx.`_mutter_id_wb` AND bf_shopper_front.shopperwoche = xxx.`_shopperwoche` AND bf_shopper_front.baseline = xxx.`_baseline`;


-- Jetzt Gesamtumsatz ueber den Baseline-Zeitraum, nicht mehr
-- ueber Aktionszeitraum.


UPDATE dbp_etl.bf_shopper_front SET
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
    FROM dbp_etl.bf_bons_kpicp_akt AS BF
    INNER JOIN dbp_process.tag_shopper_2 AS Z ON BF.dat = Z.dat
    INNER JOIN dbp_data.wup_2 AS W ON BF.wup_id = W.wup_id AND BF.mandant_id = W.mandant_id
    WHERE
        BF.dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit - 1) AND (
            SELECT MAX(dat)
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
        )
        AND BF.a_absatz_akt > 0
        AND BF.shopperwoche IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_mutter_id_wb`,
        `_shopperwoche`,
        `_baseline`
) AS xxx_2
WHERE
    bf_shopper_front.mandant_id = xxx.`_mandant_id` AND bf_shopper_front.wup_id = xxx.`_wup_id` AND bf_shopper_front.mutter_id_wb
    = xxx.`_mutter_id_wb` AND bf_shopper_front.shopperwoche = xxx.`_shopperwoche` AND bf_shopper_front.baseline = xxx.`_baseline`;


DELETE FROM dbp_etl.bf_shopper
WHERE shopperwoche IN (
    SELECT kjwo
    FROM dbp_process.tag_shopper_2
    WHERE akt_wo = shopperzeit
    GROUP BY kjwo
);


INSERT INTO dbp_etl.bf_shopper
(
    SELECT *
    FROM dbp_etl.bf_shopper_front
    WHERE shopperwoche IN (
        SELECT kjwo
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
        GROUP BY kjwo
    )
    AND baseline = 1
);


DELETE FROM dbp_data.shopper_2
WHERE (
    mandant_id, kjwo_werbe_ende) IN (
    SELECT (mandant_id, shopperwoche)
    FROM dbp_etl.bf_shopper
    WHERE
        shopperwoche IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
);


INSERT INTO dbp_data.shopper_2 (
    wup_id, nb_id, mandant_id, art_id_werbung, baseline, kjwo_werbe_ende,
    dat_baseline_von, dat_baseline_bis, anz_markt_baseline_af, ums_netto_baseline_af, ums_netto_sa, menge_baseline_af,
    menge_sa, ertrag_baseline_af, ertrag_sa, anz_kaeufer_af, anz_kaeufer_sa, anz_bon_af, anz_bon_sa, anz_bon_aktion,
    anz_tage_baseline_af, anz_tage_sa, kaeufer_prozent_baseline_af, kaeufer_prozent_sa, anz_cp_kaeufer,
    anz_cp_kaeufer_70_prozent, ums_rest_bon_af, ums_rest_bon_gesamt, ums_aktivierter_normalpreis, wrg_id,
    aktion_thema_gruppe_id, medien_kz, menge_wo1, menge_wo2, menge_wo3, anz_tage_wo1, anz_tage_wo2, anz_tage_wo3,
    vk_brutto_af_mittel, vk_brutto_sa_mittel, ums_gesamt_ausser_artikel, ums_gesamt_af_mit_wv, anz_markt_sa
)
(SELECT
    wup_id,
    nb_id,
    mandant_id,
    mutter_id_wb AS art_id_werbung,
    baseline,
    shopperwoche AS kjwo_werbe_ende,
    min_dat_bl AS dat_baseline_von,
    max_dat_bl AS dat_baseline_bis,
    anz_af_maerkte AS anz_markt_baseline_af,
    af_ums_netto AS ums_netto_baseline_af,
    akt_ums_netto AS ums_netto_sa,
    af_absatz AS menge_baseline_af,
    akt_absatz AS menge_sa,
    af_ertrag AS ertrag_baseline_af,
    akt_ertrag AS ertrag_sa,
    anz_kaeufer_af,
    anz_kaeufer_sa,
    anz_bon_af,
    anz_bon_sa,
    anz_bon_aktion,
    rw_af_tage AS anz_tage_baseline_af,
    rw_akt_tage AS anz_tage_sa,
    bl_af_kd_rw AS kaeufer_prozent_baseline_af,
    bl_akt_kd_rw AS kaeufer_prozent_sa,
    cp_kaeufer AS anz_cp_kaeufer,
    cp_alle_70 AS anz_cp_kaeufer_70_prozent,
    restbon_af AS ums_rest_bon_af,
    restbon_gesamt AS ums_rest_bon_gesamt,
    akt_np_umsatz AS ums_aktivierter_normalpreis,
    'EUR' AS wrg_id,
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
    ges_umsatz_ohne_art,
    ges_umsatz_inkl_wv,
    anz_markt_sa
FROM dbp_etl.bf_shopper AS A
WHERE shopperwoche IN (
    SELECT kjwo
    FROM dbp_process.tag_shopper_2
    WHERE akt_wo = shopperzeit
    GROUP BY kjwo
));


-- Neu: Jetzt nur Updates fuer Aktionsgruppe!!!
--
-- 1. Mit Marktbezug.


UPDATE dbp_data.shopper_2 SET
    aktion_thema_gruppe_id = b.aktion_thema_gruppe_id FROM (
    SELECT
        A.mandant_id,
        A.kjwo,
        B.aktuell_wup_id AS wup_id,
        A.art_id AS mutter_wb_id,
        MAX(A.aktion_thema_gruppe_id) AS aktion_thema_gruppe_id
    FROM dbp_process.bf_hit_the_actions_2 AS A
    INNER JOIN dbp_data.wup_2 AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
    WHERE
        A.kjwo IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
    GROUP BY
        A.mandant_id,
        A.kjwo,
        wup_id,
        mutter_wb_id
) AS b
WHERE
    shopper.mandant_id = b.mandant_id AND shopper.kjwo_werbe_ende = b.kjwo AND shopper.wup_id = b.wup_id AND shopper.art_id_werbung
    = b.mutter_wb_id;


-- 2. Ohne Marktbezug.


UPDATE dbp_data.shopper_2 SET
    aktion_thema_gruppe_id = b.aktion_thema_gruppe_id FROM (
    SELECT
        mandant_id,
        kjwo,
        art_id AS mutter_wb_id,
        MAX(aktion_thema_gruppe_id) AS aktion_thema_gruppe_id
    FROM dbp_process.bf_hit_the_actions_2 AS A
    WHERE
        kjwo IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
    GROUP BY
        mandant_id,
        kjwo,
        mutter_wb_id
) AS b
WHERE
    shopper.mandant_id = b.mandant_id AND shopper.kjwo_werbe_ende = b.kjwo AND shopper.art_id_werbung = b.mutter_wb_id
    AND shopper.aktion_thema_gruppe_id = -1;


-- Updates fuer VK_2-Preise!


UPDATE dbp_data.shopper_2 SET
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
    FROM dbp_data.shopper_2 AS A
    INNER JOIN (SELECT
        kjwo,
        MAX(dat) AS dat
    FROM dbp_process.tag_shopper_2
    WHERE kjwo >= 201601
    GROUP BY kjwo) AS x ON A.kjwo_werbe_ende = x.kjwo
    INNER JOIN dbp_data.art_2 AS B ON A.mandant_id = B.mandant_id AND A.art_id_werbung = B.art_id
    INNER JOIN dbp_data.mwst_per_2 AS C
        ON
            A.mandant_id = C.mandant_id AND B.mwst_id = C.mwst_id AND x.dat
            BETWEEN C.dat_von AND C.dat_bis
    WHERE
        A.kjwo_werbe_ende IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
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
FROM dbp_data.shopper_2 AS A
INNER JOIN (SELECT
    kjwo,
    MAX(dat) AS dat
FROM dbp_process.tag_shopper_2
WHERE kjwo >= 201601
GROUP BY kjwo) AS x ON A.kjwo_werbe_ende = x.kjwo
INNER JOIN (
    SELECT
        AKT.mandant_id,
        AKT.dat_von,
        AKT.dat_bis,
        AKTA.wup_id,
        AKTA.art_id,
        AKTA.vk_aktion_brutto
    FROM dbp_data.aktion_2 AS AKT
    INNER JOIN dbp_data.aktion_art_wup_zu_2 AS AKTA
        ON
            AKT.aktion_id = AKTA.aktion_id AND AKT.mandant_id =
            AKTA.mandant_id
    WHERE
        AKTA.dat_sperrung IS NULL
        AND AKT.preisaktiviert_fg = 1
        AND AKT.mandant_id = 1
) AS x1 ON A.mandant_id = x1.mandant_id AND A.wup_id = x1.wup_id AND A.art_id_werbung = x1.art_id

INNER JOIN (SELECT
    kjwo,
    MIN(dat) AS min_dat,
    MAX(dat) AS max_dat
FROM dbp_process.tag_shopper_2
WHERE
    kjwo IN (
        SELECT kjwo
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
        GROUP BY kjwo
    )
GROUP BY kjwo) AS x2 ON x1.dat_bis BETWEEN x2.min_dat AND x2.max_dat
WHERE
    A.kjwo_werbe_ende IN (
        SELECT kjwo
        FROM dbp_process.tag_shopper_2
        WHERE akt_wo = shopperzeit
        GROUP BY kjwo
    )
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.art_id_werbung,
    A.kjwo_werbe_ende;


UPDATE dbp_data.shopper_2 SET
    vk_brutto_sa_max = b.max_vk_brutto_sa
FROM `_upd` AS b
WHERE
    shopper.mandant_id = b.mandant_id AND shopper.wup_id = b.wup_id AND shopper.art_id_werbung = b.art_id_werbung AND
    shopper.kjwo_werbe_ende = b.kjwo_werbe_ende;


CREATE OR REPLACE TEMPORARY TABLE _upd_maedchen AS
SELECT
    X.kjwo,
    Z.mandant_id,
    Z.art_id,
    MIN(Z.dat_von) AS dat_von,
    MAX(Z.dat_bis) AS dat_bis,
    MAX(Z.bs_kz) AS bs_kz
FROM dbp_etl_process.werbe_medium_2 AS Z
INNER JOIN dbp_data.art_2 AS A ON Z.mandant_id = A.mandant_id AND Z.art_id = A.art_id
INNER JOIN dbp_data.aktion_2 AS AKT
    ON
        Z.mandant_id = AKT.mandant_id AND Z.dat_bis = AKT.dat_bis AND Z.dat_von
        = AKT.dat_von
INNER JOIN dbp_data.aktion_art_wup_zu_2 AS AKTA ON Z.mandant_id = AKTA.mandant_id AND AKT.aktion_id = AKTA.aktion_id AND Z.art_id = AKTA.art_id AND AKTA.dat_sperrung IS NULL AND Z.aktion_thema_id = AKTA.aktion_thema_id
INNER JOIN dbp_data.l_werbekat_2 AS WK
    ON
        AKT.mandant_id = WK.mandant_id AND AKT.werbe_kat_id = WK.werbe_kat_id
        AND Z.sap_werbe_kat_id = WK.sap_werbe_kat_id
INNER JOIN dbp_process.tag_shopper_2 AS X ON X.dat BETWEEN Z.dat_von AND Z.dat_bis
WHERE
    Z.bs_kz <> ''
    AND AKT.preisaktiviert_fg = 1
GROUP BY
    X.kjwo,
    Z.mandant_id,
    Z.art_id;


UPDATE dbp_data.shopper_2 SET
    medien_kz = b.bs_kz
FROM `_upd_maedchen` AS b
WHERE shopper.mandant_id = b.mandant_id AND shopper.art_id_werbung = b.art_id AND shopper.kjwo_werbe_ende = b.kjwo;


-- Werbenachbetrachtung

-- fuer 3. Woche_2


UPDATE dbp_data.shopper_2 SET
    menge_wo3 = b.menge,
    anz_tage_wo3 = b.anz_mt FROM (
    SELECT
        A.mandant_id,
        t4.kjwo,
        D.aktuell_wup_id AS wup_id,
        t4.art_id AS art_id_werbung,
        SUM(COALESCE(A.menge / t4.mengen_faktor, A.menge)) AS menge,
        COUNT(DISTINCT A.dat) AS anz_mt
    FROM dbp_data.artbew_2 AS A
    INNER JOIN dbp_process.tag_shopper_2 AS B ON A.dat = B.dat
    INNER JOIN dbp_data.wup_2 AS D ON A.mandant_id = D.mandant_id AND A.wup_id = D.wup_id
    INNER JOIN (
        SELECT
            mandant_id,
            kjwo,
            wup_id,
            art_id,
            kl_art_id,
            MIN(mengen_faktor) AS mengen_faktor
        FROM dbp_process.bf_hit_the_actions_2
        WHERE
            kjwo IN (
                SELECT kjwo
                FROM dbp_process.tag_shopper_2
                WHERE akt_wo = shopperzeit - 3
                GROUP BY kjwo
            )
        GROUP BY
            mandant_id,
            wup_id,
            kjwo,
            art_id,
            kl_art_id
    ) AS t4
        ON
            A.mandant_id = t4.mandant_id AND CAST(FLOOR(A.art_id / 100) AS INTEGER) = t4.kl_art_id AND A.wup_id
            = t4.wup_id
    WHERE
        B.kjwo IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
    GROUP BY
        A.mandant_id,
        t4.kjwo,
        wup_id,
        art_id_werbung
) AS b
WHERE
    shopper.mandant_id = b.mandant_id AND shopper.kjwo_werbe_ende = b.kjwo AND shopper.art_id_werbung = b.art_id_werbung
    AND shopper.wup_id = b.wup_id;


-- fuer 2. Woche_2


UPDATE dbp_data.shopper_2 SET
    menge_wo2 = b.menge,
    anz_tage_wo2 = b.anz_mt FROM (
    SELECT
        A.mandant_id,
        t4.kjwo,
        D.aktuell_wup_id AS wup_id,
        t4.art_id AS art_id_werbung,
        SUM(COALESCE(A.menge / t4.mengen_faktor, A.menge)) AS menge,
        COUNT(DISTINCT A.dat) AS anz_mt
    FROM dbp_data.artbew_2 AS A
    INNER JOIN dbp_process.tag_shopper_2 AS B ON A.dat = B.dat
    INNER JOIN dbp_data.wup_2 AS D ON A.mandant_id = D.mandant_id AND A.wup_id = D.wup_id
    INNER JOIN (
        SELECT
            mandant_id,
            kjwo,
            wup_id,
            art_id,
            kl_art_id,
            MIN(mengen_faktor) AS mengen_faktor
        FROM dbp_process.bf_hit_the_actions_2
        WHERE
            kjwo IN (
                SELECT kjwo
                FROM dbp_process.tag_shopper_2
                WHERE akt_wo = shopperzeit - 2
                GROUP BY kjwo
            )
        GROUP BY
            mandant_id,
            wup_id,
            kjwo,
            art_id,
            kl_art_id
    ) AS t4
        ON
            A.mandant_id = t4.mandant_id AND CAST(FLOOR(A.art_id / 100) AS INTEGER) = t4.kl_art_id AND A.wup_id
            = t4.wup_id
    WHERE
        B.kjwo IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
    GROUP BY
        A.mandant_id,
        t4.kjwo,
        wup_id,
        art_id_werbung
) AS b
WHERE
    shopper.mandant_id = b.mandant_id AND shopper.kjwo_werbe_ende = b.kjwo AND shopper.art_id_werbung = b.art_id_werbung
    AND shopper.wup_id = b.wup_id;


-- fuer 1. Woche_2


UPDATE dbp_data.shopper_2 SET
    menge_wo1 = b.menge,
    anz_tage_wo1 = b.anz_mt FROM (
    SELECT
        A.mandant_id,
        t4.kjwo,
        D.aktuell_wup_id AS wup_id,
        t4.art_id AS art_id_werbung,
        SUM(COALESCE(A.menge / t4.mengen_faktor, A.menge)) AS menge,
        COUNT(DISTINCT A.dat) AS anz_mt
    FROM dbp_data.artbew_2 AS A
    INNER JOIN dbp_process.tag_shopper_2 AS B ON A.dat = B.dat
    INNER JOIN dbp_data.wup_2 AS D ON A.mandant_id = D.mandant_id AND A.wup_id = D.wup_id
    INNER JOIN (
        SELECT
            mandant_id,
            kjwo,
            wup_id,
            art_id,
            kl_art_id,
            MIN(mengen_faktor) AS mengen_faktor
        FROM dbp_process.bf_hit_the_actions_2
        WHERE
            kjwo IN (
                SELECT kjwo
                FROM dbp_process.tag_shopper_2
                WHERE akt_wo = shopperzeit - 1
                GROUP BY kjwo
            )
        GROUP BY
            mandant_id,
            wup_id,
            kjwo,
            art_id,
            kl_art_id
    ) AS t4
        ON
            A.mandant_id = t4.mandant_id AND CAST(FLOOR(A.art_id / 100) AS INTEGER) = t4.kl_art_id AND A.wup_id
            = t4.wup_id
    WHERE
        B.kjwo IN (
            SELECT kjwo
            FROM dbp_process.tag_shopper_2
            WHERE akt_wo = shopperzeit
            GROUP BY kjwo
        )
    GROUP BY
        A.mandant_id,
        t4.kjwo,
        wup_id,
        art_id_werbung
) AS b
WHERE
    shopper.mandant_id = b.mandant_id AND shopper.kjwo_werbe_ende = b.kjwo AND shopper.art_id_werbung = b.art_id_werbung
    AND shopper.wup_id = b.wup_id;
