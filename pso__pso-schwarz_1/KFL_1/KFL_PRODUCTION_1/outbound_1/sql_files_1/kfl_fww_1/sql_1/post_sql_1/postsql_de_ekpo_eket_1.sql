CREATE OR REPLACE TEMPORARY TABLE _track1 AS
SELECT
    EKET.mandant_id,
    EKET.dat_lief_wunsch,
    EKET.best_beleg_id,
    EKET.best_beleg_pos_id
FROM dbp_data.lief_einteilung_1 AS EKET
LEFT JOIN dbp_data.besch_best_det_1 AS EKPO_1
    ON
        EKET.mandant_id = EKPO.mandant_id AND EKET.best_beleg_id =
        EKPO.best_beleg_id AND EKET.best_beleg_pos_id = EKPO.best_beleg_pos_id
WHERE
    EKET.mandant_id = 1
    AND EKET.dat_lief_wunsch >= CURRENT_DATE("Europe/Berlin")
    AND EKPO.loesch_fg IS NULL
GROUP BY
    EKET.mandant_id,
    EKET.dat_lief_wunsch,
    EKET.best_beleg_id,
    EKET.best_beleg_pos_id;


CREATE OR REPLACE TABLE dbp_etl.besch_best_det_eket_tmp_1 (
    mandant_id INTEGER NOT NULL,
    best_beleg_id INTEGER NOT NULL,
    best_beleg_pos_id INTEGER NOT NULL,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    lagerort_id STRING(4),
    loesch_fg INTEGER,
    menge_best_bme NUMERIC(29, 3),
    selbstabhol_fg INTEGER,
    best_preis_menge_einh_id STRING(3),
    best_menge_einh_id STRING(3),
    menge_best_kolli NUMERIC(29, 3),
    menge_best_palette NUMERIC(29, 3),
    endlief_fg INTEGER,
    dat_aenderung DATE,
    kunde_id STRING(10),
    dat_best_beleg DATE,
    wg_verkett_id INTEGER,
    fremd_lagerort_id STRING(4),
    ean_id INTEGER,
    betrag_kond_zw_sum2 NUMERIC(29, 4),
    pos_kostenlos_fg INTEGER,
    betrag_pos_netto NUMERIC(29, 4),
    betrag_pos_netto_best_wrg NUMERIC(29, 4),
    wrg_id STRING(3),
    betrag_best NUMERIC(29, 4),
    gp_id INTEGER,
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    komponentenmenge NUMERIC(29, 4),
    kopf_wup_id INTEGER,
    gp_teilsortiment_id STRING(10) COLLATE 'und:ci',
    zentral_best_fg INTEGER,
    dat_best_beleg_orig DATE,
    anforderer_name STRING(20) COLLATE 'und:ci'
);


/* zentral */ -- 0)
/* dezentral (lager kann nicht richtig sein) */ /* dezentral (lager kann nicht richtig sein) */
/* zentral */ -- 0)
/* zentral */ -- 0)
/* dezentral (lager kann nicht richtig sein) */ -- 0)
INSERT INTO
dbp_etl.besch_best_det_eket_tmp_1 (
    mandant_id, best_beleg_id, best_beleg_pos_id, art_id, wup_id, nb_id,
    lagerort_id, loesch_fg, menge_best_bme, selbstabhol_fg, best_preis_menge_einh_id, best_menge_einh_id, menge_best_kolli,
    menge_best_palette, endlief_fg, dat_aenderung, kunde_id, dat_best_beleg, wg_verkett_id, fremd_lagerort_id, ean_id,
    betrag_kond_zw_sum2, pos_kostenlos_fg, betrag_pos_netto, betrag_pos_netto_best_wrg, wrg_id, betrag_best, gp_id,
    ek_netto_bnk, ek_netto, komponentenmenge, kopf_wup_id, gp_teilsortiment_id, zentral_best_fg, dat_best_beleg_orig,
    anforderer_name
)
(
    SELECT
        EKPO.mandant_id,
        EKPO.best_beleg_id,
        EKPO.best_beleg_pos_id,
        EKPO.art_id,
        EKPO.wup_id,
        EKPO.nb_id,
        EKPO.lagerort_id,
        EKPO.loesch_fg,
        EKPO.menge_best_bme,
        EKPO.selbstabhol_fg,
        EKPO.best_preis_menge_einh_id,
        EKPO.best_menge_einh_id,
        EKPO.menge_best_kolli,
        EKPO.menge_best_palette,
        EKPO.endlief_fg,
        EKPO.dat_aenderung,
        EKPO.kunde_id,
        Y.dat_best_beleg,
        EKPO.wg_verkett_id,
        EKPO.fremd_lagerort_id,
        CAST(EKPO.ean_id AS INTEGER) AS ean_id,
        EKPO.betrag_kond_zw_sum2,
        EKPO.pos_kostenlos_fg,
        EKPO.betrag_pos_netto,
        EKPO.betrag_pos_netto_best_wrg,
        EKPO.wrg_id,
        EKPO.betrag_best,
        GP.gp_id,
        CASE
            WHEN EKPO.nb_id_ber IN (99, -111)
                THEN COALESCE(
                    AGW.ek_netto_bnk, AGW2.ek_netto_bnk, AGW3.ek_netto_bnk, AGW4.ek_netto_bnk, AGW5.ek_netto_bnk, AGW6.ek_netto_bnk,
                    AGW7.ek_netto_bnk, AGW8.ek_netto_bnk, AGW9.ek_netto_bnk, AGW10.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk,
                    0
                )
            ELSE COALESCE(
                AGW9.ek_netto_bnk, AGW10.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, AGW2.ek_netto_bnk, AGW4.ek_netto_bnk, AGW6.ek_netto_bnk, AGW8.ek_netto_bnk, 0
            )
        END AS ek_netto_bnk_,
        CASE
            WHEN EKPO.nb_id_ber IN (99, -111)
                THEN COALESCE(
                    AGW.ek_netto, AGW2.ek_netto, AGW3.ek_netto, AGW4.ek_netto, AGW5.ek_netto, AGW6.ek_netto, AGW7.ek_netto,
                    AGW8.ek_netto, AGW9.ek_netto, AGW10.ek_netto, AGW11.ek_netto, AGW12.ek_netto, 0
                )
            ELSE COALESCE(
                AGW9.ek_netto, AGW10.ek_netto, AGW11.ek_netto, AGW12.ek_netto, AGW2.ek_netto, AGW4.ek_netto, AGW6.ek_netto,
                AGW8.ek_netto, 0
            )
        END AS ek_netto_,
        CASE
            WHEN EKPO.nb_id_ber IN (99, -111)
                THEN COALESCE(
                    AGW.komponentenmenge, AGW2.komponentenmenge, AGW3.komponentenmenge, AGW4.komponentenmenge, AGW5.komponentenmenge,
                    AGW6.komponentenmenge, AGW7.komponentenmenge, AGW8.komponentenmenge, AGW9.komponentenmenge, AGW10.komponentenmenge,
                    AGW11.komponentenmenge, AGW12.komponentenmenge, 1
                )
            ELSE COALESCE(
                AGW9.komponentenmenge, AGW10.komponentenmenge, AGW11.komponentenmenge, AGW12.komponentenmenge, AGW2.komponentenmenge,
                AGW4.komponentenmenge, AGW6.komponentenmenge, AGW8.komponentenmenge, 1
            )
        END AS komponentenmenge_,
        EKPO.kopf_wup_id,
        EKPO.gp_teilsortiment_id,
        EKPO.zentral_best_fg,
        X.dat_lief_wunsch,
        EKPO.anforderer_name
    FROM dbp_etl.de_ekpo_eket AS EKPO_1
    INNER JOIN dbp_data.besch_best_1 AS Y ON EKPO.mandant_id = Y.mandant_id AND EKPO.best_beleg_id = Y.best_beleg_id

    INNER JOIN `_track1` AS X
        ON
            EKPO.mandant_id = X.mandant_id AND EKPO.best_beleg_id = X.best_beleg_id AND EKPO.best_beleg_pos_id
            = X.best_beleg_pos_id -- ek_preis holen

    LEFT JOIN dbp_data.art_gp_zu_per_1 AS GP_1
        ON
            EKPO.art_id = GP.art_id AND EKPO.mandant_id = GP.mandant_id
            AND EKPO.dat_best_beleg BETWEEN GP.dat_von AND GP.dat_bis
    /* zentral
        lager       richtig
        datum       richtig
        lieferant   richtig */
    LEFT JOIN dbp_etl.ek01_ekpo_1 AS AGW
        ON
            EKPO.art_id = AGW.art_id AND EKPO.dat_best_beleg BETWEEN AGW.dat_von
            AND AGW.dat_bis /* richtiges datum */ AND EKPO.werks_ber = AGW.wup_id /* richtiges lager */ AND GP.gp_id = AGW.gp_id
    /* richtiger lieferant */ /* zentral
        lager       falsch
        datum       richtig
        lieferant   richtig */
    LEFT JOIN dbp_etl.ek02_ekpo_1 AS AGW2
        ON
            EKPO.art_id = AGW2.art_id AND EKPO.dat_best_beleg BETWEEN AGW2.dat_von
            AND AGW2.dat_bis /* richtiges datum */ AND GP.gp_id = AGW2.gp_id /* richtiger lieferant */
        /* zentral
        lager       richtig
        datum       falsch
        lieferant   richtig */
    LEFT JOIN dbp_etl.ek03_ekpo_1 AS AGW3
        ON EKPO.art_id = AGW3.art_id AND EKPO.werks_ber = AGW3.wup_id
        /* richtiges lager */ AND GP.gp_id = AGW3.gp_id /* richtiger lieferant */
        /* zentral
        lager       falsch
        datum       falsch
        lieferant   richtig */
    LEFT JOIN dbp_etl.ek04_ekpo_1 AS AGW4 ON EKPO.art_id = AGW4.art_id AND GP.gp_id = AGW4.gp_id
    /* richtiger lieferant */ /* zentral
        lager       richtig
        datum       richtig
        lieferant   falsch */
    LEFT JOIN dbp_etl.ek05_ekpo_1 AS AGW5
        ON
            EKPO.art_id = AGW5.art_id AND EKPO.dat_best_beleg BETWEEN AGW5.dat_von
            AND AGW5.dat_bis /* richtiges datum */ AND EKPO.werks_ber = AGW5.wup_id /* richtiges lager */
        /* zentral
        lager       falsch
        datum       richtig
        lieferant   falsch */
    LEFT JOIN dbp_etl.ek06_ekpo_1 AS AGW6
        ON
            EKPO.art_id = AGW6.art_id AND EKPO.dat_best_beleg BETWEEN AGW6.dat_von
            AND AGW6.dat_bis /* richtiges datum */ /* zentral
        lager       richtig
        datum       falsch
        lieferant   falsch */
    LEFT JOIN dbp_etl.ek07_ekpo_1 AS AGW7 ON EKPO.art_id = AGW7.art_id AND EKPO.werks_ber = AGW7.wup_id
    /* richtiges lager */ /* zentral
        lager       falsch
        datum       falsch
        lieferant   falsch */
    LEFT JOIN dbp_etl.ek08_ekpo_1 AS AGW8 ON EKPO.art_id = AGW8.art_id
    /* dezentral
        lager       -1
        datum       richtig
        lieferant   richtig */
    LEFT JOIN dbp_etl.ek09_ekpo_1 AS AGW9
        ON EKPO.art_id = AGW9.art_id AND GP.gp_id = AGW9.gp_id
        /* richtiger lieferant */ AND EKPO.dat_best_beleg BETWEEN AGW9.dat_von AND AGW9.dat_bis /* richtiges datum */
        /* dezentral
        lager       -1
        datum       falsch
        lieferant   richtig */
    LEFT JOIN dbp_etl.ek10_ekpo_1 AS AGW10 ON EKPO.art_id = AGW10.art_id AND GP.gp_id = AGW10.gp_id
    /* richtiger lieferant */ /* dezentral
        lager       -1
        datum       richtig
        lieferant   falsch */
    LEFT JOIN dbp_etl.ek11_ekpo_1 AS AGW11
        ON
            EKPO.art_id = AGW11.art_id AND EKPO.dat_best_beleg BETWEEN
            AGW11.dat_von AND AGW11.dat_bis /* richtiges datum */
        /* dezentral
        lager       -1
        datum       falsch
        lieferant   falsch */
    LEFT JOIN dbp_etl.ek12_ekpo_1 AS AGW12 ON EKPO.art_id = AGW12.art_id
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY EKPO.mandant_id, EKPO.best_beleg_id, EKPO.best_beleg_pos_id ORDER BY CAST(CASE
        WHEN EKPO.nb_id_ber IN (99, -111)
            THEN COALESCE(AGW.ek_netto_bnk, AGW2.ek_netto_bnk, AGW3.ek_netto_bnk, AGW4.ek_netto_bnk, AGW5.ek_netto_bnk, AGW6.ek_netto_bnk, AGW7.ek_netto_bnk, AGW8.ek_netto_bnk, AGW9.ek_netto_bnk, AGW10.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, 0)
        ELSE COALESCE(AGW9.ek_netto_bnk, AGW10.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, AGW2.ek_netto_bnk, AGW4.ek_netto_bnk, AGW6.ek_netto_bnk, AGW8.ek_netto_bnk, 0)
    END AS NUMERIC) IS NULL DESC, CAST(CASE
        WHEN EKPO.nb_id_ber IN (99, -111)
            THEN COALESCE(AGW.ek_netto_bnk, AGW2.ek_netto_bnk, AGW3.ek_netto_bnk, AGW4.ek_netto_bnk, AGW5.ek_netto_bnk, AGW6.ek_netto_bnk, AGW7.ek_netto_bnk, AGW8.ek_netto_bnk, AGW9.ek_netto_bnk, AGW10.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, 0)
        ELSE COALESCE(AGW9.ek_netto_bnk, AGW10.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, AGW2.ek_netto_bnk, AGW4.ek_netto_bnk, AGW6.ek_netto_bnk, AGW8.ek_netto_bnk, 0)
    END AS NUMERIC) DESC, CASE
        WHEN EKPO.nb_id_ber IN (99, -111)
            THEN COALESCE(
                AGW.komponentenmenge, AGW2.komponentenmenge, AGW3.komponentenmenge, AGW4.komponentenmenge, AGW5.komponentenmenge,
                AGW6.komponentenmenge, AGW7.komponentenmenge, AGW8.komponentenmenge, AGW9.komponentenmenge, AGW10.komponentenmenge,
                AGW11.komponentenmenge, AGW12.komponentenmenge, 1
            )
        ELSE COALESCE(
            AGW9.komponentenmenge, AGW10.komponentenmenge, AGW11.komponentenmenge, AGW12.komponentenmenge,
            AGW2.komponentenmenge, AGW4.komponentenmenge, AGW6.komponentenmenge, AGW8.komponentenmenge, 1
        )
    END IS NULL DESC, CASE
        WHEN EKPO.nb_id_ber IN (99, -111)
            THEN COALESCE(
                AGW.komponentenmenge, AGW2.komponentenmenge, AGW3.komponentenmenge, AGW4.komponentenmenge, AGW5.komponentenmenge,
                AGW6.komponentenmenge, AGW7.komponentenmenge, AGW8.komponentenmenge, AGW9.komponentenmenge, AGW10.komponentenmenge,
                AGW11.komponentenmenge, AGW12.komponentenmenge, 1
            )
        ELSE COALESCE(
            AGW9.komponentenmenge, AGW10.komponentenmenge, AGW11.komponentenmenge, AGW12.komponentenmenge,
            AGW2.komponentenmenge, AGW4.komponentenmenge, AGW6.komponentenmenge, AGW8.komponentenmenge, 1
        )
    END DESC)) = 1
);


CREATE OR REPLACE TEMPORARY TABLE _ekpo_eket AS
-- datum ermitteln
-- umrechnungsfaktor fuer basismenge mit umrechnungsfaktor aus der bestellung holen
SELECT
    T.mandant_id
    ,
    T.best_beleg_id,
    T.best_beleg_pos_id,
    T.art_id,
    T.wup_id,
    T.nb_id,
    T.lagerort_id,
    T.loesch_fg,
    CAST(
        T.menge_best_kolli / COALESCE(aukolli.umrech_faktor, aukolli_alternativ.umrech_faktor, 1) AS NUMERIC) AS
    menge_best_neu,
    T.selbstabhol_fg,
    T.best_preis_menge_einh_id,
    T.best_menge_einh_id,
    T.menge_best_kolli,
    CASE
        WHEN aupalette.umrech_faktor IS NULL
            THEN CAST(T.menge_best_kolli / COALESCE(aukolli.umrech_faktor, aukolli_alternativ.umrech_faktor, 1) AS NUMERIC)
        ELSE ROUND(CAST(
            CAST(T.menge_best_kolli / COALESCE(aukolli.umrech_faktor, aukolli_alternativ.umrech_faktor, 1) AS NUMERIC)
            * aupalette.umrech_faktor AS NUMERIC
        ), 3)
    END AS menge_best_palette,
    T.endlief_fg,
    T.dat_aenderung,
    T.kunde_id,
    T.dat_best_beleg,
    T.ean_id,
    T.betrag_kond_zw_sum2,
    T.pos_kostenlos_fg,
    T.betrag_pos_netto,
    T.betrag_pos_netto_best_wrg,
    T.wrg_id,
    ROUND(CAST(
        T.menge_best_kolli / COALESCE(aukolli.umrech_faktor, aukolli_alternativ.umrech_faktor, 1) AS NUMERIC) * CAST(
        CAST(T.ek_netto_bnk AS NUMERIC)
        * T.komponentenmenge AS NUMERIC
    ), 2) AS betrag_best,
    T.gp_teilsortiment_id,
    0 AS menge_block_bestand,
    CASE
        WHEN WGFZ.wg_id IS NOT NULL
            THEN 1
        ELSE 0
    END AS flw_fg,
    T.zentral_best_fg,
    T.anforderer_name
FROM dbp_etl.besch_best_det_eket_tmp_1 AS T
INNER JOIN (SELECT
    best_beleg_id,
    dat_best_beleg
FROM dbp_data.besch_best_1
WHERE mandant_id = 1) AS la ON T.best_beleg_id = la.best_beleg_id
LEFT JOIN dbp_data.art_wg_zu_per_1 AS AWZP
    ON
        AWZP.mandant_id = 1 AND T.art_id = AWZP.art_id AND AWZP.arthiertyp_id
        = 2 AND AWZP.dat_bis = PARSE_DATE('%F', '9999-12-31')
LEFT JOIN (SELECT
    art_id,
    altnv_menge_einh_id,
    dat_von,
    dat_bis,
    umrech_faktor
FROM dbp_data.art_umrechnung_faktor_per_1
WHERE mandant_id = 1) AS aukolli
    ON
        T.art_id = aukolli.art_id AND T.best_menge_einh_id = aukolli.altnv_menge_einh_id
        AND la.dat_best_beleg BETWEEN aukolli.dat_von AND aukolli.dat_bis -- palettenfaktor und default mengeneinheit holen

LEFT JOIN (SELECT
    art_id,
    paletten_faktor_einh_id,
    ausg_menge_einh_id,
    dat_von,
    dat_bis
FROM dbp_data.art_vorschlagswert_per_1
WHERE mandant_id = 1) AS av ON T.art_id = av.art_id AND la.dat_best_beleg BETWEEN av.dat_von AND av.dat_bis
-- umrechnungsfaktor fuer palettenfaktor holen

LEFT JOIN (SELECT
    art_id,
    umrech_faktor,
    altnv_menge_einh_id,
    dat_von,
    dat_bis
FROM dbp_data.art_umrechnung_faktor_per_1
WHERE mandant_id = 1) AS aupalette
    ON
        T.art_id = aupalette.art_id AND av.paletten_faktor_einh_id = aupalette.altnv_menge_einh_id
        AND la.dat_best_beleg BETWEEN aupalette.dat_von AND aupalette.dat_bis
-- default umrechnungsfaktor fuer basismenge holen, wenn umrechnungsfaktor aus bestellung null ist

LEFT JOIN (SELECT
    art_id,
    altnv_menge_einh_id,
    dat_von,
    dat_bis,
    umrech_faktor
FROM dbp_data.art_umrechnung_faktor_per_1
WHERE mandant_id = 1) AS aukolli_alternativ
    ON
        T.art_id = aukolli_alternativ.art_id AND av.ausg_menge_einh_id =
        aukolli_alternativ.altnv_menge_einh_id AND la.dat_best_beleg BETWEEN aukolli_alternativ.dat_von AND
        aukolli_alternativ.dat_bis
LEFT JOIN dbp_data.wg_filter_zu_1
    AS WGFZ ON AWZP.wg_id = WGFZ.wg_id AND AWZP.mandant_id = WGFZ.mandant_id
AND WGFZ.wg_filter_id = 23 AND WGFZ.arthiertyp_id = 2;


INSERT INTO dbp_data.besch_best_det_1 (
    mandant_id, best_beleg_id, best_beleg_pos_id, art_id, wup_id, nb_id,
    lagerort_id, loesch_fg, menge_best_bme, selbstabhol_fg, best_preis_menge_einh_id, menge_best_kolli,
    menge_best_palette, endlief_fg, dat_aenderung, kunde_id, dat_best_beleg, best_menge_einh_id, ean_id,
    betrag_kond_zw_sum2, pos_kostenlos_fg, betrag_pos_netto, betrag_pos_netto_best_wrg, wrg_id, betrag_best,
    menge_block_bestand, gp_teilsortiment_id, flw_fg, zentral_best_fg, anforderer_name
)
(SELECT
    mandant_id,
    best_beleg_id,
    best_beleg_pos_id,
    art_id,
    wup_id,
    nb_id,
    lagerort_id,
    loesch_fg,
    menge_best_neu AS menge_best_bme,
    selbstabhol_fg,
    best_preis_menge_einh_id,
    menge_best_kolli,
    menge_best_palette,
    endlief_fg,
    dat_aenderung,
    kunde_id,
    dat_best_beleg,
    best_menge_einh_id,
    ean_id,
    betrag_kond_zw_sum2,
    pos_kostenlos_fg,
    betrag_pos_netto,
    betrag_pos_netto_best_wrg,
    wrg_id,
    betrag_best,
    menge_block_bestand,
    gp_teilsortiment_id,
    flw_fg,
    zentral_best_fg,
    anforderer_name
FROM `_ekpo_eket`);
