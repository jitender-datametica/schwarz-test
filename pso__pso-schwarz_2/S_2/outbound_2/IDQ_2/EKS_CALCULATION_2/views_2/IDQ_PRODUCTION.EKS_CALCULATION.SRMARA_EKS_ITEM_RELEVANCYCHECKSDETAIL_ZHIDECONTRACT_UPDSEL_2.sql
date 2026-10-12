CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhidecontract_updsel_2 (uid,
itemid, itemno, zhidecontract, zhidecontractnew) AS SELECT uid,
 itemid,
 itemno,
 zhidecontract,
 1 AS zhidecontractnew
FROM idq_production_eks_calculation.stmara_eks_item_relevancychecksdetail_2
WHERE zarticletype = 'EA' AND ziscurrentcontractfromsk = 1 AND contractpricevalidityid IS NULL
 OR zarticletype = 'BA';