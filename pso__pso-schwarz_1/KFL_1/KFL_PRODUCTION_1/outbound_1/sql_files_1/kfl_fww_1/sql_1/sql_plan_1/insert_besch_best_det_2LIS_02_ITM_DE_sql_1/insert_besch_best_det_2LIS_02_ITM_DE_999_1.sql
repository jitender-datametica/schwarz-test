CREATE OR REPLACE TABLE dbp_etl.ek01_ekpo_1 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek02_ekpo_1 (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek03_ekpo_1 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek04_ekpo_1 (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek05_ekpo_1 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek06_ekpo_1 (
    art_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek07_ekpo_1 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek08_ekpo_1 (
    art_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek09_ekpo_1 (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek10_ekpo_1 (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek11_ekpo_1 (
    art_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek12_ekpo_1 (
    art_id INTEGER NOT NULL,
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    komponentenmenge NUMERIC(29, 4)
);


INSERT INTO dbp_etl.ek01_ekpo_1 (
    art_id, wup_id, gp_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk,
    ek_netto
)
(
    SELECT
        art_id,
        wup_id,
        gp_id,
        dat_von,
        dat_bis,
        komponentenmenge,
        ek_netto_bnk,
        ek_netto
    FROM dbp_data.art_gp_wup_zu_per_1
    WHERE
        nb_id IN (99, -111)
        AND bezugsweg_id = 4
        AND ek_kal_basis > 0
        AND mandant_id = 1
);


INSERT INTO dbp_etl.ek02_ekpo_1 (
    art_id, gp_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto
)
(SELECT
    art_id,
    gp_id,
    dat_von,
    dat_bis,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto
FROM dbp_data.art_gp_wup_zu_per_1
WHERE
    nb_id IN (99, -111)
    AND bezugsweg_id = 4
    AND ek_kal_basis > 0
    AND mandant_id = 1
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, dat_von, gp_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto
        IS NULL DESC,
        ek_brutto DESC,
        gp_id IS NULL,
        gp_id,
        ek_mep IS NULL DESC,
        ek_mep DESC,
        ek_kal_basis IS NULL DESC,
        ek_kal_basis DESC
)) = 1);


INSERT INTO dbp_etl.ek03_ekpo_1 (
    art_id, wup_id, gp_id, komponentenmenge, ek_netto_bnk, ek_netto
)
(SELECT
    art_id,
    wup_id,
    gp_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto
FROM dbp_data.art_gp_wup_zu_per_1
WHERE
    nb_id IN (99, -111)
    AND bezugsweg_id = 4
    AND ek_kal_basis > 0
    AND mandant_id = 1
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, gp_id, wup_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto
        IS NULL DESC,
        ek_brutto DESC,
        gp_id IS NULL,
        gp_id,
        ek_mep IS NULL DESC,
        ek_mep DESC,
        ek_kal_basis IS NULL DESC,
        ek_kal_basis DESC
)) = 1);


INSERT INTO dbp_etl.ek04_ekpo_1 (
    art_id, gp_id, komponentenmenge, ek_netto_bnk, ek_netto
)
(SELECT
    art_id,
    gp_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto
FROM dbp_data.art_gp_wup_zu_per_1
WHERE
    nb_id IN (99, -111)
    AND bezugsweg_id = 4
    AND ek_kal_basis > 0
    AND mandant_id = 1
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, gp_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto IS NULL
        DESC,
        ek_brutto DESC,
        gp_id IS NULL,
        gp_id,
        ek_mep IS NULL DESC,
        ek_mep DESC,
        ek_kal_basis IS NULL DESC,
        ek_kal_basis DESC
)) = 1);


INSERT INTO dbp_etl.ek05_ekpo_1 (
    art_id, wup_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto
)
(
    SELECT
        AGW5_1.art_id,
        AGW5_1.wup_id,
        CASE
            WHEN AGW5_1.dat_von > AGW5_2.dat_von
                THEN AGW5_1.dat_von
            ELSE AGW5_2.dat_von
        END AS dat_von,
        CASE
            WHEN AGW5_1.dat_bis < AGW5_2.dat_bis
                THEN AGW5_1.dat_bis
            ELSE AGW5_2.dat_bis
        END AS dat_bis,
        AGW5_1.komponentenmenge,
        AGW5_1.ek_netto_bnk,
        AGW5_1.ek_netto
    FROM dbp_data.art_gp_wup_zu_per_1 AS AGW5_1
    INNER JOIN dbp_data.art_gp_zu_per_1 AS AGW5_2
        ON
            AGW5_1.art_id = AGW5_2.art_id AND AGW5_1.gp_id = AGW5_2
            .gp_id AND (
                AGW5_1.dat_von BETWEEN AGW5_2.dat_von AND AGW5_2.dat_bis
                OR AGW5_2.dat_von BETWEEN AGW5_1.dat_von AND
                AGW5_1.dat_bis
            )
            AND AGW5_1.mandant_id = AGW5_2.mandant_id
            AND AGW5_1.einkaufsorganisation_id
            = AGW5_2.einkaufsorganisation_id

    WHERE
        AGW5_1.nb_id IN (99, -111)
        AND AGW5_1.bezugsweg_id = 4
        AND AGW5_1.ek_kal_basis > 0
        AND AGW5_1.mandant_id = 1
);


INSERT INTO dbp_etl.ek06_ekpo_1 (
    art_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto
)
(
    SELECT
        AGW6_1.art_id,
        CASE
            WHEN AGW6_1.dat_von > AGW6_2.dat_von
                THEN AGW6_1.dat_von
            ELSE AGW6_2.dat_von
        END AS dat_von,
        CASE
            WHEN AGW6_1.dat_bis < AGW6_2.dat_bis
                THEN AGW6_1.dat_bis
            ELSE AGW6_2.dat_bis
        END AS dat_bis,
        AGW6_1.komponentenmenge,
        AGW6_1.ek_netto_bnk,
        AGW6_1.ek_netto
    FROM dbp_data.art_gp_wup_zu_per_1 AS AGW6_1
    INNER JOIN dbp_data.art_gp_zu_per_1 AS AGW6_2
        ON
            AGW6_1.art_id = AGW6_2.art_id AND AGW6_1.gp_id = AGW6_2
            .gp_id AND (
                AGW6_1.dat_von BETWEEN AGW6_2.dat_von AND AGW6_2.dat_bis
                OR AGW6_2.dat_von BETWEEN AGW6_1.dat_von AND
                AGW6_1.dat_bis
            )
            AND AGW6_1.mandant_id = AGW6_2.mandant_id
            AND AGW6_1.einkaufsorganisation_id
            = AGW6_2.einkaufsorganisation_id

    WHERE
        AGW6_1.nb_id IN (99, -111)
        AND AGW6_1.bezugsweg_id = 4
        AND AGW6_1.ek_kal_basis > 0
        AND AGW6_1.mandant_id = 1
);


INSERT INTO dbp_etl.ek07_ekpo_1 (
    art_id, wup_id, komponentenmenge, ek_netto_bnk, ek_netto
)
(SELECT
    art_id,
    wup_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto
FROM dbp_data.art_gp_wup_zu_per_1
WHERE
    nb_id IN (99, -111)
    AND bezugsweg_id = 4
    AND ek_kal_basis > 0
    AND mandant_id = 1
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, wup_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto IS NULL
        DESC,
        ek_brutto DESC,
        gp_id IS NULL,
        gp_id,
        ek_mep IS NULL DESC,
        ek_mep DESC,
        ek_kal_basis IS NULL DESC,
        ek_kal_basis DESC
)) = 1);


INSERT INTO dbp_etl.ek08_ekpo_1 (art_id, komponentenmenge, ek_netto_bnk, ek_netto)
(SELECT
    art_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto
FROM dbp_data.art_gp_wup_zu_per_1
WHERE
    nb_id IN (99, -111)
    AND bezugsweg_id = 4
    AND ek_kal_basis > 0
    AND mandant_id = 1
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto IS NULL DESC,
        ek_brutto DESC,
        gp_id IS NULL,
        gp_id,
        ek_mep IS NULL DESC,
        ek_mep DESC,
        ek_kal_basis IS NULL DESC,
        ek_kal_basis
        DESC
)) = 1);


INSERT INTO dbp_etl.ek09_ekpo_1 (
    art_id, gp_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto
)
(
    SELECT
        art_id,
        gp_id,
        dat_von,
        dat_bis,
        komponentenmenge,
        ek_netto_bnk,
        ek_netto
    FROM dbp_data.art_gp_wup_zu_per_1
    WHERE
        (nb_id NOT IN (99, -111) OR nb_id IS NULL)
        AND bezugsweg_id = 1
        AND ek_kal_basis > 0
        AND mandant_id = 1
);


INSERT INTO dbp_etl.ek10_ekpo_1 (
    art_id, gp_id, komponentenmenge, ek_netto_bnk, ek_netto
)
(SELECT
    art_id,
    gp_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto
FROM dbp_data.art_gp_wup_zu_per_1
WHERE
    (nb_id NOT IN (99, -111) OR nb_id IS NULL)
    AND bezugsweg_id = 1
    AND ek_kal_basis > 0
    AND mandant_id = 1
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, gp_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto IS NULL
        DESC,
        ek_brutto DESC,
        gp_id IS NULL,
        gp_id,
        ek_mep IS NULL DESC,
        ek_mep DESC,
        ek_kal_basis IS NULL DESC,
        ek_kal_basis DESC
)) = 1);


INSERT INTO dbp_etl.ek11_ekpo_1 (
    art_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto
)
(
    SELECT
        AGW11_1.art_id,
        CASE
            WHEN AGW11_1.dat_von > AGW11_2.dat_von
                THEN AGW11_1.dat_von
            ELSE AGW11_2.dat_von
        END AS dat_von,
        CASE
            WHEN AGW11_1.dat_bis < AGW11_2.dat_bis
                THEN AGW11_1.dat_bis
            ELSE AGW11_2.dat_bis
        END AS dat_bis,
        AGW11_1.komponentenmenge,
        AGW11_1.ek_netto_bnk,
        AGW11_1.ek_netto
    FROM dbp_data.art_gp_wup_zu_per_1 AS AGW11_1
    INNER JOIN dbp_data.art_gp_zu_per_1 AS AGW11_2
        ON
            AGW11_1.art_id = AGW11_2.art_id AND AGW11_1.gp_id
            = AGW11_2.gp_id AND (
                AGW11_1.dat_von BETWEEN AGW11_2.dat_von AND AGW11_2.dat_bis
                OR AGW11_2.dat_von BETWEEN AGW11_1
                .dat_von AND AGW11_1.dat_bis
            )
            AND AGW11_1.mandant_id = AGW11_2.mandant_id
            AND AGW11_1.einkaufsorganisation_id
            = AGW11_2.einkaufsorganisation_id
    WHERE
        (AGW11_1.nb_id NOT IN (99, -111) OR AGW11_1.nb_id IS NULL)
        AND AGW11_1.bezugsweg_id = 1
        AND AGW11_1.ek_kal_basis > 0
        AND AGW11_1.mandant_id = 1
);


INSERT INTO dbp_etl.ek12_ekpo_1 (art_id, ek_netto_bnk, ek_netto, komponentenmenge)
(SELECT
    art_id,
    ek_netto_bnk,
    ek_netto,
    komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_1
WHERE
    (nb_id NOT IN (99, -111) OR nb_id IS NULL)
    AND bezugsweg_id = 1
    AND ek_kal_basis > 0
    AND mandant_id = 1
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto IS NULL DESC,
        ek_brutto DESC,
        gp_id IS NULL,
        gp_id,
        ek_mep IS NULL DESC,
        ek_mep DESC,
        ek_kal_basis IS NULL DESC,
        ek_kal_basis
        DESC
)) = 1);


DROP TABLE IF EXISTS dbp_etl.besch_best_det_tmp_1;


CREATE TABLE IF NOT EXISTS dbp_etl.besch_best_det_tmp_1 (
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
/* zentral */ -- 0)
/* zentral */ -- 0)
/* dezentral (Lager kann nicht richtig sein) */
-- EK_PREIS holen
/* dezentral (Lager kann nicht richtig sein) */ /* dezentral (Lager kann nicht richtig sein) */
-- 0)
INSERT INTO dbp_etl.besch_best_det_tmp_1 (
    mandant_id, best_beleg_id, best_beleg_pos_id, art_id,
    wup_id,
    nb_id,
    lagerort_id,
    loesch_fg,
    menge_best_bme,
    selbstabhol_fg,
    best_preis_menge_einh_id,
    best_menge_einh_id,
    menge_best_kolli,
    menge_best_palette,
    endlief_fg,
    dat_aenderung,
    kunde_id,
    dat_best_beleg,
    wg_verkett_id,
    fremd_lagerort_id,
    ean_id,
    betrag_kond_zw_sum2,
    pos_kostenlos_fg,
    betrag_pos_netto,
    betrag_pos_netto_best_wrg,
    wrg_id,
    betrag_best,
    gp_id,
    ek_netto_bnk,
    ek_netto,
    komponentenmenge,
    kopf_wup_id,
    gp_teilsortiment_id,
    zentral_best_fg,
    dat_best_beleg_orig, anforderer_name
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
        EKPO.dat_best_beleg,
        EKPO.wg_verkett_id,
        EKPO.fremd_lagerort_id,
        EKPO.ean_id,
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
                    AGW.ek_netto_bnk,
                    AGW2.ek_netto_bnk,
                    AGW3.ek_netto_bnk,
                    AGW4.ek_netto_bnk,
                    AGW5.ek_netto_bnk,
                    AGW6.ek_netto_bnk,
                    AGW7.ek_netto_bnk,
                    AGW8.ek_netto_bnk,
                    AGW9.ek_netto_bnk,
                    AGW10.ek_netto_bnk,
                    AGW11.ek_netto_bnk,
                    AGW12.ek_netto_bnk,
                    0
                )
            ELSE COALESCE(
                AGW9.ek_netto_bnk,
                AGW10.ek_netto_bnk,
                AGW11.ek_netto_bnk,
                AGW12.ek_netto_bnk,
                AGW2.ek_netto_bnk,
                AGW4
                .ek_netto_bnk, AGW6.ek_netto_bnk, AGW8.ek_netto_bnk, 0
            )
        END AS ek_netto_bnk_,
        CASE
            WHEN EKPO.nb_id_ber IN (99, -111)
                THEN COALESCE(
                    AGW.ek_netto,
                    AGW2.ek_netto,
                    AGW3.ek_netto,
                    AGW4.ek_netto,
                    AGW5.ek_netto,
                    AGW6.ek_netto,
                    AGW7.ek_netto,
                    AGW8.ek_netto,
                    AGW9.ek_netto,
                    AGW10.ek_netto,
                    AGW11.ek_netto,
                    AGW12.ek_netto,
                    0
                )
            ELSE COALESCE(
                AGW9.ek_netto,
                AGW10.ek_netto,
                AGW11.ek_netto,
                AGW12.ek_netto,
                AGW2.ek_netto,
                AGW4.ek_netto,
                AGW6.ek_netto,
                AGW8.ek_netto, 0
            )
        END AS ek_netto_,
        CASE
            WHEN EKPO.nb_id_ber IN (99, -111)
                THEN COALESCE(
                    AGW.komponentenmenge,
                    AGW2.komponentenmenge,
                    AGW3.komponentenmenge,
                    AGW4.komponentenmenge,
                    AGW5.komponentenmenge,
                    AGW6.komponentenmenge,
                    AGW7.komponentenmenge,
                    AGW8.komponentenmenge,
                    AGW9.komponentenmenge,
                    AGW10.komponentenmenge,
                    AGW11.komponentenmenge, AGW12.komponentenmenge, 1
                )
            ELSE COALESCE(
                AGW9.komponentenmenge,
                AGW10.komponentenmenge,
                AGW11.komponentenmenge,
                AGW12.komponentenmenge,
                AGW2.komponentenmenge,
                AGW4.komponentenmenge,
                AGW6.komponentenmenge,
                AGW8.komponentenmenge,
                1
            )
        END AS komponentenmenge_,
        EKPO.kopf_wup_id,
        EKPO.gp_teilsortiment_id,
        EKPO.zentral_best_fg,
        EKPO.dat_best_beleg_orig,
        EKPO.anforderer_name
    FROM dbp_etl.de_ekpo_1 AS EKPO_1
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
            AND AGW.dat_bis /* richtiges Datum */
            AND EKPO.werks_ber = AGW.wup_id /* richtiges Lager */
            AND GP.gp_id = AGW.gp_id
    /* richtiger Lieferant */ /* zentral
        lager       falsch
        datum       richtig
        lieferant   richtig */
    LEFT JOIN dbp_etl.ek02_ekpo_1 AS AGW2
        ON
            EKPO.art_id = AGW2.art_id
            AND EKPO.dat_best_beleg BETWEEN AGW2.dat_von
            AND AGW2.dat_bis /* richtiges Datum */ AND GP.gp_id = AGW2.gp_id
    /* richtiger Lieferant */
        /* zentral
        lager       richtig
        datum       falsch
        lieferant   richtig */
    LEFT JOIN dbp_etl.ek03_ekpo_1 AS AGW3
        ON EKPO.art_id = AGW3.art_id AND EKPO.werks_ber = AGW3.wup_id
        /* richtiges Lager */ AND GP.gp_id = AGW3.gp_id
        /* richtiger Lieferant */
        /* zentral
        lager       falsch
        datum       falsch
        lieferant   richtig */
    LEFT JOIN
        dbp_etl.ek04_ekpo_1 AS AGW4
        ON EKPO.art_id = AGW4.art_id AND GP.gp_id = AGW4.gp_id
        /* richtiger Lieferant */ /* zentral
        lager       richtig
        datum       richtig
        lieferant   falsch */
    LEFT JOIN dbp_etl.ek05_ekpo_1 AS AGW5
        ON
            EKPO.art_id = AGW5.art_id
            AND EKPO.dat_best_beleg BETWEEN AGW5.dat_von
            AND AGW5.dat_bis /* richtiges Datum */
            AND EKPO.werks_ber = AGW5.wup_id
    /* richtiges Lager */
        /* zentral
        lager       falsch
        datum       richtig
        lieferant   falsch */
    LEFT JOIN dbp_etl.ek06_ekpo_1 AS AGW6
        ON
            EKPO.art_id = AGW6.art_id
            AND EKPO.dat_best_beleg BETWEEN AGW6.dat_von
            AND AGW6.dat_bis /* richtiges Datum */ /* zentral
        lager       richtig
        datum       falsch
        lieferant   falsch */
    LEFT JOIN
        dbp_etl.ek07_ekpo_1 AS AGW7
        ON EKPO.art_id = AGW7.art_id AND EKPO.werks_ber = AGW7.wup_id
        /* richtiges Lager */ /* zentral
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
        /* richtiger Lieferant */
        AND EKPO.dat_best_beleg BETWEEN AGW9.dat_von AND AGW9.dat_bis
        /* richtiges Datum */
        /* dezentral
        lager       -1
        datum       falsch
        lieferant   richtig */
    LEFT JOIN
        dbp_etl.ek10_ekpo_1 AS AGW10
        ON EKPO.art_id = AGW10.art_id AND GP.gp_id = AGW10.gp_id
        /* richtiger Lieferant */ /* dezentral
        lager       -1
        datum       richtig
        lieferant   falsch */
    LEFT JOIN dbp_etl.ek11_ekpo_1 AS AGW11
        ON
            EKPO.art_id = AGW11.art_id AND EKPO.dat_best_beleg BETWEEN
            AGW11.dat_von AND AGW11.dat_bis /* richtiges Datum */
        /* dezentral
        lager       -1
        datum       falsch
        lieferant   falsch */
    LEFT JOIN dbp_etl.ek12_ekpo_1 AS AGW12 ON EKPO.art_id = AGW12.art_id
    QUALIFY
        (
            ROW_NUMBER()
                OVER (
                    PARTITION BY
                        EKPO.mandant_id,
                        EKPO.best_beleg_id,
                        EKPO.best_beleg_pos_id
                    ORDER BY CAST(CASE
                        WHEN EKPO.nb_id_ber IN (99, -111)
                            THEN
                                COALESCE(
                                    AGW.ek_netto_bnk,
                                    AGW2.ek_netto_bnk,
                                    AGW3.ek_netto_bnk,
                                    AGW4.ek_netto_bnk,
                                    AGW5.ek_netto_bnk,
                                    AGW6.ek_netto_bnk,
                                    AGW7.ek_netto_bnk,
                                    AGW8.ek_netto_bnk,
                                    AGW9.ek_netto_bnk,
                                    AGW10.ek_netto_bnk,
                                    AGW11.ek_netto_bnk,
                                    AGW12.ek_netto_bnk,
                                    0
                                )
                        ELSE
                            COALESCE(
                                AGW9.ek_netto_bnk,
                                AGW10.ek_netto_bnk,
                                AGW11.ek_netto_bnk,
                                AGW12.ek_netto_bnk,
                                AGW2.ek_netto_bnk,
                                AGW4.ek_netto_bnk,
                                AGW6.ek_netto_bnk,
                                AGW8.ek_netto_bnk,
                                0
                            )
                    END AS NUMERIC) IS NULL DESC, CAST(CASE
                        WHEN EKPO.nb_id_ber IN (99, -111)
                            THEN
                                COALESCE(
                                    AGW.ek_netto_bnk,
                                    AGW2.ek_netto_bnk,
                                    AGW3.ek_netto_bnk,
                                    AGW4.ek_netto_bnk,
                                    AGW5.ek_netto_bnk,
                                    AGW6.ek_netto_bnk,
                                    AGW7.ek_netto_bnk,
                                    AGW8.ek_netto_bnk,
                                    AGW9.ek_netto_bnk,
                                    AGW10.ek_netto_bnk,
                                    AGW11.ek_netto_bnk,
                                    AGW12.ek_netto_bnk,
                                    0
                                )
                        ELSE
                            COALESCE(
                                AGW9.ek_netto_bnk,
                                AGW10.ek_netto_bnk,
                                AGW11.ek_netto_bnk,
                                AGW12.ek_netto_bnk,
                                AGW2.ek_netto_bnk,
                                AGW4.ek_netto_bnk,
                                AGW6.ek_netto_bnk,
                                AGW8.ek_netto_bnk,
                                0
                            )
                    END AS NUMERIC) DESC, CASE
                        WHEN EKPO.nb_id_ber IN (99, -111)
                            THEN COALESCE(
                                AGW.komponentenmenge,
                                AGW2.komponentenmenge,
                                AGW3.komponentenmenge,
                                AGW4.komponentenmenge,
                                AGW5.komponentenmenge,
                                AGW6.komponentenmenge,
                                AGW7.komponentenmenge,
                                AGW8.komponentenmenge,
                                AGW9.komponentenmenge,
                                AGW10.komponentenmenge,
                                AGW11.komponentenmenge,
                                AGW12.komponentenmenge,
                                1
                            )
                        ELSE COALESCE(
                            AGW9.komponentenmenge,
                            AGW10.komponentenmenge,
                            AGW11.komponentenmenge,
                            AGW12.komponentenmenge,
                            AGW2.komponentenmenge,
                            AGW4.komponentenmenge,
                            AGW6.komponentenmenge,
                            AGW8.komponentenmenge,
                            1
                        )
                    END IS NULL DESC, CASE
                        WHEN EKPO.nb_id_ber IN (99, -111)
                            THEN COALESCE(
                                AGW.komponentenmenge,
                                AGW2.komponentenmenge,
                                AGW3.komponentenmenge,
                                AGW4.komponentenmenge,
                                AGW5.komponentenmenge,
                                AGW6.komponentenmenge,
                                AGW7.komponentenmenge,
                                AGW8.komponentenmenge,
                                AGW9.komponentenmenge,
                                AGW10.komponentenmenge,
                                AGW11.komponentenmenge,
                                AGW12.komponentenmenge,
                                1
                            )
                        ELSE COALESCE(
                            AGW9.komponentenmenge,
                            AGW10.komponentenmenge,
                            AGW11.komponentenmenge,
                            AGW12.komponentenmenge,
                            AGW2.komponentenmenge,
                            AGW4.komponentenmenge,
                            AGW6.komponentenmenge,
                            AGW8.komponentenmenge,
                            1
                        )
                    END DESC
                )
        ) = 1
);


DROP TABLE IF EXISTS dbp_etl.fww_perf_tmp1_1;


CREATE TABLE IF NOT EXISTS dbp_etl.fww_perf_tmp1_1 AS
SELECT DISTINCT dat_best_beleg_orig AS dat_best_beleg
FROM dbp_etl.besch_best_det_tmp_1;


DELETE FROM dbp_data.besch_best_det_1
WHERE dat_best_beleg IN (
    SELECT dat_best_beleg
    FROM dbp_etl.fww_perf_tmp1_1
)
AND mandant_id = 1
AND (
    mandant_id, best_beleg_id, best_beleg_pos_id,
    dat_best_beleg) IN (
    SELECT (mandant_id, best_beleg_id, best_beleg_pos_id, dat_best_beleg_orig)
    FROM dbp_etl.besch_best_det_tmp_1
    WHERE dat_best_beleg_orig IS NOT NULL
);


-- Datum ermitteln
-- Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen

-- Palettenfaktor und Default Mengeneinheit holen
INSERT INTO dbp_data.besch_best_det_1 (
    mandant_id,
    best_beleg_id,
    best_beleg_pos_id,
    art_id,
    wup_id,
    nb_id,
    lagerort_id,
    loesch_fg,
    menge_best_bme,
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
)
(
    SELECT
        T.mandant_id,
        T.best_beleg_id,
        T.best_beleg_pos_id,
        T.art_id,
        T.wup_id,
        T.nb_id,
        T.lagerort_id,
        T.loesch_fg,
        CAST(
            T.menge_best_kolli
            / COALESCE(
                COALESCE(aukolli.umrech_faktor, aukolli_akt.umrech_faktor),
                COALESCE(
                    aukolli_alternativ.umrech_faktor,
                    aukolli_alternativ_akt.umrech_faktor
                ),
                1
            ) AS NUMERIC
        )
            AS menge_best_neu,
        T.selbstabhol_fg,
        T.best_preis_menge_einh_id,
        T.menge_best_kolli,
        CASE
            WHEN aupalette.umrech_faktor IS NULL
                THEN
                    CAST(
                        T.menge_best_kolli
                        / COALESCE(
                            COALESCE(
                                aukolli.umrech_faktor, aukolli_akt.umrech_faktor
                            ),
                            COALESCE(
                                aukolli_alternativ.umrech_faktor,
                                aukolli_alternativ_akt.umrech_faktor
                            ),
                            1
                        ) AS NUMERIC
                    )
            ELSE ROUND(CAST(
                CAST(
                    T.menge_best_kolli
                    / COALESCE(
                        COALESCE(
                            aukolli.umrech_faktor, aukolli_akt.umrech_faktor
                        ),
                        COALESCE(
                            aukolli_alternativ.umrech_faktor,
                            aukolli_alternativ_akt.umrech_faktor
                        ),
                        1
                    ) AS NUMERIC
                )
                * aupalette.umrech_faktor AS NUMERIC
            ), 3)
        END AS menge_best_palette,
        T.endlief_fg,
        T.dat_aenderung,
        T.kunde_id,
        T.dat_best_beleg,
        T.best_menge_einh_id,
        T.ean_id,
        T.betrag_kond_zw_sum2,
        T.pos_kostenlos_fg,
        T.betrag_pos_netto,
        T.betrag_pos_netto_best_wrg,
        T.wrg_id,
        ROUND(CAST(
            CAST(
                T.menge_best_kolli
                / COALESCE(
                    COALESCE(aukolli.umrech_faktor, aukolli_akt.umrech_faktor),
                    COALESCE(
                        aukolli_alternativ.umrech_faktor,
                        aukolli_alternativ_akt.umrech_faktor
                    ),
                    1
                ) AS NUMERIC
            )
            * CAST(
                CAST(T.ek_netto_bnk AS NUMERIC) * T.komponentenmenge AS FLOAT64
            ) AS NUMERIC
        ), 2) AS betrag_best,
        0 AS menge_block_bestand,
        T.gp_teilsortiment_id,
        CASE
            WHEN WGFZ.wg_id IS NOT NULL
                THEN 1
            ELSE 0
        END AS flw_fg,
        T.zentral_best_fg,
        T.anforderer_name
    FROM dbp_etl.besch_best_det_tmp_1 AS T
    INNER JOIN (SELECT
        best_beleg_id,
        dat_best_beleg
    FROM dbp_data.besch_best_1
    WHERE mandant_id = 1) AS la ON T.best_beleg_id = la.best_beleg_id
    LEFT JOIN dbp_data.art_wg_zu_per_1 AS AWZP
        ON
            AWZP.mandant_id = 1
            AND T.art_id = AWZP.art_id
            AND AWZP.arthiertyp_id
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
            T.art_id = aukolli.art_id
            AND T.best_menge_einh_id = aukolli.altnv_menge_einh_id
            AND la.dat_best_beleg BETWEEN aukolli.dat_von AND aukolli.dat_bis
    -- Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen / current state in case there is no as-was record

    LEFT JOIN (SELECT
        art_id,
        altnv_menge_einh_id,
        dat_von,
        dat_bis,
        umrech_faktor
    FROM dbp_data.art_umrechnung_faktor_per_1
    WHERE mandant_id = 1) AS aukolli_akt
        ON
            T.art_id = aukolli_akt.art_id
            AND T.best_menge_einh_id = aukolli_akt.altnv_menge_einh_id
            AND aukolli_akt.dat_bis = DATE '9999-12-31'
    LEFT JOIN (SELECT
        art_id,
        paletten_faktor_einh_id,
        ausg_menge_einh_id,
        dat_von,
        dat_bis
    FROM dbp_data.art_vorschlagswert_per_1
    WHERE mandant_id = 1) AS av
        ON
            T.art_id = av.art_id
            AND la.dat_best_beleg BETWEEN av.dat_von AND av.dat_bis
    -- Umrechnungsfaktor fuer Palettenfaktor holen

    LEFT JOIN (SELECT
        art_id,
        umrech_faktor,
        altnv_menge_einh_id,
        dat_von,
        dat_bis
    FROM dbp_data.art_umrechnung_faktor_per_1
    WHERE mandant_id = 1) AS aupalette
        ON
            T.art_id = aupalette.art_id
            AND av.paletten_faktor_einh_id = aupalette.altnv_menge_einh_id
            AND la.dat_best_beleg BETWEEN aupalette.dat_von AND aupalette.dat_bis
    -- Default Umrechnungsfaktor fuer Basismenge holen, wenn Umrechnungsfaktor aus Bestellung NULL ist

    LEFT JOIN (SELECT
        art_id,
        altnv_menge_einh_id,
        dat_von,
        dat_bis,
        umrech_faktor
    FROM dbp_data.art_umrechnung_faktor_per_1
    WHERE mandant_id = 1) AS aukolli_alternativ
        ON
            T.art_id = aukolli_alternativ.art_id AND av.ausg_menge_einh_id
            = aukolli_alternativ.altnv_menge_einh_id AND la.dat_best_beleg BETWEEN aukolli_alternativ.dat_von AND
            aukolli_alternativ.dat_bis
    -- Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen / current state in case there is no as-was record

    LEFT JOIN (SELECT
        art_id,
        altnv_menge_einh_id,
        dat_von,
        dat_bis,
        umrech_faktor
    FROM dbp_data.art_umrechnung_faktor_per_1
    WHERE mandant_id = 1) AS aukolli_alternativ_akt
        ON
            T.art_id = aukolli_alternativ_akt.art_id AND T.best_menge_einh_id
            = aukolli_alternativ_akt.altnv_menge_einh_id
            AND aukolli_alternativ_akt.dat_bis = DATE '9999-12-31'
    LEFT JOIN
        dbp_data.wg_filter_zu_1
            AS WGFZ
        ON
            AWZP.wg_id = WGFZ.wg_id AND AWZP.mandant_id = WGFZ.mandant_id
            AND WGFZ.wg_filter_id = 23 AND WGFZ.arthiertyp_id = 2
);


UPDATE dbp_data.besch_best_det_1 SET
    zentral_best_fg = 1 FROM (
    SELECT DISTINCT
        T1.mandant_id,
        T1.best_beleg_id,
        T1.best_beleg_pos_id,
        T1.art_id,
        T1.wup_id,
        T1.dat_best_beleg
    FROM dbp_data.besch_best_det_1 AS T1_1
    INNER JOIN dbp_etl.besch_best_det_tmp_1 AS X
        ON
            T1.mandant_id = X.mandant_id AND T1.best_beleg_id = X.best_beleg_id
            AND T1.best_beleg_pos_id = X.best_beleg_pos_id
            AND T1.wup_id = X.wup_id
            AND T1.dat_best_beleg = X.dat_best_beleg
            AND T1.art_id = X.art_id
    LEFT JOIN dbp_data.fur_best_vor_1 AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.wup_id = T2.wup_id
            AND T1.art_id = T2.art_id AND T1.dat_best_beleg = T2.dat_dispo
    WHERE T1.anforderer_name = 'ZFRE0150_INT'
) AS b
WHERE
    besch_best_det.mandant_id = b.mandant_id
    AND besch_best_det.best_beleg_id = b.best_beleg_id
    AND besch_best_det.best_beleg_pos_id
    = b.best_beleg_pos_id
    AND besch_best_det.art_id = b.art_id
    AND besch_best_det.wup_id = b.wup_id
    AND besch_best_det_1
    .dat_best_beleg = b.dat_best_beleg;


UPDATE dbp_data.besch_best_1 SET
    empfaenger_wup_id = bzeile.empfaenger_wup_id,
    anz_pos_aktiv = bzeile.anz_pos_aktiv,
    anz_pos_offen = bzeile.anz_pos_offen FROM (
    SELECT
        mandant_id,
        best_beleg_id,
        MAX(wup_id) AS empfaenger_wup_id,
        COUNT(*) AS anz_pos_aktiv,
        SUM(CASE
            WHEN endlief_fg = 1
                THEN 0
            ELSE 1
        END) AS anz_pos_offen
    FROM dbp_data.besch_best_det_1
    WHERE
        loesch_fg = 0
        AND (
            mandant_id, best_beleg_id, dat_best_beleg) IN (
            SELECT (mandant_id, best_beleg_id, dat_best_beleg)
            FROM dbp_etl.besch_best_det_tmp_1
            WHERE IF(kopf_wup_id = 0, NULL, kopf_wup_id) IS NULL
        )
    GROUP BY
        mandant_id,
        best_beleg_id
) AS bzeile
WHERE
    besch_best.mandant_id = bzeile.mandant_id AND besch_best.best_beleg_id = bzeile.best_beleg_id;


DROP TABLE IF EXISTS dbp_etl.lief_eint_tmp_1;


CREATE TABLE IF NOT EXISTS dbp_etl.lief_eint_tmp_1 (
    mandant_id INTEGER NOT NULL,
    best_beleg_id INTEGER NOT NULL,
    best_beleg_pos_id INTEGER NOT NULL,
    einteil_id INTEGER NOT NULL,
    menge_einteil NUMERIC(29, 3) NOT NULL,
    dat_lief_wunsch DATE NOT NULL,
    dat_lief_bewertung DATE,
    mahnung_anz INTEGER NOT NULL,
    system_id INTEGER NOT NULL,
    flw_fg INTEGER NOT NULL
);


DROP TABLE IF EXISTS dbp_etl.fww_perf_tmp2_1;


CREATE TABLE IF NOT EXISTS dbp_etl.fww_perf_tmp2_1 AS
SELECT
    T1.mandant_id,
    T1.best_beleg_id,
    T1.best_beleg_pos_id,
    T1.flw_fg
FROM dbp_data.besch_best_det_1 AS T1_1
INNER JOIN dbp_etl.de_ekpo_1 AS T2
    ON
        T1.mandant_id = T2.mandant_id AND T1.best_beleg_id = T2.best_beleg_id
        AND T1.best_beleg_pos_id = T2.best_beleg_pos_id
        AND T1.dat_best_beleg = T2.dat_best_beleg
INNER JOIN dbp_etl.fww_perf_tmp1_1
    AS T0 ON T1.dat_best_beleg = T0.dat_best_beleg AND T1.mandant_id = 1
AND T1.flw_fg = 1;


INSERT INTO dbp_etl.lief_eint_tmp_1 (
    mandant_id, best_beleg_id, best_beleg_pos_id, einteil_id,
    menge_einteil,
    dat_lief_wunsch,
    dat_lief_bewertung,
    mahnung_anz,
    system_id,
    flw_fg
)
(
    SELECT
        T2.mandant_id,
        T2.best_beleg_id,
        T2.best_beleg_pos_id,
        T2.einteil_id,
        T2.menge_einteil,
        T2.dat_lief_wunsch,
        T2.dat_lief_bewertung,
        T2.mahnung_anz,
        T2.system_id,
        T1.flw_fg
    FROM dbp_etl.fww_perf_tmp2_1 AS T1_1
    INNER JOIN dbp_data.lief_einteilung_1 AS T2
        ON
            T1.mandant_id = T2.mandant_id
            AND T1.best_beleg_id = T2.best_beleg_id
            AND T1.best_beleg_pos_id = T2.best_beleg_pos_id
    WHERE T2.mandant_id = 1
);


DELETE FROM dbp_data.lief_einteilung_1
WHERE
    (mandant_id, best_beleg_id, best_beleg_pos_id, dat_lief_wunsch) IN (SELECT (
        mandant_id, best_beleg_id,
        best_beleg_pos_id, dat_lief_wunsch
    )
    FROM dbp_etl.lief_eint_tmp_1);


INSERT INTO dbp_data.lief_einteilung_1 (
    mandant_id, best_beleg_id, best_beleg_pos_id, einteil_id,
    menge_einteil,
    dat_lief_wunsch,
    dat_lief_bewertung,
    mahnung_anz,
    system_id,
    flw_fg
)
(SELECT
    mandant_id,
    best_beleg_id,
    best_beleg_pos_id,
    einteil_id,
    menge_einteil,
    dat_lief_wunsch,
    dat_lief_bewertung,
    mahnung_anz,
    system_id,
    flw_fg
FROM dbp_etl.lief_eint_tmp_1);


/* decimal 18,4 */ CREATE TABLE IF NOT EXISTS dbp_etl.besch_best_lbs_1 (
    mandant_id INTEGER NOT NULL,
    best_beleg_id INTEGER NOT NULL,
    best_beleg_pos_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    lagerort_id STRING(4) COLLATE 'und:ci',
    menge_best_bme NUMERIC(29, 3) NOT NULL,
    endlief_fg INTEGER NOT NULL,
    dat_best_beleg DATE NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci',
    ek_netto NUMERIC(29, 4),
    betrag_best_ekn NUMERIC(29, 4),
    gp_id INTEGER NOT NULL,
    bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    menge_best_kolli NUMERIC(29, 3),
    loesch_fg INTEGER,
    selbstabhol_fg INTEGER
);


DELETE FROM dbp_etl.besch_best_lbs_1
WHERE (
    mandant_id, best_beleg_id, best_beleg_pos_id) IN (
    SELECT (mandant_id, best_beleg_id, best_beleg_pos_id)
    FROM dbp_etl.besch_best_det_tmp_1
);


-- Datum ermitteln
INSERT INTO dbp_etl.besch_best_lbs_1 (
    mandant_id, best_beleg_id, best_beleg_pos_id,
    art_id,
    wup_id,
    nb_id,
    lagerort_id,
    menge_best_bme,
    endlief_fg,
    dat_best_beleg,
    wrg_id,
    ek_netto,
    gp_id,
    bestellart_id,
    komponentenmenge, menge_best_kolli, loesch_fg, selbstabhol_fg
)
(
    SELECT
        T.mandant_id,
        T.best_beleg_id,
        T.best_beleg_pos_id,
        T.art_id,
        T.wup_id,
        T.nb_id,
        T.lagerort_id,
        CAST(
            T.menge_best_kolli
            / COALESCE(
                aukolli.umrech_faktor, aukolli_alternativ.umrech_faktor, 1
            ) AS NUMERIC
        )
            AS
            menge_best_bme,
        T.endlief_fg,
        T.dat_best_beleg,
        T.wrg_id,
        T.ek_netto /* in besch_best_det_1 wird fuer LIS der ek_netto_bnk fuer betrag_best gerechnet, in LBS ek_netto */,
        la.gp_id,
        la.bestellart_id,
        T.komponentenmenge,
        T.menge_best_kolli,
        T.loesch_fg,
        T.selbstabhol_fg
    FROM dbp_etl.besch_best_det_tmp_1 AS T
    INNER JOIN (
        SELECT
            best_beleg_id,
            dat_best_beleg,
            gp_id,
            bestellart_id
        FROM dbp_data.besch_best_1
        WHERE
            mandant_id = 1
            AND einkaufsorganisation_id = 1000
    ) AS la ON T.best_beleg_id = la.best_beleg_id
    -- Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen

    LEFT JOIN (SELECT
        art_id,
        altnv_menge_einh_id,
        dat_von,
        dat_bis,
        umrech_faktor
    FROM dbp_data.art_umrechnung_faktor_per_1
    WHERE mandant_id = 1) AS aukolli
        ON
            T.art_id = aukolli.art_id
            AND T.best_menge_einh_id = aukolli.altnv_menge_einh_id
            -- Palettenfaktor und Default Mengeneinheit holen
            AND la.dat_best_beleg BETWEEN aukolli.dat_von AND aukolli.dat_bis

    LEFT JOIN (SELECT
        art_id,
        paletten_faktor_einh_id,
        ausg_menge_einh_id,
        dat_von,
        dat_bis
    FROM dbp_data.art_vorschlagswert_per_1
    WHERE mandant_id = 1) AS av
        ON
            T.art_id = av.art_id
            AND la.dat_best_beleg BETWEEN av.dat_von AND av.dat_bis
    -- Default Umrechnungsfaktor fuer Basismenge holen, wenn Umrechnungsfaktor aus Bestellung NULL ist

    LEFT JOIN (SELECT
        art_id,
        altnv_menge_einh_id,
        dat_von,
        dat_bis,
        umrech_faktor
    FROM dbp_data.art_umrechnung_faktor_per_1
    WHERE mandant_id = 1) AS aukolli_alternativ
        ON
            T.art_id = aukolli_alternativ.art_id AND av.ausg_menge_einh_id
            = aukolli_alternativ.altnv_menge_einh_id AND la.dat_best_beleg BETWEEN aukolli_alternativ.dat_von AND
            aukolli_alternativ.dat_bis
);


DELETE FROM dbp_etl.besch_best_lbs_1
WHERE nb_id = 99;
