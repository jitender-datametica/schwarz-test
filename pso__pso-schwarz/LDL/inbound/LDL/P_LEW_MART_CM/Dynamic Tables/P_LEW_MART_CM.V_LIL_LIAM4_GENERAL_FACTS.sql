
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_LIAM4_GENERAL_FACTS
(
client_id
, liam_clnt_cat_id
, per_id
, liam_parnt_clnt_cat_id
, currency_iso_cd
, volume_type
, buyer_cnt
, turnover_val
, penetrate_abs_pct
, household_in_country_cnt
, feature1_name
, feature2_name
, feature3_name
, feature4_name
, feature5_name
, feature6_name
, feature7_name
, feature8_name
, feature9_name
, feature10_name
, feature11_name
, feature12_name
, feature13_name
, feature14_name
, total_market_desc
, total_market_id
, retailer1_desc
, retailer1_id
, retailer2_desc
, retailer2_id
, retailer3_desc
, retailer3_id
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
       reg.region_id AS client_id
     , CAST(assort_region_cat_id AS CHAR(27)) AS liam_clnt_cat_id
     , period_id AS per_id
     , CAST(SUBSTRING(ass.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)) AS liam_parnt_clnt_cat_id
     , CAST(cer.to_currency_iso_cd AS CHAR(3)) AS currency_iso_cd
     , CASE
            WHEN LENGTH(SUBSTRING(feature14_name, 13)) = 0 THEN CAST('-Volume not provided-' AS VARCHAR(30))
            ELSE COALESCE(SUBSTRING(feature14_name, 13), CAST('-Volume not provided-' AS VARCHAR(30)))
            END AS volume_type,
    (dt.buyer_cnt/1000)::DECIMAL(23,5) AS buyer_cnt,
    ((dt.turnover_val/1000)::DECIMAL(23,5)*cer.rate_currency_exchange)::DECIMAL(23,5) AS turnover_val,
    (penetrate_abs_pct)::DECIMAL(23,5),
    (household_in_country_cnt/1000)::DECIMAL(23,5) AS household_in_country_cnt
     , feature1_name
     , feature2_name
     , feature3_name
     , feature4_name
     , feature5_name
     , feature6_name
     , feature7_name
     , feature8_name
     , feature9_name
     , feature10_name
     , feature11_name
     , feature12_name
     , feature13_name
     , CAST(TRIM(SUBSTRING(feature14_name, 1, 11))AS VARCHAR(180)) AS feature14_name
     , CAST('Total Market' AS VARCHAR(128)) AS total_market_desc
     , CAST(10 AS INTEGER) AS total_market_id
     , CAST('Lidl' AS VARCHAR(128)) AS retailer1_desc
     , CAST('1000' AS INTEGER) AS retailer1_id
     , CAST(comp1.region_rtl_desc_de AS VARCHAR(128)) AS retailer2_desc
     , comp1.rtl_id AS retailer2_id
     , CAST(comp2.region_rtl_desc_de AS VARCHAR(128)) AS retailer3_desc
     , comp2.rtl_id AS retailer3_id
FROM P_LEW_CORE_AC.v_market_article_feature AS dt
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region AS reg
    ON reg.region_sid = dt.region_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period AS perms
    ON perms.client_id = dt.client_id
    AND perms.period_sid = dt.period_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_assort_region_cat AS ass
    ON ass.client_id = dt.client_id
    AND ass.region_sid = dt.region_sid
    AND ass.assort_cat_sid = dt.assort_cat_sid
INNER JOIN P_LEW_CORE_AC.v_lil_assort_category AS assc
    ON assc.client_id = ass.client_id
   AND assc.assort_cat_sid = ass.assort_cat_sid
INNER JOIN P_LEW_CORE_AC.v_market_article_feature_pos AS pos
    ON pos.region_sid = dt.region_sid
    AND pos.assort_cat_sid = dt.assort_cat_sid
    AND pos.period_sid = dt.period_sid
    AND pos.rank_pos = 1
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_retailer AS comp1
    ON comp1.client_id = pos.client_id
    AND comp1.retailer_sid = pos.retailer_sid_comp1
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_retailer AS comp2
    ON comp2.client_id = pos.client_id
    AND comp2.retailer_sid = pos.retailer_sid_comp2
INNER JOIN P_LEW_MART_CM.v_lil_currency_exch_rt AS cer
    ON cer.from_currency_iso_cd = dt.curr_cd
WHERE COALESCE(pos.deleted_fg, 0) = 0
    AND NOT EXISTS(
        SELECT NULL
        FROM P_LEW_PROCESS_MSTR_AC.v_lil_data_mask AS dm
        WHERE dm.client_id = dt.client_id
        AND dm.region_sid = dt.region_sid
        AND dm.period_sid = dt.period_sid
        AND dm.src_assort_parent_cat_cd = LTRIM(assc.src_assort_parent_cat_cd)
        AND dm.interface_name = 'LIAM_FMCG_AssOpt'
        AND dm.mask_data_fg = 1);
