CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_messures_diff_betw_articles_040_2 (ba_itemno,
casesize, listingoverviewid, percentagevolume, avgvolume) AS SELECT DISTINCT
 svmara_eks_item_messures_diff_betw_articles020.ba_itemno,
 svmara_eks_item_messures_diff_betw_articles020.casesize,
 svmara_eks_item_messures_diff_betw_articles020.listingoverviewid,
 svmara_eks_item_messures_diff_betw_articles020.percentagevolume,
 svmara_eks_item_messures_diff_betw_articles020.avgvolume
FROM idq_production_eks_calculation.svmara_eks_item_messures_diff_betw_articles020_2
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter_2 AS idhigh ON idhigh.id = 'RPTDQ028h'
 INNER JOIN idq_production_eks_calculation.eks_zsm_articleparameter_2 AS idlow ON idlow.id = 'RPTDQ028l'
WHERE svmara_eks_item_messures_diff_betw_articles020.percentagevolume NOT BETWEEN idlow.value * 100 AND (idhigh.value *
    100);