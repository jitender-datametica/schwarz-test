CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_reset_updsel_1 (itemid,
zlegacymatnr, ziscurrentcontractfromsk, ziscurrentcontractfromsknew) AS SELECT ea.itemid,
 ea.zlegacymatnr,
 ea.ziscurrentcontractfromsk,
 NULL AS ziscurrentcontractfromsknew
FROM idq_production_eks_calculation.stmara_eks_item_1 AS ea
 INNER JOIN idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_reset_01_1 AS sk ON ea.itemid = sk.itemid
  
WHERE ea.zarticletype = 'EA'
 AND ea.ziscurrentcontractfromsk = 1
 AND ea.ziscurrentcontract IS NULL;