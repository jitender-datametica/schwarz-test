-- bartosiewiczadm - cloud migration
-- ,(a.dat / 100) +  190000 AS kjmo
INSERT INTO dbp_etl.wpuums_build_tmp_1
(
    mandant_id,
    wup_id,
    wg_id,
    bewart_id,
    dat,
    nb_id,
    arthiertyp_id,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz,
    umsatz_netto_konz,
    umsatz_mwst_betrag,
    kjmo,
    menge,
    quelle
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        B.wg_id,
        1001 AS bewart_id,
        A.dat,
        A.nb_id,
        2 AS arthiertyp_id,
        CAST(
            SUM(
                (A.umsatz_netto + A.umsatz_mwst_betrag) * B.alt_neu_kz
            ) AS NUMERIC
        ) AS umsatz_brutto,
        CAST(SUM(A.umsatz_netto * B.alt_neu_kz) AS NUMERIC),
        A.wrg_1,
        0,
        0,
        CAST(SUM(A.umsatz_mwst_betrag * B.alt_neu_kz) AS NUMERIC)
            AS umsatz_mwst_betrag,
        CAST(
            ROUND(CAST(FORMAT_DATE('%Y%m', A.dat) AS BIGNUMERIC), 0) AS INTEGER
        )
            AS kjmo,
        CAST(SUM(A.menge * B.alt_neu_kz) AS NUMERIC) AS menge,
        1
    FROM dbp_data.artbew_1 AS A
    INNER JOIN dbp_etl.artbew_wg_wechsel_join_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id
            AND A.dat = B.dat
    INNER JOIN dbp_data.art_wg_zu_per_1 AS W
        ON
            A.mandant_id = W.mandant_id AND A.art_id = W.art_id AND W.dat_bis
            = PARSE_DATE('%F', '9999-12-31') AND W.arthiertyp_id = 2
    WHERE
        CASE
            WHEN
                A.mandant_id = 1
                AND A.dat >= DATE '2017-03-01'
                AND A.art_id IN (590006700, 590006900)
                THEN 0
            WHEN
                A.mandant_id = 6
                AND A.art_id / 10 IN (9800130, 9800131, 9800132)
                OR A.mandant_id = 7 AND A.dat
                >= DATE '2019-03-01' AND W.wg_id = 969 AND W.wug_id = 6
                THEN 0
            ELSE 1
        END = 1
        AND B.wg_id NOT IN (818, 969)
    GROUP BY
        A.mandant_id,
        A.wup_id,
        B.wg_id,
        bewart_id,
        A.dat,
        A.nb_id,
        arthiertyp_id,
        A.wrg_1,
        11,
        kjmo,
        16
);


UPDATE dbp_etl.wpuums_build_tmp_1 SET
    umsatz_brutto_konz
    = ROUND(
        CAST(wpuums_build_tmp.umsatz_brutto * K.umrechnungskurs AS NUMERIC), 4
    ),
    umsatz_netto_konz
    = ROUND(
        CAST(wpuums_build_tmp.umsatz_netto * K.umrechnungskurs AS NUMERIC), 4
    )
FROM
    dbp_data.kurs_1 AS K
WHERE
    wpuums_build_tmp.umsatz_wrg = K.von_wrg_id
    AND K.dat_bis = PARSE_DATE('%F', '9999-12-31')
    AND K.nach_wrg_id
    = 'EUR' AND K.kurstyp_id = 3;


UPDATE dbp_data.artbew_wg_sum_1 AS AWS SET
    menge = AWS.menge + b.menge,
    umsatz_netto = AWS.umsatz_netto + b.umsatz_netto,
    umsatz_brutto = AWS.umsatz_brutto + b.umsatz_brutto,
    umsatz_brutto_konz = AWS.umsatz_brutto_konz + b.umsatz_brutto_konz,
    umsatz_netto_konz = AWS.umsatz_netto_konz + b.umsatz_netto_konz FROM (SELECT
    mandant_id,
    nb_id,
    arthiertyp_id,
    wg_id,
    dat,
    wup_id,
    bewart_id,
    kjmo,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz,
    umsatz_netto_konz,
    quelle,
    menge
FROM dbp_etl.wpuums_build_tmp_1) AS b
WHERE
    AWS.mandant_id = b.mandant_id
    AND AWS.nb_id = b.nb_id
    AND AWS.arthiertyp_id = b.arthiertyp_id
    AND AWS.wg_id = b.wg_id
    AND AWS.dat = b.dat
    AND AWS.wup_id = b.wup_id
    AND AWS.bewart_id = b.bewart_id
    AND AWS.umsatz_wrg = b.umsatz_wrg
    AND AWS.quelle = b.quelle;


INSERT INTO dbp_data.artbew_wg_sum_1 (
    mandant_id, nb_id, arthiertyp_id, wg_id, dat, wup_id, bewart_id, kjmo,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz,
    umsatz_netto_konz,
    quelle,
    menge
)
(
    SELECT
        a.mandant_id,
        a.nb_id,
        a.arthiertyp_id,
        a.wg_id,
        a.dat,
        a.wup_id,
        a.bewart_id,
        a.kjmo,
        a.umsatz_brutto,
        a.umsatz_netto,
        a.umsatz_wrg,
        a.umsatz_brutto_konz,
        a.umsatz_netto_konz,
        a.quelle,
        a.menge
    FROM (
        SELECT
            mandant_id,
            nb_id,
            arthiertyp_id,
            wg_id,
            dat,
            wup_id,
            bewart_id,
            kjmo,
            umsatz_wrg,
            quelle,
            SUM(umsatz_brutto) AS umsatz_brutto,
            SUM(umsatz_netto) AS umsatz_netto,
            SUM(umsatz_brutto_konz) AS umsatz_brutto_konz,
            SUM(umsatz_netto_konz) AS umsatz_netto_konz,
            SUM(menge) AS menge
        FROM dbp_etl.wpuums_build_tmp_1 AS A
        GROUP BY
            mandant_id,
            wup_id,
            wg_id,
            bewart_id,
            dat,
            nb_id,
            arthiertyp_id,
            umsatz_wrg,
            kjmo,
            quelle
    ) AS a
    LEFT JOIN dbp_data.artbew_wg_sum_1 AS B
        ON
            a.mandant_id = B.mandant_id AND a.wup_id = B.wup_id AND a.nb_id
            = B.nb_id
            AND a.dat = B.dat
            AND a.arthiertyp_id = B.arthiertyp_id
            AND a.wg_id = B.wg_id
            AND a.bewart_id = B
            .bewart_id
            AND a.kjmo = B.kjmo
            AND a.umsatz_wrg = B.umsatz_wrg
            AND a.quelle = B.quelle
    WHERE B.mandant_id IS NULL
);


DROP TABLE IF EXISTS dbp_etl.maabs_build_tmp_1;


CREATE TABLE IF NOT EXISTS dbp_etl.maabs_build_tmp_1 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    abschriftart_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    abschriftbetrag_netto NUMERIC(29, 2) NOT NULL,
    abschriftbetrag_brutto NUMERIC(29, 2) NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' NOT NULL
);


INSERT INTO dbp_etl.maabs_build_tmp_1 (
    mandant_id, wup_id, nb_id, abschriftart_id, wg_id, arthiertyp_id,
    dat, abschriftbetrag_netto, abschriftbetrag_brutto, wrg_id
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.preis_aend_grund_id,
        T2.wg_id,
        T2.arthiertyp_id,
        T1.dat_umbew,
        CAST(SUM(T1.diff_wert_bestand_netto * T2.alt_neu_kz) AS NUMERIC),
        CAST(SUM(T1.diff_wert_bestand_brutto * T2.alt_neu_kz) AS NUMERIC),
        T1.wrg_id
    FROM dbp_data.art_umbewertung_1 AS T1_1
    INNER JOIN dbp_etl.artbew_wg_wechsel_join_1 AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id
            AND T1.dat_umbew = T2.dat
    INNER JOIN dbp_data.abschriftart_abschriftgrp_zu_1 AS T3
        ON
            T1.mandant_id = T3.mandant_id AND T1.preis_aend_grund_id
            = T3.abschriftart_id AND T3.abschriftgruppe_id = 400
    GROUP BY
        T1.wup_id,
        T1.nb_id,
        T1.dat_umbew,
        T1.mandant_id,
        T2.wg_id,
        T1.preis_aend_grund_id,
        T1.wrg_id,
        T2.arthiertyp_id
);


INSERT INTO dbp_etl.maabs_build_tmp_1 (
    mandant_id, wup_id, nb_id, abschriftart_id, wg_id, arthiertyp_id,
    dat, abschriftbetrag_netto, abschriftbetrag_brutto, wrg_id
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.abschriftart_id,
        T2.wg_id,
        T2.arthiertyp_id,
        T1.dat,
        CAST(SUM(T1.abschriftbetrag_netto * T2.alt_neu_kz) AS NUMERIC),
        CAST(SUM(T1.abschriftbetrag_brutto * T2.alt_neu_kz) AS NUMERIC),
        T1.wrg_id
    FROM dbp_data.marktabschriften_1 AS T1_1
    INNER JOIN dbp_etl.artbew_wg_wechsel_join_1 AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id
            AND T1.dat = T2.dat
    GROUP BY
        T1.wup_id,
        T1.nb_id,
        T1.dat,
        T1.mandant_id,
        T2.wg_id,
        T1.abschriftart_id,
        T1.wrg_id,
        T2.arthiertyp_id
);


UPDATE dbp_data.marktabschriften_wg_sum_1 AS MWS SET
    abschriftbetrag_netto = MWS.abschriftbetrag_netto + b.abschriftbetrag_netto,
    abschriftbetrag_brutto
    = MWS.abschriftbetrag_brutto + b.abschriftbetrag_brutto
FROM (SELECT
    wup_id,
    nb_id,
    dat,
    mandant_id,
    wg_id,
    abschriftart_id,
    wrg_id,
    arthiertyp_id,
    abschriftbetrag_netto,
    abschriftbetrag_brutto
FROM dbp_etl.maabs_build_tmp_1) AS b
WHERE
    MWS.wup_id = b.wup_id
    AND MWS.nb_id = b.nb_id
    AND MWS.dat = b.dat
    AND MWS.mandant_id = b.mandant_id
    AND MWS.wg_id
    = b.wg_id AND MWS.abschriftart_id = b.abschriftart_id AND MWS.wrg_id = b.wrg_id AND MWS.arthiertyp_id = b.arthiertyp_id;


INSERT INTO dbp_data.marktabschriften_wg_sum_1 (
    mandant_id, wup_id, nb_id, abschriftart_id, wg_id,
    arthiertyp_id, dat, abschriftbetrag_netto, abschriftbetrag_brutto, wrg_id
)
(
    SELECT
        a.mandant_id,
        a.wup_id,
        a.nb_id,
        a.abschriftart_id,
        a.wg_id,
        a.arthiertyp_id,
        a.dat,
        a.abschriftbetrag_netto,
        a.abschriftbetrag_brutto,
        a.wrg_id
    FROM (
        SELECT
            wup_id,
            nb_id,
            dat,
            mandant_id,
            wg_id,
            abschriftart_id,
            wrg_id,
            arthiertyp_id,
            SUM(abschriftbetrag_netto) AS abschriftbetrag_netto,
            SUM(abschriftbetrag_brutto) AS abschriftbetrag_brutto
        FROM dbp_etl.maabs_build_tmp_1
        GROUP BY
            mandant_id,
            wup_id,
            nb_id,
            abschriftart_id,
            wg_id,
            arthiertyp_id,
            dat,
            wrg_id
    ) AS a
    LEFT JOIN dbp_data.marktabschriften_wg_sum_1 AS B
        ON
            a.wup_id = B.wup_id AND a.nb_id = B.nb_id AND a.dat
            = B.dat
            AND a.mandant_id = B.mandant_id
            AND a.wg_id = B.wg_id
            AND a.abschriftart_id = B.abschriftart_id
            AND a.wrg_id
            = B.wrg_id AND a.arthiertyp_id = B.arthiertyp_id
    WHERE B.mandant_id IS NULL
);


TRUNCATE TABLE dbp_etl_process.artbew_wg_wechsel_1;


INSERT INTO dbp_etl_process.artbew_wg_wechsel_1 (
    mandant_id, art_id, arthiertyp_id, wg_id, wg_art_fg
)
(SELECT
    mandant_id,
    art_id,
    arthiertyp_id,
    wg_id,
    wg_art_fg
FROM dbp_etl.artbew_wg_wechsel_tmp_1
WHERE alt_neu_kz = 1);


DELETE FROM dbp_data.artbew_wg_mo_sum_1 AS AWMS
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.artbew_wg_sum_tmp_1 AS AWST
    WHERE
        AWMS.wg_id = wg_id
        AND AWMS.wup_id = wup_id
        AND AWMS.nb_id = nb_id
        AND AWMS.arthiertyp_id = arthiertyp_id
        AND AWMS.bewart_id = bewart_id
        AND AWMS.posten_id = posten_id
        AND AWMS.mandant_id = mandant_id
        AND AWMS.menge = 0
        AND AWMS.umsatz_netto = 0
        AND AWMS.diff_umsatz_netto_konz = 0
        AND AWMS.umsatz_mwst_betrag = 0
        AND AWMS.diff_umsatz_mwst_betrag_konz = 0
        AND AWMS.ek_brutto = 0
        AND AWMS.diff_ek_brutto_konz = 0
        AND AWMS.ek_netto = 0
        AND AWMS.diff_ek_netto_konz = 0
        AND AWMS.ek_nettonetto = 0
        AND AWMS.diff_ek_nettonetto_konz = 0
        AND AWMS.ek_kal_basis = 0
        AND AWMS.diff_ek_kal_basis_konz = 0
        AND AWMS.ek_mep = 0
        AND AWMS.diff_ek_mep_konz = 0
        AND AWMS.einstandspreis = 0
        AND AWMS.diff_einstandspreis_konz = 0
        AND AWMS.logkostenzuschlag = 0
        AND AWMS.diff_logkostenzuschlag_konz = 0
        AND AWMS.ek_netto_bnk = 0
        AND AWMS.diff_ek_netto_bnk_konz = 0
        AND AWMS.ek_netto_bnk_sachk = 0
        AND AWMS.diff_ek_netto_bnk_sachk_konz = 0
);


DELETE FROM dbp_data.artbew_wg_tp2_sum_1 AS AWTS
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.artbew_wg_sum_tmp_1 AS ABWSTMP
    WHERE
        AWTS.menge = 0
        AND AWTS.menge_ohne_wg_erf_art = 0
        AND AWTS.umsatz_netto = 0
        AND AWTS.diff_umsatz_netto_konz = 0
        AND AWTS.umsatz_mwst_betrag = 0
        AND AWTS.diff_umsatz_mwst_betrag_konz = 0
        AND AWTS.ek_brutto = 0
        AND AWTS.diff_ek_brutto_konz = 0
        AND AWTS.ek_netto = 0
        AND AWTS.diff_ek_netto_konz = 0
        AND AWTS.ek_nettonetto = 0
        AND AWTS.diff_ek_nettonetto_konz = 0
        AND AWTS.ek_kal_basis = 0
        AND AWTS.diff_ek_kal_basis_konz = 0
        AND AWTS.ek_mep = 0
        AND AWTS.diff_ek_mep_konz = 0
        AND AWTS.einstandspreis = 0
        AND AWTS.diff_einstandspreis_konz = 0
        AND AWTS.logkostenzuschlag = 0
        AND AWTS.diff_logkostenzuschlag_konz = 0
        AND AWTS.ek_netto_bnk = 0
        AND AWTS.diff_ek_netto_bnk_konz = 0
        AND AWTS.ek_netto_bnk_sachk = 0
        AND AWTS.diff_ek_netto_bnk_sachk_konz = 0
        AND AWTS.wg_id = wg_id
        AND AWTS.wup_id = wup_id
        AND AWTS.nb_id = nb_id
        AND AWTS.arthiertyp_id = arthiertyp_id
        AND AWTS.dat = dat
        AND AWTS.bewart_id = bewart_id
        AND AWTS.posten_id = COLLATE(posten_id, 'und:ci')
        AND AWTS.mandant_id = mandant_id
);


DELETE FROM dbp_data.artbew_wg_sum_1 AS AWS
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.wpuums_build_tmp_1 AS WBT
    WHERE
        AWS.menge = 0
        AND AWS.umsatz_netto = 0
        AND AWS.umsatz_brutto = 0
        AND AWS.umsatz_brutto_konz = 0
        AND AWS.umsatz_netto_konz = 0
        AND AWS.wg_id = wg_id
        AND AWS.wup_id = wup_id
        AND AWS.nb_id = nb_id
        AND AWS.arthiertyp_id = arthiertyp_id
        AND AWS.bewart_id = bewart_id
        AND AWS.mandant_id = mandant_id
        AND AWS.dat = dat
        AND AWS.umsatz_wrg = umsatz_wrg
        AND AWS.quelle = quelle
);


DELETE FROM dbp_data.marktabschriften_wg_sum_1 AS MWS
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.maabs_build_tmp_1 AS MBT
    WHERE
        MWS.abschriftbetrag_netto = 0
        AND MWS.abschriftbetrag_brutto = 0
        AND MWS.wup_id = wup_id
        AND MWS.nb_id = nb_id
        AND MWS.dat = dat
        AND MWS.mandant_id = mandant_id
        AND MWS.wg_id = wg_id
        AND MWS.abschriftart_id = abschriftart_id
        AND MWS.wrg_id = wrg_id
        AND MWS.arthiertyp_id = arthiertyp_id
);


DROP TABLE IF EXISTS dbp_etl.artbew_wg_wechsel_tmp_1;


DROP TABLE IF EXISTS dbp_etl.artbew_wg_sum_tmp_1;
