CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_znegotiatingcountryupdsel_2 (itemid,
znegotiatingcountry, znegotiatingcountrynew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.znegotiatingcountry,
 country.countrycode AS znegotiatingcountrynew
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks.itembuyerel_2 ON stmara_eks_item.itemid = itembuyerel.itemid
 INNER JOIN idq_production_eks.employee_2 ON itembuyerel.employeeid = employee.employeeid
 INNER JOIN idq_production_eks.country_2 ON employee.countryid = country.countryid
WHERE CAST(CURRENT_DATE AS DATETIME) BETWEEN itembuyerel.datefrom AND itembuyerel.dateuntil;