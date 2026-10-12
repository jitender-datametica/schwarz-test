
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_REGION_SPLIT
(
    country_iso_cd
  , region_split_id
  , region_split_desc
  , region_split_desc_EN
  , region_split_desc_with_country_iso_cd
  , region_split_desc_with_country_iso_cd_EN
  , region_lvl
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
    cl.country_iso_cd
  , CAST(rg.region_id AS SMALLINT) AS client_id
  , CAST(COALESCE(dsde.region_name, rg.region_name_de, rg.region_name_en) AS VARCHAR(128)) AS region_split_desc
  , CAST(COALESCE(dsen.region_name, rg.region_name_en) AS VARCHAR(128)) AS region_split_desc_EN
  , CASE WHEN (rg.region_lvl = 10 OR rg.region_lvl = 6) THEN cl.country_iso_cd ELSE CAST(COALESCE(dsde.region_name, rg.region_name_de, rg.region_name_en) AS VARCHAR(128)) END AS region_split_desc_with_country_iso_cd
  , CASE WHEN (rg.region_lvl = 10 OR rg.region_lvl = 6) THEN cl.country_iso_cd ELSE CAST(COALESCE(dsen.region_name, rg.region_name_en) AS VARCHAR(128)) END AS region_split_desc_with_country_iso_cd_EN
  , rg.region_lvl
FROM P_LEW_PROCESS_MSTR_AC.v_lil_region AS rg
INNER JOIN P_LEW_MART_CM.v_lil_client AS cl
    ON cl.client_id = rg.client_id
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_region_descr AS dsde
   ON dsde.client_id = rg.client_id
  AND dsde.region_sid = rg.region_sid
  AND dsde.lang_cd = 'DE'
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_region_descr AS dsen
   ON dsen.client_id = rg.client_id
  AND dsen.region_sid = rg.region_sid
  AND dsen.lang_cd = 'EN'
WHERE rg.region_lvl IN (6,9,10,11);
