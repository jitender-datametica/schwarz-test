DELETE FROM dbp_data.wupcal_2
WHERE (
    wup_id, mandant_id, nb_id, dat) IN (
    SELECT (WC.wup_id, WC.mandant_id, WC.nb_id, WC.dat)
    FROM dbp_data.wupcal_2 AS WC
    INNER JOIN dbp_data.wup_2 AS W
        ON
            WC.wup_id = W.wup_id
            AND WC.mandant_id = W.mandant_id
            AND WC.nb_id = W
            .nb_id
    WHERE
        WC.dat < W.dat_von
        OR WC.dat > COALESCE(W.dat_bis, PARSE_DATE('%F', '9999-12-31'))
);


/* unbekannt */ /* unbekannt */ /* 0 = nein, es sind keine Tagesdaten da. */ /* unbekannt */ /* Nein */ /* unbekannt */
/* unbekannt */ INSERT INTO dbp_data.wupcal_2 (
    mandant_id, wup_id, nb_id, dat, offen, werbewoche,
    datenlieferung_artbew_wg_sum,
    datenlieferung_bonanzahl,
    datenlieferung_misvier,
    datenlieferung_artbew,
    datenlieferung_qbm_status,
    bonanzahl,
    bonanzahl_misvier,
    td_update,
    td_insert
)
(
    SELECT
        W.mandant_id,
        W.wup_id,
        W.nb_id,
        T.dat,
        1 AS offen,
        0 AS werbewoche, /* Nein */
        0 AS datenlieferung_artbew_wg_sum, /* unbekannt */
        0 AS datenlieferung_bonanzahl,
        /* 0 = nein, es sind keine Tagesdaten da. */
        0 AS datenlieferung_misvier, /* unbekannt */
        0 AS datenlieferung_artbew,
        0 AS datenlieferung_qbm_status, /* unbekannt */
        0 AS bonanzahl, /* unbekannt */
        0 AS bonanzahl_misvier, /* unbekannt */
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_data.wup_2 AS W
    INNER JOIN dbp_data.tag_2 AS T ON TRUE
    WHERE
        W.dat_von <= T.dat
        AND CASE
            WHEN W.dat_bis = PARSE_DATE('%F', '9999-12-31')
                THEN CURRENT_DATE("Europe/Berlin")
            ELSE W.dat_bis
        END >= T.dat
        AND T.dat >= PARSE_DATE('%F', '1998-01-01')
        AND T.dat <= CURRENT_DATE("Europe/Berlin")
        AND (
            W.mandant_id, W.wup_id, W.nb_id, T.dat) NOT IN (
            SELECT (mandant_id, wup_id, nb_id, dat)
            FROM dbp_data.wupcal_2
        )
);
