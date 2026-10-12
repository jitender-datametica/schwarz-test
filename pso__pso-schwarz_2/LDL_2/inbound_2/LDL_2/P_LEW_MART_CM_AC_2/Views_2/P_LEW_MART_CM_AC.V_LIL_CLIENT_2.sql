CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_CLIENT_2
(
    client_id
  , country_iso_cd
  , client_desc
  , client_desc_EN
  , client_short_desc
  , client_long_desc
  , client_long_desc_EN
  , client_srt_cd
  , qr_srt_cd
  , cc_srt_cd
  , client_lvl
  , currency_iso_cd
  , sd_chld_below_12
  , sd_chld_below_12_EN
  , sd_chld_over_12
  , sd_chld_over_12_EN
) AS
SELECT
    client_id
  , country_iso_cd
  , client_desc
  , client_desc_EN
  , client_short_desc
  , client_long_desc
  , client_long_desc_EN
  , client_srt_cd
  , qr_srt_cd
  , cc_srt_cd
  , client_lvl
  , currency_iso_cd
  , sd_chld_below_12
  , sd_chld_below_12_EN
  , sd_chld_over_12
  , sd_chld_over_12_EN
FROM P_LEW_MART_CM.V_LIL_CLIENT_2;
