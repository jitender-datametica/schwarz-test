CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_union_inssel_2 (listingoverviewid,
casesize, itemid, basicpriceid, contractpricevalidityid, zarticletype, receivingcountry) AS SELECT DISTINCT
 listingoverviewid,
 casesize,
 itemid,
 basicpriceid,
 contractpricevalidityid,
 'EA' AS zarticletype,
 receivingcountry
FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_2
WHERE zisvalidcontract = 1
 AND sk_itemid IS NULL
UNION DISTINCT
SELECT DISTINCT listingoverviewid,
 casesize,
 sk_itemid AS itemid,
 basicpriceid,
 contractpricevalidityid,
 'SK' AS zarticletype,
 receivingcountry
FROM idq_production_eks_calculation.xteks_basicinfo_reccountry_2
WHERE zisvalidcontract = 1
 AND sk_itemid IS NOT NULL;