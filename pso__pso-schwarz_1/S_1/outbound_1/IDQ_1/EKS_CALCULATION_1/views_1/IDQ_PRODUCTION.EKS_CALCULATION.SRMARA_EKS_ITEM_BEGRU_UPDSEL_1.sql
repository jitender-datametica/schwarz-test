CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_begru_updsel_1 (itemid, zbegru, zbegrunew) AS SELECT
 itemid,
 zbegru,
  CASE
  WHEN znegotiatingcountry = 'NT'
  THEN 'INTEGER '
  ELSE znegotiatingcountry
  END AS zbegrunew
FROM idq_production_eks_calculation.stmara_eks_item_1
WHERE CASE
  WHEN znegotiatingcountry = 'NT'
  THEN 'INTEGER '
  ELSE znegotiatingcountry
  END IS NOT NULL;