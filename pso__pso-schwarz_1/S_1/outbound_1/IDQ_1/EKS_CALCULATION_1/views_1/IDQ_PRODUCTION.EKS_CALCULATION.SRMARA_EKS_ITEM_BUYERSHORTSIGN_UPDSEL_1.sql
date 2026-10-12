CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_buyershortsign_updsel_1 (itemid, buyerid,
buyershortsign, buyershortsignnew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.buyerid,
 stmara_eks_item.buyershortsign,
 employee.shortsign AS buyershortsignnew
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks.employee_1 ON stmara_eks_item.buyerid = employee.employeeid;