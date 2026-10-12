CREATE OR REPLACE VIEW idq_production_eks_calculation.steks_listingoverviewmax_alltime_1 (listingoverviewid, location_1,
supplierno, cr_locationid, receivingcountry, itemid, casesize) AS SELECT MAX(listingoverview.listingoverviewid) AS
 listingoverviewid,
 location.shortsign AS location_1,
 supplier.supplierno,
 listingoverview.cr_locationid,
 steks_location_1.shortsign AS receivingcountry,
 listingitem.itemid,
 basicprice.casesizecalc AS casesize
FROM idq_production_eks.listingoverview_1
 INNER JOIN idq_production_eks.contractlink_1 ON listingoverview.listingoverviewid = contractlink.listingoverviewid
 INNER JOIN idq_production_eks.supplier_1 ON listingoverview.supplierno = supplier.supplierno
 INNER JOIN idq_production_eks.location_1 ON listingoverview.cr_locationid = location.locationid
 INNER JOIN idq_production_eks.location_1 AS steks_location_1 ON contractlink.locationid = steks_location_1.locationid
 INNER JOIN idq_production_eks.contractpricerel_1 ON contractlink.contractlinkid = contractpricerel.contractlinkid
 INNER JOIN idq_production_eks.basicprice_1 ON contractpricerel.basicpriceid = basicprice.basicpriceid
 INNER JOIN idq_production_eks.listingitem_1 ON basicprice.listingitemid = listingitem.listingitemid
WHERE contractlink.statusid IN (34, 86)
GROUP BY supplier.supplierno,
 listingoverview.cr_locationid,
 location_1,
 receivingcountry,
 listingitem.itemid,
 casesize
HAVING supplier.supplierno <> 10236;