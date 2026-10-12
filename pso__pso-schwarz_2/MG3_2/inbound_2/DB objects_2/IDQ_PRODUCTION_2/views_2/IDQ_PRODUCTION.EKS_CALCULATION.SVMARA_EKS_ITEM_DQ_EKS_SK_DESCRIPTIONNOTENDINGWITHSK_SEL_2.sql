create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_DQ_EKS_SK_DESCRIPTIONNOTENDINGWITHSK_SEL_2(
	NEGOTIATINGCOUNTRY,
	BUYERSHORTSIGN,
	BUYERFIRSTNAME,
	BUYERLASTNAME,
	ZMATKL,
	ARTICLEFAMILY,
	ITEMID,
	ITEMNO,
	ARTICLETYPE,
	SHORTDESC_INT,
	DESCRIPTION,
	SHORTDESC_NAT,
	DESCRIPTION_NAT,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as
(SELECT DISTINCT EKS_CALCULATION.stMARA_EKS_ITEM.zNegotiatingCountry AS NegotiatingCountry, EKS_CALCULATION.stMARA_EKS_ITEM.BuyerSHORTSIGN, EKS_CALCULATION.stMARA_EKS_ITEM.BuyerFirstName, EKS_CALCULATION.stMARA_EKS_ITEM.BuyerLastName, EKS_CALCULATION.stMARA_EKS_ITEM.zMATKL, EKS_CALCULATION.stMARA_EKS_ITEM.ArticleFamily, EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID, EKS_CALCULATION.stMARA_EKS_ITEM.ITEMNO, EKS_CALCULATION.stMARA_EKS_ITEM.zArticleType AS ArticleType, EKS_CALCULATION.stMARA_EKS_ITEM.SHORTDESC_INT, EKS_CALCULATION.stMARA_EKS_ITEM.DESCRIPTION_INT as Description, EKS_CALCULATION.stMARA_EKS_ITEM.SHORTDESC_NAT, EKS_CALCULATION.stMARA_EKS_ITEM.DESCRIPTION_NAT , EKS_CALCULATION.stMARA_EKS_ITEM.zRelevantMDM, EKS_CALCULATION.stMARA_EKS_ITEM.zSource, EKS_CALCULATION.stMARA_EKS_ITEM.zActive
FROM     EKS_CALCULATION.stMARA_EKS_ITEM_2 LEFT OUTER JOIN EKS_CALCULATION.EKS_ZSM_ExcludeList_2
                      ON EKS_CALCULATION.stMARA_EKS_ITEM.ITEMNO = EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO
                         AND EKS_CALCULATION.EKS_ZSM_ExcludeList.REPORTNO = '045' 
WHERE   ((zActive = 1) AND (Constructed IS NULL) AND (zArticleType = 'SK') 
AND (regexp_like(rtrim(description_int),'.*SK[1-9]')=0 AND regexp_like(rtrim(description_int),'.*SK[1-9][0-9]')=0 AND regexp_like(rtrim(description_int),'.*SK[1-9][0-9][0-9]')=0 OR regexp_like(rtrim(description_nat),'.*SK[1-9]')=0 AND regexp_like(rtrim(description_nat),'.*SK[1-9][0-9]')=0 AND regexp_like(rtrim(description_nat),'.*SK[1-9][0-9][0-9]')=0 OR regexp_like(rtrim(shortdesc_int),'.*SK[1-9]')=0 AND regexp_like(rtrim(shortdesc_int),'.*SK[1-9][0-9]')=0 AND regexp_like(rtrim(shortdesc_int),'.*SK[1-9][0-9][0-9]')=0 OR regexp_like(rtrim(shortdesc_nat),'.*SK[1-9]')=0 AND regexp_like(rtrim(shortdesc_nat),'.*SK[1-9][0-9]')=0 AND regexp_like(rtrim(shortdesc_nat),'.*SK[1-9][0-9][0-9]')=0)) and ( EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO IS NULL ) 
);