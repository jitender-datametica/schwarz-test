CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_znegotiatingcountry_barollup01_2 (itemid,
znegotiatingcountry, bitflag) AS SELECT t1.itemid1 AS itemid,
 t1.znegotiatingcountry,
 t1.bitflag0 AS bitflag
FROM (SELECT STMARA_EKS_ITEM_1.itemid AS itemid1,
   STMARA_EKS_ITEM_1.bitflag AS bitflag0,
   MIN(stmara_eks_item.znegotiatingcountry) AS znegotiatingcountry
  FROM idq_production_eks_calculation.stmara_eks_item_2
   INNER JOIN idq_production_eks.itemsorting_2 ON stmara_eks_item.itemid = itemsorting.itemid
   INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS STMARA_EKS_ITEM_1 ON itemsorting.sortitemid =
    STMARA_EKS_ITEM_1.itemid
  WHERE stmara_eks_item.bitflag = 4
  GROUP BY STMARA_EKS_ITEM_1.itemid,
   STMARA_EKS_ITEM_1.bitflag
  HAVING znegotiatingcountry IS NOT NULL) AS t1_2;