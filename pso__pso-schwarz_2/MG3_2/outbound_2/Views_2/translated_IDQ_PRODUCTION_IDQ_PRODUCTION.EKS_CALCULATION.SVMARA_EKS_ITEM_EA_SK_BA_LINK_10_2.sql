CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_ea_sk_ba_link_10_2 (ea_itemid, ea_itemno,
ea_description, sk_itemid, sk_itemno, sk_description, ba_itemid, ba_itemno, ba_description) AS SELECT ea.itemid AS
 ea_itemid,
 ea.itemno AS ea_itemno,
 ea.description_int AS ea_description,
 sk.itemid AS sk_itemid,
 sk.itemno AS sk_itemno,
 sk.description_int AS sk_description,
 ba.itemid AS ba_itemid,
 ba.itemno AS ba_itemno,
 ba.description_int AS ba_description
FROM idq_production_eks_calculation.stmara_eks_item_2 AS ea
 INNER JOIN idq_production_eks.itemsorting_2 AS eask ON ea.itemid = eask.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS sk ON eask.sortitemid = sk.itemid
 INNER JOIN idq_production_eks.itemsorting_2 AS skba ON sk.itemid = skba.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS ba ON skba.sortitemid = ba.itemid
WHERE ea.zarticletype = 'EA'
 AND sk.zarticletype = 'SK'
 AND ba.zarticletype = 'BA'
 AND sk.ziscurrentcontract = 1;