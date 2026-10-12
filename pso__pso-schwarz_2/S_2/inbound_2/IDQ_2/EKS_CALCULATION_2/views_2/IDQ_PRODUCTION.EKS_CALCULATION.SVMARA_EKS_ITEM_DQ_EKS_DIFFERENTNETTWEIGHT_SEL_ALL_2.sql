create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_DQ_EKS_DIFFERENTNETTWEIGHT_SEL_ALL_2(
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
	GEBINDE_ANZAHL,
	GEBINDE_INHALT,
	GEBINDE_EINHEIT,
	GEBINDE_VERPAKUNG,
	NETWEIGHT,
	ZUSATZ_GEW_ART_INT,
	ZUSATZ_GEW_ART_NAT,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as SELECT DISTINCT
                  zNegotiatingCountry AS NegotiatingCountry,
				  BuyerSHORTSIGN, BuyerFirstName,
				  BuyerLastName, zMATKL, ArticleFamily,
				  ITEMID, ITEMNO, zArticleType AS ArticleType,
				  DESCRIPTION_INT AS Description, GEBINDE_ANZAHL,
                  GEBINDE_INHALT, GEBINDE_EINHEIT, GEBINDE_VERPAKUNG,
				  NETWEIGHT, ZUSATZ_GEW_ART_INT, ZUSATZ_GEW_ART_NAT,
				  zRelevantMDM, zSource, zActive
FROM     EKS_CALCULATION.svMARA_EKS_ITEM_DQ_EKS_DifferentNettWeight_010_2
WHERE  (ZUSATZ_GEW_ART_INT IS NOT NULL OR 	ZUSATZ_GEW_ART_NAT IS NOT NULL AND zNegotiatingCountry NOT IN ('DE', 'AT', 'CH')) AND
				  ((GEBINDE_ANZAHL <> 1) OR
                  (GEBINDE_INHALT <> 1) OR
                  (lower(GEBINDE_EINHEIT) <> 'kg') OR
                 NOT (IFNULL(NETWEIGHT, 0) = 1) AND ( (ITEMID not IN
                      (SELECT ITEMID
                       FROM EKS_CALCULATION.svMARA_EKS_ITEM_ItemsOnlyInExcludeList_2)) OR
                  (NETWEIGHT IS not NULL))) AND ( (GEBINDE_ANZAHL <> 1) OR
                  (GEBINDE_INHALT <> 1000) OR
                  (lower(GEBINDE_EINHEIT) <> 'g') OR
                  NOT (IFNULL(NETWEIGHT, 0) = 1) AND ( (ITEMID not IN
                      (SELECT ITEMID
                       FROM EKS_CALCULATION.svMARA_EKS_ITEM_ItemsOnlyInExcludeList_2 AS svMARA_EKS_ITEM_ItemsOnlyInExcludeList_2)) OR
                   (NETWEIGHT IS not NULL))) AND ((GEBINDE_ANZAHL <> 1) OR
                   (GEBINDE_INHALT <> 1) OR
                   (lower(GEBINDE_EINHEIT) <> 'lb') OR
                 NOT (IFNULL(NETWEIGHT, 0) = 1) AND ( (ITEMID not IN
                      (SELECT ITEMID
                       FROM EKS_CALCULATION.svMARA_EKS_ITEM_ItemsOnlyInExcludeList_2 AS svMARA_EKS_ITEM_ItemsOnlyInExcludeList_1)) OR
                  NOT (NETWEIGHT IS NULL)));