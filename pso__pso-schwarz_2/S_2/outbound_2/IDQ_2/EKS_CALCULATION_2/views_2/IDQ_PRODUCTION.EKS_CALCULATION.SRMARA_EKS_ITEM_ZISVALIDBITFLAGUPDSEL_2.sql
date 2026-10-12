CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zisvalidbitflagupdsel_2 (itemid, zisvalidbitflag,
zisvalidbitflagnew) AS SELECT itemid,
 zisvalidbitflag,
  CASE
  WHEN bitflag IN (0, 2, 4)
  THEN 1
  ELSE NULL
  END AS zisvalidbitflagnew
FROM idq_production_eks_calculation.stmara_eks_item_2;