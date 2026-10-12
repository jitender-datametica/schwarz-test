DECLARE aw INT64;
DECLARE akt_woche INT64;
DECLARE vor_woche INT64;
DECLARE flg_woche INT64;
SET aw = ${WW};

SET akt_woche = (
    SELECT ww.kjwo_ww
    FROM
        dbp_data.werbewoche_kl AS ww
    WHERE
        ww.mandant_id = 1
        AND ww.akt_kjwo_ww = aw
    GROUP BY 1
);
SET vor_woche = (
    SELECT ww.kjwo_ww
    FROM
        dbp_data.werbewoche_kl AS ww
    WHERE
        ww.mandant_id = 1
        AND ww.akt_kjwo_ww = aw - 1
    GROUP BY 1
);
SET flg_woche = (
    SELECT ww.kjwo_ww
    FROM
        dbp_data.werbewoche_kl AS ww
    WHERE
        ww.mandant_id = 1
        AND ww.akt_kjwo_ww = aw + 1
    GROUP BY 1
);


CREATE OR REPLACE TEMPORARY TABLE _hit_the_actions AS
SELECT
    AKT.mandant_id,
    W.wup_id,
    x.kjwo_ww AS kjwo,
    AKT.aktion_id,
    '' AS aktion_thema_gruppe_id,
    AKT.werbe_kat_id,
    AKTA.art_id,
    A.kl_art_id,
    'W' AS muki,
    AKT.dat_von,
    AKT.dat_bis,
    1 AS mengen_faktor,
    A.posten_id,
    0 AS vk_brutto
FROM dbp_data.aktion AS AKT
INNER JOIN dbp_data.aktion_art_wup_zu AS AKTA
    ON
        AKT.aktion_id = AKTA.aktion_id AND AKT.mandant_id =
        AKTA.mandant_id
INNER JOIN dbp_data.art AS A
    ON
        AKTA.mandant_id = A.mandant_id AND A.mutter_wb_id IS NULL AND AKTA.art_id
        = A.art_id
INNER JOIN dbp_data.wup AS W
    ON
        AKTA.wup_id = W.wup_id AND AKTA.mandant_id = W.mandant_id AND W.nb_id =
        0 AND AKT.dat_von BETWEEN W.dat_von AND W.dat_bis
INNER JOIN dbp_data.art_wg_zu_per AS AW
    ON
        AKTA.art_id = AW.art_id AND AKTA.mandant_id = AW.mandant_id
        AND AW.arthiertyp_id = 2 AND AW.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wg_per AS WP
    ON
        AW.mandant_id = WP.mandant_id AND AW.arthiertyp_id = WP.arthiertyp_id
        AND AW.wg_id = WP.wg_id AND WP.dat_bis = DATE '9999-12-31'
INNER JOIN (
    SELECT
        A0.kjwo_ww,
        MIN(COALESCE(B.dat, A0.dat)) AS min_dat,
        MAX(COALESCE(B.dat, A0.dat)) AS max_dat
    FROM dbp_data.werbewoche_kl AS A0
    LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B ON A0.kjwo_ww = B.kjwo_ww AND A0.mandant_id = B.mandant_id
    WHERE
        A0.akt_kjwo_ww = aw
        AND A0.mandant_id = 1
    GROUP BY A0.kjwo_ww
) AS x ON AKT.dat_bis BETWEEN x.min_dat AND x.max_dat
WHERE
    AKTA.dat_sperrung IS NULL
    AND AKT.preisaktiviert_fg = 1
    AND AKT.mandant_id = 1
GROUP BY
    AKT.mandant_id,
    W.wup_id,
    kjwo,
    AKT.aktion_id,
    aktion_thema_gruppe_id,
    AKT.werbe_kat_id,
    AKTA.art_id,
    A.kl_art_id,
    muki,
    AKT.dat_von,
    AKT.dat_bis,
    mengen_faktor,
    A.posten_id,
    vk_brutto
UNION ALL
SELECT
    AKT.mandant_id,
    W.wup_id,
    x.kjwo_ww AS kjwo,
    AKT.aktion_id,
    '' AS aktion_thema_gruppe_id,
    AKT.werbe_kat_id,
    AKTA.art_id,
    A.kl_art_id,
    'M' AS muki,
    AKT.dat_von,
    AKT.dat_bis,
    1 AS mengen_faktor,
    A.posten_id,
    0 AS vk_brutto
FROM dbp_data.aktion AS AKT
INNER JOIN dbp_data.aktion_art_wup_zu AS AKTA
    ON
        AKT.aktion_id = AKTA.aktion_id AND AKT.mandant_id =
        AKTA.mandant_id
INNER JOIN dbp_data.art AS A ON AKTA.mandant_id = A.mandant_id AND AKTA.art_id = A.mutter_wb_id
INNER JOIN dbp_data.wup AS W
    ON
        AKTA.wup_id = W.wup_id AND AKTA.mandant_id = W.mandant_id AND W.nb_id =
        0 AND AKT.dat_von BETWEEN W.dat_von AND W.dat_bis
INNER JOIN dbp_data.art_wg_zu_per AS AW
    ON
        AKTA.art_id = AW.art_id AND AKTA.mandant_id = AW.mandant_id
        AND AW.arthiertyp_id = 2 AND AW.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wg_per AS WP
    ON
        AW.mandant_id = WP.mandant_id AND AW.arthiertyp_id = WP.arthiertyp_id
        AND AW.wg_id = WP.wg_id AND WP.dat_bis = DATE '9999-12-31'
INNER JOIN (
    SELECT
        A1.kjwo_ww,
        MIN(COALESCE(B.dat, A1.dat)) AS min_dat,
        MAX(COALESCE(B.dat, A1.dat)) AS max_dat
    FROM dbp_data.werbewoche_kl AS A1
    LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B ON A1.kjwo_ww = B.kjwo_ww AND A1.mandant_id = B.mandant_id
    WHERE
        A1.akt_kjwo_ww = aw
        AND A1.mandant_id = 1
    GROUP BY A1.kjwo_ww
) AS x ON AKT.dat_bis BETWEEN x.min_dat AND x.max_dat
WHERE
    AKTA.dat_sperrung IS NULL
    AND AKT.preisaktiviert_fg = 1
    AND AKT.mandant_id = 1
GROUP BY
    AKT.mandant_id,
    W.wup_id,
    kjwo,
    AKT.aktion_id,
    aktion_thema_gruppe_id,
    AKT.werbe_kat_id,
    AKTA.art_id,
    A.kl_art_id,
    muki,
    AKT.dat_von,
    AKT.dat_bis,
    mengen_faktor,
    A.posten_id,
    vk_brutto;


INSERT INTO `_hit_the_actions`
(
    SELECT
        A.mandant_id,
        A.wup_id,
        b.kjwo_ww,
        A.aktion_id,
        A.aktion_thema_gruppe_id,
        A.werbe_kat_id,
        A.art_id,
        A.kl_art_id,
        A.muki,
        A.dat_von,
        A.dat_bis,
        A.mengen_faktor,
        A.posten_id,
        A.vk_brutto
    FROM `_hit_the_actions` AS A
    INNER JOIN (
        SELECT
            A0.kjwo_ww,
            MIN(COALESCE(B.dat, A0.dat)) AS min_dat,
            MAX(COALESCE(B.dat, A0.dat)) AS max_dat
        FROM dbp_data.werbewoche_kl AS A0
        LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B
            ON
                A0.kjwo_ww = B.kjwo_ww AND A0.mandant_id =
                B.mandant_id
        WHERE A0.mandant_id = 1
        GROUP BY A0.kjwo_ww
    ) AS b ON A.dat_von BETWEEN b.min_dat AND b.max_dat
    WHERE A.kjwo <> b.kjwo_ww
);


INSERT INTO `_hit_the_actions`
(SELECT
    mandant_id,
    wup_id,
    kjwo,
    aktion_id,
    aktion_thema_gruppe_id,
    CAST(werbe_kat_id AS INTEGER) AS werbe_kat_id,
    art_id,
    kl_art_id,
    muki,
    DATE(dm__operand9) AS dm__operand9,
    DATE(dm__operand10) AS dm__operand10,
    mengen_faktor,
    posten_id,
    vk_brutto
FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        x.kjwo_ww AS kjwo,
        A.aktion_id,
        '' AS aktion_thema_gruppe_id,
        NULL AS werbe_kat_id,
        B.art_id,
        B.kl_art_id,
        'W' AS muki,
        '9999-12-31' AS dm__operand9,
        '9999-12-31' AS dm__operand10,
        1 AS mengen_faktor,
        B.posten_id,
        0 AS vk_brutto
    FROM dbp_data.artbew AS A
    INNER JOIN dbp_data.art AS B
        ON
            A.mandant_id = B.mandant_id AND B.mutter_wb_id IS NULL AND A.art_id
            = B.art_id
    INNER JOIN (
        SELECT
            A0.mandant_id,
            A0.kjwo_ww,
            COALESCE(B0.dat, A0.dat) AS dat
        FROM dbp_data.werbewoche_kl AS A0
        LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B0
            ON
                A0.kjwo_ww = B0.kjwo_ww AND A0.mandant_id
                = B0.mandant_id
        WHERE
            A0.akt_kjwo_ww = aw
            AND A0.mandant_id = 1
        GROUP BY
            A0.mandant_id,
            A0.kjwo_ww,
            dat
    ) AS x ON A.mandant_id = x.mandant_id AND A.dat = x.dat
    WHERE
        A.mandant_id = 1
        AND A.bewart_id = 1002
        AND A.aktion_id <> '999999999'
        AND (
            A.mandant_id, A.wup_id, A.art_id) NOT IN (
            SELECT (mandant_id, wup_id, art_id)
            FROM `_hit_the_actions`
        )
    GROUP BY
        A.mandant_id,
        A.wup_id,
        kjwo,
        A.aktion_id,
        aktion_thema_gruppe_id,
        werbe_kat_id,
        B.art_id,
        B.kl_art_id,
        muki,
        10,
        mengen_faktor,
        B.posten_id,
        vk_brutto
    UNION ALL
    SELECT
        A.mandant_id,
        A.wup_id,
        x.kjwo_ww AS kjwo,
        A.aktion_id,
        '' AS aktion_thema_gruppe_id,
        NULL AS werbe_kat_id,
        B.mutter_wb_id AS art_id,
        B.kl_art_id,
        'M' AS muki,
        '9999-12-31',
        '9999-12-31',
        1 AS mengen_faktor,
        B.posten_id,
        0 AS vk_brutto
    FROM dbp_data.artbew AS A
    INNER JOIN dbp_data.art AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.mutter_wb_id
            IS NOT NULL
    INNER JOIN (
        SELECT
            A1.mandant_id,
            A1.kjwo_ww,
            COALESCE(B1.dat, A1.dat) AS dat
        FROM dbp_data.werbewoche_kl AS A1
        LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B1
            ON
                A1.kjwo_ww = B1.kjwo_ww AND A1.mandant_id
                = B1.mandant_id
        WHERE
            A1.akt_kjwo_ww = aw
            AND A1.mandant_id = 1
        GROUP BY
            A1.mandant_id,
            A1.kjwo_ww,
            dat
    ) AS x ON A.mandant_id = x.mandant_id AND A.dat = x.dat
    WHERE
        A.mandant_id = 1
        AND A.bewart_id = 1002
        AND A.aktion_id <> '999999999'
        AND (
            A.mandant_id, A.wup_id, A.art_id) NOT IN (
            SELECT (mandant_id, wup_id, art_id)
            FROM `_hit_the_actions`
        )
    GROUP BY
        A.mandant_id,
        A.wup_id,
        kjwo,
        A.aktion_id,
        aktion_thema_gruppe_id,
        werbe_kat_id,
        art_id,
        B.kl_art_id,
        muki,
        10,
        mengen_faktor,
        B.posten_id,
        vk_brutto
) AS t15);


CREATE OR REPLACE TEMPORARY TABLE _hilfe1 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.art_id,
    A.bewart_id,
    MAX(A.aktionsart_id_liste_txt) AS aktionsart_id_liste_txt,
    MAX(A.aktionsart_bez_liste_txt) AS aktionsart_bez_liste_txt,
    MAX(A.aktion_typ_id_liste_txt) AS aktion_typ_id_liste_txt,
    MAX(A.aktion_typ_bez_liste_txt) AS aktion_typ_bez_liste_txt,
    MAX(A.gp_id) AS gp_id,
    SUM(A.umsatz_netto) AS umsatz_netto,
    SUM(A.menge) AS menge,
    SUM(A.ek_mep) AS ek_mep,
    SUM(A.logkostenzuschlag) AS logkostenzuschlag,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bonrabatt_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bonrabatt_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bonrabatt_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_bby_non_loyalty
FROM dbp_data.artbew AS A
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.kjwo_ww,
        COALESCE(B.dat, A0.dat) AS dat
    FROM dbp_data.werbewoche_kl AS A0
    LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B ON A0.kjwo_ww = B.kjwo_ww AND A0.mandant_id = B.mandant_id
    WHERE A0.mandant_id = 1
    GROUP BY
        A0.mandant_id,
        A0.kjwo_ww,
        dat
) AS f ON A.mandant_id = f.mandant_id AND A.dat = f.dat
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
    FROM `_hit_the_actions`
    WHERE kjwo = akt_woche
    GROUP BY
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
) AS g
    ON
        CAST(FLOOR(A.art_id / 100) AS INTEGER
        ) = g.kl_art_id AND A.mandant_id = g.mandant_id AND f.kjwo_ww = g.kjwo AND A.wup_id = g.wup_id
WHERE
    A.mandant_id = 1
    AND A.bewart_id = 1002
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.bewart_id,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _hilfe2 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.art_id,
    A.bewart_id,
    MAX(A.aktionsart_id_liste_txt) AS aktionsart_id_liste_txt,
    MAX(A.aktionsart_bez_liste_txt) AS aktionsart_bez_liste_txt,
    MAX(A.aktion_typ_id_liste_txt) AS aktion_typ_id_liste_txt,
    MAX(A.aktion_typ_bez_liste_txt) AS aktion_typ_bez_liste_txt,
    MAX(A.gp_id) AS gp_id,
    SUM(A.umsatz_netto) AS umsatz_netto,
    SUM(A.menge) AS menge,
    SUM(A.ek_mep) AS ek_mep,
    SUM(A.logkostenzuschlag) AS logkostenzuschlag,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bonrabatt_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bonrabatt_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bonrabatt_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_bby_non_loyalty
FROM dbp_data.artbew AS A
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.kjwo_ww,
        A0.akt_kjwo_ww,
        COALESCE(B.dat, A0.dat) AS dat
    FROM dbp_data.werbewoche_kl AS A0
    LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B ON A0.kjwo_ww = B.kjwo_ww AND A0.mandant_id = B.mandant_id
    WHERE A0.mandant_id = 1
    GROUP BY
        A0.mandant_id,
        A0.kjwo_ww,
        A0.akt_kjwo_ww,
        dat
) AS f ON A.mandant_id = f.mandant_id AND A.dat = f.dat
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
    FROM `_hit_the_actions`
    WHERE kjwo <> akt_woche
    GROUP BY
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
) AS g
    ON
        CAST(FLOOR(A.art_id / 100) AS INTEGER
        ) = g.kl_art_id AND A.mandant_id = g.mandant_id AND f.kjwo_ww = g.kjwo AND A.wup_id = g.wup_id
WHERE
    A.mandant_id = 1
    AND A.bewart_id = 1002
    AND f.akt_kjwo_ww = aw - 1
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.bewart_id,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _hilfe3 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.art_id,
    A.bewart_id,
    MAX(A.aktionsart_id_liste_txt) AS aktionsart_id_liste_txt,
    MAX(A.aktionsart_bez_liste_txt) AS aktionsart_bez_liste_txt,
    MAX(A.aktion_typ_id_liste_txt) AS aktion_typ_id_liste_txt,
    MAX(A.aktion_typ_bez_liste_txt) AS aktion_typ_bez_liste_txt,
    MAX(A.gp_id) AS gp_id,
    SUM(A.umsatz_netto) AS umsatz_netto,
    SUM(A.menge) AS menge,
    SUM(A.ek_mep) AS ek_mep,
    SUM(A.logkostenzuschlag) AS logkostenzuschlag,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bonrabatt_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bonrabatt_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bonrabatt_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_bby_non_loyalty
FROM dbp_data.artbew AS A
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.kjwo_ww,
        COALESCE(B.dat, A0.dat) AS dat
    FROM dbp_data.werbewoche_kl AS A0
    LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B ON A0.kjwo_ww = B.kjwo_ww AND A0.mandant_id = B.mandant_id
    WHERE A0.mandant_id = 1
    GROUP BY
        A0.mandant_id,
        A0.kjwo_ww,
        dat
) AS f ON A.mandant_id = f.mandant_id AND A.dat = f.dat
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
    FROM `_hit_the_actions`
    WHERE kjwo = akt_woche
    GROUP BY
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
) AS g
    ON
        CAST(FLOOR(A.art_id / 100) AS INTEGER
        ) = g.kl_art_id AND A.mandant_id = g.mandant_id AND f.kjwo_ww = g.kjwo AND A.wup_id = g.wup_id
WHERE
    A.mandant_id = 1
    AND A.bewart_id = 1002
    AND A.aktion_id = '999999999'
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.bewart_id,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _hilfe4 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.art_id,
    A.bewart_id,
    MAX(A.aktionsart_id_liste_txt) AS aktionsart_id_liste_txt,
    MAX(A.aktionsart_bez_liste_txt) AS aktionsart_bez_liste_txt,
    MAX(A.aktion_typ_id_liste_txt) AS aktion_typ_id_liste_txt,
    MAX(A.aktion_typ_bez_liste_txt) AS aktion_typ_bez_liste_txt,
    MAX(A.gp_id) AS gp_id,
    SUM(A.umsatz_netto) AS umsatz_netto,
    SUM(A.menge) AS menge,
    SUM(A.ek_mep) AS ek_mep,
    SUM(A.logkostenzuschlag) AS logkostenzuschlag,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.umsatz_netto
        ELSE 0
    END) AS umsatz_netto_sa_bonrabatt_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.menge
        ELSE 0
    END) AS menge_sa_bonrabatt_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.ek_mep
        ELSE 0
    END) AS ek_mep_sa_bonrabatt_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS logkostenzuschlag_sa_bby_non_loyalty
FROM dbp_data.artbew AS A
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.kjwo_ww,
        A0.akt_kjwo_ww,
        COALESCE(B.dat, A0.dat) AS dat
    FROM dbp_data.werbewoche_kl AS A0
    LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B ON A0.kjwo_ww = B.kjwo_ww AND A0.mandant_id = B.mandant_id
    WHERE A0.mandant_id = 1
    GROUP BY
        A0.mandant_id,
        A0.kjwo_ww,
        A0.akt_kjwo_ww,
        dat
) AS f ON A.mandant_id = f.mandant_id AND A.dat = f.dat
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
    FROM `_hit_the_actions`
    WHERE kjwo <> akt_woche
    GROUP BY
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
) AS g
    ON
        CAST(FLOOR(A.art_id / 100) AS INTEGER
        ) = g.kl_art_id AND A.mandant_id = g.mandant_id AND f.kjwo_ww = g.kjwo AND A.wup_id = g.wup_id
WHERE
    A.mandant_id = 1
    AND A.bewart_id = 1002
    AND f.akt_kjwo_ww = aw - 1
    AND A.aktion_id = '999999999'
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.bewart_id,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _hilfe11 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.art_id,
    A.bewart_id,
    SUM(CASE
        WHEN A.bewart_id = 1002
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa,
    SUM(CASE
        WHEN A.bewart_id = 1002 AND E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_west,
    SUM(CASE
        WHEN A.bewart_id = 1002 AND E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_ost,
    SUM(CASE
        WHEN A.bewart_id = 1002 AND E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_sued,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty
FROM dbp_data.artbew_dat_ek_cp_sum AS A
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.kjwo_ww,
        COALESCE(B.dat, A0.dat) AS dat
    FROM dbp_data.werbewoche_kl AS A0
    LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B ON A0.kjwo_ww = B.kjwo_ww AND A0.mandant_id = B.mandant_id
    WHERE A0.mandant_id = 1
    GROUP BY
        A0.mandant_id,
        A0.kjwo_ww,
        dat
) AS f ON A.mandant_id = f.mandant_id AND A.dat = f.dat
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
    FROM `_hit_the_actions`
    WHERE kjwo = akt_woche
    GROUP BY
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
) AS g
    ON
        CAST(FLOOR(A.art_id / 100) AS INTEGER
        ) = g.kl_art_id AND A.mandant_id = g.mandant_id AND f.kjwo_ww = g.kjwo AND A.wup_id = g.wup_id
INNER JOIN dbp_data.wup AS E ON A.mandant_id = E.mandant_id AND A.wup_id = E.wup_id
WHERE
    A.mandant_id = 1
    AND A.bewart_id = 1002
    AND A.wup_bereinigt_fg = 0
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.art_id,
    A.bewart_id
HAVING COALESCE(wa_kalk_abschriften_sa, 0) <> 0 OR COALESCE(wa_kalk_abschriften_sa_loyalty, 0) <> 0;


CREATE OR REPLACE TEMPORARY TABLE _hilfe22 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.art_id,
    A.bewart_id,
    SUM(CASE
        WHEN A.bewart_id = 1002
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa,
    SUM(CASE
        WHEN A.bewart_id = 1002 AND E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_west,
    SUM(CASE
        WHEN A.bewart_id = 1002 AND E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_ost,
    SUM(CASE
        WHEN A.bewart_id = 1002 AND E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_sued,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211, 100221, 100231, 100241, 100251)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100211)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_aktion_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100221)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100231)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_kdn_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100241)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_kdp_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100251)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210, 100220, 100250)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100210)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_aktion_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100220)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_bby_non_loyalty,
    SUM(CASE
        WHEN A.bewart_det_id IN (100250)
            THEN A.preis_abschrift_netto
        ELSE 0
    END) AS wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty
FROM dbp_data.artbew_dat_ek_cp_sum AS A
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.kjwo_ww,
        A0.akt_kjwo_ww,
        COALESCE(B.dat, A0.dat) AS dat
    FROM dbp_data.werbewoche_kl AS A0
    LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B ON A0.kjwo_ww = B.kjwo_ww AND A0.mandant_id = B.mandant_id
    WHERE A0.mandant_id = 1
    GROUP BY
        A0.mandant_id,
        A0.kjwo_ww,
        A0.akt_kjwo_ww,
        dat
) AS f ON A.mandant_id = f.mandant_id AND A.dat = f.dat
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
    FROM `_hit_the_actions`
    WHERE kjwo <> akt_woche
    GROUP BY
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
) AS g
    ON
        CAST(FLOOR(A.art_id / 100) AS INTEGER
        ) = g.kl_art_id AND A.mandant_id = g.mandant_id AND f.kjwo_ww = g.kjwo AND A.wup_id = g.wup_id
INNER JOIN dbp_data.wup AS E ON A.mandant_id = E.mandant_id AND A.wup_id = E.wup_id
WHERE
    A.mandant_id = 1
    AND A.bewart_id = 1002
    AND f.akt_kjwo_ww = aw - 1
    AND A.wup_bereinigt_fg = 0
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.dat,
    A.art_id,
    A.bewart_id
HAVING COALESCE(wa_kalk_abschriften_sa, 0) <> 0 OR COALESCE(wa_kalk_abschriften_sa_loyalty, 0) <> 0;


CREATE OR REPLACE TEMPORARY TABLE _artbew1 AS
SELECT
    A.mandant_id,
    f.kjwo_ww,
    A.art_id,
    g.art_id AS mutter_art_id,
    g.muki,
    A.wup_id,
    A.gp_id,
    A.aktionsart_id_liste_txt,
    A.aktionsart_bez_liste_txt,
    A.aktion_typ_id_liste_txt,
    A.aktion_typ_bez_liste_txt,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.umsatz_netto
        ELSE 0
    END AS umsatz_netto_sa_west,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.menge
        ELSE 0
    END AS absatz_sa_west,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.ek_mep
        ELSE 0
    END AS ek_mep_sa_west,
    CASE
        WHEN
            B.wg_id IN (
                161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                'N',
                'W'
            )
            THEN A.logkostenzuschlag
        ELSE 0
    END AS logkostenzuschlag_sa_west_wg30,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.logkostenzuschlag
        ELSE 0
    END AS logkostenzuschlag_sa_west,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.umsatz_netto
        ELSE 0
    END - (CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.ek_mep
        ELSE 0
    END + CASE
        WHEN
            B.wg_id IN (
                161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                'N',
                'W'
            )
            THEN A.logkostenzuschlag
        ELSE 0
    END - CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS rohertrag_sa_west,
    (CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.umsatz_netto
        ELSE 0
    END - (CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.ek_mep
        ELSE 0
    END + CASE
        WHEN
            B.wg_id IN (
                161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                'N',
                'W'
            )
            THEN A.logkostenzuschlag
        ELSE 0
    END - CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.logkostenzuschlag
        ELSE 0
    END)) / IF(CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.umsatz_netto
        ELSE 0
    END = 0, NULL, CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.umsatz_netto
        ELSE 0
    END) * 100 AS spanne_sa_west,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN COALESCE(t7.abschriftenbetrag_netto, 0)
        ELSE 0
    END AS preisvorteil_west,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.umsatz_netto
        ELSE 0
    END - (CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.ek_mep
        ELSE 0
    END + CASE
        WHEN
            B.wg_id IN (
                161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                'N',
                'W'
            )
            THEN A.logkostenzuschlag
        ELSE 0
    END - CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.logkostenzuschlag
        ELSE 0
    END) - I.wa_kalk_abschriften_sa_west AS wa_kalk_nach_pv_sa_west,
    (CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.umsatz_netto
        ELSE 0
    END - (CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.ek_mep
        ELSE 0
    END + CASE
        WHEN
            B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
            ('N', 'W')
            THEN A.logkostenzuschlag
        ELSE 0
    END - CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.logkostenzuschlag
        ELSE 0
    END) - I.wa_kalk_abschriften_sa_west) / IF(CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.umsatz_netto
        ELSE 0
    END = 0, NULL, CASE
        WHEN E.kreistyp_gruppe_id IN ('N', 'W')
            THEN A.umsatz_netto
        ELSE 0
    END) * 100 AS spanne_wa_kalk_nach_pv_sa_west,
    I.wa_kalk_abschriften_sa_west,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.umsatz_netto
        ELSE 0
    END AS umsatz_netto_sa_ost,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.menge
        ELSE 0
    END AS absatz_sa_ost,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.ek_mep
        ELSE 0
    END AS ek_mep_sa_ost,
    CASE
        WHEN
            B.wg_id IN (
                161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                'O',
                'Q'
            )
            THEN A.logkostenzuschlag
        ELSE 0
    END AS logkostenzuschlag_sa_ost_wg30,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.logkostenzuschlag
        ELSE 0
    END AS logkostenzuschlag_sa_ost,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.umsatz_netto
        ELSE 0
    END - (CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.ek_mep
        ELSE 0
    END + CASE
        WHEN
            B.wg_id IN (
                161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                'O',
                'Q'
            )
            THEN A.logkostenzuschlag
        ELSE 0
    END - CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS rohertrag_sa_ost,
    (CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.umsatz_netto
        ELSE 0
    END - (CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.ek_mep
        ELSE 0
    END + CASE
        WHEN
            B.wg_id IN (
                161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                'O',
                'Q'
            )
            THEN A.logkostenzuschlag
        ELSE 0
    END - CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.logkostenzuschlag
        ELSE 0
    END)) / IF(CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.umsatz_netto
        ELSE 0
    END = 0, NULL, CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.umsatz_netto
        ELSE 0
    END) * 100 AS spanne_sa_ost,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN COALESCE(t7.abschriftenbetrag_netto, 0)
        ELSE 0
    END AS preisvorteil_ost,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.umsatz_netto
        ELSE 0
    END - (CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.ek_mep
        ELSE 0
    END + CASE
        WHEN
            B.wg_id IN (
                161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                'O',
                'Q'
            )
            THEN A.logkostenzuschlag
        ELSE 0
    END - CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.logkostenzuschlag
        ELSE 0
    END) - I.wa_kalk_abschriften_sa_ost AS wa_kalk_nach_pv_sa_ost,
    (CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.umsatz_netto
        ELSE 0
    END - (CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.ek_mep
        ELSE 0
    END + CASE
        WHEN
            B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
            ('O', 'Q')
            THEN A.logkostenzuschlag
        ELSE 0
    END - CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.logkostenzuschlag
        ELSE 0
    END) - I.wa_kalk_abschriften_sa_ost) / IF(CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.umsatz_netto
        ELSE 0
    END = 0, NULL, CASE
        WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
            THEN A.umsatz_netto
        ELSE 0
    END) * 100 AS spanne_wa_kalk_nach_pv_sa_ost,
    I.wa_kalk_abschriften_sa_ost,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.umsatz_netto
        ELSE 0
    END AS umsatz_netto_sa_sued,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.menge
        ELSE 0
    END AS absatz_sa_sued,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.ek_mep
        ELSE 0
    END AS ek_mep_sa_sued,
    CASE
        WHEN
            B.wg_id IN (
                161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                'G',
                'M'
            )
            THEN A.logkostenzuschlag
        ELSE 0
    END AS logkostenzuschlag_sa_sued_wg30,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.logkostenzuschlag
        ELSE 0
    END AS logkostenzuschlag_sa_sued,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.umsatz_netto
        ELSE 0
    END - (CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.ek_mep
        ELSE 0
    END + CASE
        WHEN
            B.wg_id IN (
                161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                'G',
                'M'
            )
            THEN A.logkostenzuschlag
        ELSE 0
    END - CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.logkostenzuschlag
        ELSE 0
    END) AS rohertrag_sa_sued,
    (CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.umsatz_netto
        ELSE 0
    END - (CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.ek_mep
        ELSE 0
    END + CASE
        WHEN
            B.wg_id IN (
                161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                'G',
                'M'
            )
            THEN A.logkostenzuschlag
        ELSE 0
    END - CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.logkostenzuschlag
        ELSE 0
    END)) / IF(CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.umsatz_netto
        ELSE 0
    END = 0, NULL, CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.umsatz_netto
        ELSE 0
    END) * 100 AS spanne_sa_sued,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN COALESCE(t7.abschriftenbetrag_netto, 0)
        ELSE 0
    END AS preisvorteil_sued,
    CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.umsatz_netto
        ELSE 0
    END - (CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.ek_mep
        ELSE 0
    END + CASE
        WHEN
            B.wg_id IN (
                161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                'G',
                'M'
            )
            THEN A.logkostenzuschlag
        ELSE 0
    END - CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.logkostenzuschlag
        ELSE 0
    END) - I.wa_kalk_abschriften_sa_sued AS wa_kalk_nach_pv_sa_sued,
    (CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.umsatz_netto
        ELSE 0
    END - (CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.ek_mep
        ELSE 0
    END + CASE
        WHEN
            B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
            ('G', 'M')
            THEN A.logkostenzuschlag
        ELSE 0
    END - CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.logkostenzuschlag
        ELSE 0
    END) - I.wa_kalk_abschriften_sa_sued) / IF(CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.umsatz_netto
        ELSE 0
    END = 0, NULL, CASE
        WHEN E.kreistyp_gruppe_id IN ('G', 'M')
            THEN A.umsatz_netto
        ELSE 0
    END) * 100 AS spanne_wa_kalk_nach_pv_sa_sued,
    I.wa_kalk_abschriften_sa_sued,
    A.umsatz_netto AS umsatz_netto_sa,
    A.menge AS absatz_sa,
    A.ek_mep AS ek_mep_sa,
    CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag
        ELSE 0
    END AS logkostenzuschlag_sa_wg30,
    A.logkostenzuschlag AS logkostenzuschlag_sa,
    A.umsatz_netto - (A.ek_mep + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag
        ELSE 0
    END - A.logkostenzuschlag) AS rohertrag_sa,
    IF((A.umsatz_netto - (A.ek_mep + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag
        ELSE 0
    END - A.logkostenzuschlag)) / IF(A.umsatz_netto = 0, NULL, A.umsatz_netto) = 0, NULL, (A.umsatz_netto - (A.ek_mep
    + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag
        ELSE 0
    END - A.logkostenzuschlag)) / IF(A.umsatz_netto = 0, NULL, A.umsatz_netto)) * 100 AS spanne_sa,
    COALESCE(t7.abschriftenbetrag_netto, 0) AS preisvorteil,
    A.umsatz_netto - (A.ek_mep + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag
        ELSE 0
    END - A.logkostenzuschlag) - I.wa_kalk_abschriften_sa AS wa_kalk_nach_pv_sa,
    (A.umsatz_netto - (A.ek_mep + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag
        ELSE 0
    END - A.logkostenzuschlag) - I.wa_kalk_abschriften_sa) / IF(A.umsatz_netto = 0, NULL, A.umsatz_netto) * 100 AS
    spanne_wa_kalk_nach_pv_sa,
    I.wa_kalk_abschriften_sa,
    -- sa_loyalty-------------
    A.umsatz_netto_sa_loyalty,
    A.menge_sa_loyalty AS absatz_sa_loyalty,
    A.ek_mep_sa_loyalty,
    CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_loyalty
        ELSE 0
    END AS logkostenzuschlag_sa_loyalty_wg30,
    A.logkostenzuschlag_sa_loyalty,
    A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_loyalty) AS rohertrag_sa_loyalty,
    (A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_loyalty)) / IF(A.umsatz_netto_sa_loyalty = 0, NULL, A.umsatz_netto_sa_loyalty) *
    100 AS spanne_sa_loyalty,
    A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_loyalty) - I.wa_kalk_abschriften_sa_loyalty AS wa_kalk_nach_pv_sa_loyalty,
    (A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_loyalty) - I.wa_kalk_abschriften_sa_loyalty) / IF(A.umsatz_netto_sa_loyalty = 0,
    NULL, A.umsatz_netto_sa_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_loyalty,
    I.wa_kalk_abschriften_sa_loyalty,
    -- sa_aktion_loyalty-------------
    A.umsatz_netto_sa_aktion_loyalty,
    A.menge_sa_aktion_loyalty AS absatz_sa_aktion_loyalty,
    A.ek_mep_sa_aktion_loyalty,
    CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_aktion_loyalty
        ELSE 0
    END AS logkostenzuschlag_sa_aktion_loyalty_wg30,
    A.logkostenzuschlag_sa_aktion_loyalty,
    A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_aktion_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_aktion_loyalty) AS rohertrag_sa_aktion_loyalty,
    (A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_aktion_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_aktion_loyalty)) / IF(A.umsatz_netto_sa_aktion_loyalty = 0, NULL, A.umsatz_netto_sa_aktion_loyalty
    ) * 100 AS spanne_sa_aktion_loyalty,
    A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_aktion_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_aktion_loyalty) - I.wa_kalk_abschriften_sa_aktion_loyalty AS
    wa_kalk_nach_pv_sa_aktion_loyalty,
    (A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_aktion_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_aktion_loyalty) - I.wa_kalk_abschriften_sa_aktion_loyalty) / IF(A.umsatz_netto_sa_aktion_loyalty
    = 0, NULL, A.umsatz_netto_sa_aktion_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_aktion_loyalty,
    I.wa_kalk_abschriften_sa_aktion_loyalty,
    -- sa_bby_loyalty -------------
    A.umsatz_netto_sa_bby_loyalty,
    A.menge_sa_bby_loyalty AS absatz_sa_bby_loyalty,
    A.ek_mep_sa_bby_loyalty,
    CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_loyalty
        ELSE 0
    END AS logkostenzuschlag_sa_bby_loyalty_wg30,
    A.logkostenzuschlag_sa_bby_loyalty,
    A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bby_loyalty) AS rohertrag_sa_bby_loyalty,
    (A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bby_loyalty)) / IF(A.umsatz_netto_sa_bby_loyalty = 0, NULL, A.umsatz_netto_sa_bby_loyalty
    ) * 100 AS spanne_sa_bby_loyalty,
    A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bby_loyalty) - I.wa_kalk_abschriften_sa_bby_loyalty AS
    wa_kalk_nach_pv_sa_bby_loyalty,
    (A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bby_loyalty) - I.wa_kalk_abschriften_sa_bby_loyalty) / IF(A.umsatz_netto_sa_bby_loyalty
    = 0, NULL, A.umsatz_netto_sa_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_bby_loyalty,
    I.wa_kalk_abschriften_sa_bby_loyalty,
    -- sa_kdn_bby_loyalty -------------
    A.umsatz_netto_sa_kdn_bby_loyalty,
    A.menge_sa_kdn_bby_loyalty AS absatz_sa_kdn_bby_loyalty,
    A.ek_mep_sa_kdn_bby_loyalty,
    CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
        ELSE 0
    END AS logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
    A.logkostenzuschlag_sa_kdn_bby_loyalty,
    A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_kdn_bby_loyalty) AS rohertrag_sa_kdn_bby_loyalty,
    (A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_kdn_bby_loyalty)) / IF(A.umsatz_netto_sa_kdn_bby_loyalty = 0, NULL, A.umsatz_netto_sa_kdn_bby_loyalty
    ) * 100 AS spanne_sa_kdn_bby_loyalty,
    A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_kdn_bby_loyalty) - I.wa_kalk_abschriften_sa_kdn_bby_loyalty AS
    wa_kalk_nach_pv_sa_kdn_bby_loyalty,
    (A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_kdn_bby_loyalty) - I.wa_kalk_abschriften_sa_kdn_bby_loyalty) / IF(A.umsatz_netto_sa_kdn_bby_loyalty
    = 0, NULL, A.umsatz_netto_sa_kdn_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty,
    I.wa_kalk_abschriften_sa_kdn_bby_loyalty,
    -- sa_kdp_bby_loyalty -------------
    A.umsatz_netto_sa_kdp_bby_loyalty,
    A.menge_sa_kdp_bby_loyalty AS absatz_sa_kdp_bby_loyalty,
    A.ek_mep_sa_kdp_bby_loyalty,
    CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
        ELSE 0
    END AS logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
    A.logkostenzuschlag_sa_kdp_bby_loyalty,
    A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_kdp_bby_loyalty) AS rohertrag_sa_kdp_bby_loyalty,
    (A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_kdp_bby_loyalty)) / IF(A.umsatz_netto_sa_kdp_bby_loyalty = 0, NULL, A.umsatz_netto_sa_kdp_bby_loyalty
    ) * 100 AS spanne_sa_kdp_bby_loyalty,
    A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_kdp_bby_loyalty) - I.wa_kalk_abschriften_sa_kdp_bby_loyalty AS
    wa_kalk_nach_pv_sa_kdp_bby_loyalty,
    (A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_kdp_bby_loyalty) - I.wa_kalk_abschriften_sa_kdp_bby_loyalty) / IF(A.umsatz_netto_sa_kdp_bby_loyalty
    = 0, NULL, A.umsatz_netto_sa_kdp_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty,
    I.wa_kalk_abschriften_sa_kdp_bby_loyalty,
    -- sa_non_loyalty -------------
    A.umsatz_netto_sa_non_loyalty,
    A.menge_sa_non_loyalty AS absatz_sa_non_loyalty,
    A.ek_mep_sa_non_loyalty,
    CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_non_loyalty
        ELSE 0
    END AS logkostenzuschlag_sa_non_loyalty_wg30,
    A.logkostenzuschlag_sa_non_loyalty,
    A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_non_loyalty) AS rohertrag_sa_non_loyalty,
    (A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_non_loyalty)) / IF(A.umsatz_netto_sa_non_loyalty = 0, NULL, A.umsatz_netto_sa_non_loyalty
    ) * 100 AS spanne_sa_non_loyalty,
    A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_non_loyalty) - I.wa_kalk_abschriften_sa_non_loyalty AS
    wa_kalk_nach_pv_sa_non_loyalty,
    (A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_non_loyalty) - I.wa_kalk_abschriften_sa_non_loyalty) / IF(A.umsatz_netto_sa_non_loyalty
    = 0, NULL, A.umsatz_netto_sa_non_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_non_loyalty,
    I.wa_kalk_abschriften_sa_non_loyalty,
    -- sa_aktion_non_loyalty -------------
    A.umsatz_netto_sa_aktion_non_loyalty,
    A.menge_sa_aktion_non_loyalty AS absatz_sa_aktion_non_loyalty,
    A.ek_mep_sa_aktion_non_loyalty,
    CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_aktion_non_loyalty
        ELSE 0
    END AS logkostenzuschlag_sa_aktion_non_loyalty_wg30,
    A.logkostenzuschlag_sa_aktion_non_loyalty,
    A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_aktion_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_aktion_non_loyalty) AS rohertrag_sa_aktion_non_loyalty,
    (A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_aktion_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_aktion_non_loyalty)) / IF(A.umsatz_netto_sa_aktion_non_loyalty = 0, NULL, A.umsatz_netto_sa_aktion_non_loyalty
    ) * 100 AS spanne_sa_aktion_non_loyalty,
    A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_aktion_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_aktion_non_loyalty) - I.wa_kalk_abschriften_sa_aktion_non_loyalty AS
    wa_kalk_nach_pv_sa_aktion_non_loyalty,
    (A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_aktion_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_aktion_non_loyalty) - I.wa_kalk_abschriften_sa_aktion_non_loyalty) / IF(A.umsatz_netto_sa_aktion_non_loyalty
    = 0, NULL, A.umsatz_netto_sa_aktion_non_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty,
    I.wa_kalk_abschriften_sa_aktion_non_loyalty,
    -- sa_bby_non_loyalty -------------
    A.umsatz_netto_sa_bby_non_loyalty,
    A.menge_sa_bby_non_loyalty AS absatz_sa_bby_non_loyalty,
    A.ek_mep_sa_bby_non_loyalty,
    CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_non_loyalty
        ELSE 0
    END AS logkostenzuschlag_sa_bby_non_loyalty_wg30,
    A.logkostenzuschlag_sa_bby_non_loyalty,
    A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bby_non_loyalty) AS rohertrag_sa_bby_non_loyalty,
    (A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bby_non_loyalty)) / IF(A.umsatz_netto_sa_bby_non_loyalty = 0, NULL, A.umsatz_netto_sa_bby_non_loyalty
    ) * 100 AS spanne_sa_bby_non_loyalty,
    A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bby_non_loyalty AS
    wa_kalk_nach_pv_sa_bby_non_loyalty,
    (A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bby_non_loyalty) / IF(A.umsatz_netto_sa_bby_non_loyalty
    = 0, NULL, A.umsatz_netto_sa_bby_non_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_bby_non_loyalty,
    I.wa_kalk_abschriften_sa_bby_non_loyalty,
    -- sa_bonrabatt_bby_loyalty -------------
    A.umsatz_netto_sa_bonrabatt_bby_loyalty,
    A.menge_sa_bonrabatt_bby_loyalty AS absatz_sa_bonrabatt_bby_loyalty,
    A.ek_mep_sa_bonrabatt_bby_loyalty,
    CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_loyalty
        ELSE 0
    END AS logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
    A.logkostenzuschlag_sa_bonrabatt_bby_loyalty,
    A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) AS rohertrag_sa_bonrabatt_bby_loyalty,
    (A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty)) / IF(A.umsatz_netto_sa_bonrabatt_bby_loyalty = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_loyalty) * 100 AS spanne_sa_bonrabatt_bby_loyalty,
    A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty AS
    wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
    (A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty) / IF(A.umsatz_netto_sa_bonrabatt_bby_loyalty
    = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
    I.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
    -- sa_bonrabatt_bby_non_loyalty -------------
    A.umsatz_netto_sa_bonrabatt_bby_non_loyalty,
    A.menge_sa_bonrabatt_bby_non_loyalty AS absatz_sa_bonrabatt_bby_non_loyalty,
    A.ek_mep_sa_bonrabatt_bby_non_loyalty,
    CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_non_loyalty
        ELSE 0
    END AS logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
    A.logkostenzuschlag_sa_bby_non_loyalty AS logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
    A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bby_non_loyalty) AS rohertrag_sa_bonrabatt_bby_non_loyalty,
    (A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bby_non_loyalty)) / IF(A.umsatz_netto_sa_bonrabatt_bby_non_loyalty = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_non_loyalty
    ) * 100 AS spanne_sa_bonrabatt_bby_non_loyalty,
    A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty AS
    wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
    (A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
        WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
            THEN A.logkostenzuschlag_sa_bby_non_loyalty
        ELSE 0
    END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty) / IF(A.umsatz_netto_sa_bonrabatt_bby_non_loyalty
    = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_non_loyalty) * 100 AS
    spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
    I.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
    j.pv_aktion_loy,
    j.pv_aktion_non_loy,
    j.pv_bby_loy,
    j.pv_bby_non_loy,
    j.pv_kdn_bby,
    j.pv_kdp_bby,
    j.pv_bonrabatt_bby_loy,
    j.pv_bonrabatt_bby_non_loy,
    B.wg_id,
    C.owg_id,
    D.hwg_id,
    C.abt_id
FROM `_hilfe1` AS A
INNER JOIN dbp_data.art_wg_zu_per AS B
    ON
        A.art_id = B.art_id AND A.mandant_id = B.mandant_id AND B.dat_bis
        = DATE '9999-12-31' AND B.arthiertyp_id = 2
INNER JOIN dbp_data.wg_per AS C
    ON
        A.mandant_id = C.mandant_id AND B.wg_id = C.wg_id AND C.dat_bis =
        DATE '9999-12-31' AND C.arthiertyp_id = 2
INNER JOIN dbp_data.owg_per AS D
    ON
        A.mandant_id = D.mandant_id AND C.owg_id = D.owg_id AND D.dat_bis =
        DATE '9999-12-31' AND D.arthiertyp_id = 2
INNER JOIN dbp_data.wup AS E ON A.mandant_id = E.mandant_id AND A.wup_id = E.wup_id
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.kjwo_ww,
        COALESCE(B0.dat, A0.dat) AS dat
    FROM dbp_data.werbewoche_kl AS A0
    LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B0
        ON
            A0.kjwo_ww = B0.kjwo_ww AND A0.mandant_id =
            B0.mandant_id
    WHERE A0.mandant_id = 1
    GROUP BY
        A0.mandant_id,
        A0.kjwo_ww,
        dat
) AS f ON A.mandant_id = f.mandant_id AND A.dat = f.dat
INNER JOIN (
    SELECT
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
    FROM `_hit_the_actions`
    WHERE kjwo = akt_woche
    GROUP BY
        mandant_id,
        wup_id,
        kjwo,
        art_id,
        kl_art_id,
        muki
) AS g
    ON
        CAST(FLOOR(A.art_id / 100) AS INTEGER
        ) = g.kl_art_id AND A.mandant_id = g.mandant_id AND f.kjwo_ww = g.kjwo AND A.wup_id = g.wup_id
LEFT JOIN (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        dat,
        SUM(abschriftenbetrag_netto) AS abschriftenbetrag_netto
    FROM dbp_msi_view2.mv_marktabschriften
    WHERE abschriftenart_id = -1
    GROUP BY
        mandant_id,
        wup_id,
        dat,
        art_id
) AS t7 ON A.art_id = t7.art_id AND A.mandant_id = t7.mandant_id AND A.wup_id = t7.wup_id AND A.dat = t7.dat
LEFT JOIN `_hilfe11` AS I ON A.art_id = I.art_id AND A.mandant_id = I.mandant_id AND A.wup_id = I.wup_id AND A.dat = I.dat
LEFT JOIN (
    SELECT
        V01.mandant_id,
        V01.wup_id,
        V01.art_id,
        V01.dat,
        SUM(CASE
            WHEN V01.wv_grund_id = 2 AND V01.abschriftart_id = -1
                THEN V01.abschriftbetrag_netto
            ELSE 0
        END) AS pv_aktion_loy,
        SUM(CASE
            WHEN V01.wv_grund_id = 0 AND V01.abschriftart_id = -1
                THEN V01.abschriftbetrag_netto
            ELSE 0
        END) AS pv_aktion_non_loy,
        SUM(CASE
            WHEN
                V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54) AND V01.abschriftart_id = -1 OR V01.dat <
                DATE '2022-04-01' AND V01.wv_grund_id IN (52, 54, 54, 55) AND V01.abschriftart_id = -1
                THEN V01.abschriftbetrag_netto
            ELSE 0
        END) AS pv_bby_loy,
        SUM(CASE
            WHEN
                V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58) AND V01.abschriftart_id = -1 OR V01.dat <
                DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58, 59) AND V01.abschriftart_id = -1
                THEN V01.abschriftbetrag_netto
            ELSE 0
        END) AS pv_bby_non_loy,
        SUM(CASE
            WHEN
                V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62) AND V01.abschriftart_id = -1 OR V01.dat <
                DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62, 63) AND V01.abschriftart_id = -1
                THEN V01.abschriftbetrag_netto
            ELSE 0
        END) AS pv_kdn_bby,
        SUM(CASE
            WHEN
                V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 73, 74, 75) AND V01.abschriftart_id = -1 OR
                V01.dat < DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 67) AND V01.abschriftart_id = -1
                THEN V01.abschriftbetrag_netto
            ELSE 0
        END) AS pv_kdp_bby,
        SUM(CASE
            WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (59) AND V01.abschriftart_id = -1
                THEN V01.abschriftbetrag_netto
            ELSE 0
        END) AS pv_bonrabatt_bby_non_loy,
        SUM(CASE
            WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (55, 63, 67) AND V01.abschriftart_id = -1
                THEN V01.abschriftbetrag_netto
            ELSE 0
        END) AS pv_bonrabatt_bby_loy
    FROM dbp_data.marktabschriften AS V01
    LEFT JOIN (SELECT
        art_id,
        gp_id,
        wup_id,
        dat_von,
        dat_bis
    FROM dbp_data.art_gp_nm_zu_per
    WHERE mandant_id = 1) AS v02
        ON
            V01.art_id = v02.art_id AND V01.wup_id = v02.wup_id AND V01.dat BETWEEN v02.dat_von
            AND v02.dat_bis
    INNER JOIN (SELECT
        art_id,
        gewart_id
    FROM dbp_data.art
    WHERE mandant_id = 1) AS v03 ON V01.art_id = v03.art_id
    WHERE V01.mandant_id = 1
    GROUP BY
        V01.mandant_id,
        V01.wup_id,
        V01.art_id,
        V01.dat
) AS j ON A.art_id = j.art_id AND A.mandant_id = j.mandant_id AND A.wup_id = j.wup_id AND A.dat = j.dat
WHERE
    A.mandant_id = 1
    AND A.bewart_id = 1002;


INSERT INTO `_artbew1`
(
    SELECT
        A.mandant_id,
        f.kjwo_ww,
        A.art_id,
        g.art_id AS mutter_art_id,
        g.muki,
        A.wup_id,
        A.gp_id,
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END AS umsatz_netto_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.menge
            ELSE 0
        END AS absatz_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END AS ek_mep_sa_west,
        CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'N',
                    'W'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_west_wg30,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'N',
                    'W'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END) AS rohertrag_sa_west,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END)) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN COALESCE(t7.abschriftenbetrag_netto, 0)
            ELSE 0
        END AS preisvorteil_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'N',
                    'W'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_west AS wa_kalk_nach_pv_sa_west,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_west) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_wa_kalk_nach_pv_sa_west,
        I.wa_kalk_abschriften_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END AS umsatz_netto_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.menge
            ELSE 0
        END AS absatz_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END AS ek_mep_sa_ost,
        CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'O',
                    'Q'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_ost_wg30,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'O',
                    'Q'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END) AS rohertrag_sa_ost,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END)) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN COALESCE(t7.abschriftenbetrag_netto, 0)
            ELSE 0
        END AS preisvorteil_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'O',
                    'Q'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_ost AS wa_kalk_nach_pv_sa_ost,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_ost) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_wa_kalk_nach_pv_sa_ost,
        I.wa_kalk_abschriften_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END AS umsatz_netto_sa_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.menge
            ELSE 0
        END AS absatz_sa_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END AS ek_mep_sa_sued,
        CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'G',
                    'M'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_sued_wg30,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'G',
                    'M'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END) AS rohertrag_sa_sued,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END)) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_sa_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN COALESCE(t7.abschriftenbetrag_netto, 0)
            ELSE 0
        END AS preisvorteil_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'G',
                    'M'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_sued AS wa_kalk_nach_pv_sa_sued,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_sued) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_wa_kalk_nach_pv_sa_sued,
        I.wa_kalk_abschriften_sa_sued,
        A.umsatz_netto AS umsatz_netto_sa,
        A.menge AS absatz_sa,
        A.ek_mep AS ek_mep_sa,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_wg30,
        A.logkostenzuschlag AS logkostenzuschlag_sa,
        A.umsatz_netto - (A.ek_mep + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag) AS rohertrag_sa,
        IF((A.umsatz_netto - (A.ek_mep + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag)) / IF(A.umsatz_netto = 0, NULL, A.umsatz_netto) = 0, NULL, (A.umsatz_netto - (A.ek_mep
        + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag)) / IF(A.umsatz_netto = 0, NULL, A.umsatz_netto)) * 100 AS spanne_sa,
        COALESCE(t7.abschriftenbetrag_netto, 0) AS preisvorteil,
        A.umsatz_netto - (A.ek_mep + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag) - I.wa_kalk_abschriften_sa AS wa_kalk_nach_pv_sa,
        (A.umsatz_netto - (A.ek_mep + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag) - I.wa_kalk_abschriften_sa) / IF(A.umsatz_netto = 0, NULL, A.umsatz_netto) * 100
            AS spanne_wa_kalk_nach_pv_sa,
        I.wa_kalk_abschriften_sa,
        -- sa_loyalty-------------
        A.umsatz_netto_sa_loyalty,
        A.menge_sa_loyalty AS absatz_sa_loyalty,
        A.ek_mep_sa_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_loyalty_wg30,
        A.logkostenzuschlag_sa_loyalty,
        A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_loyalty) AS rohertrag_sa_loyalty,
        (A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_loyalty)) / IF(A.umsatz_netto_sa_loyalty = 0, NULL, A.umsatz_netto_sa_loyalty) *
        100 AS spanne_sa_loyalty,
        A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_loyalty) - I.wa_kalk_abschriften_sa_loyalty AS wa_kalk_nach_pv_sa_loyalty,
        (A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_loyalty) - I.wa_kalk_abschriften_sa_loyalty) / IF(A.umsatz_netto_sa_loyalty = 0,
        NULL, A.umsatz_netto_sa_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_loyalty,
        I.wa_kalk_abschriften_sa_loyalty,
        -- sa_aktion_loyalty-------------
        A.umsatz_netto_sa_aktion_loyalty,
        A.menge_sa_aktion_loyalty AS absatz_sa_aktion_loyalty,
        A.ek_mep_sa_aktion_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_aktion_loyalty_wg30,
        A.logkostenzuschlag_sa_aktion_loyalty,
        A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_loyalty) AS rohertrag_sa_aktion_loyalty,
        (A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_loyalty)) / IF(A.umsatz_netto_sa_aktion_loyalty = 0, NULL, A.umsatz_netto_sa_aktion_loyalty
        ) * 100 AS spanne_sa_aktion_loyalty,
        A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_loyalty) - I.wa_kalk_abschriften_sa_aktion_loyalty AS
        wa_kalk_nach_pv_sa_aktion_loyalty,
        (A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_loyalty) - I.wa_kalk_abschriften_sa_aktion_loyalty) / IF(A.umsatz_netto_sa_aktion_loyalty
        = 0, NULL, A.umsatz_netto_sa_aktion_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_aktion_loyalty,
        I.wa_kalk_abschriften_sa_aktion_loyalty,
        -- sa_bby_loyalty -------------
        A.umsatz_netto_sa_bby_loyalty,
        A.menge_sa_bby_loyalty AS absatz_sa_bby_loyalty,
        A.ek_mep_sa_bby_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_bby_loyalty_wg30,
        A.logkostenzuschlag_sa_bby_loyalty,
        A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_loyalty) AS rohertrag_sa_bby_loyalty,
        (A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_loyalty)) / IF(A.umsatz_netto_sa_bby_loyalty = 0, NULL, A.umsatz_netto_sa_bby_loyalty
        ) * 100 AS spanne_sa_bby_loyalty,
        A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_loyalty) - I.wa_kalk_abschriften_sa_bby_loyalty AS
        wa_kalk_nach_pv_sa_bby_loyalty,
        (A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_loyalty) - I.wa_kalk_abschriften_sa_bby_loyalty) / IF(A.umsatz_netto_sa_bby_loyalty
        = 0, NULL, A.umsatz_netto_sa_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_bby_loyalty,
        I.wa_kalk_abschriften_sa_bby_loyalty,
        -- sa_kdn_bby_loyalty -------------
        A.umsatz_netto_sa_kdn_bby_loyalty,
        A.menge_sa_kdn_bby_loyalty AS absatz_sa_kdn_bby_loyalty,
        A.ek_mep_sa_kdn_bby_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
        A.logkostenzuschlag_sa_kdn_bby_loyalty,
        A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdn_bby_loyalty) AS rohertrag_sa_kdn_bby_loyalty,
        (A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdn_bby_loyalty)) / IF(A.umsatz_netto_sa_kdn_bby_loyalty = 0, NULL, A.umsatz_netto_sa_kdn_bby_loyalty
        ) * 100 AS spanne_sa_kdn_bby_loyalty,
        A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdn_bby_loyalty) - I.wa_kalk_abschriften_sa_kdn_bby_loyalty AS
        wa_kalk_nach_pv_sa_kdn_bby_loyalty,
        (A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdn_bby_loyalty) - I.wa_kalk_abschriften_sa_kdn_bby_loyalty) / IF(A.umsatz_netto_sa_kdn_bby_loyalty
        = 0, NULL, A.umsatz_netto_sa_kdn_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty,
        I.wa_kalk_abschriften_sa_kdn_bby_loyalty,
        -- sa_kdp_bby_loyalty -------------
        A.umsatz_netto_sa_kdp_bby_loyalty,
        A.menge_sa_kdp_bby_loyalty AS absatz_sa_kdp_bby_loyalty,
        A.ek_mep_sa_kdp_bby_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
        A.logkostenzuschlag_sa_kdp_bby_loyalty,
        A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdp_bby_loyalty) AS rohertrag_sa_kdp_bby_loyalty,
        (A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdp_bby_loyalty)) / IF(A.umsatz_netto_sa_kdp_bby_loyalty = 0, NULL, A.umsatz_netto_sa_kdp_bby_loyalty
        ) * 100 AS spanne_sa_kdp_bby_loyalty,
        A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdp_bby_loyalty) - I.wa_kalk_abschriften_sa_kdp_bby_loyalty AS
        wa_kalk_nach_pv_sa_kdp_bby_loyalty,
        (A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdp_bby_loyalty) - I.wa_kalk_abschriften_sa_kdp_bby_loyalty) / IF(A.umsatz_netto_sa_kdp_bby_loyalty
        = 0, NULL, A.umsatz_netto_sa_kdp_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty,
        I.wa_kalk_abschriften_sa_kdp_bby_loyalty,
        -- sa_non_loyalty -------------
        A.umsatz_netto_sa_non_loyalty,
        A.menge_sa_non_loyalty AS absatz_sa_non_loyalty,
        A.ek_mep_sa_non_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_non_loyalty_wg30,
        A.logkostenzuschlag_sa_non_loyalty,
        A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_non_loyalty) AS rohertrag_sa_non_loyalty,
        (A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_non_loyalty)) / IF(A.umsatz_netto_sa_non_loyalty = 0, NULL, A.umsatz_netto_sa_non_loyalty
        ) * 100 AS spanne_sa_non_loyalty,
        A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_non_loyalty) - I.wa_kalk_abschriften_sa_non_loyalty AS
        wa_kalk_nach_pv_sa_non_loyalty,
        (A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_non_loyalty) - I.wa_kalk_abschriften_sa_non_loyalty) / IF(A.umsatz_netto_sa_non_loyalty
        = 0, NULL, A.umsatz_netto_sa_non_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_non_loyalty,
        I.wa_kalk_abschriften_sa_non_loyalty,
        -- sa_aktion_non_loyalty -------------
        A.umsatz_netto_sa_aktion_non_loyalty,
        A.menge_sa_aktion_non_loyalty AS absatz_sa_aktion_non_loyalty,
        A.ek_mep_sa_aktion_non_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_aktion_non_loyalty_wg30,
        A.logkostenzuschlag_sa_aktion_non_loyalty,
        A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_non_loyalty) AS rohertrag_sa_aktion_non_loyalty,
        (A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_non_loyalty)) / IF(A.umsatz_netto_sa_aktion_non_loyalty = 0, NULL, A.umsatz_netto_sa_aktion_non_loyalty
        ) * 100 AS spanne_sa_aktion_non_loyalty,
        A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_non_loyalty) - I.wa_kalk_abschriften_sa_aktion_non_loyalty AS
        wa_kalk_nach_pv_sa_aktion_non_loyalty,
        (A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_non_loyalty) - I.wa_kalk_abschriften_sa_aktion_non_loyalty) / IF(A.umsatz_netto_sa_aktion_non_loyalty
        = 0, NULL, A.umsatz_netto_sa_aktion_non_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty,
        I.wa_kalk_abschriften_sa_aktion_non_loyalty,
        -- sa_bby_non_loyalty -------------
        A.umsatz_netto_sa_bby_non_loyalty,
        A.menge_sa_bby_non_loyalty AS absatz_sa_bby_non_loyalty,
        A.ek_mep_sa_bby_non_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_bby_non_loyalty_wg30,
        A.logkostenzuschlag_sa_bby_non_loyalty,
        A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) AS rohertrag_sa_bby_non_loyalty,
        (A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty)) / IF(A.umsatz_netto_sa_bby_non_loyalty = 0, NULL, A.umsatz_netto_sa_bby_non_loyalty
        ) * 100 AS spanne_sa_bby_non_loyalty,
        A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bby_non_loyalty AS
        wa_kalk_nach_pv_sa_bby_non_loyalty,
        (A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bby_non_loyalty) / IF(A.umsatz_netto_sa_bby_non_loyalty
        = 0, NULL, A.umsatz_netto_sa_bby_non_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_bby_non_loyalty,
        I.wa_kalk_abschriften_sa_bby_non_loyalty,
        -- sa_bonrabatt_bby_loyalty -------------
        A.umsatz_netto_sa_bonrabatt_bby_loyalty,
        A.menge_sa_bonrabatt_bby_loyalty AS absatz_sa_bonrabatt_bby_loyalty,
        A.ek_mep_sa_bonrabatt_bby_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
        A.logkostenzuschlag_sa_bonrabatt_bby_loyalty,
        A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) AS rohertrag_sa_bonrabatt_bby_loyalty,
        (A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty)) / IF(A.umsatz_netto_sa_bonrabatt_bby_loyalty = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_loyalty) * 100 AS spanne_sa_bonrabatt_bby_loyalty,
        A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty AS
        wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
        (A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty) / IF(A.umsatz_netto_sa_bonrabatt_bby_loyalty = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_loyalty) * 100 AS
        spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
        I.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
        -- sa_bonrabatt_bby_non_loyalty -------------
        A.umsatz_netto_sa_bonrabatt_bby_non_loyalty,
        A.menge_sa_bonrabatt_bby_non_loyalty AS absatz_sa_bonrabatt_bby_non_loyalty,
        A.ek_mep_sa_bonrabatt_bby_non_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
        A.logkostenzuschlag_sa_bby_non_loyalty AS logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
        A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) AS rohertrag_sa_bonrabatt_bby_non_loyalty,
        (A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty)) / IF(A.umsatz_netto_sa_bonrabatt_bby_non_loyalty = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_non_loyalty
        ) * 100 AS spanne_sa_bonrabatt_bby_non_loyalty,
        A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty AS
        wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
        (A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty) / IF(A.umsatz_netto_sa_bonrabatt_bby_non_loyalty
        = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_non_loyalty) * 100 AS
        spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
        I.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
        j.pv_aktion_loy,
        j.pv_aktion_non_loy,
        j.pv_bby_loy,
        j.pv_bby_non_loy,
        j.pv_kdn_bby,
        j.pv_kdp_bby,
        j.pv_bonrabatt_bby_loy,
        j.pv_bonrabatt_bby_non_loy,
        B.wg_id,
        C.owg_id,
        D.hwg_id,
        C.abt_id
    FROM `_hilfe2` AS A
    INNER JOIN dbp_data.art_wg_zu_per AS B
        ON
            A.art_id = B.art_id AND A.mandant_id = B.mandant_id AND B.dat_bis
            = DATE '9999-12-31' AND B.arthiertyp_id = 2
    INNER JOIN dbp_data.wg_per AS C
        ON
            A.mandant_id = C.mandant_id AND B.wg_id = C.wg_id AND C.dat_bis =
            DATE '9999-12-31' AND C.arthiertyp_id = 2
    INNER JOIN dbp_data.owg_per AS D
        ON
            A.mandant_id = D.mandant_id AND C.owg_id = D.owg_id AND D.dat_bis =
            DATE '9999-12-31' AND D.arthiertyp_id = 2
    INNER JOIN dbp_data.wup AS E ON A.mandant_id = E.mandant_id AND A.wup_id = E.wup_id
    INNER JOIN (
        SELECT
            A0.mandant_id,
            A0.kjwo_ww,
            A0.akt_kjwo_ww,
            COALESCE(B0.dat, A0.dat) AS dat
        FROM dbp_data.werbewoche_kl AS A0
        LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B0
            ON
                A0.kjwo_ww = B0.kjwo_ww AND A0.mandant_id
                = B0.mandant_id
        WHERE A0.mandant_id = 1
        GROUP BY
            A0.mandant_id,
            A0.kjwo_ww,
            A0.akt_kjwo_ww,
            dat
    ) AS f ON A.mandant_id = f.mandant_id AND A.dat = f.dat
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            kjwo,
            art_id,
            kl_art_id,
            muki
        FROM `_hit_the_actions`
        WHERE kjwo <> akt_woche
        GROUP BY
            mandant_id,
            wup_id,
            kjwo,
            art_id,
            kl_art_id,
            muki
    ) AS g
        ON
            CAST(FLOOR(A.art_id / 100) AS INTEGER
            ) = g.kl_art_id AND A.mandant_id = g.mandant_id AND A.wup_id = g.wup_id
    LEFT JOIN (
        SELECT
            mandant_id,
            wup_id,
            art_id,
            dat,
            SUM(abschriftenbetrag_netto) AS abschriftenbetrag_netto
        FROM dbp_msi_view2.mv_marktabschriften
        WHERE abschriftenart_id = -1
        GROUP BY
            mandant_id,
            wup_id,
            dat,
            art_id
    ) AS t7 ON A.art_id = t7.art_id AND A.mandant_id = t7.mandant_id AND A.wup_id = t7.wup_id AND A.dat = t7.dat
    LEFT JOIN `_hilfe22` AS I ON A.art_id = I.art_id AND A.mandant_id = I.mandant_id AND A.wup_id = I.wup_id AND A.dat = I.dat
    LEFT JOIN (
        SELECT
            V01.mandant_id,
            V01.wup_id,
            V01.art_id,
            V01.dat,
            SUM(CASE
                WHEN V01.wv_grund_id = 2 AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_aktion_loy,
            SUM(CASE
                WHEN V01.wv_grund_id = 0 AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_aktion_non_loy,
            SUM(CASE
                WHEN
                    V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54) AND V01.abschriftart_id = -1 OR V01.dat <
                    DATE '2022-04-01' AND V01.wv_grund_id IN (52, 54, 54, 55) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_bby_loy,
            SUM(CASE
                WHEN
                    V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58) AND V01.abschriftart_id = -1 OR V01.dat <
                    DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58, 59) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_bby_non_loy,
            SUM(CASE
                WHEN
                    V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62) AND V01.abschriftart_id = -1 OR V01.dat <
                    DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62, 63) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_kdn_bby,
            SUM(CASE
                WHEN
                    V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 73, 74, 75) AND V01.abschriftart_id = -1 OR
                    V01.dat < DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 67) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_kdp_bby,
            SUM(CASE
                WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (59) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_bonrabatt_bby_non_loy,
            SUM(CASE
                WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (55, 63, 67) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_bonrabatt_bby_loy
        FROM dbp_data.marktabschriften AS V01
        LEFT JOIN (SELECT
            art_id,
            gp_id,
            wup_id,
            dat_von,
            dat_bis
        FROM dbp_data.art_gp_nm_zu_per
        WHERE mandant_id = 1) AS v02
            ON
                V01.art_id = v02.art_id AND V01.wup_id = v02.wup_id AND V01.dat BETWEEN v02.dat_von
                AND v02.dat_bis
        INNER JOIN (SELECT
            art_id,
            gewart_id
        FROM dbp_data.art
        WHERE mandant_id = 1) AS v03 ON V01.art_id = v03.art_id
        WHERE V01.mandant_id = 1
        GROUP BY
            V01.mandant_id,
            V01.wup_id,
            V01.art_id,
            V01.dat
    ) AS j ON A.art_id = j.art_id AND A.mandant_id = j.mandant_id AND A.wup_id = j.wup_id AND A.dat = j.dat
    WHERE
        A.mandant_id = 1
        AND A.bewart_id = 1002
        AND f.akt_kjwo_ww = aw - 1
);


INSERT INTO `_artbew1`
(
    SELECT
        A.mandant_id,
        f.kjwo_ww,
        A.art_id,
        g.art_id AS mutter_art_id,
        g.muki,
        A.wup_id,
        A.gp_id,
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END AS umsatz_netto_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.menge
            ELSE 0
        END AS absatz_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END AS ek_mep_sa_west,
        CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'N',
                    'W'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_west_wg30,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'N',
                    'W'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END) AS rohertrag_sa_west,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END)) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN COALESCE(t7.abschriftenbetrag_netto, 0)
            ELSE 0
        END AS preisvorteil_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'N',
                    'W'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_west AS wa_kalk_nach_pv_sa_west,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_west) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_wa_kalk_nach_pv_sa_west,
        I.wa_kalk_abschriften_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END AS umsatz_netto_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.menge
            ELSE 0
        END AS absatz_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END AS ek_mep_sa_ost,
        CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'O',
                    'Q'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_ost_wg30,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'O',
                    'Q'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END) AS rohertrag_sa_ost,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END)) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN COALESCE(t7.abschriftenbetrag_netto, 0)
            ELSE 0
        END AS preisvorteil_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'O',
                    'Q'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_ost AS wa_kalk_nach_pv_sa_ost,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_ost) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_wa_kalk_nach_pv_sa_ost,
        I.wa_kalk_abschriften_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END AS umsatz_netto_sa_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.menge
            ELSE 0
        END AS absatz_sa_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END AS ek_mep_sa_sued,
        CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'G',
                    'M'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_sued_wg30,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'G',
                    'M'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END) AS rohertrag_sa_sued,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END)) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_sa_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN COALESCE(t7.abschriftenbetrag_netto, 0)
            ELSE 0
        END AS preisvorteil_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'G',
                    'M'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_sued AS wa_kalk_nach_pv_sa_sued,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_sued) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_wa_kalk_nach_pv_sa_sued,
        I.wa_kalk_abschriften_sa_sued,
        A.umsatz_netto AS umsatz_netto_sa,
        A.menge AS absatz_sa,
        A.ek_mep AS ek_mep_sa,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_wg30,
        A.logkostenzuschlag AS logkostenzuschlag_sa,
        A.umsatz_netto - (A.ek_mep + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag) AS rohertrag_sa,
        IF((A.umsatz_netto - (A.ek_mep + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag)) / IF(A.umsatz_netto = 0, NULL, A.umsatz_netto) = 0, NULL, (A.umsatz_netto - (A.ek_mep
        + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag)) / IF(A.umsatz_netto = 0, NULL, A.umsatz_netto)) * 100 AS spanne_sa,
        COALESCE(t7.abschriftenbetrag_netto, 0) AS preisvorteil,
        A.umsatz_netto - (A.ek_mep + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag) - I.wa_kalk_abschriften_sa AS wa_kalk_nach_pv_sa,
        (A.umsatz_netto - (A.ek_mep + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag) - I.wa_kalk_abschriften_sa) / IF(A.umsatz_netto = 0, NULL, A.umsatz_netto) * 100
            AS spanne_wa_kalk_nach_pv_sa,
        I.wa_kalk_abschriften_sa,
        -- sa_loyalty-------------
        A.umsatz_netto_sa_loyalty,
        A.menge_sa_loyalty AS absatz_sa_loyalty,
        A.ek_mep_sa_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_loyalty_wg30,
        A.logkostenzuschlag_sa_loyalty,
        A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_loyalty) AS rohertrag_sa_loyalty,
        (A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_loyalty)) / IF(A.umsatz_netto_sa_loyalty = 0, NULL, A.umsatz_netto_sa_loyalty) *
        100 AS spanne_sa_loyalty,
        A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_loyalty) - I.wa_kalk_abschriften_sa_loyalty AS wa_kalk_nach_pv_sa_loyalty,
        (A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_loyalty) - I.wa_kalk_abschriften_sa_loyalty) / IF(A.umsatz_netto_sa_loyalty = 0,
        NULL, A.umsatz_netto_sa_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_loyalty,
        I.wa_kalk_abschriften_sa_loyalty,
        -- sa_aktion_loyalty-------------
        A.umsatz_netto_sa_aktion_loyalty,
        A.menge_sa_aktion_loyalty AS absatz_sa_aktion_loyalty,
        A.ek_mep_sa_aktion_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_aktion_loyalty_wg30,
        A.logkostenzuschlag_sa_aktion_loyalty,
        A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_loyalty) AS rohertrag_sa_aktion_loyalty,
        (A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_loyalty)) / IF(A.umsatz_netto_sa_aktion_loyalty = 0, NULL, A.umsatz_netto_sa_aktion_loyalty
        ) * 100 AS spanne_sa_aktion_loyalty,
        A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_loyalty) - I.wa_kalk_abschriften_sa_aktion_loyalty AS
        wa_kalk_nach_pv_sa_aktion_loyalty,
        (A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_loyalty) - I.wa_kalk_abschriften_sa_aktion_loyalty) / IF(A.umsatz_netto_sa_aktion_loyalty
        = 0, NULL, A.umsatz_netto_sa_aktion_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_aktion_loyalty,
        I.wa_kalk_abschriften_sa_aktion_loyalty,
        -- sa_bby_loyalty -------------
        A.umsatz_netto_sa_bby_loyalty,
        A.menge_sa_bby_loyalty AS absatz_sa_bby_loyalty,
        A.ek_mep_sa_bby_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_bby_loyalty_wg30,
        A.logkostenzuschlag_sa_bby_loyalty,
        A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_loyalty) AS rohertrag_sa_bby_loyalty,
        (A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_loyalty)) / IF(A.umsatz_netto_sa_bby_loyalty = 0, NULL, A.umsatz_netto_sa_bby_loyalty
        ) * 100 AS spanne_sa_bby_loyalty,
        A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_loyalty) - I.wa_kalk_abschriften_sa_bby_loyalty AS
        wa_kalk_nach_pv_sa_bby_loyalty,
        (A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_loyalty) - I.wa_kalk_abschriften_sa_bby_loyalty) / IF(A.umsatz_netto_sa_bby_loyalty
        = 0, NULL, A.umsatz_netto_sa_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_bby_loyalty,
        I.wa_kalk_abschriften_sa_bby_loyalty,
        -- sa_kdn_bby_loyalty -------------
        A.umsatz_netto_sa_kdn_bby_loyalty,
        A.menge_sa_kdn_bby_loyalty AS absatz_sa_kdn_bby_loyalty,
        A.ek_mep_sa_kdn_bby_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
        A.logkostenzuschlag_sa_kdn_bby_loyalty,
        A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdn_bby_loyalty) AS rohertrag_sa_kdn_bby_loyalty,
        (A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdn_bby_loyalty)) / IF(A.umsatz_netto_sa_kdn_bby_loyalty = 0, NULL, A.umsatz_netto_sa_kdn_bby_loyalty
        ) * 100 AS spanne_sa_kdn_bby_loyalty,
        A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdn_bby_loyalty) - I.wa_kalk_abschriften_sa_kdn_bby_loyalty AS
        wa_kalk_nach_pv_sa_kdn_bby_loyalty,
        (A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdn_bby_loyalty) - I.wa_kalk_abschriften_sa_kdn_bby_loyalty) / IF(A.umsatz_netto_sa_kdn_bby_loyalty
        = 0, NULL, A.umsatz_netto_sa_kdn_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty,
        I.wa_kalk_abschriften_sa_kdn_bby_loyalty,
        -- sa_kdp_bby_loyalty -------------
        A.umsatz_netto_sa_kdp_bby_loyalty,
        A.menge_sa_kdp_bby_loyalty AS absatz_sa_kdp_bby_loyalty,
        A.ek_mep_sa_kdp_bby_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
        A.logkostenzuschlag_sa_kdp_bby_loyalty,
        A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdp_bby_loyalty) AS rohertrag_sa_kdp_bby_loyalty,
        (A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdp_bby_loyalty)) / IF(A.umsatz_netto_sa_kdp_bby_loyalty = 0, NULL, A.umsatz_netto_sa_kdp_bby_loyalty
        ) * 100 AS spanne_sa_kdp_bby_loyalty,
        A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdp_bby_loyalty) - I.wa_kalk_abschriften_sa_kdp_bby_loyalty AS
        wa_kalk_nach_pv_sa_kdp_bby_loyalty,
        (A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdp_bby_loyalty) - I.wa_kalk_abschriften_sa_kdp_bby_loyalty) / IF(A.umsatz_netto_sa_kdp_bby_loyalty
        = 0, NULL, A.umsatz_netto_sa_kdp_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty,
        I.wa_kalk_abschriften_sa_kdp_bby_loyalty,
        -- sa_non_loyalty -------------
        A.umsatz_netto_sa_non_loyalty,
        A.menge_sa_non_loyalty AS absatz_sa_non_loyalty,
        A.ek_mep_sa_non_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_non_loyalty_wg30,
        A.logkostenzuschlag_sa_non_loyalty,
        A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_non_loyalty) AS rohertrag_sa_non_loyalty,
        (A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_non_loyalty)) / IF(A.umsatz_netto_sa_non_loyalty = 0, NULL, A.umsatz_netto_sa_non_loyalty
        ) * 100 AS spanne_sa_non_loyalty,
        A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_non_loyalty) - I.wa_kalk_abschriften_sa_non_loyalty AS
        wa_kalk_nach_pv_sa_non_loyalty,
        (A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_non_loyalty) - I.wa_kalk_abschriften_sa_non_loyalty) / IF(A.umsatz_netto_sa_non_loyalty
        = 0, NULL, A.umsatz_netto_sa_non_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_non_loyalty,
        I.wa_kalk_abschriften_sa_non_loyalty,
        -- sa_aktion_non_loyalty -------------
        A.umsatz_netto_sa_aktion_non_loyalty,
        A.menge_sa_aktion_non_loyalty AS absatz_sa_aktion_non_loyalty,
        A.ek_mep_sa_aktion_non_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_aktion_non_loyalty_wg30,
        A.logkostenzuschlag_sa_aktion_non_loyalty,
        A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_non_loyalty) AS rohertrag_sa_aktion_non_loyalty,
        (A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_non_loyalty)) / IF(A.umsatz_netto_sa_aktion_non_loyalty = 0, NULL, A.umsatz_netto_sa_aktion_non_loyalty
        ) * 100 AS spanne_sa_aktion_non_loyalty,
        A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_non_loyalty) - I.wa_kalk_abschriften_sa_aktion_non_loyalty AS
        wa_kalk_nach_pv_sa_aktion_non_loyalty,
        (A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_non_loyalty) - I.wa_kalk_abschriften_sa_aktion_non_loyalty) / IF(A.umsatz_netto_sa_aktion_non_loyalty
        = 0, NULL, A.umsatz_netto_sa_aktion_non_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty,
        I.wa_kalk_abschriften_sa_aktion_non_loyalty,
        -- sa_bby_non_loyalty -------------
        A.umsatz_netto_sa_bby_non_loyalty,
        A.menge_sa_bby_non_loyalty AS absatz_sa_bby_non_loyalty,
        A.ek_mep_sa_bby_non_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_bby_non_loyalty_wg30,
        A.logkostenzuschlag_sa_bby_non_loyalty,
        A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) AS rohertrag_sa_bby_non_loyalty,
        (A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty)) / IF(A.umsatz_netto_sa_bby_non_loyalty = 0, NULL, A.umsatz_netto_sa_bby_non_loyalty
        ) * 100 AS spanne_sa_bby_non_loyalty,
        A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bby_non_loyalty AS
        wa_kalk_nach_pv_sa_bby_non_loyalty,
        (A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bby_non_loyalty) / IF(A.umsatz_netto_sa_bby_non_loyalty
        = 0, NULL, A.umsatz_netto_sa_bby_non_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_bby_non_loyalty,
        I.wa_kalk_abschriften_sa_bby_non_loyalty,
        -- sa_bonrabatt_bby_loyalty -------------
        A.umsatz_netto_sa_bonrabatt_bby_loyalty,
        A.menge_sa_bonrabatt_bby_loyalty AS absatz_sa_bonrabatt_bby_loyalty,
        A.ek_mep_sa_bonrabatt_bby_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
        A.logkostenzuschlag_sa_bonrabatt_bby_loyalty,
        A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) AS rohertrag_sa_bonrabatt_bby_loyalty,
        (A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty)) / IF(A.umsatz_netto_sa_bonrabatt_bby_loyalty = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_loyalty) * 100 AS spanne_sa_bonrabatt_bby_loyalty,
        A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty AS
        wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
        (A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty) / IF(A.umsatz_netto_sa_bonrabatt_bby_loyalty = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_loyalty) * 100 AS
        spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
        I.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
        -- sa_bonrabatt_bby_non_loyalty -------------
        A.umsatz_netto_sa_bonrabatt_bby_non_loyalty,
        A.menge_sa_bonrabatt_bby_non_loyalty AS absatz_sa_bonrabatt_bby_non_loyalty,
        A.ek_mep_sa_bonrabatt_bby_non_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
        A.logkostenzuschlag_sa_bby_non_loyalty AS logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
        A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) AS rohertrag_sa_bonrabatt_bby_non_loyalty,
        (A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty)) / IF(A.umsatz_netto_sa_bonrabatt_bby_non_loyalty = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_non_loyalty
        ) * 100 AS spanne_sa_bonrabatt_bby_non_loyalty,
        A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty AS
        wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
        (A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty) / IF(A.umsatz_netto_sa_bonrabatt_bby_non_loyalty
        = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_non_loyalty) * 100 AS
        spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
        I.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
        j.pv_aktion_loy,
        j.pv_aktion_non_loy,
        j.pv_bby_loy,
        j.pv_bby_non_loy,
        j.pv_kdn_bby,
        j.pv_kdp_bby,
        j.pv_bonrabatt_bby_loy,
        j.pv_bonrabatt_bby_non_loy,
        B.wg_id,
        C.owg_id,
        D.hwg_id,
        C.abt_id
    FROM `_hilfe3` AS A
    INNER JOIN dbp_data.art_wg_zu_per AS B
        ON
            A.art_id = B.art_id AND A.mandant_id = B.mandant_id AND B.dat_bis
            = DATE '9999-12-31' AND B.arthiertyp_id = 2
    INNER JOIN dbp_data.wg_per AS C
        ON
            A.mandant_id = C.mandant_id AND B.wg_id = C.wg_id AND C.dat_bis =
            DATE '9999-12-31' AND C.arthiertyp_id = 2
    INNER JOIN dbp_data.owg_per AS D
        ON
            A.mandant_id = D.mandant_id AND C.owg_id = D.owg_id AND D.dat_bis =
            DATE '9999-12-31' AND D.arthiertyp_id = 2
    INNER JOIN dbp_data.wup AS E ON A.mandant_id = E.mandant_id AND A.wup_id = E.wup_id
    INNER JOIN (
        SELECT
            A0.mandant_id,
            A0.kjwo_ww,
            COALESCE(B0.dat, A0.dat) AS dat
        FROM dbp_data.werbewoche_kl AS A0
        LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B0
            ON
                A0.kjwo_ww = B0.kjwo_ww AND A0.mandant_id
                = B0.mandant_id
        WHERE A0.mandant_id = 1
        GROUP BY
            A0.mandant_id,
            A0.kjwo_ww,
            dat
    ) AS f ON A.mandant_id = f.mandant_id AND A.dat = f.dat
    INNER JOIN (
        SELECT
            mandant_id,
            kjwo,
            art_id,
            kl_art_id,
            muki
        FROM `_hit_the_actions`
        WHERE kjwo = akt_woche
        GROUP BY
            mandant_id,
            kjwo,
            art_id,
            kl_art_id,
            muki
    ) AS g
        ON
            CAST(FLOOR(A.art_id / 100) AS INTEGER
            ) = g.kl_art_id AND A.mandant_id = g.mandant_id AND f.kjwo_ww = g.kjwo
    LEFT JOIN (
        SELECT
            mandant_id,
            wup_id,
            art_id,
            dat,
            SUM(abschriftenbetrag_netto) AS abschriftenbetrag_netto
        FROM dbp_msi_view2.mv_marktabschriften
        WHERE abschriftenart_id = -1
        GROUP BY
            mandant_id,
            wup_id,
            dat,
            art_id
    ) AS t7 ON A.art_id = t7.art_id AND A.mandant_id = t7.mandant_id AND A.wup_id = t7.wup_id AND A.dat = t7.dat
    LEFT JOIN `_hilfe11` AS I ON A.art_id = I.art_id AND A.mandant_id = I.mandant_id AND A.wup_id = I.wup_id AND A.dat = I.dat
    LEFT JOIN (
        SELECT
            V01.mandant_id,
            V01.wup_id,
            V01.art_id,
            V01.dat,
            SUM(CASE
                WHEN V01.wv_grund_id = 2 AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_aktion_loy,
            SUM(CASE
                WHEN V01.wv_grund_id = 0 AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_aktion_non_loy,
            SUM(CASE
                WHEN
                    V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54) AND V01.abschriftart_id = -1 OR V01.dat <
                    DATE '2022-04-01' AND V01.wv_grund_id IN (52, 54, 54, 55) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_bby_loy,
            SUM(CASE
                WHEN
                    V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58) AND V01.abschriftart_id = -1 OR V01.dat <
                    DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58, 59) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_bby_non_loy,
            SUM(CASE
                WHEN
                    V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62) AND V01.abschriftart_id = -1 OR V01.dat <
                    DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62, 63) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_kdn_bby,
            SUM(CASE
                WHEN
                    V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 73, 74, 75) AND V01.abschriftart_id = -1 OR
                    V01.dat < DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 67) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_kdp_bby,
            SUM(CASE
                WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (59) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_bonrabatt_bby_non_loy,
            SUM(CASE
                WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (55, 63, 67) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_bonrabatt_bby_loy
        FROM dbp_data.marktabschriften AS V01
        LEFT JOIN (SELECT
            art_id,
            gp_id,
            wup_id,
            dat_von,
            dat_bis
        FROM dbp_data.art_gp_nm_zu_per
        WHERE mandant_id = 1) AS v02
            ON
                V01.art_id = v02.art_id AND V01.wup_id = v02.wup_id AND V01.dat BETWEEN v02.dat_von
                AND v02.dat_bis
        INNER JOIN (SELECT
            art_id,
            gewart_id
        FROM dbp_data.art
        WHERE mandant_id = 1) AS v03 ON V01.art_id = v03.art_id
        WHERE V01.mandant_id = 1
        GROUP BY
            V01.mandant_id,
            V01.wup_id,
            V01.art_id,
            V01.dat
    ) AS j ON A.art_id = j.art_id AND A.mandant_id = j.mandant_id AND A.wup_id = j.wup_id AND A.dat = j.dat
    WHERE
        A.mandant_id = 1
        AND A.bewart_id = 1002
);


INSERT INTO `_artbew1`
(
    SELECT
        A.mandant_id,
        f.kjwo_ww,
        A.art_id,
        g.art_id AS mutter_art_id,
        g.muki,
        A.wup_id,
        A.gp_id,
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END AS umsatz_netto_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.menge
            ELSE 0
        END AS absatz_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END AS ek_mep_sa_west,
        CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'N',
                    'W'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_west_wg30,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'N',
                    'W'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END) AS rohertrag_sa_west,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END)) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN COALESCE(t7.abschriftenbetrag_netto, 0)
            ELSE 0
        END AS preisvorteil_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'N',
                    'W'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_west AS wa_kalk_nach_pv_sa_west,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_west) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('N', 'W')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_wa_kalk_nach_pv_sa_west,
        I.wa_kalk_abschriften_sa_west,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END AS umsatz_netto_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.menge
            ELSE 0
        END AS absatz_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END AS ek_mep_sa_ost,
        CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'O',
                    'Q'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_ost_wg30,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'O',
                    'Q'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END) AS rohertrag_sa_ost,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END)) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN COALESCE(t7.abschriftenbetrag_netto, 0)
            ELSE 0
        END AS preisvorteil_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'O',
                    'Q'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_ost AS wa_kalk_nach_pv_sa_ost,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_ost) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('O', 'Q')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_wa_kalk_nach_pv_sa_ost,
        I.wa_kalk_abschriften_sa_ost,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END AS umsatz_netto_sa_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.menge
            ELSE 0
        END AS absatz_sa_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END AS ek_mep_sa_sued,
        CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'G',
                    'M'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_sued_wg30,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'G',
                    'M'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END) AS rohertrag_sa_sued,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END)) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_sa_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN COALESCE(t7.abschriftenbetrag_netto, 0)
            ELSE 0
        END AS preisvorteil_sued,
        CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (
                    161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN (
                    'G',
                    'M'
                )
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_sued AS wa_kalk_nach_pv_sa_sued,
        (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END - (CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.ek_mep
            ELSE 0
        END + CASE
            WHEN
                B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178) AND E.kreistyp_gruppe_id IN
                ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END - CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.logkostenzuschlag
            ELSE 0
        END) - I.wa_kalk_abschriften_sa_sued) / IF(CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END = 0, NULL, CASE
            WHEN E.kreistyp_gruppe_id IN ('G', 'M')
                THEN A.umsatz_netto
            ELSE 0
        END) * 100 AS spanne_wa_kalk_nach_pv_sa_sued,
        I.wa_kalk_abschriften_sa_sued,
        A.umsatz_netto AS umsatz_netto_sa,
        A.menge AS absatz_sa,
        A.ek_mep AS ek_mep_sa,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END AS logkostenzuschlag_sa_wg30,
        A.logkostenzuschlag AS logkostenzuschlag_sa,
        A.umsatz_netto - (A.ek_mep + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag) AS rohertrag_sa,
        IF((A.umsatz_netto - (A.ek_mep + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag)) / IF(A.umsatz_netto = 0, NULL, A.umsatz_netto) = 0, NULL, (A.umsatz_netto - (A.ek_mep
        + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag)) / IF(A.umsatz_netto = 0, NULL, A.umsatz_netto)) * 100 AS spanne_sa,
        COALESCE(t7.abschriftenbetrag_netto, 0) AS preisvorteil,
        A.umsatz_netto - (A.ek_mep + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag) - I.wa_kalk_abschriften_sa AS wa_kalk_nach_pv_sa,
        (A.umsatz_netto - (A.ek_mep + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag
            ELSE 0
        END - A.logkostenzuschlag) - I.wa_kalk_abschriften_sa) / IF(A.umsatz_netto = 0, NULL, A.umsatz_netto) * 100
            AS spanne_wa_kalk_nach_pv_sa,
        I.wa_kalk_abschriften_sa,
        -- sa_loyalty-------------
        A.umsatz_netto_sa_loyalty,
        A.menge_sa_loyalty AS absatz_sa_loyalty,
        A.ek_mep_sa_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_loyalty_wg30,
        A.logkostenzuschlag_sa_loyalty,
        A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_loyalty) AS rohertrag_sa_loyalty,
        (A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_loyalty)) / IF(A.umsatz_netto_sa_loyalty = 0, NULL, A.umsatz_netto_sa_loyalty) *
        100 AS spanne_sa_loyalty,
        A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_loyalty) - I.wa_kalk_abschriften_sa_loyalty AS wa_kalk_nach_pv_sa_loyalty,
        (A.umsatz_netto_sa_loyalty - (A.ek_mep_sa_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_loyalty) - I.wa_kalk_abschriften_sa_loyalty) / IF(A.umsatz_netto_sa_loyalty = 0,
        NULL, A.umsatz_netto_sa_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_loyalty,
        I.wa_kalk_abschriften_sa_loyalty,
        -- sa_aktion_loyalty-------------
        A.umsatz_netto_sa_aktion_loyalty,
        A.menge_sa_aktion_loyalty AS absatz_sa_aktion_loyalty,
        A.ek_mep_sa_aktion_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_aktion_loyalty_wg30,
        A.logkostenzuschlag_sa_aktion_loyalty,
        A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_loyalty) AS rohertrag_sa_aktion_loyalty,
        (A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_loyalty)) / IF(A.umsatz_netto_sa_aktion_loyalty = 0, NULL, A.umsatz_netto_sa_aktion_loyalty
        ) * 100 AS spanne_sa_aktion_loyalty,
        A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_loyalty) - I.wa_kalk_abschriften_sa_aktion_loyalty AS
        wa_kalk_nach_pv_sa_aktion_loyalty,
        (A.umsatz_netto_sa_aktion_loyalty - (A.ek_mep_sa_aktion_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_loyalty) - I.wa_kalk_abschriften_sa_aktion_loyalty) / IF(A.umsatz_netto_sa_aktion_loyalty
        = 0, NULL, A.umsatz_netto_sa_aktion_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_aktion_loyalty,
        I.wa_kalk_abschriften_sa_aktion_loyalty,
        -- sa_bby_loyalty -------------
        A.umsatz_netto_sa_bby_loyalty,
        A.menge_sa_bby_loyalty AS absatz_sa_bby_loyalty,
        A.ek_mep_sa_bby_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_bby_loyalty_wg30,
        A.logkostenzuschlag_sa_bby_loyalty,
        A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_loyalty) AS rohertrag_sa_bby_loyalty,
        (A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_loyalty)) / IF(A.umsatz_netto_sa_bby_loyalty = 0, NULL, A.umsatz_netto_sa_bby_loyalty
        ) * 100 AS spanne_sa_bby_loyalty,
        A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_loyalty) - I.wa_kalk_abschriften_sa_bby_loyalty AS
        wa_kalk_nach_pv_sa_bby_loyalty,
        (A.umsatz_netto_sa_bby_loyalty - (A.ek_mep_sa_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_loyalty) - I.wa_kalk_abschriften_sa_bby_loyalty) / IF(A.umsatz_netto_sa_bby_loyalty
        = 0, NULL, A.umsatz_netto_sa_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_bby_loyalty,
        I.wa_kalk_abschriften_sa_bby_loyalty,
        -- sa_kdn_bby_loyalty -------------
        A.umsatz_netto_sa_kdn_bby_loyalty,
        A.menge_sa_kdn_bby_loyalty AS absatz_sa_kdn_bby_loyalty,
        A.ek_mep_sa_kdn_bby_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
        A.logkostenzuschlag_sa_kdn_bby_loyalty,
        A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdn_bby_loyalty) AS rohertrag_sa_kdn_bby_loyalty,
        (A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdn_bby_loyalty)) / IF(A.umsatz_netto_sa_kdn_bby_loyalty = 0, NULL, A.umsatz_netto_sa_kdn_bby_loyalty
        ) * 100 AS spanne_sa_kdn_bby_loyalty,
        A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdn_bby_loyalty) - I.wa_kalk_abschriften_sa_kdn_bby_loyalty AS
        wa_kalk_nach_pv_sa_kdn_bby_loyalty,
        (A.umsatz_netto_sa_kdn_bby_loyalty - (A.ek_mep_sa_kdn_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdn_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdn_bby_loyalty) - I.wa_kalk_abschriften_sa_kdn_bby_loyalty) / IF(A.umsatz_netto_sa_kdn_bby_loyalty
        = 0, NULL, A.umsatz_netto_sa_kdn_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty,
        I.wa_kalk_abschriften_sa_kdn_bby_loyalty,
        -- sa_kdp_bby_loyalty -------------
        A.umsatz_netto_sa_kdp_bby_loyalty,
        A.menge_sa_kdp_bby_loyalty AS absatz_sa_kdp_bby_loyalty,
        A.ek_mep_sa_kdp_bby_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
        A.logkostenzuschlag_sa_kdp_bby_loyalty,
        A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdp_bby_loyalty) AS rohertrag_sa_kdp_bby_loyalty,
        (A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdp_bby_loyalty)) / IF(A.umsatz_netto_sa_kdp_bby_loyalty = 0, NULL, A.umsatz_netto_sa_kdp_bby_loyalty
        ) * 100 AS spanne_sa_kdp_bby_loyalty,
        A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdp_bby_loyalty) - I.wa_kalk_abschriften_sa_kdp_bby_loyalty AS
        wa_kalk_nach_pv_sa_kdp_bby_loyalty,
        (A.umsatz_netto_sa_kdp_bby_loyalty - (A.ek_mep_sa_kdp_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_kdp_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_kdp_bby_loyalty) - I.wa_kalk_abschriften_sa_kdp_bby_loyalty) / IF(A.umsatz_netto_sa_kdp_bby_loyalty
        = 0, NULL, A.umsatz_netto_sa_kdp_bby_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty,
        I.wa_kalk_abschriften_sa_kdp_bby_loyalty,
        -- sa_non_loyalty -------------
        A.umsatz_netto_sa_non_loyalty,
        A.menge_sa_non_loyalty AS absatz_sa_non_loyalty,
        A.ek_mep_sa_non_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_non_loyalty_wg30,
        A.logkostenzuschlag_sa_non_loyalty,
        A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_non_loyalty) AS rohertrag_sa_non_loyalty,
        (A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_non_loyalty)) / IF(A.umsatz_netto_sa_non_loyalty = 0, NULL, A.umsatz_netto_sa_non_loyalty
        ) * 100 AS spanne_sa_non_loyalty,
        A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_non_loyalty) - I.wa_kalk_abschriften_sa_non_loyalty AS
        wa_kalk_nach_pv_sa_non_loyalty,
        (A.umsatz_netto_sa_non_loyalty - (A.ek_mep_sa_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_non_loyalty) - I.wa_kalk_abschriften_sa_non_loyalty) / IF(A.umsatz_netto_sa_non_loyalty
        = 0, NULL, A.umsatz_netto_sa_non_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_non_loyalty,
        I.wa_kalk_abschriften_sa_non_loyalty,
        -- sa_aktion_non_loyalty -------------
        A.umsatz_netto_sa_aktion_non_loyalty,
        A.menge_sa_aktion_non_loyalty AS absatz_sa_aktion_non_loyalty,
        A.ek_mep_sa_aktion_non_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_aktion_non_loyalty_wg30,
        A.logkostenzuschlag_sa_aktion_non_loyalty,
        A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_non_loyalty) AS rohertrag_sa_aktion_non_loyalty,
        (A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_non_loyalty)) / IF(A.umsatz_netto_sa_aktion_non_loyalty = 0, NULL, A.umsatz_netto_sa_aktion_non_loyalty
        ) * 100 AS spanne_sa_aktion_non_loyalty,
        A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_non_loyalty) - I.wa_kalk_abschriften_sa_aktion_non_loyalty AS
        wa_kalk_nach_pv_sa_aktion_non_loyalty,
        (A.umsatz_netto_sa_aktion_non_loyalty - (A.ek_mep_sa_aktion_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_aktion_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_aktion_non_loyalty) - I.wa_kalk_abschriften_sa_aktion_non_loyalty) / IF(A.umsatz_netto_sa_aktion_non_loyalty
        = 0, NULL, A.umsatz_netto_sa_aktion_non_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty,
        I.wa_kalk_abschriften_sa_aktion_non_loyalty,
        -- sa_bby_non_loyalty -------------
        A.umsatz_netto_sa_bby_non_loyalty,
        A.menge_sa_bby_non_loyalty AS absatz_sa_bby_non_loyalty,
        A.ek_mep_sa_bby_non_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_bby_non_loyalty_wg30,
        A.logkostenzuschlag_sa_bby_non_loyalty,
        A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) AS rohertrag_sa_bby_non_loyalty,
        (A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty)) / IF(A.umsatz_netto_sa_bby_non_loyalty = 0, NULL, A.umsatz_netto_sa_bby_non_loyalty
        ) * 100 AS spanne_sa_bby_non_loyalty,
        A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bby_non_loyalty AS
        wa_kalk_nach_pv_sa_bby_non_loyalty,
        (A.umsatz_netto_sa_bby_non_loyalty - (A.ek_mep_sa_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bby_non_loyalty) / IF(A.umsatz_netto_sa_bby_non_loyalty
        = 0, NULL, A.umsatz_netto_sa_bby_non_loyalty) * 100 AS spanne_wa_kalk_nach_pv_sa_bby_non_loyalty,
        I.wa_kalk_abschriften_sa_bby_non_loyalty,
        -- sa_bonrabatt_bby_loyalty -------------
        A.umsatz_netto_sa_bonrabatt_bby_loyalty,
        A.menge_sa_bonrabatt_bby_loyalty AS absatz_sa_bonrabatt_bby_loyalty,
        A.ek_mep_sa_bonrabatt_bby_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
        A.logkostenzuschlag_sa_bonrabatt_bby_loyalty,
        A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) AS rohertrag_sa_bonrabatt_bby_loyalty,
        (A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty)) / IF(A.umsatz_netto_sa_bonrabatt_bby_loyalty = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_loyalty) * 100 AS spanne_sa_bonrabatt_bby_loyalty,
        A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty AS
        wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
        (A.umsatz_netto_sa_bonrabatt_bby_loyalty - (A.ek_mep_sa_bonrabatt_bby_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty) / IF(A.umsatz_netto_sa_bonrabatt_bby_loyalty = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_loyalty) * 100 AS
        spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty,
        I.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
        -- sa_bonrabatt_bby_non_loyalty -------------
        A.umsatz_netto_sa_bonrabatt_bby_non_loyalty,
        A.menge_sa_bonrabatt_bby_non_loyalty AS absatz_sa_bonrabatt_bby_non_loyalty,
        A.ek_mep_sa_bonrabatt_bby_non_loyalty,
        CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END AS logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
        A.logkostenzuschlag_sa_bby_non_loyalty AS logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
        A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) AS rohertrag_sa_bonrabatt_bby_non_loyalty,
        (A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty)) / IF(A.umsatz_netto_sa_bonrabatt_bby_non_loyalty = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_non_loyalty
        ) * 100 AS spanne_sa_bonrabatt_bby_non_loyalty,
        A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty AS
        wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
        (A.umsatz_netto_sa_bonrabatt_bby_non_loyalty - (A.ek_mep_sa_bonrabatt_bby_non_loyalty + CASE
            WHEN B.wg_id IN (161, 162, 163, 164, 168, 169, 172, 173, 174, 175, 176, 177, 178)
                THEN A.logkostenzuschlag_sa_bby_non_loyalty
            ELSE 0
        END - A.logkostenzuschlag_sa_bby_non_loyalty) - I.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty) / IF(A.umsatz_netto_sa_bonrabatt_bby_non_loyalty
        = 0, NULL, A.umsatz_netto_sa_bonrabatt_bby_non_loyalty) * 100 AS
        spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty,
        I.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
        j.pv_aktion_loy,
        j.pv_aktion_non_loy,
        j.pv_bby_loy,
        j.pv_bby_non_loy,
        j.pv_kdn_bby,
        j.pv_kdp_bby,
        j.pv_bonrabatt_bby_loy,
        j.pv_bonrabatt_bby_non_loy,
        B.wg_id,
        C.owg_id,
        D.hwg_id,
        C.abt_id
    FROM `_hilfe4` AS A
    INNER JOIN dbp_data.art_wg_zu_per AS B
        ON
            A.art_id = B.art_id AND A.mandant_id = B.mandant_id AND B.dat_bis
            = DATE '9999-12-31' AND B.arthiertyp_id = 2
    INNER JOIN dbp_data.wg_per AS C
        ON
            A.mandant_id = C.mandant_id AND B.wg_id = C.wg_id AND C.dat_bis =
            DATE '9999-12-31' AND C.arthiertyp_id = 2
    INNER JOIN dbp_data.owg_per AS D
        ON
            A.mandant_id = D.mandant_id AND C.owg_id = D.owg_id AND D.dat_bis =
            DATE '9999-12-31' AND D.arthiertyp_id = 2
    INNER JOIN dbp_data.wup AS E ON A.mandant_id = E.mandant_id AND A.wup_id = E.wup_id
    INNER JOIN (
        SELECT
            A0.mandant_id,
            A0.kjwo_ww,
            COALESCE(B0.dat, A0.dat) AS dat
        FROM dbp_data.werbewoche_kl AS A0
        LEFT JOIN dbp_etl_process.werbewoche_real_manuell AS B0
            ON
                A0.kjwo_ww = B0.kjwo_ww AND A0.mandant_id
                = B0.mandant_id
        WHERE A0.mandant_id = 1
        GROUP BY
            A0.mandant_id,
            A0.kjwo_ww,
            dat
    ) AS f ON A.mandant_id = f.mandant_id AND A.dat = f.dat
    INNER JOIN (
        SELECT
            mandant_id,
            kjwo,
            art_id,
            kl_art_id,
            muki
        FROM `_hit_the_actions`
        WHERE kjwo <> akt_woche
        GROUP BY
            mandant_id,
            kjwo,
            art_id,
            kl_art_id,
            muki
    ) AS g
        ON
            CAST(FLOOR(A.art_id / 100) AS INTEGER
            ) = g.kl_art_id AND A.mandant_id = g.mandant_id
    LEFT JOIN (
        SELECT
            mandant_id,
            wup_id,
            art_id,
            dat,
            SUM(abschriftenbetrag_netto) AS abschriftenbetrag_netto
        FROM dbp_msi_view2.mv_marktabschriften
        WHERE abschriftenart_id = -1
        GROUP BY
            mandant_id,
            wup_id,
            dat,
            art_id
    ) AS t7 ON A.art_id = t7.art_id AND A.mandant_id = t7.mandant_id AND A.wup_id = t7.wup_id AND A.dat = t7.dat
    LEFT JOIN `_hilfe11` AS I ON A.art_id = I.art_id AND A.mandant_id = I.mandant_id AND A.wup_id = I.wup_id AND A.dat = I.dat
    LEFT JOIN (
        SELECT
            V01.mandant_id,
            V01.wup_id,
            V01.art_id,
            V01.dat,
            SUM(CASE
                WHEN V01.wv_grund_id = 2 AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_aktion_loy,
            SUM(CASE
                WHEN V01.wv_grund_id = 0 AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_aktion_non_loy,
            SUM(CASE
                WHEN
                    V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (52, 53, 54) AND V01.abschriftart_id = -1 OR V01.dat <
                    DATE '2022-04-01' AND V01.wv_grund_id IN (52, 54, 54, 55) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_bby_loy,
            SUM(CASE
                WHEN
                    V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58) AND V01.abschriftart_id = -1 OR V01.dat <
                    DATE '2022-04-01' AND V01.wv_grund_id IN (56, 57, 58, 59) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_bby_non_loy,
            SUM(CASE
                WHEN
                    V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62) AND V01.abschriftart_id = -1 OR V01.dat <
                    DATE '2022-04-01' AND V01.wv_grund_id IN (60, 61, 62, 63) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_kdn_bby,
            SUM(CASE
                WHEN
                    V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 73, 74, 75) AND V01.abschriftart_id = -1 OR
                    V01.dat < DATE '2022-04-01' AND V01.wv_grund_id IN (64, 65, 66, 67) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_kdp_bby,
            SUM(CASE
                WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (59) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_bonrabatt_bby_non_loy,
            SUM(CASE
                WHEN V01.dat >= DATE '2022-04-01' AND V01.wv_grund_id IN (55, 63, 67) AND V01.abschriftart_id = -1
                    THEN V01.abschriftbetrag_netto
                ELSE 0
            END) AS pv_bonrabatt_bby_loy
        FROM dbp_data.marktabschriften AS V01
        LEFT JOIN (SELECT
            art_id,
            gp_id,
            wup_id,
            dat_von,
            dat_bis
        FROM dbp_data.art_gp_nm_zu_per
        WHERE mandant_id = 1) AS v02
            ON
                V01.art_id = v02.art_id AND V01.wup_id = v02.wup_id AND V01.dat BETWEEN v02.dat_von
                AND v02.dat_bis
        INNER JOIN (SELECT
            art_id,
            gewart_id
        FROM dbp_data.art
        WHERE mandant_id = 1) AS v03 ON V01.art_id = v03.art_id
        WHERE V01.mandant_id = 1
        GROUP BY
            V01.mandant_id,
            V01.wup_id,
            V01.art_id,
            V01.dat
    ) AS j ON A.art_id = j.art_id AND A.mandant_id = j.mandant_id AND A.wup_id = j.wup_id AND A.dat = j.dat
    WHERE
        A.mandant_id = 1
        AND A.bewart_id = 1002
);


CREATE OR REPLACE TEMPORARY TABLE _artbew2 AS
-- 
-- 
-- 
-- sa_loyalty --
-- sa_aktion_loyalty --
-- sa_bby_loyalty --
-- sa_kdn_bby_loyalty --

-- sa_kdp_bby_loyalty --
-- sa_non_loyalty --
-- sa_aktion_non_loyalty --
-- sa_bby_non_loyalty --

-- sa_bonrabatt_bby_loyalty --
-- sa_bonrabatt_bby_non_loyalty --
SELECT
    mandant_id,
    kjwo_ww,
    wup_id,
    mutter_art_id,
    art_id,
    99 AS gp_id,
    aktionsart_id_liste_txt,
    aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt,
    wg_id,
    owg_id,
    hwg_id,
    abt_id,
    SUM(umsatz_netto_sa_west) AS umsatz_netto_sa_west,
    SUM(absatz_sa_west) AS absatz_sa_west,
    SUM(ek_mep_sa_west) AS ek_mep_sa_west,
    SUM(logkostenzuschlag_sa_west_wg30) AS logkostenzuschlag_sa_west_wg30,
    SUM(logkostenzuschlag_sa_west) AS logkostenzuschlag_sa_west,
    SUM(preisvorteil_west) AS preisvorteil_west,
    SUM(wa_kalk_nach_pv_sa_west) AS wa_kalk_nach_pv_sa_west,
    SUM(wa_kalk_abschriften_sa_west) AS wa_kalk_abschriften_sa_west,
    SUM(umsatz_netto_sa_ost) AS umsatz_netto_sa_ost,
    SUM(absatz_sa_ost) AS absatz_sa_ost,
    SUM(ek_mep_sa_ost) AS ek_mep_sa_ost,
    SUM(logkostenzuschlag_sa_ost_wg30) AS logkostenzuschlag_sa_ost_wg30,
    SUM(logkostenzuschlag_sa_ost) AS logkostenzuschlag_sa_ost,
    SUM(preisvorteil_ost) AS preisvorteil_ost,
    SUM(wa_kalk_nach_pv_sa_ost) AS wa_kalk_nach_pv_sa_ost,
    SUM(wa_kalk_abschriften_sa_ost) AS wa_kalk_abschriften_sa_ost,
    SUM(umsatz_netto_sa_sued) AS umsatz_netto_sa_sued,
    SUM(absatz_sa_sued) AS absatz_sa_sued,
    SUM(ek_mep_sa_sued) AS ek_mep_sa_sued,
    SUM(logkostenzuschlag_sa_sued_wg30) AS logkostenzuschlag_sa_sued_wg30,
    SUM(logkostenzuschlag_sa_sued) AS logkostenzuschlag_sa_sued,
    SUM(preisvorteil_sued) AS preisvorteil_sued,
    SUM(wa_kalk_nach_pv_sa_sued) AS wa_kalk_nach_pv_sa_sued,
    SUM(wa_kalk_abschriften_sa_sued) AS wa_kalk_abschriften_sa_sued,
    SUM(umsatz_netto_sa) AS umsatz_netto_sa,
    SUM(absatz_sa) AS absatz_sa,
    SUM(ek_mep_sa) AS ek_mep_sa,
    SUM(logkostenzuschlag_sa_wg30) AS logkostenzuschlag_sa_wg30,
    SUM(logkostenzuschlag_sa) AS logkostenzuschlag_sa,
    SUM(preisvorteil) AS preisvorteil,
    SUM(wa_kalk_nach_pv_sa) AS wa_kalk_nach_pv_sa,
    SUM(wa_kalk_abschriften_sa) AS wa_kalk_abschriften_sa,
    SUM(umsatz_netto_sa_loyalty) AS umsatz_netto_sa_loyalty,
    SUM(absatz_sa_loyalty) AS absatz_sa_loyalty,
    SUM(ek_mep_sa_loyalty) AS ek_mep_sa_loyalty,
    SUM(logkostenzuschlag_sa_loyalty_wg30) AS logkostenzuschlag_sa_loyalty_wg30,
    SUM(logkostenzuschlag_sa_loyalty) AS logkostenzuschlag_sa_loyalty,
    SUM(wa_kalk_abschriften_sa_loyalty) AS wa_kalk_abschriften_sa_loyalty,
    SUM(umsatz_netto_sa_aktion_loyalty) AS umsatz_netto_sa_aktion_loyalty,
    SUM(absatz_sa_aktion_loyalty) AS absatz_sa_aktion_loyalty,
    SUM(ek_mep_sa_aktion_loyalty) AS ek_mep_sa_aktion_loyalty,
    SUM(logkostenzuschlag_sa_aktion_loyalty_wg30) AS logkostenzuschlag_sa_aktion_loyalty_wg30,
    SUM(logkostenzuschlag_sa_aktion_loyalty) AS logkostenzuschlag_sa_aktion_loyalty,
    SUM(wa_kalk_abschriften_sa_aktion_loyalty) AS wa_kalk_abschriften_sa_aktion_loyalty,
    SUM(umsatz_netto_sa_bby_loyalty) AS umsatz_netto_sa_bby_loyalty,
    SUM(absatz_sa_bby_loyalty) AS absatz_sa_bby_loyalty,
    SUM(ek_mep_sa_bby_loyalty) AS ek_mep_sa_bby_loyalty,
    SUM(logkostenzuschlag_sa_bby_loyalty_wg30) AS logkostenzuschlag_sa_bby_loyalty_wg30,
    SUM(logkostenzuschlag_sa_bby_loyalty) AS logkostenzuschlag_sa_bby_loyalty,
    SUM(wa_kalk_abschriften_sa_bby_loyalty) AS wa_kalk_abschriften_sa_bby_loyalty,
    SUM(umsatz_netto_sa_kdn_bby_loyalty) AS umsatz_netto_sa_kdn_bby_loyalty,
    SUM(absatz_sa_kdn_bby_loyalty) AS absatz_sa_kdn_bby_loyalty,
    SUM(ek_mep_sa_kdn_bby_loyalty) AS ek_mep_sa_kdn_bby_loyalty,
    SUM(logkostenzuschlag_sa_kdn_bby_loyalty_wg30) AS logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
    SUM(logkostenzuschlag_sa_kdn_bby_loyalty) AS logkostenzuschlag_sa_kdn_bby_loyalty,
    SUM(wa_kalk_abschriften_sa_kdn_bby_loyalty) AS wa_kalk_abschriften_sa_kdn_bby_loyalty,
    SUM(umsatz_netto_sa_kdp_bby_loyalty) AS umsatz_netto_sa_kdp_bby_loyalty,
    SUM(absatz_sa_kdp_bby_loyalty) AS absatz_sa_kdp_bby_loyalty,
    SUM(ek_mep_sa_kdp_bby_loyalty) AS ek_mep_sa_kdp_bby_loyalty,
    SUM(logkostenzuschlag_sa_kdp_bby_loyalty_wg30) AS logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
    SUM(logkostenzuschlag_sa_kdp_bby_loyalty) AS logkostenzuschlag_sa_kdp_bby_loyalty,
    SUM(wa_kalk_abschriften_sa_kdp_bby_loyalty) AS wa_kalk_abschriften_sa_kdp_bby_loyalty,
    SUM(umsatz_netto_sa_non_loyalty) AS umsatz_netto_sa_non_loyalty,
    SUM(absatz_sa_non_loyalty) AS absatz_sa_non_loyalty,
    SUM(ek_mep_sa_non_loyalty) AS ek_mep_sa_non_loyalty,
    SUM(logkostenzuschlag_sa_non_loyalty_wg30) AS logkostenzuschlag_sa_non_loyalty_wg30,
    SUM(logkostenzuschlag_sa_non_loyalty) AS logkostenzuschlag_sa_non_loyalty,
    SUM(wa_kalk_abschriften_sa_non_loyalty) AS wa_kalk_abschriften_sa_non_loyalty,
    SUM(umsatz_netto_sa_aktion_non_loyalty) AS umsatz_netto_sa_aktion_non_loyalty,
    SUM(absatz_sa_aktion_non_loyalty) AS absatz_sa_aktion_non_loyalty,
    SUM(ek_mep_sa_aktion_non_loyalty) AS ek_mep_sa_aktion_non_loyalty,
    SUM(logkostenzuschlag_sa_aktion_non_loyalty_wg30) AS logkostenzuschlag_sa_aktion_non_loyalty_wg30,
    SUM(logkostenzuschlag_sa_aktion_non_loyalty) AS logkostenzuschlag_sa_aktion_non_loyalty,
    SUM(wa_kalk_abschriften_sa_aktion_non_loyalty) AS wa_kalk_abschriften_sa_aktion_non_loyalty,
    SUM(umsatz_netto_sa_bby_non_loyalty) AS umsatz_netto_sa_bby_non_loyalty,
    SUM(absatz_sa_bby_non_loyalty) AS absatz_sa_bby_non_loyalty,
    SUM(ek_mep_sa_bby_non_loyalty) AS ek_mep_sa_bby_non_loyalty,
    SUM(logkostenzuschlag_sa_bby_non_loyalty_wg30) AS logkostenzuschlag_sa_bby_non_loyalty_wg30,
    SUM(logkostenzuschlag_sa_bby_non_loyalty) AS logkostenzuschlag_sa_bby_non_loyalty,
    SUM(wa_kalk_abschriften_sa_bby_non_loyalty) AS wa_kalk_abschriften_sa_bby_non_loyalty,
    SUM(umsatz_netto_sa_bonrabatt_bby_loyalty) AS umsatz_netto_sa_bonrabatt_bby_loyalty,
    SUM(absatz_sa_bonrabatt_bby_loyalty) AS absatz_sa_bonrabatt_bby_loyalty,
    SUM(ek_mep_sa_bonrabatt_bby_loyalty) AS ek_mep_sa_bonrabatt_bby_loyalty,
    SUM(logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30) AS logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
    SUM(logkostenzuschlag_sa_bonrabatt_bby_loyalty) AS logkostenzuschlag_sa_bonrabatt_bby_loyalty,
    SUM(wa_kalk_abschriften_sa_bonrabatt_bby_loyalty) AS wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
    SUM(umsatz_netto_sa_bonrabatt_bby_non_loyalty) AS umsatz_netto_sa_bonrabatt_bby_non_loyalty,
    SUM(absatz_sa_bonrabatt_bby_non_loyalty) AS absatz_sa_bonrabatt_bby_non_loyalty,
    SUM(ek_mep_sa_bonrabatt_bby_non_loyalty) AS ek_mep_sa_bonrabatt_bby_non_loyalty,
    SUM(logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30) AS logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
    SUM(logkostenzuschlag_sa_bonrabatt_bby_non_loyalty) AS logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
    SUM(wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty) AS wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
    SUM(pv_aktion_loy) AS pv_aktion_loy,
    SUM(pv_aktion_non_loy) AS pv_aktion_non_loy,
    SUM(pv_bby_loy) AS pv_bby_loy,
    SUM(pv_bby_non_loy) AS pv_bby_non_loy,
    SUM(pv_kdn_bby) AS pv_kdn_bby,
    SUM(pv_kdp_bby) AS pv_kdp_bby,
    SUM(pv_bonrabatt_bby_loy) AS pv_bonrabatt_bby_loy,
    SUM(pv_bonrabatt_bby_non_loy) AS pv_bonrabatt_bby_non_loy
FROM `_artbew1` AS Z
GROUP BY
    mandant_id,
    kjwo_ww,
    wup_id,
    mutter_art_id,
    art_id,
    gp_id,
    aktionsart_id_liste_txt,
    aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt,
    wg_id,
    owg_id,
    hwg_id,
    abt_id;


UPDATE `_hit_the_actions` SET
    aktion_thema_gruppe_id = b.aktion_thema_id FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.kl_art_id,
        B.kjwo_ww,
        MAX(A.aktion_thema_id) AS aktion_thema_id
    FROM dbp_etl_process.bon_aktion_thema_group AS A
    INNER JOIN dbp_data.werbewoche_kl AS B ON A.bon_dat = B.dat
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.kl_art_id,
        B.kjwo_ww
) AS b
WHERE
    `_hit_the_actions`.mandant_id = b.mandant_id AND `_hit_the_actions`.wup_id = b.wup_id AND `_hit_the_actions`.kl_art_id
    = b.kl_art_id AND `_hit_the_actions`.kjwo = b.kjwo_ww;


SELECT *
FROM dbp_data.aktionsart_spr_zu
WHERE aktionsart_id = 'ZKX';


CREATE OR REPLACE TEMPORARY TABLE _distinct_aktionsart AS
SELECT
    mandant_id,
    mutter_art_id,
    value AS aktionsart_id_liste_txt,
    value0 AS aktionsart_bez_liste_txt
FROM (
    SELECT
        t1.mandant_id,
        t1.kjwo_ww,
        t1.wup_id,
        t1.mutter_art_id,
        t1.art_id,
        t1.gp_id,
        t1.aktionsart_id_liste_txt,
        t1.aktionsart_bez_liste_txt,
        t1.aktion_typ_id_liste_txt,
        t1.aktion_typ_bez_liste_txt,
        t1.wg_id,
        t1.owg_id,
        t1.hwg_id,
        t1.abt_id,
        t1.umsatz_netto_sa_west,
        t1.absatz_sa_west,
        t1.ek_mep_sa_west,
        t1.logkostenzuschlag_sa_west_wg30,
        t1.logkostenzuschlag_sa_west,
        t1.preisvorteil_west,
        t1.wa_kalk_nach_pv_sa_west,
        t1.wa_kalk_abschriften_sa_west,
        t1.umsatz_netto_sa_ost,
        t1.absatz_sa_ost,
        t1.ek_mep_sa_ost,
        t1.logkostenzuschlag_sa_ost_wg30,
        t1.logkostenzuschlag_sa_ost,
        t1.preisvorteil_ost,
        t1.wa_kalk_nach_pv_sa_ost,
        t1.wa_kalk_abschriften_sa_ost,
        t1.umsatz_netto_sa_sued,
        t1.absatz_sa_sued,
        t1.ek_mep_sa_sued,
        t1.logkostenzuschlag_sa_sued_wg30,
        t1.logkostenzuschlag_sa_sued,
        t1.preisvorteil_sued,
        t1.wa_kalk_nach_pv_sa_sued,
        t1.wa_kalk_abschriften_sa_sued,
        t1.umsatz_netto_sa,
        t1.absatz_sa,
        t1.ek_mep_sa,
        t1.logkostenzuschlag_sa_wg30,
        t1.logkostenzuschlag_sa,
        t1.preisvorteil,
        t1.wa_kalk_nach_pv_sa,
        t1.wa_kalk_abschriften_sa,
        t1.umsatz_netto_sa_loyalty,
        t1.absatz_sa_loyalty,
        t1.ek_mep_sa_loyalty,
        t1.logkostenzuschlag_sa_loyalty_wg30,
        t1.logkostenzuschlag_sa_loyalty,
        t1.wa_kalk_abschriften_sa_loyalty,
        t1.umsatz_netto_sa_aktion_loyalty,
        t1.absatz_sa_aktion_loyalty,
        t1.ek_mep_sa_aktion_loyalty,
        t1.logkostenzuschlag_sa_aktion_loyalty_wg30,
        t1.logkostenzuschlag_sa_aktion_loyalty,
        t1.wa_kalk_abschriften_sa_aktion_loyalty,
        t1.umsatz_netto_sa_bby_loyalty,
        t1.absatz_sa_bby_loyalty,
        t1.ek_mep_sa_bby_loyalty,
        t1.logkostenzuschlag_sa_bby_loyalty_wg30,
        t1.logkostenzuschlag_sa_bby_loyalty,
        t1.wa_kalk_abschriften_sa_bby_loyalty,
        t1.umsatz_netto_sa_kdn_bby_loyalty,
        t1.absatz_sa_kdn_bby_loyalty,
        t1.ek_mep_sa_kdn_bby_loyalty,
        t1.logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
        t1.logkostenzuschlag_sa_kdn_bby_loyalty,
        t1.wa_kalk_abschriften_sa_kdn_bby_loyalty,
        t1.umsatz_netto_sa_kdp_bby_loyalty,
        t1.absatz_sa_kdp_bby_loyalty,
        t1.ek_mep_sa_kdp_bby_loyalty,
        t1.logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
        t1.logkostenzuschlag_sa_kdp_bby_loyalty,
        t1.wa_kalk_abschriften_sa_kdp_bby_loyalty,
        t1.umsatz_netto_sa_non_loyalty,
        t1.absatz_sa_non_loyalty,
        t1.ek_mep_sa_non_loyalty,
        t1.logkostenzuschlag_sa_non_loyalty_wg30,
        t1.logkostenzuschlag_sa_non_loyalty,
        t1.wa_kalk_abschriften_sa_non_loyalty,
        t1.umsatz_netto_sa_aktion_non_loyalty,
        t1.absatz_sa_aktion_non_loyalty,
        t1.ek_mep_sa_aktion_non_loyalty,
        t1.logkostenzuschlag_sa_aktion_non_loyalty_wg30,
        t1.logkostenzuschlag_sa_aktion_non_loyalty,
        t1.wa_kalk_abschriften_sa_aktion_non_loyalty,
        t1.umsatz_netto_sa_bby_non_loyalty,
        t1.absatz_sa_bby_non_loyalty,
        t1.ek_mep_sa_bby_non_loyalty,
        t1.logkostenzuschlag_sa_bby_non_loyalty_wg30,
        t1.logkostenzuschlag_sa_bby_non_loyalty,
        t1.wa_kalk_abschriften_sa_bby_non_loyalty,
        t1.umsatz_netto_sa_bonrabatt_bby_loyalty,
        t1.absatz_sa_bonrabatt_bby_loyalty,
        t1.ek_mep_sa_bonrabatt_bby_loyalty,
        t1.logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
        t1.logkostenzuschlag_sa_bonrabatt_bby_loyalty,
        t1.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
        t1.umsatz_netto_sa_bonrabatt_bby_non_loyalty,
        t1.absatz_sa_bonrabatt_bby_non_loyalty,
        t1.ek_mep_sa_bonrabatt_bby_non_loyalty,
        t1.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
        t1.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
        t1.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
        t1.pv_aktion_loy,
        t1.pv_aktion_non_loy,
        t1.pv_bby_loy,
        t1.pv_bby_non_loy,
        t1.pv_kdn_bby,
        t1.pv_kdp_bby,
        t1.pv_bonrabatt_bby_loy,
        t1.pv_bonrabatt_bby_non_loy,
        t1.seq,
        t1.index,
        t1.value,
        t1.index AS seq0,
        ORDINALITY + 1 AS index0,
        VALUE AS value0
    FROM (
        SELECT
            A.mandant_id,
            A.kjwo_ww,
            A.wup_id,
            A.mutter_art_id,
            A.art_id,
            A.gp_id,
            A.aktionsart_id_liste_txt,
            A.aktionsart_bez_liste_txt,
            A.aktion_typ_id_liste_txt,
            A.aktion_typ_bez_liste_txt,
            A.wg_id,
            A.owg_id,
            A.hwg_id,
            A.abt_id,
            A.umsatz_netto_sa_west,
            A.absatz_sa_west,
            A.ek_mep_sa_west,
            A.logkostenzuschlag_sa_west_wg30,
            A.logkostenzuschlag_sa_west,
            A.preisvorteil_west,
            A.wa_kalk_nach_pv_sa_west,
            A.wa_kalk_abschriften_sa_west,
            A.umsatz_netto_sa_ost,
            A.absatz_sa_ost,
            A.ek_mep_sa_ost,
            A.logkostenzuschlag_sa_ost_wg30,
            A.logkostenzuschlag_sa_ost,
            A.preisvorteil_ost,
            A.wa_kalk_nach_pv_sa_ost,
            A.wa_kalk_abschriften_sa_ost,
            A.umsatz_netto_sa_sued,
            A.absatz_sa_sued,
            A.ek_mep_sa_sued,
            A.logkostenzuschlag_sa_sued_wg30,
            A.logkostenzuschlag_sa_sued,
            A.preisvorteil_sued,
            A.wa_kalk_nach_pv_sa_sued,
            A.wa_kalk_abschriften_sa_sued,
            A.umsatz_netto_sa,
            A.absatz_sa,
            A.ek_mep_sa,
            A.logkostenzuschlag_sa_wg30,
            A.logkostenzuschlag_sa,
            A.preisvorteil,
            A.wa_kalk_nach_pv_sa,
            A.wa_kalk_abschriften_sa,
            A.umsatz_netto_sa_loyalty,
            A.absatz_sa_loyalty,
            A.ek_mep_sa_loyalty,
            A.logkostenzuschlag_sa_loyalty_wg30,
            A.logkostenzuschlag_sa_loyalty,
            A.wa_kalk_abschriften_sa_loyalty,
            A.umsatz_netto_sa_aktion_loyalty,
            A.absatz_sa_aktion_loyalty,
            A.ek_mep_sa_aktion_loyalty,
            A.logkostenzuschlag_sa_aktion_loyalty_wg30,
            A.logkostenzuschlag_sa_aktion_loyalty,
            A.wa_kalk_abschriften_sa_aktion_loyalty,
            A.umsatz_netto_sa_bby_loyalty,
            A.absatz_sa_bby_loyalty,
            A.ek_mep_sa_bby_loyalty,
            A.logkostenzuschlag_sa_bby_loyalty_wg30,
            A.logkostenzuschlag_sa_bby_loyalty,
            A.wa_kalk_abschriften_sa_bby_loyalty,
            A.umsatz_netto_sa_kdn_bby_loyalty,
            A.absatz_sa_kdn_bby_loyalty,
            A.ek_mep_sa_kdn_bby_loyalty,
            A.logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
            A.logkostenzuschlag_sa_kdn_bby_loyalty,
            A.wa_kalk_abschriften_sa_kdn_bby_loyalty,
            A.umsatz_netto_sa_kdp_bby_loyalty,
            A.absatz_sa_kdp_bby_loyalty,
            A.ek_mep_sa_kdp_bby_loyalty,
            A.logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
            A.logkostenzuschlag_sa_kdp_bby_loyalty,
            A.wa_kalk_abschriften_sa_kdp_bby_loyalty,
            A.umsatz_netto_sa_non_loyalty,
            A.absatz_sa_non_loyalty,
            A.ek_mep_sa_non_loyalty,
            A.logkostenzuschlag_sa_non_loyalty_wg30,
            A.logkostenzuschlag_sa_non_loyalty,
            A.wa_kalk_abschriften_sa_non_loyalty,
            A.umsatz_netto_sa_aktion_non_loyalty,
            A.absatz_sa_aktion_non_loyalty,
            A.ek_mep_sa_aktion_non_loyalty,
            A.logkostenzuschlag_sa_aktion_non_loyalty_wg30,
            A.logkostenzuschlag_sa_aktion_non_loyalty,
            A.wa_kalk_abschriften_sa_aktion_non_loyalty,
            A.umsatz_netto_sa_bby_non_loyalty,
            A.absatz_sa_bby_non_loyalty,
            A.ek_mep_sa_bby_non_loyalty,
            A.logkostenzuschlag_sa_bby_non_loyalty_wg30,
            A.logkostenzuschlag_sa_bby_non_loyalty,
            A.wa_kalk_abschriften_sa_bby_non_loyalty,
            A.umsatz_netto_sa_bonrabatt_bby_loyalty,
            A.absatz_sa_bonrabatt_bby_loyalty,
            A.ek_mep_sa_bonrabatt_bby_loyalty,
            A.logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
            A.logkostenzuschlag_sa_bonrabatt_bby_loyalty,
            A.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
            A.umsatz_netto_sa_bonrabatt_bby_non_loyalty,
            A.absatz_sa_bonrabatt_bby_non_loyalty,
            A.ek_mep_sa_bonrabatt_bby_non_loyalty,
            A.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
            A.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
            A.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
            A.pv_aktion_loy,
            A.pv_aktion_non_loy,
            A.pv_bby_loy,
            A.pv_bby_non_loy,
            A.pv_kdn_bby,
            A.pv_kdp_bby,
            A.pv_bonrabatt_bby_loy,
            A.pv_bonrabatt_bby_non_loy,
            t.seq,
            ORDINALITY + 1 AS index,
            VALUE AS value
        FROM `_artbew2` AS A
        INNER JOIN (SELECT 1 AS seq) AS t ON TRUE
        INNER JOIN UNNEST(SPLIT(A.AKTIONSART_ID_LISTE_TXT, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE
    ) AS t1
    INNER JOIN (SELECT 1 AS seq) AS t2 ON TRUE
    INNER JOIN UNNEST(SPLIT(t1.AKTIONSART_BEZ_LISTE_TXT, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE
) AS t4
WHERE t4.value <> ''  and     t4.value0 <> ''
GROUP BY
    mandant_id,
    mutter_art_id,
    aktionsart_id_liste_txt,
    aktionsart_bez_liste_txt;


CREATE OR REPLACE TEMPORARY TABLE _distinct_aktionsart2 AS
SELECT
    x.mandant_id,
    x.mutter_art_id,
    MAX(x.aktionsart_id_liste_txt_) AS aktionsart_id_liste_txt,
    MAX(x.aktionsart_bez_liste_txt_) AS aktionsart_bez_liste_txt
FROM (
    SELECT
        mandant_id,
        mutter_art_id,
        RTRIM(STRING_AGG(DISTINCT aktionsart_id_liste_txt, ','), ',') AS aktionsart_id_liste_txt_,
        RTRIM(STRING_AGG(DISTINCT aktionsart_bez_liste_txt, ','), ',') AS aktionsart_bez_liste_txt_,
        LENGTH(RTRIM(STRING_AGG(DISTINCT aktionsart_id_liste_txt, ','), ',')) AS anz
    FROM `_distinct_aktionsart`
    GROUP BY
        mandant_id,
        mutter_art_id
) AS x
INNER JOIN (
    SELECT
        mandant_id,
        mutter_art_id,
        MAX(anz) AS anz
    FROM (
        SELECT
            mandant_id,
            mutter_art_id,
            LENGTH(RTRIM(STRING_AGG(DISTINCT aktionsart_id_liste_txt, ','), ',')) AS anz
        FROM `_distinct_aktionsart`
        GROUP BY
            mandant_id,
            mutter_art_id
    ) AS x
    GROUP BY
        mandant_id,
        mutter_art_id
) AS y ON x.mandant_id = y.mandant_id AND x.mutter_art_id = y.mutter_art_id AND x.anz = y.anz
GROUP BY
    x.mandant_id,
    x.mutter_art_id;


CREATE OR REPLACE TEMPORARY TABLE _distinct_aktiontyp AS
SELECT
    mandant_id,
    mutter_art_id,
    value AS aktion_typ_id_liste_txt,
    value0 AS aktion_typ_bez_liste_txt
FROM (
    SELECT
        t1.mandant_id,
        t1.kjwo_ww,
        t1.wup_id,
        t1.mutter_art_id,
        t1.art_id,
        t1.gp_id,
        t1.aktionsart_id_liste_txt,
        t1.aktionsart_bez_liste_txt,
        t1.aktion_typ_id_liste_txt,
        t1.aktion_typ_bez_liste_txt,
        t1.wg_id,
        t1.owg_id,
        t1.hwg_id,
        t1.abt_id,
        t1.umsatz_netto_sa_west,
        t1.absatz_sa_west,
        t1.ek_mep_sa_west,
        t1.logkostenzuschlag_sa_west_wg30,
        t1.logkostenzuschlag_sa_west,
        t1.preisvorteil_west,
        t1.wa_kalk_nach_pv_sa_west,
        t1.wa_kalk_abschriften_sa_west,
        t1.umsatz_netto_sa_ost,
        t1.absatz_sa_ost,
        t1.ek_mep_sa_ost,
        t1.logkostenzuschlag_sa_ost_wg30,
        t1.logkostenzuschlag_sa_ost,
        t1.preisvorteil_ost,
        t1.wa_kalk_nach_pv_sa_ost,
        t1.wa_kalk_abschriften_sa_ost,
        t1.umsatz_netto_sa_sued,
        t1.absatz_sa_sued,
        t1.ek_mep_sa_sued,
        t1.logkostenzuschlag_sa_sued_wg30,
        t1.logkostenzuschlag_sa_sued,
        t1.preisvorteil_sued,
        t1.wa_kalk_nach_pv_sa_sued,
        t1.wa_kalk_abschriften_sa_sued,
        t1.umsatz_netto_sa,
        t1.absatz_sa,
        t1.ek_mep_sa,
        t1.logkostenzuschlag_sa_wg30,
        t1.logkostenzuschlag_sa,
        t1.preisvorteil,
        t1.wa_kalk_nach_pv_sa,
        t1.wa_kalk_abschriften_sa,
        t1.umsatz_netto_sa_loyalty,
        t1.absatz_sa_loyalty,
        t1.ek_mep_sa_loyalty,
        t1.logkostenzuschlag_sa_loyalty_wg30,
        t1.logkostenzuschlag_sa_loyalty,
        t1.wa_kalk_abschriften_sa_loyalty,
        t1.umsatz_netto_sa_aktion_loyalty,
        t1.absatz_sa_aktion_loyalty,
        t1.ek_mep_sa_aktion_loyalty,
        t1.logkostenzuschlag_sa_aktion_loyalty_wg30,
        t1.logkostenzuschlag_sa_aktion_loyalty,
        t1.wa_kalk_abschriften_sa_aktion_loyalty,
        t1.umsatz_netto_sa_bby_loyalty,
        t1.absatz_sa_bby_loyalty,
        t1.ek_mep_sa_bby_loyalty,
        t1.logkostenzuschlag_sa_bby_loyalty_wg30,
        t1.logkostenzuschlag_sa_bby_loyalty,
        t1.wa_kalk_abschriften_sa_bby_loyalty,
        t1.umsatz_netto_sa_kdn_bby_loyalty,
        t1.absatz_sa_kdn_bby_loyalty,
        t1.ek_mep_sa_kdn_bby_loyalty,
        t1.logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
        t1.logkostenzuschlag_sa_kdn_bby_loyalty,
        t1.wa_kalk_abschriften_sa_kdn_bby_loyalty,
        t1.umsatz_netto_sa_kdp_bby_loyalty,
        t1.absatz_sa_kdp_bby_loyalty,
        t1.ek_mep_sa_kdp_bby_loyalty,
        t1.logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
        t1.logkostenzuschlag_sa_kdp_bby_loyalty,
        t1.wa_kalk_abschriften_sa_kdp_bby_loyalty,
        t1.umsatz_netto_sa_non_loyalty,
        t1.absatz_sa_non_loyalty,
        t1.ek_mep_sa_non_loyalty,
        t1.logkostenzuschlag_sa_non_loyalty_wg30,
        t1.logkostenzuschlag_sa_non_loyalty,
        t1.wa_kalk_abschriften_sa_non_loyalty,
        t1.umsatz_netto_sa_aktion_non_loyalty,
        t1.absatz_sa_aktion_non_loyalty,
        t1.ek_mep_sa_aktion_non_loyalty,
        t1.logkostenzuschlag_sa_aktion_non_loyalty_wg30,
        t1.logkostenzuschlag_sa_aktion_non_loyalty,
        t1.wa_kalk_abschriften_sa_aktion_non_loyalty,
        t1.umsatz_netto_sa_bby_non_loyalty,
        t1.absatz_sa_bby_non_loyalty,
        t1.ek_mep_sa_bby_non_loyalty,
        t1.logkostenzuschlag_sa_bby_non_loyalty_wg30,
        t1.logkostenzuschlag_sa_bby_non_loyalty,
        t1.wa_kalk_abschriften_sa_bby_non_loyalty,
        t1.umsatz_netto_sa_bonrabatt_bby_loyalty,
        t1.absatz_sa_bonrabatt_bby_loyalty,
        t1.ek_mep_sa_bonrabatt_bby_loyalty,
        t1.logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
        t1.logkostenzuschlag_sa_bonrabatt_bby_loyalty,
        t1.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
        t1.umsatz_netto_sa_bonrabatt_bby_non_loyalty,
        t1.absatz_sa_bonrabatt_bby_non_loyalty,
        t1.ek_mep_sa_bonrabatt_bby_non_loyalty,
        t1.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
        t1.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
        t1.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
        t1.pv_aktion_loy,
        t1.pv_aktion_non_loy,
        t1.pv_bby_loy,
        t1.pv_bby_non_loy,
        t1.pv_kdn_bby,
        t1.pv_kdp_bby,
        t1.pv_bonrabatt_bby_loy,
        t1.pv_bonrabatt_bby_non_loy,
        t1.seq,
        t1.index,
        t1.value,
        t1.index AS seq0,
        ORDINALITY + 1 AS index0,
        VALUE AS value0
    FROM (
        SELECT
            A.mandant_id,
            A.kjwo_ww,
            A.wup_id,
            A.mutter_art_id,
            A.art_id,
            A.gp_id,
            A.aktionsart_id_liste_txt,
            A.aktionsart_bez_liste_txt,
            A.aktion_typ_id_liste_txt,
            A.aktion_typ_bez_liste_txt,
            A.wg_id,
            A.owg_id,
            A.hwg_id,
            A.abt_id,
            A.umsatz_netto_sa_west,
            A.absatz_sa_west,
            A.ek_mep_sa_west,
            A.logkostenzuschlag_sa_west_wg30,
            A.logkostenzuschlag_sa_west,
            A.preisvorteil_west,
            A.wa_kalk_nach_pv_sa_west,
            A.wa_kalk_abschriften_sa_west,
            A.umsatz_netto_sa_ost,
            A.absatz_sa_ost,
            A.ek_mep_sa_ost,
            A.logkostenzuschlag_sa_ost_wg30,
            A.logkostenzuschlag_sa_ost,
            A.preisvorteil_ost,
            A.wa_kalk_nach_pv_sa_ost,
            A.wa_kalk_abschriften_sa_ost,
            A.umsatz_netto_sa_sued,
            A.absatz_sa_sued,
            A.ek_mep_sa_sued,
            A.logkostenzuschlag_sa_sued_wg30,
            A.logkostenzuschlag_sa_sued,
            A.preisvorteil_sued,
            A.wa_kalk_nach_pv_sa_sued,
            A.wa_kalk_abschriften_sa_sued,
            A.umsatz_netto_sa,
            A.absatz_sa,
            A.ek_mep_sa,
            A.logkostenzuschlag_sa_wg30,
            A.logkostenzuschlag_sa,
            A.preisvorteil,
            A.wa_kalk_nach_pv_sa,
            A.wa_kalk_abschriften_sa,
            A.umsatz_netto_sa_loyalty,
            A.absatz_sa_loyalty,
            A.ek_mep_sa_loyalty,
            A.logkostenzuschlag_sa_loyalty_wg30,
            A.logkostenzuschlag_sa_loyalty,
            A.wa_kalk_abschriften_sa_loyalty,
            A.umsatz_netto_sa_aktion_loyalty,
            A.absatz_sa_aktion_loyalty,
            A.ek_mep_sa_aktion_loyalty,
            A.logkostenzuschlag_sa_aktion_loyalty_wg30,
            A.logkostenzuschlag_sa_aktion_loyalty,
            A.wa_kalk_abschriften_sa_aktion_loyalty,
            A.umsatz_netto_sa_bby_loyalty,
            A.absatz_sa_bby_loyalty,
            A.ek_mep_sa_bby_loyalty,
            A.logkostenzuschlag_sa_bby_loyalty_wg30,
            A.logkostenzuschlag_sa_bby_loyalty,
            A.wa_kalk_abschriften_sa_bby_loyalty,
            A.umsatz_netto_sa_kdn_bby_loyalty,
            A.absatz_sa_kdn_bby_loyalty,
            A.ek_mep_sa_kdn_bby_loyalty,
            A.logkostenzuschlag_sa_kdn_bby_loyalty_wg30,
            A.logkostenzuschlag_sa_kdn_bby_loyalty,
            A.wa_kalk_abschriften_sa_kdn_bby_loyalty,
            A.umsatz_netto_sa_kdp_bby_loyalty,
            A.absatz_sa_kdp_bby_loyalty,
            A.ek_mep_sa_kdp_bby_loyalty,
            A.logkostenzuschlag_sa_kdp_bby_loyalty_wg30,
            A.logkostenzuschlag_sa_kdp_bby_loyalty,
            A.wa_kalk_abschriften_sa_kdp_bby_loyalty,
            A.umsatz_netto_sa_non_loyalty,
            A.absatz_sa_non_loyalty,
            A.ek_mep_sa_non_loyalty,
            A.logkostenzuschlag_sa_non_loyalty_wg30,
            A.logkostenzuschlag_sa_non_loyalty,
            A.wa_kalk_abschriften_sa_non_loyalty,
            A.umsatz_netto_sa_aktion_non_loyalty,
            A.absatz_sa_aktion_non_loyalty,
            A.ek_mep_sa_aktion_non_loyalty,
            A.logkostenzuschlag_sa_aktion_non_loyalty_wg30,
            A.logkostenzuschlag_sa_aktion_non_loyalty,
            A.wa_kalk_abschriften_sa_aktion_non_loyalty,
            A.umsatz_netto_sa_bby_non_loyalty,
            A.absatz_sa_bby_non_loyalty,
            A.ek_mep_sa_bby_non_loyalty,
            A.logkostenzuschlag_sa_bby_non_loyalty_wg30,
            A.logkostenzuschlag_sa_bby_non_loyalty,
            A.wa_kalk_abschriften_sa_bby_non_loyalty,
            A.umsatz_netto_sa_bonrabatt_bby_loyalty,
            A.absatz_sa_bonrabatt_bby_loyalty,
            A.ek_mep_sa_bonrabatt_bby_loyalty,
            A.logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30,
            A.logkostenzuschlag_sa_bonrabatt_bby_loyalty,
            A.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty,
            A.umsatz_netto_sa_bonrabatt_bby_non_loyalty,
            A.absatz_sa_bonrabatt_bby_non_loyalty,
            A.ek_mep_sa_bonrabatt_bby_non_loyalty,
            A.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30,
            A.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty,
            A.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty,
            A.pv_aktion_loy,
            A.pv_aktion_non_loy,
            A.pv_bby_loy,
            A.pv_bby_non_loy,
            A.pv_kdn_bby,
            A.pv_kdp_bby,
            A.pv_bonrabatt_bby_loy,
            A.pv_bonrabatt_bby_non_loy,
            t.seq,
            ORDINALITY + 1 AS index,
            VALUE AS value
        FROM `_artbew2` AS A
        INNER JOIN (SELECT 1 AS seq) AS t ON TRUE
        INNER JOIN UNNEST(SPLIT(A.AKTION_TYP_ID_LISTE_TXT, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE
    ) AS t1
    INNER JOIN (SELECT 1 AS seq) AS t2 ON TRUE
    INNER JOIN UNNEST(SPLIT(t1.AKTION_TYP_BEZ_LISTE_TXT, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE
) AS t4
WHERE t4.value <> ' and\n      t.value <> '
GROUP BY
    mandant_id,
    mutter_art_id,
    aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt;


CREATE OR REPLACE TEMPORARY TABLE _distinct_aktiontyp2 AS
SELECT
    x.mandant_id,
    x.mutter_art_id,
    MAX(x.aktion_typ_id_liste_txt_) AS aktion_typ_id_liste_txt,
    MAX(x.aktion_typ_bez_liste_txt_) AS aktion_typ_bez_liste_txt
FROM (
    SELECT
        mandant_id,
        mutter_art_id,
        RTRIM(STRING_AGG(DISTINCT aktion_typ_id_liste_txt, ','), ',') AS aktion_typ_id_liste_txt_,
        RTRIM(STRING_AGG(DISTINCT aktion_typ_bez_liste_txt, ','), ',') AS aktion_typ_bez_liste_txt_,
        LENGTH(')') AS anz
    FROM `_distinct_aktiontyp`
    GROUP BY
        mandant_id,
        mutter_art_id
) AS x
INNER JOIN (
    SELECT
        mandant_id,
        mutter_art_id,
        MAX(anz) AS anz
    FROM (
        SELECT
            mandant_id,
            mutter_art_id,
            LENGTH(')') AS anz
        FROM `_distinct_aktiontyp`
        GROUP BY
            mandant_id,
            mutter_art_id
    ) AS x
    GROUP BY
        mandant_id,
        mutter_art_id
) AS y ON x.mandant_id = y.mandant_id AND x.mutter_art_id = y.mutter_art_id AND x.anz = y.anz
GROUP BY
    x.mandant_id,
    x.mutter_art_id;


CREATE OR REPLACE TEMPORARY TABLE _distinct_art1 AS
SELECT
    mandant_id,
    mutter_art_id,
    art_id
FROM `_artbew2`
GROUP BY
    mandant_id,
    mutter_art_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _distinct_art2 AS
SELECT
    x.mandant_id,
    x.mutter_art_id,
    MAX(x.kl_art_id_) AS kl_art_id
FROM (
    SELECT
        mandant_id,
        mutter_art_id,
        TRANSLATE(RTRIM(STRING_AGG(CAST(CAST(art_id / 100 AS NUMERIC) AS STRING), ',' ORDER BY CAST(art_id / 100 AS NUMERIC) IS NULL, CAST(art_id / 100 AS NUMERIC)), ','), ' ', '') AS kl_art_id_,
        LENGTH(TRANSLATE(RTRIM(STRING_AGG(CAST(CAST(art_id / 100 AS NUMERIC) AS STRING), ',' ORDER BY CAST(art_id / 100 AS NUMERIC) IS NULL, CAST(art_id / 100 AS NUMERIC)), ','), ' ', '')) AS anz
    FROM `_distinct_art1`
    GROUP BY
        mandant_id,
        mutter_art_id
) AS x
INNER JOIN (
    SELECT
        mandant_id,
        mutter_art_id,
        MAX(anz) AS anz
    FROM (
        SELECT
            mandant_id,
            mutter_art_id,
            LENGTH(TRANSLATE(RTRIM(STRING_AGG(CAST(CAST(art_id / 100 AS NUMERIC) AS STRING), ',' ORDER BY CAST(art_id / 100 AS NUMERIC) IS NULL, CAST(art_id / 100 AS NUMERIC)), ','), ' ', '')) AS anz
        FROM `_distinct_art1`
        GROUP BY
            mandant_id,
            mutter_art_id
    ) AS x
    GROUP BY
        mandant_id,
        mutter_art_id
) AS y ON x.mandant_id = y.mandant_id AND x.mutter_art_id = y.mutter_art_id AND x.anz = y.anz
GROUP BY
    x.mandant_id,
    x.mutter_art_id;


CREATE OR REPLACE TEMPORARY TABLE _distinct_aktion_thema1 AS
SELECT
    A.mandant_id,
    A.art_id AS mutter_art_id,
    B.art_id,
    A.wup_id,
    A.aktion_thema_gruppe_id
FROM `_hit_the_actions` AS A
INNER JOIN dbp_data.art AS B
    ON
        A.mandant_id = B.mandant_id AND A.kl_art_id = B.kl_art_id AND B.dat_bis
        = DATE '9999-12-31'
GROUP BY
    A.mandant_id,
    mutter_art_id,
    B.art_id,
    A.wup_id,
    A.aktion_thema_gruppe_id;


CREATE OR REPLACE TEMPORARY TABLE _distinct_aktion_thema2 AS
SELECT
    mandant_id,
    mutter_art_id,
    art_id,
    wup_id,
    MAX(aktion_thema_gruppe_id) AS aktion_thema_gruppe_id
FROM `_distinct_aktion_thema1` AS A
GROUP BY
    mandant_id,
    mutter_art_id,
    art_id,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _distinct_wg1 AS
SELECT
    mandant_id,
    mutter_art_id,
    wg_id
FROM `_artbew2`
GROUP BY
    mandant_id,
    mutter_art_id,
    wg_id;


CREATE OR REPLACE TEMPORARY TABLE _distinct_wg2 AS
SELECT
    x.mandant_id,
    x.mutter_art_id,
    MAX(x.wg_id_) AS wg_id
FROM (
    SELECT
        mandant_id,
        mutter_art_id,
        TRANSLATE(RTRIM(STRING_AGG(CAST(wg_id AS STRING), ',' ORDER BY wg_id IS NULL, wg_id), ','), ' ', '') AS wg_id_,
        LENGTH(TRANSLATE(RTRIM(STRING_AGG(CAST(wg_id AS STRING), ',' ORDER BY wg_id IS NULL, wg_id), ','), ' ', '')) AS anz
    FROM `_distinct_wg1`
    GROUP BY
        mandant_id,
        mutter_art_id
) AS x
INNER JOIN (
    SELECT
        mandant_id,
        mutter_art_id,
        MAX(anz) AS anz
    FROM (
        SELECT
            mandant_id,
            mutter_art_id,
            LENGTH(TRANSLATE(RTRIM(STRING_AGG(CAST(wg_id AS STRING), ',' ORDER BY wg_id IS NULL, wg_id), ','), ' ', '')) AS anz

        FROM `_distinct_wg1`
        GROUP BY
            mandant_id,
            mutter_art_id
    ) AS x
    GROUP BY
        mandant_id,
        mutter_art_id
) AS y ON x.mandant_id = y.mandant_id AND x.mutter_art_id = y.mutter_art_id AND x.anz = y.anz
GROUP BY
    x.mandant_id,
    x.mutter_art_id;


CREATE OR REPLACE TEMPORARY TABLE _distinct_werbe_kat1 AS
SELECT
    mandant_id,
    art_id AS mutter_art_id,
    werbe_kat_id
FROM `_hit_the_actions`
GROUP BY
    mandant_id,
    mutter_art_id,
    werbe_kat_id;


CREATE OR REPLACE TEMPORARY TABLE _distinct_werbe_kat2 AS
SELECT
    x.mandant_id,
    x.mutter_art_id,
    MAX(x.werbe_kat_id_) AS werbe_kat_id
FROM (
    SELECT
        mandant_id,
        mutter_art_id,
        TRANSLATE(
            RTRIM(STRING_AGG(CAST(werbe_kat_id AS STRING), ',' ORDER BY werbe_kat_id IS NULL, werbe_kat_id), ','), ' ',
            ''
        ) AS werbe_kat_id_,
        LENGTH(TRANSLATE(
            RTRIM(STRING_AGG(CAST(werbe_kat_id AS STRING), ',' ORDER BY werbe_kat_id IS NULL, werbe_kat_id), ','
            ), ' ', ''
        )) AS anz
    FROM `_distinct_werbe_kat1`
    GROUP BY
        mandant_id,
        mutter_art_id
) AS x
INNER JOIN (
    SELECT
        mandant_id,
        mutter_art_id,
        MAX(anz) AS anz
    FROM (
        SELECT
            mandant_id,
            mutter_art_id,
            LENGTH(TRANSLATE(RTRIM(
                STRING_AGG(CAST(werbe_kat_id AS STRING), ',' ORDER BY werbe_kat_id IS NULL, werbe_kat_id),
                ','
            ), ' ', '')) AS anz
        FROM `_distinct_werbe_kat1`
        GROUP BY
            mandant_id,
            mutter_art_id
    ) AS x
    GROUP BY
        mandant_id,
        mutter_art_id
) AS y ON x.mandant_id = y.mandant_id AND x.mutter_art_id = y.mutter_art_id AND x.anz = y.anz
GROUP BY
    x.mandant_id,
    x.mutter_art_id;


CREATE OR REPLACE TEMPORARY TABLE _artbew4 AS
-- sa_loyalty --
-- sa_aktion_loyalty --
-- sa_bby_loyalty --
-- sa_kdn_bby_loyalty --
-- sa_kdp_bby_loyalty --

-- sa_non_loyalty --
-- sa_aktion_non_loyalty --
-- sa_bby_non_loyalty --
-- sa_bonrabatt_bby_loyalty --

-- sa_bonrabatt_bby_non_loyalty --
SELECT
    A.mandant_id,
    akt_woche AS kjwo_ww,
    A.kjwo_ww AS kjwo,
    A.mutter_art_id,
    B.kl_art_id,
    COALESCE(c.aktion_thema_gruppe_id, '') AS aktion_thema_gruppe_id,
    E.werbe_kat_id,
    A.gp_id,
    F.aktionsart_id_liste_txt,
    F.aktionsart_bez_liste_txt,
    G.aktion_typ_id_liste_txt,
    G.aktion_typ_bez_liste_txt,
    D.wg_id,
    SUM(A.umsatz_netto_sa_west) AS umsatz_netto_sa_west_,
    SUM(A.absatz_sa_west) AS absatz_sa_west_,
    SUM(A.ek_mep_sa_west) AS ek_mep_sa_west_,
    SUM(0) AS logkostenzuschlag_sa_west_wg30_,
    SUM(A.logkostenzuschlag_sa_west) AS logkostenzuschlag_sa_west_,
    SUM(
        A.umsatz_netto_sa_west) - (SUM(A.ek_mep_sa_west) + SUM(0) - SUM(A.logkostenzuschlag_sa_west)) AS
    rohertrag_sa_west_,
    (
        SUM(A.umsatz_netto_sa_west) - (SUM(A.ek_mep_sa_west) + SUM(0) - SUM(A.logkostenzuschlag_sa_west))) / IF(
        SUM(A.umsatz_netto_sa_west
        ) = 0, NULL, SUM(A.umsatz_netto_sa_west)
    ) * 100 AS spanne_sa_west_,
    SUM(A.preisvorteil_west) AS preisvorteil_west,
    SUM(COALESCE(A.wa_kalk_abschriften_sa_west, 0)) AS wa_kalk_abschriften_sa_west_,
    SUM(A.umsatz_netto_sa_west) - (SUM(
        A.ek_mep_sa_west) + SUM(0) - SUM(A.logkostenzuschlag_sa_west)) - SUM(COALESCE(
        A.wa_kalk_abschriften_sa_west,
        0
    )) AS wa_kalk_nach_pv_sa_west_,
    (SUM(A.umsatz_netto_sa_west) - (SUM(A.ek_mep_sa_west) + SUM(0) - SUM(A.logkostenzuschlag_sa_west)) - SUM(COALESCE(A.wa_kalk_abschriften_sa_west, 0))) / IF(SUM(A.umsatz_netto_sa_west) = 0, NULL, SUM(A.umsatz_netto_sa_west)) * 100
        AS spanne_wa_kalk_nach_pv_sa_west_,
    SUM(A.umsatz_netto_sa_ost) AS umsatz_netto_sa_ost_,
    SUM(A.absatz_sa_ost) AS absatz_sa_ost_,
    SUM(A.ek_mep_sa_ost) AS ek_mep_sa_ost_,
    SUM(0) AS logkostenzuschlag_sa_ost_wg30_,
    SUM(A.logkostenzuschlag_sa_ost) AS logkostenzuschlag_sa_ost_,
    SUM(A.umsatz_netto_sa_ost) - (SUM(A.ek_mep_sa_ost) + SUM(0) - SUM(A.logkostenzuschlag_sa_ost)) AS rohertrag_sa_ost_,
    (
        SUM(A.umsatz_netto_sa_ost) - (SUM(A.ek_mep_sa_ost) + SUM(0) - SUM(A.logkostenzuschlag_sa_ost))) / IF(
        SUM(A.umsatz_netto_sa_ost
        ) = 0, NULL, SUM(A.umsatz_netto_sa_ost)
    ) * 100 AS spanne_sa_ost_,
    SUM(A.preisvorteil_ost) AS preisvorteil_ost,
    SUM(COALESCE(A.wa_kalk_abschriften_sa_ost, 0)) AS wa_kalk_abschriften_sa_ost_,
    SUM(A.umsatz_netto_sa_ost) - (SUM(
        A.ek_mep_sa_ost) + SUM(0) - SUM(A.logkostenzuschlag_sa_ost)) - SUM(COALESCE(
        A.wa_kalk_abschriften_sa_ost,
        0
    )) AS wa_kalk_nach_pv_sa_ost_,
    (SUM(A.umsatz_netto_sa_ost) - (SUM(
        A.ek_mep_sa_ost) + SUM(0) - SUM(A.logkostenzuschlag_sa_ost)) - SUM(COALESCE(
        A.wa_kalk_abschriften_sa_ost,
        0
    ))) / IF(SUM(A.umsatz_netto_sa_ost) = 0, NULL, SUM(A.umsatz_netto_sa_ost)) * 100 AS
    spanne_wa_kalk_nach_pv_sa_ost_,
    SUM(A.umsatz_netto_sa_sued) AS umsatz_netto_sa_sued_,
    SUM(A.absatz_sa_sued) AS absatz_sa_sued_,
    SUM(A.ek_mep_sa_sued) AS ek_mep_sa_sued_,
    SUM(0) AS logkostenzuschlag_sa_sued_wg30_,
    SUM(A.logkostenzuschlag_sa_sued) AS logkostenzuschlag_sa_sued_,
    SUM(
        A.umsatz_netto_sa_sued) - (SUM(A.ek_mep_sa_sued) + SUM(0) - SUM(A.logkostenzuschlag_sa_sued)) AS
    rohertrag_sa_sued_,
    (
        SUM(A.umsatz_netto_sa_sued) - (SUM(A.ek_mep_sa_sued) + SUM(0) - SUM(A.logkostenzuschlag_sa_sued))) / IF(
        SUM(A.umsatz_netto_sa_sued
        ) = 0, NULL, SUM(A.umsatz_netto_sa_sued)
    ) * 100 AS spanne_sa_sued_,
    SUM(A.preisvorteil_sued) AS preisvorteil_sued,
    SUM(COALESCE(A.wa_kalk_abschriften_sa_sued, 0)) AS wa_kalk_abschriften_sa_sued_,
    SUM(A.umsatz_netto_sa_sued) - (SUM(
        A.ek_mep_sa_sued) + SUM(0) - SUM(A.logkostenzuschlag_sa_sued)) - SUM(COALESCE(
        A.wa_kalk_abschriften_sa_sued,
        0
    )) AS wa_kalk_nach_pv_sa_sued_,
    (SUM(A.umsatz_netto_sa_sued) - (SUM(A.ek_mep_sa_sued) + SUM(0) - SUM(A.logkostenzuschlag_sa_sued)) - SUM(COALESCE(A.wa_kalk_abschriften_sa_sued, 0))) / IF(SUM(A.umsatz_netto_sa_sued) = 0, NULL, SUM(A.umsatz_netto_sa_sued)) * 100
        AS spanne_wa_kalk_nach_pv_sa_sued_,
    SUM(A.umsatz_netto_sa) AS umsatz_netto_sa_,
    SUM(A.absatz_sa) AS absatz_sa_,
    SUM(A.ek_mep_sa) AS ek_mep_sa_,
    SUM(0) AS logkostenzuschlag_sa_wg30_,
    SUM(A.logkostenzuschlag_sa) AS logkostenzuschlag_sa_,
    SUM(A.umsatz_netto_sa) - (SUM(A.ek_mep_sa) + SUM(0) - SUM(A.logkostenzuschlag_sa)) AS rohertrag_sa_,
    (
        SUM(A.umsatz_netto_sa) - (SUM(A.ek_mep_sa) + SUM(0) - SUM(A.logkostenzuschlag_sa))) / IF(
        SUM(A.umsatz_netto_sa) = 0,
        NULL, SUM(A.umsatz_netto_sa)
    ) * 100 AS spanne_sa_,
    SUM(A.preisvorteil) AS preisvorteil,
    SUM(COALESCE(A.wa_kalk_abschriften_sa, 0)) AS wa_kalk_abschriften_sa_,
    SUM(A.umsatz_netto_sa) - (SUM(
        A.ek_mep_sa) + SUM(0) - SUM(A.logkostenzuschlag_sa)) - SUM(COALESCE(
        A.wa_kalk_abschriften_sa,
        0
    )) AS wa_kalk_nach_pv_sa_,
    (SUM(A.umsatz_netto_sa) - (SUM(
        A.ek_mep_sa) + SUM(0) - SUM(A.logkostenzuschlag_sa)) - SUM(COALESCE(
        A.wa_kalk_abschriften_sa,
        0
    ))) / IF(SUM(A.umsatz_netto_sa) = 0, NULL, SUM(A.umsatz_netto_sa)) * 100 AS spanne_wa_kalk_nach_pv_sa_,
    SUM(A.umsatz_netto_sa_loyalty) AS umsatz_netto_sa_loyalty_,
    SUM(A.absatz_sa_loyalty) AS absatz_sa_loyalty_,
    SUM(A.ek_mep_sa_loyalty) AS ek_mep_sa_loyalty_,
    SUM(0) AS logkostenzuschlag_sa_loyalty_wg30_,
    SUM(A.logkostenzuschlag_sa_loyalty) AS logkostenzuschlag_sa_loyalty_,
    SUM(
        A.umsatz_netto_sa_loyalty) - (SUM(A.ek_mep_sa_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_loyalty)) AS
    rohertrag_sa_loyalty_,
    SUM(COALESCE(A.wa_kalk_abschriften_sa_loyalty, 0)) AS wa_kalk_abschriften_sa_loyalty_,
    SUM(A.umsatz_netto_sa_loyalty) - (SUM(A.ek_mep_sa_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_loyalty)) - SUM(COALESCE(A.wa_kalk_abschriften_sa_loyalty, 0)) AS wa_kalk_nach_pv_sa_loyalty_,
    (
        SUM(A.umsatz_netto_sa_loyalty) - (SUM(A.ek_mep_sa_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_loyalty)) - SUM(COALESCE(A.wa_kalk_abschriften_sa_loyalty, 0))) / IF(
        SUM(A.umsatz_netto_sa_loyalty) = 0, NULL, SUM(A.umsatz_netto_sa_loyalty
        )
    ) * 100 AS spanne_wa_kalk_nach_pv_sa_loyalty_,
    SUM(A.umsatz_netto_sa_aktion_loyalty) AS umsatz_netto_sa_aktion_loyalty_,
    SUM(A.absatz_sa_aktion_loyalty) AS absatz_sa_aktion_loyalty_,
    SUM(A.ek_mep_sa_aktion_loyalty) AS ek_mep_sa_aktion_loyalty_,
    SUM(0) AS logkostenzuschlag_sa_aktion_loyalty_wg30_,
    SUM(A.logkostenzuschlag_sa_aktion_loyalty) AS logkostenzuschlag_sa_aktion_loyalty_,
    SUM(
        A.umsatz_netto_sa_aktion_loyalty) - (
        SUM(A.ek_mep_sa_aktion_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_aktion_loyalty
        )
    ) AS rohertrag_sa_aktion_loyalty_,
    SUM(COALESCE(A.wa_kalk_abschriften_sa_aktion_loyalty, 0)) AS wa_kalk_abschriften_sa_aktion_loyalty_,
    SUM(
        A.umsatz_netto_sa_aktion_loyalty) - (
        SUM(A.ek_mep_sa_aktion_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_aktion_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_aktion_loyalty, 0)
    ) AS wa_kalk_nach_pv_sa_aktion_loyalty_,
    (SUM(
        A.umsatz_netto_sa_aktion_loyalty) - (
        SUM(A.ek_mep_sa_aktion_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_aktion_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_aktion_loyalty, 0)
    )) / IF(SUM(A.umsatz_netto_sa_aktion_loyalty
    ) = 0,
    NULL, SUM(A.umsatz_netto_sa_aktion_loyalty)) * 100 AS spanne_wa_kalk_nach_pv_sa_aktion_loyalty_,
    SUM(A.umsatz_netto_sa_bby_loyalty) AS umsatz_netto_sa_bby_loyalty_,
    SUM(A.absatz_sa_bby_loyalty) AS absatz_sa_bby_loyalty_,
    SUM(A.ek_mep_sa_bby_loyalty) AS ek_mep_sa_bby_loyalty_,
    SUM(0) AS logkostenzuschlag_sa_bby_loyalty_wg30_,
    SUM(A.logkostenzuschlag_sa_bby_loyalty) AS logkostenzuschlag_sa_bby_loyalty_,
    SUM(A.umsatz_netto_sa_bby_loyalty) - (SUM(A.ek_mep_sa_bby_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_bby_loyalty)
    ) AS rohertrag_sa_bby_loyalty_,
    SUM(COALESCE(A.wa_kalk_abschriften_sa_bby_loyalty, 0)) AS wa_kalk_abschriften_sa_bby_loyalty_,
    SUM(
        A.umsatz_netto_sa_bby_loyalty) - (
        SUM(A.ek_mep_sa_bby_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_bby_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_bby_loyalty, 0)
    ) AS wa_kalk_nach_pv_sa_bby_loyalty_,
    (SUM(
        A.umsatz_netto_sa_bby_loyalty) - (
        SUM(A.ek_mep_sa_bby_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_bby_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_bby_loyalty, 0)
    )) / IF(SUM(A.umsatz_netto_sa_bby_loyalty
    ) = 0, NULL,
    SUM(A.umsatz_netto_sa_bby_loyalty)) * 100 AS spanne_wa_kalk_nach_pv_sa_bby_loyalty_,
    SUM(A.umsatz_netto_sa_kdn_bby_loyalty) AS umsatz_netto_sa_kdn_bby_loyalty_,
    SUM(A.absatz_sa_kdn_bby_loyalty) AS absatz_sa_kdn_bby_loyalty_,
    SUM(A.ek_mep_sa_kdn_bby_loyalty) AS ek_mep_sa_kdn_bby_loyalty_,
    SUM(0) AS logkostenzuschlag_sa_kdn_bby_loyalty_wg30_,
    SUM(A.logkostenzuschlag_sa_kdn_bby_loyalty) AS logkostenzuschlag_sa_kdn_bby_loyalty_,
    SUM(
        A.umsatz_netto_sa_kdn_bby_loyalty) - (
        SUM(A.ek_mep_sa_kdn_bby_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_kdn_bby_loyalty
        )
    ) AS rohertrag_sa_kdn_bby_loyalty_,
    SUM(COALESCE(A.wa_kalk_abschriften_sa_kdn_bby_loyalty, 0)) AS wa_kalk_abschriften_sa_kdn_bby_loyalty_,
    SUM(
        A.umsatz_netto_sa_kdn_bby_loyalty) - (
        SUM(A.ek_mep_sa_kdn_bby_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_kdn_bby_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_kdn_bby_loyalty, 0)
    ) AS wa_kalk_nach_pv_sa_kdn_bby_loyalty_,
    (SUM(
        A.umsatz_netto_sa_kdn_bby_loyalty) - (
        SUM(A.ek_mep_sa_kdn_bby_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_kdn_bby_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_kdn_bby_loyalty, 0)
    )) / IF(SUM(A.umsatz_netto_sa_kdn_bby_loyalty
    ) =
    0, NULL, SUM(A.umsatz_netto_sa_kdn_bby_loyalty)) * 100 AS spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty_,
    SUM(A.umsatz_netto_sa_kdp_bby_loyalty) AS umsatz_netto_sa_kdp_bby_loyalty_,
    SUM(A.absatz_sa_kdp_bby_loyalty) AS absatz_sa_kdp_bby_loyalty_,
    SUM(A.ek_mep_sa_kdp_bby_loyalty) AS ek_mep_sa_kdp_bby_loyalty_,
    SUM(0) AS logkostenzuschlag_sa_kdp_bby_loyalty_wg30_,
    SUM(A.logkostenzuschlag_sa_kdp_bby_loyalty) AS logkostenzuschlag_sa_kdp_bby_loyalty_,
    SUM(
        A.umsatz_netto_sa_kdp_bby_loyalty) - (
        SUM(A.ek_mep_sa_kdp_bby_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_kdp_bby_loyalty
        )
    ) AS rohertrag_sa_kdp_bby_loyalty_,
    SUM(COALESCE(A.wa_kalk_abschriften_sa_kdp_bby_loyalty, 0)) AS wa_kalk_abschriften_sa_kdp_bby_loyalty_,
    SUM(
        A.umsatz_netto_sa_kdp_bby_loyalty) - (
        SUM(A.ek_mep_sa_kdp_bby_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_kdp_bby_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_kdp_bby_loyalty, 0)
    ) AS wa_kalk_nach_pv_sa_kdp_bby_loyalty_,
    (SUM(
        A.umsatz_netto_sa_kdp_bby_loyalty) - (
        SUM(A.ek_mep_sa_kdp_bby_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_kdp_bby_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_kdp_bby_loyalty, 0)
    )) / IF(SUM(A.umsatz_netto_sa_kdp_bby_loyalty
    ) =
    0, NULL, SUM(A.umsatz_netto_sa_kdp_bby_loyalty)) * 100 AS spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty_,
    SUM(A.umsatz_netto_sa_non_loyalty) AS umsatz_netto_sa_non_loyalty_,
    SUM(A.absatz_sa_non_loyalty) AS absatz_sa_non_loyalty_,
    SUM(A.ek_mep_sa_non_loyalty) AS ek_mep_sa_non_loyalty_,
    SUM(0) AS logkostenzuschlag_sa_non_loyalty_wg30_,
    SUM(A.logkostenzuschlag_sa_non_loyalty) AS logkostenzuschlag_sa_non_loyalty_,
    SUM(A.umsatz_netto_sa_non_loyalty) - (SUM(A.ek_mep_sa_non_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_non_loyalty)
    ) AS rohertrag_sa_non_loyalty_,
    SUM(COALESCE(A.wa_kalk_abschriften_sa_non_loyalty, 0)) AS wa_kalk_abschriften_sa_non_loyalty_,
    SUM(
        A.umsatz_netto_sa_non_loyalty) - (
        SUM(A.ek_mep_sa_non_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_non_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_non_loyalty, 0)
    ) AS wa_kalk_nach_pv_sa_non_loyalty_,
    (SUM(
        A.umsatz_netto_sa_non_loyalty) - (
        SUM(A.ek_mep_sa_non_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_non_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_non_loyalty, 0)
    )) / IF(SUM(A.umsatz_netto_sa_non_loyalty
    ) = 0, NULL,
    SUM(A.umsatz_netto_sa_non_loyalty)) * 100 AS spanne_wa_kalk_nach_pv_sa_non_loyalty_,
    SUM(A.umsatz_netto_sa_aktion_non_loyalty) AS umsatz_netto_sa_aktion_non_loyalty_,
    SUM(A.absatz_sa_aktion_non_loyalty) AS absatz_sa_aktion_non_loyalty_,
    SUM(A.ek_mep_sa_aktion_non_loyalty) AS ek_mep_sa_aktion_non_loyalty_,
    SUM(0) AS logkostenzuschlag_sa_aktion_non_loyalty_wg30_,
    SUM(A.logkostenzuschlag_sa_aktion_non_loyalty) AS logkostenzuschlag_sa_aktion_non_loyalty_,
    SUM(
        A.umsatz_netto_sa_aktion_non_loyalty) - (
        SUM(A.ek_mep_sa_aktion_non_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_aktion_non_loyalty
        )
    ) AS rohertrag_sa_aktion_non_loyalty_,
    SUM(COALESCE(A.wa_kalk_abschriften_sa_aktion_non_loyalty, 0)) AS wa_kalk_abschriften_sa_aktion_non_loyalty_,
    SUM(
        A.umsatz_netto_sa_aktion_non_loyalty) - (
        SUM(A.ek_mep_sa_aktion_non_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_aktion_non_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_aktion_non_loyalty, 0)
    ) AS wa_kalk_nach_pv_sa_aktion_non_loyalty_,
    (SUM(
        A.umsatz_netto_sa_aktion_non_loyalty) - (
        SUM(A.ek_mep_sa_aktion_non_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_aktion_non_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_aktion_non_loyalty, 0)
    )) / IF(SUM(A.umsatz_netto_sa_aktion_non_loyalty
    ) = 0, NULL, SUM(A.umsatz_netto_sa_aktion_non_loyalty)) * 100 AS spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty_,
    SUM(A.umsatz_netto_sa_bby_non_loyalty) AS umsatz_netto_sa_bby_non_loyalty_,
    SUM(A.absatz_sa_bby_non_loyalty) AS absatz_sa_bby_non_loyalty_,
    SUM(A.ek_mep_sa_bby_non_loyalty) AS ek_mep_sa_bby_non_loyalty_,
    SUM(0) AS logkostenzuschlag_sa_bby_non_loyalty_wg30_,
    SUM(A.logkostenzuschlag_sa_bby_non_loyalty) AS logkostenzuschlag_sa_bby_non_loyalty_,
    SUM(
        A.umsatz_netto_sa_bby_non_loyalty) - (
        SUM(A.ek_mep_sa_bby_non_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_bby_non_loyalty
        )
    ) AS rohertrag_sa_bby_non_loyalty_,
    SUM(COALESCE(A.wa_kalk_abschriften_sa_bby_non_loyalty, 0)) AS wa_kalk_abschriften_sa_bby_non_loyalty_,
    SUM(
        A.umsatz_netto_sa_bby_non_loyalty) - (
        SUM(A.ek_mep_sa_bby_non_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_bby_non_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_bby_non_loyalty, 0)
    ) AS wa_kalk_nach_pv_sa_bby_non_loyalty_,
    (SUM(
        A.umsatz_netto_sa_bby_non_loyalty) - (
        SUM(A.ek_mep_sa_bby_non_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_bby_non_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_bby_non_loyalty, 0)
    )) / IF(SUM(A.umsatz_netto_sa_bby_non_loyalty
    ) =
    0, NULL, SUM(A.umsatz_netto_sa_bby_non_loyalty)) * 100 AS spanne_wa_kalk_nach_pv_sa_bby_non_loyalty_,
    SUM(A.umsatz_netto_sa_bonrabatt_bby_loyalty) AS umsatz_netto_sa_bonrabatt_bby_loyalty_,
    SUM(A.absatz_sa_bonrabatt_bby_loyalty) AS absatz_sa_bonrabatt_bby_loyalty_,
    SUM(A.ek_mep_sa_bonrabatt_bby_loyalty) AS ek_mep_sa_bonrabatt_bby_loyalty_,
    SUM(0) AS logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30_,
    SUM(A.logkostenzuschlag_sa_bonrabatt_bby_loyalty) AS logkostenzuschlag_sa_bonrabatt_bby_loyalty_,
    SUM(
        A.umsatz_netto_sa_bonrabatt_bby_loyalty) - (
        SUM(A.ek_mep_sa_bonrabatt_bby_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_bonrabatt_bby_loyalty
        )
    ) AS rohertrag_sa_bonrabatt_bby_loyalty_,
    SUM(COALESCE(A.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty, 0)) AS wa_kalk_abschriften_sa_bonrabatt_bby_loyalty_,
    SUM(
        A.umsatz_netto_sa_bonrabatt_bby_loyalty) - (
        SUM(A.ek_mep_sa_bonrabatt_bby_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_bonrabatt_bby_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty, 0)
    ) AS wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty_
    ,
    (SUM(
        A.umsatz_netto_sa_bonrabatt_bby_loyalty) - (
        SUM(A.ek_mep_sa_bonrabatt_bby_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_bonrabatt_bby_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty, 0)
    )) / IF(SUM(A.umsatz_netto_sa_bonrabatt_bby_loyalty
    ) = 0, NULL, SUM(A.umsatz_netto_sa_bonrabatt_bby_loyalty)) * 100 AS
    spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty_,
    SUM(A.umsatz_netto_sa_bonrabatt_bby_non_loyalty) AS umsatz_netto_sa_bonrabatt_bby_non_loyalty_,
    SUM(A.absatz_sa_bonrabatt_bby_non_loyalty) AS absatz_sa_bonrabatt_bby_non_loyalty_,
    SUM(A.ek_mep_sa_bonrabatt_bby_non_loyalty) AS ek_mep_sa_bonrabatt_bby_non_loyalty_,
    SUM(0) AS logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30_,
    SUM(A.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty) AS logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_,
    SUM(
        A.umsatz_netto_sa_bonrabatt_bby_non_loyalty) - (
        SUM(A.ek_mep_sa_bonrabatt_bby_non_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty
        )
    ) AS rohertrag_sa_bonrabatt_bby_non_loyalty_,
    SUM(
        COALESCE(A.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty, 0)) AS
    wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty_,
    SUM(
        A.umsatz_netto_sa_bonrabatt_bby_non_loyalty) - (SUM(A.ek_mep_sa_bonrabatt_bby_non_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty
    )) - SUM(COALESCE(A.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty, 0)) AS
    wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty_,
    (SUM(
        A.umsatz_netto_sa_bonrabatt_bby_non_loyalty) - (
        SUM(A.ek_mep_sa_bonrabatt_bby_non_loyalty) + SUM(0) - SUM(A.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty
        )
    ) - SUM(COALESCE(A.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty, 0)
    )) / IF(SUM(A.umsatz_netto_sa_bonrabatt_bby_non_loyalty
    ) = 0, NULL, SUM(A.umsatz_netto_sa_bonrabatt_bby_non_loyalty)) * 100 AS
    spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty_,
    SUM(A.pv_aktion_loy) AS pv_aktion_loy,
    SUM(A.pv_aktion_non_loy) AS pv_aktion_non_loy,
    SUM(A.pv_bby_loy) AS pv_bby_loy,
    SUM(A.pv_bby_non_loy) AS pv_bby_non_loy,
    SUM(A.pv_kdn_bby) AS pv_kdn_bby,
    SUM(A.pv_kdp_bby) AS pv_kdp_bby,
    SUM(A.pv_bonrabatt_bby_loy) AS pv_bonrabatt_bby_loy,
    SUM(A.pv_bonrabatt_bby_non_loy) AS pv_bonrabatt_bby_non_loy
FROM `_artbew2` AS A
INNER JOIN `_distinct_art2` AS B ON A.mandant_id = B.mandant_id AND A.mutter_art_id = B.mutter_art_id
LEFT JOIN (
    SELECT
        A0.mandant_id,
        A0.mutter_art_id,
        A0.wup_id,
        A0.art_id,
        MAX(CASE
            WHEN TRIM(A0.aktion_thema_gruppe_id) = ''
                THEN b.aktion_thema_gruppe_id
            ELSE A0.aktion_thema_gruppe_id
        END) AS aktion_thema_gruppe_id
    FROM `_distinct_aktion_thema2` AS A0
    LEFT JOIN (
        SELECT
            mandant_id,
            mutter_art_id,
            MAX(aktion_thema_gruppe_id) AS aktion_thema_gruppe_id
        FROM `_distinct_aktion_thema2`
        GROUP BY
            mandant_id,
            mutter_art_id
    ) AS b ON A0.mandant_id = b.mandant_id AND A0.mutter_art_id = b.mutter_art_id
    GROUP BY
        A0.mandant_id,
        A0.mutter_art_id,
        A0.wup_id,
        A0.art_id
) AS c
    ON
        A.mandant_id = c.mandant_id AND A.mutter_art_id = c.mutter_art_id AND A.art_id = c.art_id AND A.wup_id
        = c.wup_id
INNER JOIN `_distinct_wg2` AS D ON A.mandant_id = D.mandant_id AND A.mutter_art_id = D.mutter_art_id
INNER JOIN `_distinct_werbe_kat2` AS E ON A.mandant_id = E.mandant_id AND A.mutter_art_id = E.mutter_art_id
INNER JOIN `_distinct_aktionsart2` AS F ON A.mandant_id = F.mandant_id AND A.mutter_art_id = F.mutter_art_id
INNER JOIN `_distinct_aktiontyp2` AS G ON A.mandant_id = G.mandant_id AND A.mutter_art_id = G.mutter_art_id
GROUP BY
    A.mandant_id,
    kjwo,
    A.mutter_art_id,
    B.kl_art_id,
    aktion_thema_gruppe_id,
    E.werbe_kat_id,
    A.gp_id,
    F.aktionsart_id_liste_txt,
    F.aktionsart_bez_liste_txt,
    G.aktion_typ_id_liste_txt,
    G.aktion_typ_bez_liste_txt,
    D.wg_id;


CREATE OR REPLACE TEMPORARY TABLE zzmq00_avq (
    art_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    mandant_id0 INTEGER,
    werbe_typ_id INTEGER,
    kjwo INTEGER
);



INSERT INTO zzmq00_avq
(
    SELECT
        A11.art_id  AS art_id,
        A11.mandant_id  AS mandant_id,
        A11.wup_id  AS wup_id,
        A11.mandant_id  AS mandant_id0,
        A11.werbe_typ_id  AS werbe_typ_id,
        A11.kjwo  AS kjwo
    FROM dbp_msi_view_vis.mv_werbung_kennzahlen_woche AS A11
    INNER JOIN dbp_msi_view_vis.mv_wup AS A12 ON A11.mandant_id = A12.mandant_id AND A11.wup_id = A12.wup_id

    WHERE
        A12.nb_id = 0
        AND (A11.kjwo IN (vor_woche, akt_woche) OR A11.kjwo = flg_woche AND A11.werbe_typ_id = 3)
        AND A11.art_display_id = 0
        AND (A11.mandant_id IN (1)) IS NOT NULL
    GROUP BY
        A11.art_id,
        A11.mandant_id,
        A11.wup_id,
        A11.werbe_typ_id,
        A11.kjwo
    HAVING
        SUM(A11.menge_aktionsstart / IF(IF(
            A11.faktor_flaki = 0, NULL, A11.faktor_flaki) = 0, NULL, IF(
            A11.faktor_flaki
            = 0, NULL, A11.faktor_flaki
        ))) <> 0.0
);


CREATE OR REPLACE TEMPORARY TABLE zzmq01_avq (
    art_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    mandant_id0 INTEGER,
    werbe_typ_id INTEGER,
    kjwo INTEGER
);


INSERT INTO zzmq01_avq
(
    SELECT
        A11.art_id  AS art_id,
        A11.mandant_id  AS mandant_id,
        A11.wup_id  AS wup_id,
        A11.mandant_id  AS mandant_id0,
        A11.werbe_typ_id  AS werbe_typ_id,
        A11.kjwo  AS kjwo
    FROM dbp_msi_view_vis.mv_werbung_kennzahlen_woche AS A11
    INNER JOIN dbp_msi_view_vis.mv_wup AS A12 ON A11.mandant_id = A12.mandant_id AND A11.wup_id = A12.wup_id

    WHERE
        A12.nb_id = 0
        AND (A11.kjwo IN (vor_woche, akt_woche) OR A11.kjwo = flg_woche AND A11.werbe_typ_id = 3)
        AND A11.art_display_id = 0
        AND (A11.mandant_id IN (1)) IS NOT NULL
    GROUP BY
        A11.art_id,
        A11.mandant_id,
        A11.wup_id,
        A11.werbe_typ_id,
        A11.kjwo
    HAVING
        SUM(A11.menge / IF(IF(
            A11.faktor_flaki = 0, NULL, A11.faktor_flaki) = 0, NULL, IF(
            A11.faktor_flaki = 0, NULL,
            A11.faktor_flaki
        ))) <> 0.0 OR SUM(A11.menge_we_zentrale / IF(IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki
        ) = 0,
        NULL, IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki))) <> 0.0
);


CREATE OR REPLACE TEMPORARY TABLE zzmd02_avq (
    mandant_id INTEGER,
    rotemarkierungbeiavqx FLOAT64,
    filterwareneingangzlbestandsta FLOAT64
);


INSERT INTO zzmd02_avq
(SELECT
    mandant_id  AS mandant_id,
    avq_schwellwert  AS rotemarkierungbeiavqx,
    we_bestand_schwellwert  AS filterwareneingangzlbestandsta
FROM dbp_msi_view_vis.mv_ts_avq_schwellwert AS A11);


CREATE OR REPLACE TEMPORARY TABLE zzmd03_avq (
    kjwo INTEGER,
    werbe_typ_id INTEGER,
    wup_id INTEGER,
    mandant_id INTEGER,
    art_id INTEGER,
    mandant_id0 INTEGER,
    abverkauftemengewebestandwerbu FLOAT64,
    wezlaktionbestandstart FLOAT64,
    abverkauftemengewebestand01 FLOAT64,
    abverkauftemengewebestand0103 FLOAT64,
    abverkauftemengewebestand04 FLOAT64,
    abverkauftemengewebestand07 FLOAT64,
    abverkauftemengewebestand03 FLOAT64,
    abverkauftemengewebestand05 FLOAT64,
    abverkauftemengewebestand02 FLOAT64,
    abverkauftemengewebestand06 FLOAT64,
    anzartikelxfilialenxtagehilfsm FLOAT64,
    minsicherheitsbestand FLOAT64,
    einheitwb STRING(3),
    bestandaktionsstart FLOAT64,
    verpackungwb STRING(3),
    umsatznettowerbung FLOAT64,
    abverkauftemengewerbung FLOAT64,
    abverkauftemenge6wo FLOAT64,
    endbestand FLOAT64,
    anzahlnullbestnde FLOAT64,
    marktrestlaufzeit FLOAT64,
    wjxbfs1 FLOAT64,
    wareneingangzlinaktion FLOAT64,
    wareneingangzlvoraktion FLOAT64,
    abverkauftemenge01 FLOAT64,
    abverkauftemenge0103 FLOAT64,
    wareneingangzl FLOAT64,
    updatetimestamp DATETIME,
    sollbestand FLOAT64,
    nullbestnde01tag FLOAT64,
    nullbestnde0103tag FLOAT64
);


CREATE OR REPLACE TEMPORARY TABLE _perf_avq AS
SELECT *
FROM dbp_msi_view_vis.mv_werbung_kennzahlen_woche
WHERE
    kjwo IN (vor_woche, akt_woche)
    OR kjwo = flg_woche AND werbe_typ_id = 3;


INSERT INTO zzmd03_avq
(
    SELECT
        A11.kjwo  AS kjwo,
        A11.werbe_typ_id  AS werbe_typ_id,
        A11.wup_id  AS wup_id,
        A11.mandant_id  AS mandant_id,
        A11.art_id  AS art_id,
        A11.mandant_id  AS mandant_id0,
        CAST(SUM(CASE
            WHEN A11.mandant_id = 1
                THEN A11.menge * A11.menge_we_zentrale / IF(A11.faktor_flaki * A11.menge_we_zentrale = 0, NULL, A11.faktor_flaki * A11.menge_we_zentrale)
            ELSE A11.menge * (A11.menge_we_zentrale + A11.menge_aktionsstart) / IF(A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart) = 0, NULL, A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart))
        END) AS FLOAT64) AS abverkauftemengewebestandwerbu,
        CAST(SUM(CASE
            WHEN A11.mandant_id = 1
                THEN A11.menge_we_zentrale / IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki)
            ELSE (A11.menge_we_zentrale + A11.menge_aktionsstart) / IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki)
        END) AS FLOAT64) AS wezlaktionbestandstart,
        CAST(SUM(CASE
            WHEN A11.mandant_id = 1
                THEN A11.menge_tag1 * A11.menge_we_zentrale / IF(A11.faktor_flaki * A11.menge_we_zentrale = 0, NULL, A11.faktor_flaki * A11.menge_we_zentrale)
            ELSE A11.menge_tag1 * (A11.menge_we_zentrale + A11.menge_aktionsstart) / IF(A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart) = 0, NULL, A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart))
        END) AS FLOAT64) AS abverkauftemengewebestand01,
        CAST(SUM(CASE
            WHEN A11.mandant_id = 1
                THEN (A11.menge_tag1 + A11.menge_tag2 + A11.menge_tag3) * A11.menge_we_zentrale / IF(A11.faktor_flaki * A11.menge_we_zentrale = 0, NULL, A11.faktor_flaki * A11.menge_we_zentrale)
            ELSE (A11.menge_tag1 + A11.menge_tag2 + A11.menge_tag3) * (A11.menge_we_zentrale + A11.menge_aktionsstart) / IF(A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart) = 0, NULL, A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart))
        END) AS FLOAT64) AS abverkauftemengewebestand0103,
        CAST(SUM(CASE
            WHEN A11.mandant_id = 1
                THEN A11.menge_tag4 * A11.menge_we_zentrale / IF(A11.faktor_flaki * A11.menge_we_zentrale = 0, NULL, A11.faktor_flaki * A11.menge_we_zentrale)
            ELSE A11.menge_tag4 * (A11.menge_we_zentrale + A11.menge_aktionsstart) / IF(A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart) = 0, NULL, A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart))
        END) AS FLOAT64) AS abverkauftemengewebestand04,
        CAST(SUM(CASE
            WHEN A11.mandant_id = 1
                THEN A11.menge_tag7 * A11.menge_we_zentrale / IF(A11.faktor_flaki * A11.menge_we_zentrale = 0, NULL, A11.faktor_flaki * A11.menge_we_zentrale)
            ELSE A11.menge_tag7 * (A11.menge_we_zentrale + A11.menge_aktionsstart) / IF(A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart) = 0, NULL, A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart))
        END) AS FLOAT64) AS abverkauftemengewebestand07,
        CAST(SUM(CASE
            WHEN A11.mandant_id = 1
                THEN A11.menge_tag3 * A11.menge_we_zentrale / IF(A11.faktor_flaki * A11.menge_we_zentrale = 0, NULL, A11.faktor_flaki * A11.menge_we_zentrale)
            ELSE A11.menge_tag3 * (A11.menge_we_zentrale + A11.menge_aktionsstart) / IF(A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart) = 0, NULL, A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart))
        END) AS FLOAT64) AS abverkauftemengewebestand03,
        CAST(SUM(CASE
            WHEN A11.mandant_id = 1
                THEN A11.menge_tag5 * A11.menge_we_zentrale / IF(A11.faktor_flaki * A11.menge_we_zentrale = 0, NULL, A11.faktor_flaki * A11.menge_we_zentrale)
            ELSE A11.menge_tag5 * (A11.menge_we_zentrale + A11.menge_aktionsstart) / IF(A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart) = 0, NULL, A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart))
        END) AS FLOAT64) AS abverkauftemengewebestand05,
        CAST(SUM(CASE
            WHEN A11.mandant_id = 1
                THEN A11.menge_tag2 * A11.menge_we_zentrale / IF(A11.faktor_flaki * A11.menge_we_zentrale = 0, NULL, A11.faktor_flaki * A11.menge_we_zentrale)
            ELSE A11.menge_tag2 * (A11.menge_we_zentrale + A11.menge_aktionsstart) / IF(A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart) = 0, NULL, A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart))
        END) AS FLOAT64) AS abverkauftemengewebestand02,
        CAST(SUM(CASE
            WHEN A11.mandant_id = 1
                THEN A11.menge_tag6 * A11.menge_we_zentrale / IF(A11.faktor_flaki * A11.menge_we_zentrale = 0, NULL, A11.faktor_flaki * A11.menge_we_zentrale)
            ELSE A11.menge_tag6 * (A11.menge_we_zentrale + A11.menge_aktionsstart) / IF(A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart) = 0, NULL, A11.faktor_flaki * (A11.menge_we_zentrale + A11.menge_aktionsstart))
        END) AS FLOAT64) AS abverkauftemengewebestand06,
        CAST(
            COUNT(DISTINCT A11.wup_id) * MAX(A11.anzahl_tage_aktion) * COUNT(DISTINCT A11.art_id) AS FLOAT64) AS
        anzartikelxfilialenxtagehilfsm,
        CAST(SUM(A11.min_sicherh_bestand) AS FLOAT64) AS minsicherheitsbestand,
        MAX(A11.mwb_basismenge_einh_id) AS einheitwb,
        CAST(SUM(A11.menge_aktionsstart / IF(IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki) = 0, NULL, IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki))) AS FLOAT64)
            AS bestandaktionsstart,
        MAX(A11.mwb_verpart_id) AS verpackungwb,
        CAST(SUM(A11.umsatz_netto) AS FLOAT64) AS umsatznettowerbung,
        CAST(SUM(A11.menge / IF(IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki) = 0, NULL, IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki))) AS FLOAT64)
            AS abverkauftemengewerbung,
        CAST(SUM(A11.menge_historie_af / IF(IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki) = 0, NULL, IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki))) AS FLOAT64)
            AS abverkauftemenge6wo,
        CAST(SUM(A11.menge_endbestand / IF(IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki) = 0, NULL, IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki))) AS FLOAT64)
            AS endbestand,
        CAST(SUM(A11.anzahl_nullbestand) AS FLOAT64) AS anzahlnullbestnde,
        CAST(SUM(A11.mhd_zeitraum * A11.lager_prozent) AS FLOAT64) AS marktrestlaufzeit,
        CAST(SUM(A11.menge_endbestand / IF(IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki) = 0, NULL, IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki))) - (SUM(A11.min_sicherh_bestand) + SUM(A11.sollbestand)) AS FLOAT64)
            AS wjxbfs1,
        CAST(SUM(A11.menge_we) AS FLOAT64) AS wareneingangzlinaktion,
        CAST(SUM(A11.we_menge_vor_aktion) AS FLOAT64) AS wareneingangzlvoraktion,
        CAST(SUM(A11.menge_tag1 / IF(IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki) = 0, NULL, IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki))) AS FLOAT64)
            AS abverkauftemenge01,
        CAST(SUM((A11.menge_tag1 + A11.menge_tag2 + A11.menge_tag3) / IF(IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki) = 0, NULL, IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki))) AS FLOAT64)
            AS abverkauftemenge0103,
        CAST(SUM(A11.menge_we_zentrale / IF(IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki) = 0, NULL, IF(A11.faktor_flaki = 0, NULL, A11.faktor_flaki))) AS FLOAT64)
            AS wareneingangzl,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS updatetimestamp,
        CAST(SUM(A11.sollbestand) AS FLOAT64) AS sollbestand,
        CAST(SUM(A11.anzahl_nullbestand_tag1) AS FLOAT64) AS nullbestnde01tag,
        CAST(SUM(A11.anzahl_nullbestand_tag1bis3) AS FLOAT64) AS nullbestnde0103tag
    FROM `_perf_avq` AS A11
    INNER JOIN dbp_msi_view_vis.mv_wup AS A12 ON A11.mandant_id = A12.mandant_id AND A11.wup_id = A12.wup_id

    WHERE (
        A11.mandant_id IN (1) OR (A11.art_id, A11.mandant_id, A11.wup_id, A11.mandant_id, A11.werbe_typ_id, A11.kjwo) IN
        (
            SELECT (art_id, mandant_id, wup_id, mandant_id0, werbe_typ_id, kjwo)
            FROM (
                SELECT *
                FROM zzmq01_avq AS PS21
                UNION DISTINCT
                SELECT
                    PS21.art_id,
                    PS21.mandant_id,
                    PS21.wup_id,
                    PS21.mandant_id0,
                    PS21.werbe_typ_id,
                    PS21.kjwo
                FROM zzmq00_avq AS PS21
                INNER JOIN dbp_msi_view_vis.mv_wup AS S22
                    ON
                        PS21.mandant_id0 = S22.mandant_id AND PS21.wup_id
                        = S22.wup_id
                WHERE S22.mandant_id NOT IN (1)
                GROUP BY
                    PS21.art_id,
                    PS21.mandant_id,
                    PS21.wup_id,
                    PS21.mandant_id0,
                    PS21.werbe_typ_id,
                    PS21.kjwo
            ) AS t1
        )
    )
    AND A12.nb_id = 0
    AND (A11.kjwo IN (vor_woche, akt_woche) OR A11.kjwo = flg_woche AND A11.werbe_typ_id = 3)
    AND A11.art_display_id = 0
    GROUP BY
        A11.kjwo,
        A11.werbe_typ_id,
        A11.wup_id,
        A11.mandant_id,
        A11.art_id
);


CREATE OR REPLACE TEMPORARY TABLE zzmd04_avq (
    kjwo INTEGER,
    werbe_typ_id INTEGER,
    posten_fg INTEGER,
    owg_id INTEGER,
    mandant_id INTEGER,
    art_mutter_wb_id INTEGER,
    mandant_id0 INTEGER,
    anzahltagederaktion INTEGER,
    anzahlartikelwerbung INTEGER,
    anzahlfilialenwerbung INTEGER
);


INSERT INTO zzmd04_avq
(
    SELECT
        A11.kjwo  AS kjwo,
        A11.werbe_typ_id  AS werbe_typ_id,
        A11.posten_fg,
        A14.owg_id  AS owg_id,
        A11.mandant_id  AS mandant_id,
        A11.art_mutter_wb_id,
        A11.mandant_id  AS mandant_id0,
        MAX(A11.anzahl_tage_aktion)  AS anzahltagederaktion,
        COUNT(DISTINCT A11.art_id) AS anzahlartikelwerbung,
        COUNT(DISTINCT A11.wup_id) AS anzahlfilialenwerbung
    FROM `_perf_avq` AS A11
    INNER JOIN dbp_msi_view_vis.mv_wup AS A12 ON A11.mandant_id = A12.mandant_id AND A11.wup_id = A12.wup_id

    INNER JOIN dbp_msi_view_vis.mv_art_wg_zu AS A13 ON A11.art_id = A13.art_id AND A11.mandant_id = A13.mandant_id

    INNER JOIN dbp_msi_view_vis.mv_wg_int AS A14 ON A13.wg_id = A14.wg_id
    WHERE (
        A11.mandant_id IN (1) OR (A11.art_id, A11.mandant_id, A11.wup_id, A11.mandant_id, A11.werbe_typ_id, A11.kjwo) IN
        (
            SELECT (art_id, mandant_id, wup_id, mandant_id0, werbe_typ_id, kjwo)
            FROM (
                SELECT *
                FROM zzmq01_avq AS PS21
                UNION DISTINCT
                SELECT
                    PS21.art_id,
                    PS21.mandant_id,
                    PS21.wup_id,
                    PS21.mandant_id0,
                    PS21.werbe_typ_id,
                    PS21.kjwo
                FROM zzmq00_avq AS PS21
                INNER JOIN dbp_msi_view_vis.mv_wup AS S22
                    ON
                        PS21.mandant_id0 = S22.mandant_id AND PS21.wup_id
                        = S22.wup_id
                WHERE S22.mandant_id NOT IN (1)
                GROUP BY
                    PS21.art_id,
                    PS21.mandant_id,
                    PS21.wup_id,
                    PS21.mandant_id0,
                    PS21.werbe_typ_id,
                    PS21.kjwo
            ) AS t1
        )
    )
    AND A12.nb_id = 0
    AND (A11.kjwo IN (vor_woche, akt_woche) OR A11.kjwo = flg_woche AND A11.werbe_typ_id = 3)
    AND A11.art_display_id = 0
    GROUP BY
        A11.mandant_id,
        A11.kjwo,
        A11.werbe_typ_id,
        A11.posten_fg,
        A11.art_mutter_wb_id,
        A14.owg_id
);


CREATE OR REPLACE TEMPORARY TABLE zzmd05_avq (
    kjwo INTEGER,
    werbe_typ_id INTEGER,
    posten_fg INTEGER,
    mandant_id INTEGER,
    art_mutter_wb_id INTEGER,
    mandant_id0 INTEGER,
    abt_id INTEGER,
    anzahlfilialenwerbungfrhilfsme INTEGER
);


INSERT INTO zzmd05_avq
(
    SELECT
        A11.kjwo  AS kjwo,
        A11.werbe_typ_id  AS werbe_typ_id,
        A11.posten_fg,
        A11.mandant_id  AS mandant_id,
        A11.art_mutter_wb_id,
        A11.mandant_id  AS mandant_id0,
        A15.abt_id  AS abt_id,
        COUNT(DISTINCT A11.wup_id) AS anzahlfilialenwerbungfrhilfsme
    FROM `_perf_avq` AS A11
    INNER JOIN dbp_msi_view_vis.mv_art_wg_zu AS A12 ON A11.art_id = A12.art_id AND A11.mandant_id = A12.mandant_id

    INNER JOIN dbp_msi_view_vis.mv_wg_int AS A13 ON A12.wg_id = A13.wg_id
    INNER JOIN dbp_msi_view_vis.mv_owg_int AS A14 ON A13.owg_id = A14.owg_id
    INNER JOIN dbp_msi_view_vis.mv_hwg_int AS A15 ON A14.hwg_id = A15.hwg_id
    INNER JOIN dbp_msi_view_vis.mv_wup AS A16 ON A11.mandant_id = A16.mandant_id AND A11.wup_id = A16.wup_id

    WHERE (
        A11.mandant_id IN (1) OR (A11.art_id, A11.mandant_id, A11.wup_id, A11.mandant_id, A11.werbe_typ_id, A11.kjwo) IN
        (
            SELECT (art_id, mandant_id, wup_id, mandant_id0, werbe_typ_id, kjwo)
            FROM (
                SELECT *
                FROM zzmq01_avq AS PS21
                UNION DISTINCT
                SELECT
                    PS21.art_id,
                    PS21.mandant_id,
                    PS21.wup_id,
                    PS21.mandant_id0,
                    PS21.werbe_typ_id,
                    PS21.kjwo
                FROM zzmq00_avq AS PS21
                INNER JOIN dbp_msi_view_vis.mv_wup AS S22
                    ON
                        PS21.mandant_id0 = S22.mandant_id AND PS21.wup_id
                        = S22.wup_id
                WHERE S22.mandant_id NOT IN (1)
                GROUP BY
                    PS21.art_id,
                    PS21.mandant_id,
                    PS21.wup_id,
                    PS21.mandant_id0,
                    PS21.werbe_typ_id,
                    PS21.kjwo
            ) AS t1
        )
    )
    AND A16.nb_id = 0
    AND (A11.kjwo IN (vor_woche, akt_woche) OR A11.kjwo = flg_woche AND A11.werbe_typ_id = 3)
    AND A11.art_display_id = 0
    GROUP BY
        A11.mandant_id,
        A11.kjwo,
        A11.werbe_typ_id,
        A11.posten_fg,
        A11.art_mutter_wb_id,
        A15.abt_id
);


CREATE OR REPLACE TEMPORARY TABLE zzmd06_avq (
    mandant_id INTEGER,
    aktualisierungsdatum DATETIME
);


INSERT INTO zzmd06_avq
(
    SELECT
        A12.mandant_id  AS mandant_id,
        MAX(A11.dat_letzte_aktualisierung) AS aktualisierungsdatum
    FROM dbp_msi_view_vis.mv_avq_aktualisierung AS A11
    INNER JOIN dbp_msi_view_vis.mv_mandant AS A12 ON TRUE
    GROUP BY mandant_id
);


CREATE OR REPLACE TEMPORARY TABLE zzmd07_avq (
    art_id INTEGER,
    mandant_id INTEGER,
    kl_art_nr STRING(8),
    wup_id INTEGER,
    mandant_id0 INTEGER,
    mandant_id1 INTEGER,
    mandant_sort_id INTEGER,
    vs_id INTEGER,
    mandant_id2 INTEGER,
    werbe_typ_id INTEGER,
    sort_id INTEGER,
    ww_von_bis STRING(35),
    kjwo INTEGER,
    wo_von_bis STRING(20),
    kjwo_bez STRING(30),
    akt_wo INTEGER,
    wo_kj INTEGER,
    abt_id INTEGER,
    sort_id0 INTEGER,
    posten_fg INTEGER,
    art_mutter_wb_id INTEGER,
    mandant_id3 INTEGER,
    wg_id INTEGER,
    sort_id1 INTEGER,
    vkl_id INTEGER,
    mandant_id4 INTEGER,
    vkl_sort STRING(40),
    rotemarkierungbeiavqx FLOAT64,
    abverkauftemengeperanzahltageh FLOAT64,
    anzartikelxfilialenxtagehilfsm FLOAT64,
    filterwareneingangzlbestandsta FLOAT64,
    minsicherheitsbestand FLOAT64,
    anzahlfilialenhilfsmetrik FLOAT64,
    einheitwb STRING(3),
    bestandaktionsstart FLOAT64,
    verpackungwb STRING(3),
    abverkauftemengewebestandwerbu FLOAT64,
    umsatznettowerbung FLOAT64,
    abverkauftemengewerbung FLOAT64,
    abverkauftemenge6wo FLOAT64,
    endbestand FLOAT64,
    anzahlnullbestnde FLOAT64,
    anzahltagederaktion INTEGER,
    marktrestlaufzeit FLOAT64,
    berbestand FLOAT64,
    wareneingangzlinaktion FLOAT64,
    wezlaktionbestandstart FLOAT64,
    wareneingangzlvoraktion FLOAT64,
    abverkauftemengewebestand01 FLOAT64,
    abverkauftemengewebestand0103 FLOAT64,
    abverkauftemenge01 FLOAT64,
    abverkauftemenge0103 FLOAT64,
    anzahlartikelwerbung INTEGER,
    anzahlfilialenwerbung INTEGER,
    lfdnrmenge FLOAT64,
    wareneingangzl FLOAT64,
    aktualisierungsdatum DATETIME,
    updatetimestamp DATETIME,
    abverkauftemengewebestand04 FLOAT64,
    sollbestand FLOAT64,
    abverkauftemengewebestand07 FLOAT64,
    nullbestnde01tag FLOAT64,
    abverkauftemengewebestand03 FLOAT64,
    abverkauftemengewebestand05 FLOAT64,
    abverkauftemengewebestand02 FLOAT64,
    abverkauftemengewebestand06 FLOAT64,
    nullbestnde0103tag FLOAT64
);


INSERT INTO `zzmd07_avq`
WITH AggregatedData AS (
    SELECT
        pa12.art_id AS art_id,
        pa12.mandant_id0 AS mandant_id,
        MAX(a114.kl_art_nr) AS kl_art_nr,
        pa12.wup_id AS wup_id,
        pa12.mandant_id AS mandant_id0,
        a13.mandant_id AS mandant_id1,
        MAX(a119.mandant_sort_id) AS mandant_sort_id,
        CASE
            WHEN a13.mandant_id = 1 AND a13.vs_id = 7 THEN 11
            WHEN a13.mandant_id = 1 AND a13.vs_id = 2 THEN 12
            WHEN a13.mandant_id = 1 AND a13.vs_id = 3 THEN 13
            WHEN a13.mandant_id = 1 AND a13.vs_id = 1 THEN 14
            WHEN a13.mandant_id = 1 AND a13.vs_id = 8 THEN 15
            WHEN a13.mandant_id = 1 AND a13.vs_id = 6 THEN 16
            WHEN a13.mandant_id = 2 AND a13.vs_id = 1 THEN 21
            WHEN a13.mandant_id = 2 AND a13.vs_id = 2 THEN 22
            ELSE a13.mandant_id * 10 + 9
        END AS vs_id,
        a13.mandant_id AS mandant_id2,
        pa12.werbe_typ_id AS werbe_typ_id,
        MAX(a115.werbe_typ_id) AS sort_id,
        a113.ww_von_bis AS ww_von_bis,
        pa12.kjwo AS kjwo,
        MAX(a116.wo_von_bis) AS wo_von_bis,
        MAX(CONCAT(TRIM(CAST(a116.kj AS STRING), ' '), ' ', a116.wo_von_bis)) AS kjwo_bez,
        MAX(a116.akt_wo) AS akt_wo,
        MAX(a116.wo_kj) AS wo_kj,
        a110.abt_id AS abt_id,
        MAX(a118.sort_id) AS sort_id0,
        a15.posten_fg AS posten_fg,
        a15.art_mutter_wb_id AS art_mutter_wb_id,
        a15.mandant_id AS mandant_id3,
        a16.wg_id AS wg_id,
        MAX(a17.sort_id) AS sort_id1,
        a13.vkl_id AS vkl_id,
        a13.mandant_id AS mandant_id4,
        MAX(CASE WHEN a117.vkl_id < 0 THEN CONCAT('ZZZ', CAST(a117.vkl_id AS STRING)) ELSE a117.ma_name END) AS vkl_sort,
        MAX(pa14.rotemarkierungbeiavqx) AS rotemarkierungbeiavqx,
        IFNULL((MAX(pa12.abverkauftemengewebestandwerbu) / NULLIF(MAX(pa18.anzahltagederaktion), 0)), 0) AS abverkauftemengeperanzahltageh,
        MAX(pa12.anzartikelxfilialenxtagehilfsm) AS anzartikelxfilialenxtagehilfsm,
        MAX(pa14.filterwareneingangzlbestandsta) AS filterwareneingangzlbestandsta,
        MAX(pa12.minsicherheitsbestand) AS minsicherheitsbestand,
        IFNULL(((MAX(pa111.anzahlfilialenwerbungfrhilfsme) * MAX(pa18.anzahltagederaktion)) / NULLIF(MAX(pa18.anzahltagederaktion), 0)), 0) AS anzahlfilialenhilfsmetrik,
        MAX(pa12.einheitwb) AS einheitwb,
        MAX(pa12.bestandaktionsstart) AS bestandaktionsstart,
        MAX(pa12.verpackungwb) AS verpackungwb,
        MAX(pa12.abverkauftemengewebestandwerbu) AS abverkauftemengewebestandwerbu,
        MAX(pa12.umsatznettowerbung) AS umsatznettowerbung,
        MAX(pa12.abverkauftemengewerbung) AS abverkauftemengewerbung,
        MAX(pa12.abverkauftemenge6wo) AS abverkauftemenge6wo,
        MAX(pa12.endbestand) AS endbestand,
        MAX(pa12.anzahlnullbestnde) AS anzahlnullbestnde,
        MAX(pa18.anzahltagederaktion) AS anzahltagederaktion,
        MAX(pa12.marktrestlaufzeit) AS marktrestlaufzeit,
        (CASE WHEN MAX(pa12.wjxbfs1) < 0 THEN 0 ELSE MAX(pa12.wjxbfs1) END) AS berbestand,
        MAX(pa12.wareneingangzlinaktion) AS wareneingangzlinaktion,
        MAX(pa12.wezlaktionbestandstart) AS wezlaktionbestandstart,
        MAX(pa12.wareneingangzlvoraktion) AS wareneingangzlvoraktion,
        MAX(pa12.abverkauftemengewebestand01) AS abverkauftemengewebestand01,
        MAX(pa12.abverkauftemengewebestand0103) AS abverkauftemengewebestand0103,
        MAX(pa12.abverkauftemenge01) AS abverkauftemenge01,
        MAX(pa12.abverkauftemenge0103) AS abverkauftemenge0103,
        MAX(pa18.anzahlartikelwerbung) AS anzahlartikelwerbung,
        MAX(pa18.anzahlfilialenwerbung) AS anzahlfilialenwerbung,
        MAX(IFNULL((pa12.abverkauftemengewerbung / NULLIF(((pa111.anzahlfilialenwerbungfrhilfsme * pa18.anzahltagederaktion) / NULLIF(pa18.anzahltagederaktion, 0)), 0)), 0)) AS rank_sort_metric,

        MAX(pa12.wareneingangzl) AS wareneingangzl,
        MAX(pa112.aktualisierungsdatum) AS aktualisierungsdatum,
        MAX(pa12.updatetimestamp) AS updatetimestamp,
        MAX(pa12.abverkauftemengewebestand04) AS abverkauftemengewebestand04,
        MAX(pa12.sollbestand) AS sollbestand,
        MAX(pa12.abverkauftemengewebestand07) AS abverkauftemengewebestand07,
        MAX(pa12.nullbestnde01tag) AS nullbestnde01tag,
        MAX(pa12.abverkauftemengewebestand03) AS abverkauftemengewebestand03,
        MAX(pa12.abverkauftemengewebestand05) AS abverkauftemengewebestand05,
        MAX(pa12.abverkauftemengewebestand02) AS abverkauftemengewebestand02,
        MAX(pa12.abverkauftemengewebestand06) AS abverkauftemengewebestand06,
        MAX(pa12.nullbestnde0103tag) AS nullbestnde0103tag
    FROM `zzmd03_avq` AS pa12
    JOIN dbp_msi_view_vis.mv_wup AS a13
        ON (pa12.mandant_id = a13.mandant_id AND pa12.wup_id = a13.wup_id)
    LEFT OUTER JOIN `zzmd02_avq` AS pa14
        ON (a13.mandant_id = pa14.mandant_id)
    JOIN dbp_msi_view_vis.mv_art_mutter_wb AS a15
        ON (pa12.art_id = a15.art_id AND pa12.mandant_id0 = a15.mandant_id)
    JOIN dbp_msi_view_vis.mv_art_wg_zu AS a16
        ON (pa12.art_id = a16.art_id AND pa12.mandant_id0 = a16.mandant_id)
    JOIN dbp_msi_view_vis.mv_wg_int AS a17
        ON (a16.wg_id = a17.wg_id)
    LEFT OUTER JOIN `zzmd04_avq` AS pa18
        ON (a13.mandant_id = pa18.mandant_id AND a15.art_mutter_wb_id = pa18.art_mutter_wb_id AND a15.mandant_id = pa18.mandant_id0 AND a15.posten_fg = pa18.posten_fg AND a17.owg_id = pa18.owg_id AND pa12.kjwo = pa18.kjwo AND pa12.werbe_typ_id = pa18.werbe_typ_id)
    JOIN dbp_msi_view_vis.mv_owg_int AS a19
        ON (a17.owg_id = a19.owg_id)
    JOIN dbp_msi_view_vis.mv_hwg_int AS a110
        ON (a19.hwg_id = a110.hwg_id)
    LEFT OUTER JOIN `zzmd05_avq` AS pa111
        ON (a110.abt_id = pa111.abt_id AND a13.mandant_id = pa111.mandant_id AND a15.art_mutter_wb_id = pa111.art_mutter_wb_id AND a15.mandant_id = pa111.mandant_id0 AND a15.posten_fg = pa111.posten_fg AND pa12.kjwo = pa111.kjwo AND pa12.werbe_typ_id = pa111.werbe_typ_id)
    LEFT OUTER JOIN `zzmd06_avq` AS pa112
        ON (a13.mandant_id = pa112.mandant_id)
    JOIN dbp_msi_view_vis.mv_werbe_woche AS a113
        ON (pa12.kjwo = a113.kjwo AND pa12.werbe_typ_id = a113.werbe_typ_id)
    JOIN dbp_msi_view_vis.mv_art AS a114
        ON (a13.mandant_id = a114.mandant_id AND pa12.art_id = a114.art_id AND pa12.mandant_id0 = a114.mandant_id)
    JOIN dbp_msi_view_vis.mv_l_werbe_typ AS a115
        ON (pa12.werbe_typ_id = a115.werbe_typ_id)
    JOIN dbp_msi_view_vis.mv_woche AS a116
        ON (pa12.kjwo = a116.kjwo)
    JOIN dbp_msi_view_vis.mv_vkl AS a117
        ON (a13.mandant_id = a117.mandant_id AND a13.vkl_id = a117.vkl_id)
    JOIN dbp_msi_view_vis.mv_abt_int AS a118
        ON (a110.abt_id = a118.abt_id)
    JOIN dbp_msi_view_vis.mv_mandant AS a119
        ON (a115.mandant_id = a119.mandant_id AND a13.mandant_id = a119.mandant_id)
    GROUP BY
        pa12.art_id,
        pa12.mandant_id0,
        pa12.wup_id,
        pa12.mandant_id,
        a13.mandant_id,
        CASE
            WHEN a13.mandant_id = 1 AND a13.vs_id = 7 THEN 11
            WHEN a13.mandant_id = 1 AND a13.vs_id = 2 THEN 12
            WHEN a13.mandant_id = 1 AND a13.vs_id = 3 THEN 13
            WHEN a13.mandant_id = 1 AND a13.vs_id = 1 THEN 14
            WHEN a13.mandant_id = 1 AND a13.vs_id = 8 THEN 15
            WHEN a13.mandant_id = 1 AND a13.vs_id = 6 THEN 16
            WHEN a13.mandant_id = 2 AND a13.vs_id = 1 THEN 21
            WHEN a13.mandant_id = 2 AND a13.vs_id = 2 THEN 22
            ELSE a13.mandant_id * 10 + 9
        END,
        pa12.werbe_typ_id,
        a113.ww_von_bis,
        pa12.kjwo,
        a110.abt_id,
        a15.posten_fg,
        a15.art_mutter_wb_id,
        a15.mandant_id,
        a16.wg_id,
        a13.vkl_id
)

SELECT
    art_id,
    mandant_id,
    kl_art_nr,
    wup_id,
    mandant_id0,
    mandant_id1,
    mandant_sort_id,
    vs_id,
    mandant_id2,
    werbe_typ_id,
    sort_id,
    ww_von_bis,
    kjwo,
    wo_von_bis,
    kjwo_bez,
    akt_wo,
    wo_kj,
    abt_id,
    sort_id0,
    posten_fg,
    art_mutter_wb_id,
    mandant_id3,
    wg_id,
    sort_id1,
    vkl_id,
    mandant_id4,
    vkl_sort,
    rotemarkierungbeiavqx,
    abverkauftemengeperanzahltageh,
    anzartikelxfilialenxtagehilfsm,
    filterwareneingangzlbestandsta,
    minsicherheitsbestand,
    anzahlfilialenhilfsmetrik,
    einheitwb,
    bestandaktionsstart,
    verpackungwb,
    abverkauftemengewebestandwerbu,
    umsatznettowerbung,
    abverkauftemengewerbung,
    abverkauftemenge6wo,
    endbestand,
    anzahlnullbestnde,
    anzahltagederaktion,
    marktrestlaufzeit,
    berbestand,
    wareneingangzlinaktion,
    wezlaktionbestandstart,
    wareneingangzlvoraktion,
    abverkauftemengewebestand01,
    abverkauftemengewebestand0103,
    abverkauftemenge01,
    abverkauftemenge0103,
    anzahlartikelwerbung,
    anzahlfilialenwerbung,
    RANK() OVER (
        PARTITION BY
            kjwo,
            werbe_typ_id,
            vs_id,
            mandant_id1,
            mandant_id1
        ORDER BY
            mandant_sort_id ASC NULLS LAST,
            akt_wo ASC NULLS LAST,
            kjwo ASC NULLS LAST,
            kjwo_bez DESC NULLS FIRST,
            wo_kj ASC NULLS LAST,
            wo_von_bis DESC NULLS FIRST,
            werbe_typ_id ASC NULLS LAST,
            sort_id ASC NULLS LAST,
            vs_id ASC NULLS LAST,
            sort_id0 ASC NULLS LAST,
            posten_fg DESC NULLS FIRST,
            rank_sort_metric ASC NULLS LAST,
            art_mutter_wb_id ASC NULLS LAST,
            mandant_id3 ASC NULLS LAST,
            kl_art_nr ASC NULLS LAST,
            sort_id1 ASC NULLS LAST,
            vkl_sort ASC NULLS LAST
    ) AS lfdnrmenge,

    wareneingangzl,
    aktualisierungsdatum,
    updatetimestamp,
    abverkauftemengewebestand04,
    sollbestand,
    abverkauftemengewebestand07,
    nullbestnde01tag,
    abverkauftemengewebestand03,
    abverkauftemengewebestand05,
    abverkauftemengewebestand02,
    abverkauftemengewebestand06,
    nullbestnde0103tag
FROM AggregatedData;


INSERT INTO `zzmd07_avq`
WITH AggregatedData AS (
    SELECT
        pa12.art_id AS art_id,
        pa12.mandant_id0 AS mandant_id,
        MAX(a114.kl_art_nr) AS kl_art_nr,
        pa12.wup_id AS wup_id,
        pa12.mandant_id AS mandant_id0,
        a13.mandant_id AS mandant_id1,
        MAX(a119.mandant_sort_id) AS mandant_sort_id,
        CASE
            WHEN a13.mandant_id = 1 AND a13.vs_id = 7 THEN 11
            WHEN a13.mandant_id = 1 AND a13.vs_id = 2 THEN 12
            WHEN a13.mandant_id = 1 AND a13.vs_id = 3 THEN 13
            WHEN a13.mandant_id = 1 AND a13.vs_id = 1 THEN 14
            WHEN a13.mandant_id = 1 AND a13.vs_id = 8 THEN 15
            WHEN a13.mandant_id = 1 AND a13.vs_id = 6 THEN 16
            WHEN a13.mandant_id = 2 AND a13.vs_id = 1 THEN 21
            WHEN a13.mandant_id = 2 AND a13.vs_id = 2 THEN 22
            ELSE a13.mandant_id * 10 + 9
        END AS vs_id,
        a13.mandant_id AS mandant_id2,
        pa12.werbe_typ_id AS werbe_typ_id,
        MAX(a115.werbe_typ_id) AS sort_id,
        a113.ww_von_bis AS ww_von_bis,
        pa12.kjwo AS kjwo,
        MAX(a116.wo_von_bis) AS wo_von_bis,
        MAX(CONCAT(TRIM(CAST(a116.kj AS STRING), ' '), ' ', a116.wo_von_bis)) AS kjwo_bez,
        MAX(a116.akt_wo) AS akt_wo,
        MAX(a116.wo_kj) AS wo_kj,
        a110.abt_id AS abt_id,
        MAX(a118.sort_id) AS sort_id0,
        a15.posten_fg AS posten_fg,
        a15.art_mutter_wb_id AS art_mutter_wb_id,
        a15.mandant_id AS mandant_id3,
        a16.wg_id AS wg_id,
        MAX(a17.sort_id) AS sort_id1,
        a13.vkl_id AS vkl_id,
        a13.mandant_id AS mandant_id4,
        MAX(CASE WHEN a117.vkl_id < 0 THEN CONCAT('ZZZ', CAST(a117.vkl_id AS STRING)) ELSE a117.ma_name END) AS vkl_sort,
        MAX(pa14.rotemarkierungbeiavqx) AS rotemarkierungbeiavqx,
        IFNULL((MAX(pa12.abverkauftemengewebestandwerbu) / NULLIF(MAX(pa18.anzahltagederaktion), 0)), 0) AS abverkauftemengeperanzahltageh,
        MAX(pa12.anzartikelxfilialenxtagehilfsm) AS anzartikelxfilialenxtagehilfsm,
        MAX(pa14.filterwareneingangzlbestandsta) AS filterwareneingangzlbestandsta,
        MAX(pa12.minsicherheitsbestand) AS minsicherheitsbestand,
        IFNULL(((MAX(pa111.anzahlfilialenwerbungfrhilfsme) * MAX(pa18.anzahltagederaktion)) / NULLIF(MAX(pa18.anzahltagederaktion), 0)), 0) AS anzahlfilialenhilfsmetrik,
        MAX(pa12.einheitwb) AS einheitwb,
        MAX(pa12.bestandaktionsstart) AS bestandaktionsstart,
        MAX(pa12.verpackungwb) AS verpackungwb,
        MAX(pa12.abverkauftemengewebestandwerbu) AS abverkauftemengewebestandwerbu,
        MAX(pa12.umsatznettowerbung) AS umsatznettowerbung,
        MAX(pa12.abverkauftemengewerbung) AS abverkauftemengewerbung,
        MAX(pa12.abverkauftemenge6wo) AS abverkauftemenge6wo,
        MAX(pa12.endbestand) AS endbestand,
        MAX(pa12.anzahlnullbestnde) AS anzahlnullbestnde,
        MAX(pa18.anzahltagederaktion) AS anzahltagederaktion,
        MAX(pa12.marktrestlaufzeit) AS marktrestlaufzeit,
        (CASE WHEN MAX(pa12.wjxbfs1) < 0 THEN 0 ELSE MAX(pa12.wjxbfs1) END) AS berbestand,
        MAX(pa12.wareneingangzlinaktion) AS wareneingangzlinaktion,
        MAX(pa12.wezlaktionbestandstart) AS wezlaktionbestandstart,
        MAX(pa12.wareneingangzlvoraktion) AS wareneingangzlvoraktion,
        MAX(pa12.abverkauftemengewebestand01) AS abverkauftemengewebestand01,
        MAX(pa12.abverkauftemengewebestand0103) AS abverkauftemengewebestand0103,
        MAX(pa12.abverkauftemenge01) AS abverkauftemenge01,
        MAX(pa12.abverkauftemenge0103) AS abverkauftemenge0103,
        MAX(pa18.anzahlartikelwerbung) AS anzahlartikelwerbung,
        MAX(pa18.anzahlfilialenwerbung) AS anzahlfilialenwerbung,
        MAX(IFNULL((pa12.abverkauftemengewerbung / NULLIF(((pa111.anzahlfilialenwerbungfrhilfsme * pa18.anzahltagederaktion) / NULLIF(pa18.anzahltagederaktion, 0)), 0)), 0)) AS rank_sort_metric,

        MAX(pa12.wareneingangzl) AS wareneingangzl,
        MAX(pa112.aktualisierungsdatum) AS aktualisierungsdatum,
        MAX(pa12.updatetimestamp) AS updatetimestamp,
        MAX(pa12.abverkauftemengewebestand04) AS abverkauftemengewebestand04,
        MAX(pa12.sollbestand) AS sollbestand,
        MAX(pa12.abverkauftemengewebestand07) AS abverkauftemengewebestand07,
        MAX(pa12.nullbestnde01tag) AS nullbestnde01tag,
        MAX(pa12.abverkauftemengewebestand03) AS abverkauftemengewebestand03,
        MAX(pa12.abverkauftemengewebestand05) AS abverkauftemengewebestand05,
        MAX(pa12.abverkauftemengewebestand02) AS abverkauftemengewebestand02,
        MAX(pa12.abverkauftemengewebestand06) AS abverkauftemengewebestand06,
        MAX(pa12.nullbestnde0103tag) AS nullbestnde0103tag
    FROM `zzmd03_avq` AS pa12
    JOIN dbp_msi_view_vis.mv_wup AS a13
        ON (pa12.mandant_id = a13.mandant_id AND pa12.wup_id = a13.wup_id)
    LEFT OUTER JOIN `zzmd02_avq` AS pa14
        ON (a13.mandant_id = pa14.mandant_id)
    JOIN dbp_msi_view_vis.mv_art_mutter_wb AS a15
        ON (pa12.art_id = a15.art_id AND pa12.mandant_id0 = a15.mandant_id)
    JOIN dbp_msi_view_vis.mv_art_wg_zu AS a16
        ON (pa12.art_id = a16.art_id AND pa12.mandant_id0 = a16.mandant_id)
    JOIN dbp_msi_view_vis.mv_wg_int AS a17
        ON (a16.wg_id = a17.wg_id)
    LEFT OUTER JOIN `zzmd04_avq` AS pa18
        ON (a13.mandant_id = pa18.mandant_id AND a15.art_mutter_wb_id = pa18.art_mutter_wb_id AND a15.mandant_id = pa18.mandant_id0 AND a15.posten_fg = pa18.posten_fg AND a17.owg_id = pa18.owg_id AND pa12.kjwo = pa18.kjwo AND pa12.werbe_typ_id = pa18.werbe_typ_id)
    JOIN dbp_msi_view_vis.mv_owg_int AS a19
        ON (a17.owg_id = a19.owg_id)
    JOIN dbp_msi_view_vis.mv_hwg_int AS a110
        ON (a19.hwg_id = a110.hwg_id)
    LEFT OUTER JOIN `zzmd05_avq` AS pa111
        ON (a110.abt_id = pa111.abt_id AND a13.mandant_id = pa111.mandant_id AND a15.art_mutter_wb_id = pa111.art_mutter_wb_id AND a15.mandant_id = pa111.mandant_id0 AND a15.posten_fg = pa111.posten_fg AND pa12.kjwo = pa111.kjwo AND pa12.werbe_typ_id = pa111.werbe_typ_id)
    LEFT OUTER JOIN `zzmd06_avq` AS pa112
        ON (a13.mandant_id = pa112.mandant_id)
    JOIN dbp_msi_view_vis.mv_werbe_woche AS a113
        ON (pa12.kjwo = a113.kjwo AND pa12.werbe_typ_id = a113.werbe_typ_id)
    JOIN dbp_msi_view_vis.mv_art AS a114
        ON (a13.mandant_id = a114.mandant_id AND pa12.art_id = a114.art_id AND pa12.mandant_id0 = a114.mandant_id)
    JOIN dbp_msi_view_vis.mv_l_werbe_typ AS a115
        ON (pa12.werbe_typ_id = a115.werbe_typ_id)
    JOIN dbp_msi_view_vis.mv_woche AS a116
        ON (pa12.kjwo = a116.kjwo)
    JOIN dbp_msi_view_vis.mv_vkl AS a117
        ON (a13.mandant_id = a117.mandant_id AND a13.vkl_id = a117.vkl_id)
    JOIN dbp_msi_view_vis.mv_abt_int AS a118
        ON (a110.abt_id = a118.abt_id)
    JOIN dbp_msi_view_vis.mv_mandant AS a119
        ON (a115.mandant_id = a119.mandant_id AND a13.mandant_id = a119.mandant_id)
    GROUP BY
        pa12.art_id,
        pa12.mandant_id0,
        pa12.wup_id,
        pa12.mandant_id,
        a13.mandant_id,
        CASE
            WHEN a13.mandant_id = 1 AND a13.vs_id = 7 THEN 11
            WHEN a13.mandant_id = 1 AND a13.vs_id = 2 THEN 12
            WHEN a13.mandant_id = 1 AND a13.vs_id = 3 THEN 13
            WHEN a13.mandant_id = 1 AND a13.vs_id = 1 THEN 14
            WHEN a13.mandant_id = 1 AND a13.vs_id = 8 THEN 15
            WHEN a13.mandant_id = 1 AND a13.vs_id = 6 THEN 16
            WHEN a13.mandant_id = 2 AND a13.vs_id = 1 THEN 21
            WHEN a13.mandant_id = 2 AND a13.vs_id = 2 THEN 22
            ELSE a13.mandant_id * 10 + 9
        END,
        pa12.werbe_typ_id,
        a113.ww_von_bis,
        pa12.kjwo,
        a110.abt_id,
        a15.posten_fg,
        a15.art_mutter_wb_id,
        a15.mandant_id,
        a16.wg_id,
        a13.vkl_id
)

SELECT
    art_id,
    mandant_id,
    kl_art_nr,
    wup_id,
    mandant_id0,
    mandant_id1,
    mandant_sort_id,
    vs_id,
    mandant_id2,
    werbe_typ_id,
    sort_id,
    ww_von_bis,
    kjwo,
    wo_von_bis,
    kjwo_bez,
    akt_wo,
    wo_kj,
    abt_id,
    sort_id0,
    posten_fg,
    art_mutter_wb_id,
    mandant_id3,
    wg_id,
    sort_id1,
    vkl_id,
    mandant_id4,
    vkl_sort,
    rotemarkierungbeiavqx,
    abverkauftemengeperanzahltageh,
    anzartikelxfilialenxtagehilfsm,
    filterwareneingangzlbestandsta,
    minsicherheitsbestand,
    anzahlfilialenhilfsmetrik,
    einheitwb,
    bestandaktionsstart,
    verpackungwb,
    abverkauftemengewebestandwerbu,
    umsatznettowerbung,
    abverkauftemengewerbung,
    abverkauftemenge6wo,
    endbestand,
    anzahlnullbestnde,
    anzahltagederaktion,
    marktrestlaufzeit,
    berbestand,
    wareneingangzlinaktion,
    wezlaktionbestandstart,
    wareneingangzlvoraktion,
    abverkauftemengewebestand01,
    abverkauftemengewebestand0103,
    abverkauftemenge01,
    abverkauftemenge0103,
    anzahlartikelwerbung,
    anzahlfilialenwerbung,
    RANK() OVER (
        PARTITION BY
            kjwo,
            werbe_typ_id,
            vs_id,
            mandant_id1,
            mandant_id1
        ORDER BY
            mandant_sort_id ASC NULLS LAST,
            akt_wo ASC NULLS LAST,
            kjwo ASC NULLS LAST,
            kjwo_bez DESC NULLS FIRST,
            wo_kj ASC NULLS LAST,
            wo_von_bis DESC NULLS FIRST,
            werbe_typ_id ASC NULLS LAST,
            sort_id ASC NULLS LAST,
            vs_id ASC NULLS LAST,
            sort_id0 ASC NULLS LAST,
            posten_fg DESC NULLS FIRST,
            rank_sort_metric ASC NULLS LAST,
            art_mutter_wb_id ASC NULLS LAST,
            mandant_id3 ASC NULLS LAST,
            kl_art_nr ASC NULLS LAST,
            sort_id1 ASC NULLS LAST,
            vkl_sort ASC NULLS LAST
    ) AS lfdnrmenge,

    wareneingangzl,
    aktualisierungsdatum,
    updatetimestamp,
    abverkauftemengewebestand04,
    sollbestand,
    abverkauftemengewebestand07,
    nullbestnde01tag,
    abverkauftemengewebestand03,
    abverkauftemengewebestand05,
    abverkauftemengewebestand02,
    abverkauftemengewebestand06,
    nullbestnde0103tag
FROM AggregatedData;


CREATE OR REPLACE TEMPORARY TABLE zzmd08_avq (
    art_id INTEGER,
    mandant_id INTEGER
);


INSERT INTO zzmd08_avq
(
    SELECT
        art_id,
        mandant_id
    FROM zzmd07_avq AS PA11
    GROUP BY
        art_id,
        mandant_id
);


CREATE OR REPLACE TEMPORARY TABLE zzmd09_avq (
    abt_id INTEGER,
    sort_id INTEGER,
    abt_bez_bg STRING(100),
    abt_bez_cz STRING(100),
    abt_bez STRING(100),
    abt_bez_pl STRING(100),
    abt_bez_ro STRING(100),
    abt_bez_hr STRING(100),
    abt_bez_sk STRING(100),
    art_id INTEGER,
    mandant_id INTEGER,
    art_bez_bg STRING(50),
    art_bez_cz STRING(50),
    art_bez STRING(50),
    art_bez_pl STRING(50),
    art_bez_ro STRING(50),
    art_bez_hr STRING(50),
    art_bez_sk STRING(50),
    kl_art_nr STRING(8),
    art_mutter_wb_id INTEGER,
    mandant_id0 INTEGER,
    art_mutter_wb_bez STRING(50),
    art_mutter_wb_fg INTEGER,
    art_mutter_wb_nr STRING(8),
    art_mutter_bezugsweg_id INTEGER,
    bezugsweg_bez STRING(30),
    art_display_id INTEGER,
    owg_id INTEGER,
    owg_bez_bg STRING(100),
    owg_bez_cz STRING(100),
    owg_bez STRING(100),
    owg_bez_pl STRING(100),
    owg_bez_ro STRING(100),
    owg_bez_hr STRING(100),
    owg_bez_sk STRING(100),
    posten_fg INTEGER,
    posten_fg_desc STRING(30),
    saison_id STRING(4),
    mandant_id1 INTEGER,
    saison_bez_bg STRING(30),
    saison_bez_cz STRING(30),
    saison_bez STRING(30),
    saison_bez_pl STRING(30),
    saison_bez_ro STRING(30),
    saison_bez_hr STRING(30),
    saison_bez_sk STRING(30),
    wg_id INTEGER,
    wg_bez_bg STRING(100),
    wg_bez_cz STRING(100),
    wg_bez STRING(100),
    wg_bez_pl STRING(100),
    wg_bez_ro STRING(100),
    wg_bez_hr STRING(100),
    wg_bez_sk STRING(100),
    sort_id1 INTEGER
);


CREATE OR REPLACE TEMPORARY TABLE _p1 AS
SELECT *
FROM dbp_msi_view_vis.mv_art_wg_zu
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM zzmd08_avq
);


CREATE OR REPLACE TEMPORARY TABLE _p2 AS
SELECT *
FROM dbp_msi_view_vis.mv_art_mutter_wb
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM zzmd08_avq
)
AND art_mutter_wb_nr <> '-00000000';


CREATE OR REPLACE TEMPORARY TABLE _p3 AS
SELECT *
FROM dbp_msi_view_vis.mv_art_spr_zu
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM zzmd08_avq
);


CREATE OR REPLACE TEMPORARY TABLE _p4 AS
SELECT *
FROM dbp_msi_view_vis.mv_art
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM zzmd08_avq
);


INSERT INTO zzmd09_avq
(
    SELECT
        A15.abt_id  AS abt_id,
        CAST(MAX(A115.sort_id) AS INTEGER) AS sort_id,
        MAX(A116.abt_bez_bg) AS abt_bez_bg,
        MAX(A116.abt_bez_cz) AS abt_bez_cz,
        MAX(A116.abt_bez) AS abt_bez,
        MAX(A116.abt_bez_pl) AS abt_bez_pl,
        MAX(A116.abt_bez_ro) AS abt_bez_ro,
        MAX(A116.abt_bez_hr) AS abt_bez_hr,
        MAX(A116.abt_bez_sk) AS abt_bez_sk,
        PA11.art_id,
        PA11.mandant_id,
        MAX(A18.art_bez_bg) AS art_bez_bg,
        MAX(A18.art_bez_cz) AS art_bez_cz,
        MAX(A18.art_bez) AS art_bez,
        MAX(A18.art_bez_pl) AS art_bez_pl,
        MAX(A18.art_bez_ro) AS art_bez_ro,
        MAX(A18.art_bez_hr) AS art_bez_hr,
        MAX(A18.art_bez_sk) AS art_bez_sk,
        MAX(A19.kl_art_nr) AS kl_art_nr,
        A16.art_mutter_wb_id,
        A16.mandant_id AS mandant_id0,
        MAX(A16.art_mutter_wb_bez) AS art_mutter_wb_bez,
        CAST(MAX(A16.art_mutter_wb_fg) AS INTEGER) AS art_mutter_wb_fg,
        MAX(A16.art_mutter_wb_nr) AS art_mutter_wb_nr,
        CAST(A17.art_mutter_bezugsweg_id AS INTEGER) AS art_mutter_bezugsweg_id,
        MAX(A113.bezugsweg_bez) AS bezugsweg_bez,
        A16.art_mutter_display_id AS art_display_id,
        CAST(A13.owg_id AS INTEGER) AS owg_id,
        MAX(A114.owg_bez_bg) AS owg_bez_bg,
        MAX(A114.owg_bez_cz) AS owg_bez_cz,
        MAX(A114.owg_bez) AS owg_bez,
        MAX(A114.owg_bez_pl) AS owg_bez_pl,
        MAX(A114.owg_bez_ro) AS owg_bez_ro,
        MAX(A114.owg_bez_hr) AS owg_bez_hr,
        MAX(A114.owg_bez_sk) AS owg_bez_sk,
        A16.posten_fg,
        MAX(CASE
            WHEN A16.posten_fg = 1
                THEN 'Posten & Promotion'
            WHEN A16.posten_fg = 0
                THEN 'Sortiment'
            ELSE NULL
        END) AS posten_fg_desc,
        A16.art_mutter_saison_id AS saison_id,
        CAST(A110.mandant_id AS INTEGER) AS mandant_id1,
        MAX(A111.saison_bez_bg) AS saison_bez_bg,
        MAX(A111.saison_bez_cz) AS saison_bez_cz,
        MAX(A111.saison_bez) AS saison_bez,
        MAX(A111.saison_bez_pl) AS saison_bez_pl,
        MAX(A111.saison_bez_ro) AS saison_bez_ro,
        MAX(A111.saison_bez_hr) AS saison_bez_hr,
        MAX(A111.saison_bez_sk) AS saison_bez_sk,
        CAST(A12.wg_id AS INTEGER) AS wg_id,
        MAX(A112.wg_bez_bg) AS wg_bez_bg,
        MAX(A112.wg_bez_cz) AS wg_bez_cz,
        MAX(A112.wg_bez) AS wg_bez,
        MAX(A112.wg_bez_pl) AS wg_bez_pl,
        MAX(A112.wg_bez_ro) AS wg_bez_ro,
        MAX(A112.wg_bez_hr) AS wg_bez_hr,
        MAX(A112.wg_bez_sk) AS wg_bez_sk,
        CAST(MAX(A13.sort_id) AS INTEGER) AS sort_id1
    FROM zzmd08_avq AS PA11
    INNER JOIN `_p1` AS A12 ON PA11.art_id = A12.art_id AND PA11.mandant_id = A12.mandant_id
    INNER JOIN dbp_msi_view_vis.mv_wg_int AS A13 ON A12.wg_id = A13.wg_id
    INNER JOIN dbp_msi_view_vis.mv_owg_int AS A14 ON A13.owg_id = A14.owg_id
    INNER JOIN dbp_msi_view_vis.mv_hwg_int AS A15 ON A14.hwg_id = A15.hwg_id
    INNER JOIN `_p2` AS A16 ON PA11.art_id = A16.art_id AND PA11.mandant_id = A16.mandant_id
    INNER JOIN dbp_msi_view_vis.mv_art_mutter_bezugsweg_wup AS A17
        ON
            A12.mandant_id = A17.mandant_id AND
            A16.art_mutter_wb_id = A17.art_mutter_wb_id AND A16.mandant_id = A17.mandant_id
    INNER JOIN `_p3` AS A18 ON A12.mandant_id = A18.mandant_id AND PA11.art_id = A18.art_id AND PA11.mandant_id = A18.mandant_id

    INNER JOIN `_p4` AS A19 ON A12.mandant_id = A19.mandant_id AND PA11.art_id = A19.art_id AND PA11.mandant_id = A19.mandant_id

    INNER JOIN dbp_msi_view_vis.mv_l_saison AS A110
        ON
            A12.mandant_id = A110.mandant_id AND A16.art_mutter_saison_id
            = A110.saison_id
    INNER JOIN dbp_msi_view_vis.mv_saison_spr_zu AS A111
        ON
            A110.mandant_id = A111.mandant_id AND A16.art_mutter_saison_id
            = A111.saison_id
    INNER JOIN dbp_msi_view_vis.mv_wg_int_spr_zu AS A112 ON A12.wg_id = A112.wg_id
    INNER JOIN dbp_msi_view_vis.mv_bezugsweg_spr_zu AS A113 ON A17.art_mutter_bezugsweg_id = A113.bezugsweg_id

    INNER JOIN dbp_msi_view_vis.mv_owg_int_spr_zu AS A114 ON A13.owg_id = A114.owg_id
    INNER JOIN dbp_msi_view_vis.mv_abt_int AS A115 ON A15.abt_id = A115.abt_id
    INNER JOIN dbp_msi_view_vis.mv_abt_int_spr_zu AS A116 ON A15.abt_id = A116.abt_id
    GROUP BY
        A15.abt_id,
        PA11.art_id,
        PA11.mandant_id,
        A16.art_mutter_wb_id,
        mandant_id0,
        A17.art_mutter_bezugsweg_id,
        art_display_id,
        A13.owg_id,
        A16.posten_fg,
        saison_id,
        mandant_id1,
        A12.wg_id
);


CREATE OR REPLACE TEMPORARY TABLE zzmd0a_avq (
    wup_id INTEGER,
    mandant_id INTEGER
);


INSERT INTO zzmd0a_avq
(
    SELECT
        wup_id,
        mandant_id0 AS mandant_id
    FROM zzmd07_avq AS PA11
    GROUP BY
        wup_id,
        mandant_id0
);


CREATE OR REPLACE TEMPORARY TABLE zzmd0b_avq (
    wup_id INTEGER,
    mandant_id INTEGER,
    wup_standort STRING(40),
    gf_id INTEGER,
    mandant_id0 INTEGER,
    gf_name_bg STRING(40),
    gf_name_cz STRING(40),
    gf_name STRING(40),
    gf_name_pl STRING(40),
    gf_name_ro STRING(40),
    gf_name_hr STRING(40),
    gf_name_sk STRING(40),
    mandant_id1 INTEGER,
    mandant_bez STRING(40),
    mandant_sort_id INTEGER,
    vs_id INTEGER,
    mandant_id2 INTEGER,
    vs_bez STRING(40),
    vkl_id INTEGER,
    mandant_id3 INTEGER,
    vkl_name_bg STRING(40),
    vkl_name_cz STRING(40),
    vkl_name STRING(40),
    vkl_name_pl STRING(40),
    vkl_name_ro STRING(40),
    vkl_name_hr STRING(40),
    vkl_name_sk STRING(40),
    vkl_sort STRING(40)
);


INSERT INTO zzmd0b_avq
(
    SELECT
        PA11.wup_id,
        PA11.mandant_id,
        MAX(A12.wup_standort) AS wup_standort,
        CAST(A12.gf_id AS INTEGER) AS gf_id,
        CAST(A12.mandant_id AS INTEGER) AS mandant_id0,
        MAX(TRIM(A13.ma_name_bg) || ' ' || TRIM(A13.ma_vorname_bg)) AS gf_name_bg,
        MAX(TRIM(A13.ma_name_cz) || ' ' || TRIM(A13.ma_vorname_cz)) AS gf_name_cz,
        MAX(TRIM(A13.ma_name) || ' ' || TRIM(A13.ma_vorname)) AS gf_name,
        MAX(TRIM(A13.ma_name_pl) || ' ' || TRIM(A13.ma_vorname_pl)) AS gf_name_pl,
        MAX(TRIM(A13.ma_name_ro) || ' ' || TRIM(A13.ma_vorname_ro)) AS gf_name_ro,
        MAX(TRIM(A13.ma_name_hr) || ' ' || TRIM(A13.ma_vorname_hr)) AS gf_name_hr,
        MAX(TRIM(A13.ma_name_sk) || ' ' || TRIM(A13.ma_vorname_sk)) AS gf_name_sk,
        CAST(A12.mandant_id AS INTEGER) AS mandant_id1,
        MAX(A16.mandant_bez) AS mandant_bez,
        CAST(MAX(A16.mandant_sort_id) AS INTEGER) AS mandant_sort_id,
        CAST(CASE
            WHEN A12.mandant_id = 1 AND A12.vs_id = 7
                THEN 11
            WHEN A12.mandant_id = 1 AND A12.vs_id = 2
                THEN 12
            WHEN A12.mandant_id = 1 AND A12.vs_id = 3
                THEN 13
            WHEN A12.mandant_id = 1 AND A12.vs_id = 1
                THEN 14
            WHEN A12.mandant_id = 1 AND A12.vs_id = 8
                THEN 15
            WHEN A12.mandant_id = 1 AND A12.vs_id = 6
                THEN 16
            WHEN A12.mandant_id = 2 AND A12.vs_id = 1
                THEN 21
            WHEN A12.mandant_id = 2 AND A12.vs_id = 2
                THEN 22
            ELSE A12.mandant_id * 10 + 9
        END AS INTEGER) AS vs_id,
        CAST(A12.mandant_id AS INTEGER) AS mandant_id2,
        MAX(A14.vsvt_bez) AS vs_bez,
        CAST(A12.vkl_id AS INTEGER) AS vkl_id,
        CAST(A12.mandant_id AS INTEGER) AS mandant_id3,
        MAX(TRIM(A15.ma_name_bg) || ' ' || TRIM(A15.ma_vorname_bg)) AS vkl_name_bg,
        MAX(TRIM(A15.ma_name_cz) || ' ' || TRIM(A15.ma_vorname_cz)) AS vkl_name_cz,
        MAX(TRIM(A15.ma_name) || ' ' || TRIM(A15.ma_vorname)) AS vkl_name,
        MAX(TRIM(A15.ma_name_pl) || ' ' || TRIM(A15.ma_vorname_pl)) AS vkl_name_pl,
        MAX(TRIM(A15.ma_name_ro) || ' ' || TRIM(A15.ma_vorname_ro)) AS vkl_name_ro,
        MAX(TRIM(A15.ma_name_hr) || ' ' || TRIM(A15.ma_vorname_hr)) AS vkl_name_hr,
        MAX(TRIM(A15.ma_name_sk) || ' ' || TRIM(A15.ma_vorname_sk)) AS vkl_name_sk,
        MAX(CASE
            WHEN A15.vkl_id < 0
                THEN 'ZZZ' || CAST(A15.vkl_id AS STRING)
            ELSE A15.ma_name
        END) AS vkl_sort
    FROM zzmd0a_avq AS PA11
    INNER JOIN dbp_msi_view_vis.mv_wup AS A12 ON PA11.mandant_id = A12.mandant_id AND PA11.wup_id = A12.wup_id

    INNER JOIN dbp_msi_view_vis.mv_gf AS A13 ON A12.gf_id = A13.gf_id AND A12.mandant_id = A13.mandant_id
    INNER JOIN dbp_msi_view_vis.mv_vs AS A14
        ON CASE
            WHEN A12.mandant_id = 1 AND A12.vs_id = 7
                THEN 11
            WHEN A12.mandant_id = 1 AND A12.vs_id = 2
                THEN 12
            WHEN A12.mandant_id = 1 AND A12.vs_id = 3
                THEN 13
            WHEN A12.mandant_id = 1 AND A12.vs_id = 1
                THEN 14
            WHEN A12.mandant_id = 1 AND A12.vs_id = 8
                THEN 15
            WHEN A12.mandant_id = 1 AND A12.vs_id = 6
                THEN 16
            WHEN A12.mandant_id = 2 AND A12.vs_id = 1
                THEN 21
            WHEN A12.mandant_id = 2 AND A12.vs_id = 2
                THEN 22
            ELSE A12.mandant_id * 10 + 9
        END = CASE
            WHEN A14.mandant_id = 1 AND A14.vs_id = 7
                THEN 11
            WHEN A14.mandant_id = 1 AND A14.vs_id = 2
                THEN 12
            WHEN A14.mandant_id = 1 AND A14.vs_id = 3
                THEN 13
            WHEN A14.mandant_id = 1 AND A14.vs_id = 1
                THEN 14
            WHEN A14.mandant_id = 1 AND A14.vs_id = 8
                THEN 15
            WHEN A14.mandant_id = 1 AND A14.vs_id = 6
                THEN 16
            WHEN A14.mandant_id = 2 AND A14.vs_id = 1
                THEN 21
            WHEN A14.mandant_id = 2 AND A14.vs_id = 2
                THEN 22
            ELSE A14.mandant_id * 10 + 9
        END AND A12.mandant_id = A14.mandant_id
    INNER JOIN dbp_msi_view_vis.mv_vkl AS A15 ON A12.mandant_id = A15.mandant_id AND A12.vkl_id = A15.vkl_id

    INNER JOIN dbp_msi_view_vis.mv_mandant AS A16 ON A12.mandant_id = A16.mandant_id
    GROUP BY
        PA11.wup_id,
        PA11.mandant_id,
        A12.gf_id,
        mandant_id0,
        vs_id,
        A12.vkl_id
);


CREATE OR REPLACE TEMPORARY TABLE zzmd0c_avq (
    werbe_typ_id INTEGER
);


INSERT INTO zzmd0c_avq
(
    SELECT werbe_typ_id
    FROM zzmd07_avq AS PA11
    GROUP BY werbe_typ_id
);


CREATE OR REPLACE TEMPORARY TABLE zzmd0d_avq (
    kjwo INTEGER
);


INSERT INTO zzmd0d_avq
(
    SELECT kjwo
    FROM zzmd07_avq AS PA11
    GROUP BY kjwo
);


CREATE OR REPLACE TEMPORARY TABLE zzmd0e_avq (
    ww_von_bis STRING(35)
);


INSERT INTO zzmd0e_avq
(
    SELECT ww_von_bis
    FROM zzmd07_avq AS PA11
    GROUP BY ww_von_bis
);


CREATE OR REPLACE TEMPORARY TABLE _avq AS
SELECT
    art_id,
    mandant_id,
    kl_art_nr,
    wup_id,
    mandant_id0,
    mandant_id1,
    mandant_sort_id,
    vs_id,
    mandant_id2,
    werbe_typ_id,
    sort_id,
    ww_von_bis,
    kjwo,
    wo_von_bis,
    kjwo_bez,
    akt_wo,
    wo_kj,
    abt_id,
    sort_id0,
    posten_fg,
    art_mutter_wb_id,
    mandant_id3,
    wg_id,
    sort_id1,
    vkl_id,
    mandant_id4,
    vkl_sort,
    rotemarkierungbeiavqx AS wjxbfs1,
    abverkauftemengeperanzahltageh AS wjxbfs2,
    anzartikelxfilialenxtagehilfsm AS wjxbfs3,
    filterwareneingangzlbestandsta AS wjxbfs4,
    minsicherheitsbestand AS wjxbfs5,
    anzahlfilialenhilfsmetrik AS wjxbfs6,
    einheitwb AS wjxbfs7,
    bestandaktionsstart AS wjxbfs8,
    verpackungwb AS wjxbfs9,
    abverkauftemengewebestandwerbu AS wjxbfsa,
    umsatznettowerbung AS wjxbfsb,
    abverkauftemengewerbung AS wjxbfsc,
    abverkauftemenge6wo AS wjxbfsd,
    endbestand AS wjxbfse,
    anzahlnullbestnde AS wjxbfsf,
    anzahltagederaktion AS wjxbfs10,
    marktrestlaufzeit AS wjxbfs11,
    berbestand AS wjxbfs12,
    wareneingangzlinaktion AS wjxbfs13,
    wezlaktionbestandstart AS wjxbfs14,
    wareneingangzlvoraktion AS wjxbfs15,
    abverkauftemengewebestand01 AS wjxbfs16,
    abverkauftemengewebestand0103 AS wjxbfs17,
    abverkauftemenge01 AS wjxbfs18,
    abverkauftemenge0103 AS wjxbfs19,
    anzahlartikelwerbung AS wjxbfs1a,
    anzahlfilialenwerbung AS wjxbfs1b,
    lfdnrmenge AS wjxbfs1c,
    wareneingangzl AS wjxbfs1d,
    aktualisierungsdatum AS wjxbfs1e,
    updatetimestamp AS wjxbfs1f,
    abverkauftemengewebestand04 AS wjxbfs20,
    sollbestand AS wjxbfs21,
    abverkauftemengewebestand07 AS wjxbfs22,
    nullbestnde01tag AS wjxbfs23,
    abverkauftemengewebestand03 AS wjxbfs24,
    abverkauftemengewebestand05 AS wjxbfs25,
    abverkauftemengewebestand02 AS wjxbfs26,
    abverkauftemengewebestand06 AS wjxbfs27,
    nullbestnde0103tag AS wjxbfs28
FROM zzmd07_avq AS PA11;


CREATE OR REPLACE TEMPORARY TABLE _avq_snap AS
SELECT
    mandant_id,
    kjwo,
    art_mutter_wb_id,
    SUM(wjxbfs16) / SUM(wjxbfs1d) * 100 AS avq_1,
    SUM(wjxbfs17) / SUM(wjxbfs1d) * 100 AS avq_3,
    SUM(wjxbfs27 + wjxbfs26 + wjxbfs25 + wjxbfs24 + wjxbfs22 + wjxbfs20 + wjxbfs16) / SUM(wjxbfs1d) * 100 AS avq,
    SUM(wjxbfs1d) AS wareneingang_zl,
    SUM(wjxbfsa) AS abverkaufte_menge_bestand,
    SUM(wjxbfsc) AS abverkaufte_menge,
    SUM(wjxbfsc) / IF(COUNT(DISTINCT wup_id) = 0, NULL, COUNT(DISTINCT wup_id)) AS durchschnitt_menge_pro_filiale,
    MAX(wjxbfs7) AS einheit_wb,
    SUM(wjxbfsb) AS umsatz_netto,
    SUM(
        wjxbfsb) / IF(COUNT(DISTINCT wup_id) = 0, NULL, COUNT(DISTINCT wup_id)) AS
    durchschnitt_umsatz_pro_artikel_pro_filiale,
    SUM(0) AS anz_nullbestand,
    CAST(SUM(0) AS NUMERIC) AS nullbestandsquote,
    SUM(wjxbfse) AS endbestand,
    SUM(wjxbfse) / IF(SUM(wjxbfsd) = 0, NULL, SUM(wjxbfsd)) AS umschlagsquote,
    COUNT(DISTINCT art_id) AS anz_artikel,
    COUNT(DISTINCT wup_id) AS anz_filialen
FROM `_avq`
WHERE
    (kjwo IN (vor_woche, akt_woche) OR kjwo = flg_woche AND werbe_typ_id = 3)
    AND mandant_id = 1
GROUP BY
    mandant_id,
    kjwo,
    art_mutter_wb_id
HAVING SUM(wjxbfs1d) <> 0;


INSERT INTO `_avq_snap`
(SELECT
    mandant_id,
    kjwo,
    art_mutter_wb_id,
    SUM(wjxbfs16) AS avq_1,
    SUM(wjxbfs17) AS avq_3,
    SUM(wjxbfs27 + wjxbfs26 + wjxbfs25 + wjxbfs24 + wjxbfs22 + wjxbfs20 + wjxbfs16) AS avq,
    SUM(wjxbfs1d) AS wareneingang_zl,
    SUM(wjxbfsa) AS abverkaufte_menge_bestand,
    SUM(wjxbfsc) AS abverkaufte_menge,
    SUM(wjxbfsc) / IF(COUNT(DISTINCT wup_id) = 0, NULL, COUNT(DISTINCT wup_id)) AS durchschnitt_menge_pro_filiale,
    MAX(wjxbfs7) AS einheit_wb,
    SUM(wjxbfsb) AS umsatz_netto,
    SUM(
        wjxbfsb) / IF(COUNT(DISTINCT wup_id) = 0, NULL, COUNT(DISTINCT wup_id)) AS
    durchschnitt_umsatz_pro_artikel_pro_filiale,
    SUM(0) AS anz_nullbestand,
    CAST(SUM(0) AS NUMERIC) AS nullbestandsquote,
    SUM(wjxbfse) AS endbestand,
    SUM(wjxbfse) / IF(SUM(wjxbfsd) = 0, NULL, SUM(wjxbfsd)) AS umschlagsquote,
    COUNT(DISTINCT art_id) AS anz_artikel,
    COUNT(DISTINCT wup_id) AS anz_filialen
FROM `_avq`
WHERE
    (kjwo IN (vor_woche, akt_woche) OR kjwo = flg_woche AND werbe_typ_id = 3)
    AND mandant_id = 1
GROUP BY
    mandant_id,
    kjwo,
    art_mutter_wb_id
HAVING wareneingang_zl = 0);


CREATE OR REPLACE TEMPORARY TABLE _avq_nb AS
SELECT
    mandant_id,
    kjwo,
    mutter_wb_id,
    CAST(SUM(anzahl_nullbestand) AS NUMERIC) AS anzahl_nullbestand,
    ROUND(CAST(SUM(
        CAST(anzahl_nullbestand AS NUMERIC)) / IF(
        CAST(COUNT(DISTINCT wup_id) * MAX(anzahl_tage_aktion) * COUNT(DISTINCT art_id) AS NUMERIC)
        = 0, NULL, CAST(COUNT(DISTINCT wup_id) * MAX(anzahl_tage_aktion) * COUNT(DISTINCT art_id) AS NUMERIC)
    ) * 100.0000
    AS NUMERIC), 4) AS nullbestandsquote
FROM dbp_data.werbung_kennzahlen_woche
WHERE (
    mandant_id = 1 AND menge_tag1 + menge_tag2 + menge_tag3 + menge_tag4 + menge_tag5 + menge_tag6 + menge_tag7 <> 0
    OR mandant_id = 1 AND we_menge_zentral <> 0
)
AND (kjwo IN (vor_woche, akt_woche) OR kjwo = flg_woche AND werbe_typ_id = 3)
GROUP BY
    mandant_id,
    kjwo,
    mutter_wb_id;


UPDATE `_avq_snap` SET
    nullbestandsquote = b.nullbestandsquote,
    anz_nullbestand = CAST(b.anzahl_nullbestand AS INTEGER)
FROM `_avq_nb` AS b
WHERE `_avq_snap`.mandant_id = b.mandant_id AND `_avq_snap`.art_mutter_wb_id = b.mutter_wb_id AND `_avq_snap`.kjwo = b.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _avq_snap2 AS
SELECT
    mandant_id,
    CASE
        WHEN kjwo = flg_woche
            THEN akt_woche
        ELSE kjwo
    END AS kjwo_,
    art_mutter_wb_id,
    avq_1,
    avq_3,
    avq,
    wareneingang_zl,
    abverkaufte_menge_bestand,
    abverkaufte_menge,
    durchschnitt_menge_pro_filiale,
    einheit_wb,
    umsatz_netto,
    durchschnitt_umsatz_pro_artikel_pro_filiale,
    anz_nullbestand,
    nullbestandsquote,
    endbestand,
    umschlagsquote,
    anz_artikel,
    anz_filialen
FROM `_avq_snap` AS A
QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, CASE
    WHEN kjwo = flg_woche
        THEN akt_woche
    ELSE kjwo
END, art_mutter_wb_id ORDER BY avq IS NULL DESC, avq DESC)) = 1;


CREATE OR REPLACE TEMPORARY TABLE _artbew_avq AS
SELECT
    A.mandant_id,
    A.kjwo_ww,
    A.kjwo,
    A.mutter_art_id,
    A.kl_art_id,
    A.aktion_thema_gruppe_id,
    A.werbe_kat_id,
    A.gp_id,
    A.aktionsart_id_liste_txt,
    A.aktionsart_bez_liste_txt,
    A.aktion_typ_id_liste_txt,
    A.aktion_typ_bez_liste_txt,
    A.wg_id,
    A.umsatz_netto_sa_west_,
    A.absatz_sa_west_,
    A.ek_mep_sa_west_,
    A.logkostenzuschlag_sa_west_wg30_,
    A.logkostenzuschlag_sa_west_,
    A.rohertrag_sa_west_,
    A.spanne_sa_west_,
    A.preisvorteil_west,
    A.wa_kalk_abschriften_sa_west_,
    A.wa_kalk_nach_pv_sa_west_,
    A.spanne_wa_kalk_nach_pv_sa_west_,
    A.umsatz_netto_sa_ost_,
    A.absatz_sa_ost_,
    A.ek_mep_sa_ost_,
    A.logkostenzuschlag_sa_ost_wg30_,
    A.logkostenzuschlag_sa_ost_,
    A.rohertrag_sa_ost_,
    A.spanne_sa_ost_,
    A.preisvorteil_ost,
    A.wa_kalk_abschriften_sa_ost_,
    A.wa_kalk_nach_pv_sa_ost_,
    A.spanne_wa_kalk_nach_pv_sa_ost_,
    A.umsatz_netto_sa_sued_,
    A.absatz_sa_sued_,
    A.ek_mep_sa_sued_,
    A.logkostenzuschlag_sa_sued_wg30_,
    A.logkostenzuschlag_sa_sued_,
    A.rohertrag_sa_sued_,
    A.spanne_sa_sued_,
    A.preisvorteil_sued,
    A.wa_kalk_abschriften_sa_sued_,
    A.wa_kalk_nach_pv_sa_sued_,
    A.spanne_wa_kalk_nach_pv_sa_sued_,
    A.umsatz_netto_sa_,
    A.absatz_sa_,
    A.ek_mep_sa_,
    A.logkostenzuschlag_sa_wg30_,
    A.logkostenzuschlag_sa_,
    A.rohertrag_sa_,
    A.spanne_sa_,
    A.preisvorteil,
    A.wa_kalk_abschriften_sa_,
    A.wa_kalk_nach_pv_sa_,
    A.spanne_wa_kalk_nach_pv_sa_,
    A.umsatz_netto_sa_loyalty_,
    A.absatz_sa_loyalty_,
    A.ek_mep_sa_loyalty_,
    A.logkostenzuschlag_sa_loyalty_wg30_,
    A.logkostenzuschlag_sa_loyalty_,
    A.rohertrag_sa_loyalty_,
    A.wa_kalk_abschriften_sa_loyalty_,
    A.wa_kalk_nach_pv_sa_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_loyalty_,
    A.umsatz_netto_sa_aktion_loyalty_,
    A.absatz_sa_aktion_loyalty_,
    A.ek_mep_sa_aktion_loyalty_,
    A.logkostenzuschlag_sa_aktion_loyalty_wg30_,
    A.logkostenzuschlag_sa_aktion_loyalty_,
    A.rohertrag_sa_aktion_loyalty_,
    A.wa_kalk_abschriften_sa_aktion_loyalty_,
    A.wa_kalk_nach_pv_sa_aktion_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_aktion_loyalty_,
    A.umsatz_netto_sa_bby_loyalty_,
    A.absatz_sa_bby_loyalty_,
    A.ek_mep_sa_bby_loyalty_,
    A.logkostenzuschlag_sa_bby_loyalty_wg30_,
    A.logkostenzuschlag_sa_bby_loyalty_,
    A.rohertrag_sa_bby_loyalty_,
    A.wa_kalk_abschriften_sa_bby_loyalty_,
    A.wa_kalk_nach_pv_sa_bby_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_bby_loyalty_,
    A.umsatz_netto_sa_kdn_bby_loyalty_,
    A.absatz_sa_kdn_bby_loyalty_,
    A.ek_mep_sa_kdn_bby_loyalty_,
    A.logkostenzuschlag_sa_kdn_bby_loyalty_wg30_,
    A.logkostenzuschlag_sa_kdn_bby_loyalty_,
    A.rohertrag_sa_kdn_bby_loyalty_,
    A.wa_kalk_abschriften_sa_kdn_bby_loyalty_,
    A.wa_kalk_nach_pv_sa_kdn_bby_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty_,
    A.umsatz_netto_sa_kdp_bby_loyalty_,
    A.absatz_sa_kdp_bby_loyalty_,
    A.ek_mep_sa_kdp_bby_loyalty_,
    A.logkostenzuschlag_sa_kdp_bby_loyalty_wg30_,
    A.logkostenzuschlag_sa_kdp_bby_loyalty_,
    A.rohertrag_sa_kdp_bby_loyalty_,
    A.wa_kalk_abschriften_sa_kdp_bby_loyalty_,
    A.wa_kalk_nach_pv_sa_kdp_bby_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty_,
    A.umsatz_netto_sa_non_loyalty_,
    A.absatz_sa_non_loyalty_,
    A.ek_mep_sa_non_loyalty_,
    A.logkostenzuschlag_sa_non_loyalty_wg30_,
    A.logkostenzuschlag_sa_non_loyalty_,
    A.rohertrag_sa_non_loyalty_,
    A.wa_kalk_abschriften_sa_non_loyalty_,
    A.wa_kalk_nach_pv_sa_non_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_non_loyalty_,
    A.umsatz_netto_sa_aktion_non_loyalty_,
    A.absatz_sa_aktion_non_loyalty_,
    A.ek_mep_sa_aktion_non_loyalty_,
    A.logkostenzuschlag_sa_aktion_non_loyalty_wg30_,
    A.logkostenzuschlag_sa_aktion_non_loyalty_,
    A.rohertrag_sa_aktion_non_loyalty_,
    A.wa_kalk_abschriften_sa_aktion_non_loyalty_,
    A.wa_kalk_nach_pv_sa_aktion_non_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty_,
    A.umsatz_netto_sa_bby_non_loyalty_,
    A.absatz_sa_bby_non_loyalty_,
    A.ek_mep_sa_bby_non_loyalty_,
    A.logkostenzuschlag_sa_bby_non_loyalty_wg30_,
    A.logkostenzuschlag_sa_bby_non_loyalty_,
    A.rohertrag_sa_bby_non_loyalty_,
    A.wa_kalk_abschriften_sa_bby_non_loyalty_,
    A.wa_kalk_nach_pv_sa_bby_non_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_bby_non_loyalty_,
    A.umsatz_netto_sa_bonrabatt_bby_loyalty_,
    A.absatz_sa_bonrabatt_bby_loyalty_,
    A.ek_mep_sa_bonrabatt_bby_loyalty_,
    A.logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30_,
    A.logkostenzuschlag_sa_bonrabatt_bby_loyalty_,
    A.rohertrag_sa_bonrabatt_bby_loyalty_,
    A.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty_,
    A.wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty_,
    A.umsatz_netto_sa_bonrabatt_bby_non_loyalty_,
    A.absatz_sa_bonrabatt_bby_non_loyalty_,
    A.ek_mep_sa_bonrabatt_bby_non_loyalty_,
    A.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30_,
    A.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_,
    A.rohertrag_sa_bonrabatt_bby_non_loyalty_,
    A.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty_,
    A.wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty_,
    A.pv_aktion_loy,
    A.pv_aktion_non_loy,
    A.pv_bby_loy,
    A.pv_bby_non_loy,
    A.pv_kdn_bby,
    A.pv_kdp_bby,
    A.pv_bonrabatt_bby_loy,
    A.pv_bonrabatt_bby_non_loy,
    B.avq_1,
    B.avq_3,
    B.avq,
    B.wareneingang_zl,
    B.abverkaufte_menge_bestand,
    B.abverkaufte_menge,
    B.durchschnitt_menge_pro_filiale,
    B.einheit_wb,
    B.umsatz_netto,
    B.durchschnitt_umsatz_pro_artikel_pro_filiale,
    B.anz_nullbestand,
    B.nullbestandsquote,
    B.endbestand,
    B.umschlagsquote,
    B.anz_artikel,
    B.anz_filialen
FROM `_artbew4` AS A
LEFT JOIN `_avq_snap2` AS B ON A.mandant_id = B.mandant_id AND A.mutter_art_id = B.art_mutter_wb_id AND A.kjwo = B.kjwo_;


CREATE OR REPLACE TEMPORARY TABLE _shopper1 AS
SELECT
    mandant_id,
    art_id_werbung,
    SUM(anz_kaeufer_af) AS anz_kaeufer_af,
    SUM(ums_netto_baseline_af) AS ums_netto_baseline_af,
    SUM(ertrag_baseline_af) AS ertrag_baseline_af,
    SUM(menge_baseline_af) AS menge_baseline_af,
    SUM(menge_sa) AS menge_sa,
    SUM(anz_bon_aktion) AS anz_bon_aktion,
    SUM(anz_tage_baseline_af) AS anz_tage_baseline_af,
    SUM(ertrag_sa) AS ertrag_sa,
    SUM(anz_tage_sa) AS anz_tage_sa,
    SUM(anz_bon_sa) AS anz_bon_sa,
    SUM(anz_bon_af) AS anz_bon_af,
    SUM(ums_netto_sa) AS ums_netto_sa,
    SUM(anz_cp_kaeufer) AS anz_cp_kaeufer,
    SUM(anz_cp_kaeufer_70_prozent) AS anz_cp_kaeufer_70_prozent,
    SUM(ums_gesamt_af_mit_wv) AS ums_gesamt_af_mit_wv,
    SUM(ums_gesamt_ausser_artikel) AS ums_gesamt_ausser_artikel,
    SUM(anz_markt_sa) AS anz_markt_sa
FROM dbp_data.shopper
WHERE
    kjwo_werbe_ende = akt_woche
    AND mandant_id = 1
    AND baseline = 1
GROUP BY
    mandant_id,
    art_id_werbung;


CREATE OR REPLACE TEMPORARY TABLE _shopper_snap AS
SELECT
    mandant_id,
    art_id_werbung,
    SUM(ums_netto_baseline_af) / IF(SUM(anz_tage_baseline_af) = 0, NULL, SUM(anz_tage_baseline_af)) AS umsatz_baseline,
    SUM(ums_netto_sa) / IF(SUM(anz_tage_sa) = 0, NULL, SUM(anz_tage_sa)) AS umsatz_werbewoche,
    SUM(
        ums_netto_sa) / IF(SUM(anz_tage_sa) = 0, NULL, SUM(anz_tage_sa)) - SUM(ums_netto_baseline_af) / IF(
        SUM(anz_tage_baseline_af
        ) = 0, NULL, SUM(anz_tage_baseline_af)
    ) AS umsatz_uplift,
    SUM(menge_baseline_af) / IF(SUM(anz_tage_baseline_af) = 0, NULL, SUM(anz_tage_baseline_af)) AS absatz_baseline,
    SUM(menge_sa) / IF(SUM(anz_tage_sa) = 0, NULL, SUM(anz_tage_sa)) AS absatz_werbewoche,
    SUM(
        menge_sa) / IF(SUM(anz_tage_sa) = 0, NULL, SUM(anz_tage_sa)) - SUM(menge_baseline_af) / IF(
        SUM(anz_tage_baseline_af
        ) = 0, NULL, SUM(anz_tage_baseline_af)
    ) AS absatz_uplift,
    SUM(ertrag_baseline_af) / IF(SUM(anz_tage_baseline_af) = 0, NULL, SUM(anz_tage_baseline_af)) AS ertrag_baseline,
    SUM(ertrag_sa) / IF(SUM(anz_tage_sa) = 0, NULL, SUM(anz_tage_sa)) AS ertrag_werbewoche,
    SUM(
        ertrag_sa) / IF(SUM(anz_tage_sa) = 0, NULL, SUM(anz_tage_sa)) - SUM(ertrag_baseline_af) / IF(
        SUM(anz_tage_baseline_af
        ) = 0, NULL, SUM(anz_tage_baseline_af)
    ) AS ertrag_uplift,
    CAST(ROUND(SUM(anz_kaeufer_af) / IF(SUM(anz_tage_baseline_af) = 0, NULL, SUM(anz_tage_baseline_af)) + 0.5, 0) AS INTEGER)
        AS kaeufer_baseline,
    CAST(
        ROUND(SUM(anz_bon_sa) / IF(SUM(anz_tage_sa) = 0, NULL, SUM(anz_tage_sa)) + 0.5, 0) AS INTEGER) AS
    kaeufer_werbewoche,
    CAST(ROUND(SUM(anz_bon_sa) / IF(SUM(anz_tage_sa) = 0, NULL, SUM(anz_tage_sa)) + 0.5, 0) AS INTEGER) - CAST(ROUND(SUM(anz_kaeufer_af) / IF(SUM(anz_tage_baseline_af) = 0, NULL, SUM(anz_tage_baseline_af)) + 0.5, 0) AS INTEGER)
        AS kaeufer_uplift,
    ROUND(CAST(SUM(
        CAST(anz_kaeufer_af AS NUMERIC)) / IF(
        SUM(CAST(anz_bon_af AS NUMERIC)) = 0, NULL, SUM(CAST(anz_bon_af AS NUMERIC)
        )
    ) * 100.00 AS NUMERIC), 2) AS kaeufer_reichweite_baseline,
    ROUND(CAST(SUM(
        CAST(anz_bon_sa AS NUMERIC)) / IF(
        SUM(CAST(anz_bon_aktion AS NUMERIC)) = 0, NULL, SUM(CAST(anz_bon_aktion AS NUMERIC)
        )
    ) * 100.00 AS NUMERIC), 2) AS kaeufer_reichweite_werbewoche,
    ROUND(CAST(SUM(
        CAST(anz_bon_sa AS NUMERIC)) / IF(SUM(CAST(anz_bon_aktion AS NUMERIC)) = 0, NULL, SUM(CAST(anz_bon_aktion AS NUMERIC)
    )) * 100.00 AS NUMERIC), 2) - ROUND(CAST(SUM(CAST(anz_kaeufer_af AS NUMERIC)) / IF(
        SUM(CAST(anz_bon_af AS NUMERIC)
        ) = 0, NULL, SUM(CAST(anz_bon_af AS NUMERIC))
    ) * 100.00 AS NUMERIC), 2) AS kaeufer_reichweite_uplift,
    ROUND(CAST(SUM(
        CAST(anz_cp_kaeufer_70_prozent AS NUMERIC)) / IF(
        SUM(CAST(anz_cp_kaeufer AS NUMERIC)) = 0, NULL, SUM(CAST(anz_cp_kaeufer AS NUMERIC)
        )
    ) * 100.00 AS NUMERIC), 2) AS cherrypicker_pp,
    SUM(ums_gesamt_af_mit_wv) / IF(SUM(anz_cp_kaeufer) = 0, NULL, SUM(anz_cp_kaeufer)) AS restbon_normalware,
    SUM(ums_gesamt_ausser_artikel) / IF(SUM(anz_cp_kaeufer) = 0, NULL, SUM(anz_cp_kaeufer)) AS restbon_gesamt,
    SUM(ums_gesamt_ausser_artikel) / IF(SUM(anz_cp_kaeufer) = 0, NULL, SUM(anz_cp_kaeufer)) - SUM(ums_gesamt_af_mit_wv) /
    IF(SUM(anz_cp_kaeufer) = 0, NULL, SUM(anz_cp_kaeufer)) AS restbon_tip,
    SUM(ums_gesamt_af_mit_wv) / IF(SUM(anz_tage_sa) = 0, NULL, SUM(anz_tage_sa)) AS ums_aktivierter_normalpreis,
    SUM(anz_tage_sa) AS anz_tage_sa,
    SUM(anz_markt_sa) AS anz_markt_sa,
    52 AS baseline_wochen
FROM `_shopper1`
GROUP BY
    mandant_id,
    art_id_werbung;


CREATE OR REPLACE TEMPORARY TABLE _artbew_avq_shopper AS
SELECT
    A.mandant_id,
    A.kjwo_ww,
    A.kjwo,
    A.mutter_art_id,
    A.kl_art_id,
    A.aktion_thema_gruppe_id,
    A.werbe_kat_id,
    A.gp_id,
    A.aktionsart_id_liste_txt,
    A.aktionsart_bez_liste_txt,
    A.aktion_typ_id_liste_txt,
    A.aktion_typ_bez_liste_txt,
    A.wg_id,
    A.umsatz_netto_sa_west_,
    A.absatz_sa_west_,
    A.ek_mep_sa_west_,
    A.logkostenzuschlag_sa_west_wg30_,
    A.logkostenzuschlag_sa_west_,
    A.rohertrag_sa_west_,
    A.spanne_sa_west_,
    A.preisvorteil_west,
    A.wa_kalk_abschriften_sa_west_,
    A.wa_kalk_nach_pv_sa_west_,
    A.spanne_wa_kalk_nach_pv_sa_west_,
    A.umsatz_netto_sa_ost_,
    A.absatz_sa_ost_,
    A.ek_mep_sa_ost_,
    A.logkostenzuschlag_sa_ost_wg30_,
    A.logkostenzuschlag_sa_ost_,
    A.rohertrag_sa_ost_,
    A.spanne_sa_ost_,
    A.preisvorteil_ost,
    A.wa_kalk_abschriften_sa_ost_,
    A.wa_kalk_nach_pv_sa_ost_,
    A.spanne_wa_kalk_nach_pv_sa_ost_,
    A.umsatz_netto_sa_sued_,
    A.absatz_sa_sued_,
    A.ek_mep_sa_sued_,
    A.logkostenzuschlag_sa_sued_wg30_,
    A.logkostenzuschlag_sa_sued_,
    A.rohertrag_sa_sued_,
    A.spanne_sa_sued_,
    A.preisvorteil_sued,
    A.wa_kalk_abschriften_sa_sued_,
    A.wa_kalk_nach_pv_sa_sued_,
    A.spanne_wa_kalk_nach_pv_sa_sued_,
    A.umsatz_netto_sa_,
    A.absatz_sa_,
    A.ek_mep_sa_,
    A.logkostenzuschlag_sa_wg30_,
    A.logkostenzuschlag_sa_,
    A.rohertrag_sa_,
    A.spanne_sa_,
    A.preisvorteil,
    A.wa_kalk_abschriften_sa_,
    A.wa_kalk_nach_pv_sa_,
    A.spanne_wa_kalk_nach_pv_sa_,
    A.umsatz_netto_sa_loyalty_,
    A.absatz_sa_loyalty_,
    A.ek_mep_sa_loyalty_,
    A.logkostenzuschlag_sa_loyalty_wg30_,
    A.logkostenzuschlag_sa_loyalty_,
    A.rohertrag_sa_loyalty_,
    A.wa_kalk_abschriften_sa_loyalty_,
    A.wa_kalk_nach_pv_sa_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_loyalty_,
    A.umsatz_netto_sa_aktion_loyalty_,
    A.absatz_sa_aktion_loyalty_,
    A.ek_mep_sa_aktion_loyalty_,
    A.logkostenzuschlag_sa_aktion_loyalty_wg30_,
    A.logkostenzuschlag_sa_aktion_loyalty_,
    A.rohertrag_sa_aktion_loyalty_,
    A.wa_kalk_abschriften_sa_aktion_loyalty_,
    A.wa_kalk_nach_pv_sa_aktion_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_aktion_loyalty_,
    A.umsatz_netto_sa_bby_loyalty_,
    A.absatz_sa_bby_loyalty_,
    A.ek_mep_sa_bby_loyalty_,
    A.logkostenzuschlag_sa_bby_loyalty_wg30_,
    A.logkostenzuschlag_sa_bby_loyalty_,
    A.rohertrag_sa_bby_loyalty_,
    A.wa_kalk_abschriften_sa_bby_loyalty_,
    A.wa_kalk_nach_pv_sa_bby_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_bby_loyalty_,
    A.umsatz_netto_sa_kdn_bby_loyalty_,
    A.absatz_sa_kdn_bby_loyalty_,
    A.ek_mep_sa_kdn_bby_loyalty_,
    A.logkostenzuschlag_sa_kdn_bby_loyalty_wg30_,
    A.logkostenzuschlag_sa_kdn_bby_loyalty_,
    A.rohertrag_sa_kdn_bby_loyalty_,
    A.wa_kalk_abschriften_sa_kdn_bby_loyalty_,
    A.wa_kalk_nach_pv_sa_kdn_bby_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty_,
    A.umsatz_netto_sa_kdp_bby_loyalty_,
    A.absatz_sa_kdp_bby_loyalty_,
    A.ek_mep_sa_kdp_bby_loyalty_,
    A.logkostenzuschlag_sa_kdp_bby_loyalty_wg30_,
    A.logkostenzuschlag_sa_kdp_bby_loyalty_,
    A.rohertrag_sa_kdp_bby_loyalty_,
    A.wa_kalk_abschriften_sa_kdp_bby_loyalty_,
    A.wa_kalk_nach_pv_sa_kdp_bby_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty_,
    A.umsatz_netto_sa_non_loyalty_,
    A.absatz_sa_non_loyalty_,
    A.ek_mep_sa_non_loyalty_,
    A.logkostenzuschlag_sa_non_loyalty_wg30_,
    A.logkostenzuschlag_sa_non_loyalty_,
    A.rohertrag_sa_non_loyalty_,
    A.wa_kalk_abschriften_sa_non_loyalty_,
    A.wa_kalk_nach_pv_sa_non_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_non_loyalty_,
    A.umsatz_netto_sa_aktion_non_loyalty_,
    A.absatz_sa_aktion_non_loyalty_,
    A.ek_mep_sa_aktion_non_loyalty_,
    A.logkostenzuschlag_sa_aktion_non_loyalty_wg30_,
    A.logkostenzuschlag_sa_aktion_non_loyalty_,
    A.rohertrag_sa_aktion_non_loyalty_,
    A.wa_kalk_abschriften_sa_aktion_non_loyalty_,
    A.wa_kalk_nach_pv_sa_aktion_non_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty_,
    A.umsatz_netto_sa_bby_non_loyalty_,
    A.absatz_sa_bby_non_loyalty_,
    A.ek_mep_sa_bby_non_loyalty_,
    A.logkostenzuschlag_sa_bby_non_loyalty_wg30_,
    A.logkostenzuschlag_sa_bby_non_loyalty_,
    A.rohertrag_sa_bby_non_loyalty_,
    A.wa_kalk_abschriften_sa_bby_non_loyalty_,
    A.wa_kalk_nach_pv_sa_bby_non_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_bby_non_loyalty_,
    A.umsatz_netto_sa_bonrabatt_bby_loyalty_,
    A.absatz_sa_bonrabatt_bby_loyalty_,
    A.ek_mep_sa_bonrabatt_bby_loyalty_,
    A.logkostenzuschlag_sa_bonrabatt_bby_loyalty_wg30_,
    A.logkostenzuschlag_sa_bonrabatt_bby_loyalty_,
    A.rohertrag_sa_bonrabatt_bby_loyalty_,
    A.wa_kalk_abschriften_sa_bonrabatt_bby_loyalty_,
    A.wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_loyalty_,
    A.umsatz_netto_sa_bonrabatt_bby_non_loyalty_,
    A.absatz_sa_bonrabatt_bby_non_loyalty_,
    A.ek_mep_sa_bonrabatt_bby_non_loyalty_,
    A.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_wg30_,
    A.logkostenzuschlag_sa_bonrabatt_bby_non_loyalty_,
    A.rohertrag_sa_bonrabatt_bby_non_loyalty_,
    A.wa_kalk_abschriften_sa_bonrabatt_bby_non_loyalty_,
    A.wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty_,
    A.spanne_wa_kalk_nach_pv_sa_bonrabatt_bby_non_loyalty_,
    A.pv_aktion_loy,
    A.pv_aktion_non_loy,
    A.pv_bby_loy,
    A.pv_bby_non_loy,
    A.pv_kdn_bby,
    A.pv_kdp_bby,
    A.pv_bonrabatt_bby_loy,
    A.pv_bonrabatt_bby_non_loy,
    A.avq_1,
    A.avq_3,
    A.avq,
    A.wareneingang_zl,
    A.abverkaufte_menge_bestand,
    A.abverkaufte_menge,
    A.durchschnitt_menge_pro_filiale,
    A.einheit_wb,
    A.umsatz_netto,
    A.durchschnitt_umsatz_pro_artikel_pro_filiale,
    A.anz_nullbestand,
    A.nullbestandsquote,
    A.endbestand,
    A.umschlagsquote,
    A.anz_artikel,
    A.anz_filialen,
    B.umsatz_baseline,
    B.umsatz_werbewoche,
    B.umsatz_uplift,
    B.absatz_baseline,
    B.absatz_werbewoche,
    B.absatz_uplift,
    B.ertrag_baseline,
    B.ertrag_werbewoche,
    B.ertrag_uplift,
    B.kaeufer_baseline,
    B.kaeufer_werbewoche,
    B.kaeufer_uplift,
    B.kaeufer_reichweite_baseline,
    B.kaeufer_reichweite_werbewoche,
    B.kaeufer_reichweite_uplift,
    B.cherrypicker_pp,
    B.restbon_normalware,
    B.restbon_gesamt,
    B.restbon_tip,
    B.ums_aktivierter_normalpreis,
    B.anz_tage_sa,
    B.anz_markt_sa,
    B.baseline_wochen
FROM `_artbew_avq` AS A
LEFT JOIN `_shopper_snap` AS B ON A.mandant_id = B.mandant_id AND A.mutter_art_id = B.art_id_werbung;


DELETE FROM dbp_data.aktionsmanagement
WHERE kjwo_ww = akt_woche;


-- neu ---
INSERT INTO dbp_data.aktionsmanagement (
    mandant_id, kjwo_ww, kjwo, mutter_wb_id,
    konkat_kind_art_id, konkat_aktion_thema_gruppe_id, konkat_werbe_kat_id, gp_id, konkat_wg_id, umsatz_netto_sa_west,
    absatz_sa_west, ek_mep_sa_west, rohertrag_ek_mep_olk_sa_west, spanne_ek_mep_olk_sa_west, preisvorteil_west,
    umsatz_netto_sa_ost, absatz_sa_ost, ek_mep_sa_ost, rohertrag_ek_mep_olk_sa_ost, spanne_ek_mep_olk_sa_ost,
    preisvorteil_ost, umsatz_netto_sa_sued, absatz_sa_sued, ek_mep_sa_sued, rohertrag_ek_mep_olk_sa_sued,
    spanne_ek_mep_olk_sa_sued, preisvorteil_sued, umsatz_netto_sa, absatz_sa, ek_mep_sa, rohertrag_sa, spanne_sa,
    preisvorteil, avq_1, avq_3, avq, wareneingang_zl, abverkaufte_menge_bestand, abverkaufte_menge,
    durchschnitt_menge_pro_filiale, einheit_wb, umsatz_netto, durchschnitt_umsatz_pro_artike, anz_nullbestand,
    nullbestandsquote, endbestand, umschlagsquote, anz_artikel, anz_filialen, umsatz_baseline, umsatz_werbewoche,
    umsatz_uplift, umsatz_aktivierter_normalpreis, absatz_baseline, absatz_werbewoche, absatz_uplift, ertrag_baseline,
    ertrag_werbewoche, ertrag_uplift, kaeufer_baseline, kaeufer_werbewoche, kaeufer_uplift, kaeufer_reichweite_baseline,
    kaeufer_reichweite_werbewoche, kaeufer_reichweite_uplift, cherrypicker_pp, restbon_normalware, restbon_gesamt,
    restbon_tip, anz_tage_sa, anz_markt_sa, baseline_wochen, wa_kalk_nach_pv_sa, wa_kalk_nach_pv_sa_sued,
    wa_kalk_nach_pv_sa_ost, wa_kalk_nach_pv_sa_west, spanne_wa_kalk_nach_pv_sa, spanne_wa_kalk_nach_pv_sa_sued,
    spanne_wa_kalk_nach_pv_sa_ost, spanne_wa_kalk_nach_pv_sa_west, wa_kalk_nach_pv_sa_loy, wa_kalk_nach_pv_sa_aktion_loy,
    wa_kalk_nach_pv_sa_bby_loy, wa_kalk_nach_pv_sa_kdn_bby_loy, wa_kalk_nach_pv_sa_kdp_bby_loy, wa_kalk_nach_pv_sa_non_loy,
    wa_kalk_nach_pv_sa_aktion_non_loy, wa_kalk_nach_pv_sa_bby_non_loy, spanne_wa_kalk_nach_pv_sa_loy,
    spanne_wa_kalk_nach_pv_sa_aktion_loy, spanne_wa_kalk_nach_pv_sa_bby_loy, spanne_wa_kalk_nach_pv_sa_kdn_bby_loy,
    spanne_wa_kalk_nach_pv_sa_kdp_bby_loy, spanne_wa_kalk_nach_pv_sa_non_loy, spanne_wa_kalk_nach_pv_sa_aktion_non_loy,
    spanne_wa_kalk_nach_pv_sa_bby_non_loy, umsatz_netto_sa_aktion_loy, umsatz_netto_sa_bby_loy, umsatz_netto_sa_kdn_bby_loy,
    umsatz_netto_sa_kdp_bby_loy, umsatz_netto_sa_aktion_non_loy, umsatz_netto_sa_bby_non_loy, menge_sa_aktion_loy,
    menge_sa_bby_loy, menge_sa_kdn_bby_loy, menge_sa_kdp_bby_loy, menge_sa_aktion_non_loy, menge_sa_bby_non_loy,
    pv_aktion_loy, pv_bby_loy, pv_kdn_bby, pv_kdp_bby, pv_aktion_non_loy, pv_bby_non_loy, aktionsart_id_liste_txt,
    aktionsart_bez_liste_txt, aktion_typ_id_liste_txt, aktion_typ_bez_liste_txt
)
(SELECT
    mandant_id,
    kjwo_ww,
    kjwo,
    mutter_art_id,
    SUBSTR(kl_art_id, 1, 500) AS kl_art_id,
    aktion_thema_gruppe_id,
    werbe_kat_id,
    gp_id,
    wg_id,
    CAST(umsatz_netto_sa_west_ AS NUMERIC) AS umsatz_netto_sa_west_,
    CAST(absatz_sa_west_ AS NUMERIC) AS absatz_sa_west_,
    CAST(ek_mep_sa_west_ AS NUMERIC) AS ek_mep_sa_west_,
    CAST(rohertrag_sa_west_ AS NUMERIC) AS rohertrag_sa_west_,
    spanne_sa_west_,
    CAST(preisvorteil_west AS NUMERIC) AS preisvorteil_west,
    CAST(umsatz_netto_sa_ost_ AS NUMERIC) AS umsatz_netto_sa_ost_,
    CAST(absatz_sa_ost_ AS NUMERIC) AS absatz_sa_ost_,
    CAST(ek_mep_sa_ost_ AS NUMERIC) AS ek_mep_sa_ost_,
    CAST(rohertrag_sa_ost_ AS NUMERIC) AS rohertrag_sa_ost_,
    spanne_sa_ost_,
    CAST(preisvorteil_ost AS NUMERIC) AS preisvorteil_ost,
    CAST(umsatz_netto_sa_sued_ AS NUMERIC) AS umsatz_netto_sa_sued_,
    CAST(absatz_sa_sued_ AS NUMERIC) AS absatz_sa_sued_,
    CAST(ek_mep_sa_sued_ AS NUMERIC) AS ek_mep_sa_sued_,
    CAST(rohertrag_sa_sued_ AS NUMERIC) AS rohertrag_sa_sued_,
    spanne_sa_sued_,
    CAST(preisvorteil_sued AS NUMERIC) AS preisvorteil_sued,
    umsatz_netto_sa_,
    absatz_sa_,
    ek_mep_sa_,
    rohertrag_sa_,
    spanne_sa_,
    CAST(preisvorteil AS NUMERIC) AS preisvorteil,
    ROUND(CAST(avq_1 AS NUMERIC), 4) AS avq_1,
    ROUND(CAST(avq_3 AS NUMERIC), 4) AS avq_3,
    ROUND(CAST(avq AS NUMERIC), 4) AS avq,
    ROUND(CAST(wareneingang_zl AS NUMERIC), 4) AS wareneingang_zl,
    ROUND(CAST(abverkaufte_menge_bestand AS NUMERIC), 4) AS abverkaufte_menge_bestand,
    ROUND(CAST(abverkaufte_menge AS NUMERIC), 4) AS abverkaufte_menge,
    ROUND(CAST(durchschnitt_menge_pro_filiale AS NUMERIC), 4) AS durchschnitt_menge_pro_filiale,
    einheit_wb,
    ROUND(CAST(umsatz_netto AS NUMERIC), 4) AS umsatz_netto,
    ROUND(CAST(durchschnitt_umsatz_pro_artikel_pro_filiale AS NUMERIC), 4) AS durchschnitt_umsatz_pro_artikel_pro_filiale
    ,
    anz_nullbestand,
    nullbestandsquote,
    ROUND(CAST(endbestand AS NUMERIC), 4) AS endbestand,
    ROUND(CAST(umschlagsquote AS NUMERIC), 4) AS umschlagsquote,
    anz_artikel,
    anz_filialen,
    umsatz_baseline,
    umsatz_werbewoche,
    umsatz_uplift,
    ums_aktivierter_normalpreis,
    absatz_baseline,
    absatz_werbewoche,
    absatz_uplift,
    ertrag_baseline,
    ertrag_werbewoche,
    ertrag_uplift,
    kaeufer_baseline,
    kaeufer_werbewoche,
    kaeufer_uplift,
    kaeufer_reichweite_baseline,
    kaeufer_reichweite_werbewoche,
    kaeufer_reichweite_uplift,
    cherrypicker_pp,
    restbon_normalware,
    restbon_gesamt,
    restbon_tip,
    anz_tage_sa,
    anz_markt_sa,
    baseline_wochen -- neu ---
    ,
    CAST(wa_kalk_nach_pv_sa_ AS NUMERIC) AS wa_kalk_nach_pv_sa_,
    CAST(wa_kalk_nach_pv_sa_sued_ AS NUMERIC) AS wa_kalk_nach_pv_sa_sued_,
    CAST(wa_kalk_nach_pv_sa_ost_ AS NUMERIC) AS wa_kalk_nach_pv_sa_ost_,
    CAST(wa_kalk_nach_pv_sa_west_ AS NUMERIC) AS wa_kalk_nach_pv_sa_west_,
    spanne_wa_kalk_nach_pv_sa_,
    spanne_wa_kalk_nach_pv_sa_sued_,
    spanne_wa_kalk_nach_pv_sa_ost_,
    spanne_wa_kalk_nach_pv_sa_west_,
    CAST(wa_kalk_nach_pv_sa_loyalty_ AS NUMERIC) AS wa_kalk_nach_pv_sa_loyalty_,
    CAST(wa_kalk_nach_pv_sa_aktion_loyalty_ AS NUMERIC) AS wa_kalk_nach_pv_sa_aktion_loyalty_,
    CAST(wa_kalk_nach_pv_sa_bby_loyalty_ AS NUMERIC) AS wa_kalk_nach_pv_sa_bby_loyalty_,
    CAST(wa_kalk_nach_pv_sa_kdn_bby_loyalty_ AS NUMERIC) AS wa_kalk_nach_pv_sa_kdn_bby_loyalty_,
    CAST(wa_kalk_nach_pv_sa_kdp_bby_loyalty_ AS NUMERIC) AS wa_kalk_nach_pv_sa_kdp_bby_loyalty_,
    CAST(wa_kalk_nach_pv_sa_non_loyalty_ AS NUMERIC) AS wa_kalk_nach_pv_sa_non_loyalty_,
    CAST(wa_kalk_nach_pv_sa_aktion_non_loyalty_ AS NUMERIC) AS wa_kalk_nach_pv_sa_aktion_non_loyalty_,
    CAST(wa_kalk_nach_pv_sa_bby_non_loyalty_ AS NUMERIC) AS wa_kalk_nach_pv_sa_bby_non_loyalty_,
    spanne_wa_kalk_nach_pv_sa_loyalty_,
    spanne_wa_kalk_nach_pv_sa_aktion_loyalty_,
    spanne_wa_kalk_nach_pv_sa_bby_loyalty_,
    spanne_wa_kalk_nach_pv_sa_kdn_bby_loyalty_,
    spanne_wa_kalk_nach_pv_sa_kdp_bby_loyalty_,
    spanne_wa_kalk_nach_pv_sa_non_loyalty_,
    spanne_wa_kalk_nach_pv_sa_aktion_non_loyalty_,
    spanne_wa_kalk_nach_pv_sa_bby_non_loyalty_,
    CAST(umsatz_netto_sa_aktion_loyalty_ AS NUMERIC) AS umsatz_netto_sa_aktion_loyalty_,
    CAST(umsatz_netto_sa_bby_loyalty_ AS NUMERIC) AS umsatz_netto_sa_bby_loyalty_,
    CAST(umsatz_netto_sa_kdn_bby_loyalty_ AS NUMERIC) AS umsatz_netto_sa_kdn_bby_loyalty_,
    CAST(umsatz_netto_sa_kdp_bby_loyalty_ AS NUMERIC) AS umsatz_netto_sa_kdp_bby_loyalty_,
    CAST(umsatz_netto_sa_aktion_non_loyalty_ AS NUMERIC) AS umsatz_netto_sa_aktion_non_loyalty_,
    CAST(umsatz_netto_sa_bby_non_loyalty_ AS NUMERIC) AS umsatz_netto_sa_bby_non_loyalty_,
    CAST(absatz_sa_aktion_loyalty_ AS NUMERIC) AS absatz_sa_aktion_loyalty_,
    CAST(absatz_sa_bby_loyalty_ AS NUMERIC) AS absatz_sa_bby_loyalty_,
    CAST(absatz_sa_kdn_bby_loyalty_ AS NUMERIC) AS absatz_sa_kdn_bby_loyalty_,
    CAST(absatz_sa_kdp_bby_loyalty_ AS NUMERIC) AS absatz_sa_kdp_bby_loyalty_,
    CAST(absatz_sa_aktion_non_loyalty_ AS NUMERIC) AS absatz_sa_aktion_non_loyalty_,
    CAST(absatz_sa_bby_non_loyalty_ AS NUMERIC) AS absatz_sa_bby_non_loyalty_,
    CAST(pv_aktion_loy AS NUMERIC) AS pv_aktion_loy,
    CAST(pv_bby_loy AS NUMERIC) AS pv_bby_loy,
    CAST(pv_kdn_bby AS NUMERIC) AS pv_kdn_bby,
    CAST(pv_kdp_bby AS NUMERIC) AS pv_kdp_bby,
    CAST(pv_aktion_non_loy AS NUMERIC) AS pv_aktion_non_loy,
    CAST(pv_bby_non_loy AS NUMERIC) AS pv_bby_non_loy,
    aktionsart_id_liste_txt,
    aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt
FROM `_artbew_avq_shopper`);


--update dbp_data.aktionsmanagement set konkat_aktion_thema_gruppe_id = '';
--update dbp_data.aktionsmanagement from (select a.mandant_id
--                                              ,c.art_id
--                                              ,b.kjwo_ww
--                                              ,max(a.aktion_thema_id) as aktion_thema_id
--                                        from dbp_etl_process.bon_aktion_thema_group a
--                                        join dbp_data.werbewoche_kl b
--                                          on a.bon_dat = b.dat
--                                        join dbp_data.art c
--                                          on a.mandant_id = c.mandant_id and
--                                             a.kl_art_id = c.kl_art_id and
--                                             c.dat_bis = '9999-12-31'
--                                        group by 1,2,3) b
--                              
--set konkat_aktion_thema_gruppe_id = b.aktion_thema_id
--
--where dbp_data.aktionsmanagement.mandant_id = b.mandant_id and
--      dbp_data.aktionsmanagement.mutter_wb_id = b.art_id and
--      dbp_data.aktionsmanagement.kjwo_ww = b.kjwo_ww
--;


UPDATE dbp_data.aktionsmanagement SET
    konkat_werbeteam_cd = COALESCE(aktionsmanagement.konkat_werbeteam_cd, '-1'),
    konkat_werbeteam_bez = COALESCE(aktionsmanagement.konkat_werbeteam_bez, '-1'),
    werbebereich_cd = COALESCE(aktionsmanagement.werbebereich_cd, '-1')
WHERE TRUE;
