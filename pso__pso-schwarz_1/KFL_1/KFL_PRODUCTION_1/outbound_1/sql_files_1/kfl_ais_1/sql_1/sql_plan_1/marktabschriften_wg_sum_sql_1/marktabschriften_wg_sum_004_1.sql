--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.marktabschriften_agg_dat_1 (
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE,
    mandant_id INTEGER NOT NULL
);


INSERT INTO dbp_etl.marktabschriften_agg_dat_1 (wup_id, nb_id, dat, mandant_id)
(
    SELECT
        CAST(wup_id AS INTEGER) AS wup_id,
        CAST(nb_id AS INTEGER) AS nb_id,
        dat,
        CAST(mandant_id AS INTEGER) AS mandant_id
    FROM dbp_etl.marktabschriften_temp_1
    GROUP BY
        wup_id,
        nb_id,
        dat,
        mandant_id
);


DELETE FROM dbp_data.marktabschriften_wg_sum_1
WHERE (
    wup_id, nb_id, dat, mandant_id) IN (
    SELECT (wup_id, nb_id, dat, mandant_id) --PE-Review
    FROM dbp_etl.marktabschriften_agg_dat_1
);


INSERT INTO dbp_data.marktabschriften_wg_sum_1 (
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
    FROM dbp_data.marktabschriften_1 AS T1_1
    INNER JOIN dbp_data.art_wg_zu_per_1 AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id AND
            T1.dat BETWEEN T2.dat_von AND T2.dat_bis AND T2.arthiertyp_id = 2
    WHERE (T1.wup_id, T1.nb_id, T1.dat, T1.mandant_id) IN (SELECT (
        wup_id, nb_id,
        dat, mandant_id
    ) --PE-Review
    FROM dbp_etl.marktabschriften_agg_dat_1)
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
