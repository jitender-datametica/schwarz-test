create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_XTEKS_BASICINFO_UNION_INSSEL_2(
	LISTINGOVERVIEWID,
	CASESIZE,
	ITEMID,
	BASICPRICEID,
	CONTRACTPRICEVALIDITYID,
	ZARTICLETYPE,
	RECEIVINGCOUNTRY
) as
SELECT DISTINCT LISTINGOVERVIEWID,
                  casesize,
                  itemid,
                  BASICPRICEID,
                  CONTRACTPRICEVALIDITYID,
                  'EA' AS zArticleType,
                  ReceivingCountry
  FROM   EKS_CALCULATION.XTEKS_BASICINFO_RECCOUNTRY_2
  WHERE  ( zIsValidContract = 1 )
         AND sk_itemid IS NULL
  UNION
  SELECT DISTINCT LISTINGOVERVIEWID,
                  casesize,
                  sk_itemid AS itemid,
                  BASICPRICEID,
                  CONTRACTPRICEVALIDITYID,
                  'SK'     AS zArticleType,
                  ReceivingCountry
  FROM   EKS_CALCULATION.XTEKS_BASICINFO_RECCOUNTRY_2
  WHERE  ( zIsValidContract = 1 )
         AND sk_itemid IS NOT NULL
;