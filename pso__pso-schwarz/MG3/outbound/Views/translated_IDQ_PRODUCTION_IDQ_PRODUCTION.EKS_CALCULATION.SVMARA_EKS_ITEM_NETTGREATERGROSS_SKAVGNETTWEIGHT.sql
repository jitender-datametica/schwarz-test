CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_nettgreatergross_skavgnettweight (itemid, itemno,
zarticletype, listingoverviewid, decimalcasesize, casesize, netweight, supplierno, receivingcountry) AS SELECT
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype,
 xteks_basicinfo_reccountry.listingoverviewid,
 xteks_basicinfo_reccountry.decimalcasesize,
 xteks_basicinfo_reccountry.casesize,
 AVG(CAST(itemdetail.netweight AS FLOAT64)) AS netweight,
 xteks_basicinfo_reccountry.supplierno,
 xteks_basicinfo_reccountry.receivingcountry
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry ON stmara_eks_item.itemid =
  xteks_basicinfo_reccountry.sk_itemid
 INNER JOIN idq_production_eks.itemsorting ON stmara_eks_item.itemid = itemsorting.sortitemid
 INNER JOIN idq_production_eks.itemdetail ON itemdetail.itemid IS NOT NULL
GROUP BY stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype,
 xteks_basicinfo_reccountry.listingoverviewid,
 xteks_basicinfo_reccountry.decimalcasesize,
 xteks_basicinfo_reccountry.casesize,
 xteks_basicinfo_reccountry.supplierno,
 xteks_basicinfo_reccountry.receivingcountry
HAVING stmara_eks_item.zarticletype = 'SK';