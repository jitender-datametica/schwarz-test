create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_DQ_EKS_MEASUREMENTSANDCASEGROSSWEIGHTDIFFERENCES_SEL_ALL_2(
	NEGOTIATINGCOUNTRY,
	BUYERSHORTSIGN,
	BUYERFIRSTNAME,
	BUYERLASTNAME,
	ZMATKL,
	ARTICLEFAMILY,
	ITEMID,
	ITEMNO,
	ARTICLETYPE,
	DESCRIPTION_INT,
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
WITH cnt AS (SELECT LISTINGOVERVIEWID, ITEMNO, DecimalCaseSize
                          FROM      EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_010_2
                          WHERE   (conc <> '')
                          GROUP BY LISTINGOVERVIEWID, ITEMNO, DecimalCaseSize
                          HAVING  (COUNT(DISTINCT conc) > 1) AND (COUNT(DISTINCT ReceivingCountry) > 1))
    SELECT DISTINCT 
                      eks.zNegotiatingCountry AS NegotiatingCountry, 
					  eks.BuyerSHORTSIGN, 
					  eks.BuyerFirstName, 
					  eks.BuyerLastName, 
					  eks.zMATKL, 
					  eks.ArticleFamily, 
					  eks.ITEMID, 
					  eks.ITEMNO, 
					  eks.zArticleType AS ArticleType, 
					  eks.DESCRIPTION_INT, 
                      cnt.DecimalCaseSize, 
					  eks.CASEDEPTH, eks.CASEWIDTH, 
					  eks.CASEHEIGHT, 
					  eks.LengthUnit, 
					  eks.CASEGROSSWEIGHT, 
					  eks.WeightUnit, 
					  cnt.LISTINGOVERVIEWID, 
					  eks.SUPPLIERNO, 
					  eks.SupplierDescription, 
					  eks.ReceivingCountry, 
                      eks.zRelevantMDM, 
					  eks.zSource, 
					  eks.zActive
    FROM     cnt INNER JOIN
                      EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_MeasurementsAndCaseGrossWeightDifferences_010_2 AS eks ON eks.ITEMNO = cnt.ITEMNO AND eks.DecimalCaseSize = cnt.DecimalCaseSize AND 
                      eks.LISTINGOVERVIEWID = cnt.LISTINGOVERVIEWID
    WHERE  (eks.conc <> '');