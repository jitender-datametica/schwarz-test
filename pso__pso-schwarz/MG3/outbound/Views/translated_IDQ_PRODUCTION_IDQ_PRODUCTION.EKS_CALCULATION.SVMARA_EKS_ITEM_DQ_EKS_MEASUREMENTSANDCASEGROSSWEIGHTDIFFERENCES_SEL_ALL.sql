CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_measurementsandcasegrossweightdifferences_sel_all
AS WITH cnt AS (SELECT listingoverviewid,
   itemno,
   decimalcasesize
  FROM idq_production_eks_calculation.svmara_eks_item_dq_eks_measurementsandcasegrossweightdifferences_010
  WHERE conc <> ''
  GROUP BY listingoverviewid,
   itemno,
   decimalcasesize
  HAVING COUNT(DISTINCT conc) > 1 AND COUNT(DISTINCT receivingcountry) > 1) (SELECT DISTINCT eks.znegotiatingcountry AS
   negotiatingcountry,
   eks.buyershortsign,
   eks.buyerfirstname,
   eks.buyerlastname,
   eks.zmatkl,
   eks.articlefamily,
   eks.itemid,
   eks.itemno,
   eks.zarticletype AS articletype,
   eks.description_int,
   t4.decimalcasesize,
   eks.casedepth,
   eks.casewidth,
   eks.caseheight,
   eks.lengthunit,
   eks.casegrossweight,
   eks.weightunit,
   t4.listingoverviewid,
   eks.supplierno,
   eks.supplierdescription,
   eks.receivingcountry,
   eks.zrelevantmdm,
   eks.zsource,
   eks.zactive
  FROM cnt AS t4
   INNER JOIN idq_production_eks_calculation.svmara_eks_item_dq_eks_measurementsandcasegrossweightdifferences_010 AS eks
   ON t4.itemno = eks.itemno AND t4.decimalcasesize = eks.decimalcasesize AND t4.listingoverviewid = eks.listingoverviewid
     
  WHERE eks.conc <> '');