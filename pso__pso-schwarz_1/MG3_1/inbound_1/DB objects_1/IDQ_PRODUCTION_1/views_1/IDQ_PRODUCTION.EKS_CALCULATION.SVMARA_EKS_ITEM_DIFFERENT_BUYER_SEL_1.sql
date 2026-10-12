create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_DIFFERENT_BUYER_SEL_1(
	NEGOTIATINGCOUNTRY,
	BUYERSHORTSIGN,
	BUYERFIRSTNAME,
	BUYERLASTNAME,
	ZMATKL,
	ARTICLEFAMILY,
	BA_ITEMNO,
	ITEMID,
	ITEMNO,
	ARTICLETYPE,
	DESCRIPTION,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as
 SELECT EKS_CALCULATION.svMARA_EKS_ITEM_Different_Buyer_Sel_ALL.NegotiatingCountry,
         BuyerSHORTSIGN,
         BuyerFirstName,
         BuyerLastName,
         zMATKL,
         ArticleFamily,
         BA_ITEMNO,
         EKS_CALCULATION.svMARA_EKS_ITEM_Different_Buyer_Sel_ALL.ITEMID,
         EKS_CALCULATION.svMARA_EKS_ITEM_Different_Buyer_Sel_ALL.ITEMNO,
         EKS_CALCULATION.svMARA_EKS_ITEM_Different_Buyer_Sel_ALL.ArticleType,
         Description,
         EKS_CALCULATION.svMARA_EKS_ITEM_Different_Buyer_Sel_ALL.zRelevantMDM,
         EKS_CALCULATION.svMARA_EKS_ITEM_Different_Buyer_Sel_ALL.zSource,
         zActive
  FROM   EKS_CALCULATION.svMARA_EKS_ITEM_Different_Buyer_Sel_ALL_1
         LEFT OUTER JOIN EKS_CALCULATION.EKS_ZSM_ExcludeList_1
                      ON EKS_CALCULATION.svMARA_EKS_ITEM_Different_Buyer_Sel_ALL.ITEMNO = EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO
                         AND EKS_CALCULATION.EKS_ZSM_ExcludeList.REPORTNO = '013'
  WHERE  ( EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO IS NULL );