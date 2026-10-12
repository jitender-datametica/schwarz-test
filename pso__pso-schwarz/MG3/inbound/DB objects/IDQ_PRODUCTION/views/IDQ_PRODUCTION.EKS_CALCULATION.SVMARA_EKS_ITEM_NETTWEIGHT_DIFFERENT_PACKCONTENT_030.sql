create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_NETTWEIGHT_DIFFERENT_PACKCONTENT_030(
	ZNEGOTIATINGCOUNTRY,
	ZITEM_BA,
	ZARTICLETYPE,
	ITEMNO,
	ITEMID,
	EKS_NETTWEIGHT,
	NETTWEIGHT_CALC,
	ZZZ_PACK_CONTENT_CONV,
	PACKAGEPACKAGING
) as
SELECT DISTINCT 
                  EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_020.zNegotiatingCountry, 
				  EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_020.zITEM_BA, 
                  EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_020.zArticleType, 
				  EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_020.ITEMNO, 
				  EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_020.ITEMID, 
                  EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_020.EKS_NETTWEIGHT,
				  EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_020.NETTWEIGHT_CALC, 
                  EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_010.zZZ_PACK_CONTENT_CONV, 
				  EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_010.PackagePackaging
FROM     EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_020 
INNER JOIN
    EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_010 
	ON EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_020.ITEMID = EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_010.ITEMID 
WHERE  
(ifnull(EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_020.NETTWEIGHT_CALC,-1) <> ifnull(EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_010.zZZ_PACK_CONTENT_CONV,-1)) 
OR (EKS_CALCULATION.svMARA_EKS_ITEM_NettWeight_Different_PackContent_010.NETWEIGHT IS NULL);