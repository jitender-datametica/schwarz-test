CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zhasvalidmaxlu_updsel (itemid, zhasvalidmaxlu,
zhasvalidmaxlunew, zrelevantluidnew, zrelevantluid) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidmaxlu,
 1 AS zhasvalidmaxlunew,
 MAX(steks_listingoverviewmax.listingoverviewid) AS zrelevantluidnew,
 stmara_eks_item.zrelevantluid
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks.listingitem ON stmara_eks_item.itemid = listingitem.itemid
 INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax ON listingitem.listingoverviewid =
   steks_listingoverviewmax.listingoverviewid AND listingitem.itemid = steks_listingoverviewmax.itemid
GROUP BY stmara_eks_item.itemid,
 stmara_eks_item.zhasvalidmaxlu,
 stmara_eks_item.zrelevantluid;