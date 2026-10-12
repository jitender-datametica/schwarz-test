CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zactive_updsel (itemid, zactive, zisvalidbitflag,
zisin_use, zisfood, ziscurrentcontract, zisvalidconstruct, zactivenew, zarticletype, zforcerelevant, zforcenotrelevant,
itemno) AS SELECT itemid,
 zactive,
 zisvalidbitflag,
 zisin_use,
 zisfood,
 ziscurrentcontract,
 zisvalidconstruct,
  CASE
  WHEN (IFNULL(0 <> zisvalidbitflag AND 0 <> zisfood AND 0 <> zisvalidconstruct AND (IFNULL(0 <> zisin_use AND 0 <>
              ziscurrentcontract, FALSE) OR 0 <> IFNULL(ziscurrentcontractfromsk, 0) OR 0 <> IFNULL(zrelevantmdm, 0)),
       FALSE) = (0 <> 1) OR IFNULL(zforcerelevant, 0) = 1) AND IFNULL(zforcenotrelevant, 0) = 0
  THEN 1
  ELSE 0
  END AS zactivenew,
 zarticletype,
 zforcerelevant,
 zforcenotrelevant,
 itemno
FROM idq_production_eks_calculation.stmara_eks_item
WHERE (IFNULL(0 <> zisvalidbitflag AND 0 <> zisfood AND 0 <> zisvalidconstruct AND (IFNULL(0 <> zisin_use AND 0 <>
            ziscurrentcontract, FALSE) OR 0 <> IFNULL(ziscurrentcontractfromsk, 0) OR 0 <> IFNULL(zrelevantmdm, 0)),
     FALSE) = (0 <> 1) OR IFNULL(zforcerelevant, 0) = 1)
 AND IFNULL(zforcenotrelevant, 0) = 0;