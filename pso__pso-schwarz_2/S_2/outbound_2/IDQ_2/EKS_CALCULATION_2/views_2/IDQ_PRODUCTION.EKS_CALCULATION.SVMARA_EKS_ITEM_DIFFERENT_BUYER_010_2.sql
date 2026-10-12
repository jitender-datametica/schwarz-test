CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_different_buyer_010_2 (struc, ba_itemno, sk_itemno,
ea_itemno, shortsign) AS SELECT DISTINCT IFNULL(IFNULL(BASKEA.ba_itemno, BASKEA.sk_itemno), BASKEA.ea_itemno) AS struc,
 BASKEA.ba_itemno,
 BASKEA.sk_itemno,
 BASKEA.ea_itemno,
 EMP.shortsign
FROM idq_production_eks_calculation.stmara_eks_item_2 AS ST
 INNER JOIN idq_production_eks_calculation.svmara_eks_item_baskea_structure_010_2 AS BASKEA ON ST.itemid = BASKEA.ea_itemid
  
 INNER JOIN idq_production_eks.itembuyerel_2 AS ITB ON ST.itemid = ITB.itemid AND CURRENT_TIMESTAMP() BETWEEN CAST(ITB.datefrom AS TIMESTAMP)
   AND (CAST(ITB.dateuntil AS TIMESTAMP))
 INNER JOIN idq_production_eks.employee_2 AS EMP ON ITB.employeeid = EMP.employeeid
WHERE ST.zactive = 1
 OR ST.ziscurrentcontract = 1
 OR ST.ziscurrentcontractfromsk = 1;