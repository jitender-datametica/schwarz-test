create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_CONTRACTTYPEDISPLAYISMISSING_SEL_1(
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
	CONTRACTDESC,
	LUHEADLINE,
	ARTICLEHEADLINE,
	CONTRACTHEADLINE,
	LISTINGOVERVIEWID,
	RECEIVINGCOUNTRY,
	SUPPLIERNO,
	SUPPLIERDESCRIPTION,
	BA_NUMBER,
	BA_DESCRIPTION,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as
  SELECT EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.NegotiatingCountry,
         BuyerSHORTSIGN,
         BuyerFirstName,
         BuyerLastName,
         zMATKL,
         ArticleFamily,
         EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.ITEMID,
         EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.ITEMNO,
         EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.ArticleType,
         Description,
         ContractDesc,
         LuHeadline,
         ArticleHeadline,
         ContractHeadline,
         EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.LISTINGOVERVIEWID,
         ReceivingCountry,
         EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.SUPPLIERNO,
         SupplierDescription,
         BA_NUMBER,
         BA_DESCRIPTION,
         zRelevantMDM,
         EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.zSource,
         zActive
  FROM   EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL_1
         LEFT OUTER JOIN EKS_CALCULATION.EKS_ZSM_ExcludeList_1
                      ON EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.ITEMNO = EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO
                         AND ( ( EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.SupplierNo = EKS_CALCULATION.EKS_ZSM_ExcludeList.SUPPLIERNO
                                 AND EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID IS NULL )
                                OR ( EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.LISTINGOVERVIEWID = EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID
                                     AND EKS_CALCULATION.EKS_ZSM_ExcludeList.SupplierNo IS NULL )
                                OR ( EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.SupplierNo = EKS_CALCULATION.EKS_ZSM_ExcludeList.SUPPLIERNO
                                     AND EKS_CALCULATION.svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.LISTINGOVERVIEWID = EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID )
                                OR ( EKS_CALCULATION.EKS_ZSM_ExcludeList.SupplierNo IS NULL
                                     AND EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID IS NULL ) )
                         AND EKS_CALCULATION.EKS_ZSM_ExcludeList.REPORTNO = '065'
  WHERE  ( EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO IS NULL )
         AND svMARA_EKS_ITEM_ContractTypeDisplayIsMissing_Sel_ALL.zActive = 1;