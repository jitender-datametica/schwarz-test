CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_buyerid_firstname_lastname_barollupmk_updsel_2 (itemid
, buyerid, buyeridnew, buyerfirstname, buyerfirstnamenew, buyerlastname, buyerlastnamenew) AS SELECT DISTINCT
 stmara_eks_item.itemid,
 stmara_eks_item.buyerid,
 srmara_eks_item_buyerid_firstname_lastname_skrollup01.buyerid AS buyeridnew,
 stmara_eks_item.buyerfirstname,
 employee.firstname AS buyerfirstnamenew,
 stmara_eks_item.buyerlastname,
 employee.lastname AS buyerlastnamenew
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks_calculation.srmara_eks_item_buyerid_firstname_lastname_skrollup01_2 ON stmara_eks_item.itemid
    = srmara_eks_item_buyerid_firstname_lastname_skrollup01.itemid AND stmara_eks_item.bitflag =
   srmara_eks_item_buyerid_firstname_lastname_skrollup01.bitflag
 INNER JOIN idq_production_eks.employee_2 ON srmara_eks_item_buyerid_firstname_lastname_skrollup01.buyerid = employee.employeeid
  
WHERE stmara_eks_item.bitflag = 2
 AND stmara_eks_item.buyerid IS NULL;