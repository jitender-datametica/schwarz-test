CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_buyerid_firstname_lastname_updsel_2 (itemid, buyerid
, buyeridnew, buyerfirstname, buyerfirstnamenew, buyerlastname, buyerlastnamenew) AS SELECT DISTINCT stmara_eks_item.itemid
 ,
 stmara_eks_item.buyerid,
 employee.employeeid AS buyeridnew,
 stmara_eks_item.buyerfirstname,
 employee.firstname AS buyerfirstnamenew,
 stmara_eks_item.buyerlastname,
 employee.lastname AS buyerlastnamenew
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks.itembuyerel_2 ON stmara_eks_item.itemid = itembuyerel.itemid
 INNER JOIN idq_production_eks.employee_2 ON itembuyerel.employeeid = employee.employeeid
WHERE CURRENT_DATE BETWEEN CAST(itembuyerel.datefrom AS DATE) AND (CAST(itembuyerel.dateuntil AS DATE))
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(stmara_eks_item.itemid AS STRING) ORDER BY buyeridnew IS NULL DESC,
      buyeridnew DESC)) = 1;