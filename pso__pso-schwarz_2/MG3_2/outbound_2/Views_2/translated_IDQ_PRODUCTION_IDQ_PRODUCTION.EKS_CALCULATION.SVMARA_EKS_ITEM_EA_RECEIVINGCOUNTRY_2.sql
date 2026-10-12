CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_ea_receivingcountry_2 (itemid, receivingcountry) AS
(SELECT ea.itemid,
  steks_listingoverviewmax.receivingcountry
 FROM idq_production_eks_calculation.stmara_eks_item_2 AS sk
  INNER JOIN idq_production_eks.itemsorting_2 ON sk.itemid = itemsorting.sortitemid
  INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS ea ON itemsorting.itemid = ea.itemid
  INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax_2 ON sk.itemid = steks_listingoverviewmax.itemid
 WHERE ea.bitflag = 0
  AND sk.bitflag = 4
 UNION DISTINCT
 SELECT ea.itemid,
  steks_listingoverviewmax0.receivingcountry
 FROM idq_production_eks_calculation.stmara_eks_item_2 AS ea
  INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax_2 AS steks_listingoverviewmax0 ON ea.itemid =
   steks_listingoverviewmax0.itemid
 WHERE ea.bitflag = 0)
UNION DISTINCT
SELECT sk.itemid,
 steks_listingoverviewmax1.receivingcountry
FROM idq_production_eks_calculation.stmara_eks_item_2 AS sk
 INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax_2 AS steks_listingoverviewmax1 ON sk.itemid =
  steks_listingoverviewmax1.itemid
WHERE sk.bitflag = 4
 AND sk.constructed IS NULL;