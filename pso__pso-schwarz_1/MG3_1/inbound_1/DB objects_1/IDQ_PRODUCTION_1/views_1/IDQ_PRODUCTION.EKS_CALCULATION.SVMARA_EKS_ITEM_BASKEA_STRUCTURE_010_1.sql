create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_BASKEA_STRUCTURE_010_1(
	BA_ITEMNO,
	BA_ARTICLETYPE,
	BA_DESCRIPTION,
	SK_ITEMNO,
	SK_ARTICLETYPE,
	SK_DESCRIPTION,
	SK_ACTIVE,
	SK_CONTRACT,
	EA_ITEMNO,
	EA_ITEMID,
	EA_DESCRIPTION,
	ZARTICLETYPE
) as
SELECT        CASE WHEN st_sk.zArticleType = 'BA' THEN st_sk.itemno ELSE st_ba.itemno END AS BA_ITEMNO, CASE WHEN st_sk.zArticleType = 'BA' THEN st_sk.zArticleType ELSE st_ba.zArticleType END AS BA_ArticleType, 
                         CASE WHEN st_sk.zArticleType = 'BA' THEN st_sk.DESCRIPTION_INT ELSE st_ba.DESCRIPTION_INT END AS BA_Description, CASE WHEN st_sk.zArticleType = 'SK' THEN st_sk.itemno ELSE NULL END AS SK_ITEMNO, 
                         CASE WHEN st_sk.zArticleType = 'SK' THEN st_sk.zArticleType ELSE NULL END AS SK_ArticleType, CASE WHEN st_sk.zArticleType = 'SK' THEN st_sk.DESCRIPTION_INT ELSE NULL END AS SK_Description, 
                         CASE WHEN st_sk.zArticleType = 'SK' THEN st_sk.zactive ELSE NULL END AS SK_Active, CASE WHEN st_sk.zArticleType = 'SK' THEN st_sk.zIsCurrentContract ELSE NULL END AS SK_contract, st_ea.ITEMNO AS EA_ITEMNO, 
                         st_ea.ITEMID AS EA_ITEMID, st_ea.DESCRIPTION_INT AS EA_DESCRIPTION, st_ea.zArticleType
FROM            
				EKS_CALCULATION.STMARA_EKS_ITEM_1 AS st_ea LEFT OUTER JOIN
                EKS.ITEMSORTING_1 AS eks_sk ON st_ea.ITEMID = eks_sk.ITEMID LEFT OUTER JOIN
                EKS_CALCULATION.STMARA_EKS_ITEM_1 AS st_sk ON st_sk.ITEMID = eks_sk.SORTITEMID LEFT OUTER JOIN
                EKS.ITEMSORTING_1 AS eks_ba ON st_sk.ITEMID = eks_ba.ITEMID LEFT OUTER JOIN
                         EKS_CALCULATION.STMARA_EKS_ITEM_1 AS st_ba ON st_ba.ITEMID = eks_ba.SORTITEMID
WHERE        (st_ea.zIsCurrentContract = 1) AND (st_ea.zArticleType = 'EA') OR
                         (st_ea.zArticleType = 'EA') AND (st_ea.zIsCurrentContractFromSK = 1);