create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_NETTWEIGHT_DIFFERENT_PACKCONTENT_SEL(
	NEGOTIATINGCOUNTRY,
	BUYERSHORTSIGN,
	BUYERFIRSTNAME,
	BUYERLASTNAME,
	ZMATKL,
	ARTICLEFAMILY,
	ITEMID,
	ITEMNO,
	ARTICLETYPE,
	DESCRIPTION,
	ZZZ_QUANT_PACK_CONT,
	ZZZ_PACK_CONTENT,
	ZZZ_PACK_CONT_UOM,
	PACKAGEPACKAGING,
	EKS_NETTWEIGHT,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as
  SELECT svMARA_EKS_ITEM_NettWeight_Different_PackContent_Sel_ALL.NegotiatingCountry,
         BuyerSHORTSIGN,
         BuyerFirstName,
         BuyerLastName,
         zMATKL,
         ArticleFamily,
         svMARA_EKS_ITEM_NettWeight_Different_PackContent_Sel_ALL.ITEMID,
         svMARA_EKS_ITEM_NettWeight_Different_PackContent_Sel_ALL.ITEMNO,
         svMARA_EKS_ITEM_NettWeight_Different_PackContent_Sel_ALL.ArticleType,
         Description,
         zZZ_QUANT_PACK_CONT,
         Replace(Replace(zZZ_PACK_CONTENT, Char(10), ' '), Char(13), ' ') as zZZ_PACK_CONTENT,
         zZZ_PACK_CONT_UOM,
         PackagePackaging,
         EKS_NETTWEIGHT,
         svMARA_EKS_ITEM_NettWeight_Different_PackContent_Sel_ALL.zRelevantMDM,
         svMARA_EKS_ITEM_NettWeight_Different_PackContent_Sel_ALL.zSource,
         zActive
  FROM   EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_Sel_ALL
         LEFT OUTER JOIN EKS_CALCULATION.EKS_ZSM_ExcludeList
                      ON EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_Sel_ALL.ITEMNO = EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO
                         AND EKS_CALCULATION.EKS_ZSM_ExcludeList.REPORTNO = '021'
  WHERE EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO IS NULL;