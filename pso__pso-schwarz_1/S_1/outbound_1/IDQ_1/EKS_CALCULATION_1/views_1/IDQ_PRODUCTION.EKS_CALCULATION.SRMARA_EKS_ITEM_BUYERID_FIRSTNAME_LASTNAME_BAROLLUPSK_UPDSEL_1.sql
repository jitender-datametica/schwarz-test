CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_buyerid_firstname_lastname_barollupsk_updsel_1 (itemid
, bitflag, buyerid, buyeridnew, buyerfirstname, buyerfirstnamenew, buyerlastname, buyerlastnamenew) AS SELECT DISTINCT
 stmara_eks_item.itemid,
 stmara_eks_item.bitflag,
 stmara_eks_item.buyerid,
 srmara_eks_item_buyerid_firstname_lastname_barollup01.buyerid AS buyeridnew,
 stmara_eks_item.buyerfirstname,
 employee.firstname AS buyerfirstnamenew,
 stmara_eks_item.buyerlastname,
 employee.lastname AS buyerlastnamenew
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks_calculation.srmara_eks_item_buyerid_firstname_lastname_barollup01_1 ON stmara_eks_item.itemid
    = srmara_eks_item_buyerid_firstname_lastname_barollup01.itemid AND stmara_eks_item.bitflag =
   srmara_eks_item_buyerid_firstname_lastname_barollup01.bitflag
 INNER JOIN idq_production_eks.employee_1 ON srmara_eks_item_buyerid_firstname_lastname_barollup01.buyerid = employee.employeeid
  
WHERE stmara_eks_item.bitflag = 2
 AND stmara_eks_item.buyerid IS NULL;