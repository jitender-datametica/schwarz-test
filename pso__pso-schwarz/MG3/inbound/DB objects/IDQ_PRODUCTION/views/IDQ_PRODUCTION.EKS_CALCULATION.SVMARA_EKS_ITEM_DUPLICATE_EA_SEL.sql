create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_DUPLICATE_EA_SEL(
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
	SK_ITEMNO,
	SK_SHORT_DESCRIPTION,
	BA_ITEMNO,
	BA_SHORT_DESCRIPTION,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as
(WITH cte_eks AS (SELECT ea.ITEMID    AS EA_ITEMID,
                  st_sk.ITEMID AS SK_ITEMID,
                  st_ba.ITEMID AS BA_ITEMID
           FROM   EKS_CALCULATION.stMARA_EKS_ITEM AS ea
                  INNER JOIN EKS.ITEMSORTING
                          ON ea.ITEMID = EKS.ITEMSORTING.ITEMID
                  INNER JOIN EKS_CALCULATION.stMARA_EKS_ITEM AS st_sk
                          ON EKS.ITEMSORTING.SORTITEMID = st_sk.ITEMID
                             AND st_sk.zArticleType = 'SK'
                             AND ea.zArticleType = 'EA'
                  INNER JOIN EKS.ITEMSORTING AS its_sk
                          ON st_sk.ITEMID = its_sk.ITEMID
                  INNER JOIN EKS_CALCULATION.stMARA_EKS_ITEM AS st_ba
                          ON its_sk.SORTITEMID = st_ba.ITEMID
                             AND st_ba.zArticleType = 'BA'
           UNION
           SELECT ea.ITEMID    AS EA_ITEMID,
                  NULL         AS Expr1,
                  st_ba.ITEMID AS BA_ITEMID
           FROM   EKS_CALCULATION.stMARA_EKS_ITEM AS ea
                  INNER JOIN EKS.ITEMSORTING AS stEKS_ITEMSORTING_1
                          ON ea.ITEMID = stEKS_ITEMSORTING_1.ITEMID
                             AND ea.zArticleType = 'EA'
                  INNER JOIN EKS_CALCULATION.stMARA_EKS_ITEM AS st_ba
                          ON stEKS_ITEMSORTING_1.SORTITEMID = st_ba.ITEMID
                             AND st_ba.zArticleType = 'BA')
  SELECT DISTINCT EKS_CALCULATION.stMARA_EKS_ITEM.zNegotiatingCountry AS NegotiatingCountry,
                           EKS_CALCULATION.stMARA_EKS_ITEM.BuyerSHORTSIGN,
                           EKS_CALCULATION.stMARA_EKS_ITEM.BuyerFirstName,
                           EKS_CALCULATION.stMARA_EKS_ITEM.BuyerLastName,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zMATKL,
                           EKS_CALCULATION.stMARA_EKS_ITEM.ArticleFamily,
                           EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID,
                           EKS_CALCULATION.stMARA_EKS_ITEM.ITEMNO,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zArticleType        AS ArticleType,
                           EKS_CALCULATION.stMARA_EKS_ITEM.DESCRIPTION_INT     AS Description,
                           st_sk.ITEMNO                            AS SK_ITEMNO,
                           st_sk.SHORTDESC_INT                     AS SK_Short_Description,
                           st_ba.ITEMNO                            AS BA_ITEMNO,
                           st_ba.SHORTDESC_INT                     AS BA_Short_Description,
                           case
                             when (st_sk.ITEMNO is not null) then st_sk.zRelevantMDM
                             ELSE EKS_CALCULATION.stMARA_EKS_ITEM.zRelevantMDM
                           END                                     AS zRelevantMDM,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zSource,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zActive
  FROM   EKS_CALCULATION.stMARA_EKS_ITEM
         INNER JOIN cte_eks AS eks_1
                 ON eks_1.EA_ITEMID = EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID
                    AND EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID IN (SELECT EA_ITEMID
                                                       FROM   cte_eks
                                                       GROUP  BY EA_ITEMID
                                                       HAVING ( Count(DISTINCT BA_ITEMID) > 1 ))
                    AND EKS_CALCULATION.stMARA_EKS_ITEM.Constructed IS NULL
                    AND ( EKS_CALCULATION.stMARA_EKS_ITEM.zIsCurrentContract = 1
                           OR EKS_CALCULATION.stMARA_EKS_ITEM.zIsCurrentContractFromSK = 1 )
         INNER JOIN EKS_CALCULATION.stMARA_EKS_ITEM AS st_ba
                 ON st_ba.ITEMID = eks_1.BA_ITEMID
         LEFT OUTER JOIN EKS_CALCULATION.stMARA_EKS_ITEM AS st_sk
                      ON st_sk.ITEMID = eks_1.SK_ITEMID
  where  EKS_CALCULATION.stMARA_EKS_ITEM.zActive = 1
  ORDER  BY EKS_CALCULATION.stMARA_EKS_ITEM.ITEMNO
);