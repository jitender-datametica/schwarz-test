CREATE OR REPLACE TEMPORARY TABLE _zwischen1_2 AS
SELECT
    mandant_id,
    wup_id,
    nb_id,
    dat,
    wup_abschrift_id,
    positionsnummer_id,
    abschriftart_id,
    art_id,
    MAX(wrg_id) AS wrg_id,
    MAX(woche_id) AS woche_id,
    MAX(wv_kz) AS wv_kz,
    MAX(wv_grund_id) AS wv_grund_id,
    MAX(abschrift_menge_einh_id) AS abschrift_menge_einh_id,
    MAX(lastupd_dat) AS lastupd_dat,
    SUM(menge_abschrift) AS menge_abschrift,
    SUM(abschriftbetrag_netto) AS abschriftbetrag_netto,
    SUM(abschriftbetrag_brutto) AS abschriftbetrag_brutto,
    MAX(vk_aktion_brutto) AS vk_aktion_brutto,
    MAX(vk_brutto) AS vk_brutto
FROM ${TEMP_TABLE}
GROUP BY
    mandant_id,
    wup_id,
    nb_id,
    dat,
    wup_abschrift_id,
    positionsnummer_id,
    abschriftart_id,
    art_id;


DELETE FROM dbp_data.marktabschriften_2
WHERE (wup_id, wup_abschrift_id, positionsnummer_id, nb_id, dat, mandant_id, abschriftart_id, art_id) IN (SELECT (
    wup_id,
    wup_abschrift_id, positionsnummer_id, nb_id, dat, mandant_id, abschriftart_id, art_id
)
FROM `_zwischen1_2`);


INSERT INTO dbp_data.marktabschriften_2 (
    wup_id, wup_abschrift_id, positionsnummer_id, nb_id, dat,
    mandant_id, lastupd_dat, woche_id, menge_abschrift, abschriftart_id, art_id, abschriftbetrag_netto,
    abschriftbetrag_brutto, wrg_id, wv_kz, wv_grund_id, vk_aktion_brutto, vk_brutto, td_insert, td_update,
    abschrift_menge_einh_id
)
(SELECT
    wup_id,
    wup_abschrift_id,
    positionsnummer_id,
    nb_id,
    dat,
    mandant_id,
    lastupd_dat,
    woche_id,
    menge_abschrift,
    abschriftart_id,
    art_id,
    abschriftbetrag_netto,
    abschriftbetrag_brutto,
    wrg_id,
    wv_kz,
    wv_grund_id,
    vk_aktion_brutto,
    vk_brutto,
    CURRENT_TIMESTAMP() AS td_insert,
    CURRENT_TIMESTAMP() AS td_update,
    abschrift_menge_einh_id
FROM `_zwischen1_2`);


DROP TABLE IF EXISTS dbp_etl.marktabschriften_agg_dat_2;


CREATE TABLE IF NOT EXISTS dbp_etl.marktabschriften_agg_dat_2 (
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE,
    mandant_id INTEGER NOT NULL
);


INSERT INTO dbp_etl.marktabschriften_agg_dat_2 (wup_id, nb_id, dat, mandant_id)
(
    SELECT
        wup_id,
        nb_id,
        dat,
        mandant_id
    FROM ${TEMP_TABLE}
    GROUP BY
        wup_id,
        nb_id,
        dat,
        mandant_id
);


DELETE FROM dbp_data.marktabschriften_wg_sum_2
WHERE (wup_id, nb_id, dat, mandant_id) IN (SELECT
    (wup_id, nb_id, dat, mandant_id
    )
FROM dbp_etl.marktabschriften_agg_dat_2);


INSERT INTO dbp_data.marktabschriften_wg_sum_2 (
    mandant_id, wup_id, nb_id, abschriftart_id, wg_id,
    arthiertyp_id, dat, abschriftbetrag_netto, abschriftbetrag_brutto, wrg_id
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.abschriftart_id,
        T2.wg_id,
        T2.arthiertyp_id,
        T1.dat,
        SUM(T1.abschriftbetrag_netto),
        SUM(T1.abschriftbetrag_brutto),
        T1.wrg_id
    FROM dbp_data.marktabschriften_2 AS T1_2
    INNER JOIN dbp_data.art_wg_zu_per_2 AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id AND
            T1.dat BETWEEN T2.dat_von AND T2.dat_bis AND T2.arthiertyp_id = 2
    WHERE (
        T1.wup_id, T1.nb_id, T1.dat, T1.mandant_id) IN (
        SELECT (wup_id, nb_id, dat, mandant_id)
        FROM dbp_etl.marktabschriften_agg_dat_2
    )
    GROUP BY
        T1.wup_id,
        T1.nb_id,
        T1.dat,
        T1.mandant_id,
        T1.abschriftart_id,
        T1.wrg_id,
        T2.arthiertyp_id,
        T2.wg_id
);
