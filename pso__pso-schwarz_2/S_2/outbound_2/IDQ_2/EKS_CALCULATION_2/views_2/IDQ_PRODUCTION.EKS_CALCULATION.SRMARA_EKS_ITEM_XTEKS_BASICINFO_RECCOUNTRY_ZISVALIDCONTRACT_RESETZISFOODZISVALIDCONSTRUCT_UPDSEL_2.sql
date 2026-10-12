CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_resetzisfoodzisvalidconstruct_updsel_2
(itemid, listingoverviewid, casesize, itemno, sk_itemid, sk_itemno, receivingcountry, supplierno, zisvalidcontract,
zisfood, zisvalidconstruct, zisvalidcontractnew) AS SELECT DISTINCT stmara_eks_item.itemid,
 xteks_basicinfo_reccountry.listingoverviewid,
 xteks_basicinfo_reccountry.casesize,
 xteks_basicinfo_reccountry.itemno,
 xteks_basicinfo_reccountry.sk_itemid,
 xteks_basicinfo_reccountry.sk_itemno,
 xteks_basicinfo_reccountry.receivingcountry,
 xteks_basicinfo_reccountry.supplierno,
 xteks_basicinfo_reccountry.zisvalidcontract,
 stmara_eks_item.zisfood,
 stmara_eks_item.zisvalidconstruct,
 0 AS zisvalidcontractnew
FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_2
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 ON xteks_basicinfo_reccountry.itemid = stmara_eks_item.itemid
  
WHERE xteks_basicinfo_reccountry.zisvalidcontract = 1 AND stmara_eks_item.zisfood IS NULL
 OR xteks_basicinfo_reccountry.zisvalidcontract = 1 AND stmara_eks_item.zisvalidconstruct = 0;