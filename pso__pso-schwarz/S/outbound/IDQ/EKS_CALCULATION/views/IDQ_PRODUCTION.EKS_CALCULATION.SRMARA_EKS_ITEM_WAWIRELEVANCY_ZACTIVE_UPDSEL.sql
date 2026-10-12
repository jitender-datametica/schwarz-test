CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_wawirelevancy_zactive_updsel AS WITH
 STMARA_WAWI_ZRELEVANTMDM AS (SELECT stmara_eks_item.itemid,
   stmara_eks_item.itemno,
   srmara_eks_item_wawirelevancy_zfullmatchsk_010.zfullmatchnew AS zfullmatch_sk,
   srmara_eks_item_wawirelevancy_zfullmatchea_010.zfullmatchnew AS zfullmatch_ea,
   srmara_eks_item_wawirelevancy_znomatch_010.znomatchnew AS znomatch
  FROM idq_production_eks_calculation.stmara_eks_item
   LEFT JOIN idq_production_eks_calculation.srmara_eks_item_wawirelevancy_zfullmatchsk_010 ON stmara_eks_item.itemid =
     srmara_eks_item_wawirelevancy_zfullmatchsk_010.itemid AND stmara_eks_item.itemno =
     srmara_eks_item_wawirelevancy_zfullmatchsk_010.itemno
   LEFT JOIN idq_production_eks_calculation.srmara_eks_item_wawirelevancy_zfullmatchea_010 ON stmara_eks_item.itemid =
     srmara_eks_item_wawirelevancy_zfullmatchea_010.itemid AND stmara_eks_item.itemno =
     srmara_eks_item_wawirelevancy_zfullmatchea_010.itemno
   LEFT JOIN idq_production_eks_calculation.srmara_eks_item_wawirelevancy_znomatch_010 ON stmara_eks_item.itemid =
     srmara_eks_item_wawirelevancy_znomatch_010.itemid AND stmara_eks_item.itemno =
     srmara_eks_item_wawirelevancy_znomatch_010.itemno
  WHERE stmara_eks_item.zrelevantmdm = 1) (SELECT DISTINCT itemid,
   itemno,
   znomatch,
   zfullmatch_sk,
   zfullmatch_ea,
   1 AS zactivenew
  FROM STMARA_WAWI_ZRELEVANTMDM
  WHERE IFNULL(zfullmatch_sk, 0) = 1
   OR IFNULL(zfullmatch_ea, 0) = 1
   OR IFNULL(znomatch, 0) = 1);