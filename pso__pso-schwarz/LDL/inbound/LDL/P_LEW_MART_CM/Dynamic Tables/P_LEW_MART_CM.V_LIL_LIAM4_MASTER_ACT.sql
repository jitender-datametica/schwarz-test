
CREATE OR REPLACE DYNAMIC TABLE p_lew_mart_cm.V_LIL_LIAM4_MASTER_ACT
 /* 
 #DescStart# 
 #$Revision: 12255 $, $LastChangedBy: gkunz $ 
 #SubjectAreas#:
 #DescEnd# 
 */
(
   client_id
 , per_id
 , liam_parnt_clnt_cat_id
 , liam_clnt_cat_id
 , pos_nr
 , manufacturer
 , brand
 , prod_nm
 , pack_sz
 , ean
 , family
 , feature1
 , feature2
 , feature3
 , feature4
 , feature5
 , feature6
 , feature7
 , feature8
 , feature9
 , feature10
 , feature11
 , feature12
 , feature13
 , feature14
 , acc_rel_penetr_pct
 , prot_fg
) 
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
  CAST(reg.region_id AS SMALLINT) AS client_id
  ,per.period_id
  ,CAST(Substr(asmp.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)) AS liam_parnt_clnt_cat_id
  ,CAST(asmp.assort_region_cat_id AS CHAR(27)) AS liam_clnt_cat_id
  ,CAST(pos.rank_pos AS SMALLINT) AS pos_nr
  ,CAST(pos.manufacturer AS VARCHAR(512))
  ,CAST(pos.brand AS VARCHAR(512))
  ,CAST(pos.product_name AS VARCHAR(512))
  ,CAST(pos.pack_size AS VARCHAR(512))
  ,CAST(pos.ean AS VARCHAR(10000))
  ,CAST(pos.category_family AS VARCHAR(512))
  ,CAST(pos.feature1_content AS VARCHAR(2400)) AS feature1
  ,CAST(pos.feature2_content AS VARCHAR(2400)) AS feature2
  ,CAST(pos.feature3_content AS VARCHAR(2400)) AS feature3
  ,CAST(pos.feature4_content AS VARCHAR(2400)) AS feature4
  ,CAST(pos.feature5_content AS VARCHAR(2400)) AS feature5
  ,CAST(pos.feature6_content AS VARCHAR(2400)) AS feature6
  ,CAST(pos.feature7_content AS VARCHAR(2400)) AS feature7
  ,CAST(pos.feature8_content AS VARCHAR(2400)) AS feature8
  ,CAST(pos.feature9_content AS VARCHAR(2400)) AS feature9
  ,CAST(pos.feature10_content AS VARCHAR(2400)) AS feature10
  ,CAST(pos.feature11_content AS VARCHAR(2400)) AS feature11
  ,CAST(pos.feature12_content AS VARCHAR(2400)) AS feature12
  ,CAST(pos.feature13_content AS VARCHAR(2400)) AS feature13
  ,CAST(pos.feature14_content AS VARCHAR(2400)) AS feature14
  ,CAST(pos.penetrate_cum_rel_pct AS DECIMAL(23,5))
  ,CAST(1 AS BYTEINT) AS prot_fg
FROM p_lew_core_ac.v_market_article_feature_pos AS pos
INNER JOIN p_lew_process_mstr_ac.v_lil_region AS reg
ON reg.region_sid = pos.region_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_period AS per
ON per.client_id = pos.client_id
AND per.period_sid = pos.period_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_assort_region_cat AS asmp
ON asmp.client_id = pos.client_id 
AND asmp.region_sid = pos.region_sid
AND asmp.assort_cat_sid = pos.assort_cat_sid
UNION ALL
SELECT
CAST(reg.region_id AS SMALLINT) AS client_id
  ,per.period_id
  ,CAST(Substr(asmp.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)) AS liam_parnt_clnt_cat_id
  ,CAST(asmp.assort_region_cat_id AS CHAR(27)) AS liam_clnt_cat_id
  ,0 AS pos_nr
  ,CAST(NULL AS VARCHAR(512)) AS manufacturer
  ,CAST(NULL AS VARCHAR(512)) AS brand
  ,CAST(NULL AS VARCHAR(512)) AS product_name
  ,CAST(NULL AS VARCHAR(512)) AS pack_size
  ,CAST(NULL AS VARCHAR(512)) AS ean
  ,CAST(NULL AS VARCHAR(512)) AS category_family
  ,CAST(feat.feature1_name AS VARCHAR(2400)) AS feature1
  ,CAST(feat.feature2_name AS VARCHAR(2400)) AS feature2
  ,CAST(feat.feature3_name AS VARCHAR(2400)) AS feature3
  ,CAST(feat.feature4_name AS VARCHAR(2400)) AS feature4
  ,CAST(feat.feature5_name AS VARCHAR(2400)) AS feature5
  ,CAST(feat.feature6_name AS VARCHAR(2400)) AS feature6
  ,CAST(feat.feature7_name AS VARCHAR(2400)) AS feature7
  ,CAST(feat.feature8_name AS VARCHAR(2400)) AS feature8
  ,CAST(feat.feature9_name AS VARCHAR(2400)) AS feature9
  ,CAST(feat.feature10_name AS VARCHAR(2400)) AS feature10
  ,CAST(feat.feature11_name AS VARCHAR(2400)) AS feature11
  ,CAST(feat.feature12_name AS VARCHAR(2400)) AS feature12
  ,CAST(feat.feature13_name AS VARCHAR(2400)) AS feature13
  ,CAST(feat.feature14_name AS VARCHAR(2400)) AS feature14
  ,CAST(NULL AS DECIMAL(38,9)) AS penetrate_cum_rel_pct
  ,CAST(1 AS BYTEINT) AS prot_fg
FROM p_lew_core_ac.v_market_article_feature AS feat
INNER JOIN p_lew_process_mstr_ac.v_lil_region AS reg
ON reg.region_sid = feat.region_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_period AS per
ON per.client_id = feat.client_id
AND per.period_sid = feat.period_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_assort_region_cat AS asmp
ON asmp.client_id = feat.client_id 
AND asmp.region_sid = feat.region_sid
AND asmp.assort_cat_sid = feat.assort_cat_sid
UNION ALL
SELECT
CAST(reg.region_id AS SMALLINT) AS client_id
  ,per.period_id
  ,CAST(Substr(asmp.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)) AS liam_parnt_clnt_cat_id
  ,CAST(asmp.assort_region_cat_id AS CHAR(27)) AS liam_clnt_cat_id
  ,-1 AS pos_nr
  ,CAST(NULL AS VARCHAR(512)) AS manufacturer
  ,CAST(NULL AS VARCHAR(512)) AS brand
  ,CAST(NULL AS VARCHAR(512)) AS product_name
  ,CAST(NULL AS VARCHAR(512)) AS pack_size
  ,CAST(NULL AS VARCHAR(512)) AS ean
  ,CAST(NULL AS VARCHAR(512)) AS category_family
  ,CAST(NULL AS VARCHAR(2400)) AS feature1
  ,CAST(NULL AS VARCHAR(2400)) AS feature2
  ,CAST(NULL AS VARCHAR(2400)) AS feature3
  ,CAST(NULL AS VARCHAR(2400)) AS feature4
  ,CAST(NULL AS VARCHAR(2400)) AS feature5
  ,CAST(NULL AS VARCHAR(2400)) AS feature6
  ,CAST(NULL AS VARCHAR(2400)) AS feature7
  ,CAST(NULL AS VARCHAR(2400)) AS feature8
  ,CAST(NULL AS VARCHAR(2400)) AS feature9
  ,CAST(NULL AS VARCHAR(2400)) AS feature10
  ,CAST(NULL AS VARCHAR(2400)) AS feature11
  ,CAST(NULL AS VARCHAR(2400)) AS feature12
  ,CAST(NULL AS VARCHAR(2400)) AS feature13
  ,CAST(NULL AS VARCHAR(2400)) AS feature14
  ,CAST(NULL AS DECIMAL(38,9)) AS penetrate_cum_rel_pct
  ,CAST(1 AS BYTEINT) AS prot_fg
FROM p_lew_core_ac.v_market_article_feature AS feat
INNER JOIN p_lew_process_mstr_ac.v_lil_region AS reg
ON reg.region_sid = feat.region_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_period AS per
ON per.client_id = feat.client_id
AND per.period_sid = feat.period_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_assort_region_cat AS asmp
ON asmp.client_id = feat.client_id 
AND asmp.region_sid = feat.region_sid
AND asmp.assort_cat_sid = feat.assort_cat_sid;
