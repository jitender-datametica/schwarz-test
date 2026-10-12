CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_itemsonlyinexcludelist (itemid) AS SELECT FullList
 .itemid
FROM (SELECT itemid,
   COUNT(0) AS cnt
  FROM idq_production_eks_calculation.svmara_eks_item_ea_receivingcountry
  WHERE receivingcountry IN ('US', 'LX', 'EW', 'CH')
  GROUP BY itemid) AS ExcludeList
 INNER JOIN (SELECT itemid,
   COUNT(0) AS cnt
  FROM idq_production_eks_calculation.svmara_eks_item_ea_receivingcountry AS svmara_eks_item_ea_receivingcountry_1
  GROUP BY itemid) AS FullList ON ExcludeList.itemid = FullList.itemid AND ExcludeList.cnt = FullList.cnt;