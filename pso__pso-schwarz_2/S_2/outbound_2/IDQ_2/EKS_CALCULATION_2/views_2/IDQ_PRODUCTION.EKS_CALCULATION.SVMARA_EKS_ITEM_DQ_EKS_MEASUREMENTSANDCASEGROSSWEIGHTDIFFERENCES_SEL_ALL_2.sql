CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_dq_eks_measurementsandcasegrossweightdifferences_sel_all_2
AS WITH CNT AS (SELECT listingoverviewid,
   itemno,
   decimalcasesize
  FROM idq_production_eks_calculation.svmara_eks_item_dq_eks_measurementsandcasegrossweightdifferences_010_2
  WHERE conc <> ''
  GROUP BY listingoverviewid,
   itemno,
   decimalcasesize
  HAVING COUNT(DISTINCT conc) > 1 AND COUNT(DISTINCT receivingcountry) > 1) (SELECT DISTINCT EKS.znegotiatingcountry AS
   negotiatingcountry,
   EKS.buyershortsign,
   EKS.buyerfirstname,
   EKS.buyerlastname,
   EKS.zmatkl,
   EKS.articlefamily,
   EKS.itemid,
   EKS.itemno,
   EKS.zarticletype AS articletype,
   EKS.description_int,
   t4.decimalcasesize,
   EKS.casedepth,
   EKS.casewidth,
   EKS.caseheight,
   EKS.lengthunit,
   EKS.casegrossweight,
   EKS.weightunit,
   t4.listingoverviewid,
   EKS.supplierno,
   EKS.supplierdescription,
   EKS.receivingcountry,
   EKS.zrelevantmdm,
   EKS.zsource,
   EKS.zactive
  FROM CNT AS t4
   INNER JOIN idq_production_eks_calculation.svmara_eks_item_dq_eks_measurementsandcasegrossweightdifferences_010_2 AS EKS
   ON t4.itemno = EKS.itemno AND t4.decimalcasesize = EKS.decimalcasesize AND t4.listingoverviewid = EKS.listingoverviewid
     
  WHERE EKS.conc <> '');