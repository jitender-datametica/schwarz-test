
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_CLIENT
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
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM

AS
SELECT
    CAST(rm.region_id AS SMALLINT) AS client_id
  , LEFT(rm.src_region_cd,3) AS country_iso_cd
  
  , CAST(COALESCE(dsde.region_name, rm.region_name_de, rm.region_name_en) AS VARCHAR(128)) AS client_desc
  , CAST(COALESCE(dsen.region_name, rm.region_name_en) AS VARCHAR(128)) AS client_desc_EN
    
  , CAST(rm.region_short_desc AS VARCHAR(128)) AS client_short_desc
  , CAST(COALESCE(dsde.region_long_descr,rm.region_long_desc) AS VARCHAR(128)) AS client_long_desc
  , CAST(COALESCE(dsen.region_long_descr,rm.region_long_desc) AS VARCHAR(128)) AS client_long_desc_EN
  , CAST(rm.region_srt_cd AS SMALLINT) AS client_srt_cd
  , CAST(rm.qr_srt_cd AS SMALLINT) AS qr_srt_cd
  , CASE WHEN CAST(rm.region_id AS SMALLINT) = 7 THEN 0 ELSE CAST(rm.region_srt_cd AS SMALLINT) END AS cc_srt_cd
  , CAST(rm.region_lvl AS SMALLINT) AS client_lvl
  , CAST(cl.curr_cd AS CHAR(3)) AS currency_iso_cd
  , CAST(REPLACE(rm.sd_chld_below_12, blde.src_trans_cd, blde.trans_text) AS VARCHAR(128)) AS sd_chld_below_12
  , CAST(rm.sd_chld_below_12 AS VARCHAR(128)) AS sd_chld_below_12_EN  
  , CAST(REPLACE(rm.sd_chld_over_12, ovde.src_trans_cd, ovde.trans_text) AS VARCHAR(128)) AS sd_chld_over_12
  , CAST(rm.sd_chld_over_12 AS VARCHAR(128)) AS sd_chld_over_12_EN  
FROM P_LEW_PROCESS_MSTR_AC.v_lil_region AS rm
INNER JOIN P_LEW_CORE_AC.v_lil_region AS rc
   ON rm.region_sid = rc.region_sid
INNER JOIN P_LEW_CORE_AC.v_client AS cl
   ON cl.client_id = rc.client_id
   AND cl.country_sid = rc.country_sid
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_region_descr AS dsde
   ON dsde.client_id = rc.client_id
  AND dsde.region_sid = rc.region_sid
  AND dsde.lang_cd = 'DE'
LEFT OUTER JOIN P_LEW_CORE_AC.v_lil_region_descr AS dsen
   ON dsen.client_id = rc.client_id
  AND dsen.region_sid = rc.region_sid
  AND dsen.lang_cd = 'EN'
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS blde
  ON blde.context = 'SD_CHLD'
 AND rm.sd_chld_below_12 LIKE blde.src_trans_cd||'%'
 AND blde.lang_cd = 'DE'
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS ovde
  ON ovde.context = 'SD_CHLD'
 AND rm.sd_chld_over_12 LIKE ovde.src_trans_cd||'%'
 AND ovde.lang_cd = 'DE'
WHERE rm.region_lvl IN (3,6,9);
