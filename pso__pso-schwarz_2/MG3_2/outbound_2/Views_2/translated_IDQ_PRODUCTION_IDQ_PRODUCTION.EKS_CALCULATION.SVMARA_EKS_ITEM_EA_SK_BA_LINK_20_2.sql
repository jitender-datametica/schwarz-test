CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_ea_sk_ba_link_20_2 (ea_itemid, ea_itemno,
ea_description, sk_itemid, sk_itemno, sk_description, ba_itemid, ba_itemno, ba_description) AS SELECT ea.itemid AS
 ea_itemid,
 ea.itemno AS ea_itemno,
 ea.description_int AS ea_description,
 NULL AS sk_itemid,
 NULL AS sk_itemno,
 NULL AS sk_description,
 ba.itemid AS ba_itemid,
 ba.itemno AS ba_itemno,
 ba.description_int AS ba_description
FROM idq_production_eks.itemsorting_2 AS eaba
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS ba ON eaba.sortitemid = ba.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS ea ON eaba.itemid = ea.itemid
WHERE ea.zarticletype = 'EA'
 AND ba.zarticletype = 'BA'
 AND ea.ziscurrentcontract = 1;