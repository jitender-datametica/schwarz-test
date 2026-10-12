create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_MESSURES_DIFF_BETW_ARTICLESSEL(
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
	LISTINGOVERVIEWID,
	CASESIZE,
	CASEHEIGHT,
	CASEWIDTH,
	CASEDEPTH,
	KOLLIVOLUMEN,
	AVGVOLUME,
	VOLUMEN_EINHEIT,
	PERCENTAGEVOLUME,
	SUPPLIERNO,
	SUPPLIERDESCRIPTION,
	RECEIVINGCOUNTRY,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as
  SELECT EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.NegotiatingCountry,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.BuyerSHORTSIGN,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.BuyerFirstName,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.BuyerLastName,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.zMATKL,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.ArticleFamily,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.BA_ITEMNO,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.ITEMID,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.ITEMNO,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.ArticleType,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.Description,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.listingoverviewid,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.CASESIZE,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.CASEHEIGHT,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.CASEWIDTH,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.CASEDEPTH,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.KolliVolumen,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.AvgVolume,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.VOLUMEN_EINHEIT,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.PercentageVolume,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.supplierNo,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.supplierDescription,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.ReceivingCountry,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.zRelevantMDM,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.zSource,
         EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.zActive
  FROM   EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL
         INNER JOIN 
		 EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_Counts
                 ON EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.listingoverviewid = EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_Counts.listingoverviewid
         LEFT OUTER JOIN 
		 EKS_CALCULATION.EKS_ZSM_ExcludeList
                      ON EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.ITEMNO = EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO
                         AND ( EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.supplierNo = EKS_CALCULATION.EKS_ZSM_ExcludeList.SUPPLIERNO
                               AND EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID IS NULL
                                OR EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.listingoverviewid = EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID
                                   AND EKS_CALCULATION.EKS_ZSM_ExcludeList.SUPPLIERNO IS NULL
                                OR EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.supplierNo = EKS_CALCULATION.EKS_ZSM_ExcludeList.SUPPLIERNO
                                   AND EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_ArticlesSel_ALL.listingoverviewid = EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID
                                OR EKS_CALCULATION.EKS_ZSM_ExcludeList.SUPPLIERNO IS NULL
                                   AND EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID IS NULL )
                         AND EKS_CALCULATION.EKS_ZSM_ExcludeList.REPORTNO = '028'
  WHERE  ( EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO IS NULL );