create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_RELEVANCYCHECKSDETAIL_ZHIDEROWDUPLICATES_UPDSEL(
	UID,
	ITEMID,
	ITEMNO,
	ZHIDEROW,
	ZHIDEROWNEW
) as
SELECT EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail.UID,
         EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail.ITEMID,
         EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail.ITEMNO,
         EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail.zHideRow,
         1 AS zHideRowNew
  FROM   EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail
         INNER JOIN (SELECT ITEMID,
                            ITEMNO,
                            SK_ITEMNO,
                            Min(UID) AS Min_UID
                     FROM   EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail AS stMARA_EKS_ITEM_RelevancyChecksDetail_1
                     GROUP  BY ITEMID,
                               ITEMNO,
                               SK_ITEMNO) AS Min_UID
                 ON EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail.ITEMID = Min_UID.ITEMID
                    AND EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail.SK_ITEMNO = Min_UID.SK_ITEMNO
                    AND EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail.UID <> Min_UID.Min_UID
  WHERE  ( EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail.zActive = 1 )
         AND ( EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail.zIsCurrentContractFromSK = 1 )
         AND ( EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail.zIsCurrentContract IS NULL )
         AND ( EKS_CALCULATION.stMARA_EKS_ITEM_RelevancyChecksDetail.zArticleType = 'EA' ) ;