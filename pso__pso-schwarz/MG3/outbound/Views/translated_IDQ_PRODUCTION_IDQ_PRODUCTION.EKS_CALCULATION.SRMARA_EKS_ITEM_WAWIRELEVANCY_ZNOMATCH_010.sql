CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_wawirelevancy_znomatch_010 (itemid, itemno,
znomatchnew) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 1 AS znomatchnew
FROM idq_production_eks.item
 INNER JOIN idq_production_eks_calculation.steks_listingoverviewmax_alltime ON item.itemid =
  steks_listingoverviewmax_alltime.itemid
 RIGHT JOIN idq_production_eks_calculation.stmara_eks_item ON steks_listingoverviewmax_alltime.itemid = stmara_eks_item
   .itemid AND item.itemno = stmara_eks_item.itemno
WHERE steks_listingoverviewmax_alltime.itemid IS NULL;