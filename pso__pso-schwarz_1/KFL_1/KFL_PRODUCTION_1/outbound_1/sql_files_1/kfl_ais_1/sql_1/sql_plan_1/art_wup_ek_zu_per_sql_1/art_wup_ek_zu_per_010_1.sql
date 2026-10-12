--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.art_wup_ek_zu_per_1 (
    art_id, mandant_id, wup_id, nb_id, dat_von, dat_bis, ek_netto,
    ek_netto_bnk,
    ek_mep,
    einstandspreis,
    komponentenmenge,
    wrg_id,
    ek_nettonetto,
    kein_zekp_fg
)
(SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    PARSE_DATE('%F', '1900-01-01') AS dat_von,
    DATE_SUB(min_dat_von, INTERVAL 1 DAY) AS dat_bis,
    CAST(0.00 AS NUMERIC) AS ek_netto,
    CAST(0.00 AS NUMERIC) AS ek_netto_bnk,
    CAST(0.00 AS NUMERIC) AS ek_mep,
    CAST(0.00 AS NUMERIC) AS einstandspreis,
    CAST(1.0000 AS NUMERIC) AS komponentenmenge,
    'EUR' AS wrg_id,
    CAST(0.00 AS NUMERIC) AS ek_nettonetto,
    0 AS kein_zekp_fg
FROM (
    SELECT
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        MIN(dat_von) AS min_dat_von
    FROM dbp_data.art_wup_ek_zu_per_1
    GROUP BY
        art_id,
        mandant_id,
        wup_id,
        nb_id
) AS a
WHERE min_dat_von > PARSE_DATE('%F', '1900-01-01'));
