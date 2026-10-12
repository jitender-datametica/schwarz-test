CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_wawirelevancy_zfullmatchsk_010_2 (itemid, itemno,
zfullmatchnew, zisvalidcontract) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 1 AS zfullmatchnew,
 xteks_basicinfo_reccountry.zisvalidcontract
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_2 AS xteks_basicinfo_reccountry_2 ON stmara_eks_item.itemno
   = xteks_basicinfo_reccountry.sk_itemno
WHERE xteks_basicinfo_reccountry.zisvalidcontract = 1
 AND stmara_eks_item.zrelevantmdm = 1;