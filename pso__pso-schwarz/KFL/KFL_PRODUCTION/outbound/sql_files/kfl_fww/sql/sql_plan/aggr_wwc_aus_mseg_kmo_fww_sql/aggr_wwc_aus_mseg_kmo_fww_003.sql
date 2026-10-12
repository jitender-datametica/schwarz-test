DROP TABLE IF EXISTS dbp_etl.kmo_mseg_dat_wwc_woche;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mseg_dat_wwc_woche (
    dat_buch DATE NOT NULL,
    mandant_id INTEGER NOT NULL,
    kjwo_kl INTEGER NOT NULL
);


INSERT INTO dbp_etl.kmo_mseg_dat_wwc_woche (dat_buch, mandant_id, kjwo_kl)
(
    SELECT
        WO.dat,
        WWC.mandant_id,
        WO.kjwo_kl
    FROM dbp_etl.kmo_mseg_dat_wwc AS WWC
    INNER JOIN dbp_data.tag AS TAG ON WWC.dat_buch = TAG.dat
    INNER JOIN dbp_data.tag AS WO ON TAG.kjwo_kl = WO.kjwo_kl
    GROUP BY
        WWC.mandant_id,
        WO.dat,
        WO.kjwo_kl
);


DROP TABLE IF EXISTS dbp_etl.lagerbew_wwc_tmp_woche;


CREATE TABLE IF NOT EXISTS dbp_etl.lagerbew_wwc_tmp_woche (
    mandant_id INTEGER NOT NULL,
    lagerbew_beleg_id INTEGER NOT NULL,
    lagerbew_beleg_pos_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL,
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_buch DATE NOT NULL,
    betrag_lagerbew NUMERIC(29, 4),
    betrag_verkauf NUMERIC(29, 2),
    menge_lagerbew_bme NUMERIC(29, 3) NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
    betrag_vk_netto NUMERIC(29, 4),
    betrag_verkauf_ist NUMERIC(29, 4),
    betrag_verkauf_ist_netto NUMERIC(29, 4),
    betrag_exbwr NUMERIC(29, 4),
    kjwo_kl INTEGER,
    exvkw_gleich_vkwrt_fg INTEGER NOT NULL
);


INSERT INTO dbp_etl.lagerbew_wwc_tmp_woche (
    mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, wup_id,
    nb_id,
    lager_bewart_id,
    art_id,
    gp_id,
    dat_buch,
    betrag_lagerbew,
    betrag_verkauf,
    menge_lagerbew_bme,
    wrg_id,
    betrag_vk_netto,
    betrag_verkauf_ist,
    betrag_verkauf_ist_netto,
    betrag_exbwr,
    kjwo_kl,
    exvkw_gleich_vkwrt_fg
)
(
    SELECT
        t1.mandant_id,
        t1.lagerbew_beleg_id,
        t1.lagerbew_beleg_pos_id,
        t1.wup_id,
        t1.nb_id,
        t1.lager_bewart_id,
        t1.art_id,
        t1.gp_id,
        t1.dat_buch,
        t1.betrag_lagerbew,
        t1.betrag_verkauf,
        t1.menge_lagerbew_bme,
        t1.wrg_id,
        t1.betrag_vk_netto,
        t1.betrag_verkauf_ist,
        t1.betrag_verkauf_ist_netto,
        WWC.betrag_exbwr,
        t1.kjwo_kl,
        t1.exvkw_gleich_vkwrt_fg
    FROM (
        SELECT
            DT.mandant_id,
            DT.lagerbew_beleg_id,
            DT.lagerbew_beleg_pos_id,
            DT.wup_id,
            DT.nb_id,
            DT.lager_bewart_id,
            DT.art_id,
            DT.gp_id,
            DT.dat_buch,
            DT.betrag_lagerbew,
            DT.betrag_verkauf,
            DT.menge_lagerbew_bme,
            DT.wrg_id,
            DT.betrag_vk_netto,
            DT.betrag_verkauf_ist,
            DT.betrag_verkauf_ist_netto,
            WO.kjwo_kl,
            CASE
                WHEN DT.betrag_verkauf_ist = DT.betrag_verkauf
                    THEN 1
                ELSE 0
            END AS exvkw_gleich_vkwrt_fg
        FROM dbp_data.lagerbew_det AS DT
        INNER JOIN
            dbp_etl.kmo_mseg_dat_wwc_woche
                AS WO
            ON
                DT.mandant_id = WO.mandant_id AND DT.dat_buch = WO
                .dat_buch
    ) AS t1
    INNER JOIN
        dbp_data.lagerbew_det_wwc
            AS WWC
        ON
            t1.mandant_id = WWC.mandant_id AND t1.lagerbew_beleg_id
            = WWC.lagerbew_beleg_id
            AND t1.lagerbew_beleg_pos_id = WWC.lagerbew_beleg_pos_id
            AND t1.dat_buch = WWC.dat_buch
);


DELETE FROM dbp_data.lagerbew_det_wwc_woche
WHERE (
    mandant_id, kjwo_kl) IN (
    SELECT (mandant_id, kjwo_kl)
    FROM dbp_etl.kmo_mseg_dat_wwc_woche
);


INSERT INTO dbp_data.lagerbew_det_wwc_woche (
    art_id, mandant_id, wup_id, nb_id, lager_bewart_id, gp_id,
    kjwo_kl,
    exvkw_gleich_vkwrt_fg,
    betrag_lagerbew,
    betrag_verkauf,
    menge_lagerbew_bme,
    betrag_vk_netto,
    betrag_verkauf_ist, betrag_exbwr, betrag_verkauf_ist_netto, wrg_id
)
(
    SELECT
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        lager_bewart_id,
        gp_id,
        kjwo_kl,
        exvkw_gleich_vkwrt_fg,
        SUM(ROUND(CAST(betrag_lagerbew AS NUMERIC), 2)) AS betrag_lagerbew,
        SUM(betrag_verkauf) AS betrag_verkauf,
        SUM(menge_lagerbew_bme) AS menge_lagerbew_bme,
        SUM(betrag_vk_netto) AS betrag_vk_netto,
        SUM(betrag_verkauf_ist) AS betrag_verkauf_ist,
        SUM(betrag_exbwr) AS betrag_exbwr,
        SUM(betrag_verkauf_ist_netto) AS betrag_verkauf_ist_netto,
        wrg_id
    FROM dbp_etl.lagerbew_wwc_tmp_woche AS D
    WHERE kjwo_kl >= 201001
    GROUP BY
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        lager_bewart_id,
        gp_id,
        kjwo_kl,
        wrg_id,
        exvkw_gleich_vkwrt_fg
);


DROP TABLE IF EXISTS dbp_etl.lagerbew_wwc_tmp_monat;


CREATE TABLE IF NOT EXISTS dbp_etl.lagerbew_wwc_tmp_monat (
    mandant_id INTEGER NOT NULL,
    lagerbew_beleg_id INTEGER NOT NULL,
    lagerbew_beleg_pos_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL,
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_buch DATE NOT NULL,
    betrag_lagerbew NUMERIC(29, 4),
    betrag_verkauf NUMERIC(29, 2),
    menge_lagerbew_bme NUMERIC(29, 3) NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
    betrag_vk_netto NUMERIC(29, 4),
    betrag_verkauf_ist NUMERIC(29, 4),
    betrag_verkauf_ist_netto NUMERIC(29, 4),
    betrag_exbwr NUMERIC(29, 4),
    kjmo INTEGER,
    exvkw_gleich_vkwrt_fg INTEGER NOT NULL
);


INSERT INTO dbp_etl.lagerbew_wwc_tmp_monat (
    mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, wup_id,
    nb_id,
    lager_bewart_id,
    art_id,
    gp_id,
    dat_buch,
    betrag_lagerbew,
    betrag_verkauf,
    menge_lagerbew_bme,
    wrg_id,
    betrag_vk_netto,
    betrag_verkauf_ist,
    betrag_verkauf_ist_netto,
    betrag_exbwr,
    kjmo,
    exvkw_gleich_vkwrt_fg
)
(
    SELECT
        t1.mandant_id,
        t1.lagerbew_beleg_id,
        t1.lagerbew_beleg_pos_id,
        t1.wup_id,
        t1.nb_id,
        t1.lager_bewart_id,
        t1.art_id,
        t1.gp_id,
        t1.dat_buch,
        t1.betrag_lagerbew,
        t1.betrag_verkauf,
        t1.menge_lagerbew_bme,
        t1.wrg_id,
        t1.betrag_vk_netto,
        t1.betrag_verkauf_ist,
        t1.betrag_verkauf_ist_netto,
        WWC.betrag_exbwr,
        t1.kjmo,
        t1.exvkw_gleich_vkwrt_fg
    FROM (
        SELECT
            DT.mandant_id,
            DT.lagerbew_beleg_id,
            DT.lagerbew_beleg_pos_id,
            DT.wup_id,
            DT.nb_id,
            DT.lager_bewart_id,
            DT.art_id,
            DT.gp_id,
            DT.dat_buch,
            DT.betrag_lagerbew,
            DT.betrag_verkauf,
            DT.menge_lagerbew_bme,
            DT.wrg_id,
            DT.betrag_vk_netto,
            DT.betrag_verkauf_ist,
            DT.betrag_verkauf_ist_netto,
            mo.kjmo,
            CASE
                WHEN DT.betrag_verkauf_ist = DT.betrag_verkauf
                    THEN 1
                ELSE 0
            END AS exvkw_gleich_vkwrt_fg
        FROM dbp_data.lagerbew_det AS DT
        INNER JOIN (
            SELECT
                x.mandant_id,
                Y.dat AS dat_buch,
                x.kjmo
            FROM (
                SELECT
                    mandant_id,
                    kjmo
                FROM dbp_etl.kmo_mseg_dat_wwc
                GROUP BY
                    mandant_id,
                    kjmo
            ) AS x
            INNER JOIN dbp_data.tag AS Y ON x.kjmo = Y.kjmo
        ) AS mo
            ON
                DT.dat_buch = mo.dat_buch AND DT.mandant_id
                = mo.mandant_id
    ) AS t1
    INNER JOIN
        dbp_data.lagerbew_det_wwc
            AS WWC
        ON
            t1.mandant_id = WWC.mandant_id AND t1.lagerbew_beleg_id
            = WWC.lagerbew_beleg_id
            AND t1.lagerbew_beleg_pos_id = WWC.lagerbew_beleg_pos_id
            AND t1.dat_buch = WWC.dat_buch
);


DELETE FROM dbp_data.lagerbew_det_wwc_monat
WHERE (
    mandant_id, kjmo) IN (
    SELECT (mandant_id, kjmo)
    FROM dbp_etl.kmo_mseg_dat_wwc
);


INSERT INTO dbp_data.lagerbew_det_wwc_monat (
    art_id, mandant_id, wup_id, nb_id, lager_bewart_id, gp_id,
    kjmo,
    exvkw_gleich_vkwrt_fg,
    betrag_lagerbew,
    betrag_verkauf,
    menge_lagerbew_bme,
    betrag_vk_netto,
    betrag_verkauf_ist,
    betrag_exbwr, betrag_verkauf_ist_netto, wrg_id
)
(
    SELECT
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        lager_bewart_id,
        gp_id,
        kjmo,
        exvkw_gleich_vkwrt_fg,
        SUM(ROUND(CAST(betrag_lagerbew AS NUMERIC), 2)) AS betrag_lagerbew,
        SUM(betrag_verkauf) AS betrag_verkauf,
        SUM(menge_lagerbew_bme) AS menge_lagerbew_bme,
        SUM(betrag_vk_netto) AS betrag_vk_netto,
        SUM(betrag_verkauf_ist) AS betrag_verkauf_ist,
        SUM(betrag_exbwr) AS betrag_exbwr,
        SUM(betrag_verkauf_ist_netto) AS betrag_verkauf_ist_netto,
        wrg_id
    FROM dbp_etl.lagerbew_wwc_tmp_monat AS D
    WHERE kjmo >= 201001
    GROUP BY
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        lager_bewart_id,
        gp_id,
        kjmo,
        wrg_id,
        exvkw_gleich_vkwrt_fg
);


DROP TABLE IF EXISTS dbp_etl.kmo_mseg_dat_wwc;
