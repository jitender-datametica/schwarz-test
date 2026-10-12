create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_BEGRU_UPDSEL(
	ITEMID,
	ZBEGRU,
	ZBEGRUNEW
) as
SELECT EKS_CALCULATION.STMARA_EKS_ITEM.ITEMID, zBEGRU,
         CASE zNegotiatingCountry
           WHEN 'NT' THEN 'INT'
           ELSE zNegotiatingCountry
         END AS zBEGRUNew
  FROM   EKS_CALCULATION.STMARA_EKS_ITEM
  WHERE  ( NOT ( CASE zNegotiatingCountry
                   WHEN 'NT' THEN 'INT'
                   ELSE zNegotiatingCountry
                 END IS NULL ) );