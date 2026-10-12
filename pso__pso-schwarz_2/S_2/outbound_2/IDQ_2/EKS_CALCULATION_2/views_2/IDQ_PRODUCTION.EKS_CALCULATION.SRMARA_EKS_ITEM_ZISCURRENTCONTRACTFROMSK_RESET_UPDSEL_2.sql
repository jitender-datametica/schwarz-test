CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_reset_updsel_2 (itemid,
zlegacymatnr, ziscurrentcontractfromsk, ziscurrentcontractfromsknew) AS SELECT EA.itemid,
 EA.zlegacymatnr,
 EA.ziscurrentcontractfromsk,
 NULL AS ziscurrentcontractfromsknew
FROM idq_production_eks_calculation.stmara_eks_item_2 AS EA
 INNER JOIN idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_reset_01_2 AS SK ON EA.itemid = SK.itemid
  
WHERE EA.zarticletype = 'EA'
 AND EA.ziscurrentcontractfromsk = 1
 AND EA.ziscurrentcontract IS NULL;