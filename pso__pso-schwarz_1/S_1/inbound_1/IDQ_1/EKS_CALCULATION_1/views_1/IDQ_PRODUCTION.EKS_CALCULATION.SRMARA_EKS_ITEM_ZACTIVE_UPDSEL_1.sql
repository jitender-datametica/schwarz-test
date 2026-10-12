create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_ZACTIVE_UPDSEL_1(
	ITEMID,
	ZACTIVE,
	ZISVALIDBITFLAG,
	ZISIN_USE,
	ZISFOOD,
	ZISCURRENTCONTRACT,
	ZISVALIDCONSTRUCT,
	ZACTIVENEW,
	ZARTICLETYPE,
	ZFORCERELEVANT,
	ZFORCENOTRELEVANT,
	ITEMNO
) as
SELECT EKS_CALCULATION.STMARA_EKS_ITEM.ITEMID,
         zActive,
         zIsValidBITFLAG,
         zIsIN_USE,
         zIsFood,
         zIsCurrentContract,
         zIsValidConstruct,
         CAST( ((IFNULL(( zIsValidBITFLAG and zIsFood and zIsValidConstruct ) and ( IFNULL(zIsIN_USE and zIsCurrentContract, 0) or IFNULL(zIsCurrentContractFromSK, 0) or IFNULL(zRelevantMDM, 0) ), 0) = 1) or (IFNULL(zForceRelevant, 0) = 1)) and (IFNULL(zForceNotRelevant, 0) = 0)  as NUMBER(38,0)) AS zActiveNew,
         zArticleType,
         zForceRelevant,
         zForceNotRelevant,
         ITEMNO
  FROM   EKS_CALCULATION.STMARA_EKS_ITEM_1
  WHERE  ( ((IFNULL(( zIsValidBITFLAG and zIsFood and zIsValidConstruct ) and ( IFNULL(zIsIN_USE and zIsCurrentContract, 0) or IFNULL(zIsCurrentContractFromSK, 0) or IFNULL(zRelevantMDM, 0) ), 0) = 1) or (IFNULL(zForceRelevant, 0) = 1)) and (IFNULL(zForceNotRelevant, 0) = 0) ) ;