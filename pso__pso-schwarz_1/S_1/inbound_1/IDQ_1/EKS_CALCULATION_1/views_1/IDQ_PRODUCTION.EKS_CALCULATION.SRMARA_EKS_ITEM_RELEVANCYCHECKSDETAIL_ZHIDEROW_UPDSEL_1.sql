create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_RELEVANCYCHECKSDETAIL_ZHIDEROW_UPDSEL_1(
	UID,
	ITEMID,
	ITEMNO,
	ZHIDEROW,
	ZHIDEROWNEW,
	ZARTICLETYPE
) as
SELECT UID,
         ITEMID,
         ITEMNO,
         zHideRow,
         1 AS zHideRowNew,
         zArticleType
  FROM   EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail_1
  WHERE  ( zArticleType IN ( 'EA', 'SK' ) )
         AND ( zIsCurrentContract = 1 )
         AND ( CONTRACTPRICEVALIDITYID IS NULL );