CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_buyershortsign_updsel (itemid, buyerid,
buyershortsign, buyershortsignnew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.buyerid,
 stmara_eks_item.buyershortsign,
 employee.shortsign AS buyershortsignnew
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks.employee ON stmara_eks_item.buyerid = employee.employeeid;