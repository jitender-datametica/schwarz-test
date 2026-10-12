CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_010_1 (listingoverviewid
, location_1, supplierno, cr_locationid, receivingcountry, itemid, casesize) AS SELECT MAX(LO.listingoverviewid) AS
 listingoverviewid,
 LOC.shortsign AS location_1,
 S.supplierno,
 LO.cr_locationid,
 RC.shortsign AS receivingcountry,
 LI.itemid,
 BP.casesizecalc AS casesize
FROM (SELECT supplierno,
   listingoverviewid,
   cr_locationid
  FROM idq_production_eks.listingoverview_1) AS LO
 INNER JOIN (SELECT listingoverviewid,
   locationid,
   contractlinkid
  FROM idq_production_eks.contractlink_1
  WHERE statusid IN (34, 86)) AS CONTRACTLINK_1 ON LO.listingoverviewid = CONTRACTLINK.listingoverviewid
 INNER JOIN (SELECT supplierno
  FROM idq_production_eks.supplier_1
  WHERE supplierno <> 10236) AS S ON LO.supplierno = S.supplierno
 INNER JOIN (SELECT locationid,
   shortsign
  FROM idq_production_eks.location_1) AS LOC ON LO.cr_locationid = LOC.locationid
 INNER JOIN (SELECT locationid,
   shortsign
  FROM idq_production_eks.location_1) AS RC ON CONTRACTLINK.locationid = RC.locationid
 INNER JOIN (SELECT contractlinkid,
   basicpriceid
  FROM idq_production_eks.contractpricerel_1) AS CPR ON CONTRACTLINK.contractlinkid = CPR.contractlinkid
 INNER JOIN (SELECT casesizecalc,
   basicpriceid,
   listingitemid
  FROM idq_production_eks.basicprice_1) AS BP ON CPR.basicpriceid = BP.basicpriceid
 INNER JOIN (SELECT itemid,
   listingitemid
  FROM idq_production_eks.listingitem_1) AS LI ON BP.listingitemid = LI.listingitemid
 INNER JOIN (SELECT DISTINCT znegotiatingcountry,
   itemid,
   itemno
  FROM idq_production_eks_calculation.stmara_eks_item_1
  WHERE zrelevantmdm = 1) AS mara_1 ON RC.shortsign = mara.znegotiatingcountry AND LI.itemid = mara.itemid
 INNER JOIN (SELECT DISTINCT SUBSTR(wawi_artikelnr, - 4, 4) AS wawi_artikelnr_suffix,
   eks_supplier_no,
   eks_artikel_nr
  FROM idq_production_eks_calculation.wawi_mdm_relevant_articles_1) AS wawi ON BP.casesizecalc = CAST(wawi.wawi_artikelnr_suffix AS FLOAT64)
     AND LO.supplierno = CAST(wawi.eks_supplier_no AS FLOAT64) AND mara.itemno = CAST(wawi.eks_artikel_nr AS FLOAT64)
GROUP BY S.supplierno,
 LO.cr_locationid,
 location_1,
 receivingcountry,
 LI.itemid,
 casesize
HAVING S.supplierno <> 10236;