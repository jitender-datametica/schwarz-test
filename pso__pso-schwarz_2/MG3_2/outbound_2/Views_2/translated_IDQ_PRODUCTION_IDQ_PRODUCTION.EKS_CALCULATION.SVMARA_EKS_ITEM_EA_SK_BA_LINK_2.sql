CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_ea_sk_ba_link_2 (ea_itemid, ea_itemno,
ea_description, sk_itemid, sk_itemno, sk_description, ba_itemid, ba_itemno, ba_description) AS SELECT
 svmara_eks_item_ea_sk_ba_link_20.ea_itemid,
 svmara_eks_item_ea_sk_ba_link_20.ea_itemno,
 svmara_eks_item_ea_sk_ba_link_20.ea_description,
 CAST(svmara_eks_item_ea_sk_ba_link_20.sk_itemid AS BIGNUMERIC) AS sk_itemid,
 CAST(svmara_eks_item_ea_sk_ba_link_20.sk_itemno AS BIGNUMERIC) AS sk_itemno,
 SUBSTR(CAST(svmara_eks_item_ea_sk_ba_link_20.sk_description AS STRING), 1, 100) AS sk_description,
 svmara_eks_item_ea_sk_ba_link_20.ba_itemid,
 svmara_eks_item_ea_sk_ba_link_20.ba_itemno,
 svmara_eks_item_ea_sk_ba_link_20.ba_description
FROM idq_production_eks_calculation.svmara_eks_item_ea_sk_ba_link_10_2
 RIGHT JOIN idq_production_eks_calculation.svmara_eks_item_ea_sk_ba_link_20_2 ON svmara_eks_item_ea_sk_ba_link_10.ea_itemid
   = svmara_eks_item_ea_sk_ba_link_20.ea_itemid
UNION DISTINCT
SELECT *
FROM idq_production_eks_calculation.svmara_eks_item_ea_sk_ba_link_10_2;