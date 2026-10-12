CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_wawirelevancy_zfullmatchea_010_1 (itemid, itemno,
zfullmatchnew, zisvalidcontract) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 1 AS zfullmatchnew,
 XTEKS_BASICINFO_RECCOUNTRY.zisvalidcontract
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_1 AS XTEKS_BASICINFO_RECCOUNTRY_1 ON stmara_eks_item.itemno
    = XTEKS_BASICINFO_RECCOUNTRY.itemno AND XTEKS_BASICINFO_RECCOUNTRY.sk_itemid IS NULL
WHERE XTEKS_BASICINFO_RECCOUNTRY.zisvalidcontract = 1
 AND stmara_eks_item.zrelevantmdm = 1;