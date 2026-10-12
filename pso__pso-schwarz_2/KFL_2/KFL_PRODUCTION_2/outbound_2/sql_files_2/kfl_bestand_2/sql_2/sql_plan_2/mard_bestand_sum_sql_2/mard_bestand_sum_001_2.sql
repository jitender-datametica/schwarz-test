-- Lagerbestaende


DELETE FROM dbp_data.lagerbestand_erp_per_2
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, art_id)
    FROM dbp_data.art_wg_zu_per_2
    WHERE
        arthiertyp_id = 2
        AND dat_bis = DATE '9999-12-31'
        AND wg_id = 961
);


CREATE OR REPLACE TEMPORARY TABLE _tage AS
SELECT dat
FROM dbp_data.tag_2
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 5 DAY) AND (CURRENT_DATE("Europe/Berlin"));


CREATE OR REPLACE TEMPORARY TABLE _step01_2 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.lagerort_id,
    A.art_id,
    B.dat,
    SUM(A.menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
    SUM(A.menge_lgbest_erp_umlag_bme) AS menge_lgbest_erp_umlag_bme,
    SUM(A.menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme,
    SUM(A.menge_lgbest_erp_nf_charge_bme) AS menge_lgbest_erp_nf_charge_bme,
    SUM(A.menge_lgbest_erp_gesp_bme) AS menge_lgbest_erp_gesp_bme,
    SUM(A.menge_lgbest_erp_ret_gesp_bme) AS menge_lgbest_erp_ret_gesp_bme,
    SUM(
        A.menge_lgbest_erp_frei_bme + A.menge_lgbest_erp_umlag_bme + A.menge_lgbest_erp_qual_bme + A.menge_lgbest_erp_nf_charge_bme
        + A.menge_lgbest_erp_gesp_bme + A.menge_lgbest_erp_ret_gesp_bme
    ) AS menge_lgbest_erp_gesamt_bme,
    A.sperr_id,
    A.gjmo_buch,
    A.lagerort_loesch_fg,
    A.pflege_status,
    SUM(A.menge_lgbest_erp_kolli) AS menge_lgbest_erp_kolli,
    SUM(A.menge_lgbest_erp_palette) AS menge_lgbest_erp_palette,
    SUM(A.betrag_lgbest_erp) AS ek_netto,
    A.wrg_id,
    SUM(A.vk_netto_lgbest_erp) AS vk_netto
FROM dbp_data.lagerbestand_erp_per_2 AS A
INNER JOIN `_tage` AS B ON B.dat BETWEEN A.dat_von AND A.dat_bis
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.lagerort_id,
    A.art_id,
    B.dat,
    A.sperr_id,
    A.gjmo_buch,
    A.lagerort_loesch_fg,
    A.pflege_status,
    A.wrg_id;


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


-- auf tag_2 auffaechern
INSERT INTO `_vol_art_gp_wup_zu_per` (
    mandant_id, art_id, gp_id, wup_id, nb_id,
    einkaufsorganisation_id, dat, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis,
    logistikkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk
)
(
    SELECT
        a.mandant_id AS mandant_id,
        a.art_id AS art_id,
        a.gp_id AS gp_id,
        a.wup_id AS wup_id,
        a.nb_id AS nb_id,
        a.einkaufsorganisation_id AS einkaufsorganisation_id,
        D.dat,
        a.ek_brutto AS ek_brutto,
        a.ek_netto AS ek_netto,
        a.ek_nettonetto AS ek_nettonetto,
        a.ek_kal_basis AS ek_kal_basis,
        a.ek_mep AS ek_mep,
        a.einstandspreis AS einstandspreis,
        a.logistikkostenzuschlag,
        a.ek_netto_bnk AS ek_netto_bnk,
        a.ek_netto_bnk_sachk AS ek_netto_bnk_sachk
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


CREATE OR REPLACE TABLE dbp_etl.lagerbestand_erp_per_step02_2 LIKE dbp_msi_data.lagerbestand_erp_tag_sum_2;


CREATE OR REPLACE TABLE dbp_etl.lagerbestand_erp_per_step03_2 LIKE dbp_msi_data.lagerbestand_erp_tag_sum_2;


INSERT INTO dbp_etl.lagerbestand_erp_per_step02_2 (
    mandant_id, art_id, wup_id, nb_id, lagerort_id, dat,
    gp_id, wrg_id, sperr_id, gjmo_buch, lagerort_loesch_fg, pflege_status, menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme, menge_lgbest_erp_gesamt_bme, menge_lgbest_erp_kolli, menge_lgbest_erp_palette, vk_netto,
    ek_netto
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    lagerort_id,
    dat,
    0 AS gp_id,
    wrg_id,
    sperr_id,
    gjmo_buch,
    lagerort_loesch_fg,
    pflege_status,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme,
    menge_lgbest_erp_gesamt_bme,
    menge_lgbest_erp_kolli,
    menge_lgbest_erp_palette,
    vk_netto,
    ek_netto
FROM `_step01_2`);


UPDATE dbp_etl.lagerbestand_erp_per_step02_2 SET
    betrag_vk_netto_lgbest_erp_frei = CASE
        WHEN lagerbestand_erp_per_step02.menge_lgbest_erp_gesamt_bme = 0
            THEN 0
        ELSE
            lagerbestand_erp_per_step02.vk_netto / lagerbestand_erp_per_step02.menge_lgbest_erp_gesamt_bme *
            lagerbestand_erp_per_step02.menge_lgbest_erp_frei_bme
    END,
    betrag_vk_netto_lgbest_erp_qual = CASE
        WHEN lagerbestand_erp_per_step02.menge_lgbest_erp_gesamt_bme = 0
            THEN 0
        ELSE
            lagerbestand_erp_per_step02.vk_netto / lagerbestand_erp_per_step02.menge_lgbest_erp_gesamt_bme *
            lagerbestand_erp_per_step02.menge_lgbest_erp_qual_bme
    END,
    betrag_vk_netto_lgbest_erp_gesamt = lagerbestand_erp_per_step02.vk_netto,
    ek_logistik = CASE
        WHEN lagerbestand_erp_per_step02.menge_lgbest_erp_gesamt_bme = 0
            THEN 0
        ELSE lagerbestand_erp_per_step02.ek_netto / lagerbestand_erp_per_step02.menge_lgbest_erp_gesamt_bme
    END,
    betrag_ek_logistik_lgbest_erp_gesamt = lagerbestand_erp_per_step02.ek_netto
WHERE TRUE;


CREATE OR REPLACE TEMPORARY TABLE _lagerbestand_erp_per_step03 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.lagerort_id,
    A.art_id,
    A.dat,
    COALESCE(X.gp_id, A.gp_id) AS gp_id,
    A.posten_id,
    A.menge_lgbest_erp_frei_bme,
    A.menge_lgbest_erp_umlag_bme,
    A.menge_lgbest_erp_qual_bme,
    A.menge_lgbest_erp_nf_charge_bme,
    A.menge_lgbest_erp_gesp_bme,
    A.menge_lgbest_erp_ret_gesp_bme,
    A.menge_lgbest_erp_gesamt_bme,
    A.sperr_id,
    A.gjmo_buch,
    A.lagerort_loesch_fg,
    A.pflege_status,
    A.menge_lgbest_erp_kolli,
    A.menge_lgbest_erp_palette,
    A.wrg_id,
    COALESCE(A.vk_netto / IF(A.menge_lgbest_erp_gesamt_bme = 0, NULL, A.menge_lgbest_erp_gesamt_bme), 0) AS vk_netto,
    A.betrag_vk_netto_lgbest_erp_frei,
    A.betrag_vk_netto_lgbest_erp_qual,
    A.betrag_vk_netto_lgbest_erp_gesamt,
    A.vk_netto_konz,
    A.betrag_vk_netto_lgbest_erp_frei_konz,
    A.betrag_vk_netto_lgbest_erp_qual_konz,
    A.betrag_vk_netto_lgbest_erp_gesamt_konz,
    COALESCE(AGW.ek_netto, AGWW.ek_netto, AGWWW.ek_netto, 0) AS ek_netto,
    A.menge_lgbest_erp_frei_bme * COALESCE(
        AGW.ek_netto, AGWW.ek_netto, AGWWW.ek_netto, 0) AS
    betrag_ek_netto_lgbest_erp_frei,
    A.menge_lgbest_erp_qual_bme * COALESCE(
        AGW.ek_netto, AGWW.ek_netto, AGWWW.ek_netto, 0) AS
    betrag_ek_netto_lgbest_erp_qual,
    A.ek_netto_konz,
    A.betrag_ek_netto_lgbest_erp_frei_konz,
    A.betrag_ek_netto_lgbest_erp_qual_konz,
    COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk, AGWWW.ek_netto_bnk, 0) AS ek_netto_bnk,
    A.menge_lgbest_erp_frei_bme * COALESCE(
        AGW.ek_netto_bnk, AGWW.ek_netto_bnk, AGWWW.ek_netto_bnk, 0) AS
    betrag_ek_netto_bnk_lgbest_erp_frei,
    A.menge_lgbest_erp_qual_bme * COALESCE(
        AGW.ek_netto_bnk, AGWW.ek_netto_bnk, AGWWW.ek_netto_bnk, 0) AS
    betrag_ek_netto_bnk_lgbest_erp_qual,
    A.ek_netto_bnk_konz,
    A.betrag_ek_netto_bnk_lgbest_erp_frei_konz,
    A.betrag_ek_netto_bnk_lgbest_erp_qual_konz,
    COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto, AGWWW.ek_nettonetto, 0) AS ek_nettonetto,
    A.menge_lgbest_erp_frei_bme * COALESCE(
        AGW.ek_nettonetto, AGWW.ek_nettonetto, AGWWW.ek_nettonetto, 0) AS
    betrag_ek_nettonetto_lgbest_erp_frei,
    A.menge_lgbest_erp_qual_bme * COALESCE(
        AGW.ek_nettonetto, AGWW.ek_nettonetto, AGWWW.ek_nettonetto, 0) AS
    betrag_ek_nettonetto_lgbest_erp_qual,
    A.ek_nettonetto_konz,
    A.betrag_ek_nettonetto_lgbest_erp_frei_konz,
    A.betrag_ek_nettonetto_lgbest_erp_qual_konz,
    COALESCE(
        AGW.ek_mep - COALESCE(AGW.logistikkostenzuschlag, 0), AGWW.ek_mep - COALESCE(AGWW.logistikkostenzuschlag, 0),
        AGWWW.ek_mep - COALESCE(AGWWW.logistikkostenzuschlag, 0), 0
    ) AS ek_mep_olk,
    A.menge_lgbest_erp_frei_bme * COALESCE(AGW.ek_mep - COALESCE(
        AGW.logistikkostenzuschlag, 0), AGWW.ek_mep - COALESCE(
        AGWW.logistikkostenzuschlag, 0
    ), AGWWW.ek_mep - COALESCE(AGWWW.logistikkostenzuschlag, 0
    ), 0) AS
    betrag_ek_mep_olk_lgbest_erp_frei,
    A.menge_lgbest_erp_qual_bme * COALESCE(AGW.ek_mep - COALESCE(
        AGW.logistikkostenzuschlag, 0), AGWW.ek_mep - COALESCE(
        AGWW.logistikkostenzuschlag, 0
    ), AGWWW.ek_mep - COALESCE(AGWWW.logistikkostenzuschlag, 0
    ), 0) AS
    betrag_ek_mep_olk_lgbest_erp_qual,
    A.ek_mep_olk_konz,
    A.betrag_ek_mep_olk_lgbest_erp_frei_konz,
    A.betrag_ek_mep_olk_lgbest_erp_qual_konz,
    COALESCE(AGW.einstandspreis, AGWW.einstandspreis, AGWWW.einstandspreis, 0) AS ek_einstandspreis,
    A.menge_lgbest_erp_frei_bme * COALESCE(
        AGW.einstandspreis, AGWW.einstandspreis, AGWWW.einstandspreis, 0) AS
    betrag_ek_einstandspreis_lgbest_erp_frei,
    A.menge_lgbest_erp_qual_bme * COALESCE(
        AGW.einstandspreis, AGWW.einstandspreis, AGWWW.einstandspreis, 0) AS
    betrag_ek_einstandspreis_lgbest_erp_qual,
    A.ek_einstandspreis_konz,
    A.betrag_ek_einstandspreis_lgbest_erp_frei_konz,
    A.betrag_ek_einstandspreis_lgbest_erp_qual_konz,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert,
    A.ek_logistik,
    A.betrag_ek_logistik_lgbest_erp_gesamt,
    A.betrag_ek_logistik_lgbest_erp_gesamt_konz,
    A.ek_logistik_konz
FROM dbp_etl.lagerbestand_erp_per_step02_2 AS A
INNER JOIN `_dat` AS D ON A.dat = D.dat -- lieferant und ausstiegspunkt ermitteln

LEFT JOIN dbp_data.art_gp_nm_zu_per_2 AS X
    ON
        A.mandant_id = X.mandant_id AND A.wup_id = X.wup_id AND A.art_id
        = X.art_id AND A.dat BETWEEN X.dat_von AND X.dat_bis
LEFT JOIN dbp_data.ek_orderbuch_2 AS XXX_2
    ON
        A.mandant_id = XXX.mandant_id AND X.gp_id = XXX.wup_id AND A.art_id
        = XXX.art_id AND A.dat BETWEEN XXX.dat_von AND XXX.dat_bis -- betriebsuebergreifender ek preis

LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGWWW
    ON
        X.mandant_id = AGWWW.mandant_id AND X.gp_id = AGWWW.wup_id AND X.art_id
        = AGWWW.art_id AND COALESCE(XXX.gp_id, X.gp_id) = AGWWW.gp_id AND A.dat = AGWWW.dat
-- betriebsspezifischer ek preis

LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGW
    ON
        X.mandant_id = AGW.mandant_id AND X.vz_wup_id = AGW.wup_id AND X.art_id =
        AGW.art_id AND COALESCE(XXX.gp_id, X.gp_id) = AGW.gp_id AND A.dat = AGW.dat -- betriebsuebergreifender ek preis

LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGWW
    ON
        X.mandant_id = AGWW.mandant_id AND -1 = AGWW.wup_id AND X.art_id = AGWW.art_id AND X.gp_id = AGWW.gp_id AND A.dat = AGWW.dat
WHERE A.mandant_id = 1;


INSERT INTO dbp_etl.lagerbestand_erp_per_step03_2 (
    mandant_id, art_id, wup_id, nb_id, lagerort_id, dat,
    gp_id, posten_id, wrg_id, sperr_id, gjmo_buch, lagerort_loesch_fg, pflege_status, menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme, menge_lgbest_erp_gesamt_bme, menge_lgbest_erp_kolli, menge_lgbest_erp_palette, vk_netto,
    vk_netto_konz, betrag_vk_netto_lgbest_erp_frei, betrag_vk_netto_lgbest_erp_frei_konz, betrag_vk_netto_lgbest_erp_qual,
    betrag_vk_netto_lgbest_erp_qual_konz, betrag_vk_netto_lgbest_erp_gesamt, betrag_vk_netto_lgbest_erp_gesamt_konz,
    ek_netto, ek_netto_konz, betrag_ek_netto_lgbest_erp_frei, betrag_ek_netto_lgbest_erp_frei_konz,
    betrag_ek_netto_lgbest_erp_qual, betrag_ek_netto_lgbest_erp_qual_konz, ek_netto_bnk, ek_netto_bnk_konz,
    betrag_ek_netto_bnk_lgbest_erp_frei, betrag_ek_netto_bnk_lgbest_erp_frei_konz, betrag_ek_netto_bnk_lgbest_erp_qual,
    betrag_ek_netto_bnk_lgbest_erp_qual_konz, ek_nettonetto, ek_nettonetto_konz, betrag_ek_nettonetto_lgbest_erp_frei,
    betrag_ek_nettonetto_lgbest_erp_frei_konz, betrag_ek_nettonetto_lgbest_erp_qual,
    betrag_ek_nettonetto_lgbest_erp_qual_konz, ek_mep_olk, ek_mep_olk_konz, betrag_ek_mep_olk_lgbest_erp_frei,
    betrag_ek_mep_olk_lgbest_erp_frei_konz, betrag_ek_mep_olk_lgbest_erp_qual, betrag_ek_mep_olk_lgbest_erp_qual_konz,
    ek_einstandspreis, ek_einstandspreis_konz, betrag_ek_einstandspreis_lgbest_erp_frei,
    betrag_ek_einstandspreis_lgbest_erp_frei_konz, betrag_ek_einstandspreis_lgbest_erp_qual,
    betrag_ek_einstandspreis_lgbest_erp_qual_konz, ek_logistik, ek_logistik_konz, betrag_ek_logistik_lgbest_erp_gesamt,
    betrag_ek_logistik_lgbest_erp_gesamt_konz, td_update, td_insert
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    lagerort_id,
    dat,
    gp_id,
    posten_id,
    wrg_id,
    sperr_id,
    gjmo_buch,
    lagerort_loesch_fg,
    pflege_status,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme,
    menge_lgbest_erp_gesamt_bme,
    menge_lgbest_erp_kolli,
    menge_lgbest_erp_palette,
    vk_netto,
    vk_netto_konz,
    betrag_vk_netto_lgbest_erp_frei,
    betrag_vk_netto_lgbest_erp_frei_konz,
    betrag_vk_netto_lgbest_erp_qual,
    betrag_vk_netto_lgbest_erp_qual_konz,
    betrag_vk_netto_lgbest_erp_gesamt,
    betrag_vk_netto_lgbest_erp_gesamt_konz,
    ek_netto,
    ek_netto_konz,
    betrag_ek_netto_lgbest_erp_frei,
    betrag_ek_netto_lgbest_erp_frei_konz,
    betrag_ek_netto_lgbest_erp_qual,
    betrag_ek_netto_lgbest_erp_qual_konz,
    ek_netto_bnk,
    ek_netto_bnk_konz,
    betrag_ek_netto_bnk_lgbest_erp_frei,
    betrag_ek_netto_bnk_lgbest_erp_frei_konz,
    betrag_ek_netto_bnk_lgbest_erp_qual,
    betrag_ek_netto_bnk_lgbest_erp_qual_konz,
    ek_nettonetto,
    ek_nettonetto_konz,
    betrag_ek_nettonetto_lgbest_erp_frei,
    betrag_ek_nettonetto_lgbest_erp_frei_konz,
    betrag_ek_nettonetto_lgbest_erp_qual,
    betrag_ek_nettonetto_lgbest_erp_qual_konz,
    ek_mep_olk,
    ek_mep_olk_konz,
    betrag_ek_mep_olk_lgbest_erp_frei,
    betrag_ek_mep_olk_lgbest_erp_frei_konz,
    betrag_ek_mep_olk_lgbest_erp_qual,
    betrag_ek_mep_olk_lgbest_erp_qual_konz,
    ek_einstandspreis,
    ek_einstandspreis_konz,
    betrag_ek_einstandspreis_lgbest_erp_frei,
    betrag_ek_einstandspreis_lgbest_erp_frei_konz,
    betrag_ek_einstandspreis_lgbest_erp_qual,
    betrag_ek_einstandspreis_lgbest_erp_qual_konz,
    ek_logistik,
    ek_logistik_konz,
    betrag_ek_logistik_lgbest_erp_gesamt,
    betrag_ek_logistik_lgbest_erp_gesamt_konz,
    td_update,
    td_insert
FROM `_lagerbestand_erp_per_step03`);


CREATE OR REPLACE TEMPORARY TABLE _lagerbestand_erp_per_step03_kmo AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.lagerort_id,
    A.art_id,
    A.dat,
    COALESCE(X.gp_id, A.gp_id) AS gp_id,
    A.posten_id,
    A.menge_lgbest_erp_frei_bme,
    A.menge_lgbest_erp_umlag_bme,
    A.menge_lgbest_erp_qual_bme,
    A.menge_lgbest_erp_nf_charge_bme,
    A.menge_lgbest_erp_gesp_bme,
    A.menge_lgbest_erp_ret_gesp_bme,
    A.menge_lgbest_erp_gesamt_bme,
    A.sperr_id,
    A.gjmo_buch,
    A.lagerort_loesch_fg,
    A.pflege_status,
    A.menge_lgbest_erp_kolli,
    A.menge_lgbest_erp_palette,
    A.wrg_id,
    COALESCE(A.vk_netto / IF(A.menge_lgbest_erp_gesamt_bme = 0, NULL, A.menge_lgbest_erp_gesamt_bme), 0) AS vk_netto,
    A.betrag_vk_netto_lgbest_erp_frei,
    A.betrag_vk_netto_lgbest_erp_qual,
    A.betrag_vk_netto_lgbest_erp_gesamt,
    A.vk_netto_konz,
    A.betrag_vk_netto_lgbest_erp_frei_konz,
    A.betrag_vk_netto_lgbest_erp_qual_konz,
    A.betrag_vk_netto_lgbest_erp_gesamt_konz,
    COALESCE(AGW.ek_netto, AGWW.ek_netto, 0) AS ek_netto,
    A.menge_lgbest_erp_frei_bme * COALESCE(AGW.ek_netto, AGWW.ek_netto, 0) AS betrag_ek_netto_lgbest_erp_frei,
    A.menge_lgbest_erp_qual_bme * COALESCE(AGW.ek_netto, AGWW.ek_netto, 0) AS betrag_ek_netto_lgbest_erp_qual,
    A.ek_netto_konz,
    A.betrag_ek_netto_lgbest_erp_frei_konz,
    A.betrag_ek_netto_lgbest_erp_qual_konz,
    COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk, 0) AS ek_netto_bnk,
    A.menge_lgbest_erp_frei_bme * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk, 0) AS betrag_ek_netto_bnk_lgbest_erp_frei
    ,
    A.menge_lgbest_erp_qual_bme * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk, 0) AS betrag_ek_netto_bnk_lgbest_erp_qual
    ,
    A.ek_netto_bnk_konz,
    A.betrag_ek_netto_bnk_lgbest_erp_frei_konz,
    A.betrag_ek_netto_bnk_lgbest_erp_qual_konz,
    COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto, 0) AS ek_nettonetto,
    A.menge_lgbest_erp_frei_bme * COALESCE(
        AGW.ek_nettonetto, AGWW.ek_nettonetto, 0) AS
    betrag_ek_nettonetto_lgbest_erp_frei,
    A.menge_lgbest_erp_qual_bme * COALESCE(
        AGW.ek_nettonetto, AGWW.ek_nettonetto, 0) AS
    betrag_ek_nettonetto_lgbest_erp_qual,
    A.ek_nettonetto_konz,
    A.betrag_ek_nettonetto_lgbest_erp_frei_konz,
    A.betrag_ek_nettonetto_lgbest_erp_qual_konz,
    COALESCE(AGW.ek_mep, AGWW.ek_mep, 0) AS ek_mep_olk,
    A.menge_lgbest_erp_frei_bme * COALESCE(AGW.ek_mep, AGWW.ek_mep, 0) AS betrag_ek_mep_olk_lgbest_erp_frei,
    A.menge_lgbest_erp_qual_bme * COALESCE(AGW.ek_mep, AGWW.ek_mep, 0) AS betrag_ek_mep_olk_lgbest_erp_qual,
    A.ek_mep_olk_konz,
    A.betrag_ek_mep_olk_lgbest_erp_frei_konz,
    A.betrag_ek_mep_olk_lgbest_erp_qual_konz,
    COALESCE(AGW.einstandspreis, AGWW.einstandspreis, 0) AS ek_einstandspreis,
    A.menge_lgbest_erp_frei_bme * COALESCE(
        AGW.einstandspreis, AGWW.einstandspreis, 0) AS
    betrag_ek_einstandspreis_lgbest_erp_frei,
    A.menge_lgbest_erp_qual_bme * COALESCE(
        AGW.einstandspreis, AGWW.einstandspreis, 0) AS
    betrag_ek_einstandspreis_lgbest_erp_qual,
    A.ek_einstandspreis_konz,
    A.betrag_ek_einstandspreis_lgbest_erp_frei_konz,
    A.betrag_ek_einstandspreis_lgbest_erp_qual_konz,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert,
    A.ek_logistik,
    A.betrag_ek_logistik_lgbest_erp_gesamt,
    A.betrag_ek_logistik_lgbest_erp_gesamt_konz,
    A.ek_logistik_konz
FROM dbp_etl.lagerbestand_erp_per_step02_2 AS A
INNER JOIN `_dat` AS D ON A.dat = D.dat -- lieferant und ausstiegspunkt ermitteln

LEFT JOIN dbp_data.art_gp_nm_zu_per_2 AS X
    ON
        A.mandant_id = X.mandant_id AND A.wup_id = X.wup_id AND A.art_id
        = X.art_id AND A.dat BETWEEN X.dat_von AND X.dat_bis -- betriebsspezifischer ek preis

LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGW
    ON
        X.mandant_id = AGW.mandant_id AND X.vz_wup_id = AGW.wup_id AND X.art_id =
        AGW.art_id AND X.gp_id = AGW.gp_id AND A.dat = AGW.dat -- betriebsuebergreifender ek preis

LEFT JOIN `_vol_art_gp_wup_zu_per` AS AGWW
    ON
        X.mandant_id = AGWW.mandant_id AND -1 = AGWW.wup_id AND X.art_id = AGWW.art_id AND X.gp_id = AGWW.gp_id AND A.dat = AGWW.dat
WHERE A.mandant_id > 1;


INSERT INTO dbp_etl.lagerbestand_erp_per_step03_2 (
    mandant_id, art_id, wup_id, nb_id, lagerort_id, dat,
    gp_id, posten_id, wrg_id, sperr_id, gjmo_buch, lagerort_loesch_fg, pflege_status, menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme, menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme, menge_lgbest_erp_gesamt_bme, menge_lgbest_erp_kolli, menge_lgbest_erp_palette, vk_netto,
    vk_netto_konz, betrag_vk_netto_lgbest_erp_frei, betrag_vk_netto_lgbest_erp_frei_konz, betrag_vk_netto_lgbest_erp_qual,
    betrag_vk_netto_lgbest_erp_qual_konz, betrag_vk_netto_lgbest_erp_gesamt, betrag_vk_netto_lgbest_erp_gesamt_konz,
    ek_netto, ek_netto_konz, betrag_ek_netto_lgbest_erp_frei, betrag_ek_netto_lgbest_erp_frei_konz,
    betrag_ek_netto_lgbest_erp_qual, betrag_ek_netto_lgbest_erp_qual_konz, ek_netto_bnk, ek_netto_bnk_konz,
    betrag_ek_netto_bnk_lgbest_erp_frei, betrag_ek_netto_bnk_lgbest_erp_frei_konz, betrag_ek_netto_bnk_lgbest_erp_qual,
    betrag_ek_netto_bnk_lgbest_erp_qual_konz, ek_nettonetto, ek_nettonetto_konz, betrag_ek_nettonetto_lgbest_erp_frei,
    betrag_ek_nettonetto_lgbest_erp_frei_konz, betrag_ek_nettonetto_lgbest_erp_qual,
    betrag_ek_nettonetto_lgbest_erp_qual_konz, ek_mep_olk, ek_mep_olk_konz, betrag_ek_mep_olk_lgbest_erp_frei,
    betrag_ek_mep_olk_lgbest_erp_frei_konz, betrag_ek_mep_olk_lgbest_erp_qual, betrag_ek_mep_olk_lgbest_erp_qual_konz,
    ek_einstandspreis, ek_einstandspreis_konz, betrag_ek_einstandspreis_lgbest_erp_frei,
    betrag_ek_einstandspreis_lgbest_erp_frei_konz, betrag_ek_einstandspreis_lgbest_erp_qual,
    betrag_ek_einstandspreis_lgbest_erp_qual_konz, ek_logistik, ek_logistik_konz, betrag_ek_logistik_lgbest_erp_gesamt,
    betrag_ek_logistik_lgbest_erp_gesamt_konz, td_update, td_insert
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    lagerort_id,
    dat,
    gp_id,
    posten_id,
    wrg_id,
    sperr_id,
    gjmo_buch,
    lagerort_loesch_fg,
    pflege_status,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme,
    menge_lgbest_erp_gesamt_bme,
    menge_lgbest_erp_kolli,
    menge_lgbest_erp_palette,
    vk_netto,
    vk_netto_konz,
    betrag_vk_netto_lgbest_erp_frei,
    betrag_vk_netto_lgbest_erp_frei_konz,
    betrag_vk_netto_lgbest_erp_qual,
    betrag_vk_netto_lgbest_erp_qual_konz,
    betrag_vk_netto_lgbest_erp_gesamt,
    betrag_vk_netto_lgbest_erp_gesamt_konz,
    ek_netto,
    ek_netto_konz,
    betrag_ek_netto_lgbest_erp_frei,
    betrag_ek_netto_lgbest_erp_frei_konz,
    betrag_ek_netto_lgbest_erp_qual,
    betrag_ek_netto_lgbest_erp_qual_konz,
    ek_netto_bnk,
    ek_netto_bnk_konz,
    betrag_ek_netto_bnk_lgbest_erp_frei,
    betrag_ek_netto_bnk_lgbest_erp_frei_konz,
    betrag_ek_netto_bnk_lgbest_erp_qual,
    betrag_ek_netto_bnk_lgbest_erp_qual_konz,
    ek_nettonetto,
    ek_nettonetto_konz,
    betrag_ek_nettonetto_lgbest_erp_frei,
    betrag_ek_nettonetto_lgbest_erp_frei_konz,
    betrag_ek_nettonetto_lgbest_erp_qual,
    betrag_ek_nettonetto_lgbest_erp_qual_konz,
    ek_mep_olk,
    ek_mep_olk_konz,
    betrag_ek_mep_olk_lgbest_erp_frei,
    betrag_ek_mep_olk_lgbest_erp_frei_konz,
    betrag_ek_mep_olk_lgbest_erp_qual,
    betrag_ek_mep_olk_lgbest_erp_qual_konz,
    ek_einstandspreis,
    ek_einstandspreis_konz,
    betrag_ek_einstandspreis_lgbest_erp_frei,
    betrag_ek_einstandspreis_lgbest_erp_frei_konz,
    betrag_ek_einstandspreis_lgbest_erp_qual,
    betrag_ek_einstandspreis_lgbest_erp_qual_konz,
    ek_logistik,
    ek_logistik_konz,
    betrag_ek_logistik_lgbest_erp_gesamt,
    betrag_ek_logistik_lgbest_erp_gesamt_konz,
    td_update,
    td_insert
FROM `_lagerbestand_erp_per_step03_kmo`);


CREATE OR REPLACE TEMPORARY TABLE _lagerbestand_erp_per_step04 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.lagerort_id,
    A.art_id,
    A.dat,
    A.gp_id,
    A.posten_id,
    A.menge_lgbest_erp_frei_bme,
    A.menge_lgbest_erp_umlag_bme,
    A.menge_lgbest_erp_qual_bme,
    A.menge_lgbest_erp_nf_charge_bme,
    A.menge_lgbest_erp_gesp_bme,
    A.menge_lgbest_erp_ret_gesp_bme,
    A.menge_lgbest_erp_gesamt_bme,
    A.sperr_id,
    A.gjmo_buch,
    A.lagerort_loesch_fg,
    A.pflege_status,
    A.menge_lgbest_erp_kolli,
    A.menge_lgbest_erp_palette,
    A.wrg_id,
    A.vk_netto,
    A.betrag_vk_netto_lgbest_erp_frei,
    A.betrag_vk_netto_lgbest_erp_qual,
    A.betrag_vk_netto_lgbest_erp_gesamt,
    A.vk_netto * D1.umrechnungskurs AS vk_netto_konz,
    A.betrag_vk_netto_lgbest_erp_frei * D1.umrechnungskurs AS betrag_vk_netto_lgbest_erp_frei_konz,
    A.betrag_vk_netto_lgbest_erp_qual * D1.umrechnungskurs AS betrag_vk_netto_lgbest_erp_qual_konz,
    A.betrag_vk_netto_lgbest_erp_gesamt * D1.umrechnungskurs AS betrag_vk_netto_lgbest_erp_gesamt_konz,
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
    A.td_insert,
    A.ek_logistik,
    A.betrag_ek_logistik_lgbest_erp_gesamt,
    A.betrag_ek_logistik_lgbest_erp_gesamt * D1.umrechnungskurs AS betrag_ek_logistik_lgbest_erp_gesamt_konz,
    A.ek_logistik * D1.umrechnungskurs AS ek_logistik_konz
FROM dbp_etl.lagerbestand_erp_per_step03_2 AS A
INNER JOIN dbp_data.kurs_2
    AS D1 ON A.wrg_id = D1.von_wrg_id AND D1.dat_bis = DATE '9999-12-31' AND D1.nach_wrg_id
= 'EUR' AND D1.kurstyp_id = 3;


CREATE OR REPLACE TEMPORARY TABLE _tage AS
SELECT dat
FROM `_lagerbestand_erp_per_step04`
GROUP BY dat;


CREATE OR REPLACE TEMPORARY TABLE _min_tage AS
SELECT MIN(dat) AS min_dat
FROM `_lagerbestand_erp_per_step04`;


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
        A.td_insert,
        A.td_update,
        A.mwst_id,
        A.oug_id,
        A.iwt_id
    FROM dbp_data.art_per_2 AS A
    INNER JOIN `_min_tage` AS B ON A.dat_bis >= B.min_dat
) AS a
INNER JOIN `_tage` AS B0 ON B0.dat BETWEEN a.dat_von AND a.dat_bis;


UPDATE `_lagerbestand_erp_per_step04` SET
    posten_id = b.posten_id
FROM `_art_per` AS b
WHERE
    `_lagerbestand_erp_per_step04`.dat = b.dat AND `_lagerbestand_erp_per_step04`.mandant_id = b.mandant_id AND
    `_lagerbestand_erp_per_step04`.art_id = b.art_id;


CREATE OR REPLACE TEMPORARY TABLE _lagerbestand_erp_per_step05 AS
SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    lagerort_id,
    dat,
    gp_id,
    posten_id,
    wrg_id,
    MAX(sperr_id) AS sperr_id,
    MAX(gjmo_buch) AS gjmo_buch,
    MAX(lagerort_loesch_fg) AS lagerort_loesch_fg,
    MAX(pflege_status) AS pflege_status,
    SUM(menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
    SUM(menge_lgbest_erp_umlag_bme) AS menge_lgbest_erp_umlag_bme,
    SUM(menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme,
    SUM(menge_lgbest_erp_nf_charge_bme) AS menge_lgbest_erp_nf_charge_bme,
    SUM(menge_lgbest_erp_gesp_bme) AS menge_lgbest_erp_gesp_bme,
    SUM(menge_lgbest_erp_ret_gesp_bme) AS menge_lgbest_erp_ret_gesp_bme,
    SUM(menge_lgbest_erp_gesamt_bme) AS menge_lgbest_erp_gesamt_bme,
    SUM(menge_lgbest_erp_kolli) AS menge_lgbest_erp_kolli,
    SUM(menge_lgbest_erp_palette) AS menge_lgbest_erp_palette,
    MAX(vk_netto) AS vk_netto,
    MAX(vk_netto_konz) AS vk_netto_konz,
    SUM(betrag_vk_netto_lgbest_erp_frei) AS betrag_vk_netto_lgbest_erp_frei,
    SUM(betrag_vk_netto_lgbest_erp_frei_konz) AS betrag_vk_netto_lgbest_erp_frei_konz,
    SUM(betrag_vk_netto_lgbest_erp_qual) AS betrag_vk_netto_lgbest_erp_qual,
    SUM(betrag_vk_netto_lgbest_erp_qual_konz) AS betrag_vk_netto_lgbest_erp_qual_konz,
    SUM(betrag_vk_netto_lgbest_erp_gesamt) AS betrag_vk_netto_lgbest_erp_gesamt,
    SUM(betrag_vk_netto_lgbest_erp_gesamt_konz) AS betrag_vk_netto_lgbest_erp_gesamt_konz,
    MAX(ek_netto) AS ek_netto,
    MAX(ek_netto_konz) AS ek_netto_konz,
    SUM(betrag_ek_netto_lgbest_erp_frei) AS betrag_ek_netto_lgbest_erp_frei,
    SUM(betrag_ek_netto_lgbest_erp_frei_konz) AS betrag_ek_netto_lgbest_erp_frei_konz,
    SUM(betrag_ek_netto_lgbest_erp_qual) AS betrag_ek_netto_lgbest_erp_qual,
    SUM(betrag_ek_netto_lgbest_erp_qual_konz) AS betrag_ek_netto_lgbest_erp_qual_konz,
    MAX(ek_netto_bnk) AS ek_netto_bnk,
    MAX(ek_netto_bnk_konz) AS ek_netto_bnk_konz,
    SUM(betrag_ek_netto_bnk_lgbest_erp_frei) AS betrag_ek_netto_bnk_lgbest_erp_frei,
    SUM(betrag_ek_netto_bnk_lgbest_erp_frei_konz) AS betrag_ek_netto_bnk_lgbest_erp_frei_konz,
    SUM(betrag_ek_netto_bnk_lgbest_erp_qual) AS betrag_ek_netto_bnk_lgbest_erp_qual,
    SUM(betrag_ek_netto_bnk_lgbest_erp_qual_konz) AS betrag_ek_netto_bnk_lgbest_erp_qual_konz,
    MAX(ek_nettonetto) AS ek_nettonetto,
    MAX(ek_nettonetto_konz) AS ek_nettonetto_konz,
    SUM(betrag_ek_nettonetto_lgbest_erp_frei) AS betrag_ek_nettonetto_lgbest_erp_frei,
    SUM(betrag_ek_nettonetto_lgbest_erp_frei_konz) AS betrag_ek_nettonetto_lgbest_erp_frei_konz,
    SUM(betrag_ek_nettonetto_lgbest_erp_qual) AS betrag_ek_nettonetto_lgbest_erp_qual,
    SUM(betrag_ek_nettonetto_lgbest_erp_qual_konz) AS betrag_ek_nettonetto_lgbest_erp_qual_konz,
    MAX(ek_mep_olk) AS ek_mep_olk,
    MAX(ek_mep_olk_konz) AS ek_mep_olk_konz,
    SUM(betrag_ek_mep_olk_lgbest_erp_frei) AS betrag_ek_mep_olk_lgbest_erp_frei,
    SUM(betrag_ek_mep_olk_lgbest_erp_frei_konz) AS betrag_ek_mep_olk_lgbest_erp_frei_konz,
    SUM(betrag_ek_mep_olk_lgbest_erp_qual) AS betrag_ek_mep_olk_lgbest_erp_qual,
    SUM(betrag_ek_mep_olk_lgbest_erp_qual_konz) AS betrag_ek_mep_olk_lgbest_erp_qual_konz,
    MAX(ek_einstandspreis) AS ek_einstandspreis,
    MAX(ek_einstandspreis_konz) AS ek_einstandspreis_konz,
    SUM(betrag_ek_einstandspreis_lgbest_erp_frei) AS betrag_ek_einstandspreis_lgbest_erp_frei,
    SUM(betrag_ek_einstandspreis_lgbest_erp_frei_konz) AS betrag_ek_einstandspreis_lgbest_erp_frei_konz,
    SUM(betrag_ek_einstandspreis_lgbest_erp_qual) AS betrag_ek_einstandspreis_lgbest_erp_qual,
    SUM(betrag_ek_einstandspreis_lgbest_erp_qual_konz) AS betrag_ek_einstandspreis_lgbest_erp_qual_konz,
    MAX(ek_logistik) AS ek_logistik,
    MAX(ek_logistik_konz) AS ek_logistik_konz,
    SUM(betrag_ek_logistik_lgbest_erp_gesamt) AS betrag_ek_logistik_lgbest_erp_gesamt,
    SUM(betrag_ek_logistik_lgbest_erp_gesamt_konz) AS betrag_ek_logistik_lgbest_erp_gesamt_konz,
    MAX(CURRENT_TIMESTAMP()) AS td_update,
    MAX(CURRENT_TIMESTAMP()) AS td_insert
FROM `_lagerbestand_erp_per_step04`
GROUP BY
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    lagerort_id,
    dat,
    gp_id,
    posten_id,
    wrg_id;


DELETE FROM dbp_msi_data.lagerbestand_erp_tag_sum_2
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 5 DAY) AND (CURRENT_DATE("Europe/Berlin"));


INSERT INTO dbp_msi_data.lagerbestand_erp_tag_sum_2 (
    mandant_id, art_id, wup_id, nb_id, lagerort_id, dat,
    gp_id, posten_id, wrg_id, umrechnungskurs_hist, sperr_id, gjmo_buch, lagerort_loesch_fg, pflege_status,
    menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme, menge_lgbest_erp_gesamt_bme, menge_lgbest_erp_kolli,
    menge_lgbest_erp_palette, vk_netto, vk_netto_konz, betrag_vk_netto_lgbest_erp_frei,
    betrag_vk_netto_lgbest_erp_frei_konz, betrag_vk_netto_lgbest_erp_qual, betrag_vk_netto_lgbest_erp_qual_konz,
    betrag_vk_netto_lgbest_erp_gesamt, betrag_vk_netto_lgbest_erp_gesamt_konz, ek_netto, ek_netto_konz,
    betrag_ek_netto_lgbest_erp_frei, betrag_ek_netto_lgbest_erp_frei_konz, betrag_ek_netto_lgbest_erp_qual,
    betrag_ek_netto_lgbest_erp_qual_konz, ek_netto_bnk, ek_netto_bnk_konz, betrag_ek_netto_bnk_lgbest_erp_frei,
    betrag_ek_netto_bnk_lgbest_erp_frei_konz, betrag_ek_netto_bnk_lgbest_erp_qual, betrag_ek_netto_bnk_lgbest_erp_qual_konz,
    ek_nettonetto, ek_nettonetto_konz, betrag_ek_nettonetto_lgbest_erp_frei, betrag_ek_nettonetto_lgbest_erp_frei_konz,
    betrag_ek_nettonetto_lgbest_erp_qual, betrag_ek_nettonetto_lgbest_erp_qual_konz, ek_mep_olk, ek_mep_olk_konz,
    betrag_ek_mep_olk_lgbest_erp_frei, betrag_ek_mep_olk_lgbest_erp_frei_konz, betrag_ek_mep_olk_lgbest_erp_qual,
    betrag_ek_mep_olk_lgbest_erp_qual_konz, ek_einstandspreis, ek_einstandspreis_konz,
    betrag_ek_einstandspreis_lgbest_erp_frei, betrag_ek_einstandspreis_lgbest_erp_frei_konz,
    betrag_ek_einstandspreis_lgbest_erp_qual, betrag_ek_einstandspreis_lgbest_erp_qual_konz, ek_logistik, ek_logistik_konz,
    betrag_ek_logistik_lgbest_erp_gesamt, betrag_ek_logistik_lgbest_erp_gesamt_konz, td_update, td_insert
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.lagerort_id,
        A.dat,
        A.gp_id,
        A.posten_id,
        A.wrg_id,
        K.umrechnungskurs AS umrechnungskurs_hist,
        A.sperr_id,
        A.gjmo_buch,
        A.lagerort_loesch_fg,
        A.pflege_status,
        A.menge_lgbest_erp_frei_bme,
        A.menge_lgbest_erp_umlag_bme,
        A.menge_lgbest_erp_qual_bme,
        A.menge_lgbest_erp_nf_charge_bme,
        A.menge_lgbest_erp_gesp_bme,
        A.menge_lgbest_erp_ret_gesp_bme,
        A.menge_lgbest_erp_gesamt_bme,
        A.menge_lgbest_erp_kolli,
        A.menge_lgbest_erp_palette,
        A.vk_netto,
        A.vk_netto_konz,
        A.betrag_vk_netto_lgbest_erp_frei,
        A.betrag_vk_netto_lgbest_erp_frei_konz,
        A.betrag_vk_netto_lgbest_erp_qual,
        A.betrag_vk_netto_lgbest_erp_qual_konz,
        A.betrag_vk_netto_lgbest_erp_gesamt,
        A.betrag_vk_netto_lgbest_erp_gesamt_konz,
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
        A.ek_logistik,
        A.ek_logistik_konz,
        A.betrag_ek_logistik_lgbest_erp_gesamt,
        A.betrag_ek_logistik_lgbest_erp_gesamt_konz,
        A.td_update,
        A.td_insert
    FROM `_lagerbestand_erp_per_step04` AS A
    LEFT JOIN dbp_data.kurs_2 AS K
        ON
            A.wrg_id = K.von_wrg_id AND A.dat BETWEEN K.dat_von AND K.dat_bis AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3
    WHERE A.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 5 DAY) AND (CURRENT_DATE("Europe/Berlin"))
);
