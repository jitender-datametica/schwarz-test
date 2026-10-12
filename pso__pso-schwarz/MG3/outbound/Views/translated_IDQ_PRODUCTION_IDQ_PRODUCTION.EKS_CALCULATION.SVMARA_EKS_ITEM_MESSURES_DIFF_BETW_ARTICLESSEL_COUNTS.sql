CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_messures_diff_betw_articlessel_counts (listingoverviewid
, caseheight_count, casewidth_count, casedepth_count) AS SELECT listingoverviewid,
 COUNT(DISTINCT caseheight) AS caseheight_count,
 COUNT(DISTINCT casewidth) AS casewidth_count,
 COUNT(DISTINCT casedepth) AS casedepth_count
FROM idq_production_eks_calculation.svmara_eks_item_messures_diff_betw_articlessel_all
GROUP BY listingoverviewid
HAVING caseheight_count > 1 OR casewidth_count > 1 OR casedepth_count > 1;