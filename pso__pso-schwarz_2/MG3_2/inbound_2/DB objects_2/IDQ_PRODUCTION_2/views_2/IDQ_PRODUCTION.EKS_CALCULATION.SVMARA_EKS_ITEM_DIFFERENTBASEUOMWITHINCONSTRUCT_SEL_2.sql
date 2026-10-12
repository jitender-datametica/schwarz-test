create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_DIFFERENTBASEUOMWITHINCONSTRUCT_SEL_2(
	NEGOTIATINGCOUNTRY,
	BUYERSHORTSIGN,
	BUYERFIRSTNAME,
	BUYERLASTNAME,
	ZMATKL,
	ARTICLEFAMILY,
	BA_ITEMNO,
	ITEMID,
	ITEMNO,
	ARTICLETYPE,
	DESCRIPTION,
	BUNDLEFACT,
	VOLUME,
	UNITDESCRIPTION,
	ZUSATZ_GEW_ART_INT,
	ZUSATZ_GEW_ART_NAT,
	BASEUOM,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as
  SELECT EKS_CALCULATION.stMARA_EKS_ITEM.zNegotiatingCountry AS NegotiatingCountry,
                           EKS_CALCULATION.stMARA_EKS_ITEM.BuyerSHORTSIGN,
                           EKS_CALCULATION.stMARA_EKS_ITEM.BuyerFirstName,
                           EKS_CALCULATION.stMARA_EKS_ITEM.BuyerLastName,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zMATKL,
                           EKS_CALCULATION.stMARA_EKS_ITEM.ArticleFamily,
                           BA.ITEMNO AS BA_ITEMNO,
                           EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID,
                           EKS_CALCULATION.stMARA_EKS_ITEM.ITEMNO,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zArticleType AS ArticleType,
                           EKS_CALCULATION.stMARA_EKS_ITEM.DESCRIPTION_INT AS Description,
                           ITD.BUNDLEFACT,
                           ITD.VOLUME,
                           TR.DESCRIPTION AS UnitDescription,
                           ITD.TEXT_INT AS ZUSATZ_GEW_ART_INT,
                           ITD.TEXT_NAT AS ZUSATZ_GEW_ART_NAT,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zMEINS AS BaseUoM,
                           case
                             when stMARA_EKS_ITEM.zIsCurrentContract = 1 then EKS_CALCULATION.stMARA_EKS_ITEM.zRelevantMDM
                             else sk.zRelevantMDM
                           end as zRelevantMDM,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zSource,
                           EKS_CALCULATION.stMARA_EKS_ITEM.zActive
  FROM   EKS_CALCULATION.stMARA_EKS_ITEM_2
         INNER JOIN EKS_CALCULATION.svMARA_EKS_ITEM_DifferentBaseUoM_01_2
                 ON EKS_CALCULATION.stMARA_EKS_ITEM.zITEM_BA = EKS_CALCULATION.svMARA_EKS_ITEM_DifferentBaseUoM_01.zITEM_BA
         INNER JOIN EKS_CALCULATION.stMARA_EKS_ITEM_2 AS BA
                 ON EKS_CALCULATION.svMARA_EKS_ITEM_DifferentBaseUoM_01.zITEM_BA = BA.ITEMID
         LEFT OUTER JOIN EKS.ITEMDETAIL_2 AS ITD
                      ON ITD.ITEMID = EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID
         LEFT OUTER JOIN EKS.UNIT_2 AS UN
                      ON UN.UNITID = ITD.UNITID
         LEFT OUTER JOIN EKS.TRANSLATION_INT_2 AS TR
                      ON TR.TRANSLATIONID = UN.SHORTDESCID
         left outer join (select xtEKS_BASICINFO_RecCountry.itemid,
                                 Min(stMARA_EKS_ITEM.zRelevantMDM) AS zRelevantMDM
                          from   xtEKS_BASICINFO_RecCountry_2
                                 inner join stMARA_EKS_ITEM_2
                                         on xtEKS_BASICINFO_RecCountry.SK_ITEMID = stMARA_EKS_ITEM.ITEMID
                          group  by xtEKS_BASICINFO_RecCountry.itemid) AS SK
                      on SK.itemid = stMARA_EKS_ITEM.ITEMID
  WHERE  (EKS_CALCULATION.stMARA_EKS_ITEM.zActive = 1 )
         AND (EKS_CALCULATION.stMARA_EKS_ITEM.zArticleType = 'EA')
  ORDER  BY EKS_CALCULATION.stMARA_EKS_ITEM.zITEM_BA;