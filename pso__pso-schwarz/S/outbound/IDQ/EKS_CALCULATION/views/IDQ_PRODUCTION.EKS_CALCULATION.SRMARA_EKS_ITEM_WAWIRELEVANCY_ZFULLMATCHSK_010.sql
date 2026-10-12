CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_wawirelevancy_zfullmatchsk_010 (itemid, itemno,
zfullmatchnew, zisvalidcontract) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 1 AS zfullmatchnew,
 XTEKS_BASICINFO_RECCOUNTRY.zisvalidcontract
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry AS XTEKS_BASICINFO_RECCOUNTRY ON stmara_eks_item.itemno
   = XTEKS_BASICINFO_RECCOUNTRY.sk_itemno
WHERE XTEKS_BASICINFO_RECCOUNTRY.zisvalidcontract = 1
 AND stmara_eks_item.zrelevantmdm = 1;