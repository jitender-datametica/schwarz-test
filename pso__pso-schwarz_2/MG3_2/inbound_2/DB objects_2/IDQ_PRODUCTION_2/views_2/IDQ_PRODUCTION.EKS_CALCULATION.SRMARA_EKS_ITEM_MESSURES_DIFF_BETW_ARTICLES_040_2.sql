create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_MESSURES_DIFF_BETW_ARTICLES_040_2(
	BA_ITEMNO,
	CASESIZE,
	LISTINGOVERVIEWID,
	PERCENTAGEVOLUME,
	AVGVOLUME
) as
SELECT DISTINCT 
                  EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_Articles020.BA_ITEMNO, 
				  EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_Articles020.CASESIZE, 
				  EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_Articles020.listingoverviewid, 
                  EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_Articles020.percentageVolume, 
				  EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_Articles020.avgVolume
FROM     EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_Articles020_2 INNER JOIN
         EKS_CALCULATION.EKS_ZSM_ArticleParameter_2 AS idhigh ON idhigh.ID = 'RPTDQ028h' INNER JOIN
         EKS_CALCULATION.EKS_ZSM_ArticleParameter_2 AS idlow ON idlow.ID = 'RPTDQ028l'
WHERE  (EKS_CALCULATION.svMARA_EKS_ITEM_Messures_Diff_BETW_Articles020.percentageVolume NOT BETWEEN idlow.Value * 100 AND idhigh.Value * 100);