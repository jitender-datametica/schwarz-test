CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zisvalidconstructupdsel_2 (itemid, zisvalidconstruct
, zisvalidconstructnew) AS SELECT itemid,
 zisvalidconstruct,
  CASE
  WHEN zarticletype = 'EA' AND IFNULL(ziseahassk, 0) = 0
  THEN 1
  ELSE CASE
   WHEN 0 <> IFNULL(ziseahasba, 0) OR 0 <> IFNULL(ziseahasskhasba, 0) OR 0 <> IFNULL(zisskhasba, 0)
   THEN 1
   ELSE 0
   END
  END AS zisvalidconstructnew
FROM idq_production_eks_calculation.stmara_eks_item_2
WHERE zisvalidconstruct IS NULL;