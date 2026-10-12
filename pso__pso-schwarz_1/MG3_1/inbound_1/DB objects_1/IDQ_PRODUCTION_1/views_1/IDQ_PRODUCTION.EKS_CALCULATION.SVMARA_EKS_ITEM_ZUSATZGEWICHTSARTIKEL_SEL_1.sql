create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_ZUSATZGEWICHTSARTIKEL_SEL_1(
	NEGOTIATINGCOUNTRY,
	BUYERSHORTSIGN,
	BUYERFIRSTNAME,
	BUYERLASTNAME,
	ZMATKL,
	ARTICLEFAMILY,
	SK_ITEMNO,
	SK_DESCRIPTION_INT,
	ITEMID,
	ITEMNO,
	ARTICLETYPE,
	DESCRIPTION,
	BUNDLEFACT,
	VOLUME,
	UNITDESCRIPTION,
	PACKAGEPACKAGING,
	TEXT_INT,
	TEXT_NAT,
	BASICPRICEUNIT,
	LISTINGOVERVIEWID,
	SUPPLIERNO,
	SUPPLIERDESCRIPTION,
	RECEIVINGCOUNTRY,
	ZRELEVANTMDM,
	ZSOURCE,
	ZACTIVE
) as SELECT DISTINCT EKS_CALCULATION.stMARA_EKS_ITEM.zNegotiatingCountry as NegotiatingCountry,
                  EKS_CALCULATION.stMARA_EKS_ITEM.BuyerSHORTSIGN,
                  EKS_CALCULATION.stMARA_EKS_ITEM.BuyerFirstName,
                  EKS_CALCULATION.stMARA_EKS_ITEM.BuyerLastName,
                  EKS_CALCULATION.stMARA_EKS_ITEM.zMATKL,
                  EKS_CALCULATION.stMARA_EKS_ITEM.ArticleFamily,
                  SK_ITEMNO,
                  SK_DESCRIPTION_INT,
                  EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID,
                  EKS_CALCULATION.stMARA_EKS_ITEM.ITEMNO,
                  EKS_CALCULATION.stMARA_EKS_ITEM.zArticleType as ArticleType,
                  EKS_CALCULATION.stMARA_EKS_ITEM.DESCRIPTION_INT AS Description,
                  BUNDLEFACT,
                  VOLUME,
                  ITDTR.DESCRIPTION as UnitDescription,
                  TR1.Description as PackagePackaging,
                  EKS.ITEMDETAIL.TEXT_INT,
                  EKS.ITEMDETAIL.TEXT_NAT,
                  BasicPriceUnit,
                  svMARA_EKS_ITEM_ZUSATZGEWICHTSARTIKEL010.LISTINGOVERVIEWID,
                  EKS.SUPPLIER.INTSUPPLIERNO as SupplierNo,
                  EKS.SUPPLIER.DESCRIPTION as SupplierDescription,
                  ReceivingCountry,
                  svMARA_EKS_ITEM_ZUSATZGEWICHTSARTIKEL010.zRelevantMDM,
                  EKS_CALCULATION.stMARA_EKS_ITEM.zSource,
                  EKS_CALCULATION.stMARA_EKS_ITEM.zActive
  FROM   EKS_CALCULATION.svMARA_EKS_ITEM_ZUSATZGEWICHTSARTIKEL010_1
         inner join EKS_CALCULATION.stMARA_EKS_ITEM_1
                 on svMARA_EKS_ITEM_ZUSATZGEWICHTSARTIKEL010.ITEMID = EKS_CALCULATION.stMARA_EKS_ITEM.ITEMID
         LEFT OUTER JOIN EKS.ITEMDETAIL_1
                      ON EKS_CALCULATION.svMARA_EKS_ITEM_ZUSATZGEWICHTSARTIKEL010.ITEMID = EKS.ITEMDETAIL.ITEMID
         LEFT OUTER JOIN EKS.UNIT_1 as ITDUNIT
                      ON ITDUNIT.UNITID = EKS.ITEMDETAIL.UNITID
         LEFT OUTER JOIN EKS.TRANSLATION_INT_1 as ITDTR
                      ON ITDUNIT.SHORTDESCID = ITDTR.TRANSLATIONID
         LEFT OUTER JOIN EKS.SUPPLIER_1
                      on svMARA_EKS_ITEM_ZUSATZGEWICHTSARTIKEL010.SUPPLIERNO = EKS.SUPPLIER.SUPPLIERNO
         LEFT OUTER JOIN EKS.PACKAGE_1
                      on EKS.PACKAGE.PACKAGEID = EKS.ITEMDETAIL.PACKAGEID
         LEFT OUTER JOIN EKS.TRANSLATION_INT_1 as TR1
                      on EKS.PACKAGE.SHORTDESCID = TR1.TRANSLATIONID 
  WHERE  ( ( EKS_CALCULATION.stMARA_EKS_ITEM.zActive = 1
              or EKS_CALCULATION.stMARA_EKS_ITEM.zIsCurrentContract = 1
              or EKS_CALCULATION.stMARA_EKS_ITEM.zIsCurrentContractFromSK = 1 )
           AND ( ( Upper(BasicPriceUnit) = 'KG'
                    OR Upper(BasicPriceUnit) = 'LB' )
                 AND ( ( EKS.ITEMDETAIL.TEXT_INT IS NULL
                         AND EKS.ITEMDETAIL.TEXT_NAT IS NULL )
 OR ( EKS.ITEMDETAIL.TEXT_INT IS NULL and EKS_CALCULATION.stMARA_EKS_ITEM.zNegotiatingCountry in ( 'CH', 'DE', 'AT' ) ) )
                  OR ( Upper(BasicPriceUnit) = 'STK.'
                       AND ( EKS.ITEMDETAIL.TEXT_INT IS NOT NULL
                              OR EKS.ITEMDETAIL.TEXT_NAT IS NOT NULL
                                 and EKS_CALCULATION.stMARA_EKS_ITEM.zNegotiatingCountry not in ( 'CH', 'DE', 'AT' ) ) )
                  OR ( Upper(BasicPriceUnit) = 'STK.'
                       AND ( EKS.ITEMDETAIL.TEXT_INT IS NOT NULL
and EKS_CALCULATION.stMARA_EKS_ITEM.zNegotiatingCountry in ( 'CH', 'DE', 'AT' ) ) ) OR ( Upper(BasicPriceUnit) NOT IN ( 'STK.', 'LB', 'KG' ) ) ) );