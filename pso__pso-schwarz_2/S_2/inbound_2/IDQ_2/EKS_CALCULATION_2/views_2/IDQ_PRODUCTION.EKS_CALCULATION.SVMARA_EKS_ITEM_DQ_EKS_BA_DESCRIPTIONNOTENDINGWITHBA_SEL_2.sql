create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_DQ_EKS_BA_DESCRIPTIONNOTENDINGWITHBA_SEL_2(
	NEGOTIATINGCOUNTRY,
	BUYERSHORTSIGN,
	BUYERFIRSTNAME,
	BUYERLASTNAME,
	ZMATKL,
	ARTICLEFAMILY,
	ITEMID,
	ITEMNO,
	ARTICLETYPE,
	BA_BEZEICHNUNG_INT,
	DESCRIPTION,
	BA_BEZEICHNUNG_NAT,
	BA_BEZEICHNUNG_NAT_LONG,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as
(SELECT DISTINCT st_ba.zNegotiatingCountry AS NegotiatingCountry, st_ba.BuyerSHORTSIGN, st_ba.BuyerFirstName, st_ba.BuyerLastName, st_ba.zLegacyMATKL AS zMATKL, st_ba.ArticleFamily, st_ba.ITEMID, st_ba.ITEMNO, st_ba.zArticleType AS ArticleType, st_ba.SHORTDESC_INT AS BA_BEZEICHNUNG_INT, st_ba.DESCRIPTION_INT AS Description, IT.SHORTDESC_NAT AS BA_BEZEICHNUNG_NAT, IT.DESCRIPTION_NAT AS BA_BEZEICHNUNG_NAT_LONG, st_ba.zRelevantMDM, st_ba.zSource, st_ba.zActive
FROM     EKS_CALCULATION.stMARA_EKS_ITEM_2 AS st_ba INNER JOIN
EKS.ITEM_2 AS IT ON IT.ITEMID = st_ba.ITEMID AND st_ba.zArticleType = 'BA' AND st_ba.ConstructedFrom IS NULL INNER JOIN
EKS_CALCULATION.stMARA_EKS_ITEM_2 AS st_ea ON st_ba.zITEM_BA = st_ea.zITEM_BA AND st_ea.zArticleType = 'EA' AND (st_ea.zActive = 1 OR st_ea.zIsCurrentContract = 1 OR st_ea.zIsCurrentContractFromSK = 1) LEFT OUTER JOIN
EKS_CALCULATION.stMARA_EKS_ITEM_2 AS st_sk ON st_ba.zITEM_BA = st_sk.zITEM_BA AND st_sk.zArticleType = 'SK' AND st_sk.ConstructedFrom IS NULL AND (st_sk.zActive = 1 OR st_sk.zIsCurrentContract = 1) LEFT OUTER JOIN
EKS.ITEMBUYEREL_2 AS ITB ON ITB.ITEMID = st_ea.ITEMID AND  current_date() BETWEEN ITB.DATEFROM AND ITB.DATEUNTIL LEFT OUTER JOIN
EKS.EMPLOYEE_2 ON st_ea.BuyerID = EKS.EMPLOYEE.EMPLOYEEID LEFT OUTER JOIN
EKS_CALCULATION.EKS_ZSM_ExcludeList_2 ON st_ba.ITEMNO = EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO AND EKS_CALCULATION.EKS_ZSM_ExcludeList.REPORTNO = '044'
WHERE ((st_ba.zNegotiatingCountry <> 'GR') AND  (COLLATE(RIGHT(RTRIM(st_ba.SHORTDESC_INT), 2),'latin1_general_cs_as') <> 'BA' OR
COLLATE(RIGHT(RTRIM(st_ba.DESCRIPTION_INT), 2),'latin1_general_cs_as') <> 'BA' OR COLLATE(RIGHT(RTRIM(IT.SHORTDESC_NAT), 2),'latin1_general_cs_as') <> 'BA' OR COLLATE(RIGHT(RTRIM(IT.DESCRIPTION_NAT), 2),'latin1_general_cs_as') <> 'BA') OR (st_ba.zNegotiatingCountry = 'GR') AND (COLLATE(RIGHT(RTRIM(st_ba.SHORTDESC_INT), 2),'sql_latin1_general_CP1253_cs_as') <> 'ΒΑ' AND COLLATE(RIGHT(RTRIM(st_ba.SHORTDESC_INT), 2),'latin1_general_cs_as') <> 'BA' AND COLLATE(RIGHT(RTRIM(st_ba.SHORTDESC_INT), 2),'sql_latin1_general_CP1253_cs_as') <> 'BΑ' OR COLLATE(RIGHT(RTRIM(st_ba.DESCRIPTION_INT), 2),'sql_latin1_general_CP1253_cs_as') <> 'ΒΑ' AND COLLATE(RIGHT(RTRIM(st_ba.DESCRIPTION_INT), 2),'latin1_general_cs_as') <> 'BA' AND COLLATE(RIGHT(RTRIM(st_ba.DESCRIPTION_INT),2),'sql_latin1_general_CP1253_cs_as') <> 'BΑ' OR COLLATE(RIGHT(RTRIM(IT.SHORTDESC_NAT), 2),'sql_latin1_general_CP1253_cs_as') <> 'ΒΑ' AND COLLATE(RIGHT(RTRIM(IT.SHORTDESC_NAT), 2),'latin1_general_cs_as') <> 'BA' AND COLLATE(RIGHT(RTRIM(IT.SHORTDESC_NAT),2),'sql_latin1_general_CP1253_cs_as') <> 'BΑ' OR COLLATE(RIGHT(RTRIM(IT.DESCRIPTION_NAT), 2),'sql_latin1_general_CP1253_cs_as') <> 'ΒΑ' AND COLLATE(RIGHT(RTRIM(IT.DESCRIPTION_NAT), 2),'latin1_general_cs_as') <> 'BA' AND COLLATE(RIGHT(RTRIM(IT.DESCRIPTION_NAT),2),'sql_latin1_general_CP1253_cs_as') <> 'BΑ')) AND ( EKS_CALCULATION.EKS_ZSM_ExcludeList.ITEMNO IS NULL )
);