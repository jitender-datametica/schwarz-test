CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_nettgreatergross_010 (contract_type, lu_heading,
zsource, zactive, znegotiatingcountry, itemid, itemno, zarticletype, description_int, zmatkl, articlefamily,
buyerfirstname, buyerlastname, buyershortsign, listingoverviewid, intsupplierno, supplierdescription, receivingcountry,
casesize, decimalcasesize, casegrossweight, netweight, subcases, subcasesize, casenetweight, ziscurrentcontract,
ziscurrentcontractfromsk, zrelevantmdm) AS SELECT DISTINCT trans_loc.description AS contract_type,
 trans_loh.description AS lu_heading,
 stmara_eks_item.zsource,
 stmara_eks_item.zactive,
 stmara_eks_item.znegotiatingcountry,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype,
 stmara_eks_item.description_int,
 stmara_eks_item.zmatkl,
 stmara_eks_item.articlefamily,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.buyershortsign,
 xteks_basicinfo_reccountry.listingoverviewid,
 supplier.intsupplierno,
 supplier.description AS supplierdescription,
 xteks_basicinfo_reccountry.receivingcountry,
 xteks_basicinfo_reccountry.casesize,
 xteks_basicinfo_reccountry.decimalcasesize,
 itemweight.casegrossweight,
 itemdetail.netweight,
 basicprice.subcases,
 basicprice.subcasesize,
   CAST(basicprice.subcases AS FLOAT64) * CAST(basicprice.subcasesize AS FLOAT64) * CAST(itemdetail.netweight AS FLOAT64)
   AS casenetweight,
 stmara_eks_item.ziscurrentcontract,
 stmara_eks_item.ziscurrentcontractfromsk,
 xteks_basicinfo_reccountry.ziswawirelevant AS zrelevantmdm
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry ON stmara_eks_item.itemno =
  xteks_basicinfo_reccountry.itemno
 INNER JOIN idq_production_eks.listingitem ON xteks_basicinfo_reccountry.listingoverviewid = listingitem.listingoverviewid
    AND stmara_eks_item.itemid = listingitem.itemid
 INNER JOIN idq_production_eks.basicprice ON xteks_basicinfo_reccountry.basicpriceid = basicprice.basicpriceid AND
   listingitem.listingitemid = basicprice.listingitemid
 INNER JOIN idq_production_eks.supplier ON xteks_basicinfo_reccountry.supplierno = supplier.supplierno
 INNER JOIN idq_production_eks.itemdetail ON stmara_eks_item.itemid = itemdetail.itemid
 LEFT JOIN idq_production_eks.itemweight ON xteks_basicinfo_reccountry.itemid = itemweight.itemid AND
   xteks_basicinfo_reccountry.contractpricevalidityid = itemweight.contractpricevalidityid
 LEFT JOIN idq_production_eks.listingoverview AS list ON xteks_basicinfo_reccountry.listingoverviewid = list.listingoverviewid
  
 LEFT JOIN idq_production_eks.loheading AS loh ON list.loheadingid = loh.loheadingid
 LEFT JOIN idq_production_eks.translation_int AS trans_loh ON loh.descriptionid = trans_loh.translationid
 LEFT JOIN idq_production_eks.locategory AS loc ON list.locategoryid = loc.locategoryid
 LEFT JOIN idq_production_eks.translation_int AS trans_loc ON loc.descriptionid = trans_loc.translationid
WHERE stmara_eks_item.ziscurrentcontract = 1
 AND stmara_eks_item.zarticletype = 'EA'
 AND LOWER(IFNULL(trans_loc.description, '')) NOT LIKE '%filialbelieferung%'
 AND LOWER(IFNULL(trans_loh.description, '')) NOT LIKE '%dezentral%';