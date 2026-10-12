--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_rw_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.art_bestand_vw_sum_rw_tmp (
    mandant_id INTEGER NOT NULL,
    vw_id INTEGER NOT NULL,
    bezugsweg_id INTEGER NOT NULL,
    lagerbestand_fg INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    gp_id INTEGER NOT NULL,
    relevant_fg INTEGER NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_gesamt_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_qual_bme NUMERIC(29, 3) NOT NULL,
    betrag_vk_netto_frei_bme NUMERIC(29, 4),
    betrag_vk_netto_gesamt_bme NUMERIC(29, 4),
    betrag_vk_netto_qual_bme NUMERIC(29, 4),
    menge_abgang_bme NUMERIC(29, 3)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


-- Hr. Ferber 2008.09.25
INSERT INTO dbp_etl.art_bestand_vw_sum_rw_tmp (
    mandant_id, vw_id, bezugsweg_id,
    lagerbestand_fg,
    nb_id,
    art_id,
    wup_id,
    dat,
    gp_id,
    relevant_fg,
    wrg_id,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_gesamt_bme,
    menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme,
    betrag_vk_netto_gesamt_bme,
    betrag_vk_netto_qual_bme, menge_abgang_bme
)
(
    SELECT
        tmp.mandant_id,
        tmp.vw_id,
        4 AS bezugsweg_id,
        1 AS lagerbestand_fg,
        tmp.nb_id,
        tmp.art_id,
        tmp.wup_id,
        tmp.dat_buch,
        tmp.gp_id,
        1 AS relevant_fg,
        tmp.wrg_id,
        COALESCE(T03.menge_lgbest_erp_frei_bme, 0) AS menge_lgbest_erp_frei_bme,
        COALESCE(T03.menge_lgbest_erp_gesamt_bme, 0)
            AS menge_lgbest_erp_gesamt_bme,
        COALESCE(T03.menge_lgbest_erp_qual_bme, 0) AS menge_lgbest_erp_qual_bme,
        CAST(CASE
            WHEN T03.mandant_id IS NOT NULL
                THEN T03.betrag_vk_netto_frei_bme
            ELSE NULL
        END AS NUMERIC) AS betrag_vk_netto_frei_bme,
        CAST(CASE
            WHEN T03.mandant_id IS NOT NULL
                THEN T03.betrag_vk_netto_gesamt_bme
            ELSE NULL
        END AS NUMERIC) AS betrag_vk_netto_gesamt_bme,
        CAST(CASE
            WHEN T03.mandant_id IS NOT NULL
                THEN T03.betrag_vk_netto_qual_bme
            ELSE NULL
        END AS NUMERIC) AS betrag_vk_netto_qual_bme,
        CAST(tmp.menge_abgang_bme AS NUMERIC) AS menge_abgang_bme
    FROM (
        SELECT
            T01.mandant_id,
            W.vw_id,
            T01.nb_id,
            T02.art_id,
            T01.wup_id,
            T01.dat_buch,
            ag.gp_id,
            T02.wrg_id,
            SUM(T02.menge_lagerbew_bme * -1) AS menge_abgang_bme
        FROM dbp_etl.mseg_reichweite AS T01
        INNER JOIN dbp_data.wup AS W
            ON
                T01.mandant_id = W.mandant_id
                AND T01.wup_id = W.wup_id
                AND T01.nb_id
                = W.nb_id
        INNER JOIN dbp_data.lagerbew_det AS T02
            ON
                T01.mandant_id = T02.mandant_id AND T01.dat_buch = T02.dat_buch
                AND T01.wup_id = T02.wup_id AND T01.nb_id = T02.nb_id
        INNER JOIN (
            SELECT
                AG.mandant_id,
                AG.art_id,
                AG.gp_id,
                AG.dat_von,
                AG.dat_bis
            FROM dbp_data.art_gp_zu_per AS AG
            INNER JOIN (SELECT
                mandant_id,
                gp_id,
                einkaufsorganisation_id
            FROM dbp_data.gp
            QUALIFY (ROW_NUMBER() OVER (
                PARTITION BY
                    mandant_id, gp_id ORDER BY
                    einkaufsorganisation_id IS NULL,
                    einkaufsorganisation_id
            )) = 1) AS t0
                ON
                    AG.gp_id = t0.gp_id
                    AND AG.einkaufsorganisation_id
                    = t0.einkaufsorganisation_id
                    AND AG.mandant_id = t0.mandant_id
        ) AS ag
            ON
                T02.art_id = ag.art_id
                AND T02.mandant_id = ag.mandant_id
                AND T02
                .dat_buch BETWEEN ag.dat_von AND ag.dat_bis
        WHERE
            TRIM(T02.lagerort_id) IN (
                '0',
                '1',
                '2',
                '3',
                '4',
                '6',
                '7',
                'W2',
                'KL0',
                'KL1',
                'KL2',
                'KL3',
                'KL4',
                'KL6',
                'KL7'
            )
            AND T02.lager_bewart_id IN (
                '641', '643', '645', '651', '945', 'Z46', 'Z48'
            )
        GROUP BY
            T01.mandant_id,
            W.vw_id,
            T01.nb_id,
            T02.art_id,
            T01.wup_id,
            T01.dat_buch,
            ag.gp_id,
            T02.wrg_id
    ) AS tmp
    LEFT JOIN
        dbp_data.art_bestand_vw_sum
            AS T03
        ON
            tmp.mandant_id = T03.mandant_id AND tmp.dat_buch = T03
            .dat
            AND tmp.wup_id = T03.wup_id
            AND tmp.nb_id = T03.nb_id
            AND tmp.art_id = T03.art_id
            AND tmp.gp_id = T03.gp_id
            AND T03.lagerbestand_fg = 1
);


DELETE FROM dbp_data.art_bestand_vw_sum
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.art_bestand_vw_sum_rw_tmp
    WHERE
        art_bestand_vw_sum.mandant_id = mandant_id
        AND art_bestand_vw_sum.dat = dat
        AND art_bestand_vw_sum.wup_id = wup_id
        AND art_bestand_vw_sum.nb_id = nb_id
        AND art_bestand_vw_sum.vw_id = vw_id
        AND art_bestand_vw_sum.art_id = art_id
        AND art_bestand_vw_sum.bezugsweg_id = bezugsweg_id
        AND art_bestand_vw_sum.relevant_fg = relevant_fg
        AND art_bestand_vw_sum.lagerbestand_fg = lagerbestand_fg
        AND art_bestand_vw_sum.gp_id = gp_id
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.art_bestand_vw_sum (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id, art_id,
    wup_id,
    dat,
    gp_id,
    relevant_fg,
    wrg_id,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesamt_bme,
    betrag_vk_netto_frei_bme,
    betrag_vk_netto_qual_bme,
    betrag_vk_netto_gesamt_bme,
    menge_abgang_bme
)
(SELECT
    mandant_id,
    vw_id,
    bezugsweg_id,
    lagerbestand_fg,
    nb_id,
    art_id,
    wup_id,
    dat,
    gp_id,
    relevant_fg,
    wrg_id,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesamt_bme,
    betrag_vk_netto_frei_bme,
    betrag_vk_netto_qual_bme,
    betrag_vk_netto_gesamt_bme,
    menge_abgang_bme
FROM dbp_etl.art_bestand_vw_sum_rw_tmp);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_rw_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)


TRUNCATE TABLE dbp_etl.mseg_reichweite;
