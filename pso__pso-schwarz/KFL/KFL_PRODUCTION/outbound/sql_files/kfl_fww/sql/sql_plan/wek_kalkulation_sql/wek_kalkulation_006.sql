CREATE OR REPLACE TABLE dbp_etl.tag_wa_kalk_final_ro (
    mandant_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    dat DATE,
    wrg_id STRING(3) COLLATE 'und:ci',
    zek_id STRING(3),
    eigenmarke_fg INTEGER,
    wup_bereinigt_fg INTEGER,
    umsatz_netto NUMERIC(29, 4),
    umsatz_netto_vj NUMERIC(29, 4),
    umsatz_netto_vj_km NUMERIC(29, 4),
    logkostenzuschlag NUMERIC(29, 4),
    logkostenzuschlag_vj NUMERIC(29, 4),
    logkostenzuschlag_vj_km NUMERIC(29, 4),
    betrag_kmep_km FLOAT64,
    betrag_kmep_km_vj FLOAT64,
    betrag_kmep_kw FLOAT64,
    betrag_kmep_kw_vj FLOAT64,
    betrag_kmep_ww FLOAT64,
    betrag_kmep_ww_vj FLOAT64,
    werbe_abschrift_netto NUMERIC(29, 4) NOT NULL,
    werbe_abschrift_netto_vj NUMERIC(29, 4) NOT NULL,
    werbe_abschrift_netto_vj_km NUMERIC(29, 4) NOT NULL,
    preis_abschrift_netto NUMERIC(29, 4) NOT NULL,
    preis_abschrift_netto_vj NUMERIC(29, 4) NOT NULL,
    preis_abschrift_netto_vj_km NUMERIC(29, 4) NOT NULL,
    betrag_kmep_o_fwu_km FLOAT64,
    betrag_kmep_o_fwu_km_vj FLOAT64,
    betrag_kmep_o_fwu_kw FLOAT64,
    betrag_kmep_o_fwu_kw_vj FLOAT64,
    betrag_kmep_o_fwu_ww FLOAT64,
    betrag_kmep_o_fwu_ww_vj FLOAT64,
    umrechnungskurs_hist NUMERIC(29, 5)
);


CREATE OR REPLACE TABLE dbp_etl.monat_wa_kalk_final_ro (
    mandant_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    kjmo INTEGER,
    wrg_id STRING(3) COLLATE 'und:ci',
    posten_id STRING(2) COLLATE 'und:ci',
    wup_bereinigt_fg INTEGER,
    zek_id STRING(3),
    eigenmarke_fg INTEGER,
    gp_id INTEGER,
    umsatz_netto NUMERIC(29, 4),
    umsatz_netto_vj NUMERIC(29, 4),
    betrag_kmep NUMERIC(29, 4),
    betrag_kmep_vj NUMERIC(29, 4),
    logkostenzuschlag NUMERIC(29, 4),
    logkostenzuschlag_vj NUMERIC(29, 4),
    werbe_abschrift_netto NUMERIC(29, 4),
    werbe_abschrift_netto_vj NUMERIC(29, 4),
    preis_abschrift_netto NUMERIC(29, 2),
    preis_abschrift_netto_vj NUMERIC(29, 2),
    bewart_det_id INTEGER,
    betrag_kmep_o_fwu NUMERIC(29, 4),
    betrag_kmep_o_fwu_vj NUMERIC(29, 4),
    umrechnungskurs_hist NUMERIC(29, 5)
);


INSERT INTO dbp_etl.tag_wa_kalk_final_ro (
    mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id,
    dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    umsatz_netto,
    umsatz_netto_vj,
    umsatz_netto_vj_km,
    logkostenzuschlag,
    logkostenzuschlag_vj,
    logkostenzuschlag_vj_km,
    betrag_kmep_km,
    betrag_kmep_km_vj,
    betrag_kmep_kw,
    betrag_kmep_kw_vj,
    betrag_kmep_ww,
    betrag_kmep_ww_vj,
    werbe_abschrift_netto,
    werbe_abschrift_netto_vj,
    werbe_abschrift_netto_vj_km,
    preis_abschrift_netto,
    preis_abschrift_netto_vj,
    preis_abschrift_netto_vj_km,
    betrag_kmep_o_fwu_km,
    betrag_kmep_o_fwu_km_vj,
    betrag_kmep_o_fwu_kw,
    betrag_kmep_o_fwu_kw_vj,
    betrag_kmep_o_fwu_ww,
    betrag_kmep_o_fwu_ww_vj, umrechnungskurs_hist
)
(
    SELECT
        mandant_id,
        art_id,
        bewart_id,
        bewart_det_id,
        wup_id,
        nb_id,
        dat,
        wrg_id,
        zek_id,
        eigenmarke_fg,
        wup_bereinigt_fg,
        SUM(umsatz_netto),
        SUM(umsatz_netto_vj),
        SUM(umsatz_netto_vj_km),
        SUM(logkostenzuschlag),
        SUM(logkostenzuschlag_vj),
        SUM(logkostenzuschlag_vj_km),
        CAST(SUM(betrag_kmep_km) AS FLOAT64),
        SUM(betrag_kmep_km_vj),
        CAST(SUM(betrag_kmep_kw) AS FLOAT64),
        SUM(betrag_kmep_kw_vj),
        CAST(SUM(betrag_kmep_ww) AS FLOAT64),
        SUM(betrag_kmep_ww_vj),
        SUM(werbe_abschrift_netto),
        SUM(werbe_abschrift_netto_vj),
        SUM(werbe_abschrift_netto_vj_km),
        SUM(preis_abschrift_netto),
        SUM(preis_abschrift_netto_vj),
        SUM(preis_abschrift_netto_vj_km),
        CAST(SUM(betrag_kmep_o_fwu_km) AS FLOAT64),
        SUM(betrag_kmep_o_fwu_km_vj),
        CAST(SUM(betrag_kmep_o_fwu_kw) AS FLOAT64),
        SUM(betrag_kmep_o_fwu_kw_vj),
        CAST(SUM(betrag_kmep_o_fwu_ww) AS FLOAT64),
        SUM(betrag_kmep_o_fwu_ww_vj),
        SUM(0)
    FROM (
        SELECT
            A.mandant_id,
            A.art_id,
            A.bewart_id,
            A.bewart_det_id,
            A.wup_id,
            A.nb_id,
            A.dat,
            B.default_wrg AS wrg_id,
            C.zek_id,
            C.eigenmarke_fg,
            0 AS wup_bereinigt_fg,
            A.umsatz_netto_ AS umsatz_netto,
            0 AS umsatz_netto_vj,
            0 AS umsatz_netto_vj_km,
            A.logkostenzuschlag,
            0 AS logkostenzuschlag_vj,
            0 AS logkostenzuschlag_vj_km,
            A.umsatz_netto_ - A.ek_mep_einstandspreis__ AS betrag_kmep_km,
            0 AS betrag_kmep_km_vj,
            A.umsatz_netto_ - A.wa_kalk_kw_ AS betrag_kmep_kw,
            0 AS betrag_kmep_kw_vj,
            A.umsatz_netto_ - A.wa_kalk_ww_ AS betrag_kmep_ww,
            0 AS betrag_kmep_ww_vj,
            0 AS werbe_abschrift_netto,
            0 AS werbe_abschrift_netto_vj,
            0 AS werbe_abschrift_netto_vj_km,
            0 AS preis_abschrift_netto,
            0 AS preis_abschrift_netto_vj,
            0 AS preis_abschrift_netto_vj_km,
            A.umsatz_netto_
            - A.ek_mep_einstandspreis_fwu__ AS betrag_kmep_o_fwu_km,
            0 AS betrag_kmep_o_fwu_km_vj,
            A.umsatz_netto_ - A.wa_kalk_fwu_kw_ AS betrag_kmep_o_fwu_kw,
            0 AS betrag_kmep_o_fwu_kw_vj,
            A.umsatz_netto_ - A.wa_kalk_fwu_ww_ AS betrag_kmep_o_fwu_ww,
            0 AS betrag_kmep_o_fwu_ww_vj
        FROM dbp_etl_process.ekc_artbew AS A
        INNER JOIN dbp_data.mandant AS B ON A.mandant_id = B.mandant_id
        INNER JOIN
            dbp_etl_process.ekc_zek AS C
            ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
        WHERE
            A.dat BETWEEN (
                SELECT MIN(dat)
                FROM dbp_etl.zeitraum_fww_kmo_gld) AND (
                SELECT MAX(dat)
                FROM dbp_etl.zeitraum_fww_kmo_gld
            )
            AND A.mandant_id = 7
        UNION ALL
        SELECT
            A.mandant_id,
            A.art_id,
            A.bewart_id,
            A.bewart_det_id,
            A.wup_id,
            A.nb_id,
            DATE_ADD(A.dat, INTERVAL 364 DAY) AS dat,
            B.default_wrg AS wrg_id,
            C.zek_id,
            C.eigenmarke_fg,
            0 AS wup_bereinigt_fg,
            0 AS umsatz_netto,
            A.umsatz_netto_ AS umsatz_netto_vj,
            0 AS umsatz_netto_vj_km,
            0 AS logkostenzuschlag,
            A.logkostenzuschlag AS logkostenzuschlag_vj,
            0 AS logkostenzuschlag_vj_km,
            0 AS betrag_kmep_km,
            0 AS betrag_kmep_km_vj,
            0 AS betrag_kmep_kw,
            A.umsatz_netto_ - A.wa_kalk_kw_ AS betrag_kmep_kw_vj,
            0 AS betrag_kmep_ww,
            A.umsatz_netto_ - A.wa_kalk_ww_ AS betrag_kmep_ww_vj,
            0 AS werbe_abschrift_netto,
            0 AS werbe_abschrift_netto_vj,
            0 AS werbe_abschrift_netto_vj_km,
            0 AS preis_abschrift_netto,
            0 AS preis_abschrift_netto_vj,
            0 AS preis_abschrift_netto_vj_km,
            0 AS betrag_kmep_o_fwu_km,
            0 AS betrag_kmep_o_fwu_km_vj,
            0 AS betrag_kmep_o_fwu_kw,
            A.umsatz_netto_ - A.wa_kalk_fwu_kw_ AS betrag_kmep_o_fwu_kw_vj,
            0 AS betrag_kmep_o_fwu_ww,
            A.umsatz_netto_ - A.wa_kalk_fwu_ww_ AS betrag_kmep_o_fwu_ww_vj
        FROM dbp_etl_process.ekc_artbew AS A
        INNER JOIN dbp_data.mandant AS B ON A.mandant_id = B.mandant_id
        INNER JOIN
            dbp_etl_process.ekc_zek AS C
            ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
        WHERE
            A.dat BETWEEN (
                SELECT DATE_SUB(MIN(dat), INTERVAL 364 DAY)
                FROM dbp_etl.zeitraum_fww_kmo_gld) AND (
                SELECT DATE_SUB(MAX(dat), INTERVAL 364 DAY)
                FROM dbp_etl.zeitraum_fww_kmo_gld
            )
            AND A.mandant_id = 7
        UNION ALL
        SELECT
            A.mandant_id,
            A.art_id,
            A.bewart_id,
            A.bewart_det_id,
            A.wup_id,
            A.nb_id,
            DATE_ADD(A.dat, INTERVAL X.days_back DAY) AS dat,
            B.default_wrg AS wrg_id,
            C.zek_id,
            C.eigenmarke_fg,
            0 AS wup_bereinigt_fg,
            0 AS umsatz_netto,
            0 AS umsatz_netto_vj,
            A.umsatz_netto_ AS umsatz_netto_vj_km,
            0 AS logkostenzuschlag,
            0 AS logkostenzuschlag_vj,
            A.logkostenzuschlag AS logkostenzuschlag_vj_km,
            0 AS betrag_kmep_km,
            A.umsatz_netto_
            - A.ek_mep_einstandspreis__ AS betrag_kmep_km_vj,
            0 AS betrag_kmep_kw,
            0 AS betrag_kmep_kw_vj,
            0 AS betrag_kmep_ww,
            0 AS betrag_kmep_ww_vj,
            0 AS werbe_abschrift_netto,
            0 AS werbe_abschrift_netto_vj,
            0 AS werbe_abschrift_netto_vj_km,
            0 AS preis_abschrift_netto,
            0 AS preis_abschrift_netto_vj,
            0 AS preis_abschrift_netto_vj_km,
            0 AS betrag_kmep_o_fwu_km,
            A.umsatz_netto_
            - A.ek_mep_einstandspreis_fwu__ AS betrag_kmep_o_fwu_km_vj,
            0 AS betrag_kmep_o_fwu_kw,
            0 AS betrag_kmep_o_fwu_kw_vj,
            0 AS betrag_kmep_o_fwu_ww,
            0 AS betrag_kmep_o_fwu_ww_vj
        FROM dbp_etl_process.ekc_artbew AS A
        INNER JOIN dbp_data.mandant AS B ON A.mandant_id = B.mandant_id
        INNER JOIN
            dbp_etl_process.ekc_zek AS C
            ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
        INNER JOIN
            dbp_etl.zeitraum_fww_kmo_gld AS X
            ON A.dat = DATE_SUB(X.dat, INTERVAL X.days_back DAY)

        WHERE
            A.mandant_id = 7
            AND DATE_ADD(
                A.dat, INTERVAL X.days_back DAY) NOT IN (
                SELECT dat
                FROM dbp_etl.zeitraum_fww_kmo_gld
                WHERE sj = 1
            )
        UNION ALL
        SELECT
            A.mandant_id,
            A.art_id,
            A.bewart_id,
            A.bewart_det_id,
            A.wup_id,
            A.nb_id,
            DATE_SUB(
                DATE_ADD(A.dat, INTERVAL X.days_back DAY), INTERVAL 1 DAY
            )
                AS dat,
            B.default_wrg AS wrg_id,
            C.zek_id,
            C.eigenmarke_fg,
            0 AS wup_bereinigt_fg,
            0 AS umsatz_netto,
            0 AS umsatz_netto_vj,
            A.umsatz_netto_ AS umsatz_netto_vj_km,
            0 AS logkostenzuschlag,
            0 AS logkostenzuschlag_vj,
            A.logkostenzuschlag AS logkostenzuschlag_vj_km,
            0 AS betrag_kmep_km,
            A.umsatz_netto_
            - A.ek_mep_einstandspreis__ AS betrag_kmep_km_vj,
            0 AS betrag_kmep_kw,
            0 AS betrag_kmep_kw_vj,
            0 AS betrag_kmep_ww,
            0 AS betrag_kmep_ww_vj,
            0 AS werbe_abschrift_netto,
            0 AS werbe_abschrift_netto_vj,
            0 AS werbe_abschrift_netto_vj_km,
            0 AS preis_abschrift_netto,
            0 AS preis_abschrift_netto_vj,
            0 AS preis_abschrift_netto_vj_km,
            0 AS betrag_kmep_o_fwu_km,
            A.umsatz_netto_
            - A.ek_mep_einstandspreis_fwu__ AS betrag_kmep_o_fwu_km_vj,
            0 AS betrag_kmep_o_fwu_kw,
            0 AS betrag_kmep_o_fwu_kw_vj,
            0 AS betrag_kmep_o_fwu_ww,
            0 AS betrag_kmep_o_fwu_ww_vj
        FROM dbp_etl_process.ekc_artbew AS A
        INNER JOIN dbp_data.mandant AS B ON A.mandant_id = B.mandant_id
        INNER JOIN
            dbp_etl_process.ekc_zek AS C
            ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
        INNER JOIN dbp_etl.zeitraum_fww_kmo_gld AS X
            ON A.dat = DATE_ADD(DATE_SUB(
                X.dat, INTERVAL X.days_back
                DAY
            ), INTERVAL 1 DAY) AND X.sj = -1
        WHERE A.mandant_id = 7
    ) AS z
    GROUP BY
        mandant_id,
        art_id,
        bewart_id,
        bewart_det_id,
        wup_id,
        nb_id,
        dat,
        wrg_id,
        zek_id,
        eigenmarke_fg,
        wup_bereinigt_fg
);


INSERT INTO dbp_etl.tag_wa_kalk_final_ro (
    mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id,
    dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    umsatz_netto,
    umsatz_netto_vj,
    umsatz_netto_vj_km,
    logkostenzuschlag,
    logkostenzuschlag_vj,
    logkostenzuschlag_vj_km,
    betrag_kmep_km,
    betrag_kmep_km_vj,
    betrag_kmep_kw,
    betrag_kmep_kw_vj,
    betrag_kmep_ww,
    betrag_kmep_ww_vj,
    werbe_abschrift_netto,
    werbe_abschrift_netto_vj,
    werbe_abschrift_netto_vj_km,
    preis_abschrift_netto,
    preis_abschrift_netto_vj,
    preis_abschrift_netto_vj_km,
    betrag_kmep_o_fwu_km,
    betrag_kmep_o_fwu_km_vj,
    betrag_kmep_o_fwu_kw,
    betrag_kmep_o_fwu_kw_vj,
    betrag_kmep_o_fwu_ww,
    betrag_kmep_o_fwu_ww_vj, umrechnungskurs_hist
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        1 AS wup_bereinigt_fg,
        A.umsatz_netto,
        A.umsatz_netto_vj,
        A.umsatz_netto_vj_km,
        A.logkostenzuschlag,
        A.logkostenzuschlag_vj,
        A.logkostenzuschlag_vj_km,
        A.betrag_kmep_km,
        A.betrag_kmep_km_vj,
        A.betrag_kmep_kw,
        A.betrag_kmep_kw_vj,
        A.betrag_kmep_ww,
        A.betrag_kmep_ww_vj,
        A.werbe_abschrift_netto,
        A.werbe_abschrift_netto_vj,
        A.werbe_abschrift_netto_vj_km,
        A.preis_abschrift_netto,
        A.preis_abschrift_netto_vj,
        A.preis_abschrift_netto_vj_km,
        A.betrag_kmep_o_fwu_km,
        A.betrag_kmep_o_fwu_km_vj,
        A.betrag_kmep_o_fwu_kw,
        A.betrag_kmep_o_fwu_kw_vj,
        A.betrag_kmep_o_fwu_ww,
        A.betrag_kmep_o_fwu_ww_vj,
        A.umrechnungskurs_hist
    FROM dbp_etl.tag_wa_kalk_final_ro AS A
    INNER JOIN dbp_data.tag AS X1 ON A.dat = X1.dat
    INNER JOIN dbp_data.wup AS X2
        ON
            A.mandant_id = X2.mandant_id
            AND A.nb_id = X2.nb_id
            AND A.wup_id = X2
            .wup_id
    WHERE
        X1.wo_dat_von >= IF(
            X2.dat_von = LAST_DAY(X2.dat_von),
            LAST_DAY(DATE_ADD(X2.dat_von, INTERVAL 12 MONTH)),
            DATE_ADD(X2.dat_von, INTERVAL 12 MONTH)
        )
        AND X1.wo_dat_bis <= X2.dat_bis
);


INSERT INTO dbp_etl.tag_wa_kalk_final_ro (
    mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id,
    dat,
    wrg_id,
    zek_id,
    eigenmarke_fg,
    wup_bereinigt_fg,
    umsatz_netto,
    umsatz_netto_vj,
    umsatz_netto_vj_km,
    logkostenzuschlag,
    logkostenzuschlag_vj,
    logkostenzuschlag_vj_km,
    betrag_kmep_km,
    betrag_kmep_km_vj,
    betrag_kmep_kw,
    betrag_kmep_kw_vj,
    betrag_kmep_ww,
    betrag_kmep_ww_vj,
    werbe_abschrift_netto,
    werbe_abschrift_netto_vj,
    werbe_abschrift_netto_vj_km,
    preis_abschrift_netto,
    preis_abschrift_netto_vj,
    preis_abschrift_netto_vj_km,
    betrag_kmep_o_fwu_km,
    betrag_kmep_o_fwu_km_vj,
    betrag_kmep_o_fwu_kw,
    betrag_kmep_o_fwu_kw_vj,
    betrag_kmep_o_fwu_ww,
    betrag_kmep_o_fwu_ww_vj, umrechnungskurs_hist
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        'EUR' AS wrg_id,
        A.zek_id,
        A.eigenmarke_fg,
        A.wup_bereinigt_fg,
        A.umsatz_netto * D1.umrechnungskurs,
        A.umsatz_netto_vj * D1.umrechnungskurs,
        A.umsatz_netto_vj_km * D1.umrechnungskurs,
        A.logkostenzuschlag * D1.umrechnungskurs,
        A.logkostenzuschlag_vj * D1.umrechnungskurs,
        A.logkostenzuschlag_vj_km * D1.umrechnungskurs,
        CAST(A.betrag_kmep_km * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_km_vj * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_kw * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_kw_vj * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_ww * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_ww_vj * D1.umrechnungskurs AS FLOAT64),
        A.werbe_abschrift_netto * D1.umrechnungskurs,
        A.werbe_abschrift_netto_vj * D1.umrechnungskurs,
        A.werbe_abschrift_netto_vj_km * D1.umrechnungskurs,
        A.preis_abschrift_netto * D1.umrechnungskurs,
        A.preis_abschrift_netto_vj * D1.umrechnungskurs,
        A.preis_abschrift_netto_vj_km * D1.umrechnungskurs,
        CAST(A.betrag_kmep_o_fwu_km * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_o_fwu_km_vj * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_o_fwu_kw * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_o_fwu_kw_vj * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_o_fwu_ww * D1.umrechnungskurs AS FLOAT64),
        CAST(A.betrag_kmep_o_fwu_ww_vj * D1.umrechnungskurs AS FLOAT64),
        A.umrechnungskurs_hist
    FROM dbp_etl.tag_wa_kalk_final_ro AS A
    INNER JOIN dbp_data.kurs AS D1
        ON
            A.wrg_id = D1.von_wrg_id
            AND D1.dat_bis = DATE '9999-12-31'
            AND D1.nach_wrg_id
            = 'EUR' AND D1.kurstyp_id = 3
    WHERE A.mandant_id = 7
);


INSERT INTO dbp_etl.monat_wa_kalk_final_ro (
    mandant_id, art_id, bewart_id, wup_id, nb_id, kjmo, wrg_id,
    posten_id,
    wup_bereinigt_fg,
    zek_id,
    eigenmarke_fg,
    gp_id,
    umsatz_netto,
    umsatz_netto_vj,
    betrag_kmep,
    betrag_kmep_vj,
    logkostenzuschlag,
    logkostenzuschlag_vj,
    werbe_abschrift_netto,
    werbe_abschrift_netto_vj,
    preis_abschrift_netto,
    preis_abschrift_netto_vj,
    bewart_det_id,
    betrag_kmep_o_fwu,
    betrag_kmep_o_fwu_vj,
    umrechnungskurs_hist
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.wup_id,
        A.nb_id,
        CAST(
            ROUND(
                CAST(SUBSTR(FORMAT_DATE('%Y%m%d', A.dat), 1, 6) AS BIGNUMERIC),
                0
            ) AS INTEGER
        ) AS kjmo,
        A.wrg_id,
        B.posten_id,
        A.wup_bereinigt_fg,
        A.zek_id,
        A.eigenmarke_fg,
        C.gp_id,
        SUM(A.umsatz_netto),
        SUM(A.umsatz_netto_vj_km),
        ROUND(CAST(SUM(A.betrag_kmep_km) AS NUMERIC), 4),
        ROUND(CAST(SUM(A.betrag_kmep_km_vj) AS NUMERIC), 4),
        SUM(A.logkostenzuschlag),
        SUM(A.logkostenzuschlag_vj_km),
        SUM(A.werbe_abschrift_netto),
        SUM(A.werbe_abschrift_netto_vj_km),
        SUM(A.preis_abschrift_netto),
        SUM(A.preis_abschrift_netto_vj_km),
        A.bewart_det_id,
        ROUND(CAST(SUM(A.betrag_kmep_o_fwu_km) AS NUMERIC), 4),
        ROUND(CAST(SUM(A.betrag_kmep_o_fwu_km_vj) AS NUMERIC), 4),
        SUM(A.umrechnungskurs_hist)
    FROM dbp_etl.tag_wa_kalk_final_ro AS A
    INNER JOIN dbp_data.art_per AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.dat
            BETWEEN B.dat_von AND B.dat_bis
    LEFT JOIN dbp_etl.art_gp_nm_zu_per_fww AS C
        ON
            A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
            AND A.art_id = C.art_id AND A.dat = C.dat
    WHERE
        A.preis_abschrift_netto = 0
        AND A.preis_abschrift_netto_vj_km = 0
        AND A.werbe_abschrift_netto = 0
        AND A.werbe_abschrift_netto_vj_km = 0
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.wup_id,
        A.nb_id,
        kjmo,
        A.wrg_id,
        B.posten_id,
        A.wup_bereinigt_fg,
        A.zek_id,
        A.eigenmarke_fg,
        C.gp_id
);


-- 13.03.25, -dbay-
--
-- Ab hier die Umrechnungskurse. Zunaechst (1) werden die Landeswaehrungen verwendet,
-- um den historischen durch den aktuellen Kurs zu teilen und als historischen
-- Kursfaktor auf die EUR-Waehrung festzuschreiben. Dann (2) werden die Restanten
-- der Landeswaehrung ganz normal mit dem jeweiligen Umrechnungskurs bestueckt.

-- (1)


UPDATE dbp_etl.tag_wa_kalk_final_ro SET
    umrechnungskurs_hist = b.umrechnungskurs_hist FROM (
    SELECT
        D.mandant_id,
        A.dat,
        'EUR' AS wrg_id,
        B.umrechnungskurs / C.umrechnungskurs AS umrechnungskurs_hist
    FROM dbp_data.tag AS A
    INNER JOIN dbp_data.mandant AS D ON TRUE
    INNER JOIN
        dbp_data.kurs AS B
        ON
            D.default_wrg = B.von_wrg_id
            AND A.dat BETWEEN B.dat_von AND B.dat_bis

    INNER JOIN dbp_data.kurs AS C ON D.default_wrg = C.von_wrg_id
    WHERE
        C.dat_bis = DATE '9999-12-31'
        AND C.nach_wrg_id = 'EUR'
        AND C.kurstyp_id = 3
        AND B.nach_wrg_id = 'EUR'
        AND B.kurstyp_id = 3
        AND D.mandant_id IN (7)
        AND A.akt_mo BETWEEN -13 AND 0
    GROUP BY
        D.mandant_id,
        A.dat,
        wrg_id,
        umrechnungskurs_hist
) AS b
WHERE
    tag_wa_kalk_final_ro.mandant_id = b.mandant_id
    AND tag_wa_kalk_final_ro.dat = b.dat
    AND tag_wa_kalk_final_ro.wrg_id
    = b.wrg_id;


UPDATE dbp_etl.monat_wa_kalk_final_ro SET
    umrechnungskurs_hist = b.umrechnungskurs_hist FROM (
    SELECT
        D.mandant_id,
        A.kjmo,
        'EUR' AS wrg_id,
        B.umrechnungskurs / C.umrechnungskurs AS umrechnungskurs_hist
    FROM dbp_data.tag AS A
    INNER JOIN dbp_data.monat AS E ON A.kjmo = E.kjmo
    INNER JOIN dbp_data.mandant AS D ON TRUE
    INNER JOIN
        dbp_data.kurs AS B
        ON
            D.default_wrg = B.von_wrg_id
            AND E.min_dat BETWEEN B.dat_von AND B.dat_bis

    INNER JOIN dbp_data.kurs AS C ON D.default_wrg = C.von_wrg_id
    WHERE
        C.dat_bis = DATE '9999-12-31'
        AND C.nach_wrg_id = 'EUR'
        AND C.kurstyp_id = 3
        AND B.nach_wrg_id = 'EUR'
        AND B.kurstyp_id = 3
        AND D.mandant_id IN (7)
        AND A.akt_mo BETWEEN -13 AND 0
    GROUP BY
        D.mandant_id,
        A.kjmo,
        wrg_id,
        umrechnungskurs_hist
) AS b
WHERE
    monat_wa_kalk_final_ro.mandant_id = b.mandant_id
    AND monat_wa_kalk_final_ro.kjmo = b.kjmo
    AND monat_wa_kalk_final_ro.wrg_id = b.wrg_id;


-- (2)


UPDATE dbp_etl.tag_wa_kalk_final_ro SET
    umrechnungskurs_hist = K.umrechnungskurs
FROM dbp_data.kurs AS K
WHERE
    tag_wa_kalk_final_ro.wrg_id = K.von_wrg_id
    AND tag_wa_kalk_final_ro.dat BETWEEN K.dat_von AND K.dat_bis
    AND K.nach_wrg_id
    = 'EUR' AND K.kurstyp_id = 3 AND tag_wa_kalk_final_ro.umrechnungskurs_hist = 0;


UPDATE dbp_etl.monat_wa_kalk_final_ro SET
    umrechnungskurs_hist = K.umrechnungskurs
FROM dbp_data.monat AS X, dbp_data.kurs AS K
WHERE
    monat_wa_kalk_final_ro.wrg_id = K.von_wrg_id
    AND monat_wa_kalk_final_ro.kjmo = X.kjmo
    AND X.min_dat BETWEEN K.dat_von
    AND K.dat_bis AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3 AND monat_wa_kalk_final_ro.umrechnungskurs_hist = 0;
