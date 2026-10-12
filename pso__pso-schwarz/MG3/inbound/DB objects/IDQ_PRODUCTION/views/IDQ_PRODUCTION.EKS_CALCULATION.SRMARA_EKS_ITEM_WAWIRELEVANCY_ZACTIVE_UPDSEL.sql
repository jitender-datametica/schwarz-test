create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_WAWIRELEVANCY_ZACTIVE_UPDSEL(
	ITEMID,
	ITEMNO,
	ZNOMATCH,
	ZFULLMATCH_SK,
	ZFULLMATCH_EA,
	ZACTIVENEW
) as
WITH stMARA_WAWI_zRelevantMDM as (
    select   EKS_CALCULATION.STMARA_EKS_ITEM.itemid, EKS_CALCULATION.STMARA_EKS_ITEM.itemno, 
        EKS_CALCULATION.srMARA_EKS_ITEM_WAWIRelevancy_zFullMatchSK_010.zFullMatchNew as zFullMatch_SK, 
        EKS_CALCULATION.srMARA_EKS_ITEM_WAWIRelevancy_zFullMatchEA_010.zfullmatchnew as zFullMatch_EA, 
        EKS_CALCULATION.srMARA_EKS_ITEM_WAWIRelevancy_zNoMatch_010.zNoMatchNew as zNoMatch
    FROM   EKS_CALCULATION.STMARA_EKS_ITEM
      left outer join EKS_CALCULATION.srMARA_EKS_ITEM_WAWIRelevancy_zFullMatchSK_010
          on EKS_CALCULATION.STMARA_EKS_ITEM.itemid = EKS_CALCULATION.srMARA_EKS_ITEM_WAWIRelevancy_zFullMatchSK_010.itemid
          and EKS_CALCULATION.STMARA_EKS_ITEM.itemno = EKS_CALCULATION.srMARA_EKS_ITEM_WAWIRelevancy_zFullMatchSK_010.itemno
      left outer join EKS_CALCULATION.srMARA_EKS_ITEM_WAWIRelevancy_zFullMatchEA_010
          on EKS_CALCULATION.STMARA_EKS_ITEM.itemid = EKS_CALCULATION.srMARA_EKS_ITEM_WAWIRelevancy_zFullMatchEA_010.itemid
          and EKS_CALCULATION.STMARA_EKS_ITEM.itemno = EKS_CALCULATION.srMARA_EKS_ITEM_WAWIRelevancy_zFullMatchEA_010.itemno
      left outer join EKS_CALCULATION.srMARA_EKS_ITEM_WAWIRelevancy_zNoMatch_010
          on EKS_CALCULATION.STMARA_EKS_ITEM.itemid = EKS_CALCULATION.srMARA_EKS_ITEM_WAWIRelevancy_zNoMatch_010.itemid
          and EKS_CALCULATION.STMARA_EKS_ITEM.itemno = EKS_CALCULATION.srMARA_EKS_ITEM_WAWIRelevancy_zNoMatch_010.itemno
    where EKS_CALCULATION.STMARA_EKS_ITEM.zRelevantMDM = 1
)
SELECT   distinct ITEMID,
         ITEMNO,
         zNoMatch,
         zFullMatch_SK,
         zFullMatch_EA,
         1 AS zActiveNew
  FROM   stMARA_WAWI_zRelevantMDM
  WHERE  ( IFNULL(zFullMatch_SK,0) = 1 or IFNULL(zFullMatch_EA,0) = 1 )
         or ( IFNULL(zNoMatch,0) = 1 ) ;