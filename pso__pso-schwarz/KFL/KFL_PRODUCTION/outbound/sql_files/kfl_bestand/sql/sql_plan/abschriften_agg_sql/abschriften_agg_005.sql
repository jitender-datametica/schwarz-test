INSERT INTO dbp_etl.useg_agg_dat (wup_id, nb_id, dat, mandant_id)
(
    SELECT
        T2.wup_id,
        T2.nb_id,
        T2.dat_umbew,
        T2.mandant_id
    FROM dbp_etl.kmo_idb_zmuseg AS T1
    INNER JOIN dbp_data.art_umbewertung AS T2
        ON
            T1.mandant_id = T2.mandant_id
            AND T1.umbew_beleg_id = T2.umbew_beleg_id
            AND T1.umbew_beleg_pos_id = T2.umbew_beleg_pos_id
            AND T1.kj = T2.kj
    INNER JOIN dbp_data.abschriftart_abschriftgrp_zu AS T3
        ON
            T2.mandant_id = T3.mandant_id AND T2.preis_aend_grund_id
            = T3.abschriftart_id AND T3.abschriftgruppe_id = 400
    GROUP BY
        T2.mandant_id,
        T2.wup_id,
        T2.nb_id,
        T2.dat_umbew
);


DELETE FROM dbp_data.marktabschriften_wg_sum
WHERE (
    wup_id, nb_id, dat, mandant_id) IN (
    SELECT (wup_id, nb_id, dat, mandant_id)
    FROM
        dbp_etl.useg_agg_dat
)
AND (mandant_id, abschriftart_id) IN (
    SELECT
        (mandant_id, abschriftart_id
        )
    FROM dbp_data.abschriftart_abschriftgrp_zu
    WHERE abschriftgruppe_id = 400
) AND mandant_id NOT IN (1
);


INSERT INTO dbp_data.marktabschriften_wg_sum (
    mandant_id, wup_id, nb_id, abschriftart_id, wg_id,
    arthiertyp_id, dat, abschriftbetrag_netto, abschriftbetrag_brutto, wrg_id
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.preis_aend_grund_id,
        T2.wg_id,
        T2.arthiertyp_id,
        T1.dat_umbew,
        SUM(T1.diff_wert_bestand_netto),
        SUM(T1.diff_wert_bestand_brutto),
        T1.wrg_id
    FROM dbp_data.art_umbewertung AS T1
    INNER JOIN dbp_data.art_wg_zu_per AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id
            AND T1.dat_umbew BETWEEN T2.dat_von AND T2.dat_bis AND T2.arthiertyp_id = 2
    INNER JOIN dbp_data.abschriftart_abschriftgrp_zu AS T3
        ON
            T1.mandant_id = T3.mandant_id AND T1.preis_aend_grund_id
            = T3.abschriftart_id AND T3.abschriftgruppe_id = 400
    WHERE (
        T1.wup_id, T1.nb_id, T1.dat_umbew, T1.mandant_id) IN (
        SELECT (wup_id, nb_id, dat, mandant_id)
        FROM dbp_etl.useg_agg_dat
    )
    GROUP BY
        T1.mandant_id,
        T1.preis_aend_grund_id,
        T1.wup_id,
        T1.nb_id,
        T1.dat_umbew,
        T1.wrg_id,
        T2.arthiertyp_id,
        T2.wg_id
);
