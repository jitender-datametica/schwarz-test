CREATE OR REPLACE VIEW idq_production_eks_calculation.steks_listingoverviewmax_alltime_2 (listingoverviewid, location_2,
supplierno, cr_locationid, receivingcountry, itemid, casesize) AS SELECT MAX(listingoverview.listingoverviewid) AS
 listingoverviewid,
 location.shortsign AS location_2,
 supplier.supplierno,
 listingoverview.cr_locationid,
 STEKS_LOCATION_1.shortsign AS receivingcountry,
 listingitem.itemid,
 basicprice.casesizecalc AS casesize
FROM idq_production_eks.listingoverview_2
 INNER JOIN idq_production_eks.contractlink_2 ON listingoverview.listingoverviewid = contractlink.listingoverviewid
 INNER JOIN idq_production_eks.supplier_2 ON listingoverview.supplierno = supplier.supplierno
 INNER JOIN idq_production_eks.location_2 ON listingoverview.cr_locationid = location.locationid
 INNER JOIN idq_production_eks.location_2 AS STEKS_LOCATION_1 ON contractlink.locationid = STEKS_LOCATION_1.locationid
 INNER JOIN idq_production_eks.contractpricerel_2 ON contractlink.contractlinkid = contractpricerel.contractlinkid
 INNER JOIN idq_production_eks.basicprice_2 ON contractpricerel.basicpriceid = basicprice.basicpriceid
 INNER JOIN idq_production_eks.listingitem_2 ON basicprice.listingitemid = listingitem.listingitemid
WHERE contractlink.statusid IN (34, 86)
GROUP BY supplier.supplierno,
 listingoverview.cr_locationid,
 location_2,
 receivingcountry,
 listingitem.itemid,
 casesize
HAVING supplier.supplierno <> 10236;