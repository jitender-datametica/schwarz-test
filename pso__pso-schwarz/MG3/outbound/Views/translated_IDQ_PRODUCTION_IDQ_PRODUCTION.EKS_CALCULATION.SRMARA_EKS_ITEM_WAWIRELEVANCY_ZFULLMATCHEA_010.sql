CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_wawirelevancy_zfullmatchea_010 (itemid, itemno,
zfullmatchnew, zisvalidcontract) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 1 AS zfullmatchnew,
 xteks_basicinfo_reccountry.zisvalidcontract
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry AS xteks_basicinfo_reccountry ON stmara_eks_item.itemno
    = xteks_basicinfo_reccountry.itemno AND xteks_basicinfo_reccountry.sk_itemid IS NULL
WHERE xteks_basicinfo_reccountry.zisvalidcontract = 1
 AND stmara_eks_item.zrelevantmdm = 1;