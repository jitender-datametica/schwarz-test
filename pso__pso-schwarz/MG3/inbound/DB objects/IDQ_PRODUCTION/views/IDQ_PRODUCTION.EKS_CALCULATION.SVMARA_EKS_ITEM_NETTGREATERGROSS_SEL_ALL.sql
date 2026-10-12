create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_NETTGREATERGROSS_SEL_ALL(
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
	ZACTIVE
) as		
	SELECT DISTINCT 
						  zNegotiatingCountry AS NegotiatingCountry, 
						  BuyerSHORTSIGN, 
						  BuyerFirstName, 
						  BuyerLastName, 
						  zMATKL, 
						  ArticleFamily, 
						  ITEMID, 
						  ITEMNO, 
						  zArticleType AS ArticleType, 
						  DESCRIPTION_INT AS Description, 
						  CaseNetweight AS Total_CaseNetweight, 
						  cast(CASEGROSSWEIGHT AS decimal(8, 3)) AS casegrossweight, 
						  DecimalCaseSize, 
						  LISTINGOVERVIEWID, 
						  INTSUPPLIERNO AS SUPPLIERNO, 
						  SupplierDescription, 
						  ReceivingCountry, 
						  zRelevantMDM,
						  zSource,
						  zActive
		FROM     EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_010
		WHERE  ((CASEGROSSWEIGHT <= CaseNetweight) OR
						  CASEGROSSWEIGHT IS NULL)
		UNION
		SELECT DISTINCT 
						  zNegotiatingCountry AS NegotiatingCountry, BuyerSHORTSIGN, BuyerFirstName, BuyerLastName, zMATKL, ArticleFamily, ITEMID, ITEMNO, zArticleType AS ArticleType, DESCRIPTION_INT AS Description, Total_CaseNetweight, 
						  CASEGROSSWEIGHT, DecimalCaseSize, LISTINGOVERVIEWID, INTSUPPLIERNO AS SUPPLIERNO, SupplierDescription, ReceivingCountry, zRelevantMDM, zSource, zActive
		FROM     EKS_CALCULATION.svMARA_EKS_ITEM_NettgreaterGross_020
		WHERE  ((CASEGROSSWEIGHT <= Total_CaseNetweight) OR
						  CASEGROSSWEIGHT IS NULL);