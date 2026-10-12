
CREATE TABLE IF NOT EXISTS  ldl_p_lew_mart_cm.v_lil_region_split_2
 AS
SELECT CL.country_iso_cd,
 CAST(RG.region_id AS BIGNUMERIC) AS client_id,
 CAST(COALESCE(DSDE.region_name, RG.region_name_de, RG.region_name_en) AS STRING) AS region_split_desc,
 CAST(COALESCE(DSEN.region_name, RG.region_name_en) AS STRING) AS region_split_desc_en,
  CASE
  WHEN RG.region_lvl IN (6, 10)
  THEN CL.country_iso_cd
  ELSE CAST(COALESCE(DSDE.region_name, RG.region_name_de, RG.region_name_en) AS STRING)
  END AS region_split_desc_with_country_iso_cd,
  CASE
  WHEN RG.region_lvl IN (6, 10)
  THEN CL.country_iso_cd
  ELSE CAST(COALESCE(DSEN.region_name, RG.region_name_en) AS STRING)
  END AS region_split_desc_with_country_iso_cd_en,
 RG.region_lvl
FROM ldl_p_lew_process_mstr_ac.v_lil_region_2 AS RG
 INNER JOIN ldl_p_lew_mart_cm.v_lil_client_2 AS CL ON RG.client_id = CL.client_id
 LEFT JOIN ldl_p_lew_core_ac.v_lil_region_descr_2 AS DSDE ON RG.client_id = DSDE.client_id AND RG.region_sid = DSDE.region_sid
     AND DSDE.lang_cd = 'DE'
 LEFT JOIN ldl_p_lew_core_ac.v_lil_region_descr_2 AS DSEN ON RG.client_id = DSEN.client_id AND RG.region_sid = DSEN.region_sid
     AND DSEN.lang_cd = 'EN'
WHERE RG.region_lvl IN (6, 9, 10, 11);
