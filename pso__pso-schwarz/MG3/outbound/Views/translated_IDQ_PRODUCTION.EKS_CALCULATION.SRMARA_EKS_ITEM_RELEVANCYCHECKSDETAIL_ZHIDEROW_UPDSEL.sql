CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderow_updsel (uid, itemid
, itemno, zhiderow, zhiderownew, zarticletype) AS SELECT uid,
 itemid,
 itemno,
 zhiderow,
 1 AS zhiderownew,
 zarticletype
FROM idq_production_eks_calculation.stmara_eks_item_relevancychecksdetail
WHERE zarticletype IN ('EA', 'SK')
 AND ziscurrentcontract = 1
 AND contractpricevalidityid IS NULL;