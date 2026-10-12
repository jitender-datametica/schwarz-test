CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_nettgreatergross_skcasegrossweight_2 (itemid, itemno
, zarticletype, listingoverviewid, casegrossweight, casesize, supplierno, receivingcountry, basicpriceid, listingitemid
) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype,
 xteks_basicinfo_reccountry.listingoverviewid,
 itemweight.casegrossweight,
 xteks_basicinfo_reccountry.casesize,
 xteks_basicinfo_reccountry.supplierno,
 xteks_basicinfo_reccountry.receivingcountry,
 xteks_basicinfo_reccountry.basicpriceid,
 listingitem.listingitemid
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry_2 ON stmara_eks_item.itemid =
  xteks_basicinfo_reccountry.sk_itemid
 INNER JOIN idq_production_eks.listingitem_2 ON xteks_basicinfo_reccountry.listingoverviewid = listingitem.listingoverviewid
    AND xteks_basicinfo_reccountry.sk_itemid = listingitem.itemid
 LEFT JOIN idq_production_eks.itemweight_2 ON listingitem.itemid = itemweight.itemid AND xteks_basicinfo_reccountry.contractpricevalidityid
    = itemweight.contractpricevalidityid
WHERE stmara_eks_item.zarticletype = 'SK'
 AND stmara_eks_item.ziscurrentcontract = 1;