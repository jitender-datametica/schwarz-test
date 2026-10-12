create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_XTEKS_BASICINFO_RECCOUNTRYALL_INSSEL_2(
	LISTINGOVERVIEWID,
	CASESIZE,
	ITEMID,
	ITEMNO,
	SK_ITEMID,
	SK_ITEMNO,
	SK_DESCRIPTION_INT,
	BASICPRICEUNIT,
	RECEIVINGCOUNTRY,
	SUPPLIERNO,
	BASICPRICEID,
	CONTRACTPRICERELID,
	CONTRACTLINKID,
	LOCATIONID,
	CONTRACTPRICEVALIDITYID,
	DECIMALCASESIZE
) as
with cte
       as (SELECT DISTINCT EKS_CALCULATION.STEKS_LISTINGOVERVIEWMAX.LISTINGOVERVIEWID,
                           EKS_CALCULATION.STEKS_LISTINGOVERVIEWMAX.CaseSize,
                           EKS_CALCULATION.STMARA_EKS_ITEM.ITEMID,
                           EKS_CALCULATION.STMARA_EKS_ITEM.ITEMNO,
                           EKS_CALCULATION.STMARA_EKS_ITEM.DESCRIPTION_INT                                                                                                                as SK_DESCRIPTION_INT,
                           EKS_CALCULATION.STEKS_TRANSLATION_INT_UNIT.DESCRIPTION                                                                                                         AS BasicPriceUnit,
                           ReceivingCountry,
                           EKS_CALCULATION.STEKS_LISTINGOVERVIEWMAX.SUPPLIERNO,
                           EKS.BASICPRICE.BASICPRICEID,
                           stMARA_EKS_ITEM.zarticletype,
                           EKS.CONTRACTPRICEREL.CONTRACTPRICERELID,
                           EKS.CONTRACTPRICEREL.CONTRACTLINKID,
                           EKS.CONTRACTLINK.LOCATIONID,
                           CONTRACTPRICEVALIDITYID,
                           ( TRY_TO_DECIMAL(CAST(CAST(EKS.BASICPRICE.SUBCASES as NUMBER(15,2)) * CAST( EKS.BASICPRICE.SUBCASESIZE as NUMBER(15,2)) as VARCHAR(255)), 6, 4) ) as DecimalCasesize
           FROM   EKS_CALCULATION.STMARA_EKS_ITEM_2
                  INNER JOIN EKS_CALCULATION.STEKS_LISTINGOVERVIEWMAX_2
                          ON EKS_CALCULATION.STEKS_LISTINGOVERVIEWMAX.ITEMID = EKS_CALCULATION.STMARA_EKS_ITEM.ITEMID
                  INNER JOIN EKS.LISTINGITEM_2
                          ON EKS.LISTINGITEM.LISTINGOVERVIEWID = EKS_CALCULATION.STEKS_LISTINGOVERVIEWMAX.LISTINGOVERVIEWID
                             AND EKS.LISTINGITEM.ITEMID = EKS_CALCULATION.STEKS_LISTINGOVERVIEWMAX.ITEMID
                  INNER JOIN EKS.BASICPRICE_2
                          ON EKS.LISTINGITEM.LISTINGITEMID = EKS.BASICPRICE.LISTINGITEMID
                             AND EKS.BASICPRICE.CASESIZECalc = EKS_CALCULATION.STEKS_LISTINGOVERVIEWMAX.CaseSize
                  INNER JOIN EKS.CONTRACTLINK_2
                          ON EKS_CALCULATION.STEKS_LISTINGOVERVIEWMAX.LISTINGOVERVIEWID = EKS.CONTRACTLINK.LISTINGOVERVIEWID
                  INNER JOIN EKS.CONTRACTPRICEREL_2
                          ON EKS.CONTRACTLINK.CONTRACTLINKID = EKS.CONTRACTPRICEREL.CONTRACTLINKID
                             AND EKS.BASICPRICE.BASICPRICEID = EKS.CONTRACTPRICEREL.BASICPRICEID
                  inner join EKS.CONTRACTPRICEVALIDITY_2
                          on EKS.CONTRACTPRICEVALIDITY.CONTRACTPRICERELID = EKS.CONTRACTPRICEREL.CONTRACTPRICERELID
                  INNER JOIN EKS.UNIT_2
                          ON EKS.BASICPRICE.UNITID = EKS.UNIT.UNITID
                  INNER JOIN EKS_CALCULATION.STEKS_TRANSLATION_INT_UNIT_2
                          ON EKS.UNIT.SHORTDESCID = EKS_CALCULATION.STEKS_TRANSLATION_INT_UNIT.TRANSLATIONID
                  inner JOIN EKS.LOCATION_2
                          ON EKS.CONTRACTLINK.LOCATIONID = EKS.LOCATION.LOCATIONID
                             AND EKS_CALCULATION.STEKS_LISTINGOVERVIEWMAX.ReceivingCountry = EKS.LOCATION.SHORTSIGN)
  -- get the EAs from the SKs that have a contract
  select cte.LISTINGOVERVIEWID,
         casesize,
         EKS.ITEM.itemid,
         EKS.ITEM.ITEMNO,
         cte.itemid             as SK_ITEMID,
         cte.itemno             as SK_ITEMNO,
         cte.SK_DESCRIPTION_INT as SK_DESCRIPTION_INT,
         BasicPriceUnit,
         ReceivingCountry,
         SUPPLIERNO,
         BASICPRICEID,
         CONTRACTPRICERELID,
         CONTRACTLINKID,
         LOCATIONID,
         CONTRACTPRICEVALIDITYID,
         DecimalCasesize
  from   cte
         inner join EKS.ITEMSORTING_2
                 on EKS.ITEMSORTING.SORTITEMID = cte.ITEMID
                    and cte.zArticleType = 'SK'
         inner join EKS.ITEM_2
                 on EKS.ITEMSORTING.itemid = EKS.ITEM.itemid
                    and EKS.ITEM.bitflag = '0'
  UNION ALL
  --get the EAs with a contract
  select cte.LISTINGOVERVIEWID,
         casesize,
         itemid,
         ITEMNO,
         null as SK_ITEMID,
         null as SK_ITEMNO,
         null as SK_DESCRIPTION_INT,
         BasicPriceUnit,
         ReceivingCountry,
         SUPPLIERNO,
         BASICPRICEID,
         CONTRACTPRICERELID,
         CONTRACTLINKID,
         LOCATIONID,
         CONTRACTPRICEVALIDITYID,
         DecimalCasesize
  from   cte
  where  cte.zArticleType = 'EA' 
;