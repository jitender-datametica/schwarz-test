CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_REGION_SPLIT_1
(
    country_iso_cd
  , region_split_id
  , region_split_desc
  , region_split_desc_EN
  , region_split_desc_with_country_iso_cd
  , region_split_desc_with_country_iso_cd_EN
  , region_lvl
)
AS
SELECT
    country_iso_cd
  , region_split_id
  , region_split_desc
  , region_split_desc_EN
  , region_split_desc_with_country_iso_cd
  , region_split_desc_with_country_iso_cd_EN
  , region_lvl
FROM P_LEW_MART_CM.V_LIL_REGION_SPLIT_1;
