CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_baskea_structure_010 (ba_itemno, ba_articletype,
ba_description, sk_itemno, sk_articletype, sk_description, sk_active, sk_contract, ea_itemno, ea_itemid, ea_description
, zarticletype) AS SELECT CASE
  WHEN st_sk.zarticletype = 'BA'
  THEN st_sk.itemno
  ELSE st_ba.itemno
  END AS ba_itemno,
  CASE
  WHEN st_sk.zarticletype = 'BA'
  THEN st_sk.zarticletype
  ELSE st_ba.zarticletype
  END AS ba_articletype,
  CASE
  WHEN st_sk.zarticletype = 'BA'
  THEN st_sk.description_int
  ELSE st_ba.description_int
  END AS ba_description,
  CASE
  WHEN st_sk.zarticletype = 'SK'
  THEN st_sk.itemno
  ELSE NULL
  END AS sk_itemno,
  CASE
  WHEN st_sk.zarticletype = 'SK'
  THEN st_sk.zarticletype
  ELSE NULL
  END AS sk_articletype,
  CASE
  WHEN st_sk.zarticletype = 'SK'
  THEN st_sk.description_int
  ELSE NULL
  END AS sk_description,
  CASE
  WHEN st_sk.zarticletype = 'SK'
  THEN st_sk.zactive
  ELSE NULL
  END AS sk_active,
  CASE
  WHEN st_sk.zarticletype = 'SK'
  THEN st_sk.ziscurrentcontract
  ELSE NULL
  END AS sk_contract,
 st_ea.itemno AS ea_itemno,
 st_ea.itemid AS ea_itemid,
 st_ea.description_int AS ea_description,
 st_ea.zarticletype
FROM idq_production_eks_calculation.stmara_eks_item AS st_ea
 LEFT JOIN idq_production_eks.itemsorting AS eks_sk ON st_ea.itemid = eks_sk.itemid
 LEFT JOIN idq_production_eks_calculation.stmara_eks_item AS st_sk ON eks_sk.sortitemid = st_sk.itemid
 LEFT JOIN idq_production_eks.itemsorting AS eks_ba ON st_sk.itemid = eks_ba.itemid
 LEFT JOIN idq_production_eks_calculation.stmara_eks_item AS st_ba ON eks_ba.sortitemid = st_ba.itemid
WHERE st_ea.ziscurrentcontract = 1 AND st_ea.zarticletype = 'EA'
 OR st_ea.zarticletype = 'EA' AND st_ea.ziscurrentcontractfromsk = 1;