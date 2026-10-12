CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_baskea_structure_010_2 (ba_itemno, ba_articletype,
ba_description, sk_itemno, sk_articletype, sk_description, sk_active, sk_contract, ea_itemno, ea_itemid, ea_description
, zarticletype) AS SELECT CASE
  WHEN ST_SK.zarticletype = 'BA'
  THEN ST_SK.itemno
  ELSE ST_BA.itemno
  END AS ba_itemno,
  CASE
  WHEN ST_SK.zarticletype = 'BA'
  THEN ST_SK.zarticletype
  ELSE ST_BA.zarticletype
  END AS ba_articletype,
  CASE
  WHEN ST_SK.zarticletype = 'BA'
  THEN ST_SK.description_int
  ELSE ST_BA.description_int
  END AS ba_description,
  CASE
  WHEN ST_SK.zarticletype = 'SK'
  THEN ST_SK.itemno
  ELSE NULL
  END AS sk_itemno,
  CASE
  WHEN ST_SK.zarticletype = 'SK'
  THEN ST_SK.zarticletype
  ELSE NULL
  END AS sk_articletype,
  CASE
  WHEN ST_SK.zarticletype = 'SK'
  THEN ST_SK.description_int
  ELSE NULL
  END AS sk_description,
  CASE
  WHEN ST_SK.zarticletype = 'SK'
  THEN ST_SK.zactive
  ELSE NULL
  END AS sk_active,
  CASE
  WHEN ST_SK.zarticletype = 'SK'
  THEN ST_SK.ziscurrentcontract
  ELSE NULL
  END AS sk_contract,
 ST_EA.itemno AS ea_itemno,
 ST_EA.itemid AS ea_itemid,
 ST_EA.description_int AS ea_description,
 ST_EA.zarticletype
FROM idq_production_eks_calculation.stmara_eks_item_2 AS ST_EA
 LEFT JOIN idq_production_eks.itemsorting_2 AS EKS_SK ON ST_EA.itemid = EKS_SK.itemid
 LEFT JOIN idq_production_eks_calculation.stmara_eks_item_2 AS ST_SK ON EKS_SK.sortitemid = ST_SK.itemid
 LEFT JOIN idq_production_eks.itemsorting_2 AS EKS_BA ON ST_SK.itemid = EKS_BA.itemid
 LEFT JOIN idq_production_eks_calculation.stmara_eks_item_2 AS ST_BA ON EKS_BA.sortitemid = ST_BA.itemid
WHERE ST_EA.ziscurrentcontract = 1 AND ST_EA.zarticletype = 'EA'
 OR ST_EA.zarticletype = 'EA' AND ST_EA.ziscurrentcontractfromsk = 1;