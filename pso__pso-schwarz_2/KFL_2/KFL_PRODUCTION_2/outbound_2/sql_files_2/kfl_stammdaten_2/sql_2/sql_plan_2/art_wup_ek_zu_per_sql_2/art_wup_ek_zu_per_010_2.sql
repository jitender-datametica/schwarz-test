--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO KFL_PRODUCTION.${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per_2
--(
--   art_id
--  ,mandant_Id
--  ,wup_id
--  ,nb_id
--  ,dat_von
--  ,dat_bis
--  ,ek_netto
--  ,ek_netto_bnk
--  ,ek_mep
--  ,einstandspreis
--  ,ek_nettonetto
--  ,komponentenmenge
--  ,wrg_id
--  ,kein_zekp_fg
--)
--SELECT
--   art_id
--  ,mandant_id
--  ,wup_id
--  ,nb_id
--  ,CAST(101 AS DATE) AS dat_von
--  ,min_dat_von - 1 AS dat_bis
--  , ${DWH_COMMON_PTY_ENC} (0.00 ${DWH_COMMON_PTY_KEY_ENC} ) AS ek_netto
--  , ${DWH_COMMON_PTY_ENC} (0.00 ${DWH_COMMON_PTY_KEY_ENC} ) AS ek_netto_bnk
--  , ${DWH_COMMON_PTY_ENC} (0.00 ${DWH_COMMON_PTY_KEY_ENC} ) AS ek_mep
--  , ${DWH_COMMON_PTY_ENC} (0.00 ${DWH_COMMON_PTY_KEY_ENC} ) AS einstandspreis
--  , ${DWH_COMMON_PTY_ENC} (0.00 ${DWH_COMMON_PTY_KEY_ENC} ) AS ek_nettonetto
--  ,1.0000 AS komponentenmenge
--  ,'EUR' AS wrg_id
--  ,0 AS kein_zekp_fg
--FROM
--(
--  SELECT
--     art_id
--    ,mandant_id
--    ,wup_id
--    ,nb_id
--    ,MIN(dat_von) AS min_dat_von
--  FROM KFL_PRODUCTION.${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per_2
--  GROUP BY 1, 2, 3, 4
--) a
--WHERE min_dat_von > CAST(101 AS DATE)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


INSERT INTO dbp_data.art_wup_ek_zu_per_2 (
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
FROM (SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    MIN(dat_von) AS min_dat_von
FROM dbp_data.art_wup_ek_zu_per_2
GROUP BY
    art_id,
    mandant_id,
    wup_id,
    nb_id
HAVING min_dat_von > PARSE_DATE('%F', '1900-01-01')) AS t0);
