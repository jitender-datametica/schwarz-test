create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_ZACTIVE_ZISRELEVANTBYASSOCIATIONEASKBA_UPDSEL(
	ITEMID,
	ZACTIVE,
	ZACTIVENEW,
	ZISRELEVANTBYASSOCIATION,
	ZISRELEVANTBYASSOCIATIONNEW,
	ZITEM_BA
) as
SELECT distinct BA.ITEMID,
         BA.zActive,
         EA.zActive AS zActiveNew,
         BA.zIsRelevantByAssociation,
         1          AS zIsRelevantByAssociationNew,
         BA.zITEM_BA
  FROM   EKS_CALCULATION.STMARA_EKS_ITEM AS EA
         INNER JOIN EKS.ITEMSORTING
                 ON EA.ITEMID = EKS.ITEMSORTING.ITEMID
         INNER JOIN EKS_CALCULATION.STMARA_EKS_ITEM AS SK
                 ON EKS.ITEMSORTING.SORTITEMID = SK.ITEMID
         INNER JOIN EKS.ITEMSORTING AS stEKS_ITEMSORTING_1
                 ON SK.ITEMID = stEKS_ITEMSORTING_1.ITEMID
         INNER JOIN EKS_CALCULATION.STMARA_EKS_ITEM AS BA
                 ON stEKS_ITEMSORTING_1.SORTITEMID = BA.ITEMID
  WHERE  ( EA.BITFLAG = 0 )
         AND ( BA.BITFLAG = 2 )
         AND ( EA.zActive = 1 )
         AND ( SK.BITFLAG = 4 )
         AND ( SK.zActive = 1 )
         AND ( BA.zActive IS NULL )
         AND ( IFNULL(BA.zForceNotRelevant,0) = 0 )
          OR ( EA.BITFLAG = 0 )
             AND ( BA.BITFLAG = 2 )
             AND ( EA.zActive = 1 )
             AND ( SK.BITFLAG = 4 )
             AND ( BA.zActive IS NULL )
             AND ( EA.zActive = 1 )
             AND ( IFNULL(BA.zForceNotRelevant,0) = 0 );