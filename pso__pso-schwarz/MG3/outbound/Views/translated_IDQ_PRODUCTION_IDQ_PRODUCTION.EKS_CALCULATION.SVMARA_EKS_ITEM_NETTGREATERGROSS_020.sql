CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_nettgreatergross_020 (zsource, zactive,
znegotiatingcountry, itemid, itemno, zarticletype, description_int, zmatkl, articlefamily, buyerfirstname, buyerlastname
, buyershortsign, listingoverviewid, intsupplierno, supplierdescription, receivingcountry, casesize, casegrossweight,
netweight, total_casenetweight, decimalcasesize, ziscurrentcontract, ziscurrentcontractfromsk, zrelevantmdm) AS SELECT
DISTINCT stmara_eks_item.zsource,
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
 gw.casegrossweight,
 nw.netweight,
 nw.total_casenetweight,
 xteks_basicinfo_reccountry.decimalcasesize,
 stmara_eks_item.ziscurrentcontract,
 stmara_eks_item.ziscurrentcontractfromsk,
 xteks_basicinfo_reccountry.ziswawirelevant AS zrelevantmdm
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks_calculation.xteks_basicinfo_reccountry ON stmara_eks_item.itemid =
  xteks_basicinfo_reccountry.sk_itemid
 INNER JOIN idq_production_eks.listingitem ON xteks_basicinfo_reccountry.listingoverviewid = listingitem.listingoverviewid
    AND stmara_eks_item.itemid = listingitem.itemid
 INNER JOIN idq_production_eks.basicprice ON listingitem.listingitemid = basicprice.listingitemid AND
   xteks_basicinfo_reccountry.basicpriceid = basicprice.basicpriceid
 INNER JOIN idq_production_eks.supplier ON xteks_basicinfo_reccountry.supplierno = supplier.supplierno
 INNER JOIN idq_production_eks_calculation.svmara_eks_item_nettgreatergross_skcasegrossweight AS gw ON listingitem.itemid
       = gw.itemid AND xteks_basicinfo_reccountry.listingoverviewid = gw.listingoverviewid AND
     xteks_basicinfo_reccountry.casesize = gw.casesize AND xteks_basicinfo_reccountry.supplierno = gw.supplierno AND
   xteks_basicinfo_reccountry.receivingcountry = gw.receivingcountry
 INNER JOIN idq_production_eks_calculation.svmara_eks_item_nettgreatergross_sknettweight AS nw ON listingitem.itemid =
      nw.itemid AND xteks_basicinfo_reccountry.listingoverviewid = nw.listingoverviewid AND xteks_basicinfo_reccountry.decimalcasesize
      = nw.casesize AND xteks_basicinfo_reccountry.supplierno = nw.supplierno AND xteks_basicinfo_reccountry.receivingcountry
    = nw.receivingcountry
 LEFT JOIN idq_production_eks.listingoverview AS list ON xteks_basicinfo_reccountry.listingoverviewid = list.listingoverviewid
  
 LEFT JOIN idq_production_eks.loheading AS loh ON list.loheadingid = loh.loheadingid
 LEFT JOIN idq_production_eks.translation_int AS trans_loh ON loh.descriptionid = trans_loh.translationid
 LEFT JOIN idq_production_eks.locategory AS loc ON list.locategoryid = loc.locategoryid
 LEFT JOIN idq_production_eks.translation_int AS trans_loc ON loc.descriptionid = trans_loc.translationid
WHERE stmara_eks_item.ziscurrentcontract = 1
 AND LOWER(IFNULL(trans_loc.description, '')) NOT LIKE '%filialbelieferung%'
 AND LOWER(IFNULL(trans_loh.description, '')) NOT LIKE '%dezentral%';