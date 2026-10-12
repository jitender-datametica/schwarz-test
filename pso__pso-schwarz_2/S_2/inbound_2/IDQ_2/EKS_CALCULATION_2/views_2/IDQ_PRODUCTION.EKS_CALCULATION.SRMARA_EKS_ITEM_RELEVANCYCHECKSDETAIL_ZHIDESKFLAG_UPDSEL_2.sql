create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_RELEVANCYCHECKSDETAIL_ZHIDESKFLAG_UPDSEL_2(
	UID,
	ITEMID,
	ITEMNO,
	ZHIDESKFLAG,
	ZHIDESKFLAGNEW
) as
SELECT UID,
         ITEMID,
         ITEMNO,
         zHideSKFlag,
         1 AS zHideSKFlagNew
  FROM   EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail_2
  WHERE  ( NOT ( zArticleType = 'EA' ) )
          OR ( NOT ( zIsCurrentContract = 0 ) );