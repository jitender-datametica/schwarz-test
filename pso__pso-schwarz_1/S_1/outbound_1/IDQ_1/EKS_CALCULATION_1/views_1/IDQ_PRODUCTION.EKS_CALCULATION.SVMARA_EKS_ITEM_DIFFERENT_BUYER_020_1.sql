CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_different_buyer_020_1 (struc, count_employees) AS
SELECT struc,
 COUNT(DISTINCT shortsign) AS count_employees
FROM idq_production_eks_calculation.svmara_eks_item_different_buyer_010_1
GROUP BY struc
HAVING count_employees > 1;