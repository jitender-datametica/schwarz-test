create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SVMARA_EKS_ITEM_ITEMSONLYINEXCLUDELIST(
	ITEMID
) as
SELECT FullList.ITEMID
FROM  
   (SELECT ITEMID, COUNT(0) AS cnt
                  FROM EKS_CALCULATION.svMARA_EKS_ITEM_EA_ReceivingCountry
                  WHERE (ReceivingCountry IN('US','LX','EW','CH'))
                  GROUP BY ITEMID) AS ExcludeList INNER JOIN
                      (SELECT ITEMID, COUNT(0) AS cnt
                       FROM EKS_CALCULATION.svMARA_EKS_ITEM_EA_ReceivingCountry AS svMARA_EKS_ITEM_EA_ReceivingCountry_1
                       GROUP BY ITEMID) AS FullList ON ExcludeList.ITEMID = FullList.ITEMID AND ExcludeList.cnt = FullList.cnt;