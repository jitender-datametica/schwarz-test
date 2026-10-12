CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_merchandising_01_sel_1 (merchandisinggroup,
baitemnumber) AS SELECT zlegacymatkl AS merchandisinggroup,
 zitem_ba AS baitemnumber
FROM idq_production_eks_calculation.stmara_eks_item_1
WHERE zactive = 1
GROUP BY merchandisinggroup,
 baitemnumber
HAVING merchandisinggroup IS NOT NULL
ORDER BY merchandisinggroup NULLS LAST;