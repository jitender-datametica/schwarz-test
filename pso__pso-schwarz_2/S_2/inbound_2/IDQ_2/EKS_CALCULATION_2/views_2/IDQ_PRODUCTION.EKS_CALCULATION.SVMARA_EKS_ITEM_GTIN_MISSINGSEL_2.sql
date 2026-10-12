create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_GTIN_MISSINGSEL_2(
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
	SUPPLIERNO,
	SUPPLIERDESCRIPTION,
	LISTINGOVERVIEWID,
	RECEIVINGCOUNTRY,
	ZUSATZ,
	ITEMVALIDFROM,
	ITEMVALIDUNTIL,
	ZRELEVANTMDM,
	SUPPLIERCOUNTRY,
	ZSOURCE,
	ZACTIVE
) as
SELECT DISTINCT EKS_CALCULATION.STMARA_EKS_ITEM.zNegotiatingCountry AS NegotiatingCountry,
                  EKS_CALCULATION.STMARA_EKS_ITEM.BuyerSHORTSIGN,
                  EKS_CALCULATION.STMARA_EKS_ITEM.BuyerFirstName,
                  EKS_CALCULATION.STMARA_EKS_ITEM.BuyerLastName,
                  EKS_CALCULATION.STMARA_EKS_ITEM.zMATKL,
                  EKS_CALCULATION.STMARA_EKS_ITEM.ArticleFamily,
                  EKS_CALCULATION.STMARA_EKS_ITEM.ITEMID,
                  EKS_CALCULATION.STMARA_EKS_ITEM.ITEMNO,
                  EKS_CALCULATION.STMARA_EKS_ITEM.zArticleType        AS ArticleType,
                  EKS_CALCULATION.STMARA_EKS_ITEM.DESCRIPTION_INT     AS Description,
                  v.INTSUPPLIERNO                         as SupplierNo,
                  v.description                         as SupplierDescription,
                  LISTINGOVERVIEWID,
                  ReceivingCountry,
                  TR_VAL.DESCRIPTION                      as Zusatz,
                  EKS.CONTRACTPRICEVALIDITY.DATEFROM    as ItemValidFrom,
                  EKS.CONTRACTPRICEVALIDITY.DATEUNTIL   as ItemValidUntil,
                  --st_sk.zRelevantMDM as sk_zRelevantMDM,
                  --EKS_CALCULATION.STMARA_EKS_ITEM.zRelevantMDM  as ea_zrelevantMDM, 
                  --case when sk_itemno is null then EKS_CALCULATION.STMARA_EKS_ITEM.zRelevantMDM else st_sk.zRelevantMDM end as zRelevantMDM, 
                  eks.zIsWAWIRelevant                     AS zRelevantMDM,
                  case
                    when loc.shortsign = 'INT' then 'NT'
                    else loc.SHORTSIGN
                  end                                     as SupplierCountry,
                  EKS_CALCULATION.STMARA_EKS_ITEM.zSource,
                  EKS_CALCULATION.STMARA_EKS_ITEM.zActive
  FROM   EKS_CALCULATION.STMARA_EKS_ITEM_2
         LEFT OUTER JOIN EKS.ITEMEAN_2
                      ON EKS_CALCULATION.STMARA_EKS_ITEM.ITEMID = EKS.ITEMEAN.ITEMID
         INNER JOIN EKS_CALCULATION.XTEKS_BASICINFO_RECCOUNTRY_2 AS eks
                 ON eks.ITEMID = EKS_CALCULATION.STMARA_EKS_ITEM.ITEMID
         inner join EKS.CONTRACTPRICEVALIDITY_2
                 on eks.CONTRACTPRICEVALIDITYID = EKS.CONTRACTPRICEVALIDITY.CONTRACTPRICEVALIDITYID
         LEFT OUTER JOIN EKS.VALIDITY_2 as val
                      on EKS.CONTRACTPRICEVALIDITY.validityid = val.validityid
         LEFT OUTER JOIN EKS.TRANSLATION_INT_2 as TR_VAL
                      ON ( TR_VAL.TRANSLATIONID = VAL.DESCRIPTIONID )
         LEFT OUTER JOIN EKS.SUPPLIER_2 as v
                      on eks.SUPPLIERNO = v.SUPPLIERNO 
         --                LEFT OUTER JOIN stMARA_EKS_ITEM_2 as st_sk on st_sk.itemno = eks.SK_ITEMNO
         LEFT OUTER JOIN EKS.SUPPLIER_LOC_USE_2 SU
                      ON su.SUPPLIERNO = v.SUPPLIERNO
                         and su.cr_loc_flag = 1
         LEFT OUTER JOIN EKS.LOCATION_2 LOC
                      ON loc.LOCATIONID = su.locationid
  WHERE  ( EKS_CALCULATION.STMARA_EKS_ITEM.zActive = 1 )
         AND -- Change applied on 20.12.2019 to exclude the already excluded article
         ( ( EKS.ITEMEAN.EAN_2 IS NULL )
           AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zArticleType = 'EA' )
           AND ( EKS_CALCULATION.STMARA_EKS_ITEM.Constructed IS NULL )
           AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zIsCurrentContract = 1 )
           AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zMEINS <> 'KG' )
           AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zMEINS <> 'LB' )
           AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zMATKL <> 74 )
           AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zNegotiatingCountry <> 'NT' )
            OR ( EKS.ITEMEAN.EAN_2 IS NULL )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zArticleType = 'EA' )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.Constructed IS NULL )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zMEINS <> 'KG' )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zMEINS <> 'LB' )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zMATKL <> '74' )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zNegotiatingCountry <> 'NT' )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zIsCurrentContractFromSK = 1 )
            OR ( EKS.ITEMEAN.EAN_2 IS NULL )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zArticleType = 'EA' )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.Constructed IS NULL )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zIsCurrentContract = 1 )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zMEINS <> 'KG' )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zMEINS <> 'LB' )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zNegotiatingCountry = 'NT' )
            OR ( EKS.ITEMEAN.EAN_2 IS NULL )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zArticleType = 'EA' )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.Constructed IS NULL )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zMEINS <> 'KG' )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zMEINS <> 'LB' )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zNegotiatingCountry = 'NT' )
               AND ( EKS_CALCULATION.STMARA_EKS_ITEM.zIsCurrentContractFromSK = 1 ) )
         and EKS_CALCULATION.STMARA_EKS_ITEM.ITEMNO in (select itemno
                                            from   EKS_CALCULATION.XTEKS_BASICINFO_RECCOUNTRY_2
                                            where  ReceivingCountry <> 'KO')
         and EKS_CALCULATION.STMARA_EKS_ITEM.ITEMID not in (select itemid
                                                from   EKS.ITEMPLU_2)
         AND EKS_CALCULATION.STMARA_EKS_ITEM.zNegotiatingCountry = loc.SHORTSIGN;