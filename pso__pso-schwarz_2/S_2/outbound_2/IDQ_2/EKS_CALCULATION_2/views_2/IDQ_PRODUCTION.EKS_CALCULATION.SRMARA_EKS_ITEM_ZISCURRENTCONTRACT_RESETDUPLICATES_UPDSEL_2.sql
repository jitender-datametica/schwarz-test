CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziscurrentcontract_resetduplicates_updsel_2 (zarticletype
, itemid, ziscurrentcontract, zhasvalidcontractdate, zhasvalidadsflg, contractpricevalidityid, constructed,
ziscurrentcontractnew) AS SELECT stmara_eks_item.zarticletype,
 stmara_eks_item.itemid,
 stmara_eks_item.ziscurrentcontract,
 stmara_eks_item.zhasvalidcontractdate,
 stmara_eks_item.zhasvalidadsflg,
 xteks_basicinfo_union.contractpricevalidityid,
 stmara_eks_item.constructed,
 NULL AS ziscurrentcontractnew
FROM idq_production_eks_calculation.stmara_eks_item_2
 LEFT JOIN idq_production_eks_calculation.xteks_basicinfo_union_2 ON stmara_eks_item.itemid = xteks_basicinfo_union.itemid
  
WHERE xteks_basicinfo_union.contractpricevalidityid IS NULL
 AND stmara_eks_item.zarticletype IN ('SK', 'EA')
 AND stmara_eks_item.constructed IS NULL
 AND stmara_eks_item.zhasvalidadsflg = 1
 AND stmara_eks_item.zhasvalidcontractdate = 1
 AND stmara_eks_item.ziscurrentcontract = 1;