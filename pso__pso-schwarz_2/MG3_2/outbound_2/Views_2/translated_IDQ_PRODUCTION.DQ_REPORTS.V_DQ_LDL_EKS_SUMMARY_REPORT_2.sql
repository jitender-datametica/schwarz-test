
CREATE OR REPLACE VIEW idq_production_dq_reports.v_dq_ldl_eks_summary_report_2 AS WITH combineddq AS (SELECT itemid,
   ref_country_id,
   1 AS ref_source_system_type_id,
   negotiatingcountry,
   buyershortsign,
   articlefamily,
   supplierno,
   supplierdescription,
   listingoverviewid AS lu_number,         
   description,
   itemno,
   articletype,
   dq
  FROM (SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      listingoverviewid,
      description,
      itemno,
      articletype,
      '5' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_item_nettgreatergross_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      listingoverviewid,
      description,
      itemno,
      articletype,
      '10' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_item_gtin_missingsel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      listingoverviewid,
      description,
      itemno,
      articletype,
      '11' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_gtin_missing_changecountry_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      CAST(NULL AS STRING) AS articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '12' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_different_merchandising_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '13' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_different_buyer_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '16' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_item_duplicate_ea_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      listingoverviewid,
      description,
      itemno,
      articletype,
      '17' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_item_zusatzgewichtsartikel_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      listingoverviewid,
      description,
      itemno,
      articletype,
      '18' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_measurementsandcasegrossweightdifferences_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '20' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_item_nettweight_missingsel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '21' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_nettweight_different_packcontent_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '22' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_item_commodity_code_missingsel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      listingoverviewid,
      description,
      itemno,
      articletype,
      '23' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_casegrossweight_missingsel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      listingoverviewid,
      description,
      itemno,
      articletype,
      '25' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_with_measure_gt_cm_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      listingoverviewid,
      description,
      itemno,
      articletype,
      '27' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_item_palletutilisationunder50orover120_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      listingoverviewid,
      description,
      itemno,
      articletype,
      '28' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_messures_diff_betw_articlessel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '29' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_ean_duplicate_eas_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '30' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_ea_multiple_commoditycode_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '36' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_notint604_detail_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '37' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_differentnettweight_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '42' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_multiple_ea_for_kolligtin_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '44' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_ba_descriptionnotendingwithba_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '45' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_dq_eks_sk_descriptionnotendingwithsk_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      listingoverviewid,
      description,
      itemno,
      articletype,
      '46' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_rlz_mhd_notmaintained_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      listingoverviewid,
      description,
      itemno,
      articletype,
      '53' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks__missingkolligtin_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '54' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_inconsistentbrandacrossconstruct_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '57' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_missinggewart_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '59' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_easinactivebuyer_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      listingoverviewid,
      description,
      itemno,
      articletype,
      '65' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_contracttypedisplayismissing_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      CAST(NULL AS BIGNUMERIC) AS supplierno,
      CAST(NULL AS STRING) AS supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '206' AS dq
     FROM idq_production_dq_reports.v_dq_ldl_eks_item_differentbaseuomwithinconstruct_sel_2
     UNION ALL
     SELECT itemid,
      ref_country_id,
      negotiatingcountry,
      buyershortsign,
      articlefamily,
      supplierno,
      supplierdescription,
      CAST(NULL AS BIGNUMERIC) AS listingoverviewid,
      description,
      itemno,
      articletype,
      '207' AS dq
     FROM idq_production_dq_reports.v_dq_rep_ldl_eks_gtincheckdigitinvalid_sel_2) AS AllDQData), filtereddq AS (SELECT t1_2
   .itemid,
   t1.ref_country_id,
   t1.ref_source_system_type_id,
   t1.negotiatingcountry,
   t1.buyershortsign,
   t1.articlefamily,
   t1.supplierno,
   t1.supplierdescription,
   t1.lu_number,
   t1.description,
   t1.itemno,
   t1.articletype,
   t1.dq
  FROM combineddq AS t1_2
   LEFT JOIN idq_production_dq_reports.eks_exclude_2 AS t210 ON CAST(t1.dq AS FLOAT64) = t210.rule_id AND CAST(t1.ref_country_id AS FLOAT64)
       = t210.country_id AND t1.itemid = t210.itemid AND IFNULL(t1.lu_number, - 1) = IFNULL(t210.listingoverviewid, - 1
      )
  WHERE t210.rule_id IS NULL), groupeddq AS (SELECT ref_country_id,
   ref_source_system_type_id,
   MAX(negotiatingcountry) AS negotiatingcountry,
   MAX(buyershortsign) AS buyershortsign,
   MAX(articlefamily) AS articlefamily,
   supplierno,
   MAX(supplierdescription) AS supplierdescription,
   lu_number,
   MAX(description) AS description,
   itemno,
   MAX(articletype) AS articletype,
   CONCAT('|',STRING_AGG(DISTINCT DQ, '|' ORDER BY DQ),'|') AS DQ_Aggregated  FROM filtereddq
  GROUP BY ref_country_id,
   ref_source_system_type_id,
   supplierno,
   lu_number,
   itemno) (SELECT ROW_NUMBER() OVER (ORDER BY DQS.itemno IS NULL, DQS.itemno) AS id,
   DQS.ref_country_id,
   DQS.ref_source_system_type_id,
   DQS.negotiatingcountry,
   DQS.buyershortsign,
   DQS.articlefamily,
   DQS.supplierno,
   DQS.supplierdescription,
   DQS.lu_number,
   trs.description AS lu_uberschrift,
   DQS.itemno,
   DQS.description,
   DQS.articletype,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|5|%'
    THEN 1
    ELSE NULL
    END AS dq_005,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|10|%'
    THEN 1
    ELSE NULL
    END AS dq_010,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|11|%'
    THEN 1
    ELSE NULL
    END AS dq_011,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|12|%'
    THEN 1
    ELSE NULL
    END AS dq_012,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|13|%'
    THEN 1
    ELSE NULL
    END AS dq_013,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|16|%'
    THEN 1
    ELSE NULL
    END AS dq_016,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|17|%'
    THEN 1
    ELSE NULL
    END AS dq_017,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|18|%'
    THEN 1
    ELSE NULL
    END AS dq_018,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|20|%'
    THEN 1
    ELSE NULL
    END AS dq_020,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|21|%'
    THEN 1
    ELSE NULL
    END AS dq_021,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|22|%'
    THEN 1
    ELSE NULL
    END AS dq_022,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|23|%'
    THEN 1
    ELSE NULL
    END AS dq_023,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|25|%'
    THEN 1
    ELSE NULL
    END AS dq_025,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|27|%'
    THEN 1
    ELSE NULL
    END AS dq_027,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|28|%'
    THEN 1
    ELSE NULL
    END AS dq_028,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|29|%'
    THEN 1
    ELSE NULL
    END AS dq_029,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|30|%'
    THEN 1
    ELSE NULL
    END AS dq_030,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|36|%'
    THEN 1
    ELSE NULL
    END AS dq_036,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|37|%'
    THEN 1
    ELSE NULL
    END AS dq_037,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|42|%'
    THEN 1
    ELSE NULL
    END AS dq_042,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|44|%'
    THEN 1
    ELSE NULL
    END AS dq_044,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|45|%'
    THEN 1
    ELSE NULL
    END AS dq_045,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|46|%'
    THEN 1
    ELSE NULL
    END AS dq_046,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|53|%'
    THEN 1
    ELSE NULL
    END AS dq_053,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|54|%'
    THEN 1
    ELSE NULL
    END AS dq_054,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|57|%'
    THEN 1
    ELSE NULL
    END AS dq_057,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|59|%'
    THEN 1
    ELSE NULL
    END AS dq_059,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|65|%'
    THEN 1
    ELSE NULL
    END AS dq_065,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|206|%'
    THEN 1
    ELSE NULL
    END AS dq_206,
    CASE
    WHEN DQS.dq_aggregated LIKE '%|207|%'
    THEN 1
    ELSE NULL
    END AS dq_207
  FROM groupeddq AS DQS
   LEFT JOIN idq_production_eks.listingoverview_2 AS list ON DQS.lu_number = list.listingoverviewid
   LEFT JOIN idq_production_eks.loheading_2 AS lh ON list.loheadingid = lh.loheadingid
   LEFT JOIN idq_production_eks.translation_int_2 AS trs ON lh.descriptionid = trs.translationid);

