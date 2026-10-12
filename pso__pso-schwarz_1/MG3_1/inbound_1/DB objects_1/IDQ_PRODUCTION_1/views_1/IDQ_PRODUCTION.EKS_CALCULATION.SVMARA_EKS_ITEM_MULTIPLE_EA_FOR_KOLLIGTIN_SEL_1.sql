create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_MULTIPLE_EA_FOR_KOLLIGTIN_SEL_1(
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
	KOLLIGTIN,
	EAS,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE,
	ZNEGOTIATINGCOUNTRY
) as
(SELECT EKS_CALCULATION.stMARA_EKS_ITEM.zNegotiatingCountry as NegotiatingCountry,
         EKS_CALCULATION.stMARA_EKS_ITEM.BuyerSHORTSIGN,
         EKS_CALCULATION.stMARA_EKS_ITEM.BuyerFirstName,
         EKS_CALCULATION.stMARA_EKS_ITEM.BuyerLastName,
         EKS_CALCULATION.stMARA_EKS_ITEM.zMATKL,
         EKS_CALCULATION.stMARA_EKS_ITEM.ArticleFamily,
         EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID,
         EKS_CALCULATION.stMARA_EKS_ITEM.ITEMNO,
         EKS_CALCULATION.stMARA_EKS_ITEM.zArticleType        as ArticleType,
         EKS_CALCULATION.stMARA_EKS_ITEM.DESCRIPTION_INT     AS Description,
         GTIN                                    as KolliGTIN,
         (SELECT LISTAGG(concat( a.zNegotiatingCountry , '-', Cast( a.itemno as varchar(50) )),', ') within group( order by a.zNegotiatingCountry,a.itemno) as EA_S
                FROM   stMARA_EKS_ITEM_1 as a
                       INNER JOIN EKS.ITEM_1 AS IT
                               ON ( a.ITEMID = IT.ITEMID )
                                  AND IT.BRANDTYPEID = 1
                       inner join eks.itemgtin_1 as gtin
                               on a.ITEMID = gtin.ITEMID
                                  and gtin.gtin = itg.gtin
                                  and a.itemid <> EKS_CALCULATION.stMARA_EKS_ITEM.itemid
                                  and gtin.NO_GTIN = 0
                                  and a.zArticleType = 'EA'
                                  and ( a.zactive = 1
                                         or a.zIsCurrentContract = 1
                                         or EKS_CALCULATION.stMARA_EKS_ITEM.zIsCurrentContractFromSK = 1 )   )    AS EAs,
           Case
           when ( stMARA_EKS_ITEM.zIsCurrentContractFromSK = 1
                  AND stMARA_EKS_ITEM.zIsCurrentContract = 0 ) then sk.zRelevantMDM
           ELSE stMARA_EKS_ITEM.zRelevantMDM
         END                                     AS zRelevantMDM,
         EKS_CALCULATION.stMARA_EKS_ITEM.zSource,
         EKS_CALCULATION.stMARA_EKS_ITEM.zActive,
         EKS_CALCULATION.stMARA_EKS_ITEM.zNegotiatingCountry
  FROM   EKS_CALCULATION.stMARA_EKS_ITEM_1
         INNER JOIN EKS.ITEM_1 AS IT
                 ON ( EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID = IT.ITEMID )
                    AND IT.BRANDTYPEID = 1
         INNER JOIN eks.itemgtin_1 as ITG
                 ON ( ITG.ITEMID = EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID )
         left outer join (select xtEKS_BASICINFO_RecCountry.itemid,
                                 Min(cast( stMARA_EKS_ITEM.zRelevantMDM as varchar(1))) AS zRelevantMDM
                          from   EKS_CALCULATION.xtEKS_BASICINFO_RecCountry_1
                                 inner join EKS_CALCULATION.stMARA_EKS_ITEM_1
                                         on EKS_CALCULATION.xtEKS_BASICINFO_RecCountry.SK_ITEMID = EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID
                          group  by xtEKS_BASICINFO_RecCountry.itemid) AS SK
                      on SK.itemid = EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID
  where  EKS_CALCULATION.stMARA_EKS_ITEM.zArticleType = 'EA'
         and ( EKS_CALCULATION.stMARA_EKS_ITEM.zActive = 1
                or EKS_CALCULATION.stMARA_EKS_ITEM.zIsCurrentContract = 1
                or EKS_CALCULATION.stMARA_EKS_ITEM.zIsCurrentContractFromSK = 1 )
         and GTIN in (select GTIN
                      FROM   eks.itemgtin_1 as ITG1
                             INNER JOIN EKS_CALCULATION.stMARA_EKS_ITEM_1 as it1
                                     ON ( ITG1.ITEMID = it1.ITEMID )
                                        and ITG1.NO_GTIN = 0
                                        and ( it1.zactive = 1
                                               or it1.zIsCurrentContract = 1
                                               or it1.zIsCurrentContractFromSK = 1 )
                             INNER JOIN EKS.ITEM_1 AS IT2
                                     ON ( it1.ITEMID = IT2.ITEMID )
                                        AND IT2.BRANDTYPEID = 1
                      group  by itg1.GTIN
                      having Count(distinct it1.itemno) > 1) 
);