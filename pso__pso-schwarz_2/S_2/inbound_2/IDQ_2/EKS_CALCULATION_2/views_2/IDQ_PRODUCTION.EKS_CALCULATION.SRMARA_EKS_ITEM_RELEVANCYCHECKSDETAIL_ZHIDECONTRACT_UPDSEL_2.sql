create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_RELEVANCYCHECKSDETAIL_ZHIDECONTRACT_UPDSEL_2(
	UID,
	ITEMID,
	ITEMNO,
	ZHIDECONTRACT,
	ZHIDECONTRACTNEW
) as
SELECT UID,
         ITEMID,
         ITEMNO,
         zHideContract,
         1 AS zHideContractNew
  FROM   EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail_2
  WHERE  ( zArticleType = 'EA' )
         AND ( zIsCurrentContractFromSK = 1 )
         AND ( CONTRACTPRICEVALIDITYID IS NULL )
          OR ( zArticleType = 'BA' );