CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zskcasesizeforea_1 (itemid, zskcasesize, itemprefix
) AS SELECT steks_listingoverviewmax.itemid,
 steks_listingoverviewmax.casesize AS zskcasesize,
   '8' || REPEAT('0', 6 - LENGTH(CAST(CAST(steks_listingoverviewmax.casesize AS BIGNUMERIC) AS STRING))) || CAST(CAST(steks_listingoverviewmax.casesize AS BIGNUMERIC) AS STRING) AS itemprefix
FROM idq_production_eks_calculation.steks_listingoverviewmax_1
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_1 ON steks_listingoverviewmax.listingoverviewid = xteks_basicinfo_reccountry.listingoverviewid AND steks_listingoverviewmax.casesize = xteks_basicinfo_reccountry.casesize AND steks_listingoverviewmax.itemid =
     xteks_basicinfo_reccountry.itemid AND steks_listingoverviewmax.receivingcountry = xteks_basicinfo_reccountry.receivingcountry AND steks_listingoverviewmax.supplierno = xteks_basicinfo_reccountry.supplierno
WHERE xteks_basicinfo_reccountry.zisvalidcontract = 1
 AND xteks_basicinfo_reccountry.sk_itemid IS NULL
GROUP BY steks_listingoverviewmax.itemid,
 zskcasesize,
 itemprefix;