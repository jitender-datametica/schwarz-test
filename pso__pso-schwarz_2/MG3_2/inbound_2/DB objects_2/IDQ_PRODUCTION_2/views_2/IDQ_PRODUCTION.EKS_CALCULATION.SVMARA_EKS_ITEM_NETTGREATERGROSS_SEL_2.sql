create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_NETTGREATERGROSS_SEL_2(
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
	TOTAL_CASENETWEIGHT,
	CASEGROSSWEIGHT,
	DECIMALCASESIZE,
	LISTINGOVERVIEWID,
	SUPPLIERNO,
	SUPPLIERDESCRIPTION,
	RECEIVINGCOUNTRY,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE,
	EXECUTION_TIME
) as
SELECT EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.NegotiatingCountry,
         EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.BuyerSHORTSIGN,
         EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.BuyerFirstName,
         EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.BuyerLastName,
         EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.zMATKL,
         EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.ArticleFamily,
         EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.ITEMID,
         EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.ITEMNO,
         EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.ArticleType,
         Description,
         Replace(Replace(Total_CaseNetweight, Char(10), ' '), Char(13), ' ') as Total_CaseNetweight,
         Replace(Replace(casegrossweight, Char(10), ' '), Char(13), ' ')     as Casegrossweight,
         Replace(Replace(DecimalCaseSize, Char(10), ' '), Char(13), ' ')     as DecimalCaseSize,
         EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.LISTINGOVERVIEWID,
         EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.SUPPLIERNO,
         SupplierDescription,
         ReceivingCountry,
         EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.zRelevantMDM,
         EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.zSource,
         zActive,
        EKS_CALCULATION.GETLASTEXECUTIONTIME()
  FROM   EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL_2
         LEFT OUTER JOIN EKS_CALCULATION.EKS_ZSM_ExcludeList_2 ON
EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.ITEMNO = EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO
AND ( ( EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.SupplierNo = EKS_CALCULATION.EKS_ZSM_ExcludeList.SUPPLIERNO
                                 AND EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID IS NULL )
                                OR ( EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.LISTINGOVERVIEWID = EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID
                                     AND EKS_CALCULATION.EKS_ZSM_ExcludeList.SupplierNo IS NULL )
                                OR ( EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.SupplierNo = EKS_CALCULATION.EKS_ZSM_ExcludeList.SUPPLIERNO
                                     AND EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_Sel_ALL.LISTINGOVERVIEWID = EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID )
                                OR ( EKS_CALCULATION.EKS_ZSM_ExcludeList.SupplierNo IS NULL
                                     AND EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID IS NULL ) )
                         AND EKS_CALCULATION.EKS_ZSM_ExcludeList.REPORTNO = '005'
  WHERE  ( EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO IS NULL )
         AND zActive = 1;