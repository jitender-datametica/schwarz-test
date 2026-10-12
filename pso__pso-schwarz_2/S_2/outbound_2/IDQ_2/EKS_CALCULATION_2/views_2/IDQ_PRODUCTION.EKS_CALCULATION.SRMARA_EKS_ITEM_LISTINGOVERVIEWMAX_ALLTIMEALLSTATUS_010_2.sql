CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_alltimeallstatus_010_2 AS WITH
 SVMARA_EKS_ITEM_LISTINGOVERVIEWMAX_ALLTIMEALLSTATUS_SEL AS (SELECT MAX(listingoverview.listingoverviewid) AS
   listingoverviewid,
   location.shortsign AS location_2,
   supplier.intsupplierno,
   listingoverview.cr_locationid,
   CAST(STEKS_LOCATION_1.shortsign AS STRING) AS receivingcountry,
   listingitem.itemid,
   CAST(basicprice.casesizecalc AS BIGNUMERIC) AS casesize
  FROM idq_production_eks.listingoverview_2
   INNER JOIN idq_production_eks.contractlink_2 ON listingoverview.listingoverviewid = contractlink.listingoverviewid
   INNER JOIN idq_production_eks.supplier_2 ON listingoverview.supplierno = supplier.supplierno
   INNER JOIN idq_production_eks.location_2 ON listingoverview.cr_locationid = location.locationid
   INNER JOIN idq_production_eks.location_2 AS STEKS_LOCATION_1 ON contractlink.locationid = STEKS_LOCATION_1.locationid
   INNER JOIN idq_production_eks.contractpricerel_2 ON contractlink.contractlinkid = contractpricerel.contractlinkid
   INNER JOIN idq_production_eks.basicprice_2 ON contractpricerel.basicpriceid = basicprice.basicpriceid
   INNER JOIN idq_production_eks.listingitem_2 ON basicprice.listingitemid = listingitem.listingitemid
  WHERE IFNULL(listingoverview.statusid, 0) <> 0
  GROUP BY supplier.intsupplierno,
   listingoverview.cr_locationid,
   location_2,
   STEKS_LOCATION_1.shortsign,
   listingitem.itemid,
   basicprice.casesizecalc
  HAVING supplier.intsupplierno <> 10236) (SELECT DISTINCT listingoverviewid,
   location_2,
   intsupplierno,
   cr_locationid,
   receivingcountry,
   itemid,
   CAST(ROUND(casesize, 0) AS INTEGER) AS casesize
  FROM SVMARA_EKS_ITEM_LISTINGOVERVIEWMAX_ALLTIMEALLSTATUS_SEL);