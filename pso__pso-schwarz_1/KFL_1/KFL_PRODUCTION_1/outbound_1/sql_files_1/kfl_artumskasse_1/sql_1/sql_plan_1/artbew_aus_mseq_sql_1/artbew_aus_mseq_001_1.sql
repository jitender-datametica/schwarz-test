INSERT INTO dbp_data.artbew_agg_wt_1 (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_etl.artbew_kmo_tmp_1
    WHERE (
        mandant_id, wup_id, nb_id, dat) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat)
        FROM dbp_data.artbew_agg_wt_1
    )
    GROUP BY
        wup_id,
        mandant_id,
        nb_id,
        dat
);


DROP TABLE IF EXISTS dbp_etl.artbew_reload_mseq_1;


CREATE TABLE IF NOT EXISTS dbp_etl.artbew_reload_mseq_1 LIKE dbp_data.artbew_1;


DROP TABLE IF EXISTS dbp_etl.artbew_251_1;


CREATE TABLE IF NOT EXISTS dbp_etl.artbew_251_1 LIKE dbp_data.artbew_1;


-- Kennzeichen Zuordnung Aktion_1, Artikel_1, Wup_1 aktiv
-- ,0 AS zero_enc
INSERT INTO dbp_etl.artbew_reload_mseq_1
(
    mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id, promo_fg, einkaufsorganisation_id, herst_id,
    mwst_id, menge, wrg_1, umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto,
    diff_ek_brutto_konz, ek_netto, diff_ek_netto_konz, ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis,
    diff_ek_kal_basis_konz, ek_mep, diff_ek_mep_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag,
    diff_logkostenzuschlag_konz, bezugsweg_id, ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz, posten_id, bq_findung_id, ek_gld, diff_ek_gld_konz, bewart_det_id, pv_bby, pv_kdn_bby,
    pv_kdp_bby, pv_aktion_bby, pv_aktion_kdn_bby, pv_aktion_kdp_bby
)
(SELECT
    t8.mandant_id,
    t8.wup_id,
    t8.nb_id,
    t8.dat,
    t8.bewart_id,
    t8.gp_id,
    t8.art_id,
    t8.aktion_id,
    0 AS promo_fg,
    t8.gp_id AS einkaufsorganisation_id,
    t8.gp_id AS herst_id,
    t8.mwst_id,
    CAST(t8.a0 * t8.gp_id AS NUMERIC) AS menge_sum,
    t8.wrg_1,
    CAST(t8.a0_0 * t8.gp_id AS NUMERIC) AS umsatz_netto_sum,
    t8.a0_2 * t8.gp_id AS diff_umsatz_netto_konz_sum,
    CAST(t8.a0_1 * t8.gp_id AS NUMERIC) AS umsatz_mwst_betrag_sum,
    t8.a0_3 * t8.gp_id AS diff_umsatz_mwst_betrag_konz_s,
    t8.bezugsweg_id AS ek_brutto,
    t8.bezugsweg_id AS diff_ek_brutto_konz,
    t8.bezugsweg_id AS ek_netto,
    t8.bezugsweg_id AS diff_ek_netto_konz,
    t8.bezugsweg_id AS ek_nettonetto,
    t8.bezugsweg_id AS diff_ek_nettonetto_konz,
    t8.bezugsweg_id AS ek_kal_basis,
    t8.bezugsweg_id AS diff_ek_kal_basis_konz,
    t8.bezugsweg_id AS ek_mep,
    t8.bezugsweg_id AS diff_ek_mep_konz,
    t8.bezugsweg_id AS einstandspreis,
    t8.bezugsweg_id AS diff_einstandspreis_konz,
    0 AS logkostenzuschlag,
    0 AS diff_logkostenzuschlag_konz,
    t8.bezugsweg_id,
    t8.bezugsweg_id AS ek_netto_bnk,
    t8.bezugsweg_id AS diff_ek_netto_bnk_konz,
    t8.bezugsweg_id AS ek_netto_bnk_sachk,
    t8.bezugsweg_id AS diff_ek_netto_bnk_sachk_konz,
    t8.posten_id,
    0 AS bq_findung_id,
    0 AS ek_gld,
    0 AS diff_ek_gld_konz,
    9999 AS bewart_det_id,
    0 AS pv_bby,
    0 AS pv_kdn_bby,
    0 AS pv_kdp_bby,
    0 AS pv_aktion_bby,
    0 AS pv_aktion_kdn_bby,
    0 AS pv_aktion_kdp_bby
FROM (
    SELECT
        L.mandant_id,
        L.wup_id,
        L.nb_id,
        L.art_id,
        -1 AS gp_id,
        -1 AS einkaufsorganisation_id,
        COALESCE(r.bewart_id, 1001) AS bewart_id,
        L.dat_buch AS dat,
        CASE
            WHEN r.anz_aktion = 1
                THEN r.max_aktion_id
            ELSE ''
        END AS aktion_id,
        -1 AS herst_id,
        A.mwst_id,
        M.default_wrg AS wrg_1,
        COALESCE(A.posten_id, ' ') AS posten_id,
        0 AS bezugsweg_id,
        0 AS zero_enc,
        SUM(L.menge_erf) AS a0,
        SUM(CAST(L.betrag_verkauf_ist / (1 + MWST.mwst / 100) AS NUMERIC)) AS a0_0,
        SUM(L.betrag_verkauf_ist - CAST(L.betrag_verkauf_ist / (1 + MWST.mwst / 100) AS NUMERIC)) AS a0_1,
        SUM(CAST(L.betrag_verkauf_ist / (1 + MWST.mwst / 100) AS NUMERIC) * K.umrechnungskurs) AS a0_2,
        SUM((L.betrag_verkauf_ist - CAST(L.betrag_verkauf_ist / (1 + MWST.mwst / 100) AS NUMERIC)) * K.umrechnungskurs)
            AS
            a0_3
    FROM dbp_data.lagerbew_det_1 AS L
    INNER JOIN dbp_data.art_1 AS A ON L.mandant_id = A.mandant_id AND L.art_id = A.art_id
    INNER JOIN dbp_data.mwst_per_1 AS MWST
        ON
            L.mandant_id = MWST.mandant_id AND A.mwst_id = MWST.mwst_id
            AND L.dat_buch BETWEEN MWST.dat_von AND MWST.dat_bis
    INNER JOIN dbp_data.mandant_1 AS M ON L.mandant_id = M.mandant_id
    INNER JOIN dbp_data.kurs_1 AS K
        ON
            M.default_wrg = K.von_wrg_id AND K.kurstyp_id = 9 AND K.nach_wrg_id
            = 'EUR' AND L.dat_buch BETWEEN K.dat_von AND K.dat_bis
    LEFT JOIN (
        SELECT
            mandant_id,
            MAX(aktion_id) AS max_aktion_id,
            bewart_id,
            dat,
            art_id,
            wup_id,
            nb_id,
            MAX(zaehler) AS anz_aktion
        FROM (
            SELECT
                A0.mandant_id,
                A0.bewart_id,
                d.dat,
                AAW.art_id,
                AAW.wup_id,
                AAW.nb_id,
                A0.aktion_id,
                ROW_NUMBER() OVER (
                    PARTITION BY A0.mandant_id, A0.bewart_id, AAW.art_id, AAW.wup_id, AAW.nb_id, d.dat ORDER BY
                        A0.dat_von IS NULL, A0.dat_von
                ) AS zaehler
            FROM dbp_data.aktion_1 AS A0
            INNER JOIN (
                SELECT dat
                FROM dbp_data.artbew_agg_wt_1
                GROUP BY dat
            ) AS d
                ON d.dat BETWEEN A0.dat_von AND A0.dat_bis
            INNER JOIN dbp_data.aktion_art_wup_zu_1 AS AAW
                ON
                    A0.mandant_id = AAW.mandant_id AND A0.aktion_id =
                    AAW.aktion_id AND A0.bewart_id = AAW.bewart_id
            WHERE
                A0.bewart_id = 1002 -- Kennzeichen Aktion_1

                AND (UPPER(AAW.grund_sperrung) <> 'X' OR AAW.grund_sperrung IS NULL)
                AND A0.mandant_id IN (3, 8)
        ) AS a
        GROUP BY
            mandant_id,
            bewart_id,
            dat,
            art_id,
            wup_id,
            nb_id
    ) AS r
        ON
            L.mandant_id = r.mandant_id AND L.art_id = r.art_id AND L.wup_id = r.wup_id AND L.nb_id = r.nb_id
            AND L.dat_buch = r.dat /* SALESDATE SETZEN  / WUP_ID SETZEN  /MANDANT_1 SETZEN */
    WHERE
        L.lager_bewart_id IN ('251', '252')
        AND (
            L.mandant_id, L.wup_id, L.dat_buch) IN (
            SELECT (mandant_id, wup_id, dat)
            FROM dbp_data.artbew_agg_wt_1
            WHERE mandant_id IN (3, 8)
        )
    GROUP BY
        L.mandant_id,
        L.wup_id,
        L.nb_id,
        L.art_id,
        gp_id,
        einkaufsorganisation_id,
        bewart_id,
        dat,
        aktion_id,
        herst_id,
        A.mwst_id,
        wrg_1,
        posten_id,
        bezugsweg_id,
        zero_enc
) AS t8);


/* FEHLT */ /* FEHLT */ /* FEHLT */ /* FEHLT */ INSERT INTO dbp_etl.artbew_251_1 (
    mandant_id, wup_id, nb_id,
    dat, bewart_id, gp_id, art_id, aktion_id, promo_fg, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg_1,
    umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz,
    ek_netto, diff_ek_netto_konz, ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep,
    diff_ek_mep_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag, diff_logkostenzuschlag_konz,
    bezugsweg_id, ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk, diff_ek_netto_bnk_sachk_konz, posten_id,
    bq_findung_id, ek_gld, diff_ek_gld_konz, bewart_det_id, pv_bby, pv_kdn_bby, pv_kdp_bby, pv_aktion_bby,
    pv_aktion_kdn_bby, pv_aktion_kdp_bby
)
(SELECT
    mandant_id,
    wup_id,
    nb_id,
    dat,
    bewart_id,
    gp_id,
    art_id,
    aktion_id,
    promo_fg,
    einkaufsorganisation_id,
    herst_id,
    mwst_id,
    menge,
    wrg_1,
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
    bewart_det_id,
    pv_bby,
    pv_kdn_bby,
    pv_kdp_bby,
    pv_aktion_bby,
    pv_aktion_kdn_bby,
    pv_aktion_kdp_bby
FROM dbp_etl.artbew_reload_mseq_1);


CREATE OR REPLACE TABLE dbp_etl.`__vol_art_gp_wup_zu_per` (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER,
    einkaufsorganisation_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    ek_brutto NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    logistikkostenzuschlag NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.`_kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX}` (
    dat DATE
);


CREATE OR REPLACE TABLE dbp_etl.`_kmo_wpuums_dat_min_${TRANSIENT_TABLE_SUFFIX}` (
    dat DATE
);


TRUNCATE TABLE dbp_etl.`_kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX}`;


TRUNCATE TABLE dbp_etl.`_kmo_wpuums_dat_min_${TRANSIENT_TABLE_SUFFIX}`;


INSERT INTO dbp_etl.`_kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX}` (dat)
(
    SELECT dat
    FROM dbp_data.tag_1
    WHERE dat IN (
        SELECT dat
        FROM dbp_data.artbew_agg_wt_1
        WHERE mandant_id IN (3, 8)
        GROUP BY dat
    )
);


INSERT INTO dbp_etl.`_kmo_wpuums_dat_min_${TRANSIENT_TABLE_SUFFIX}` (dat)
(
    SELECT MIN(dat)
    FROM dbp_data.tag_1
    WHERE dat IN (
        SELECT dat
        FROM dbp_data.artbew_agg_wt_1
        WHERE mandant_id IN (3, 8)
        GROUP BY dat
    )
);


TRUNCATE TABLE dbp_etl.`__vol_art_gp_wup_zu_per`;


INSERT INTO dbp_etl.`__vol_art_gp_wup_zu_per` (
    mandant_id, art_id, gp_id, wup_id, nb_id, einkaufsorganisation_id,
    dat, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis, logistikkostenzuschlag, ek_netto_bnk,
    ek_netto_bnk_sachk
)
(
    SELECT
        a.mandant_id,
        a.art_id,
        a.gp_id,
        a.wup_id,
        a.nb_id,
        a.einkaufsorganisation_id,
        D.dat,
        a.ek_brutto,
        a.ek_netto,
        a.ek_nettonetto,
        a.ek_kal_basis,
        a.ek_mep,
        a.einstandspreis,
        a.logistikkostenzuschlag,
        a.ek_netto_bnk,
        a.ek_netto_bnk_sachk
    FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            A.gp_id,
            A.einkaufsorganisation_id,
            A.dat_von,
            A.dat_bis,
            A.wrg_id,
            A.ek_brutto,
            A.ek_netto,
            A.ek_nettonetto,
            A.ek_kal_basis,
            A.ek_mep,
            A.einstandspreis,
            A.logistikkostenzuschlag,
            A.ek_netto_bnk,
            A.ek_netto_bnk_sachk
        FROM dbp_data.art_gp_wup_zu_per_1 AS A
        INNER JOIN dbp_etl.`_kmo_wpuums_dat_min_${TRANSIENT_TABLE_SUFFIX}` AS M
            ON
                A.dat_bis
                >= M.dat /* MANDANT_1 SETZEN */
        WHERE A.mandant_id IN (3, 8)
    ) AS a
    INNER JOIN
        dbp_etl.`_kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX}`
            AS D
        ON
            D.dat
            BETWEEN a.dat_von AND a.dat_bis
);


CREATE OR REPLACE TABLE dbp_etl.`__vol_artbew_rb` (
    art_id INTEGER NOT NULL,
    ean_kasse INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    einkaufsorganisation_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE,
    aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
    herst_id INTEGER,
    mwst_id INTEGER,
    menge NUMERIC(29, 4),
    wrg_1 STRING(3) COLLATE 'und:ci',
    umsatz_netto NUMERIC(29, 4),
    diff_umsatz_netto_konz NUMERIC(29, 4),
    umsatz_mwst_betrag NUMERIC(29, 4),
    diff_umsatz_mwst_betrag_konz NUMERIC(29, 4),
    ek_brutto NUMERIC(29, 4),
    diff_ek_brutto_konz NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    diff_ek_netto_konz NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    diff_ek_nettonetto_konz NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    diff_ek_kal_basis_konz NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    diff_ek_mep_konz NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    diff_einstandspreis_konz NUMERIC(29, 4),
    logkostenzuschlag NUMERIC(29, 4),
    diff_logkostenzuschlag_konz NUMERIC(29, 4),
    bezugsweg_id INTEGER,
    ek_netto_bnk NUMERIC(29, 4),
    diff_ek_netto_bnk_konz NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4),
    ek_gld NUMERIC(29, 4),
    diff_ek_gld_konz NUMERIC(29, 4),
    posten_id STRING(2),
    bq_findung_id INTEGER,
    promo_fg INTEGER
);


CREATE OR REPLACE TABLE dbp_etl.`_art_wup_man_spanne_tmp_$_1{TRANSIENT_TABLE_SUFFIX}`
(
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    zwgs NUMERIC(29, 4),
    zwgm NUMERIC(29, 4),
    zwge NUMERIC(29, 4)
);


/* optional */ /* Einstandspreis zwingend erforderlich */ /* optional */ INSERT INTO dbp_etl.`_art_wup_man_spanne_tmp_$_1{TRANSIENT_TABLE_SUFFIX}`
(mandant_id, art_id, wup_id, nb_id, dat, zwgs, zwgm, zwge)
(
    SELECT
        EIN.mandant_id,
        EIN.art_id,
        -1 AS wup_id,
        -1 AS nb_id,
        A.dat,
        EIN.ek_faktor AS zwgs,
        COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
        COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
    FROM dbp_etl.`_kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX}` AS A
    INNER JOIN dbp_data.art_man_spanne_per_1 AS EIN
        ON
            EIN.konditionsart_id = 'ZWGS' /* einstandspreis */ AND
            EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_man_spanne_per_1 AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.art_id = MEP.art_id
            AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat BETWEEN MEP.dat_von AND MEP.dat_bis
    LEFT JOIN
        dbp_data.art_man_spanne_per_1
            AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.art_id =
            EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg = 0 AND A.dat BETWEEN
            EKBNK.dat_von AND EKBNK.dat_bis
);


/* optional */ /* Einstandspreis zwingend erforderlich */ /* optional */ INSERT INTO dbp_etl.`_art_wup_man_spanne_tmp_$_1{TRANSIENT_TABLE_SUFFIX}`
(mandant_id, art_id, wup_id, nb_id, dat, zwgs, zwgm, zwge)
(
    SELECT
        EIN.mandant_id,
        EIN.art_id,
        EIN.wup_id,
        EIN.nb_id,
        A.dat,
        EIN.ek_faktor AS zwgs,
        COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
        COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
    FROM dbp_etl.`_kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX}` AS A
    INNER JOIN dbp_data.art_wup_man_spanne_per_1 AS EIN
        ON
            EIN.konditionsart_id = 'ZWGS' /* einstandspreis */
            AND EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_wup_man_spanne_per_1 AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.wup_id =
            MEP.wup_id AND EIN.art_id = MEP.art_id AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat
            BETWEEN MEP.dat_von AND MEP.dat_bis
    LEFT JOIN
        dbp_data.art_wup_man_spanne_per_1
            AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.wup_id
            = EKBNK.wup_id AND EIN.art_id = EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg
            = 0 AND A.dat BETWEEN EKBNK.dat_von AND EKBNK.dat_bis
);


DROP TABLE IF EXISTS dbp_etl.kmo_251_wpuums_art_gp_wup_zu_1;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_251_wpuums_art_gp_wup_zu_1 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    bezugsweg_id INTEGER,
    anz_ek_infosatz INTEGER,
    anz_ek_orderbuch INTEGER,
    bq_gp_id INTEGER,
    bq_ekorg INTEGER,
    bq_findung_id INTEGER,
    regel_gp_id INTEGER,
    regel_ekorg INTEGER,
    ref_wup_id INTEGER,
    ref_nb_id INTEGER,
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER,
    umrechnungskurs FLOAT64
);


-- kein Bezugsquellenfindung und man. Spanne auf 0 setzen

-- Rückbau des Ausstiegspunktes auf den Zustand vor dem Zugriff auf ZEKP_1

-- allg. oder betriebsspezifischer Zugriff auf ZEKP_1: betriebsspezifisch -1

/* Gruppierung wg. Promotion Kennzeichen erforderlich */ -- ermittelt werden muss

-- Kurs_1 merken, damit dieser bei der Anreicherung nicht
-- Bezugsweg zental: -12
INSERT INTO dbp_etl.kmo_251_wpuums_art_gp_wup_zu_1
(
    mandant_id, art_id, wup_id, nb_id, dat, bezugsweg_id, anz_ek_infosatz, anz_ek_orderbuch, bq_gp_id, bq_ekorg,
    bq_findung_id, regel_gp_id, regel_ekorg, ref_wup_id, ref_nb_id, kreistyp_gruppe_id, wg_id, umrechnungskurs
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.bezugsweg_id,
        0 AS anz_ek_infosatz,
        0 AS anz_ek_orderbuch,
        A.gp_id AS bq_gp_id,
        A.einkaufsorganisation_id AS bq_ekorg,
        MAX(CASE
            WHEN A.bq_findung_id BETWEEN 25 AND 27
                THEN 0
            WHEN A.bq_findung_id = 28
                THEN 28
            ELSE CASE
                WHEN A.bq_findung_id > 1
                    THEN CASE
                        WHEN A.bezugsweg_id = 4 -- bartosiewiczadm - cloud migration

                        -- THEN bq_findung_id - 12 + (bq_findung_id MOD 2) - 1
                        -- ELSE bq_findung_id + (bq_findung_id MOD 2) - 1

                            THEN A.bq_findung_id - 12 + MOD(A.bq_findung_id, 2) - 1
                        ELSE A.bq_findung_id + MOD(A.bq_findung_id, 2) - 1
                    END
                ELSE A.bq_findung_id
            END
        END) AS bq_findung_id_,
        0 AS regel_gp_id,
        0 AS regel_ekorg,
        0 AS ref_wup_id,
        0 AS ref_nb_id,
        '' AS kreistyp_gruppe_id,
        0 AS wg_id,
        CAST(K.umrechnungskurs AS FLOAT64) AS umrechnungskurs
    FROM dbp_etl.artbew_251_1 AS A
    INNER JOIN dbp_data.kurs_1 AS K
        ON
            A.wrg_1 = K.von_wrg_id AND K.kurstyp_id = 9 AND K.nach_wrg_id = 'EUR'
            AND A.dat BETWEEN K.dat_von AND K.dat_bis
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        A.dat,
        A.bezugsweg_id,
        bq_gp_id,
        bq_ekorg,
        K.umrechnungskurs
);


/* (1) manuelle Spanne */ /* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (2) EK-Preise ZEKP_1 */
/* (2) EK-Preise ZEKP_1 */ /* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */
/* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP_1 */ /* (2) EK-Preise ZEKP_1 */ /* (2) EK-Preise ZEKP_1 */
/* (2) EK-Preise ZEKP_1 */ /* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP_1 */ /* (1) manuelle Spanne */
/* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP_1 */ /* (1) manuelle Spanne */
/* (2) EK-Preise ZEKP_1 */ /* (2) EK-Preise ZEKP_1 */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */
/* (3) kein Treffer; 0%-Spanne */ /* (2) EK-Preise ZEKP_1 */ /* (3) kein Treffer; 0%-Spanne */ /* (2) EK-Preise ZEKP_1 */
/* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */
/* (2) EK-Preise ZEKP_1 */ /* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (3) kein Treffer; 0%-Spanne */
/* (2) EK-Preise ZEKP_1 */ /* (1) manuelle Spanne */ /* (2) EK-Preise ZEKP_1 */ /* (2) EK-Preise ZEKP_1 */
/* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */ /* (3) kein Treffer; 0%-Spanne */
/* (3) kein Treffer; 0%-Spanne */ /* (3) kein Treffer; 0%-Spanne */ /* (1) manuelle Spanne */
/* (3) kein Treffer; 0%-Spanne */ /* (3) kein Treffer; 0%-Spanne */ INSERT INTO dbp_etl.`__vol_artbew_rb`
(
    art_id, ean_kasse, wup_id, mandant_id, bewart_id, gp_id, einkaufsorganisation_id, nb_id, dat, aktion_id, herst_id,
    mwst_id, menge, wrg_1, umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto,
    diff_ek_brutto_konz, ek_netto, diff_ek_netto_konz, ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis,
    diff_ek_kal_basis_konz, ek_mep, diff_ek_mep_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag,
    diff_logkostenzuschlag_konz, bezugsweg_id, ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz, ek_gld, diff_ek_gld_konz, posten_id, bq_findung_id, promo_fg
)
(
    SELECT
        A.art_id,
        CAST(A.ean_kasse AS INTEGER) AS ean_kasse,
        A.wup_id,
        A.mandant_id,
        A.bewart_id,
        A.gp_id,
        A.einkaufsorganisation_id,
        A.nb_id,
        A.dat,
        A.aktion_id,
        A.herst_id,
        A.mwst_id,
        A.menge,
        A.wrg_1,
        A.umsatz_netto,
        A.diff_umsatz_netto_konz,
        A.umsatz_mwst_betrag,
        A.diff_umsatz_mwst_betrag_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_brutto, AGWW.ek_brutto) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_brutto,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_brutto, AGWW.ek_brutto) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * Z.umrechnungskurs AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_brutto_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_netto, AGWW.ek_netto) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_netto,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_netto, AGWW.ek_netto) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * Z.umrechnungskurs AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_netto_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_nettonetto,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * Z.umrechnungskurs AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_nettonetto_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_kal_basis, AGWW.ek_kal_basis) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_kal_basis,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_kal_basis, AGWW.ek_kal_basis) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * Z.umrechnungskurs AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_kal_basis_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_mep, AGWW.ek_mep) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_mep,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_mep, AGWW.ek_mep) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * Z.umrechnungskurs AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_mep_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.einstandspreis, AGWW.einstandspreis) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS einstandspreis,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.einstandspreis, AGWW.einstandspreis) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * Z.umrechnungskurs AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_einstandspreis_konz,
        CAST(
            A.menge * COALESCE(AGW.logistikkostenzuschlag, AGWW.logistikkostenzuschlag, 0.0000) AS NUMERIC) AS
        logkostenzuschlag_,
        CAST(
            A.menge * COALESCE(AGW.logistikkostenzuschlag, AGWW.logistikkostenzuschlag, 0.0000) * Z.umrechnungskurs AS NUMERIC) AS
        diff_logkostenzuschlag_konz_,
        A.bezugsweg_id,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_netto_bnk,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * Z.umrechnungskurs AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_netto_bnk_konz,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.umsatz_netto AS NUMERIC)
            ELSE COALESCE(ROUND(
                CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                CAST(A.menge * COALESCE(AGW.ek_netto_bnk_sachk, AGWW.ek_netto_bnk_sachk) AS NUMERIC),
                4
            ), CAST(A.umsatz_netto AS NUMERIC
            ))
        END AS ek_netto_bnk_sachk,
        CASE
            WHEN X.bq_findung_id = 25
                THEN CAST(A.diff_umsatz_netto_konz AS NUMERIC)
            ELSE COALESCE(ROUND(CAST(A.diff_umsatz_netto_konz * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(CAST(CASE
                WHEN X.bq_findung_id = 25
                    THEN CAST(A.umsatz_netto AS NUMERIC)
                ELSE COALESCE(ROUND(
                    CAST(A.umsatz_netto * COALESCE(MA.zwge, MS.zwge) AS NUMERIC), 4), ROUND(
                    CAST(A.menge * COALESCE(AGW.ek_netto_bnk_sachk, AGWW.ek_netto_bnk_sachk) AS NUMERIC),
                    4
                ), CAST(A.umsatz_netto AS NUMERIC
                ))
            END * Z.umrechnungskurs AS NUMERIC), 4), CAST(A.diff_umsatz_netto_konz AS NUMERIC))
        END AS diff_ek_netto_bnk_sachk_konz,
        A.ek_gld,
        A.diff_ek_gld_konz,
        A.posten_id,
        CASE
            WHEN A.bq_findung_id = 28
                THEN 28
            ELSE COALESCE(X.bq_findung_id, 30)
        END AS bq_findung_id,
        A.promo_fg
    FROM dbp_etl.artbew_251_1 AS A
    INNER JOIN dbp_etl.`_kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX}` AS D ON A.dat = D.dat
    INNER JOIN dbp_etl.kmo_251_wpuums_art_gp_wup_zu_1 AS Z
        ON
            A.mandant_id = Z.mandant_id AND A.art_id = Z.art_id
            AND A.wup_id = Z.wup_id AND A.nb_id = Z.nb_id AND A.dat = Z.dat -- Lieferant und Ausstiegspunkt ermitteln

    LEFT JOIN dbp_data.art_gp_nm_zu_per_1 AS X
        ON
            A.mandant_id = X.mandant_id AND A.wup_id = X.wup_id AND A.art_id
            = X.art_id AND A.dat BETWEEN X.dat_von AND X.dat_bis -- Betriebsspezifischer EK Preis

    LEFT JOIN dbp_etl.`__vol_art_gp_wup_zu_per` AS AGW
        ON
            X.mandant_id = AGW.mandant_id AND X.vz_wup_id = AGW.wup_id
            AND X.art_id = AGW.art_id AND A.gp_id = AGW.gp_id AND A.dat = AGW.dat -- Betriebsuebergreifender EK Preis

    LEFT JOIN dbp_etl.`__vol_art_gp_wup_zu_per` AS AGWW
        ON
            X.mandant_id = AGWW.mandant_id AND -1 = AGWW.wup_id AND
            X.art_id = AGWW.art_id AND A.gp_id = AGWW.gp_id AND A.dat = AGWW.dat
    -- Ermittlung betriebsuebergreifernde manuelle Spannenfaktoren

    LEFT JOIN dbp_etl.`_art_wup_man_spanne_tmp_$_1{TRANSIENT_TABLE_SUFFIX}` AS MS
        ON
            A.mandant_id = MS.mandant_id AND A.art_id = MS.art_id AND MS.wup_id = -1 AND A.dat = MS.dat AND A.bq_findung_id =
            27 -- Ermittlung Betriebsspezifischer manuelle Spannefaktoren

    LEFT JOIN
        dbp_etl.`_art_wup_man_spanne_tmp_$_1{TRANSIENT_TABLE_SUFFIX}`
            AS MA
        ON
            A.mandant_id = MA.mandant_id AND A.art_id = MA.art_id AND A.wup_id = MA.wup_id AND A.dat = MA.dat AND A.bq_findung_id
            = 26
);


UPDATE dbp_etl.`__vol_artbew_rb` SET
    gp_id = b.gp_id,
    bezugsweg_id = b.bezugsweg_id,
    ek_gld = b.ek_gld,
    diff_ek_gld_konz = b.diff_ek_gld_konz FROM (
    SELECT *
    FROM dbp_data.artbew_1
    WHERE (
        mandant_id, wup_id, dat) IN (
        SELECT (mandant_id, wup_id, dat)
        FROM dbp_data.artbew_agg_wt_1
        WHERE mandant_id IN (3, 8)
    )
) AS b
WHERE
    `__vol_artbew_rb`.wup_id = b.wup_id AND `__vol_artbew_rb`.art_id = b.art_id AND `__vol_artbew_rb`.bewart_id = b.bewart_id
    AND `__vol_artbew_rb`.ean_kasse = b.ean_kasse AND `__vol_artbew_rb`.promo_fg = b.promo_fg AND `__vol_artbew_rb`.dat
    = b.dat AND `__vol_artbew_rb`.mandant_id = b.mandant_id;


UPDATE dbp_etl.`__vol_artbew_rb` SET
    aktion_id = ''
WHERE aktion_id = '   0      ';


UPDATE dbp_etl.`__vol_artbew_rb` SET
    gp_id = b.gp_id_neu FROM (
    SELECT
        A.art_id,
        A.ean_kasse,
        A.wup_id,
        A.mandant_id,
        A.bewart_id,
        A.gp_id,
        A.einkaufsorganisation_id,
        A.nb_id,
        A.dat,
        A.aktion_id,
        A.herst_id,
        A.mwst_id,
        A.menge,
        A.wrg_1,
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
        A.einstandspreis,
        A.diff_einstandspreis_konz,
        A.logkostenzuschlag,
        A.diff_logkostenzuschlag_konz,
        A.bezugsweg_id,
        A.ek_netto_bnk,
        A.diff_ek_netto_bnk_konz,
        A.ek_netto_bnk_sachk,
        A.diff_ek_netto_bnk_sachk_konz,
        A.ek_gld,
        A.diff_ek_gld_konz,
        A.posten_id,
        A.bq_findung_id,
        A.promo_fg,
        B.gp_id AS gp_id_neu
    FROM dbp_etl.`__vol_artbew_rb` AS A
    INNER JOIN dbp_data.art_gp_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.dat_bis
            = PARSE_DATE('%F', '9999-12-31')
    WHERE A.gp_id = -1
) AS b
WHERE
    `__vol_artbew_rb`.mandant_id = b.mandant_id AND `__vol_artbew_rb`.dat = b.dat AND `__vol_artbew_rb`.wup_id = b.wup_id
    AND `__vol_artbew_rb`.art_id = b.art_id AND `__vol_artbew_rb`.bewart_id = b.bewart_id AND `__vol_artbew_rb`.ean_kasse
    = b.ean_kasse;


UPDATE dbp_etl.`__vol_artbew_rb` SET
    bezugsweg_id = b.bezugsweg_id_neu FROM (
    SELECT
        A.art_id,
        A.ean_kasse,
        A.wup_id,
        A.mandant_id,
        A.bewart_id,
        A.gp_id,
        A.einkaufsorganisation_id,
        A.nb_id,
        A.dat,
        A.aktion_id,
        A.herst_id,
        A.mwst_id,
        A.menge,
        A.wrg_1,
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
        A.einstandspreis,
        A.diff_einstandspreis_konz,
        A.logkostenzuschlag,
        A.diff_logkostenzuschlag_konz,
        A.bezugsweg_id,
        A.ek_netto_bnk,
        A.diff_ek_netto_bnk_konz,
        A.ek_netto_bnk_sachk,
        A.diff_ek_netto_bnk_sachk_konz,
        A.ek_gld,
        A.diff_ek_gld_konz,
        A.posten_id,
        A.bq_findung_id,
        A.promo_fg,
        B.bezugsweg_id AS bezugsweg_id_neu
    FROM dbp_etl.`__vol_artbew_rb` AS A
    INNER JOIN dbp_data.art_wup_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.wup_id
            = B.wup_id AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
    WHERE A.bezugsweg_id = 0
) AS b
WHERE
    `__vol_artbew_rb`.mandant_id = b.mandant_id AND `__vol_artbew_rb`.dat = b.dat AND `__vol_artbew_rb`.wup_id = b.wup_id
    AND `__vol_artbew_rb`.art_id = b.art_id AND `__vol_artbew_rb`.bewart_id = b.bewart_id AND `__vol_artbew_rb`.ean_kasse
    = b.ean_kasse;


DELETE FROM dbp_data.artbew_1
WHERE bewart_id <> 1010 AND (
    mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.`__vol_artbew_rb`
);


INSERT INTO dbp_data.artbew_1 (
    mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id,
    promo_fg, ean_kasse, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg_1, umsatz_netto, diff_umsatz_netto_konz,
    umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz, ek_netto, diff_ek_netto_konz,
    ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep, diff_ek_mep_konz, einstandspreis,
    diff_einstandspreis_konz, logkostenzuschlag, diff_logkostenzuschlag_konz, bezugsweg_id, ek_netto_bnk,
    diff_ek_netto_bnk_konz, ek_netto_bnk_sachk, diff_ek_netto_bnk_sachk_konz, posten_id, bq_findung_id, ek_gld,
    diff_ek_gld_konz, bewart_det_id, pv_bby, pv_kdn_bby, pv_kdp_bby, pv_aktion_bby, pv_aktion_kdn_bby, pv_aktion_kdp_bby
)
(SELECT
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
    einkaufsorganisation_id,
    herst_id,
    mwst_id,
    menge,
    wrg_1,
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
    9999 AS bewart_det_id,
    0 AS pv_bby,
    0 AS pv_kdn_bby,
    0 AS pv_kdp_bby,
    0 AS pv_aktion_bby,
    0 AS pv_aktion_kdn_bby,
    0 AS pv_aktion_kdp_bby
FROM dbp_etl.`__vol_artbew_rb`);


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon_delta_1;


DROP TABLE IF EXISTS dbp_etl.artbew_kmo_tmp_1;


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon_aktion_relevant_1;
