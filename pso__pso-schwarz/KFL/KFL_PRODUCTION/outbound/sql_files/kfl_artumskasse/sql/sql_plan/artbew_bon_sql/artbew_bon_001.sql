DROP TABLE IF EXISTS dbp_etl.artbew_mis;


CREATE TABLE IF NOT EXISTS dbp_etl.artbew_mis (
    mandant_id INTEGER,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER,
    wg_id INTEGER,
    arthiertyp_id INTEGER,
    bewart_id INTEGER,
    dat DATE,
    menge NUMERIC(29, 4),
    wrg STRING(3) COLLATE 'und:ci',
    umsatz_netto NUMERIC(29, 4),
    diff_umsatz_netto_konz NUMERIC(29, 4),
    umsatz_mwst_betrag NUMERIC(29, 4),
    diff_umsatz_mwst_betrag_konz NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.`_artbew_tmp` (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    gp_id INTEGER,
    einkaufsorganisation_id INTEGER,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
    ean_kasse INTEGER NOT NULL,
    herst_id INTEGER,
    wg_id INTEGER,
    mwst_id INTEGER,
    menge NUMERIC(29, 4),
    wrg STRING(3) COLLATE 'und:ci',
    umsatz_netto NUMERIC(29, 4),
    umsatz_mwst_betrag NUMERIC(29, 4),
    ek_brutto NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    logkostenzuschlag NUMERIC(29, 4),
    bezugsweg_id INTEGER,
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    posten_id STRING(2),
    bewart_det_id INTEGER NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.`_artbew_tmp_anr` (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    gp_id INTEGER,
    faktor_fg INTEGER,
    wg_id INTEGER,
    einkaufsorganisation_id INTEGER,
    dat DATE NOT NULL,
    herst_id INTEGER,
    zekp_dat_von DATE,
    ek_brutto NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    logkostenzuschlag NUMERIC(29, 4),
    bezugsweg_id INTEGER,
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4)
);


INSERT INTO dbp_etl.`_artbew_tmp` (
    art_id, wup_id, mandant_id, bewart_id, nb_id, dat, aktion_id, ean_kasse,
    mwst_id, menge, wrg, umsatz_netto, umsatz_mwst_betrag, bezugsweg_id, posten_id, bewart_det_id
)
(
    SELECT
        COALESCE(t1.art_id, ERF.art_id, 0),
        p.wup_id,
        p.mandant_id,
        p.bewart_id,
        W.nb_id,
        p.dat,
        p.aktion_id,
        COALESCE(p.ean_kasse, 0) AS ean_kasse,
        COALESCE(MW.mwst_id, MWS.mwst_id),
        SUM(p.menge) AS menge_,
        'EUR' AS wrg,
        ROUND(
            CAST(SUM(p.umsatz) - SUM(p.umsatz / (1 + COALESCE(MW.mwst, MWS.mwst) / 100) * (COALESCE(MW.mwst, MWS.mwst) / 100)) AS NUMERIC),
            4
        ) AS umsatz_netto,
        CAST(SUM(p.umsatz / (1 + COALESCE(MW.mwst, MWS.mwst) / 100) * (COALESCE(MW.mwst, MWS.mwst) / 100)) AS NUMERIC) AS umsatz_mwst_betrag, --PE-Review
        COALESCE(AW.bezugsweg_id, p.bezugsweg_id),
        COALESCE(t1.posten_id, '') AS posten_id,
        p.bewart_det_id
    FROM (SELECT
        mandant_id,
        wup_id,
        dat,
        kl_art_id,
        ean_kasse,
        wg_id,
        CAST(umsatz_brutto AS FLOAT64) AS umsatz,
        mwst_id,
        menge,
        CASE
            WHEN LTRIM(aktion_id) IN ('0', '0000000000', '')
                THEN 1001
            ELSE 1002
        END AS bewart_id,
        CASE
            WHEN LTRIM(aktion_id) IN ('0', '0000000000', '')
                THEN ''
            ELSE aktion_id
        END AS aktion_id,
        4 AS bezugsweg_id,
        CASE
            WHEN LTRIM(aktion_id) IN ('0', '0000000000', '') AND kundenkarte_id IS NULL AND kundenkarte_typ_id = 0
                THEN 100110
            ELSE CASE
                WHEN LTRIM(aktion_id) IN ('0', '0000000000', '') AND kundenkarte_typ_id IN (2) AND kundenkarte_id IS NOT NULL
                    THEN 100111
                ELSE CASE
                    WHEN
                        kundenkarte_id IS NULL AND kundenkarte_typ_id = 0 AND (
                            bonuskauf_id IS NULL OR bonuskauf_id
                            = '0'
                        ) AND LTRIM(aktion_id
                        ) NOT IN ('0', '0000000000', ''
                        ) AND aktion_id_obv IS NOT NULL
                        THEN 100210
                    ELSE CASE
                        WHEN
                            kundenkarte_typ_id IN (2) AND (bonuskauf_id IS NULL OR bonuskauf_id = '0') AND LTRIM(aktion_id
                            ) NOT IN ('0', '0000000000', '') AND kundenkarte_id IS NOT NULL AND aktion_id_obv IS NOT NULL
                            THEN 100211
                        ELSE CASE
                            WHEN
                                kundenkarte_id IS NULL AND kundenkarte_typ_id = 0 AND customer_promotion_fg = 0 AND promotion_art =
                                'COMMON' AND LTRIM(aktion_id) NOT IN ('0', '0000000000', '') AND bonuskauf_id IS NOT NULL
                                THEN 100220
                            ELSE CASE
                                WHEN
                                    kundenkarte_typ_id IN (2) AND customer_promotion_fg = 0 AND promotion_art = 'COMMON' AND LTRIM(aktion_id
                                    ) NOT IN ('0', '0000000000', '') AND bonuskauf_id IS NOT NULL AND kundenkarte_id IS NOT NULL
                                    THEN 100221
                                ELSE CASE
                                    WHEN
                                        customer_promotion_fg = 1 AND promotion_art = 'CUSTOMER' AND LTRIM(
                                            aktion_id) NOT IN (
                                            '0', '0000000000',
                                            ''
                                        ) AND bonuskauf_id IS NOT NULL
                                        THEN 100231
                                    ELSE CASE
                                        WHEN
                                            customer_promotion_fg = 1 AND promotion_art = 'PERSONAL' AND LTRIM(
                                                aktion_id) NOT IN (
                                                '0', '0000000000',
                                                ''
                                            ) AND bonuskauf_id IS NOT NULL
                                            THEN 100241
                                        ELSE 9999
                                    END
                                END
                            END
                        END
                    END
                END
            END
        END AS bewart_det_id
    FROM dbp_etl.bon_artbew_tmp_talon) AS p
    INNER JOIN dbp_data.wup AS W ON p.mandant_id = W.mandant_id AND p.wup_id = W.wup_id
    LEFT JOIN (SELECT
        mandant_id,
        art_id,
        kl_art_id,
        posten_id,
        mwst_id
    FROM dbp_data.art
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, kl_art_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1) AS t1
        ON p.kl_art_id = t1.kl_art_id AND p.mandant_id = t1.mandant_id
    LEFT JOIN dbp_etl_process.dwh_wg_erfass_artikel AS ERF
        ON
            p.mandant_id = ERF.mandant_id AND p.wg_id =
            ERF.wg_id AND ERF.arthiertyp_id = 2
    LEFT JOIN dbp_data.art AS AERF ON ERF.mandant_id = AERF.mandant_id AND ERF.art_id = AERF.art_id
    LEFT JOIN dbp_data.mwst_per AS MW
        ON
            p.mandant_id = MW.mandant_id AND p.dat BETWEEN MW.dat_von AND MW.dat_bis
            AND p.mwst_id = MW.mwst_id AND COALESCE(MW.mwst, 0) <> 0
    LEFT JOIN dbp_data.mwst_per AS MWS
        ON
            p.mandant_id = MWS.mandant_id AND p.dat BETWEEN MWS.dat_von AND
            MWS.dat_bis AND COALESCE(t1.mwst_id, AERF.mwst_id) = MWS.mwst_id
    LEFT JOIN dbp_data.art_wup_zu_per AS AW
        ON
            p.mandant_id = AW.mandant_id AND p.wup_id = AW.wup_id AND
            COALESCE(t1.art_id, ERF.art_id, 0) = AW.art_id AND p.dat BETWEEN AW.dat_von AND AW.dat_bis
    GROUP BY
        p.mandant_id,
        wrg,
        p.wup_id,
        W.nb_id,
        p.dat,
        posten_id,
        COALESCE(AW.bezugsweg_id, p.bezugsweg_id),
        COALESCE(t1.art_id, ERF.art_id, 0),
        ean_kasse,
        p.bewart_id,
        COALESCE(MW.mwst_id, MWS.mwst_id),
        p.aktion_id,
        p.bewart_det_id
    HAVING menge_ <> 0 OR SUM(p.umsatz) - umsatz_mwst_betrag <> 0
);


INSERT INTO dbp_etl.`_artbew_tmp_anr` (art_id, mandant_id, wg_id, dat, bezugsweg_id)
(
    SELECT
        A.art_id,
        A.mandant_id,
        W.wg_id,
        A.dat,
        A.bezugsweg_id
    FROM dbp_etl.`_artbew_tmp` AS A
    INNER JOIN dbp_data.art_wg_zu_per AS W
        ON
            A.mandant_id = W.mandant_id AND A.art_id = W.art_id AND W.dat_bis
            = PARSE_DATE('%F', '9999-12-31') AND W.arthiertyp_id = 2
    GROUP BY
        A.art_id,
        A.mandant_id,
        A.dat,
        A.bezugsweg_id,
        W.wg_id
);


CREATE TEMPORARY TABLE IF NOT EXISTS _xxx AS
(
    SELECT
        T2.mandant_id,
        T2.gp_id,
        T2.wup_id,
        T2.nb_id,
        T2.dat_von,
        T2.bezugsweg_id,
        T2.art_id,
        T2.einkaufsorganisation_id,
        T2.dat_bis,
        T2.ek_brutto,
        T2.ek_netto,
        T2.ek_nettonetto,
        T2.ek_kal_basis,
        T2.ek_mep,
        T2.einstandspreis,
        T2.logistikkostenzuschlag,
        T2.wrg_id,
        T2.komponentenmenge,
        T2.ek_brutto_nrfb_rab,
        T2.bonusbasis,
        T2.bezugsnebenkosten,
        T2.zollwert,
        T2.ek_netto_bnk,
        T2.ek_netto_bnk_sachk,
        T2.cycle_id,
        T2.td_insert,
        T2.td_update,
        T2.ek_mep_vor_fwu,
        T2.ek_brutto_normal
    FROM dbp_etl.`_artbew_tmp_anr` AS T1
    INNER JOIN dbp_data.art_gp_wup_zu_per AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id
            AND T1.dat BETWEEN T2.dat_von AND T2.dat_bis
    WHERE T2.wup_id = -1
    UNION DISTINCT
    SELECT
        T2.mandant_id,
        T2.gp_id,
        T2.wup_id,
        T2.nb_id,
        T2.dat_von,
        T2.bezugsweg_id,
        T2.art_id,
        T2.einkaufsorganisation_id,
        T2.dat_bis,
        T2.ek_brutto,
        T2.ek_netto,
        T2.ek_nettonetto,
        T2.ek_kal_basis,
        T2.ek_mep,
        T2.einstandspreis,
        T2.logistikkostenzuschlag,
        T2.wrg_id,
        T2.komponentenmenge,
        T2.ek_brutto_nrfb_rab,
        T2.bonusbasis,
        T2.bezugsnebenkosten,
        T2.zollwert,
        T2.ek_netto_bnk,
        T2.ek_netto_bnk_sachk,
        T2.cycle_id,
        T2.td_insert,
        T2.td_update,
        T2.ek_mep_vor_fwu,
        T2.ek_brutto_normal
    FROM dbp_etl.`_artbew_tmp_anr` AS T1
    INNER JOIN dbp_data.art_gp_wup_zu_per AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id
            AND T1.dat BETWEEN T2.dat_von AND T2.dat_bis
    WHERE
        T2.wup_id = 6906
        AND (
            T1.mandant_id, T1.wg_id) NOT IN (
            SELECT (mandant_id, wg_id)
            FROM dbp_data.wg_filter_zu
            WHERE wg_filter_id = 20
            GROUP BY mandant_id,
            wg_id
        )
)
UNION DISTINCT
SELECT
    T2.mandant_id,
    T2.gp_id,
    T2.wup_id,
    T2.nb_id,
    T2.dat_von,
    T2.bezugsweg_id,
    T2.art_id,
    T2.einkaufsorganisation_id,
    T2.dat_bis,
    T2.ek_brutto,
    T2.ek_netto,
    T2.ek_nettonetto,
    T2.ek_kal_basis,
    T2.ek_mep,
    T2.einstandspreis,
    T2.logistikkostenzuschlag,
    T2.wrg_id,
    T2.komponentenmenge,
    T2.ek_brutto_nrfb_rab,
    T2.bonusbasis,
    T2.bezugsnebenkosten,
    T2.zollwert,
    T2.ek_netto_bnk,
    T2.ek_netto_bnk_sachk,
    T2.cycle_id,
    T2.td_insert,
    T2.td_update,
    T2.ek_mep_vor_fwu,
    T2.ek_brutto_normal
FROM dbp_etl.`_artbew_tmp_anr` AS T1
INNER JOIN dbp_data.art_gp_wup_zu_per AS T2
    ON
        T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id
        AND T1.dat BETWEEN T2.dat_von AND T2.dat_bis
WHERE
    T2.wup_id = 6907
    AND (
        T1.mandant_id, T1.wg_id) IN (
        SELECT (mandant_id, wg_id)
        FROM dbp_data.wg_filter_zu
        WHERE wg_filter_id = 20
        GROUP BY mandant_id,
        wg_id
    );


UPDATE dbp_etl.`_artbew_tmp_anr` SET
    herst_id = dt1.`_herst_id`,
    gp_id = dt1.`_gp_id`,
    einkaufsorganisation_id = COALESCE(dt1.`_einkaufsorganisation_id`, 1000),
    ek_brutto = CAST(CASE
        WHEN dt1.`_ek_brutto` IS NOT NULL
            THEN CAST(dt1.`_ek_brutto` AS NUMERIC)
        ELSE NULL
    END AS NUMERIC),
    ek_netto = CAST(CASE
        WHEN dt1.`_ek_netto` IS NOT NULL
            THEN CAST(dt1.`_ek_netto` AS NUMERIC)
        ELSE NULL
    END AS NUMERIC),
    ek_nettonetto = CAST(CASE
        WHEN dt1.`_ek_nettonetto` IS NOT NULL
            THEN CAST(dt1.`_ek_nettonetto` AS NUMERIC)
        ELSE NULL
    END AS NUMERIC),
    ek_kal_basis = CAST(CASE
        WHEN dt1.`_ek_kal_basis` IS NOT NULL
            THEN CAST(dt1.`_ek_kal_basis` AS NUMERIC)
        ELSE NULL
    END AS NUMERIC),
    ek_mep = CAST(CASE
        WHEN dt1.`_ek_mep` IS NOT NULL
            THEN CAST(dt1.`_ek_mep` AS NUMERIC)
        ELSE NULL
    END AS NUMERIC),
    einstandspreis = CAST(CASE
        WHEN dt1.`_einstandspreis` IS NOT NULL
            THEN CAST(dt1.`_einstandspreis` AS NUMERIC)
        ELSE NULL
    END AS NUMERIC),
    logkostenzuschlag = CAST(CASE
        WHEN dt1.`_logkostenzuschlag` IS NOT NULL
            THEN dt1.`_logkostenzuschlag`
        ELSE NULL
    END AS NUMERIC),
    ek_netto_bnk = CAST(CASE
        WHEN dt1.`_ek_netto_bnk` IS NOT NULL
            THEN CAST(dt1.`_ek_netto_bnk` AS NUMERIC)
        ELSE NULL
    END AS NUMERIC),
    ek_netto_bnk_sachk = CAST(CASE
        WHEN dt1.`_ek_netto_bnk_sachk` IS NOT NULL
            THEN CAST(dt1.`_ek_netto_bnk_sachk` AS NUMERIC)
        ELSE NULL
    END AS NUMERIC) FROM (
    SELECT
        T1.mandant_id AS `_mandant_id`,
        T1.art_id AS `_art_id`,
        T1.bezugsweg_id AS `_bezugsweg_id`,
        T1.dat AS `_dat`,
        COALESCE(T4.herst_id, T2.gp_id, -1) AS `_herst_id`,
        COALESCE(T2.gp_id, -1) AS `_gp_id`,
        T2.einkaufsorganisation_id AS `_einkaufsorganisation_id`,
        T2.ek_brutto AS `_ek_brutto`,
        T2.ek_netto AS `_ek_netto`,
        T2.ek_nettonetto AS `_ek_nettonetto`,
        T2.ek_kal_basis AS `_ek_kal_basis`,
        T2.ek_mep AS `_ek_mep`,
        T2.einstandspreis AS `_einstandspreis`,
        T2.logistikkostenzuschlag AS `_logkostenzuschlag`,
        T2.ek_netto_bnk AS `_ek_netto_bnk`,
        T2.ek_netto_bnk_sachk AS `_ek_netto_bnk_sachk`
    FROM dbp_etl.`_artbew_tmp_anr` AS T1
    LEFT JOIN `_xxx` AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id AND T1.dat BETWEEN T2.dat_von AND
            T2.dat_bis
    LEFT JOIN dbp_data.art_gp_zu_per AS T4
        ON
            T1.mandant_id = T4.mandant_id AND T1.art_id = T4.art_id AND
            T1.dat BETWEEN T4.dat_von AND T4.dat_bis
    WHERE T1.mandant_id = 1
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY `_mandant_id`, `_art_id`, `_bezugsweg_id`, `_dat` ORDER BY CASE
        WHEN T1.bezugsweg_id = 1 AND T2.wup_id = -1 OR T1.bezugsweg_id = 4 AND T2.wup_id <> -1
            THEN 1
        ELSE 0
    END IS NULL DESC, CASE
        WHEN T1.bezugsweg_id = 1 AND T2.wup_id = -1 OR T1.bezugsweg_id = 4 AND T2.wup_id <> -1
            THEN 1
        ELSE 0
    END DESC, T2.dat_von IS NULL DESC, T2.dat_von DESC, CAST(T2.ek_brutto AS NUMERIC) IS NULL DESC, CAST(T2.ek_brutto AS NUMERIC)
    DESC, T2.gp_id IS NULL, T2.gp_id)) = 1
) AS dt1
WHERE
    `_artbew_tmp_anr`.mandant_id = dt1.`_mandant_id` AND `_artbew_tmp_anr`.art_id = dt1.`_art_id` AND `_artbew_tmp_anr`
    .bezugsweg_id = dt1.`_bezugsweg_id` AND `_artbew_tmp_anr`.dat = dt1.`_dat`;


UPDATE dbp_etl.`_artbew_tmp_anr` SET
    faktor_fg = 1,
    ek_brutto = dt1.zwge,
    ek_netto = dt1.zwge,
    ek_nettonetto = dt1.zwgm,
    ek_kal_basis = dt1.zwgm,
    ek_mep = dt1.zwgm,
    einstandspreis = dt1.zwgs,
    logkostenzuschlag = 0,
    ek_netto_bnk = dt1.zwge,
    ek_netto_bnk_sachk = dt1.zwgm FROM (
    SELECT
        T0.mandant_id AS `_mandant_id`,
        T0.art_id AS `_art_id`,
        T0.dat AS `_dat`,
        MAX(T1.ek_faktor) AS zwgs,
        MAX(COALESCE(T2.ek_faktor, T1.ek_faktor)) AS zwgm,
        MAX(COALESCE(T3.ek_faktor, T2.ek_faktor, T1.ek_faktor)) AS zwge
    FROM dbp_etl.`_artbew_tmp_anr` AS T0
    INNER JOIN dbp_data.art_man_spanne_per AS T1
        ON
            T0.mandant_id = T1.mandant_id AND T0.art_id = T1.art_id
            AND T0.dat BETWEEN T1.dat_von AND T1.dat_bis AND T1.konditionsart_id = 'ZWGS' AND T1.loesch_fg = 0
    LEFT JOIN dbp_data.art_man_spanne_per AS T2
        ON
            T0.mandant_id = T2.mandant_id AND T0.art_id = T2.art_id
            AND T0.dat BETWEEN T2.dat_von AND T2.dat_bis AND T2.konditionsart_id = 'ZWGM' AND T2.loesch_fg = 0
    LEFT JOIN dbp_data.art_man_spanne_per AS T3
        ON
            T0.mandant_id = T3.mandant_id AND T0.art_id = T3.art_id
            AND T0.dat BETWEEN T3.dat_von AND T3.dat_bis AND T3.konditionsart_id = 'ZWGE' AND T3.loesch_fg = 0
    GROUP BY
        `_mandant_id`,
        `_art_id`,
        `_dat`
) AS dt1
WHERE
    `_artbew_tmp_anr`.mandant_id = dt1.`_mandant_id` AND `_artbew_tmp_anr`.art_id = dt1.`_art_id` AND `_artbew_tmp_anr`
    .dat = dt1.`_dat`;


UPDATE dbp_etl.`_artbew_tmp` SET
    herst_id = t1.`_herst_id`,
    gp_id = t1.`_gp_id`,
    einkaufsorganisation_id = t1.`_einkaufsorganisation_id`,
    ek_brutto = CAST(COALESCE(`_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_brutto`, `_artbew_tmp`.menge * t1.`_ek_brutto`) AS NUMERIC)
    ,
    ek_netto = CAST(COALESCE(`_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_netto`, `_artbew_tmp`.menge * t1.`_ek_netto`) AS NUMERIC)
    ,
    ek_nettonetto = CAST(COALESCE(`_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_nettonetto`, `_artbew_tmp`.menge * t1.`_ek_nettonetto`) AS NUMERIC)
    ,
    ek_kal_basis = CAST(COALESCE(`_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_kal_basis`, `_artbew_tmp`.menge * t1.`_ek_kal_basis`) AS NUMERIC)
    ,
    ek_mep = CAST(COALESCE(`_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_mep`, `_artbew_tmp`.menge * t1.`_ek_mep`) AS NUMERIC)
    ,
    einstandspreis = CAST(COALESCE(`_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_einstandspreis`, `_artbew_tmp`.menge * t1.`_einstandspreis`) AS NUMERIC)
    ,
    logkostenzuschlag = CAST(COALESCE(`_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_logkostenzuschlag`, `_artbew_tmp`.menge * t1.`_logkostenzuschlag`) AS NUMERIC)
    ,
    ek_netto_bnk = CAST(COALESCE(`_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_netto_bnk`, `_artbew_tmp`.menge * t1.`_ek_netto_bnk`) AS NUMERIC)
    ,
    ek_netto_bnk_sachk = CAST(COALESCE(`_artbew_tmp`.umsatz_netto * t1.`_faktor_fg` * t1.`_ek_netto_bnk_sachk`, `_artbew_tmp`.menge * t1.`_ek_netto_bnk_sachk`) AS NUMERIC)
    ,
    wg_id = t1.`_wg_id` FROM (SELECT
    mandant_id AS `_mandant_id`,
    art_id AS `_art_id`,
    bezugsweg_id AS `_bezugsweg_id`,
    dat AS `_dat`,
    herst_id AS `_herst_id`,
    wg_id AS `_wg_id`,
    gp_id AS `_gp_id`,
    einkaufsorganisation_id AS `_einkaufsorganisation_id`,
    ek_brutto AS `_ek_brutto`,
    ek_netto AS `_ek_netto`,
    ek_nettonetto AS `_ek_nettonetto`,
    ek_kal_basis AS `_ek_kal_basis`,
    ek_mep AS `_ek_mep`,
    einstandspreis AS `_einstandspreis`,
    logkostenzuschlag AS `_logkostenzuschlag`,
    ek_netto_bnk AS `_ek_netto_bnk`,
    ek_netto_bnk_sachk AS `_ek_netto_bnk_sachk`,
    faktor_fg AS `_faktor_fg`
FROM dbp_etl.`_artbew_tmp_anr`) AS t1
WHERE
    `_artbew_tmp`.mandant_id = t1.`_mandant_id` AND `_artbew_tmp`.art_id = t1.`_art_id` AND `_artbew_tmp`.bezugsweg_id
    = t1.`_bezugsweg_id` AND `_artbew_tmp`.dat = t1.`_dat`;


UPDATE dbp_etl.`_artbew_tmp` SET
    ek_brutto = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwge AS NUMERIC),
    ek_netto = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwge AS NUMERIC),
    ek_nettonetto = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwgm AS NUMERIC),
    ek_kal_basis = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwgm AS NUMERIC),
    ek_mep = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwgm AS NUMERIC),
    einstandspreis = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwgs AS NUMERIC),
    logkostenzuschlag = 0,
    ek_netto_bnk = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwge AS NUMERIC),
    ek_netto_bnk_sachk = CAST(`_artbew_tmp`.umsatz_netto * dt1.zwgm AS NUMERIC) FROM (
    SELECT
        T0.mandant_id AS `_mandant_id`
        ,
        T0.art_id AS `_art_id`,
        T0.wup_id AS `_wup_id`,
        T0.dat AS `_dat`,
        MAX(T1.ek_faktor) AS zwgs,
        MAX(COALESCE(T2.ek_faktor, T1.ek_faktor)) AS zwgm,
        MAX(COALESCE(T3.ek_faktor, T2.ek_faktor, T1.ek_faktor)) AS zwge
    FROM dbp_etl.`_artbew_tmp` AS T0
    INNER JOIN dbp_data.art_wup_man_spanne_per AS T1
        ON
            T0.mandant_id = T1.mandant_id AND T0.art_id = T1.art_id
            AND T0.wup_id = T1.wup_id AND T0.dat BETWEEN T1.dat_von AND T1.dat_bis AND T1.konditionsart_id = 'ZWGS' AND T1.loesch_fg = 0
    LEFT JOIN dbp_data.art_wup_man_spanne_per AS T2
        ON
            T0.mandant_id = T2.mandant_id AND T0.art_id = T2.art_id
            AND T0.wup_id = T2.wup_id AND T0.dat BETWEEN T2.dat_von AND T2.dat_bis AND T2.konditionsart_id = 'ZWGM' AND T2.loesch_fg = 0
    LEFT JOIN dbp_data.art_wup_man_spanne_per AS T3
        ON
            T0.mandant_id = T3.mandant_id AND T0.art_id = T3.art_id
            AND T0.wup_id = T3.wup_id AND T0.dat BETWEEN T3.dat_von AND T3.dat_bis AND T3.konditionsart_id = 'ZWGE' AND T3.loesch_fg = 0
    GROUP BY
        `_mandant_id`,
        `_art_id`,
        `_wup_id`,
        `_dat`
) AS dt1
WHERE
    `_artbew_tmp`.mandant_id = dt1.`_mandant_id` AND `_artbew_tmp`.art_id = dt1.`_art_id` AND `_artbew_tmp`.wup_id =
    dt1.`_wup_id` AND `_artbew_tmp`.dat = dt1.`_dat`;


UPDATE dbp_etl.`_artbew_tmp` SET
    ek_brutto = `_artbew_tmp`.umsatz_netto * (
        dt1.`_ek_brutto` / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`
        )
    ), --PE-Review
    ek_netto = `_artbew_tmp`.umsatz_netto * (
        dt1.`_ek_netto` / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`
        )
    ),--PE-Review
    ek_nettonetto = `_artbew_tmp`.umsatz_netto * (dt1.`_ek_nettonetto` / IF(
        dt1.`_umsatz_netto` = 0, NULL,
        dt1.`_umsatz_netto`
    )),--PE-Review
    ek_kal_basis = `_artbew_tmp`.umsatz_netto * (dt1.`_ek_kal_basis` / IF(
        dt1.`_umsatz_netto` = 0, NULL,
        dt1.`_umsatz_netto`
    )),--PE-Review
    ek_mep = `_artbew_tmp`.umsatz_netto * (
        dt1.`_ek_mep` / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`
        )
    ),--PE-Review
    einstandspreis = `_artbew_tmp`.umsatz_netto * (dt1.`_einstandspreis` / IF(
        dt1.`_umsatz_netto` = 0,
        NULL, dt1.`_umsatz_netto`
    )),--PE-Review
    logkostenzuschlag = `_artbew_tmp`.umsatz_netto * (dt1.`_logkostenzuschlag` / IF(
        dt1.`_umsatz_netto` =
        0, NULL, dt1.`_umsatz_netto`
    )),--PE-Review
    ek_netto_bnk = `_artbew_tmp`.umsatz_netto * (dt1.`_ek_netto_bnk` / IF(
        dt1.`_umsatz_netto` = 0, NULL,
        dt1.`_umsatz_netto`
    )),--PE-Review
    ek_netto_bnk_sachk = `_artbew_tmp`.umsatz_netto * (dt1.`_ek_netto_bnk_sachk` / IF(
        dt1.`_umsatz_netto`
        = 0, NULL, dt1.`_umsatz_netto`
    )) --PE-Review
FROM (
    SELECT
        ARTBEW.wup_id AS `_wup_id`,
        SUM(ARTBEW.ek_brutto) AS `_ek_brutto`,
        SUM(ARTBEW.ek_netto) AS `_ek_netto`,
        SUM(ARTBEW.ek_nettonetto) AS `_ek_nettonetto`,
        SUM(ARTBEW.ek_kal_basis) AS `_ek_kal_basis`,
        SUM(ARTBEW.ek_mep) AS `_ek_mep`,
        SUM(ARTBEW.einstandspreis) AS `_einstandspreis`,
        SUM(ARTBEW.logkostenzuschlag) AS `_logkostenzuschlag`,
        SUM(ARTBEW.ek_netto_bnk) AS `_ek_netto_bnk`,
        SUM(ARTBEW.ek_netto_bnk_sachk) AS `_ek_netto_bnk_sachk`,
        SUM(ARTBEW.umsatz_netto) AS `_umsatz_netto`
    FROM dbp_etl.`_artbew_tmp` AS ARTBEW
    INNER JOIN dbp_data.wg_filter_zu AS WGFZ
        ON
            ARTBEW.mandant_id = WGFZ.mandant_id AND ARTBEW.wg_id =
            WGFZ.wg_id
    WHERE WGFZ.wg_filter_id = 1
    GROUP BY `_wup_id`
) AS dt1
WHERE `_artbew_tmp`.wup_id = dt1.`_wup_id` AND (`_artbew_tmp`.mandant_id, `_artbew_tmp`.wg_id) IN (SELECT (
    mandant_id,
    wg_id
)
FROM dbp_data.wg_filter_zu
WHERE wg_filter_id = 33
GROUP BY mandant_id,
wg_id);


UPDATE dbp_etl.`_artbew_tmp` SET
    ek_brutto = `_artbew_tmp`.umsatz_netto * (
        dt1.`_ek_brutto` / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`
        )
    ),--PE-Review
    ek_netto = `_artbew_tmp`.umsatz_netto * (
        dt1.`_ek_netto` / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`
        )
    ),--PE-Review
    ek_nettonetto = `_artbew_tmp`.umsatz_netto * (dt1.`_ek_nettonetto` / IF(
        dt1.`_umsatz_netto` = 0, NULL,
        dt1.`_umsatz_netto`
    )),--PE-Review
    ek_kal_basis = `_artbew_tmp`.umsatz_netto * (dt1.`_ek_kal_basis` / IF(
        dt1.`_umsatz_netto` = 0, NULL,
        dt1.`_umsatz_netto`
    )),--PE-Review
    ek_mep = `_artbew_tmp`.umsatz_netto * (
        dt1.`_ek_mep` / IF(dt1.`_umsatz_netto` = 0, NULL, dt1.`_umsatz_netto`
        )
    ),--PE-Review
    einstandspreis = `_artbew_tmp`.umsatz_netto * (dt1.`_einstandspreis` / IF(
        dt1.`_umsatz_netto` = 0,
        NULL, dt1.`_umsatz_netto`
    )),--PE-Review
    logkostenzuschlag = `_artbew_tmp`.umsatz_netto * (dt1.`_logkostenzuschlag` / IF(
        dt1.`_umsatz_netto` =
        0, NULL, dt1.`_umsatz_netto`
    )),--PE-Review
    ek_netto_bnk = `_artbew_tmp`.umsatz_netto * (dt1.`_ek_netto_bnk` / IF(
        dt1.`_umsatz_netto` = 0, NULL,
        dt1.`_umsatz_netto`
    )),--PE-Review
    ek_netto_bnk_sachk = `_artbew_tmp`.umsatz_netto * (dt1.`_ek_netto_bnk_sachk` / IF(
        dt1.`_umsatz_netto`
        = 0, NULL, dt1.`_umsatz_netto`
    )) --PE-Review
FROM (
    SELECT
        ARTBEW.wup_id AS `_wup_id`,
        SUM(ARTBEW.ek_brutto) AS `_ek_brutto`,
        SUM(ARTBEW.ek_netto) AS `_ek_netto`,
        SUM(ARTBEW.ek_nettonetto) AS `_ek_nettonetto`,
        SUM(ARTBEW.ek_kal_basis) AS `_ek_kal_basis`,
        SUM(ARTBEW.ek_mep) AS `_ek_mep`,
        SUM(ARTBEW.einstandspreis) AS `_einstandspreis`,
        SUM(ARTBEW.logkostenzuschlag) AS `_logkostenzuschlag`,
        SUM(ARTBEW.ek_netto_bnk) AS `_ek_netto_bnk`,
        SUM(ARTBEW.ek_netto_bnk_sachk) AS `_ek_netto_bnk_sachk`,
        SUM(ARTBEW.umsatz_netto) AS `_umsatz_netto`
    FROM dbp_etl.`_artbew_tmp` AS ARTBEW
    INNER JOIN dbp_data.wg_filter_zu AS WGFZ
        ON
            ARTBEW.mandant_id = WGFZ.mandant_id AND ARTBEW.wg_id =
            WGFZ.wg_id
    WHERE WGFZ.wg_filter_id = 32
    GROUP BY `_wup_id`
) AS dt1
WHERE `_artbew_tmp`.wup_id = dt1.`_wup_id` AND (`_artbew_tmp`.mandant_id, `_artbew_tmp`.wg_id) IN (SELECT (
    mandant_id,
    wg_id
)
FROM dbp_data.wg_filter_zu
WHERE wg_filter_id = 34
GROUP BY mandant_id,
wg_id);


DELETE FROM dbp_data.artbew AS A
WHERE mandant_id = 1 AND dat IN (
    SELECT dat
    FROM dbp_etl.bon_artbew_dat) AND (mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.`_artbew_tmp`
) AND bewart_id <> 1010;


DELETE FROM dbp_data.artbew_dra AS D
WHERE mandant_id = 1 AND dat IN (
    SELECT dat
    FROM dbp_etl.bon_artbew_dat) AND (mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.`_artbew_tmp`
);


INSERT INTO dbp_data.artbew_dra (
    wup_id, mandant_id, bewart_id, gp_id, nb_id, art_id, dat, aktion_id,
    ean_kasse, menge, wrg, umsatz_netto, umsatz_mwst_betrag
)
(SELECT
    wup_id,
    mandant_id,
    bewart_id,
    gp_id,
    nb_id,
    art_id,
    dat,
    aktion_id,
    ean_kasse,
    menge_,
    wrg,
    umsatz_netto_,
    umsatz_mwst_betrag_
FROM (
    SELECT
        A.wup_id,
        A.mandant_id,
        A.bewart_id,
        COALESCE(A.gp_id, -1) AS gp_id,
        A.nb_id,
        A.art_id,
        A.ean_kasse,
        A.dat,
        A.aktion_id,
        A.wrg,
        SUM(A.menge) AS menge_,
        SUM(A.umsatz_netto) AS umsatz_netto_,
        SUM(A.umsatz_mwst_betrag) AS umsatz_mwst_betrag_
    FROM dbp_etl.`_artbew_tmp` AS A
    INNER JOIN dbp_data.art_wg_zu_per AS W ON A.mandant_id = W.mandant_id AND A.art_id = W.art_id
    INNER JOIN dbp_data.wg_filter_zu AS WGFZ ON W.mandant_id = WGFZ.mandant_id AND W.arthiertyp_id = WGFZ.arthiertyp_id AND W.wg_id = WGFZ.wg_id
    WHERE
        W.arthiertyp_id = 2
        AND W.dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND WGFZ.wg_filter_id = 9
    GROUP BY
        A.wup_id,
        A.mandant_id,
        A.bewart_id,
        gp_id,
        A.nb_id,
        A.art_id,
        A.ean_kasse,
        A.dat,
        A.aktion_id,
        A.wrg
) AS a);


DELETE FROM dbp_etl.`_artbew_tmp`
WHERE (
    mandant_id, art_id) IN (
    SELECT (AWZP.mandant_id, AWZP.art_id)
    FROM dbp_data.art_wg_zu_per AS AWZP
    INNER JOIN dbp_data.wg_filter_zu AS WGFZ
        ON
            AWZP.mandant_id = WGFZ.mandant_id AND AWZP.arthiertyp_id =
            WGFZ.arthiertyp_id AND AWZP.wg_id = WGFZ.wg_id
    WHERE
        AWZP.arthiertyp_id = 2
        AND AWZP.dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND WGFZ.wg_filter_id = 9
    GROUP BY AWZP.mandant_id,
    AWZP.art_id
);


INSERT INTO dbp_data.artbew (
    mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id,
    promo_fg, ean_kasse, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg, umsatz_netto, umsatz_mwst_betrag,
    ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis, logkostenzuschlag, bezugsweg_id, ek_netto_bnk,
    ek_netto_bnk_sachk, posten_id, bewart_det_id
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        bewart_id,
        COALESCE(gp_id, -1) AS gp_id,
        art_id,
        aktion_id,
        CASE
            WHEN bewart_det_id IN (100220, 100221, 100231, 100241)
                THEN 1
            ELSE 0
        END AS promo_fg,
        ean_kasse,
        COALESCE(einkaufsorganisation_id, 1000) AS einkaufsorganisation_id,
        COALESCE(herst_id, -1) AS herst_id,
        mwst_id,
        SUM(menge) AS menge_,
        wrg,
        SUM(umsatz_netto) AS umsatz_netto_,
        SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_,
        COALESCE(SUM(ek_brutto), 0) AS ek_brutto_,
        COALESCE(SUM(ek_netto), 0) AS ek_netto_,
        COALESCE(SUM(ek_nettonetto), 0) AS ek_nettonetto_,
        COALESCE(SUM(ek_kal_basis), 0) AS ek_kal_basis_,
        COALESCE(SUM(ek_mep), 0) AS ek_mep_,
        COALESCE(SUM(einstandspreis), 0) AS einstandspreis_,
        COALESCE(SUM(logkostenzuschlag), 0) AS logkostenzuschlag_,
        bezugsweg_id,
        COALESCE(SUM(ek_netto_bnk), 0) AS ek_netto_bnk_,
        COALESCE(SUM(ek_netto_bnk_sachk), 0) AS ek_netto_bnk_sachk_,
        posten_id,
        bewart_det_id
    FROM dbp_etl.`_artbew_tmp`
    GROUP BY
        art_id,
        wup_id,
        mandant_id,
        bewart_id,
        gp_id,
        einkaufsorganisation_id,
        nb_id,
        dat,
        aktion_id,
        ean_kasse,
        herst_id,
        mwst_id,
        wrg,
        bezugsweg_id,
        posten_id,
        bewart_det_id
);


UPDATE dbp_ods.ods_talon_det SET
    artbew_fg = 1
WHERE (
    mandant_id, wup_id, talon_id) IN (
    SELECT (mandant_id, wup_id, CAST(talon_id AS NUMERIC))
    FROM dbp_etl.bon_artbew_tmp_talon
);


UPDATE dbp_ods.ods_talon_det SET
    artbew_fg = 1
WHERE (
    mandant_id, wup_id, talon_id) IN (
    SELECT (mandant_id, wup_id, CAST(talon_id AS NUMERIC))
    FROM dbp_etl.bon_talon_fix
);


DELETE FROM dbp_data.artbew_coupon_zu
WHERE (
    mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.artbew_coupon_zu_tmp
);


INSERT INTO dbp_data.artbew_coupon_zu (
    wup_id, nb_id, mandant_id, art_id, dat, coupon_kz, coupon_menge,
    betrag_coupon_netto, betrag_coupon_mwst
)
(SELECT
    wup_id,
    nb_id,
    mandant_id,
    art_id,
    dat,
    coupon_kz,
    coupon_menge,
    betrag_coupon_netto,
    betrag_coupon_mwst
FROM dbp_etl.artbew_coupon_zu_tmp);
