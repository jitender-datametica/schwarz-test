create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_DQ_EKS_MISSINGGEWART_SEL_2(
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
	TEXT_NAT,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as
  SELECT DISTINCT EKS_CALCULATION.stMARA_EKS_ITEM.zNegotiatingCountry as NegotiatingCountry,
                  EKS_CALCULATION.stMARA_EKS_ITEM.BuyerSHORTSIGN,
                  EKS_CALCULATION.stMARA_EKS_ITEM.BuyerFirstName,
                  EKS_CALCULATION.stMARA_EKS_ITEM.BuyerLastName,
                  EKS_CALCULATION.stMARA_EKS_ITEM.zMATKL,
                  EKS_CALCULATION.stMARA_EKS_ITEM.ArticleFamily,
                  EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID,
                  EKS_CALCULATION.stMARA_EKS_ITEM.ITEMNO,
                  EKS_CALCULATION.stMARA_EKS_ITEM.zArticleType as ArticleType,
                  EKS_CALCULATION.stMARA_EKS_ITEM.DESCRIPTION_INT AS Description,
                  EKS.ITEMDETAIL.TEXT_NAT,
                  EKS_CALCULATION.xtEKS_BASICINFO_RecCountry.zIsWAWIRelevant AS zRelevantMDM,
                  EKS_CALCULATION.stMARA_EKS_ITEM.zSource,
                  EKS_CALCULATION.stMARA_EKS_ITEM.zActive
  from   EKS_CALCULATION.stMARA_EKS_ITEM_2
         inner join EKS_CALCULATION.xtEKS_BASICINFO_RecCountry_2
                 on EKS_CALCULATION.stMARA_EKS_ITEM.itemid = EKS_CALCULATION.xtEKS_BASICINFO_RecCountry.itemid
         left outer join EKS.ITEMDETAIL_2
                      on EKS_CALCULATION.stMARA_EKS_ITEM.itemid = EKS.ITEMDETAIL.itemid
  where  ( zactive = 1
            or ziscurrentcontract = 1
            or ziscurrentcontractfromSK = 1 )
         AND TEXT_INT IS NULL
         AND TEXT_NAT IS NOT NULL
         AND znegotiatingcountry NOT IN ( 'AT', 'DE', 'CH' );