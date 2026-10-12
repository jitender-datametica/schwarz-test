create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_DQ_EKS_MEASUREMENTSANDCASEGROSSWEIGHTDIFFERENCES_SEL_1(
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
	DECIMALCASESIZE,
	CASEDEPTH,
	CASEWIDTH,
	CASEHEIGHT,
	LENGTHUNIT,
	CASEGROSSWEIGHT,
	WEIGHTUNIT,
	LISTINGOVERVIEWID,
	SUPPLIERNO,
	SUPPLIERDESCRIPTION,
	RECEIVINGCOUNTRY,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as
  SELECT EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.NegotiatingCountry,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.BuyerShortsign,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.BuyerFirstName,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.BuyerLastName,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.zMATKL,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.ArticleFamily,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.ITEMID,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.ITEMNO,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.ArticleType,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.DESCRIPTION_INT AS DESCRIPTION,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.decimalCaseSize,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.CASEDEPTH,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.CASEWIDTH,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.CASEHEIGHT,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.LengthUnit,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.CASEGROSSWEIGHT,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.WeightUnit,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.LISTINGOVERVIEWID,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.SUPPLIERNO,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.SupplierDescription,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.ReceivingCountry,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.zRelevantMDM,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.zSource,
         EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.zActive
  FROM   EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL_1
         LEFT OUTER JOIN EKS_CALCULATION.EKS_ZSM_ExcludeList_1
                      ON EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.ITEMNO = EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO
                         AND ( EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.SUPPLIERNO = EKS_CALCULATION.EKS_ZSM_ExcludeList.SUPPLIERNO
                               AND EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID IS NULL
                                OR EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.LISTINGOVERVIEWID = EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID
                                   AND EKS_CALCULATION.EKS_ZSM_ExcludeList.SUPPLIERNO IS NULL
                                OR EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.SUPPLIERNO = EKS_CALCULATION.EKS_ZSM_ExcludeList.SUPPLIERNO
                                   AND EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_Sel_ALL.LISTINGOVERVIEWID = EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID
                                OR EKS_CALCULATION.EKS_ZSM_ExcludeList.SUPPLIERNO IS NULL
                                   AND EKS_CALCULATION.EKS_ZSM_ExcludeList.LISTINGOVERVIEWID IS NULL )
                         AND EKS_CALCULATION.EKS_ZSM_ExcludeList.REPORTNO = '018'
  WHERE  ( EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO IS NULL );