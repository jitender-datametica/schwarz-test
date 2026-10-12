-- Marktbestaende

-- 11.11.2025, -dba-
--
-- Unplausible Buchungen ueber '343','344' (vornehmlich in RO)
-- werden hier durchs Setzen des Auto-Flags auf '1' respektive
-- '2' das Abgreifen durch die Bewegungsartenlogik unterbunden.


CREATE OR REPLACE TEMPORARY TABLE _fix_implausible_amounts AS
SELECT
    mandant_id,
    dat_buch,
    art_id,
    wup_id,
    SUM(menge_lagerbew_bme) AS menge_frei
FROM dbp_data.lagerbew_det_2
WHERE
    mandant_id > 1
    AND dat_buch >= DATE '2025-10-01'
    AND (menge_lagerbew_bme > 99999 OR menge_lagerbew_bme < -99999)
    AND lager_bewart_id IN ('343', '344')
    AND (
        mandant_id, wup_id) NOT IN (
        SELECT (mandant_id, wup_id)
        FROM dbp_data.wup_2
        WHERE nb_id = -111
    )
    AND auto_fg NOT IN ('Y', '1', '2')
GROUP BY
    mandant_id,
    art_id,
    wup_id,
    dat_buch
HAVING menge_frei = 0;


UPDATE dbp_data.lagerbew_det_2 SET
    auto_fg = CASE
        WHEN lagerbew_det.auto_fg = 'X'
            THEN '1'
        ELSE '2'
    END
FROM `_fix_implausible_amounts` AS b
WHERE
    lagerbew_det.mandant_id = b.mandant_id AND lagerbew_det.wup_id = b.wup_id AND lagerbew_det.art_id = b.art_id AND
    lagerbew_det.dat_buch = b.dat_buch AND lagerbew_det.lager_bewart_id IN ('343', '344');


CREATE OR REPLACE TEMPORARY TABLE _tracker AS
SELECT
    mandant_id,
    wup_id
FROM dbp_data.wup_2 AS V01
WHERE (
    (dat_eroeffnung < CURRENT_DATE("Europe/Berlin") OR dat_eroeffnung < DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 45 DAY)) AND dat_von
    IS NOT NULL OR nb_id <> 0 OR wup_id = 9203
)
AND nb_id <> 99
AND NOT wup_id BETWEEN 1 AND 999;


DELETE FROM dbp_data.marktbestand_erp_2
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_wg_zu_per_2
    WHERE
        arthiertyp_id = 2
        AND dat_bis = DATE '9999-12-31'
        AND wg_id = 961
);


CREATE OR REPLACE TEMPORARY TABLE _dat (
    dat DATE
);


CREATE OR REPLACE TEMPORARY TABLE _dat_min (
    dat DATE
);


CREATE OR REPLACE TEMPORARY TABLE _vol_art_gp_wup_zu_per (
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


INSERT INTO `_dat` (dat)
(
    SELECT dat
    FROM dbp_data.tag_2
    WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 5 DAY) AND (CURRENT_DATE("Europe/Berlin"))
    GROUP BY dat
);


INSERT INTO `_dat_min` (dat)
(
    SELECT MIN(dat)
    FROM dbp_data.tag_2
    WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 5 DAY) AND (CURRENT_DATE("Europe/Berlin"))
    HAVING MIN(dat) IS NOT NULL
);


INSERT INTO `_vol_art_gp_wup_zu_per` (
    mandant_id, art_id, gp_id, wup_id, nb_id, einkaufsorganisation_id, dat, ek_brutto,
    ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis, logistikkostenzuschlag, ek_netto_bnk,
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
        CAST(a.ek_brutto AS NUMERIC) AS ek_brutto,
        CAST(a.ek_netto AS NUMERIC) AS ek_netto,
        CAST(a.ek_nettonetto AS NUMERIC) AS ek_nettonetto,
        CAST(a.ek_kal_basis AS NUMERIC) AS ek_kal_basis,
        CAST(a.ek_mep AS NUMERIC) AS ek_mep,
        CAST(a.einstandspreis AS NUMERIC) AS einstandspreis,
        CAST(a.logistikkostenzuschlag AS NUMERIC) AS logistikkostenzuschlag,
        CAST(a.ek_netto_bnk AS NUMERIC) AS ek_netto_bnk,
        CAST(a.ek_netto_bnk_sachk AS NUMERIC) AS ek_netto_bnk_sachk
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
            CAST(A.ek_brutto AS NUMERIC) * COALESCE(A.komponentenmenge, 1) AS ek_brutto,
            CAST(A.ek_netto AS NUMERIC) * COALESCE(A.komponentenmenge, 1) AS ek_netto,
            CAST(A.ek_nettonetto AS NUMERIC) * COALESCE(A.komponentenmenge, 1) AS ek_nettonetto,
            CAST(A.ek_kal_basis AS NUMERIC) * COALESCE(A.komponentenmenge, 1) AS ek_kal_basis,
            CAST(A.ek_mep AS NUMERIC) * COALESCE(A.komponentenmenge, 1) AS ek_mep,
            CAST(A.einstandspreis AS NUMERIC) * COALESCE(A.komponentenmenge, 1) AS einstandspreis,
            A.logistikkostenzuschlag * COALESCE(A.komponentenmenge, 1) AS logistikkostenzuschlag,
            CAST(A.ek_netto_bnk AS NUMERIC) * COALESCE(A.komponentenmenge, 1) AS ek_netto_bnk,
            CAST(A.ek_netto_bnk_sachk AS NUMERIC) * COALESCE(A.komponentenmenge, 1) AS ek_netto_bnk_sachk
        FROM dbp_data.art_gp_wup_zu_per_2 AS A
        INNER JOIN `_dat_min` AS M ON A.dat_bis >= M.dat
    ) AS a
    INNER JOIN `_dat` AS D ON D.dat BETWEEN a.dat_von AND a.dat_bis
);


CREATE OR REPLACE TEMPORARY TABLE _marktbestand_erp_step01 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    gp_id INTEGER NOT NULL,
    bezugsweg_id INTEGER NOT NULL,
    relevant_fg INTEGER NOT NULL,
    posten_id STRING(2),
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesp_bme NUMERIC(29, 3),
    wrg_id STRING(3) NOT NULL,
    vk_netto NUMERIC(29, 4),
    betrag_vk_netto_lgbest_erp_frei NUMERIC(29, 4),
    betrag_vk_netto_lgbest_erp_qual NUMERIC(29, 4),
    vk_netto_konz NUMERIC(29, 4),
    betrag_vk_netto_lgbest_erp_frei_konz NUMERIC(29, 4),
    betrag_vk_netto_lgbest_erp_qual_konz NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    betrag_ek_netto_lgbest_erp_frei NUMERIC(29, 4),
    betrag_ek_netto_lgbest_erp_qual NUMERIC(29, 4),
    ek_netto_konz NUMERIC(29, 4),
    betrag_ek_netto_lgbest_erp_frei_konz NUMERIC(29, 4),
    betrag_ek_netto_lgbest_erp_qual_konz NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    betrag_ek_netto_bnk_lgbest_erp_frei NUMERIC(29, 4),
    betrag_ek_netto_bnk_lgbest_erp_qual NUMERIC(29, 4),
    ek_netto_bnk_konz NUMERIC(29, 4),
    betrag_ek_netto_bnk_lgbest_erp_frei_konz NUMERIC(29, 4),
    betrag_ek_netto_bnk_lgbest_erp_qual_konz NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    betrag_ek_nettonetto_lgbest_erp_frei NUMERIC(29, 4),
    betrag_ek_nettonetto_lgbest_erp_qual NUMERIC(29, 4),
    ek_nettonetto_konz NUMERIC(29, 4),
    betrag_ek_nettonetto_lgbest_erp_frei_konz NUMERIC(29, 4),
    betrag_ek_nettonetto_lgbest_erp_qual_konz NUMERIC(29, 4),
    ek_mep_olk NUMERIC(29, 4),
    betrag_ek_mep_olk_lgbest_erp_frei NUMERIC(29, 4),
    betrag_ek_mep_olk_lgbest_erp_qual NUMERIC(29, 4),
    ek_mep_olk_konz NUMERIC(29, 4),
    betrag_ek_mep_olk_lgbest_erp_frei_konz NUMERIC(29, 4),
    betrag_ek_mep_olk_lgbest_erp_qual_konz NUMERIC(29, 4),
    ek_einstandspreis NUMERIC(29, 4),
    betrag_ek_einstandspreis_lgbest_erp_frei NUMERIC(29, 4),
    betrag_ek_einstandspreis_lgbest_erp_qual NUMERIC(29, 4),
    ek_einstandspreis_konz NUMERIC(29, 4),
    betrag_ek_einstandspreis_lgbest_erp_frei_konz NUMERIC(29, 4),
    betrag_ek_einstandspreis_lgbest_erp_qual_konz NUMERIC(29, 4),
    td_update TIMESTAMP,
    td_insert TIMESTAMP
);


INSERT INTO `_marktbestand_erp_step01`
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        COALESCE(X.gp_id, 0) AS gp_id,
        A.bezugsweg_id,
        A.relevant_fg,
        CAST(NULL AS STRING) AS posten_id,
        A.menge_lgbest_erp_frei_bme,
        A.menge_lgbest_erp_qual_bme,
        A.menge_lgbest_erp_gesp_bme,
        Y.default_wrg,
        0 AS vk_netto,
        0 AS betrag_vk_netto_lgbest_erp_frei,
        0 AS betrag_vk_netto_lgbest_erp_qual,
        0 AS vk_netto_konz,
        0 AS betrag_vk_netto_lgbest_erp_frei_konz,
        0 AS betrag_vk_netto_lgbest_erp_qual_konz,
        COALESCE(AGW.ek_netto, AGWW.ek_netto, 0) AS ek_netto,
        CAST(
            A.menge_lgbest_erp_frei_bme * COALESCE(AGW.ek_netto, AGWW.ek_netto, 0) AS NUMERIC) AS
        betrag_ek_netto_lgbest_erp_frei,
        CAST(
            A.menge_lgbest_erp_qual_bme * COALESCE(AGW.ek_netto, AGWW.ek_netto, 0) AS NUMERIC) AS
        betrag_ek_netto_lgbest_erp_qual,
        NULL AS ek_netto_konz,
        NULL AS betrag_ek_netto_lgbest_erp_frei_konz,
        NULL AS betrag_ek_netto_lgbest_erp_qual_konz,
        COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk, 0) AS ek_netto_bnk,
        CAST(
            A.menge_lgbest_erp_frei_bme * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk, 0) AS NUMERIC) AS
        betrag_ek_netto_bnk_lgbest_erp_frei,
        CAST(
            A.menge_lgbest_erp_qual_bme * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk, 0) AS NUMERIC) AS
        betrag_ek_netto_bnk_lgbest_erp_qual,
        NULL AS ek_netto_bnk_konz,
        NULL AS betrag_ek_netto_bnk_lgbest_erp_frei_konz,
        NULL AS betrag_ek_netto_bnk_lgbest_erp_qual_konz,
        COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto, 0) AS ek_nettonetto,
        CAST(
            A.menge_lgbest_erp_frei_bme * COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto, 0) AS NUMERIC) AS
        betrag_ek_nettonetto_lgbest_erp_frei,
        CAST(
            A.menge_lgbest_erp_qual_bme * COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto, 0) AS NUMERIC) AS
        betrag_ek_nettonetto_lgbest_erp_qual,
        NULL AS ek_nettonetto_konz,
        NULL AS betrag_ek_nettonetto_lgbest_erp_frei_konz,
        NULL AS betrag_ek_nettonetto_lgbest_erp_qual_konz,
        COALESCE(
            AGW.ek_mep - COALESCE(AGW.logistikkostenzuschlag, 0), AGWW.ek_mep - COALESCE(AGWW.logistikkostenzuschlag, 0),
            0
        ) AS ek_mep_olk,
        CAST(A.menge_lgbest_erp_frei_bme * COALESCE(AGW.ek_mep - COALESCE(AGW.logistikkostenzuschlag, 0), AGWW.ek_mep - COALESCE(AGWW.logistikkostenzuschlag, 0), 0) AS NUMERIC)
            AS betrag_ek_mep_olk_lgbest_erp_frei,
        CAST(A.menge_lgbest_erp_qual_bme * COALESCE(AGW.ek_mep - COALESCE(AGW.logistikkostenzuschlag, 0), AGWW.ek_mep - COALESCE(AGWW.logistikkostenzuschlag, 0), 0) AS NUMERIC)
            AS betrag_ek_mep_olk_lgbest_erp_qual,
        NULL AS ek_mep_olk_konz,
        NULL AS betrag_ek_mep_olk_lgbest_erp_frei_konz,
        NULL AS betrag_ek_mep_olk_lgbest_erp_qual_konz,
        COALESCE(AGW.einstandspreis, AGWW.einstandspreis, 0) AS ek_einstandspreis,
        CAST(
            A.menge_lgbest_erp_frei_bme * COALESCE(AGW.einstandspreis, AGWW.einstandspreis, 0) AS NUMERIC) AS
        betrag_ek_einstandspreis_lgbest_erp_frei,
        CAST(
            A.menge_lgbest_erp_qual_bme * COALESCE(AGW.einstandspreis, AGWW.einstandspreis, 0) AS NUMERIC) AS
        betrag_ek_einstandspreis_lgbest_erp_qual,
        NULL AS einstandspreis_konz,
        NULL AS betrag_einstandspreis_lgbest_erp_frei_konz,
        NULL AS betrag_einstandspreis_lgbest_erp_qual_konz,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM dbp_data.marktbestand_erp_2 AS A
    INNER JOIN dbp_data.mandant_2 AS Y ON A.mandant_id = Y.mandant_id
    LEFT JOIN dbp_data.art_gp_nm_zu_per_2 AS X
        ON
            A.mandant_id = X.mandant_id AND A.wup_id = X.wup_id AND A.art_id
            = X.art_id AND A.dat BETWEEN X.dat_von AND X.dat_bis
    LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGW
        ON
            X.mandant_id = AGW.mandant_id AND X.vz_wup_id = AGW.wup_id AND X.art_id =
            AGW.art_id AND X.gp_id = AGW.gp_id AND A.dat = AGW.dat
    LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGWW
        ON
            X.mandant_id = AGWW.mandant_id AND -1 = AGWW.wup_id AND X.art_id = AGWW.art_id AND X.gp_id = AGWW.gp_id AND A.dat = AGWW.dat
    WHERE
        A.mandant_id > 1
        AND A.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 5 DAY) AND (CURRENT_DATE("Europe/Berlin"))
);


INSERT INTO `_marktbestand_erp_step01`
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        COALESCE(X.gp_id, 0) AS gp_id,
        A.bezugsweg_id,
        A.relevant_fg,
        CAST(NULL AS STRING) AS posten_id,
        A.menge_lgbest_erp_frei_bme,
        A.menge_lgbest_erp_qual_bme,
        A.menge_lgbest_erp_gesp_bme,
        Y.default_wrg,
        0 AS vk_netto,
        0 AS betrag_vk_netto_lgbest_erp_frei,
        0 AS betrag_vk_netto_lgbest_erp_qual,
        0 AS vk_netto_konz,
        0 AS betrag_vk_netto_lgbest_erp_frei_konz,
        0 AS betrag_vk_netto_lgbest_erp_qual_konz,
        COALESCE(AGW.ek_netto, AGWW.ek_netto, AGWWW.ek_netto, 0) AS ek_netto,
        CAST(
            A.menge_lgbest_erp_frei_bme * COALESCE(AGW.ek_netto, AGWW.ek_netto, AGWWW.ek_netto, 0) AS NUMERIC) AS
        betrag_ek_netto_lgbest_erp_frei,
        CAST(
            A.menge_lgbest_erp_qual_bme * COALESCE(AGW.ek_netto, AGWW.ek_netto, AGWWW.ek_netto, 0) AS NUMERIC) AS
        betrag_ek_netto_lgbest_erp_qual,
        NULL AS ek_netto_konz,
        NULL AS betrag_ek_netto_lgbest_erp_frei_konz,
        NULL AS betrag_ek_netto_lgbest_erp_qual_konz,
        COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk, AGWWW.ek_netto_bnk, 0) AS ek_netto_bnk,
        CAST(
            A.menge_lgbest_erp_frei_bme * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk, AGWWW.ek_netto_bnk, 0) AS NUMERIC) AS
        betrag_ek_netto_bnk_lgbest_erp_frei,
        CAST(
            A.menge_lgbest_erp_qual_bme * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk, AGWWW.ek_netto_bnk, 0) AS NUMERIC) AS
        betrag_ek_netto_bnk_lgbest_erp_qual,
        NULL AS ek_netto_bnk_konz,
        NULL AS betrag_ek_netto_bnk_lgbest_erp_frei_konz,
        NULL AS betrag_ek_netto_bnk_lgbest_erp_qual_konz,
        COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto, AGWWW.ek_nettonetto, 0) AS ek_nettonetto,
        CAST(A.menge_lgbest_erp_frei_bme * COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto, AGWWW.ek_nettonetto, 0) AS NUMERIC)
            AS betrag_ek_nettonetto_lgbest_erp_frei,
        CAST(A.menge_lgbest_erp_qual_bme * COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto, AGWWW.ek_nettonetto, 0) AS NUMERIC)
            AS betrag_ek_nettonetto_lgbest_erp_qual,
        NULL AS ek_nettonetto_konz,
        NULL AS betrag_ek_nettonetto_lgbest_erp_frei_konz,
        NULL AS betrag_ek_nettonetto_lgbest_erp_qual_konz,
        COALESCE(
            AGW.ek_mep - COALESCE(AGW.logistikkostenzuschlag, 0), AGWW.ek_mep - COALESCE(AGWW.logistikkostenzuschlag, 0),
            AGWWW.ek_mep - COALESCE(AGWWW.logistikkostenzuschlag, 0), 0
        ) AS ek_mep_olk,
        CAST(A.menge_lgbest_erp_frei_bme * COALESCE(AGW.ek_mep - COALESCE(AGW.logistikkostenzuschlag, 0), AGWW.ek_mep - COALESCE(AGWW.logistikkostenzuschlag, 0), AGWWW.ek_mep - COALESCE(AGWWW.logistikkostenzuschlag, 0), 0) AS NUMERIC)
            AS betrag_ek_mep_olk_lgbest_erp_frei,
        CAST(A.menge_lgbest_erp_qual_bme * COALESCE(AGW.ek_mep - COALESCE(AGW.logistikkostenzuschlag, 0), AGWW.ek_mep - COALESCE(AGWW.logistikkostenzuschlag, 0), AGWWW.ek_mep - COALESCE(AGWWW.logistikkostenzuschlag, 0), 0) AS NUMERIC)
            AS betrag_ek_mep_olk_lgbest_erp_qual,
        NULL AS ek_mep_olk_konz,
        NULL AS betrag_ek_mep_olk_lgbest_erp_frei_konz,
        NULL AS betrag_ek_mep_olk_lgbest_erp_qual_konz,
        COALESCE(AGW.einstandspreis, AGWW.einstandspreis, AGWWW.einstandspreis, 0) AS ek_einstandspreis,
        CAST(A.menge_lgbest_erp_frei_bme * COALESCE(AGW.einstandspreis, AGWW.einstandspreis, AGWWW.einstandspreis, 0) AS NUMERIC)
            AS betrag_ek_einstandspreis_lgbest_erp_frei,
        CAST(A.menge_lgbest_erp_qual_bme * COALESCE(AGW.einstandspreis, AGWW.einstandspreis, AGWWW.einstandspreis, 0) AS NUMERIC)
            AS betrag_ek_einstandspreis_lgbest_erp_qual,
        NULL AS einstandspreis_konz,
        NULL AS betrag_einstandspreis_lgbest_erp_frei_konz,
        NULL AS betrag_einstandspreis_lgbest_erp_qual_konz,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM dbp_data.marktbestand_erp_2 AS A
    INNER JOIN dbp_data.mandant_2 AS Y ON A.mandant_id = Y.mandant_id
    LEFT JOIN dbp_data.art_gp_nm_zu_per_2 AS X
        ON
            A.mandant_id = X.mandant_id AND A.wup_id = X.wup_id AND A.art_id
            = X.art_id AND A.dat BETWEEN X.dat_von AND X.dat_bis
    LEFT JOIN dbp_data.ek_orderbuch_2 AS XXX_2
        ON
            A.mandant_id = XXX.mandant_id AND X.gp_id = XXX.wup_id AND A.art_id = XXX.art_id AND A.dat BETWEEN XXX.dat_von AND XXX.dat_bis
    LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGWWW
        ON
            X.mandant_id = AGWWW.mandant_id AND X.gp_id = AGWWW.wup_id AND X.art_id
            = AGWWW.art_id AND COALESCE(XXX.gp_id, X.gp_id) = AGWWW.gp_id AND A.dat = AGWWW.dat
    LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGW
        ON
            X.mandant_id = AGW.mandant_id AND X.vz_wup_id = AGW.wup_id AND X.art_id =
            AGW.art_id AND COALESCE(XXX.gp_id, X.gp_id) = AGW.gp_id AND A.dat = AGW.dat
    LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGWW
        ON
            X.mandant_id = AGWW.mandant_id AND -1 = AGWW.wup_id AND X.art_id = AGWW.art_id AND X.gp_id = AGWW.gp_id AND A.dat = AGWW.dat
    WHERE
        A.mandant_id = 1
        AND A.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 5 DAY) AND (CURRENT_DATE("Europe/Berlin"))
);


CREATE OR REPLACE TEMPORARY TABLE _tage AS
SELECT dat
FROM `_marktbestand_erp_step01`
GROUP BY dat;


CREATE OR REPLACE TEMPORARY TABLE _min_tage AS
SELECT MIN(dat) AS min_dat
FROM `_marktbestand_erp_step01`;


CREATE OR REPLACE TEMPORARY TABLE _art_wup_zu_per AS
SELECT *
FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.dat_von,
        A.art_id,
        A.bezugsweg_id,
        A.listung_id,
        A.vk_brutto,
        A.dat_bis,
        A.kdis,
        A.wrg_id,
        A.td_update,
        A.td_insert
    FROM dbp_data.art_wup_zu_per_2 AS A
    INNER JOIN `_min_tage` AS B ON A.dat_bis >= B.min_dat
) AS a
INNER JOIN `_tage` AS B0 ON B0.dat BETWEEN a.dat_von AND a.dat_bis;


CREATE OR REPLACE TEMPORARY TABLE _mwst_per AS
SELECT *
FROM (
    SELECT
        A.mwst_id,
        A.dat_von,
        A.mandant_id,
        A.mwst,
        A.dat_bis,
        A.mwst_bez,
        A.spr_id,
        A.sap_mwst_id,
        A.td_insert,
        A.td_update
    FROM dbp_data.mwst_per_2 AS A
    INNER JOIN `_min_tage` AS B ON A.dat_bis >= B.min_dat
) AS a
INNER JOIN `_tage` AS B0 ON B0.dat BETWEEN a.dat_von AND a.dat_bis;


CREATE OR REPLACE TEMPORARY TABLE _art_per AS
SELECT *
FROM (
    SELECT
        A.art_id,
        A.mandant_id,
        A.dat_von,
        A.dat_bis,
        A.mutter_wb_id,
        A.posten_id,
        A.ipn_id,
        A.mwst_id,
        A.oug_id,
        A.iwt_id,
        A.td_update,
        A.td_insert
    FROM dbp_data.art_per_2 AS A
    INNER JOIN `_min_tage` AS B ON A.dat_bis >= B.min_dat
) AS a
INNER JOIN `_tage` AS B0 ON B0.dat BETWEEN a.dat_von AND a.dat_bis;


UPDATE `_marktbestand_erp_step01` SET
    vk_netto = b.`_vk_netto`,
    betrag_vk_netto_lgbest_erp_frei = `_marktbestand_erp_step01`.menge_lgbest_erp_frei_bme * b.`_vk_netto`,
    betrag_vk_netto_lgbest_erp_qual = `_marktbestand_erp_step01`.menge_lgbest_erp_qual_bme * b.`_vk_netto`,
    posten_id = b.`_posten_id` FROM (
    SELECT
        A.mandant_id AS `_mandant_id`,
        A.wup_id AS `_wup_id`,
        A.art_id AS `_art_id`,
        A.dat AS `DBP_DATA._dat`, --pe_review
        B.posten_id AS `_posten_id`,
        CASE
            WHEN C.mwst IS NOT NULL
                THEN CAST(A.vk_brutto / (1 + C.mwst / 100) AS NUMERIC)
            ELSE A.vk_brutto
        END AS `_vk_netto`
    FROM `_art_wup_zu_per` AS A
    LEFT JOIN `_art_per` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.dat = B.dat
    LEFT JOIN `_mwst_per` AS C ON A.mandant_id = C.mandant_id AND B.mwst_id = C.mwst_id AND A.dat = C.dat
) AS b
WHERE
    `_marktbestand_erp_step01`.dat = b.`DBP_DATA._dat` AND `_marktbestand_erp_step01`.mandant_id = b.`_mandant_id` AND
    `_marktbestand_erp_step01`.art_id = b.`_art_id` AND `_marktbestand_erp_step01`.wup_id = b.`_wup_id`; --pe_review


CREATE OR REPLACE TEMPORARY TABLE _marktbestand_erp_step02 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.dat,
    A.gp_id,
    A.bezugsweg_id,
    A.relevant_fg,
    A.posten_id,
    A.menge_lgbest_erp_frei_bme,
    A.menge_lgbest_erp_qual_bme,
    A.menge_lgbest_erp_gesp_bme,
    A.wrg_id,
    A.vk_netto,
    A.betrag_vk_netto_lgbest_erp_frei,
    A.betrag_vk_netto_lgbest_erp_qual,
    A.vk_netto * D1.umrechnungskurs AS vk_netto_konz,
    A.betrag_vk_netto_lgbest_erp_frei * D1.umrechnungskurs AS betrag_vk_netto_lgbest_erp_frei_konz,
    A.betrag_vk_netto_lgbest_erp_qual * D1.umrechnungskurs AS betrag_vk_netto_lgbest_erp_qual_konz,
    A.ek_netto,
    A.betrag_ek_netto_lgbest_erp_frei,
    A.betrag_ek_netto_lgbest_erp_qual,
    A.ek_netto * D1.umrechnungskurs AS ek_netto_konz,
    A.betrag_ek_netto_lgbest_erp_frei * D1.umrechnungskurs AS betrag_ek_netto_lgbest_erp_frei_konz,
    A.betrag_ek_netto_lgbest_erp_qual * D1.umrechnungskurs AS betrag_ek_netto_lgbest_erp_qual_konz,
    A.ek_netto_bnk,
    A.betrag_ek_netto_bnk_lgbest_erp_frei,
    A.betrag_ek_netto_bnk_lgbest_erp_qual,
    A.ek_netto_bnk * D1.umrechnungskurs AS ek_netto_bnk_konz,
    A.betrag_ek_netto_bnk_lgbest_erp_frei * D1.umrechnungskurs AS betrag_ek_netto_bnk_lgbest_erp_frei_konz,
    A.betrag_ek_netto_bnk_lgbest_erp_qual * D1.umrechnungskurs AS betrag_ek_netto_bnk_lgbest_erp_qual_konz,
    A.ek_nettonetto,
    A.betrag_ek_nettonetto_lgbest_erp_frei,
    A.betrag_ek_nettonetto_lgbest_erp_qual,
    A.ek_nettonetto * D1.umrechnungskurs AS ek_nettonetto_konz,
    A.betrag_ek_nettonetto_lgbest_erp_frei * D1.umrechnungskurs AS betrag_ek_nettonetto_lgbest_erp_frei_konz,
    A.betrag_ek_nettonetto_lgbest_erp_qual * D1.umrechnungskurs AS betrag_ek_nettonetto_lgbest_erp_qual_konz,
    A.ek_mep_olk,
    A.betrag_ek_mep_olk_lgbest_erp_frei,
    A.betrag_ek_mep_olk_lgbest_erp_qual,
    A.ek_mep_olk * D1.umrechnungskurs AS ek_mep_olk_konz,
    A.betrag_ek_mep_olk_lgbest_erp_frei * D1.umrechnungskurs AS betrag_ek_mep_olk_lgbest_erp_frei_konz,
    A.betrag_ek_mep_olk_lgbest_erp_qual * D1.umrechnungskurs AS betrag_ek_mep_olk_lgbest_erp_qual_konz,
    A.ek_einstandspreis,
    A.betrag_ek_einstandspreis_lgbest_erp_frei,
    A.betrag_ek_einstandspreis_lgbest_erp_qual,
    A.ek_einstandspreis * D1.umrechnungskurs AS ek_einstandspreis_konz,
    A.betrag_ek_einstandspreis_lgbest_erp_frei * D1.umrechnungskurs AS betrag_ek_einstandspreis_lgbest_erp_frei_konz,
    A.betrag_ek_einstandspreis_lgbest_erp_qual * D1.umrechnungskurs AS betrag_ek_einstandspreis_lgbest_erp_qual_konz,
    A.td_update,
    A.td_insert
FROM `_marktbestand_erp_step01` AS A
INNER JOIN dbp_data.kurs_2
    AS D1 ON A.wrg_id = D1.von_wrg_id AND D1.dat_bis = DATE '9999-12-31' AND D1.nach_wrg_id
= 'EUR' AND D1.kurstyp_id = 3;


DELETE FROM dbp_msi_data.marktbestand_erp_tag_sum_2
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 5 DAY) AND (CURRENT_DATE("Europe/Berlin"));


INSERT INTO dbp_msi_data.marktbestand_erp_tag_sum_2 (
    mandant_id, art_id, wup_id, nb_id, dat, gp_id,
    bezugsweg_id, posten_id, wrg_id, umrechnungskurs_hist, relevant_fg, menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme, menge_lgbest_erp_gesp_bme, vk_netto, vk_netto_konz, betrag_vk_netto_lgbest_erp_frei,
    betrag_vk_netto_lgbest_erp_frei_konz, betrag_vk_netto_lgbest_erp_qual, betrag_vk_netto_lgbest_erp_qual_konz, ek_netto,
    ek_netto_konz, betrag_ek_netto_lgbest_erp_frei, betrag_ek_netto_lgbest_erp_frei_konz, betrag_ek_netto_lgbest_erp_qual,
    betrag_ek_netto_lgbest_erp_qual_konz, ek_netto_bnk, ek_netto_bnk_konz, betrag_ek_netto_bnk_lgbest_erp_frei,
    betrag_ek_netto_bnk_lgbest_erp_frei_konz, betrag_ek_netto_bnk_lgbest_erp_qual, betrag_ek_netto_bnk_lgbest_erp_qual_konz,
    ek_nettonetto, ek_nettonetto_konz, betrag_ek_nettonetto_lgbest_erp_frei, betrag_ek_nettonetto_lgbest_erp_frei_konz,
    betrag_ek_nettonetto_lgbest_erp_qual, betrag_ek_nettonetto_lgbest_erp_qual_konz, ek_mep_olk, ek_mep_olk_konz,
    betrag_ek_mep_olk_lgbest_erp_frei, betrag_ek_mep_olk_lgbest_erp_frei_konz, betrag_ek_mep_olk_lgbest_erp_qual,
    betrag_ek_mep_olk_lgbest_erp_qual_konz, ek_einstandspreis, ek_einstandspreis_konz,
    betrag_ek_einstandspreis_lgbest_erp_frei, betrag_ek_einstandspreis_lgbest_erp_frei_konz,
    betrag_ek_einstandspreis_lgbest_erp_qual, betrag_ek_einstandspreis_lgbest_erp_qual_konz, td_update, td_insert
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.gp_id,
        A.bezugsweg_id,
        A.posten_id,
        A.wrg_id,
        K.umrechnungskurs AS umrechnungskurs_hist,
        A.relevant_fg,
        A.menge_lgbest_erp_frei_bme,
        A.menge_lgbest_erp_qual_bme,
        A.menge_lgbest_erp_gesp_bme,
        A.vk_netto,
        A.vk_netto_konz,
        A.betrag_vk_netto_lgbest_erp_frei,
        A.betrag_vk_netto_lgbest_erp_frei_konz,
        A.betrag_vk_netto_lgbest_erp_qual,
        A.betrag_vk_netto_lgbest_erp_qual_konz,
        A.ek_netto,
        A.ek_netto_konz,
        A.betrag_ek_netto_lgbest_erp_frei,
        A.betrag_ek_netto_lgbest_erp_frei_konz,
        A.betrag_ek_netto_lgbest_erp_qual,
        A.betrag_ek_netto_lgbest_erp_qual_konz,
        A.ek_netto_bnk,
        A.ek_netto_bnk_konz,
        A.betrag_ek_netto_bnk_lgbest_erp_frei,
        A.betrag_ek_netto_bnk_lgbest_erp_frei_konz,
        A.betrag_ek_netto_bnk_lgbest_erp_qual,
        A.betrag_ek_netto_bnk_lgbest_erp_qual_konz,
        A.ek_nettonetto,
        A.ek_nettonetto_konz,
        A.betrag_ek_nettonetto_lgbest_erp_frei,
        A.betrag_ek_nettonetto_lgbest_erp_frei_konz,
        A.betrag_ek_nettonetto_lgbest_erp_qual,
        A.betrag_ek_nettonetto_lgbest_erp_qual_konz,
        A.ek_mep_olk,
        A.ek_mep_olk_konz,
        A.betrag_ek_mep_olk_lgbest_erp_frei,
        A.betrag_ek_mep_olk_lgbest_erp_frei_konz,
        A.betrag_ek_mep_olk_lgbest_erp_qual,
        A.betrag_ek_mep_olk_lgbest_erp_qual_konz,
        A.ek_einstandspreis,
        A.ek_einstandspreis_konz,
        A.betrag_ek_einstandspreis_lgbest_erp_frei,
        A.betrag_ek_einstandspreis_lgbest_erp_frei_konz,
        A.betrag_ek_einstandspreis_lgbest_erp_qual,
        A.betrag_ek_einstandspreis_lgbest_erp_qual_konz,
        A.td_update,
        A.td_insert
    FROM `_marktbestand_erp_step02` AS A
    LEFT JOIN dbp_data.kurs_2 AS K
        ON
            A.wrg_id = K.von_wrg_id AND A.dat BETWEEN K.dat_von AND K.dat_bis AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3
    WHERE (
        A.mandant_id, A.wup_id) IN (
        SELECT (mandant_id, wup_id)
        FROM `_tracker`
    )
);
