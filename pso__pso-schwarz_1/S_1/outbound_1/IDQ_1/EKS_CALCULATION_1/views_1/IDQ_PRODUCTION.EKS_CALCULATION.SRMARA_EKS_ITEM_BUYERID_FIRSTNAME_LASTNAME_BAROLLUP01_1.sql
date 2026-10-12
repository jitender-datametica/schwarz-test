CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_buyerid_firstname_lastname_barollup01_1 (itemid,
buyerid, bitflag) AS SELECT t1.itemid1 AS itemid,
 t1.buyerid,
 t1.bitflag0 AS bitflag
FROM (SELECT STMARA_EKS_ITEM_1.itemid AS itemid1,
   STMARA_EKS_ITEM_1.bitflag AS bitflag0,
   MIN(stmara_eks_item.buyerid) AS buyerid
  FROM idq_production_eks_calculation.stmara_eks_item_1
   INNER JOIN idq_production_eks.itemsorting_1 ON stmara_eks_item.itemid = itemsorting.itemid
   INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS STMARA_EKS_ITEM_1 ON itemsorting.sortitemid =
    STMARA_EKS_ITEM_1.itemid
  WHERE stmara_eks_item.bitflag = 4
  GROUP BY STMARA_EKS_ITEM_1.itemid,
   STMARA_EKS_ITEM_1.bitflag
  HAVING buyerid IS NOT NULL) AS t1_1;