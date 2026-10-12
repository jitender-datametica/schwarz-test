CREATE OR REPLACE VIEW idq_production_eks_calculation.steks_listingoverviewmax_alltime (listingoverviewid, location,
supplierno, cr_locationid, receivingcountry, itemid, casesize) AS SELECT MAX(listingoverview.listingoverviewid) AS
 listingoverviewid,
 location.shortsign AS location,
 supplier.supplierno,
 listingoverview.cr_locationid,
 steks_location_1.shortsign AS receivingcountry,
 listingitem.itemid,
 basicprice.casesizecalc AS casesize
FROM idq_production_eks.listingoverview
 INNER JOIN idq_production_eks.contractlink ON listingoverview.listingoverviewid = contractlink.listingoverviewid
 INNER JOIN idq_production_eks.supplier ON listingoverview.supplierno = supplier.supplierno
 INNER JOIN idq_production_eks.location ON listingoverview.cr_locationid = location.locationid
 INNER JOIN idq_production_eks.location AS steks_location_1 ON contractlink.locationid = steks_location_1.locationid
 INNER JOIN idq_production_eks.contractpricerel ON contractlink.contractlinkid = contractpricerel.contractlinkid
 INNER JOIN idq_production_eks.basicprice ON contractpricerel.basicpriceid = basicprice.basicpriceid
 INNER JOIN idq_production_eks.listingitem ON basicprice.listingitemid = listingitem.listingitemid
WHERE contractlink.statusid IN (34, 86)
GROUP BY supplier.supplierno,
 listingoverview.cr_locationid,
 location,
 receivingcountry,
 listingitem.itemid,
 casesize
HAVING supplier.supplierno <> 10236;