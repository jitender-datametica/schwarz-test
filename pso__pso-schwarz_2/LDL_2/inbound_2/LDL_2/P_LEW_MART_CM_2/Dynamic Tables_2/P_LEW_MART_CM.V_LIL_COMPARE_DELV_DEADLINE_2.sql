
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_COMPARE_DELV_DEADLINE_2
(
client_id
, per_id
, interface_name
, per_end_date
, status_2
, delivery_content
, delivery_content_smart_desc
, delivery_content_smart_desc_EN
, min_delivery_date
, max_delivery_date
, delivery_count
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
(
SELECT
region.region_id AS client_id
, permstr.period_id AS per_id
, reg.interface_name AS interface_name
, per.end_dt AS per_end_date
, reg.status_2 AS status_2
, con.src_assort_parent_cat_cd AS delivery_content
,COALESCE(CASE con.src_assort_parent_cat_cd WHEN '00' THEN nade.trans_text END, TRIM(acatm.assort_parnt_cat_name_de), con.src_assort_parent_cat_cd) AS delivery_content_smart_desc
,COALESCE(CASE con.src_assort_parent_cat_cd WHEN '00' THEN naen.trans_text END, TRIM(acatm.assort_parnt_cat_name_en), con.src_assort_parent_cat_cd) AS delivery_content_smart_desc_EN
, CAST(MIN(reg.processing_ts) AS DATE) AS min_delivery_date
, CAST(MAX(reg.processing_ts) AS DATE) AS max_delivery_date
, COUNT(DISTINCT con.file_id) AS delivery_count
FROM (
SELECT
    c.file_id
  , c.region_sid
  , c.client_id
  , p.period_lvl
  , c.src_assort_parent_cat_cd
  , MAX(p.period_id) AS period_id
FROM P_LEW_PROCESS_MSTR_AC.v_lil_file_content_2 AS c
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period_2 AS p
    ON p.period_sid = c.period_sid
GROUP BY c.file_id, c.region_sid, p.period_lvl,c.client_id,c.src_assort_parent_cat_cd
) AS con
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_registry_files_2 AS reg
    ON reg.file_id = con.file_id
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_2 AS region_2
    ON region.region_sid = con.region_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period_2 AS permstr
    ON permstr.period_id = con.period_id
    AND permstr.client_id = con.client_id
INNER JOIN P_LEW_CORE_AC.v_lil_period_per_region_2 AS per
    ON per.period_sid = permstr.period_sid
LEFT OUTER JOIN (
  SELECT client_id, src_assort_parent_cat_cd, MIN(assort_cat_sid) AS assort_cat_sid
  FROM P_LEW_CORE_AC.v_lil_assort_category_2
  WHERE assort_cat_level = 1
  GROUP BY 1,2
 ) AS acatc
   ON acatc.client_id = region.client_id
  AND acatc.src_assort_parent_cat_cd = con.src_assort_parent_cat_cd
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_assort_region_cat_2 AS acatm
   ON acatm.client_id = acatc.client_id
  AND acatm.region_sid = region.region_sid
  AND acatm.assort_cat_sid = acatc.assort_cat_sid
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS naen
  ON naen.context = 'DELCONT'
  AND naen.trans_id = 1
  AND naen.lang_cd = 'EN'
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS nade
  ON nade.context = 'DELCONT'
  AND nade.trans_id = 1
  AND nade.lang_cd = 'DE'  
GROUP BY
1,2,3,4,5,6,7,8
);
