CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zarticletypeupdsel_1 (itemid, zarticletype,
zarticletypenew) AS SELECT itemid,
 zarticletype,
  CASE
  WHEN bitflag = 0
  THEN 'EA'
  WHEN bitflag = 2
  THEN 'BA'
  WHEN bitflag = 4
  THEN 'SK'
  ELSE NULL
  END AS zarticletypenew
FROM idq_production_eks_calculation.stmara_eks_item_1
WHERE zarticletype IS NULL;