create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_EAN_DUPLICATE_EAS_SEL_2(
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
	EAN_2,
	ADDITIONAL_GTIN,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as
(SELECT DISTINCT EKS_CALCULATION.stMARA_EKS_ITEM.zNegotiatingCountry                  AS NegotiatingCountry,
                         EKS_CALCULATION.stMARA_EKS_ITEM.BuyerSHORTSIGN,
                         EKS_CALCULATION.stMARA_EKS_ITEM.BuyerFirstName,
                         EKS_CALCULATION.stMARA_EKS_ITEM.BuyerLastName,
                         EKS_CALCULATION.stMARA_EKS_ITEM.zMATKL,
                         EKS_CALCULATION.stMARA_EKS_ITEM.ArticleFamily,
                         EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID,
                         EKS_CALCULATION.stMARA_EKS_ITEM.ITEMNO,
                         EKS_CALCULATION.stMARA_EKS_ITEM.zArticleType                         AS ArticleType,
                         EKS_CALCULATION.stMARA_EKS_ITEM.DESCRIPTION_INT                      AS Description,
                         EKS.ITEMEAN.EAN_2,
                         (SELECT  LISTAGG(concat(zNegotiatingCountry , '-' , a.zlegacymatnr),', ') within group( order by zNegotiatingCountry,zlegacymatnr)
                                FROM   EKS_CALCULATION.stMARA_EKS_ITEM_2 as a
                                       inner join EKS.ITEMEAN_2 as ean_2
                                               on a.ITEMID = ean.ITEMID
                                                  and ean.ean_2 = EKS.ITEMEAN.ean_2
                                                  and a.itemid <> EKS_CALCULATION.stMARA_EKS_ITEM.itemid)  AS ADDITIONAL_GTIN,
                         EKS_CALCULATION.svMARA_EKS_ITEM_EAN_Duplicate_03_Sel.zIsWAWIRelevant AS zRelevantMDM,
                         EKS_CALCULATION.stMARA_EKS_ITEM.zSource,
                         EKS_CALCULATION.stMARA_EKS_ITEM.zActive
  FROM   EKS_CALCULATION.svMARA_EKS_ITEM_EAN_Duplicate_03_Sel_2
         INNER JOIN EKS.ITEMEAN_2
                 ON EKS_CALCULATION.svMARA_EKS_ITEM_EAN_Duplicate_03_Sel.EAN_2 = EKS.ITEMEAN.EAN_2
         INNER JOIN EKS_CALCULATION.stMARA_EKS_ITEM_2
                 ON EKS.ITEMEAN.ITEMID = EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID
);