--[OK] statement is translated correctly (syntax and type checks are fine)


-- Somit koennen die Werte der lager_bew_det einfach summiert werden.

-- Lt. Hr. Sarbak muss das soll_haben_kz beruecksichtigt werden, um das richtige Vorzeichen zu ermitteln.

-- Fuer Retouren nur lagerort_id 19
-- Dies erfolgt schon in der Anreicherung der lager_bew_det (s. kmo_mkpfmseg.btq)

INSERT INTO dbp_etl.art_bestand_vw_sum_rw_kmo_tmp_1 (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg,
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
    betrag_vk_netto_qual_bme,
    menge_abgang_bme, betrag_vk_netto_abgang
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
        tmp.`_gp_id` AS gp_id,
        1 AS relevant_fg,
        tmp.wrg_id,
        COALESCE(T03.menge_lgbest_erp_frei_bme, 0) AS menge_lgbest_erp_frei_bme,
        COALESCE(T03.menge_lgbest_erp_gesamt_bme, 0)
            AS menge_lgbest_erp_gesamt_bme,
        COALESCE(T03.menge_lgbest_erp_qual_bme, 0) AS menge_lgbest_erp_qual_bme,
        CASE
            WHEN T03.mandant_id IS NOT NULL
                THEN T03.betrag_vk_netto_frei_bme
            ELSE NULL
        END  AS betrag_vk_netto_frei_bme,
        CASE
            WHEN T03.mandant_id IS NOT NULL
                THEN T03.betrag_vk_netto_gesamt_bme
            ELSE NULL
        END  AS betrag_vk_netto_gesamt_bme,
        CASE
            WHEN T03.mandant_id IS NOT NULL
                THEN T03.betrag_vk_netto_qual_bme
            ELSE NULL
        END  AS betrag_vk_netto_qual_bme,
        tmp.menge_abgang_bme,
        tmp.betrag_vk_netto_abgang
    FROM (
        SELECT
            T01.mandant_id,
            W.vw_id,
            T01.nb_id,
            T02.art_id,
            T01.wup_id,
            T01.dat_buch,
            COALESCE(AGN.gp_id, -1) AS `_gp_id`,
            T02.wrg_id,
            SUM(T02.menge_lagerbew_bme) AS menge_abgang_bme,
            SUM(T02.betrag_vk_netto_vz) AS betrag_vk_netto_abgang
        FROM dbp_etl.kmo_mseg_reichweite_1 AS T01
        INNER JOIN dbp_data.wup_1 AS W
            ON
                T01.mandant_id = W.mandant_id
                AND T01.wup_id = W.wup_id
                AND T01.nb_id
                -- Nur Laeger beruecksichtigen
                = W.nb_id AND T01.nb_id = -111

        INNER JOIN dbp_data.lagerbew_det_1 AS T02
            ON
                T01.mandant_id = T02.mandant_id AND T01.dat_buch = T02.dat_buch
                -- Nur Laeger beruecksichtigen
                AND T01.wup_id = T02.wup_id
                AND T01.nb_id = T02.nb_id
                AND T01.nb_id = -111

        LEFT JOIN dbp_data.art_gp_nm_zu_per_1 AS AGN
            ON
                T01.mandant_id = AGN.mandant_id AND T02.wup_id = AGN.wup_id
                AND T02.nb_id = AGN.nb_id
                AND T02.art_id = AGN.art_id
                AND T02.dat_buch BETWEEN AGN.dat_von AND AGN.dat_bis
        /* In DE verwendeter Filter:
            WHERE TRIM(t02.lagerort_id) IN ('0', '1', '2', '3', '4', '6', '7', 'W2', 'KL0', 'KL1', 'KL2', 'KL3', 'KL4', 'KL6', 'KL7') -- Hr. Ferber 2008.09.25
            AND t02.lager_bewart_id IN ('641', '643', '645', '651', '945', 'Z46', 'Z48') */

        WHERE
            -- Logik aus View msi_view_ais_kmo.mv_lagerbew_det_1
            T02.lager_bewart_id IN ('641', '642', '647', '648')

            OR T02.lagerort_id = '0019'
            AND T02.lager_bewart_id IN ('301', '302', '311', '312')
        GROUP BY
            T01.mandant_id,
            W.vw_id,
            T01.nb_id,
            T02.art_id,
            T01.wup_id,
            T01.dat_buch,
            `_gp_id`,
            T02.wrg_id
    ) AS tmp
    LEFT JOIN
        dbp_data.art_bestand_vw_sum_1
            AS T03
        ON
            tmp.mandant_id = T03.mandant_id AND tmp.dat_buch = T03
            .dat
            AND tmp.wup_id = T03.wup_id
            AND tmp.nb_id = T03.nb_id
            AND tmp.art_id = T03.art_id
            AND tmp.`_gp_id` = T03.gp_id
            AND T03.lagerbestand_fg = 1
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.art_bestand_vw_sum_1
WHERE
    (
        mandant_id,
        dat,
        wup_id,
        nb_id,
        vw_id,
        art_id,
        bezugsweg_id,
        lagerbestand_fg,
        gp_id
    ) IN (SELECT (
        mandant_id, dat,
        wup_id, nb_id, vw_id, art_id, bezugsweg_id, lagerbestand_fg, gp_id
    )
    FROM dbp_etl.art_bestand_vw_sum_rw_kmo_tmp_1);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.art_bestand_vw_sum_1 (
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
    menge_abgang_bme, betrag_vk_netto_abgang
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
    menge_abgang_bme,
    betrag_vk_netto_abgang
FROM dbp_etl.art_bestand_vw_sum_rw_kmo_tmp_1);


--[OK] statement is translated correctly (syntax and type checks are fine)


TRUNCATE TABLE dbp_etl.kmo_mseg_reichweite_1;
