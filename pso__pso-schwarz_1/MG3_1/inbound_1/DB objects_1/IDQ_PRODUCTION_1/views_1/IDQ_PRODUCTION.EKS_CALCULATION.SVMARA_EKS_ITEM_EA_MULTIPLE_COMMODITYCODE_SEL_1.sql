create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_EA_MULTIPLE_COMMODITYCODE_SEL_1(
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
	INTRASTAT,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as
  SELECT  EKS_CALCULATION.stMARA_EKS_ITEM.zNegotiatingCountry AS NegotiatingCountry,
                           EKS_CALCULATION.stMARA_EKS_ITEM.BuyerSHORTSIGN,
                           EKS_CALCULATION.stMARA_EKS_ITEM.BuyerFirstName,
                           EKS_CALCULATION.stMARA_EKS_ITEM.BuyerLastName,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zMATKL,
                           EKS_CALCULATION.stMARA_EKS_ITEM.ArticleFamily,
                           EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID,
                           EKS_CALCULATION.stMARA_EKS_ITEM.ITEMNO,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zArticleType        AS ArticleType,
                           EKS_CALCULATION.stMARA_EKS_ITEM.DESCRIPTION_INT     AS Description,
                           EKS.ITEMINTRASTAT.INTRASTAT,
                           case
                             when ( EKS_CALCULATION.stMARA_EKS_ITEM.zIsCurrentContractFromSK = 1
                                    AND EKS_CALCULATION.stMARA_EKS_ITEM.zIsCurrentContract = 0 ) then  sk.zRelevantMDM
                             ELSE EKS_CALCULATION.stMARA_EKS_ITEM.zRelevantMDM
                           END AS zRelevantMDM,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zSource,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zActive
  FROM   EKS.ITEMINTRASTAT_1
         INNER JOIN EKS_CALCULATION.stMARA_EKS_ITEM_1
                 ON EKS.ITEMINTRASTAT.ITEMID = EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID
         INNER JOIN EKS_CALCULATION.svMARA_EKS_ITEM_EA_Multiple_CommodityCode_01_Sel_1
                 ON EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID = EKS_CALCULATION.svMARA_EKS_ITEM_EA_Multiple_CommodityCode_01_Sel.ITEMID 
         left outer join (select EKS_CALCULATION.xtEKS_BASICINFO_RecCountry.itemid,
                                 Min(EKS_CALCULATION.stMARA_EKS_ITEM.zRelevantMDM) AS zRelevantMDM
                          from   EKS_CALCULATION.xtEKS_BASICINFO_RecCountry_1
                                 inner join EKS_CALCULATION.stMARA_EKS_ITEM_1
                                         on EKS_CALCULATION.xtEKS_BASICINFO_RecCountry.SK_ITEMID = EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID
                          group  by EKS_CALCULATION.xtEKS_BASICINFO_RecCountry.itemid) AS SK
                      on SK.itemid = EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID
  WHERE  ( EKS_CALCULATION.stMARA_EKS_ITEM.zIsCurrentContract = 1 )
          OR ( EKS_CALCULATION.stMARA_EKS_ITEM.zIsCurrentContractFromSK = 1 );