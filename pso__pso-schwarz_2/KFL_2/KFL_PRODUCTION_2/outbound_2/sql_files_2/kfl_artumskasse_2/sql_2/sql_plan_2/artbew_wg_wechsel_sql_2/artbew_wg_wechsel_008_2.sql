DROP TABLE IF EXISTS dbp_etl.artbew_wg_wechsel_join_2;


CREATE TABLE IF NOT EXISTS dbp_etl.artbew_wg_wechsel_join_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    alt_neu_kz INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    wg_art_fg INTEGER
);


DROP TABLE IF EXISTS dbp_etl.artbew_wg_sum_tmp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.artbew_wg_sum_tmp_2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    dat DATE,
    bewart_id INTEGER NOT NULL,
    posten_id STRING(2) DEFAULT '  ' NOT NULL,
    menge NUMERIC(29, 4),
    menge_ohne_wg_erf_art NUMERIC(29, 4),
    umsatz_netto NUMERIC(29, 4),
    diff_umsatz_netto_konz NUMERIC(29, 4),
    umsatz_mwst_betrag NUMERIC(29, 4),
    diff_umsatz_mwst_betrag_konz NUMERIC(29, 4),
    ek_brutto NUMERIC(29, 4),
    diff_ek_brutto_konz NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    diff_ek_netto_konz NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    diff_ek_nettonetto_konz NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    diff_ek_kal_basis_konz NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    diff_ek_mep_konz NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    diff_einstandspreis_konz NUMERIC(29, 4),
    logkostenzuschlag NUMERIC(29, 4),
    diff_logkostenzuschlag_konz NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    diff_ek_netto_bnk_konz NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4)
);


INSERT INTO dbp_etl.artbew_wg_wechsel_tmp_2 (
    mandant_id, art_id, arthiertyp_id, alt_neu_kz, wg_id,
    wg_art_fg
)
(SELECT
    mandant_id,
    art_id,
    arthiertyp_id,
    -1,
    wg_id,
    wg_art_fg
FROM dbp_etl_process.artbew_wg_wechsel_2);


INSERT INTO dbp_etl.artbew_wg_wechsel_tmp_2 (
    mandant_id, art_id, arthiertyp_id, alt_neu_kz, wg_id,
    wg_art_fg
)
(
    SELECT
        T01.mandant_id,
        T01.art_id,
        T01.arthiertyp_id,
        1,
        T01.wg_id,
        CAST(T02.wg_art_fg AS INTEGER) AS wg_art_fg
    FROM dbp_data.art_wg_zu_per_2 AS T01
    INNER JOIN
        dbp_data.art_2 AS T02
        ON T01.mandant_id = T02.mandant_id AND T01.art_id = T02.art_id
    WHERE T01.dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_etl.artbew_wg_wechsel_join_2 (
    mandant_id, art_id, arthiertyp_id, dat, alt_neu_kz, wg_id,
    wg_art_fg
)
(
    SELECT
        W1.mandant_id,
        W1.art_id,
        W1.arthiertyp_id,
        T.dat,
        W1.alt_neu_kz,
        W1.wg_id,
        W1.wg_art_fg
    FROM dbp_etl.artbew_wg_wechsel_tmp_2 AS W1
    INNER JOIN dbp_etl.artbew_wg_wechsel_tmp_2 AS W2
        ON
            W1.mandant_id = W2.mandant_id AND W1.art_id = W2.art_id
            AND W1.arthiertyp_id = W2.arthiertyp_id AND (
                W1.alt_neu_kz = 1 AND W2.alt_neu_kz = -1
                OR W1.alt_neu_kz = -1
                AND W2.alt_neu_kz = 1
            )
    INNER JOIN
        dbp_data.tag_2 AS T
        ON
            T.dat <= CURRENT_DATE("Europe/Berlin")
            AND T.dat >= DATE '2000-01-01'
    WHERE
        W1.wg_id <> W2.wg_id
        OR W1.wg_art_fg <> W2.wg_art_fg
);


INSERT INTO dbp_etl.vis_tag_bestand_wg_wechsel_log_2 (
    mandant_id, art_id, arthiertyp_id, wg_id
)
(
    SELECT
        W1.mandant_id,
        W1.art_id,
        W1.arthiertyp_id,
        W1.wg_id
    FROM dbp_etl.artbew_wg_wechsel_tmp_2 AS W1
    INNER JOIN dbp_etl.artbew_wg_wechsel_tmp_2 AS W2
        ON
            W1.mandant_id = W2.mandant_id AND W1.art_id = W2.art_id
            AND W1.arthiertyp_id = W2.arthiertyp_id
            AND W1.alt_neu_kz = -1
            AND W2.alt_neu_kz = 1
    WHERE
        W1.wg_id <> W2.wg_id
        AND W1.arthiertyp_id = 2
        AND (
            W1.mandant_id, W1.art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl.vis_tag_bestand_wg_wechsel_log_2
        )
);


INSERT INTO dbp_etl.vis_monat_best_wg_wechsel_log_2 (
    mandant_id, art_id, arthiertyp_id, wg_id
)
(
    SELECT
        W1.mandant_id,
        W1.art_id,
        W1.arthiertyp_id,
        W1.wg_id
    FROM dbp_etl.artbew_wg_wechsel_tmp_2 AS W1
    INNER JOIN dbp_etl.artbew_wg_wechsel_tmp_2 AS W2
        ON
            W1.mandant_id = W2.mandant_id AND W1.art_id = W2.art_id
            AND W1.arthiertyp_id = W2.arthiertyp_id
            AND W1.alt_neu_kz = -1
            AND W2.alt_neu_kz = 1
    WHERE
        W1.wg_id <> W2.wg_id
        AND W1.arthiertyp_id = 2
        AND (
            W1.mandant_id, W1.art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl.vis_monat_best_wg_wechsel_log_2
        )
);


INSERT INTO dbp_etl.artbew_wg_sum_tmp_2 (
    mandant_id, wup_id, nb_id, wg_id, arthiertyp_id, dat, bewart_id,
    posten_id,
    menge,
    menge_ohne_wg_erf_art,
    umsatz_netto,
    diff_umsatz_netto_konz,
    umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz,
    ek_brutto,
    diff_ek_brutto_konz,
    ek_netto,
    diff_ek_netto_konz,
    ek_nettonetto,
    diff_ek_nettonetto_konz,
    ek_kal_basis,
    diff_ek_kal_basis_konz,
    ek_mep,
    diff_ek_mep_konz,
    einstandspreis,
    diff_einstandspreis_konz,
    logkostenzuschlag,
    diff_logkostenzuschlag_konz,
    ek_netto_bnk,
    diff_ek_netto_bnk_konz,
    ek_netto_bnk_sachk, diff_ek_netto_bnk_sachk_konz
)
(
    SELECT
        T01.mandant_id,
        T01.wup_id,
        T01.nb_id,
        T02.wg_id,
        T02.arthiertyp_id,
        T01.dat,
        T01.bewart_id,
        T01.posten_id,
        CAST(SUM(T01.menge * T02.alt_neu_kz) AS NUMERIC),
        CAST(SUM(CASE
            WHEN T02.wg_art_fg = 0
                THEN T01.menge
            ELSE 0
        END * T02.alt_neu_kz) AS NUMERIC),
        CAST(SUM(T01.umsatz_netto * T02.alt_neu_kz) AS NUMERIC),
        CAST(SUM(T01.diff_umsatz_netto_konz * T02.alt_neu_kz) AS NUMERIC),
        CAST(SUM(T01.umsatz_mwst_betrag * T02.alt_neu_kz) AS NUMERIC),
        CAST(SUM(T01.diff_umsatz_mwst_betrag_konz * T02.alt_neu_kz) AS NUMERIC),
        CAST(SUM(CAST(T01.ek_brutto AS NUMERIC) * T02.alt_neu_kz) AS NUMERIC),
        CAST(
            SUM(
                CAST(T01.diff_ek_brutto_konz AS NUMERIC) * T02.alt_neu_kz
            ) AS NUMERIC
        ),
        CAST(SUM(CAST(T01.ek_netto AS NUMERIC) * T02.alt_neu_kz) AS NUMERIC),
        CAST(
            SUM(
                CAST(T01.diff_ek_netto_konz AS NUMERIC) * T02.alt_neu_kz
            ) AS NUMERIC
        ),
        CAST(
            SUM(CAST(T01.ek_nettonetto AS NUMERIC) * T02.alt_neu_kz) AS NUMERIC
        ),
        CAST(
            SUM(
                CAST(T01.diff_ek_nettonetto_konz AS NUMERIC) * T02.alt_neu_kz
            ) AS NUMERIC
        ),
        CAST(
            SUM(CAST(T01.ek_kal_basis AS NUMERIC) * T02.alt_neu_kz) AS NUMERIC
        ),
        CAST(
            SUM(
                CAST(T01.diff_ek_kal_basis_konz AS NUMERIC) * T02.alt_neu_kz
            ) AS NUMERIC
        ),
        CAST(SUM(CAST(T01.ek_mep AS NUMERIC) * T02.alt_neu_kz) AS NUMERIC),
        CAST(
            SUM(
                CAST(T01.diff_ek_mep_konz AS NUMERIC) * T02.alt_neu_kz
            ) AS NUMERIC
        ),
        CAST(
            SUM(CAST(T01.einstandspreis AS NUMERIC) * T02.alt_neu_kz) AS NUMERIC
        ),
        CAST(
            SUM(
                CAST(T01.diff_einstandspreis_konz AS NUMERIC) * T02.alt_neu_kz
            ) AS NUMERIC
        ),
        CAST(SUM(T01.logkostenzuschlag * T02.alt_neu_kz) AS NUMERIC),
        CAST(SUM(T01.diff_logkostenzuschlag_konz * T02.alt_neu_kz) AS NUMERIC),
        CAST(
            SUM(CAST(T01.ek_netto_bnk AS NUMERIC) * T02.alt_neu_kz) AS NUMERIC
        ),
        CAST(
            SUM(
                CAST(T01.diff_ek_netto_bnk_konz AS NUMERIC) * T02.alt_neu_kz
            ) AS NUMERIC
        ),
        CAST(
            SUM(
                CAST(T01.ek_netto_bnk_sachk AS NUMERIC) * T02.alt_neu_kz
            ) AS NUMERIC
        ),
        CAST(
            SUM(
                CAST(T01.diff_ek_netto_bnk_sachk_konz AS NUMERIC)
                * T02.alt_neu_kz
            ) AS NUMERIC
        )
    FROM dbp_data.artbew_2 AS T01
    INNER JOIN dbp_data.tag_2 AS T00 ON T01.dat = T00.dat
    INNER JOIN dbp_etl.artbew_wg_wechsel_join_2 AS T02
        ON
            T01.mandant_id = T02.mandant_id AND T01.art_id
            = T02.art_id AND T00.dat = T02.dat
    GROUP BY
        T01.mandant_id,
        T01.wup_id,
        T01.nb_id,
        T02.wg_id,
        T02.arthiertyp_id,
        T01.dat,
        T01.bewart_id,
        T01.posten_id
);


UPDATE dbp_data.artbew_wg_mo_sum_2 SET
    menge = artbew_wg_mo_sum.menge + X.menge,
    umsatz_netto = artbew_wg_mo_sum.umsatz_netto + X.umsatz_netto,
    diff_umsatz_netto_konz
    = artbew_wg_mo_sum.diff_umsatz_netto_konz + X.diff_umsatz_netto_konz,
    umsatz_mwst_betrag
    = artbew_wg_mo_sum.umsatz_mwst_betrag + X.umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz
    = artbew_wg_mo_sum.diff_umsatz_mwst_betrag_konz
    + X.diff_umsatz_mwst_betrag_konz,
    ek_brutto = artbew_wg_mo_sum.ek_brutto + X.ek_brutto,
    diff_ek_brutto_konz
    = artbew_wg_mo_sum.diff_ek_brutto_konz + X.diff_ek_brutto_konz,
    ek_netto = artbew_wg_mo_sum.ek_netto + X.ek_netto,
    diff_ek_netto_konz
    = artbew_wg_mo_sum.diff_ek_netto_konz + X.diff_ek_netto_konz,
    ek_nettonetto = artbew_wg_mo_sum.ek_nettonetto + X.ek_nettonetto,
    diff_ek_nettonetto_konz
    = artbew_wg_mo_sum.diff_ek_nettonetto_konz + X.diff_ek_nettonetto_konz,
    ek_kal_basis = artbew_wg_mo_sum.ek_kal_basis + X.ek_kal_basis,
    diff_ek_kal_basis_konz
    = artbew_wg_mo_sum.diff_ek_kal_basis_konz + X.diff_ek_kal_basis_konz,
    ek_mep = artbew_wg_mo_sum.ek_mep + X.ek_mep,
    diff_ek_mep_konz = artbew_wg_mo_sum.diff_ek_mep_konz + X.diff_ek_mep_konz,
    einstandspreis = artbew_wg_mo_sum.einstandspreis + X.einstandspreis,
    diff_einstandspreis_konz
    = artbew_wg_mo_sum.diff_einstandspreis_konz + X.diff_einstandspreis_konz,
    logkostenzuschlag
    = artbew_wg_mo_sum.logkostenzuschlag + X.logkostenzuschlag,
    diff_logkostenzuschlag_konz
    = artbew_wg_mo_sum.diff_logkostenzuschlag_konz
    + X.diff_logkostenzuschlag_konz,
    ek_netto_bnk = artbew_wg_mo_sum.ek_netto_bnk + X.ek_netto_bnk,
    diff_ek_netto_bnk_konz
    = artbew_wg_mo_sum.diff_ek_netto_bnk_konz + X.diff_ek_netto_bnk_konz,
    ek_netto_bnk_sachk
    = artbew_wg_mo_sum.ek_netto_bnk_sachk + X.ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz
    = artbew_wg_mo_sum.diff_ek_netto_bnk_sachk_konz
    + X.diff_ek_netto_bnk_sachk_konz
FROM (
    SELECT
        T01.wg_id,
        T01.wup_id,
        T01.nb_id,
        T02.kjmo,
        T01.mandant_id,
        T01.bewart_id,
        T01.arthiertyp_id,
        T01.posten_id,
        SUM(T01.menge) AS menge,
        SUM(T01.umsatz_netto) AS umsatz_netto,
        SUM(T01.diff_umsatz_netto_konz) AS diff_umsatz_netto_konz,
        SUM(T01.umsatz_mwst_betrag) AS umsatz_mwst_betrag,
        SUM(T01.diff_umsatz_mwst_betrag_konz) AS diff_umsatz_mwst_betrag_konz,
        SUM(T01.ek_brutto) AS ek_brutto,
        SUM(T01.diff_ek_brutto_konz) AS diff_ek_brutto_konz,
        SUM(T01.ek_netto) AS ek_netto,
        SUM(T01.diff_ek_netto_konz) AS diff_ek_netto_konz,
        SUM(T01.ek_nettonetto) AS ek_nettonetto,
        SUM(T01.diff_ek_nettonetto_konz) AS diff_ek_nettonetto_konz,
        SUM(T01.ek_kal_basis) AS ek_kal_basis,
        SUM(T01.diff_ek_kal_basis_konz) AS diff_ek_kal_basis_konz,
        SUM(T01.ek_mep) AS ek_mep,
        SUM(T01.diff_ek_mep_konz) AS diff_ek_mep_konz,
        SUM(T01.einstandspreis) AS einstandspreis,
        SUM(T01.diff_einstandspreis_konz) AS diff_einstandspreis_konz,
        SUM(T01.logkostenzuschlag) AS logkostenzuschlag,
        SUM(T01.diff_logkostenzuschlag_konz) AS diff_logkostenzuschlag_konz,
        SUM(T01.ek_netto_bnk) AS ek_netto_bnk,
        SUM(T01.diff_ek_netto_bnk_konz) AS diff_ek_netto_bnk_konz,
        SUM(T01.ek_netto_bnk_sachk) AS ek_netto_bnk_sachk,
        SUM(T01.diff_ek_netto_bnk_sachk_konz) AS diff_ek_netto_bnk_sachk_konz
    FROM dbp_etl.artbew_wg_sum_tmp_2 AS T01
    INNER JOIN dbp_data.tag_2 AS T02 ON T01.dat = T02.dat
    GROUP BY
        T01.mandant_id,
        T01.wup_id,
        T01.nb_id,
        T01.wg_id,
        T01.arthiertyp_id,
        T01.bewart_id,
        T01.posten_id,
        T02.kjmo
) AS X
WHERE
    artbew_wg_mo_sum.wg_id = X.wg_id
    AND artbew_wg_mo_sum.wup_id = X.wup_id
    AND artbew_wg_mo_sum.nb_id = X.nb_id
    AND artbew_wg_mo_sum.kjmo = X.kjmo AND artbew_wg_mo_sum.mandant_id = X.mandant_id AND artbew_wg_mo_sum.bewart_id = X.bewart_id
    AND artbew_wg_mo_sum.arthiertyp_id = X.arthiertyp_id AND artbew_wg_mo_sum.posten_id = X.posten_id;


INSERT INTO dbp_data.artbew_wg_mo_sum_2 (
    mandant_id, wup_id, nb_id, kjmo, bewart_id, posten_id, wg_id,
    arthiertyp_id,
    menge,
    umsatz_netto,
    diff_umsatz_netto_konz,
    umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz,
    ek_brutto,
    diff_ek_brutto_konz,
    ek_netto,
    diff_ek_netto_konz,
    ek_nettonetto,
    diff_ek_nettonetto_konz,
    ek_kal_basis,
    diff_ek_kal_basis_konz,
    ek_mep,
    diff_ek_mep_konz,
    einstandspreis,
    diff_einstandspreis_konz,
    logkostenzuschlag,
    diff_logkostenzuschlag_konz,
    ek_netto_bnk,
    diff_ek_netto_bnk_konz,
    ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz
)
(
    SELECT
        t01.mandant_id,
        t01.wup_id,
        t01.nb_id,
        t01.kjmo,
        t01.bewart_id,
        t01.posten_id,
        t01.wg_id,
        t01.arthiertyp_id,
        t01.menge,
        t01.umsatz_netto,
        t01.diff_umsatz_netto_konz,
        t01.umsatz_mwst_betrag,
        t01.diff_umsatz_mwst_betrag_konz,
        t01.ek_brutto,
        t01.diff_ek_brutto_konz,
        t01.ek_netto,
        t01.diff_ek_netto_konz,
        t01.ek_nettonetto,
        t01.diff_ek_nettonetto_konz,
        t01.ek_kal_basis,
        t01.diff_ek_kal_basis_konz,
        t01.ek_mep,
        t01.diff_ek_mep_konz,
        t01.einstandspreis,
        t01.diff_einstandspreis_konz,
        t01.logkostenzuschlag,
        t01.diff_logkostenzuschlag_konz,
        t01.ek_netto_bnk,
        t01.diff_ek_netto_bnk_konz,
        t01.ek_netto_bnk_sachk,
        t01.diff_ek_netto_bnk_sachk_konz
    FROM (
        SELECT
            T1.wg_id,
            T1.wup_id,
            T1.nb_id,
            T2.kjmo,
            T1.mandant_id,
            T1.bewart_id,
            T1.arthiertyp_id,
            T1.posten_id,
            SUM(T1.menge) AS menge,
            SUM(T1.umsatz_netto) AS umsatz_netto,
            SUM(T1.diff_umsatz_netto_konz) AS diff_umsatz_netto_konz,
            SUM(T1.umsatz_mwst_betrag) AS umsatz_mwst_betrag,
            SUM(T1.diff_umsatz_mwst_betrag_konz)
                AS diff_umsatz_mwst_betrag_konz,
            SUM(T1.ek_brutto) AS ek_brutto,
            SUM(T1.diff_ek_brutto_konz) AS diff_ek_brutto_konz,
            SUM(T1.ek_netto) AS ek_netto,
            SUM(T1.diff_ek_netto_konz) AS diff_ek_netto_konz,
            SUM(T1.ek_nettonetto) AS ek_nettonetto,
            SUM(T1.diff_ek_nettonetto_konz) AS diff_ek_nettonetto_konz,
            SUM(T1.ek_kal_basis) AS ek_kal_basis,
            SUM(T1.diff_ek_kal_basis_konz) AS diff_ek_kal_basis_konz,
            SUM(T1.ek_mep) AS ek_mep,
            SUM(T1.diff_ek_mep_konz) AS diff_ek_mep_konz,
            SUM(T1.einstandspreis) AS einstandspreis,
            SUM(T1.diff_einstandspreis_konz) AS diff_einstandspreis_konz,
            SUM(T1.logkostenzuschlag) AS logkostenzuschlag,
            SUM(T1.diff_logkostenzuschlag_konz) AS diff_logkostenzuschlag_konz,
            SUM(T1.ek_netto_bnk) AS ek_netto_bnk,
            SUM(T1.diff_ek_netto_bnk_konz) AS diff_ek_netto_bnk_konz,
            SUM(T1.ek_netto_bnk_sachk) AS ek_netto_bnk_sachk,
            SUM(T1.diff_ek_netto_bnk_sachk_konz) AS diff_ek_netto_bnk_sachk_konz
        FROM dbp_etl.artbew_wg_sum_tmp_2 AS T1_2
        INNER JOIN dbp_data.tag_2 AS T2 ON T1.dat = T2.dat
        GROUP BY
            T1.mandant_id,
            T1.wup_id,
            T1.nb_id,
            T1.wg_id,
            T1.arthiertyp_id,
            T1.bewart_id,
            T1.posten_id,
            T2.kjmo
    ) AS t01
    LEFT JOIN dbp_data.artbew_wg_mo_sum_2 AS T02
        ON
            t01.arthiertyp_id = T02.arthiertyp_id AND t01.bewart_id
            = T02.bewart_id AND t01.posten_id = T02.posten_id AND t01.wg_id = T02.wg_id AND t01.wup_id = T02.wup_id AND t01
            .mandant_id = T02.mandant_id
            AND t01.nb_id = T02.nb_id
            AND t01.kjmo = T02.kjmo
    WHERE T02.mandant_id IS NULL
);


UPDATE dbp_data.artbew_wg_tp2_sum_2 SET
    menge = artbew_wg_tp2_sum.menge + X.menge,
    menge_ohne_wg_erf_art
    = artbew_wg_tp2_sum.menge_ohne_wg_erf_art + X.menge_ohne_wg_erf_art,
    umsatz_netto = artbew_wg_tp2_sum.umsatz_netto + X.umsatz_netto,
    diff_umsatz_netto_konz
    = artbew_wg_tp2_sum.diff_umsatz_netto_konz + X.diff_umsatz_netto_konz,
    umsatz_mwst_betrag
    = artbew_wg_tp2_sum.umsatz_mwst_betrag + X.umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz
    = artbew_wg_tp2_sum.diff_umsatz_mwst_betrag_konz
    + X.diff_umsatz_mwst_betrag_konz,
    ek_brutto = artbew_wg_tp2_sum.ek_brutto + X.ek_brutto,
    diff_ek_brutto_konz
    = artbew_wg_tp2_sum.diff_ek_brutto_konz + X.diff_ek_brutto_konz,
    ek_netto = artbew_wg_tp2_sum.ek_netto + X.ek_netto,
    diff_ek_netto_konz
    = artbew_wg_tp2_sum.diff_ek_netto_konz + X.diff_ek_netto_konz,
    ek_nettonetto = artbew_wg_tp2_sum.ek_nettonetto + X.ek_nettonetto,
    diff_ek_nettonetto_konz
    = artbew_wg_tp2_sum.diff_ek_nettonetto_konz + X.diff_ek_nettonetto_konz,
    ek_kal_basis = artbew_wg_tp2_sum.ek_kal_basis + X.ek_kal_basis,
    diff_ek_kal_basis_konz
    = artbew_wg_tp2_sum.diff_ek_kal_basis_konz + X.diff_ek_kal_basis_konz,
    ek_mep = artbew_wg_tp2_sum.ek_mep + X.ek_mep,
    diff_ek_mep_konz = artbew_wg_tp2_sum.diff_ek_mep_konz + X.diff_ek_mep_konz,
    einstandspreis = artbew_wg_tp2_sum.einstandspreis + X.einstandspreis,
    diff_einstandspreis_konz
    = artbew_wg_tp2_sum.diff_einstandspreis_konz + X.diff_einstandspreis_konz,
    logkostenzuschlag
    = artbew_wg_tp2_sum.logkostenzuschlag + X.logkostenzuschlag,
    diff_logkostenzuschlag_konz
    = artbew_wg_tp2_sum.diff_logkostenzuschlag_konz
    + X.diff_logkostenzuschlag_konz,
    ek_netto_bnk = artbew_wg_tp2_sum.ek_netto_bnk + X.ek_netto_bnk,
    diff_ek_netto_bnk_konz
    = artbew_wg_tp2_sum.diff_ek_netto_bnk_konz + X.diff_ek_netto_bnk_konz,
    ek_netto_bnk_sachk
    = artbew_wg_tp2_sum.ek_netto_bnk_sachk + X.ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz
    = artbew_wg_tp2_sum.diff_ek_netto_bnk_sachk_konz
    + X.diff_ek_netto_bnk_sachk_konz
FROM
    dbp_etl.artbew_wg_sum_tmp_2 AS X
WHERE
    artbew_wg_tp2_sum.mandant_id = X.mandant_id
    AND artbew_wg_tp2_sum.wup_id = X.wup_id
    AND artbew_wg_tp2_sum.nb_id
    = X.nb_id AND artbew_wg_tp2_sum.wg_id = X.wg_id AND artbew_wg_tp2_sum.arthiertyp_id = X.arthiertyp_id
    AND artbew_wg_tp2_sum.dat = X.dat AND artbew_wg_tp2_sum.bewart_id = X.bewart_id AND artbew_wg_tp2_sum.posten_id
    = COLLATE(X.posten_id, 'und:ci') AND artbew_wg_tp2_sum.arthiertyp_id = 2;


INSERT INTO dbp_data.artbew_wg_tp2_sum_2 (
    mandant_id, wup_id, nb_id, dat, bewart_id, posten_id, wg_id,
    arthiertyp_id,
    menge,
    menge_ohne_wg_erf_art,
    umsatz_netto,
    diff_umsatz_netto_konz,
    umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz,
    ek_brutto,
    diff_ek_brutto_konz,
    ek_netto,
    diff_ek_netto_konz,
    ek_nettonetto,
    diff_ek_nettonetto_konz,
    ek_kal_basis,
    diff_ek_kal_basis_konz,
    ek_mep,
    diff_ek_mep_konz,
    einstandspreis,
    diff_einstandspreis_konz,
    logkostenzuschlag,
    diff_logkostenzuschlag_konz,
    ek_netto_bnk,
    diff_ek_netto_bnk_konz,
    ek_netto_bnk_sachk, diff_ek_netto_bnk_sachk_konz
)
(
    SELECT
        T01.mandant_id,
        T01.wup_id,
        T01.nb_id,
        T01.dat,
        T01.bewart_id,
        T01.posten_id,
        T01.wg_id,
        T01.arthiertyp_id,
        T01.menge,
        T01.menge_ohne_wg_erf_art,
        T01.umsatz_netto,
        T01.diff_umsatz_netto_konz,
        T01.umsatz_mwst_betrag,
        T01.diff_umsatz_mwst_betrag_konz,
        T01.ek_brutto,
        T01.diff_ek_brutto_konz,
        T01.ek_netto,
        T01.diff_ek_netto_konz,
        T01.ek_nettonetto,
        T01.diff_ek_nettonetto_konz,
        T01.ek_kal_basis,
        T01.diff_ek_kal_basis_konz,
        T01.ek_mep,
        T01.diff_ek_mep_konz,
        T01.einstandspreis,
        T01.diff_einstandspreis_konz,
        T01.logkostenzuschlag,
        T01.diff_logkostenzuschlag_konz,
        T01.ek_netto_bnk,
        T01.diff_ek_netto_bnk_konz,
        T01.ek_netto_bnk_sachk,
        T01.diff_ek_netto_bnk_sachk_konz
    FROM dbp_etl.artbew_wg_sum_tmp_2 AS T01
    LEFT JOIN dbp_data.artbew_wg_tp2_sum_2 AS T02
        ON
            T01.mandant_id = T02.mandant_id AND T01.wup_id = T02.wup_id
            AND T01.nb_id = T02.nb_id
            AND T01.wg_id = T02.wg_id
            AND T01.arthiertyp_id = T02.arthiertyp_id
            AND T01.dat
            = T02.dat AND T01.bewart_id = T02.bewart_id AND COLLATE(T01.posten_id, 'und:ci') = T02.posten_id
    WHERE
        T02.mandant_id IS NULL
        AND T01.arthiertyp_id = 2
);


DROP TABLE IF EXISTS dbp_etl.wpuums_build_tmp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.wpuums_build_tmp_2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    nb_id INTEGER NOT NULL,
    arthiertyp_id INTEGER,
    umsatz_brutto NUMERIC(29, 4),
    umsatz_netto NUMERIC(29, 4),
    umsatz_wrg STRING(3) COLLATE 'und:ci',
    umsatz_brutto_konz NUMERIC(29, 4),
    umsatz_netto_konz NUMERIC(29, 4),
    umsatz_mwst_betrag NUMERIC(29, 4),
    kjmo INTEGER,
    menge NUMERIC(29, 3) DEFAULT 0.000,
    quelle INTEGER DEFAULT 0
);


DROP TABLE IF EXISTS dbp_etl.wpuums_build_tmp2_2;


CREATE TABLE IF NOT EXISTS dbp_etl.wpuums_build_tmp2_2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    nb_id INTEGER NOT NULL,
    arthiertyp_id INTEGER,
    umsatz_brutto NUMERIC(29, 4),
    umsatz_netto NUMERIC(29, 4),
    umsatz_wrg STRING(3) COLLATE 'und:ci',
    umsatz_brutto_konz NUMERIC(29, 4),
    umsatz_netto_konz NUMERIC(29, 4),
    umsatz_mwst_betrag NUMERIC(29, 4),
    kjmo INTEGER,
    menge NUMERIC(29, 3) DEFAULT 0.000,
    quelle INTEGER DEFAULT 0
);
