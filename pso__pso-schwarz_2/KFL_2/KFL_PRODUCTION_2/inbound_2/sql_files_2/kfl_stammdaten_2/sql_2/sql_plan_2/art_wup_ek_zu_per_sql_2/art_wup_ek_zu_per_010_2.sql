--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per_2
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
--  FROM ${DWH_COMMON_DBX_DATA}.art_wup_ek_zu_per_2
--  GROUP BY 1, 2, 3, 4
--) a
--WHERE min_dat_von > CAST(101 AS DATE)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement
INSERT INTO DBP_DATA.art_wup_ek_zu_per_2
(
   art_id
  ,mandant_Id
  ,wup_id
  ,nb_id
  ,dat_von
  ,dat_bis
  ,ek_netto
  ,ek_netto_bnk
  ,ek_mep
  ,einstandspreis
  ,ek_nettonetto
  ,komponentenmenge
  ,wrg_id
  ,kein_zekp_fg
)
SELECT
   art_id
  ,mandant_id
  ,wup_id
  ,nb_id
  ,to_date('1900-01-01','YYYY-MM_2-DD') AS dat_von
  ,min_dat_von - 1 AS dat_bis
  ,  (0.00  ) AS ek_netto
  ,  (0.00  ) AS ek_netto_bnk
  ,  (0.00  ) AS ek_mep
  ,  (0.00  ) AS einstandspreis
  ,  (0.00  ) AS ek_nettonetto
  ,1.0000 AS komponentenmenge
  ,'EUR' AS wrg_id
  ,0 AS kein_zekp_fg
FROM
(
  SELECT
     art_id
    ,mandant_id
    ,wup_id
    ,nb_id
    ,MIN(dat_von) AS min_dat_von
  FROM DBP_DATA.art_wup_ek_zu_per_2
  GROUP BY 1, 2, 3, 4
) a
WHERE min_dat_von > to_date('1900-01-01','YYYY-MM_2-DD')
;

