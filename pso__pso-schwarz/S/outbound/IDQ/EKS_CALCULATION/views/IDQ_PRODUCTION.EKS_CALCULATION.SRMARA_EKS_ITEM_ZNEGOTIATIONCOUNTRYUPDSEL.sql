CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_znegotiationcountryupdsel (itemid,
znegotiatingcountry, znegotiatingcountrynew) AS SELECT DISTINCT T1.itemid,
 T1.znegotiatingcountry,
 T4.countrycode AS znegotiatingcountrynew
FROM idq_production_eks_calculation.stmara_eks_item AS T1
 INNER JOIN idq_production_eks.itembuyerel AS T2 ON T1.itemid = T2.itemid
 INNER JOIN idq_production_eks.employee AS T3 ON T2.employeeid = T3.employeeid
 INNER JOIN idq_production_eks.country AS T4 ON T3.countryid = T4.countryid
WHERE CURRENT_TIMESTAMP() BETWEEN CAST(T2.datefrom AS TIMESTAMP) AND (CAST(T2.dateuntil AS TIMESTAMP)
   );