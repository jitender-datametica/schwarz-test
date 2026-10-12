--[OK] statement fixed-----------------------------------------------------------------


INSERT INTO dbp_etl.art_best_vw_sum_artbew_kmo_tmp (
    mandant_id, wup_id, nb_id, art_id, gp_id, wrg_id,
    relevant_fg, bezugsweg_id, dat, menge_abgang_bme, betrag_vk_netto_abgang, herkunft
)
(
    SELECT
        M.mandant_id,
        M.wup_id,
        M.nb_id,
        M.art_id,
        A.gp_id,
        A.wrg AS wrg_id,
        M.relevant_fg,
        M.bezugsweg_id,
        D.dat,
        A.menge AS menge_abgang_bme,
        A.umsatz_netto,
        'm' AS herkunft
    FROM dbp_data.marktbestand_erp AS M
    INNER JOIN dbp_data.artbew AS A ON TRUE
    INNER JOIN dbp_etl.art_best_vw_sum_artbew_kmo_dat AS D ON TRUE
    WHERE
        M.mandant_id = A.mandant_id
        AND M.mandant_id = D.mandant_id
        AND D.dat = M.dat
        AND A.dat = D.dat
        AND M.wup_id = A.wup_id
        AND M.nb_id = A.nb_id
        AND M.art_id = A.art_id
        AND A.mandant_id IN (${MIDKMO}) -- Fuer KMO keine Einschraenkung der bezugsweg_id

        -- AND a.bezugsweg_id IN (1, 4)
        -- AND m.bezugsweg_id IN (1, 4)

        AND A.bezugsweg_id = M.bezugsweg_id
);


--[OK] statement fixed-----------------------------------------------------------------


INSERT INTO dbp_etl.art_best_vw_sum_artbew_kmo_tmp (
    mandant_id, wup_id, nb_id, art_id, gp_id, wrg_id,
    relevant_fg, bezugsweg_id, dat, menge_abgang_bme, betrag_vk_netto_abgang, herkunft
)
(
    SELECT
        a.mandant_id,
        a.wup_id,
        a.nb_id,
        a.art_id,
        a.gp_id,
        a.wrg_id,
        a.relevant_fg,
        a.bezugsweg_id,
        a.dat,
        a.menge_abgang_bme,
        a.umsatz_netto,
        'a' AS herkunft
    FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            A.gp_id,
            A.wrg AS wrg_id,
            -1 AS relevant_fg,
            A.bezugsweg_id,
            D.dat,
            A.menge AS menge_abgang_bme,
            A.umsatz_netto
        FROM dbp_data.artbew AS A
        INNER JOIN dbp_etl.art_best_vw_sum_artbew_kmo_dat AS D ON TRUE
        WHERE
            A.mandant_id = D.mandant_id
            AND A.dat = D.dat -- Fuer KMO keine Einschraenkung der bezugsweg_id
            -- AND a.bezugsweg_id IN (1, 4)

            AND A.mandant_id IN (${MIDKMO})
    ) AS a
    LEFT JOIN dbp_etl.art_best_vw_sum_artbew_kmo_tmp AS M
        ON
            a.mandant_id = M.mandant_id AND a.dat = M.dat
            AND a.wup_id = M.wup_id AND a.nb_id = M.nb_id AND a.art_id = M.art_id AND a.bezugsweg_id = M.bezugsweg_id
    WHERE M.mandant_id IS NULL
);


--[OK] statement fixed-----------------------------------------------------------------


INSERT INTO dbp_etl.art_best_vw_sum_artbew_tmpk2 (
    mandant_id, wup_id, nb_id, art_id, gp_id, wrg_id, vw_id,
    relevant_fg, bezugsweg_id, dat, menge_abgang_bme, betrag_vk_netto_abgang, herkunft
)
(
    SELECT
        T.mandant_id,
        -1 AS wup_id_neu,
        -1 AS nb_id_neu,
        T.art_id,
        T.gp_id,
        T.wrg_id,
        W.vw_id,
        T.relevant_fg,
        T.bezugsweg_id,
        T.dat,
        SUM(T.menge_abgang_bme),
        SUM(T.betrag_vk_netto_abgang),
        T.herkunft
    FROM dbp_etl.art_best_vw_sum_artbew_kmo_tmp AS T
    INNER JOIN dbp_data.wup AS W ON T.mandant_id = W.mandant_id AND T.wup_id = W.wup_id AND T.nb_id = W.nb_id

    WHERE T.mandant_id IN (${MIDKMO})
    GROUP BY
        T.mandant_id,
        wup_id_neu,
        nb_id_neu,
        T.art_id,
        T.gp_id,
        W.vw_id,
        T.relevant_fg,
        T.bezugsweg_id,
        T.dat,
        T.wrg_id,
        T.herkunft
);


--[OK] statement fixed-----------------------------------------------------------------


INSERT INTO dbp_etl.art_bestand_vw_sum_kmo_tmp (
    mandant_id, vw_id, bezugsweg_id,
    lagerbestand_fg, nb_id, art_id, wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_gesamt_bme, menge_lgbest_erp_qual_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_gesamt_bme,
    betrag_vk_netto_qual_bme, menge_abgang_bme, betrag_vk_netto_abgang, herkunft
)
(
    SELECT
        D.mandant_id,
        D.vw_id,
        D.bezugsweg_id,
        D.lagerbestand_fg,
        D.nb_id,
        D.art_id,
        D.wup_id,
        D.dat,
        D.gp_id,
        D.relevant_fg,
        D.wrg_id,
        D.menge_lgbest_erp_frei_bme,
        D.menge_lgbest_erp_gesamt_bme,
        D.menge_lgbest_erp_qual_bme,
        D.betrag_vk_netto_frei_bme,
        D.betrag_vk_netto_gesamt_bme,
        D.betrag_vk_netto_qual_bme,
        T.menge_abgang_bme,
        T.betrag_vk_netto_abgang,
        T.herkunft
    FROM dbp_data.art_bestand_vw_sum AS D
    INNER JOIN dbp_etl.art_best_vw_sum_artbew_tmpk2 AS T
        ON
            D.mandant_id = T.mandant_id AND D.wup_id = T.wup_id
            AND D.nb_id = T.nb_id AND D.art_id = T.art_id AND D.gp_id = T.gp_id AND D.vw_id = T.vw_id AND D.bezugsweg_id
            = T.bezugsweg_id AND D.dat = T.dat AND D.wrg_id = T.wrg_id AND D.relevant_fg = T.relevant_fg
    WHERE
        D.mandant_id IN (${MIDKMO})
        AND D.lagerbestand_fg = 0
        AND T.herkunft = 'm' /* Herkunft marktbestand_erp_per */
);


--[OK] statement fixed-----------------------------------------------------------------


DELETE FROM dbp_etl.art_best_vw_sum_artbew_tmpk2
WHERE (mandant_id, vw_id, bezugsweg_id, nb_id, art_id, wup_id, gp_id, relevant_fg, wrg_id, dat) IN (SELECT (
    mandant_id,
    vw_id, bezugsweg_id, nb_id, art_id, wup_id, gp_id, relevant_fg, wrg_id, dat
)
FROM dbp_etl.art_bestand_vw_sum_kmo_tmp) AND mandant_id IN (${MIDKMO}) AND herkunft = 'm';


--[OK] statement fixed-----------------------------------------------------------------


INSERT INTO dbp_etl.art_bestand_vw_sum_kmo_tmp (
    mandant_id, vw_id,
    bezugsweg_id, lagerbestand_fg, nb_id, art_id, wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_gesamt_bme, menge_lgbest_erp_qual_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_gesamt_bme,
    betrag_vk_netto_qual_bme, menge_abgang_bme, betrag_vk_netto_abgang, herkunft
)
(SELECT
    t2.mandant_id,
    t2.vw_id,
    t2.bezugsweg_id,
    t2.lagerbestand_fg,
    t2.nb_id,
    t2.art_id,
    t2.wup_id,
    t2.dat,
    t2.gp_id,
    t2.relevant_fg,
    t2.wrg_id,
    0 AS menge_lgbest_erp_frei_bme,
    0 AS menge_lgbest_erp_gesamt_bme,
    0 AS menge_lgbest_erp_qual_bme,
    0 AS betrag_vk_netto_frei_bme,
    0 AS betrag_vk_netto_gesamt_bme,
    0 AS betrag_vk_netto_qual_bme,
    t2.menge_abgang_bme,
    t2.betrag_vk_netto_abgang,
    t2.herkunft
FROM (
    SELECT
        D.mandant_id,
        D.vw_id,
        D.bezugsweg_id,
        D.lagerbestand_fg,
        D.nb_id,
        D.art_id,
        D.wup_id,
        T.dat,
        D.gp_id,
        D.relevant_fg,
        D.wrg_id,
        0 AS menge_lgbest_erp_frei_bme,
        0 AS menge_lgbest_erp_gesamt_bme,
        0 AS menge_lgbest_erp_qual_bme,
        0 AS betrag_vk_netto_frei_bme,
        0 AS betrag_vk_netto_gesamt_bme,
        0 AS betrag_vk_netto_qual_bme,
        T.menge_abgang_bme,
        T.betrag_vk_netto_abgang,
        D.dat AS csum_dat,
        T.herkunft
    FROM dbp_etl.art_best_vw_sum_artbew_tmpk2 AS T
    INNER JOIN dbp_data.art_bestand_vw_sum AS D
        ON
            T.mandant_id = D.mandant_id AND T.wup_id = D.wup_id
            AND T.nb_id = D.nb_id AND T.art_id = D.art_id AND T.gp_id = D.gp_id AND T.vw_id = D.vw_id AND T.bezugsweg_id
            = D.bezugsweg_id AND T.relevant_fg = D.relevant_fg AND T.dat >= D.dat AND T.wrg_id = D.wrg_id AND D.mandant_id
            IN (${MIDKMO}) AND D.lagerbestand_fg = 0
    WHERE
        T.mandant_id IN (${MIDKMO})
        AND T.herkunft = 'm' /* Herkunft marktbestand_erp_per */
    QUALIFY (COUNT(*) OVER (PARTITION BY
        D.mandant_id, D.vw_id, D.bezugsweg_id, D.lagerbestand_fg, D.nb_id, D.art_id, D.wup_id,
        D.gp_id, D.relevant_fg, D.wrg_id, T.dat
    ORDER BY csum_dat IS NULL DESC, csum_dat DESC
    ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW)) = 1
) AS t2);


--[OK] statement fixed-----------------------------------------------------------------


INSERT INTO dbp_etl.art_bestand_vw_sum_kmo_tmp (
    mandant_id, vw_id,
    bezugsweg_id, lagerbestand_fg, nb_id, art_id, wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_gesamt_bme, menge_lgbest_erp_qual_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_gesamt_bme,
    betrag_vk_netto_qual_bme, menge_abgang_bme, betrag_vk_netto_abgang, herkunft
)
(SELECT
    t2.mandant_id,
    t2.vw_id,
    t2.bezugsweg_id,
    t2.lagerbestand_fg,
    t2.nb_id,
    t2.art_id,
    t2.wup_id,
    t2.dat,
    t2.gp_id,
    t2.relevant_fg,
    t2.wrg_id,
    0 AS menge_lgbest_erp_frei_bme,
    0 AS menge_lgbest_erp_gesamt_bme,
    0 AS menge_lgbest_erp_qual_bme,
    0 AS betrag_vk_netto_frei_bme,
    0 AS betrag_vk_netto_gesamt_bme,
    0 AS betrag_vk_netto_qual_bme,
    t2.menge_abgang_bme,
    t2.betrag_vk_netto_abgang,
    t2.herkunft
FROM (
    SELECT
        D.mandant_id,
        D.vw_id,
        D.bezugsweg_id,
        D.lagerbestand_fg,
        D.nb_id,
        D.art_id,
        D.wup_id,
        T.dat,
        D.gp_id,
        D.relevant_fg,
        D.wrg_id,
        0 AS menge_lgbest_erp_frei_bme,
        0 AS menge_lgbest_erp_gesamt_bme,
        0 AS menge_lgbest_erp_qual_bme,
        0 AS betrag_vk_netto_frei_bme,
        0 AS betrag_vk_netto_gesamt_bme,
        0 AS betrag_vk_netto_qual_bme,
        T.menge_abgang_bme,
        T.betrag_vk_netto_abgang,
        D.dat AS csum_dat,
        T.herkunft
    FROM dbp_etl.art_best_vw_sum_artbew_tmpk2 AS T
    INNER JOIN dbp_data.art_bestand_vw_sum AS D
        ON
            T.mandant_id = D.mandant_id AND T.wup_id = D.wup_id
            AND T.nb_id = D.nb_id AND T.art_id = D.art_id AND T.gp_id = D.gp_id AND T.vw_id = D.vw_id AND T.bezugsweg_id
            = D.bezugsweg_id AND T.dat >= D.dat AND T.wrg_id = D.wrg_id
    WHERE
        D.mandant_id IN (${MIDKMO})
        AND D.lagerbestand_fg = 0
        AND T.herkunft = 'a' /* Herkunft artbew */
    QUALIFY (COUNT(*) OVER (PARTITION BY
        D.mandant_id, D.vw_id, D.bezugsweg_id, D.lagerbestand_fg, D.nb_id, D.art_id, D.wup_id,
        D.gp_id, D.wrg_id, T.dat
    ORDER BY csum_dat IS NULL DESC, csum_dat DESC, D.relevant_fg IS NULL, D.relevant_fg
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 1
) AS t2);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.art_bestand_vw_sum_kmo_tmp2 (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id,
    art_id, wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_gesamt_bme,
    menge_lgbest_erp_qual_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_gesamt_bme, betrag_vk_netto_qual_bme,
    menge_abgang_bme, betrag_vk_netto_abgang
)
(
    SELECT
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
        SUM(menge_lgbest_erp_frei_bme),
        SUM(menge_lgbest_erp_gesamt_bme),
        SUM(menge_lgbest_erp_qual_bme),
        SUM(betrag_vk_netto_frei_bme),
        SUM(betrag_vk_netto_gesamt_bme),
        SUM(betrag_vk_netto_qual_bme),
        SUM(menge_abgang_bme),
        SUM(betrag_vk_netto_abgang)
    FROM dbp_etl.art_bestand_vw_sum_kmo_tmp
    GROUP BY
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
        wrg_id
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.art_bestand_vw_sum
WHERE (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id, art_id, wup_id, dat, gp_id, relevant_fg, wrg_id) IN (
    SELECT (mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id, art_id, wup_id, dat, gp_id, relevant_fg, wrg_id)
    FROM dbp_etl.art_bestand_vw_sum_kmo_tmp2
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.art_bestand_vw_sum (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id, art_id,
    wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesamt_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_netto_gesamt_bme,
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
FROM dbp_etl.art_bestand_vw_sum_kmo_tmp2);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_best_vw_sum_artbew_kmo_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_best_vw_sum_artbew_tmpk2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_kmo_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_kmo_tmp2;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.marktbestand_erp SET
    bezugsweg_id = b.`_bezugsweg_id` FROM (
    SELECT
        T01.mandant_id AS `_mandant_id`,
        T01.dat AS `_dat`,
        T01.wup_id AS `_wup_id`,
        T01.art_id AS `_art_id`,
        T02.bezugsweg_id AS `_bezugsweg_id`
    FROM dbp_data.marktbestand_erp AS T01
    INNER JOIN dbp_data.art_wup_zu_per AS T02
        ON
            T01.mandant_id = T02.mandant_id AND T01.art_id = T02.art_id
            AND T01.wup_id = T02.wup_id
    WHERE
        T01.dat BETWEEN T02.dat_von AND T02.dat_bis
        AND T01.dat IN (
            SELECT dat
            FROM dbp_etl.art_best_vw_sum_artbew_kmo_dat
        )
        AND T01.mandant_id > 1
) AS b
WHERE
    marktbestand_erp.mandant_id = b.`_mandant_id` AND marktbestand_erp.wup_id = b.`_wup_id` AND marktbestand_erp.art_id
    = b.`_art_id` AND marktbestand_erp.dat = b.`_dat`;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)


CREATE OR REPLACE TABLE dbp_etl._mard_erp_${TRANSIENT_TABLE_SUFFIX} AS
SELECT
    A.mandant_id,
    A.dat,
    A.art_id,
    A.relevant_fg,
    A.bezugsweg_id,
    COALESCE(C.gp_id, -1) AS gp_id,
    SUM(A.menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
    SUM(A.menge_lgbest_erp_frei_bme + A.menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_gesamt_bme,
    SUM(A.menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme,
    ROUND(CAST(SUM(CAST(B.vk_netto * A.menge_lgbest_erp_frei_bme AS FLOAT64)) AS NUMERIC), 4) AS betrag_vk_netto_frei_bme,
    ROUND(
        CAST(SUM(CAST(B.vk_netto * (A.menge_lgbest_erp_frei_bme + A.menge_lgbest_erp_qual_bme) AS FLOAT64)) AS NUMERIC),
        4
    ) AS betrag_vk_netto_gesamt_bme,
    ROUND(CAST(SUM(CAST(B.vk_netto * A.menge_lgbest_erp_qual_bme AS FLOAT64)) AS NUMERIC), 4) AS betrag_vk_netto_qual_bme
FROM dbp_data.marktbestand_erp AS A
LEFT JOIN dbp_data.marktbestand_erp_zu AS B ON A.bestand_id = B.bestand_id AND A.mandant_id = B.mandant_id

LEFT JOIN dbp_data.art_gp_nm_zu_per AS C
    ON
        A.mandant_id = C.mandant_id AND A.dat BETWEEN C.dat_von AND
        C.dat_bis AND A.wup_id = C.wup_id AND A.art_id = C.art_id
WHERE
    A.mandant_id > 1
    AND A.dat IN (
        SELECT dat
        FROM dbp_etl.art_best_vw_sum_artbew_kmo_dat
    )
    AND A.nb_id = 0
GROUP BY
    A.mandant_id,
    A.dat,
    A.art_id,
    A.relevant_fg,
    A.bezugsweg_id,
    gp_id
HAVING menge_lgbest_erp_frei_bme <> 0;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.art_bestand_vw_sum SET
    menge_lgbest_erp_frei_bme = 0,
    menge_lgbest_erp_qual_bme = 0,
    menge_lgbest_erp_gesamt_bme = 0,
    betrag_vk_netto_frei_bme = 0,
    betrag_vk_netto_qual_bme = 0,
    betrag_vk_netto_gesamt_bme = 0
WHERE mandant_id > 1 AND dat IN (
    SELECT dat
    FROM dbp_etl.art_best_vw_sum_artbew_kmo_dat
) AND wup_id = -1;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.art_bestand_vw_sum SET
    menge_lgbest_erp_frei_bme = b.menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme = b.menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesamt_bme = b.menge_lgbest_erp_gesamt_bme,
    betrag_vk_netto_frei_bme = b.betrag_vk_netto_frei_bme,
    betrag_vk_netto_qual_bme = b.betrag_vk_netto_qual_bme,
    betrag_vk_netto_gesamt_bme = b.betrag_vk_netto_gesamt_bme FROM
    dbp_etl._mard_erp_${TRANSIENT_TABLE_SUFFIX}
        AS b
WHERE
    art_bestand_vw_sum.mandant_id = b.mandant_id AND art_bestand_vw_sum.dat = b.dat AND art_bestand_vw_sum.art_id = b.art_id AND art_bestand_vw_sum.relevant_fg = b.relevant_fg AND art_bestand_vw_sum.gp_id = b.gp_id AND
    art_bestand_vw_sum.bezugsweg_id = b.bezugsweg_id AND art_bestand_vw_sum.wup_id = -1 AND art_bestand_vw_sum.menge_lgbest_erp_frei_bme
    <> b.menge_lgbest_erp_frei_bme;


--[OK] statement is translated correctly (syntax and type checks are fine)


TRUNCATE TABLE dbp_etl.art_best_vw_sum_artbew_kmo_dat;
