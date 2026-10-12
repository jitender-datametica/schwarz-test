CREATE OR REPLACE TABLE dbp_etl.ek01_2 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek02_2 (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek03_2 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek04_2 (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek05_2 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek06_2 (
    art_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek07_2 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek08_2 (
    art_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek09_2 (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek10_2 (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek11_2 (
    art_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.ek12_2 (
    art_id INTEGER NOT NULL,
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    komponentenmenge NUMERIC(29, 4)
);


INSERT INTO dbp_etl.ek01_2 (
    art_id, wup_id, gp_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk,
    ek_netto, ek_mep
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
        ek_netto,
        ek_mep
    FROM dbp_data.art_gp_wup_zu_per_2
    WHERE
        nb_id IN (99, -111)
        AND bezugsweg_id = 4
        AND ek_kal_basis > 0
        AND mandant_id = 1
        AND einkaufsorganisation_id = 1000
);


INSERT INTO dbp_etl.ek02_2 (
    art_id, gp_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto,
    ek_mep
)
(SELECT
    art_id,
    gp_id,
    dat_von,
    dat_bis,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto,
    ek_mep
FROM dbp_data.art_gp_wup_zu_per_2
WHERE
    nb_id IN (99, -111)
    AND bezugsweg_id = 4
    AND ek_kal_basis > 0
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, dat_von, gp_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto
        IS NULL DESC, ek_brutto DESC, gp_id IS NULL, gp_id, ek_mep IS NULL DESC, ek_mep DESC, ek_kal_basis IS NULL DESC,
        ek_kal_basis DESC
)) = 1);


INSERT INTO dbp_etl.ek03_2 (art_id, wup_id, gp_id, komponentenmenge, ek_netto_bnk, ek_netto, ek_mep)
(SELECT
    art_id,
    wup_id,
    gp_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto,
    ek_mep
FROM dbp_data.art_gp_wup_zu_per_2
WHERE
    nb_id IN (99, -111)
    AND bezugsweg_id = 4
    AND ek_kal_basis > 0
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, gp_id, wup_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto
        IS NULL DESC, ek_brutto DESC, gp_id IS NULL, gp_id, ek_mep IS NULL DESC, ek_mep DESC, ek_kal_basis IS NULL DESC,
        ek_kal_basis DESC
)) = 1);


INSERT INTO dbp_etl.ek04_2 (art_id, gp_id, komponentenmenge, ek_netto_bnk, ek_netto, ek_mep)
(SELECT
    art_id,
    gp_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto,
    ek_mep
FROM dbp_data.art_gp_wup_zu_per_2
WHERE
    nb_id IN (99, -111)
    AND bezugsweg_id = 4
    AND ek_kal_basis > 0
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, gp_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto IS NULL
        DESC, ek_brutto DESC, gp_id IS NULL, gp_id, ek_mep IS NULL DESC, ek_mep DESC, ek_kal_basis IS NULL DESC,
        ek_kal_basis DESC
)) = 1);


INSERT INTO dbp_etl.ek05_2 (
    art_id, wup_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto,
    ek_mep
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
        AGW5_1.ek_netto,
        AGW5_1.ek_mep
    FROM dbp_data.art_gp_wup_zu_per_2 AS AGW5_1
    INNER JOIN dbp_data.art_gp_zu_per_2 AS AGW5_2
        ON
            AGW5_1.art_id = AGW5_2.art_id AND AGW5_1.gp_id = AGW5_2.gp_id AND (
                AGW5_1.dat_von BETWEEN AGW5_2.dat_von AND AGW5_2.dat_bis OR AGW5_2.dat_von BETWEEN AGW5_1.dat_von AND
                AGW5_1.dat_bis
            ) AND AGW5_1.mandant_id = AGW5_2.mandant_id AND AGW5_1.einkaufsorganisation_id = AGW5_2.einkaufsorganisation_id

    WHERE
        AGW5_1.nb_id IN (99, -111)
        AND AGW5_1.bezugsweg_id = 4
        AND AGW5_1.ek_kal_basis > 0
        AND AGW5_1.mandant_id = 1
        AND AGW5_1.einkaufsorganisation_id = 1000
);


INSERT INTO dbp_etl.ek06_2 (art_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto, ek_mep)
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
        AGW6_1.ek_netto,
        AGW6_1.ek_mep
    FROM dbp_data.art_gp_wup_zu_per_2 AS AGW6_1
    INNER JOIN dbp_data.art_gp_zu_per_2 AS AGW6_2
        ON
            AGW6_1.art_id = AGW6_2.art_id AND AGW6_1.gp_id = AGW6_2.gp_id AND (
                AGW6_1.dat_von BETWEEN AGW6_2.dat_von AND AGW6_2.dat_bis OR AGW6_2.dat_von BETWEEN AGW6_1.dat_von AND
                AGW6_1.dat_bis
            ) AND AGW6_1.mandant_id = AGW6_2.mandant_id AND AGW6_1.einkaufsorganisation_id = AGW6_2.einkaufsorganisation_id

    WHERE
        AGW6_1.nb_id IN (99, -111)
        AND AGW6_1.bezugsweg_id = 4
        AND AGW6_1.ek_kal_basis > 0
        AND AGW6_1.mandant_id = 1
        AND AGW6_1.einkaufsorganisation_id = 1000
);


INSERT INTO dbp_etl.ek07_2 (art_id, wup_id, komponentenmenge, ek_netto_bnk, ek_netto, ek_mep)
(SELECT
    art_id,
    wup_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto,
    ek_mep
FROM dbp_data.art_gp_wup_zu_per_2
WHERE
    nb_id IN (99, -111)
    AND bezugsweg_id = 4
    AND ek_kal_basis > 0
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, wup_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto IS NULL
        DESC, ek_brutto DESC, gp_id IS NULL, gp_id, ek_mep IS NULL DESC, ek_mep DESC, ek_kal_basis IS NULL DESC,
        ek_kal_basis DESC
)) = 1);


INSERT INTO dbp_etl.ek08_2 (art_id, komponentenmenge, ek_netto_bnk, ek_netto, ek_mep)
(SELECT
    art_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto,
    ek_mep
FROM dbp_data.art_gp_wup_zu_per_2
WHERE
    nb_id IN (99, -111)
    AND bezugsweg_id = 4
    AND ek_kal_basis > 0
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto IS NULL DESC,
        ek_brutto DESC, gp_id IS NULL, gp_id, ek_mep IS NULL DESC, ek_mep DESC, ek_kal_basis IS NULL DESC, ek_kal_basis
        DESC
)) = 1);


INSERT INTO dbp_etl.ek09_2 (
    art_id, gp_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto,
    ek_mep
)
(
    SELECT
        art_id,
        gp_id,
        dat_von,
        dat_bis,
        komponentenmenge,
        ek_netto_bnk,
        ek_netto,
        ek_mep
    FROM dbp_data.art_gp_wup_zu_per_2
    WHERE
        (nb_id NOT IN (99, -111) OR nb_id IS NULL)
        AND bezugsweg_id = 1
        AND ek_kal_basis > 0
        AND mandant_id = 1
        AND einkaufsorganisation_id = 1000
);


INSERT INTO dbp_etl.ek10_2 (art_id, gp_id, komponentenmenge, ek_netto_bnk, ek_netto, ek_mep)
(SELECT
    art_id,
    gp_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto,
    ek_mep
FROM dbp_data.art_gp_wup_zu_per_2
WHERE
    (nb_id NOT IN (99, -111) OR nb_id IS NULL)
    AND bezugsweg_id = 1
    AND ek_kal_basis > 0
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, gp_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto IS NULL
        DESC, ek_brutto DESC, gp_id IS NULL, gp_id, ek_mep IS NULL DESC, ek_mep DESC, ek_kal_basis IS NULL DESC,
        ek_kal_basis DESC
)) = 1);


INSERT INTO dbp_etl.ek11_2 (art_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto, ek_mep)
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
        AGW11_1.ek_netto,
        AGW11_1.ek_mep
    FROM dbp_data.art_gp_wup_zu_per_2 AS AGW11_1
    INNER JOIN dbp_data.art_gp_zu_per_2 AS AGW11_2
        ON
            AGW11_1.art_id = AGW11_2.art_id AND AGW11_1.gp_id =
            AGW11_2.gp_id AND (
                AGW11_1.dat_von BETWEEN AGW11_2.dat_von AND AGW11_2.dat_bis OR AGW11_2.dat_von BETWEEN AGW11_1.dat_von AND AGW11_1.dat_bis
            ) AND AGW11_1.mandant_id = AGW11_2.mandant_id AND AGW11_1.einkaufsorganisation_id =
            AGW11_2.einkaufsorganisation_id
    WHERE
        (AGW11_1.nb_id NOT IN (99, -111) OR AGW11_1.nb_id IS NULL)
        AND AGW11_1.bezugsweg_id = 1
        AND AGW11_1.ek_kal_basis > 0
        AND AGW11_1.mandant_id = 1
        AND AGW11_1.einkaufsorganisation_id = 1000
);


INSERT INTO dbp_etl.ek12_2 (art_id, ek_netto_bnk, ek_netto, ek_mep, komponentenmenge)
(SELECT
    art_id,
    ek_netto_bnk,
    ek_netto,
    ek_mep,
    komponentenmenge
FROM dbp_data.art_gp_wup_zu_per_2
WHERE
    (nb_id NOT IN (99, -111) OR nb_id IS NULL)
    AND bezugsweg_id = 1
    AND ek_kal_basis > 0
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, ek_brutto IS NULL DESC,
        ek_brutto DESC, gp_id IS NULL, gp_id, ek_mep IS NULL DESC, ek_mep DESC, ek_kal_basis IS NULL DESC, ek_kal_basis
        DESC
)) = 1);


UPDATE dbp_etl.de_mseg_delta_2 SET
    umwrk = NULL
WHERE TRIM(umwrk) = '';


UPDATE dbp_etl.de_mseg_delta_2 SET
    wempf = NULL
WHERE TRIM(wempf) = '';


CREATE OR REPLACE TEMPORARY TABLE _vkset_potentials_kopf AS
SELECT
    mandant_id,
    lagerbew_beleg_id,
    dat_buch,
    lagerbew_beleg_parent_pos_sort_id
FROM dbp_etl.de_mseg_delta_2
WHERE
    lagerbew_beleg_parent_pos_sort_id <> 0
    AND lager_bewart_id IN ('317', '319')
GROUP BY
    mandant_id,
    lagerbew_beleg_id,
    dat_buch,
    lagerbew_beleg_parent_pos_sort_id;


CREATE OR REPLACE TEMPORARY TABLE _vkset_potentials AS
SELECT
    mandant_id,
    lagerbew_beleg_id,
    dat_buch,
    lagerbew_beleg_pos_sort_id
FROM dbp_etl.de_mseg_delta_2
WHERE (mandant_id, lagerbew_beleg_id, dat_buch, lagerbew_beleg_pos_sort_id) IN (SELECT (
    mandant_id, lagerbew_beleg_id,
    dat_buch, lagerbew_beleg_parent_pos_sort_id
)
FROM `_vkset_potentials_kopf`)
GROUP BY
    mandant_id,
    lagerbew_beleg_id,
    dat_buch,
    lagerbew_beleg_pos_sort_id;


CREATE OR REPLACE TEMPORARY TABLE _vkset_updates AS
SELECT
    mandant_id,
    lagerbew_beleg_id,
    dat_buch,
    lagerbew_beleg_pos_sort_id,
    art_id
FROM dbp_etl.de_mseg_delta_2
WHERE (mandant_id, lagerbew_beleg_id, dat_buch, lagerbew_beleg_pos_sort_id) IN (SELECT (
    mandant_id, lagerbew_beleg_id,
    dat_buch, lagerbew_beleg_pos_sort_id
)
FROM `_vkset_potentials`)
GROUP BY
    mandant_id,
    lagerbew_beleg_id,
    dat_buch,
    lagerbew_beleg_pos_sort_id,
    art_id;


UPDATE dbp_etl.de_mseg_delta_2 SET
    display_art_id = -1
WHERE TRUE;


UPDATE dbp_etl.de_mseg_delta_2 SET
    display_art_id = b.art_id
FROM `_vkset_updates` AS b
WHERE
    de_mseg_delta.mandant_id = b.mandant_id AND de_mseg_delta.lagerbew_beleg_id = b.lagerbew_beleg_id AND
    de_mseg_delta.dat_buch = b.dat_buch AND de_mseg_delta.lagerbew_beleg_parent_pos_sort_id = b.lagerbew_beleg_pos_sort_id;


UPDATE dbp_etl.de_mseg_delta_2 SET
    display_art_id = b.art_id
FROM `_vkset_updates` AS b
WHERE
    de_mseg_delta.mandant_id = b.mandant_id AND de_mseg_delta.lagerbew_beleg_id = b.lagerbew_beleg_id AND
    de_mseg_delta.dat_buch = b.dat_buch AND de_mseg_delta.lagerbew_beleg_pos_sort_id = b.lagerbew_beleg_pos_sort_id;


DROP TABLE IF EXISTS dbp_etl.de_mseg_work_2;


CREATE TABLE IF NOT EXISTS dbp_etl.de_mseg_work_2 (
    art_id INTEGER,
    art_id_bf INTEGER,
    art_id_empfaenger INTEGER,
    auto_fg STRING(1) COLLATE 'und:ci',
    beleg_user_name STRING(20) COLLATE 'und:ci',
    belegart_id STRING(2) COLLATE 'und:ci',
    belegkopftext STRING(30) COLLATE 'und:ci',
    best_beleg_id INTEGER,
    best_beleg_pos_id INTEGER,
    betrag_bnk NUMERIC(29, 4),
    betrag_exbwr NUMERIC(29, 4),
    betrag_lagerbew NUMERIC(29, 4),
    betrag_umbewertung NUMERIC(29, 4),
    betrag_verkauf NUMERIC(29, 2),
    betrag_verkauf_ist NUMERIC(29, 2),
    betrag_verkauf_ist_netto NUMERIC(29, 4),
    betrag_vk_netto NUMERIC(29, 2),
    betrag_vk_netto_vz NUMERIC(29, 4),
    buchungskreis_id INTEGER,
    bw_vorgang_id INTEGER,
    dat_beleg DATE,
    dat_buch DATE,
    dat_erfasst DATE,
    einkaufsorganisation_id INTEGER,
    ek_netto_bnk NUMERIC(29, 4),
    empfaenger_id INTEGER,
    endlief_fg INTEGER NOT NULL,
    erfsngs_menge_einh_id STRING(3),
    gp_id INTEGER,
    grund_id STRING(10) COLLATE 'und:ci',
    kj INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    kostenstelle_id STRING(10) COLLATE 'und:ci',
    kunde_id STRING(10) COLLATE 'und:ci',
    lager_bewart_id STRING(3) COLLATE 'und:ci',
    lagerbew_beleg_id INTEGER,
    lagerbew_beleg_pos_id INTEGER,
    lagerbew_beleg_pos_mutter_id INTEGER,
    lagerbew_beleg_pos_storno_id INTEGER,
    lagerbew_beleg_storno_id INTEGER,
    lagerbew_beleg_storno_kj INTEGER,
    lagerort_id STRING(4) COLLATE 'und:ci',
    lagerort_id_empfaenger STRING(4) COLLATE 'und:ci',
    lagerplatz_id STRING(10) COLLATE 'und:ci',
    lief_gp_id INTEGER,
    line_id INTEGER,
    los_charge STRING(10) COLLATE 'und:ci',
    mandant_id INTEGER NOT NULL,
    mandant_id_empfaenger INTEGER,
    mandant_id_kunde INTEGER,
    menge_bestand_bme NUMERIC(29, 3),
    menge_erf NUMERIC(29, 3),
    menge_lagerbew_bme NUMERIC(29, 3),
    menge_lagerbew_kolli NUMERIC(29, 3),
    menge_lagerbew_palette NUMERIC(29, 3),
    menge_lief NUMERIC(29, 3),
    menge_lieferschein NUMERIC(29, 3),
    nb_id INTEGER,
    ref_lagerbew_beleg_id STRING(20) COLLATE 'und:ci',
    ref_lagerbew_beleg_id_num INTEGER,
    sachkonto_id STRING(10) COLLATE 'und:ci',
    shkum STRING(1) COLLATE 'und:ci',
    soll_haben_kz STRING(1) COLLATE 'und:ci',
    system_id INTEGER,
    transaktion_code STRING(10) COLLATE 'und:ci',
    vorgangsart_id STRING(2) COLLATE 'und:ci',
    waren_begl_schein_id STRING(10) COLLATE 'und:ci',
    wert_bestand NUMERIC(29, 4),
    wg_art_fg INTEGER,
    wrg_id STRING(3) COLLATE 'und:ci',
    wup_id INTEGER,
    xruem_fg INTEGER,
    zeit_erfasst INTEGER,
    lagerbew_beleg_pos_sort_id INTEGER,
    lagerbew_beleg_parent_pos_sort_id INTEGER,
    display_art_id INTEGER
);


INSERT INTO dbp_etl.de_mseg_work_2 (
    art_id, art_id_bf, art_id_empfaenger, auto_fg, beleg_user_name,
    belegart_id, belegkopftext, best_beleg_id, best_beleg_pos_id, betrag_bnk, betrag_exbwr, betrag_lagerbew,
    betrag_umbewertung, betrag_verkauf, betrag_verkauf_ist, betrag_verkauf_ist_netto, betrag_vk_netto, betrag_vk_netto_vz,
    buchungskreis_id, bw_vorgang_id, dat_beleg, dat_buch, dat_erfasst, einkaufsorganisation_id, ek_netto_bnk, empfaenger_id,
    endlief_fg, erfsngs_menge_einh_id, gp_id, grund_id, kj, komponentenmenge, kostenstelle_id, kunde_id, lager_bewart_id,
    lagerbew_beleg_id, lagerbew_beleg_pos_id, lagerbew_beleg_pos_mutter_id, lagerbew_beleg_pos_storno_id,
    lagerbew_beleg_storno_id, lagerbew_beleg_storno_kj, lagerort_id, lagerort_id_empfaenger, lagerplatz_id, lief_gp_id,
    line_id, los_charge, mandant_id, mandant_id_empfaenger, mandant_id_kunde, menge_bestand_bme, menge_erf,
    menge_lagerbew_bme, menge_lagerbew_kolli, menge_lagerbew_palette, menge_lief, menge_lieferschein, nb_id,
    ref_lagerbew_beleg_id, ref_lagerbew_beleg_id_num, sachkonto_id, shkum, soll_haben_kz, system_id, transaktion_code,
    vorgangsart_id, waren_begl_schein_id, wert_bestand, wg_art_fg, wrg_id, wup_id, xruem_fg, zeit_erfasst,
    lagerbew_beleg_pos_sort_id, lagerbew_beleg_parent_pos_sort_id, display_art_id
)
(
    SELECT
        MM.art_id,
        MM.art_id_bf,
        MM.art_id_empfaenger,
        MM.auto_fg,
        MM.beleg_user_name,
        MM.belegart_id,
        MM.belegkopftext,
        MM.best_beleg_id,
        MM.best_beleg_pos_id,
        MM.betrag_bnk,
        MM.betrag_exbwr,
        MM.betrag_lagerbew,
        MM.betrag_umbewertung,
        MM.betrag_verkauf,
        MM.betrag_verkauf_ist,
        COALESCE(CAST(MM.betrag_verkauf_ist AS NUMERIC) / (MM.mwst + 100) * 100, 0) AS betrag_verkauf_ist_netto, --PE-Review
        MM.betrag_vk_netto,
        MM.betrag_vk_netto_vz,
        MM.buchungskreis_id,
        MM.bw_vorgang_id,
        MM.dat_beleg,
        MM.dat_buch,
        MM.dat_erfasst,
        MM.einkaufsorganisation_id,
        CASE
            WHEN MM.nb_id IN (99, -111)
                THEN COALESCE(
                    AGW.ek_netto_bnk, AGW2.ek_netto_bnk, AGW3.ek_netto_bnk, AGW4.ek_netto_bnk, AGW5.ek_netto_bnk, AGW6.ek_netto_bnk,
                    AGW7.ek_netto_bnk, AGW8.ek_netto_bnk, AGW9.ek_netto_bnk, AGW10.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk,
                    0
                )
            ELSE COALESCE(
                AGW9.ek_netto_bnk, AGW10.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, AGW2.ek_netto_bnk, AGW4.ek_netto_bnk, AGW6.ek_netto_bnk, AGW8.ek_netto_bnk, 0
            )
        END AS ek_netto_bnk_,
        CAST(COALESCE(CAST(MM.umwrk AS BIGNUMERIC), CASE
            WHEN MM.wempf LIKE '94000%'
                THEN ROUND(CAST(COALESCE(TRIM(bb.kunde_id), TRIM(MM.kunde_id)) AS BIGNUMERIC), 0)
            ELSE CASE
                WHEN MM.wempf IS NOT NULL
                    THEN ROUND(CAST(TRIM(MM.wempf) AS BIGNUMERIC), 0)
                ELSE NULL
            END
        END) AS INTEGER) AS empfaenger_id,
        MM.endlief_fg,
        MM.erfsngs_menge_einh_id,
        MM.gp_id,
        MM.grund_id,
        MM.kj,
        CASE
            WHEN MM.nb_id IN (99, -111)
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
        MM.kostenstelle_id,
        COALESCE(TRIM(bb.kunde_id), TRIM(MM.kunde_id)) AS kunde_id,
        MM.lager_bewart_id,
        MM.lagerbew_beleg_id,
        MM.lagerbew_beleg_pos_id,
        MM.lagerbew_beleg_pos_mutter_id,
        MM.lagerbew_beleg_pos_storno_id,
        MM.lagerbew_beleg_storno_id,
        MM.lagerbew_beleg_storno_kj,
        MM.lagerort_id,
        MM.lagerort_id_empfaenger,
        MM.lagerplatz_id,
        MM.lief_gp_id,
        MM.line_id,
        MM.los_charge,
        MM.mandant_id,
        MM.mandant_id_empfaenger,
        MM.mandant_id_kunde,
        MM.menge_bestand_bme,
        MM.menge_erf,
        MM.menge_lagerbew_bme,
        MM.menge_lagerbew_kolli,
        MM.menge_lagerbew_palette,
        MM.menge_lief,
        MM.menge_lieferschein,
        MM.nb_id,
        MM.ref_lagerbew_beleg_id,
        MM.ref_lagerbew_beleg_id_num,
        MM.sachkonto_id,
        MM.shkum,
        MM.soll_haben_kz,
        MM.system_id,
        MM.transaktion_code,
        MM.vorgangsart_id,
        MM.waren_begl_schein_id,
        MM.wert_bestand,
        MM.wg_art_fg,
        MM.wrg_id,
        MM.wup_id,
        MM.xruem_fg,
        CAST(ROUND(CAST(CAST(MM.zeit_erfasst AS STRING FORMAT '000000') AS BIGNUMERIC), 0) AS INTEGER) AS mm_zeit_erfasst,
        MM.lagerbew_beleg_pos_sort_id,
        MM.lagerbew_beleg_parent_pos_sort_id,
        MM.display_art_id
    FROM dbp_etl.de_mseg_delta_2 AS MM_2
    LEFT JOIN (
        SELECT *
        FROM dbp_data.besch_best_det_2
        WHERE (
            mandant_id, dat_best_beleg) IN (
            SELECT (A.mandant_id, A.dat_best_beleg)
            FROM dbp_data.besch_best_2 AS A
            INNER JOIN dbp_etl.de_mseg_delta_2 AS B ON A.mandant_id = B.mandant_id AND A.best_beleg_id = B.best_beleg_id

            GROUP BY A.mandant_id,
            A.dat_best_beleg
        )
    ) AS bb
        ON
            MM.mandant_id = bb.mandant_id AND MM.best_beleg_id = bb.best_beleg_id AND MM.best_beleg_pos_id
            = bb.best_beleg_pos_id AND bb.mandant_id = 1
    LEFT JOIN dbp_data.art_gp_zu_per_2 AS AP
        ON
            MM.art_id = AP.art_id AND MM.mandant_id = AP.mandant_id AND
            MM.dat_buch BETWEEN AP.dat_von AND AP.dat_bis
    LEFT JOIN dbp_etl.ek01_2 AS AGW
        ON
            MM.art_id = AGW.art_id AND MM.dat_buch BETWEEN AGW.dat_von AND AGW.dat_bis
            AND MM.wup_id = AGW.wup_id AND MM.gp_id_ber = AGW.gp_id
    LEFT JOIN dbp_etl.ek02_2 AS AGW2
        ON
            MM.art_id = AGW2.art_id AND MM.dat_buch BETWEEN AGW2.dat_von AND AGW2.dat_bis AND MM.gp_id_ber = AGW2.gp_id
    LEFT JOIN dbp_etl.ek03_2 AS AGW3
        ON
            MM.art_id = AGW3.art_id AND MM.wup_id = AGW3.wup_id AND MM.gp_id_ber
            = AGW3.gp_id
    LEFT JOIN dbp_etl.ek04_2 AS AGW4 ON MM.art_id = AGW4.art_id AND MM.gp_id_ber = AGW4.gp_id
    LEFT JOIN dbp_etl.ek05_2 AS AGW5
        ON
            MM.art_id = AGW5.art_id AND MM.dat_buch BETWEEN AGW5.dat_von AND AGW5.dat_bis AND MM.wup_id = AGW5.wup_id
    LEFT JOIN dbp_etl.ek06_2 AS AGW6
        ON
            MM.art_id = AGW6.art_id AND MM.dat_buch BETWEEN AGW6.dat_von AND AGW6.dat_bis
    LEFT JOIN dbp_etl.ek07_2 AS AGW7 ON MM.art_id = AGW7.art_id AND MM.wup_id = AGW7.wup_id
    LEFT JOIN dbp_etl.ek08_2 AS AGW8 ON MM.art_id = AGW8.art_id
    LEFT JOIN dbp_etl.ek09_2 AS AGW9
        ON
            MM.art_id = AGW9.art_id AND MM.gp_id_ber = AGW9.gp_id AND MM.dat_buch
            BETWEEN AGW9.dat_von AND AGW9.dat_bis
    LEFT JOIN dbp_etl.ek10_2 AS AGW10 ON MM.art_id = AGW10.art_id AND MM.gp_id_ber = AGW10.gp_id
    LEFT JOIN dbp_etl.ek11_2 AS AGW11
        ON
            MM.art_id = AGW11.art_id AND MM.dat_buch BETWEEN AGW11.dat_von AND
            AGW11.dat_bis
    LEFT JOIN dbp_etl.ek12_2 AS AGW12 ON MM.art_id = AGW12.art_id
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY MM.mandant_id, MM.lagerbew_beleg_id, MM.lagerbew_beleg_pos_id, MM.kj ORDER BY CAST(CASE
        WHEN MM.nb_id IN (99, -111)
            THEN COALESCE(AGW.ek_netto_bnk, AGW2.ek_netto_bnk, AGW3.ek_netto_bnk, AGW4.ek_netto_bnk, AGW5.ek_netto_bnk, AGW6.ek_netto_bnk, AGW7.ek_netto_bnk, AGW8.ek_netto_bnk, AGW9.ek_netto_bnk, AGW10.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, 0)
        ELSE COALESCE(AGW9.ek_netto_bnk, AGW10.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, AGW2.ek_netto_bnk, AGW4.ek_netto_bnk, AGW6.ek_netto_bnk, AGW8.ek_netto_bnk, 0)
    END AS NUMERIC) IS NULL DESC, CAST(CASE
        WHEN MM.nb_id IN (99, -111)
            THEN COALESCE(AGW.ek_netto_bnk, AGW2.ek_netto_bnk, AGW3.ek_netto_bnk, AGW4.ek_netto_bnk, AGW5.ek_netto_bnk, AGW6.ek_netto_bnk, AGW7.ek_netto_bnk, AGW8.ek_netto_bnk, AGW9.ek_netto_bnk, AGW10.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, 0)
        ELSE COALESCE(AGW9.ek_netto_bnk, AGW10.ek_netto_bnk, AGW11.ek_netto_bnk, AGW12.ek_netto_bnk, AGW2.ek_netto_bnk, AGW4.ek_netto_bnk, AGW6.ek_netto_bnk, AGW8.ek_netto_bnk, 0)
    END AS NUMERIC) DESC, CASE
        WHEN MM.nb_id IN (99, -111)
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
        WHEN MM.nb_id IN (99, -111)
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


DROP TABLE IF EXISTS dbp_etl.de_mseg_menge_2;


CREATE TABLE IF NOT EXISTS dbp_etl.de_mseg_menge_2 (
    art_id INTEGER,
    art_id_bf INTEGER,
    art_id_empfaenger INTEGER,
    auto_fg STRING(1) COLLATE 'und:ci' NOT NULL,
    beleg_user_name STRING(20) COLLATE 'und:ci',
    belegart_id STRING(2) COLLATE 'und:ci',
    belegkopftext STRING(30) COLLATE 'und:ci',
    best_beleg_id INTEGER,
    best_beleg_pos_id INTEGER NOT NULL,
    betrag_belegfluss_wg_art NUMERIC(29, 2),
    betrag_bnk NUMERIC(29, 4),
    betrag_exbwr NUMERIC(29, 4),
    betrag_lagerbew NUMERIC(29, 4) NOT NULL,
    betrag_umbewertung NUMERIC(29, 4),
    betrag_verkauf NUMERIC(29, 2),
    betrag_verkauf_ist NUMERIC(29, 2),
    betrag_verkauf_ist_netto NUMERIC(29, 4),
    betrag_vk_netto NUMERIC(29, 2),
    betrag_vk_netto_vz NUMERIC(29, 4),
    buchungskreis_id INTEGER,
    bw_vorgang_id INTEGER,
    dat_beleg DATE,
    dat_buch DATE,
    dat_erfasst DATE,
    einkaufsorganisation_id INTEGER,
    empfaenger_id INTEGER,
    endlief_fg INTEGER,
    erfsngs_menge_einh_id STRING(3),
    gp_id INTEGER,
    grund_id STRING(10) COLLATE 'und:ci',
    kj INTEGER NOT NULL,
    kostenstelle_id STRING(10) COLLATE 'und:ci',
    kunde_id STRING(10) COLLATE 'und:ci',
    lager_bewart_id STRING(3) COLLATE 'und:ci',
    lagerbew_beleg_id INTEGER,
    lagerbew_beleg_pos_id INTEGER,
    lagerbew_beleg_pos_mutter_id INTEGER,
    lagerbew_beleg_pos_storno_id INTEGER,
    lagerbew_beleg_storno_id INTEGER,
    lagerbew_beleg_storno_kj INTEGER,
    lagerort_id STRING(4) COLLATE 'und:ci',
    lagerort_id_empfaenger STRING(4) COLLATE 'und:ci',
    lagerplatz_id STRING(10) COLLATE 'und:ci',
    lief_gp_id INTEGER,
    line_id INTEGER,
    los_charge STRING(10) COLLATE 'und:ci',
    mandant_id INTEGER NOT NULL,
    mandant_id_empfaenger INTEGER,
    mandant_id_kunde INTEGER,
    menge_bestand_bme NUMERIC(29, 3),
    menge_erf NUMERIC(29, 3),
    menge_lagerbew_bme NUMERIC(29, 3),
    menge_lagerbew_kolli NUMERIC(29, 3),
    menge_lagerbew_palette NUMERIC(29, 3),
    menge_lief NUMERIC(29, 3),
    menge_lieferschein NUMERIC(29, 3),
    nb_id INTEGER,
    ref_lagerbew_beleg_id STRING(20) COLLATE 'und:ci',
    ref_lagerbew_beleg_id_num INTEGER,
    sachkonto_id STRING(10) COLLATE 'und:ci',
    shkum STRING(1) COLLATE 'und:ci',
    soll_haben_kz STRING(1) COLLATE 'und:ci',
    system_id INTEGER,
    transaktion_code STRING(10) COLLATE 'und:ci',
    vorgangsart_id STRING(2) COLLATE 'und:ci',
    waren_begl_schein_id STRING(10) COLLATE 'und:ci',
    wert_bestand NUMERIC(29, 4),
    wrg_id STRING(3) COLLATE 'und:ci',
    wup_id INTEGER,
    xruem_fg INTEGER,
    zeit_erfasst INTEGER,
    lagerbew_beleg_pos_sort_id INTEGER,
    lagerbew_beleg_parent_pos_sort_id INTEGER,
    display_art_id INTEGER
);


INSERT INTO dbp_etl.de_mseg_menge_2 (
    art_id, art_id_bf, art_id_empfaenger, auto_fg, beleg_user_name,
    belegart_id, belegkopftext, best_beleg_id, best_beleg_pos_id, betrag_belegfluss_wg_art, betrag_bnk, betrag_exbwr,
    betrag_lagerbew, betrag_umbewertung, betrag_verkauf, betrag_verkauf_ist, betrag_vk_netto, betrag_vk_netto_vz,
    buchungskreis_id, bw_vorgang_id, dat_beleg, dat_buch, dat_erfasst, einkaufsorganisation_id, empfaenger_id, endlief_fg,
    erfsngs_menge_einh_id, gp_id, grund_id, kj, kostenstelle_id, kunde_id, lager_bewart_id, lagerbew_beleg_id,
    lagerbew_beleg_pos_id, lagerbew_beleg_pos_mutter_id, lagerbew_beleg_pos_storno_id, lagerbew_beleg_storno_id,
    lagerbew_beleg_storno_kj, lagerort_id, lagerort_id_empfaenger, lagerplatz_id, lief_gp_id, line_id, los_charge,
    mandant_id, mandant_id_empfaenger, mandant_id_kunde, menge_bestand_bme, menge_erf, menge_lagerbew_bme,
    menge_lagerbew_kolli, menge_lagerbew_palette, menge_lief, menge_lieferschein, nb_id, ref_lagerbew_beleg_id,
    ref_lagerbew_beleg_id_num, sachkonto_id, shkum, soll_haben_kz, system_id, transaktion_code, vorgangsart_id,
    waren_begl_schein_id, wert_bestand, wrg_id, wup_id, xruem_fg, zeit_erfasst, lagerbew_beleg_pos_sort_id,
    lagerbew_beleg_parent_pos_sort_id, display_art_id
)
(
    SELECT
        W.art_id,
        W.art_id_bf,
        W.art_id_empfaenger,
        COALESCE(W.auto_fg, '') AS w_auto_fg,
        W.beleg_user_name,
        W.belegart_id,
        W.belegkopftext,
        W.best_beleg_id,
        W.best_beleg_pos_id,
        COALESCE(ROUND(CAST(BBF.betrag_ek_netto AS NUMERIC), 2), 0) AS betrag_belegfluss_wg_art,
        W.betrag_bnk,
        W.betrag_exbwr,
        CASE
            WHEN WGFZ.wg_id IS NOT NULL
                THEN W.betrag_lagerbew
            ELSE ROUND(CAST(CAST(
                W.menge_lagerbew_bme AS FLOAT64) * CAST(
                CAST(W.ek_netto_bnk AS NUMERIC) * W.komponentenmenge AS
                FLOAT64
            ) AS NUMERIC), 2)
        END AS betrag_lagerbew,
        W.betrag_umbewertung,
        W.betrag_verkauf,
        W.betrag_verkauf_ist,
        W.betrag_vk_netto,
        W.betrag_vk_netto_vz,
        W.buchungskreis_id,
        W.bw_vorgang_id,
        W.dat_beleg,
        W.dat_buch,
        W.dat_erfasst,
        W.einkaufsorganisation_id,
        W.empfaenger_id,
        W.endlief_fg,
        W.erfsngs_menge_einh_id,
        W.gp_id,
        W.grund_id,
        W.kj,
        W.kostenstelle_id,
        W.kunde_id,
        W.lager_bewart_id,
        W.lagerbew_beleg_id,
        W.lagerbew_beleg_pos_id,
        W.lagerbew_beleg_pos_mutter_id,
        W.lagerbew_beleg_pos_storno_id,
        W.lagerbew_beleg_storno_id,
        W.lagerbew_beleg_storno_kj,
        W.lagerort_id,
        W.lagerort_id_empfaenger,
        W.lagerplatz_id,
        W.lief_gp_id,
        W.line_id,
        W.los_charge,
        W.mandant_id,
        W.mandant_id_empfaenger,
        W.mandant_id_kunde,
        W.menge_bestand_bme,
        W.menge_erf,
        W.menge_lagerbew_bme,
        CAST(W.menge_lagerbew_bme * CASE
            WHEN EKKO.bestellart_id = 'ZLLF' AND av.ausg_menge_einh_id <> EKPO.best_menge_einh_id
                THEN COALESCE(BSTME_KOLLI.umrech_faktor, BSTME_KOLLI_FALLBACK.umrech_faktor)
            WHEN aukolli_alternativ.umrech_faktor IS NULL
                THEN 1
            ELSE aukolli_alternativ.umrech_faktor
        END AS NUMERIC) AS menge_lagerbew_kolli,
        CAST(CASE
            WHEN aupalette.umrech_faktor IS NULL
                THEN NULL
            ELSE W.menge_lagerbew_bme * aupalette.umrech_faktor
        END AS NUMERIC) AS menge_lagerbew_palette,
        W.menge_lief,
        W.menge_lieferschein,
        W.nb_id,
        W.ref_lagerbew_beleg_id,
        W.ref_lagerbew_beleg_id_num,
        W.sachkonto_id,
        W.shkum,
        W.soll_haben_kz,
        W.system_id,
        W.transaktion_code,
        W.vorgangsart_id,
        W.waren_begl_schein_id,
        W.wert_bestand,
        W.wrg_id,
        W.wup_id,
        W.xruem_fg,
        W.zeit_erfasst,
        W.lagerbew_beleg_pos_sort_id,
        W.lagerbew_beleg_parent_pos_sort_id,
        W.display_art_id
    FROM dbp_etl.de_mseg_work_2 AS W
    LEFT JOIN (SELECT
        art_id,
        paletten_faktor_einh_id,
        ausg_menge_einh_id,
        dat_von,
        dat_bis,
        mandant_id
    FROM dbp_data.art_vorschlagswert_per_2) AS av
        ON
            W.art_id = av.art_id AND W.dat_buch >= av.dat_von AND W.dat_buch <= av.dat_bis AND W.mandant_id = av.mandant_id
    LEFT JOIN (SELECT
        art_id,
        umrech_faktor,
        altnv_menge_einh_id,
        dat_von,
        dat_bis,
        mandant_id
    FROM dbp_data.art_umrechnung_faktor_per_2) AS aupalette
        ON
            W.art_id = aupalette.art_id AND av.paletten_faktor_einh_id
            = aupalette.altnv_menge_einh_id AND W.dat_buch >= aupalette.dat_von AND W.dat_buch <= aupalette.dat_bis AND W.mandant_id
            = aupalette.mandant_id
    LEFT JOIN (SELECT
        art_id,
        altnv_menge_einh_id,
        dat_von,
        dat_bis,
        umrech_faktor,
        mandant_id
    FROM dbp_data.art_umrechnung_faktor_per_2) AS aukolli_alternativ
        ON
            W.art_id = aukolli_alternativ.art_id
            AND av.ausg_menge_einh_id = aukolli_alternativ.altnv_menge_einh_id AND W.dat_buch >= aukolli_alternativ.dat_von
            AND W.dat_buch <= aukolli_alternativ.dat_bis AND W.mandant_id = aukolli_alternativ.mandant_id
    LEFT JOIN (SELECT
        mandant_id,
        art_id,
        arthiertyp_id,
        wg_id,
        dat_von,
        dat_bis
    FROM dbp_data.art_wg_zu_per_2) AS awzp
        ON
            W.art_id = awzp.art_id AND awzp.arthiertyp_id = 2 AND W.mandant_id
            = awzp.mandant_id AND awzp.dat_bis = PARSE_DATE('%F', '9999-12-31')
    LEFT JOIN dbp_data.wg_filter_zu_2 AS WGFZ
        ON
            awzp.wg_id = WGFZ.wg_id AND awzp.mandant_id = WGFZ.mandant_id
            AND WGFZ.wg_filter_id = 6 AND WGFZ.arthiertyp_id = 2
    LEFT JOIN dbp_data.best_belegfluss_2 AS BBF
        ON
            W.lagerbew_beleg_id = BBF.folge_beleg_id AND W.mandant_id
            = BBF.mandant_id AND W.lagerbew_beleg_pos_id = BBF.folge_beleg_pos_id AND W.kj = BBF.kj AND BBF.best_entw_typ_id
            = 'E' AND BBF.mandant_id = 1 AND W.dat_buch = BBF.dat_buch AND W.best_beleg_id = BBF.best_beleg_id AND W.best_beleg_pos_id
            = BBF.best_beleg_pos_id AND W.wg_art_fg = 1
    LEFT JOIN dbp_data.besch_best_det_2 AS EKPO_2
        ON
            W.mandant_id = EKPO.mandant_id AND W.best_beleg_id = EKPO.best_beleg_id AND W.best_beleg_pos_id = EKPO.best_beleg_pos_id
    LEFT JOIN dbp_data.besch_best_2 AS EKKO_2
        ON
            EKPO.mandant_id = EKKO.mandant_id AND EKPO.best_beleg_id =
            EKKO.best_beleg_id AND EKPO.dat_best_beleg = EKKO.dat_best_beleg
    LEFT JOIN dbp_data.art_umrechnung_faktor_per_2 AS BSTME_KOLLI
        ON
            EKPO.mandant_id = BSTME_KOLLI.mandant_id
            AND EKPO.art_id = BSTME_KOLLI.art_id AND EKPO.best_menge_einh_id = BSTME_KOLLI.altnv_menge_einh_id AND EKPO.dat_best_beleg
            BETWEEN BSTME_KOLLI.dat_von AND BSTME_KOLLI.dat_bis
    LEFT JOIN
        dbp_data.art_umrechnung_faktor_per_2
            AS BSTME_KOLLI_FALLBACK
        ON
            EKPO.mandant_id =
            BSTME_KOLLI_FALLBACK.mandant_id AND EKPO.art_id = BSTME_KOLLI_FALLBACK.art_id AND EKPO.best_menge_einh_id =
            BSTME_KOLLI_FALLBACK.altnv_menge_einh_id AND BSTME_KOLLI_FALLBACK.dat_bis = DATE '9999-12-31'
);


DROP TABLE IF EXISTS dbp_etl.de_lagerbew_det_vk_anr_2;


CREATE TABLE IF NOT EXISTS dbp_etl.de_lagerbew_det_vk_anr_2 (
    mandant_id INTEGER,
    lagerbew_beleg_id INTEGER,
    lagerbew_beleg_pos_id INTEGER,
    dat_buch DATE NOT NULL,
    kj INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    menge_lagerbew_bme NUMERIC(29, 3),
    vk_netto NUMERIC(29, 4)
);


INSERT INTO dbp_etl.de_lagerbew_det_vk_anr_2 (
    mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id,
    dat_buch, kj, art_id, wup_id, nb_id, menge_lagerbew_bme, vk_netto
)
(
    SELECT
        DMM.mandant_id,
        DMM.lagerbew_beleg_id,
        DMM.lagerbew_beleg_pos_id,
        DMM.dat_buch,
        DMM.kj,
        DMM.art_id,
        DMM.wup_id,
        DMM.nb_id,
        DMM.menge_lagerbew_bme,
        CAST(AP.vk_brutto / CASE
            WHEN MWST.mwst_id IS NULL
                THEN 1
            ELSE 1 + MWST.mwst / 100
        END AS NUMERIC) AS vk_netto
    FROM dbp_etl.de_mseg_menge_2 AS DMM
    INNER JOIN dbp_data.art_2 AS ART_2 ON DMM.mandant_id = ART.mandant_id AND DMM.art_id = ART.art_id
    INNER JOIN dbp_data.mwst_per_2 AS MWST
        ON
            ART.mandant_id = MWST.mandant_id AND ART.mwst_id = MWST.mwst_id
            AND DMM.dat_buch BETWEEN MWST.dat_von AND MWST.dat_bis
    LEFT JOIN dbp_data.art_pm_vw_zu_per_2 AS AP
        ON
            DMM.mandant_id = AP.mandant_id AND DMM.art_id = AP.art_id
            AND DMM.dat_buch BETWEEN AP.dat_von AND AP.dat_bis AND AP.preistyp_id = 0 AND AP.pm_id = 1 AND AP.vw_id IN (
                1, 2,
                3, 6
            ) AND AP.vk_brutto IS NOT NULL
    WHERE DMM.nb_id IN (-111, 99)
);


UPDATE dbp_etl.de_mseg_menge_2 SET
    betrag_vk_netto_vz = t0.betrag_vk_vz_netto_ FROM (SELECT
    mandant_id AS mandant_id_,
    lagerbew_beleg_id AS lagerbew_beleg_id_,
    lagerbew_beleg_pos_id AS lagerbew_beleg_pos_id_,
    dat_buch AS dat_buch_,
    kj AS kj_,
    art_id AS art_id_,
    wup_id AS wup_id_,
    nb_id AS nb_id_,
    COALESCE(ROUND(CAST(menge_lagerbew_bme * CAST(vk_netto AS FLOAT64) AS NUMERIC), 4), 0) AS betrag_vk_vz_netto_
FROM dbp_etl.de_lagerbew_det_vk_anr_2
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, dat_buch, art_id,
        wup_id, nb_id ORDER BY
        ABS(
            COALESCE(ROUND(CAST(menge_lagerbew_bme * CAST(vk_netto AS FLOAT64) AS NUMERIC), 4), 0
            )
        ) IS NULL DESC, ABS(COALESCE(ROUND(CAST(menge_lagerbew_bme * CAST(vk_netto AS FLOAT64) AS NUMERIC), 4), 0)
        )
        DESC
)) = 1) AS t0
WHERE
    de_mseg_menge.mandant_id = t0.mandant_id_ AND de_mseg_menge.lagerbew_beleg_id = t0.lagerbew_beleg_id_ AND
    de_mseg_menge.lagerbew_beleg_pos_id = t0.lagerbew_beleg_pos_id_ AND de_mseg_menge.dat_buch = t0.dat_buch_ AND
    de_mseg_menge.kj = t0.kj_ AND de_mseg_menge.art_id = t0.art_id_ AND de_mseg_menge.wup_id = t0.wup_id_ AND
    de_mseg_menge.nb_id = t0.nb_id_;


DELETE FROM dbp_data.lagerbew_delta_2
WHERE (
    mandant_id, lagerbew_beleg_id, kj) IN (
    SELECT (mandant_id, lagerbew_beleg_id, kj)
    FROM dbp_etl.de_mseg_menge_2
);


INSERT INTO dbp_data.lagerbew_delta_2 (
    mandant_id, lagerbew_beleg_id, kj, vorgangsart_id, dat_buch,
    beleg_user_name, ref_lagerbew_beleg_id, dat_beleg, dat_erfasst, belegart_id, belegkopftext, waren_begl_schein_id,
    system_id, ref_lagerbew_beleg_id_num, lief_gp_id, zeit_erfasst, transaktion_code
)
(SELECT
    mandant_id,
    lagerbew_beleg_id,
    kj,
    vorgangsart_id,
    dat_buch,
    beleg_user_name,
    ref_lagerbew_beleg_id,
    dat_beleg,
    dat_erfasst,
    belegart_id,
    belegkopftext,
    waren_begl_schein_id,
    system_id,
    ref_lagerbew_beleg_id_num,
    lief_gp_id,
    zeit_erfasst,
    transaktion_code
FROM dbp_etl.de_mseg_menge_2
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        mandant_id, lagerbew_beleg_id, kj ORDER BY
        lagerbew_beleg_pos_id IS NULL DESC,
        lagerbew_beleg_pos_id DESC
)) = 1);


DELETE FROM dbp_data.lagerbew_det_delta_2
WHERE (mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj) IN (SELECT (
    mandant_id, lagerbew_beleg_id,
    lagerbew_beleg_pos_id, kj
)
FROM dbp_etl.de_mseg_menge_2);


INSERT INTO dbp_data.lagerbew_det_delta_2 (
    mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj,
    grund_id, lager_bewart_id, art_id, wup_id, nb_id, auto_fg, lagerort_id, gp_id, einkaufsorganisation_id, soll_haben_kz,
    wrg_id, best_beleg_id, best_beleg_pos_id, betrag_lagerbew, betrag_verkauf, erfsngs_menge_einh_id, lagerplatz_id,
    kunde_id, menge_lagerbew_kolli, menge_lagerbew_bme, menge_lagerbew_palette, menge_lieferschein, menge_lief, menge_erf,
    empfaenger_id, dat_buch, lagerbew_beleg_storno_id, lagerbew_beleg_pos_storno_id, lagerbew_beleg_storno_kj,
    betrag_vk_netto, betrag_belegfluss_wg_art, mandant_id_kunde, mandant_id_empfaenger, bw_vorgang_id, betrag_verkauf_ist,
    betrag_vk_netto_vz, betrag_verkauf_ist_netto, gp_id_zl, bq_findung_id, menge_bestand_bme, wert_bestand, system_id,
    buchungskreis_id, shkum, kostenstelle_id, sachkonto_id, art_id_empfaenger, lagerort_id_empfaenger, art_id_bf,
    lagerbew_beleg_pos_mutter_id, line_id, display_art_id, endlief_fg, xruem_fg, betrag_exbwr, betrag_bnk,
    betrag_umbewertung
)
(SELECT
    mandant_id,
    lagerbew_beleg_id,
    lagerbew_beleg_pos_id,
    kj,
    grund_id,
    lager_bewart_id,
    art_id,
    wup_id,
    nb_id,
    auto_fg,
    lagerort_id,
    gp_id,
    einkaufsorganisation_id,
    soll_haben_kz,
    wrg_id,
    best_beleg_id,
    best_beleg_pos_id,
    betrag_lagerbew,
    betrag_verkauf,
    erfsngs_menge_einh_id,
    lagerplatz_id,
    kunde_id,
    COALESCE(menge_lagerbew_kolli, 0) AS menge_lagerbew_kolli,
    COALESCE(menge_lagerbew_bme, 0) AS menge_lagerbew_bme,
    COALESCE(menge_lagerbew_palette, 0) AS menge_lagerbew_palette,
    COALESCE(menge_lieferschein, 0) AS menge_lieferschein,
    COALESCE(menge_lief, 0) AS menge_lief,
    COALESCE(menge_erf, 0) AS menge_erf,
    empfaenger_id,
    dat_buch,
    lagerbew_beleg_storno_id,
    lagerbew_beleg_pos_storno_id,
    lagerbew_beleg_storno_kj,
    betrag_vk_netto,
    betrag_belegfluss_wg_art,
    mandant_id_kunde,
    mandant_id_empfaenger,
    bw_vorgang_id,
    betrag_verkauf_ist,
    betrag_vk_netto_vz,
    COALESCE(betrag_verkauf_ist_netto, 0) AS betrag_verkauf_ist_netto,
    -1,
    0,
    menge_bestand_bme,
    wert_bestand,
    system_id,
    buchungskreis_id,
    COALESCE(shkum, '') AS shkum,
    COALESCE(kostenstelle_id, '') AS kostenstelle_id,
    COALESCE(sachkonto_id, '') AS sachkonto_id,
    art_id_empfaenger,
    COALESCE(lagerort_id_empfaenger, '') AS lagerort_id_empfaenger,
    art_id_bf,
    lagerbew_beleg_parent_pos_sort_id AS lagerbew_beleg_pos_mutter_id,
    lagerbew_beleg_pos_sort_id AS line_id,
    display_art_id,
    endlief_fg,
    xruem_fg,
    betrag_exbwr,
    betrag_bnk,
    betrag_umbewertung
FROM dbp_etl.de_mseg_menge_2);


INSERT INTO dbp_data.l_vorgangsart_2 (mandant_id, vorgangsart_id)
(
    SELECT
        mandant_id,
        vorgangsart_id
    FROM dbp_etl.de_mseg_menge_2
    WHERE
        vorgangsart_id IS NOT NULL
        AND (
            mandant_id, vorgangsart_id) NOT IN (
            SELECT (mandant_id, vorgangsart_id)
            FROM dbp_data.l_vorgangsart_2
        )
    GROUP BY
        mandant_id,
        vorgangsart_id
);


INSERT INTO dbp_data.vorgangsart_spr_zu_2 (mandant_id, vorgangsart_id, spr_id, vorgangsart_bez)
(
    SELECT
        MM.mandant_id,
        MM.vorgangsart_id,
        S.spr_id,
        'system generated' AS vorgangsart_bez
    FROM dbp_etl.de_mseg_menge_2 AS MM_2
    INNER JOIN dbp_data.mandant_spr_zu_2 AS MAN ON MM.mandant_id = MAN.mandant_id
    INNER JOIN dbp_data.spr_2 AS S ON S.dwh_spr = 1 AND S.spr_id = 22
    WHERE (
        MM.mandant_id, MM.vorgangsart_id, S.spr_id) NOT IN (
        SELECT (mandant_id, vorgangsart_id, spr_id)
        FROM dbp_data.vorgangsart_spr_zu_2
    )
    GROUP BY
        MM.mandant_id,
        MM.vorgangsart_id,
        S.spr_id,
        vorgangsart_bez
);


UPDATE dbp_data.l_lager_bewgrund_2 SET
    retourenart_id = x.retourenart_id_ FROM (
    SELECT
        mandant_id AS mandant_id_,
        lager_bewart_id AS lager_bewart_id_,
        grund_id AS grund_id_,
        MAX(retourenart_id) AS retourenart_id_
    FROM dbp_etl.de_mseg_delta_2 AS T1_2
    WHERE retourenart_id IS NOT NULL
    GROUP BY
        mandant_id_,
        lager_bewart_id_,
        grund_id_
) AS x
WHERE
    l_lager_bewgrund.mandant_id = x.mandant_id_ AND l_lager_bewgrund.lager_bewart_id = x.lager_bewart_id_ AND
    l_lager_bewgrund.grund_id = x.grund_id_ AND l_lager_bewgrund.mandant_id = 1;
