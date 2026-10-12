CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_sk_descriptionnotendingwithsk_sel (negotiatingcountry
, buyershortsign, buyerfirstname, buyerlastname, zmatkl, articlefamily, itemid, itemno, articletype, shortdesc_int,
description, shortdesc_nat, description_nat, zrelevantmdm, zsource, zactive) AS SELECT DISTINCT stmara_eks_item.znegotiatingcountry
  AS negotiatingcountry,
 stmara_eks_item.buyershortsign,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.shortdesc_int,
 stmara_eks_item.description_int AS description,
 stmara_eks_item.shortdesc_nat,
 stmara_eks_item.description_nat,
 stmara_eks_item.zrelevantmdm,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive
FROM idq_production_eks_calculation.stmara_eks_item
 LEFT JOIN idq_production_eks_calculation.eks_zsm_excludelist ON stmara_eks_item.itemno = eks_zsm_excludelist.itemno AND
   eks_zsm_excludelist.reportno = '045'
WHERE stmara_eks_item.zactive = 1
 AND stmara_eks_item.constructed IS NULL
 AND stmara_eks_item.zarticletype = 'SK'
 AND (NOT REGEXP_CONTAINS(RTRIM(stmara_eks_item.description_int) , r'.*SK[1-9]') AND NOT REGEXP_CONTAINS(RTRIM(stmara_eks_item
         .description_int) , r'.*SK[1-9][0-9]') AND NOT REGEXP_CONTAINS(RTRIM(stmara_eks_item.description_int) , r'.*SK[1-9][0-9][0-9]'
       ) OR NOT REGEXP_CONTAINS(RTRIM(stmara_eks_item.description_nat) , r'.*SK[1-9]') AND NOT REGEXP_CONTAINS(RTRIM(stmara_eks_item
         .description_nat) , r'.*SK[1-9][0-9]') AND NOT REGEXP_CONTAINS(RTRIM(stmara_eks_item.description_nat) , r'.*SK[1-9][0-9][0-9]'
       ) OR NOT REGEXP_CONTAINS(RTRIM(stmara_eks_item.shortdesc_int) , r'.*SK[1-9]') AND NOT REGEXP_CONTAINS(RTRIM(stmara_eks_item
        .shortdesc_int) , r'.*SK[1-9][0-9]') AND NOT REGEXP_CONTAINS(RTRIM(stmara_eks_item.shortdesc_int) , r'.*SK[1-9][0-9][0-9]'
      ) OR NOT REGEXP_CONTAINS(RTRIM(stmara_eks_item.shortdesc_nat) , r'.*SK[1-9]') AND NOT REGEXP_CONTAINS(RTRIM(stmara_eks_item
       .shortdesc_nat) , r'.*SK[1-9][0-9]') AND NOT REGEXP_CONTAINS(RTRIM(stmara_eks_item.shortdesc_nat) , r'.*SK[1-9][0-9][0-9]'
     ))
 AND eks_zsm_excludelist.itemno IS NULL;