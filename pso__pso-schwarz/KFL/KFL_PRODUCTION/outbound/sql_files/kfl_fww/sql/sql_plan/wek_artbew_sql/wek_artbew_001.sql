CREATE OR REPLACE TEMPORARY TABLE _zeitraum AS
SELECT
    A.dat,
    A.kjmo
FROM dbp_data.tag AS A
INNER JOIN (
    SELECT kjmo
    FROM dbp_data.tag
    WHERE
        akt_mo BETWEEN (
            SELECT *
            FROM dbp_etl_process.fww_gld_zeitraum
        ) AND 0
    GROUP BY kjmo
) AS b
    ON A.kjmo = b.kjmo
WHERE A.dat < CURRENT_DATE("Europe/Berlin");


CREATE OR REPLACE TEMPORARY TABLE _perf1 AS
SELECT
    T1.mandant_id,
    T1.art_id,
    T1.bewart_id,
    T1.bewart_det_id,
    T1.wup_id,
    T1.nb_id,
    T1.dat,
    SUM(T1.umsatz_netto) AS umsatz_netto,
    SUM(T1.logkostenzuschlag) AS logkostenzuschlag,
    SUM(CASE
        WHEN
            T1.mandant_id = 1
            OR T1.mandant_id > 1
            AND T2.wg_id = 969
            AND T2.wug_id BETWEEN 1 AND 4
            THEN CAST(T1.ek_mep AS NUMERIC)
        ELSE COALESCE(T1.ek_gld, 0)
    END) AS ek_mep_einstandspreis,
    SUM(CASE
        WHEN
            T1.mandant_id = 1
            OR T1.mandant_id > 1
            AND T2.wg_id = 969
            AND T2.wug_id BETWEEN 1 AND 4
            THEN CAST(T1.ek_mep_vor_fwu AS NUMERIC)
        ELSE COALESCE(T1.ek_gld, 0)
    END) AS ek_mep_einstandspreis_fwu,
    SUM(T1.menge) AS menge
FROM dbp_data.artbew AS T1
INNER JOIN dbp_data.art_wg_zu_per AS T2
    ON
        T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id
        AND T2.arthiertyp_id = 2 AND T2.dat_bis = DATE '9999-12-31'
WHERE
    T1.dat BETWEEN (
        SELECT MIN(dat)
        FROM `_zeitraum`) AND (
        SELECT MAX(dat)
        FROM `_zeitraum`
    )
GROUP BY
    T1.mandant_id,
    T1.art_id,
    T1.bewart_id,
    T1.bewart_det_id,
    T1.wup_id,
    T1.nb_id,
    T1.dat;


CREATE OR REPLACE TEMPORARY TABLE _perf2 AS
SELECT
    mandant_id,
    art_id,
    dat_von,
    dat_bis,
    betrag_kmep_einh AS bonus_stk,
    betrag_kmep_einh_o_fwu AS bonus_stk_fwu
FROM dbp_etl_process.ekc_artbew_kmep AS U
WHERE zeitraum_kz = 'KM';


CREATE OR REPLACE TEMPORARY TABLE _perf3 AS
SELECT
    mandant_id,
    art_id,
    dat_von,
    dat_bis,
    betrag_kmep_einh AS bonus_stk,
    betrag_kmep_einh_o_fwu AS bonus_stk_fwu
FROM dbp_etl_process.ekc_artbew_kmep AS U
WHERE zeitraum_kz = 'KW';


CREATE OR REPLACE TEMPORARY TABLE _perf4 AS
SELECT
    mandant_id,
    art_id,
    dat_von,
    dat_bis,
    betrag_kmep_einh AS bonus_stk,
    betrag_kmep_einh_o_fwu AS bonus_stk_fwu
FROM dbp_etl_process.ekc_artbew_kmep AS U
WHERE zeitraum_kz = 'WW';


CREATE OR REPLACE TEMPORARY TABLE _perf5 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.bewart_id,
    A.bewart_det_id,
    A.wup_id,
    A.nb_id,
    A.dat,
    SUM(A.umsatz_netto) AS umsatz_netto_,
    SUM(A.logkostenzuschlag) AS logkostenzuschlag,
    SUM(A.ek_mep_einstandspreis) AS ek_mep_einstandspreis_,
    SUM(A.menge) AS menge_,
    SUM(COALESCE(B.bonus_stk, 0)) AS bonus_stk_,
    SUM(COALESCE(C.bonus_stk, 0)) AS bonus_stk_kw_,
    SUM(COALESCE(D.bonus_stk, 0)) AS bonus_stk_ww_,
    SUM(
        A.umsatz_netto
    )
    - SUM(A.ek_mep_einstandspreis)
    + SUM(
        A.menge) * SUM(COALESCE(B.bonus_stk, 0)) AS
    ek_mep_einstandspreis__,
    SUM(A.umsatz_netto)
    - SUM(A.ek_mep_einstandspreis)
    + SUM(A.menge) * SUM(COALESCE(C.bonus_stk, 0)) AS wa_kalk_kw_,
    SUM(A.umsatz_netto)
    - SUM(A.ek_mep_einstandspreis)
    + SUM(A.menge) * SUM(COALESCE(D.bonus_stk, 0)) AS wa_kalk_ww_,
    SUM(COALESCE(B.bonus_stk_fwu, 0)) AS bonus_stk_fwu_,
    SUM(COALESCE(C.bonus_stk_fwu, 0)) AS bonus_stk_fwu_kw_,
    SUM(COALESCE(D.bonus_stk_fwu, 0)) AS bonus_stk_fwu_ww_,
    SUM(
        A.umsatz_netto
    )
    - SUM(A.ek_mep_einstandspreis_fwu)
    + SUM(
        A.menge) * SUM(COALESCE(B.bonus_stk_fwu, 0)) AS
    ek_mep_einstandspreis_fwu__,
    SUM(
        A.umsatz_netto
    )
    - SUM(A.ek_mep_einstandspreis_fwu)
    + SUM(
        A.menge) * SUM(COALESCE(C.bonus_stk_fwu, 0)) AS
    wa_kalk_fwu_kw_,
    SUM(A.umsatz_netto)
    - SUM(A.ek_mep_einstandspreis_fwu)
    + SUM(A.menge) * SUM(COALESCE(D.bonus_stk_fwu, 0))
        AS
        wa_kalk_fwu_ww_
FROM `_perf1` AS A
LEFT JOIN
    `_perf2` AS B
    ON
        A.mandant_id = B.mandant_id
        AND A.art_id = B.art_id
        AND A.dat BETWEEN B.dat_von AND B.dat_bis

LEFT JOIN
    `_perf3` AS C
    ON
        A.mandant_id = C.mandant_id
        AND A.art_id = C.art_id
        AND A.dat BETWEEN C.dat_von AND C.dat_bis

LEFT JOIN
    `_perf4` AS D
    ON
        A.mandant_id = D.mandant_id
        AND A.art_id = D.art_id
        AND A.dat BETWEEN D.dat_von AND D.dat_bis

GROUP BY
    A.mandant_id,
    A.art_id,
    A.bewart_id,
    A.bewart_det_id,
    A.wup_id,
    A.nb_id,
    A.dat;


DELETE FROM dbp_etl_process.ekc_artbew
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM `_zeitraum`) AND (
    SELECT MAX(dat)
    FROM `_zeitraum`
);


INSERT INTO dbp_etl_process.ekc_artbew (
    mandant_id, art_id, bewart_id, wup_id, nb_id, dat, umsatz_netto_,
    logkostenzuschlag,
    ek_mep_einstandspreis_,
    menge_,
    bonus_stk_,
    bonus_stk_kw_,
    bonus_stk_ww_,
    ek_mep_einstandspreis__,
    wa_kalk_kw_,
    wa_kalk_ww_,
    bewart_det_id,
    bonus_stk_fwu_,
    bonus_stk_fwu_kw_,
    bonus_stk_fwu_ww_,
    ek_mep_einstandspreis_fwu__, wa_kalk_fwu_kw_, wa_kalk_fwu_ww_
)
(SELECT
    mandant_id,
    art_id,
    bewart_id,
    wup_id,
    nb_id,
    dat,
    umsatz_netto_,
    logkostenzuschlag,
    ek_mep_einstandspreis_,
    menge_,
    bonus_stk_ AS bonus_stk_,
    bonus_stk_kw_ AS bonus_stk_kw_,
    bonus_stk_ww_ AS bonus_stk_ww_,
    ek_mep_einstandspreis__ AS ek_mep_einstandspreis__,
    wa_kalk_kw_ AS wa_kalk_kw_,
    wa_kalk_ww_ AS wa_kalk_ww_,
    bewart_det_id,
    bonus_stk_fwu_ AS bonus_stk_fwu_,
    bonus_stk_fwu_kw_ AS bonus_stk_fwu_kw_,
    bonus_stk_fwu_ww_ AS bonus_stk_fwu_ww_,
    ek_mep_einstandspreis_fwu__ AS ek_mep_einstandspreis_fwu__,
    wa_kalk_fwu_kw_ AS wa_kalk_fwu_kw_,
    wa_kalk_fwu_ww_ AS wa_kalk_fwu_ww_
FROM `_perf5`);
