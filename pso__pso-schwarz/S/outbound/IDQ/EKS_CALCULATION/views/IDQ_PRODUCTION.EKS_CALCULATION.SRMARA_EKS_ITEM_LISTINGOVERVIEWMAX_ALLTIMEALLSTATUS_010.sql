CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_alltimeallstatus_010 AS WITH
 SVMARA_EKS_ITEM_LISTINGOVERVIEWMAX_ALLTIMEALLSTATUS_SEL AS (SELECT MAX(listingoverview.listingoverviewid) AS
   listingoverviewid,
   location.shortsign AS location,
   supplier.intsupplierno,
   listingoverview.cr_locationid,
   CAST(STEKS_LOCATION_1.shortsign AS STRING) AS receivingcountry,
   listingitem.itemid,
   CAST(basicprice.casesizecalc AS BIGNUMERIC) AS casesize
  FROM idq_production_eks.listingoverview
   INNER JOIN idq_production_eks.contractlink ON listingoverview.listingoverviewid = contractlink.listingoverviewid
   INNER JOIN idq_production_eks.supplier ON listingoverview.supplierno = supplier.supplierno
   INNER JOIN idq_production_eks.location ON listingoverview.cr_locationid = location.locationid
   INNER JOIN idq_production_eks.location AS STEKS_LOCATION_1 ON contractlink.locationid = STEKS_LOCATION_1.locationid
   INNER JOIN idq_production_eks.contractpricerel ON contractlink.contractlinkid = contractpricerel.contractlinkid
   INNER JOIN idq_production_eks.basicprice ON contractpricerel.basicpriceid = basicprice.basicpriceid
   INNER JOIN idq_production_eks.listingitem ON basicprice.listingitemid = listingitem.listingitemid
  WHERE IFNULL(listingoverview.statusid, 0) <> 0
  GROUP BY supplier.intsupplierno,
   listingoverview.cr_locationid,
   location,
   STEKS_LOCATION_1.shortsign,
   listingitem.itemid,
   basicprice.casesizecalc
  HAVING supplier.intsupplierno <> 10236) (SELECT DISTINCT listingoverviewid,
   location,
   intsupplierno,
   cr_locationid,
   receivingcountry,
   itemid,
   CAST(ROUND(casesize, 0) AS INTEGER) AS casesize
  FROM SVMARA_EKS_ITEM_LISTINGOVERVIEWMAX_ALLTIMEALLSTATUS_SEL);