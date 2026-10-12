CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_different_buyer_010_2 (struc, ba_itemno, sk_itemno,
ea_itemno, shortsign) AS SELECT DISTINCT IFNULL(IFNULL(baskea.ba_itemno, baskea.sk_itemno), baskea.ea_itemno) AS struc,
 baskea.ba_itemno,
 baskea.sk_itemno,
 baskea.ea_itemno,
 emp.shortsign
FROM idq_production_eks_calculation.stmara_eks_item_2 AS st
 INNER JOIN idq_production_eks_calculation.svmara_eks_item_baskea_structure_010_2 AS baskea ON st.itemid = baskea.ea_itemid
  
 INNER JOIN idq_production_eks.itembuyerel_2 AS itb ON st.itemid = itb.itemid AND CURRENT_TIMESTAMP() BETWEEN CAST(itb.datefrom AS TIMESTAMP)
   AND (CAST(itb.dateuntil AS TIMESTAMP))
 INNER JOIN idq_production_eks.employee_2 AS emp ON itb.employeeid = emp.employeeid
WHERE st.zactive = 1
 OR st.ziscurrentcontract = 1
 OR st.ziscurrentcontractfromsk = 1;