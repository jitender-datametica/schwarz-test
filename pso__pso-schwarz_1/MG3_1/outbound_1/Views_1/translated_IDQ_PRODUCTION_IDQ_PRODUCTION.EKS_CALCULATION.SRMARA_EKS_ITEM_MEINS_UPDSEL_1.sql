CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_meins_updsel_1(ZMEINS, ZMEINSNEW, ITEMID, ZLEGACYMEINS, DESCRIPTION) AS SELECT
    STMARA_EKS_ITEM.ZMEINS,
    CASE
       coalesce(STMARA_EKS_ITEM.ZLEGACYMEINS, '')
      WHEN '' THEN 'ST'
      ELSE CASE
         TRANSLATION_INT.DESCRIPTION
        WHEN 'KG' THEN 'KG'
        WHEN 'g' THEN 'KG'
        
        WHEN 'LB' THEN 'LB'
        WHEN 'oz' THEN 'LB'
        ELSE 'KG'
      END
    END AS ZMEINSNEW,
    STMARA_EKS_ITEM.ITEMID,
    STMARA_EKS_ITEM.ZLEGACYMEINS,
    TRANSLATION_INT.DESCRIPTION
  FROM
    idq_production_eks_calculation.stmara_eks_item_1
    LEFT OUTER JOIN idq_production_eks.itemdetail_1 ON STMARA_EKS_ITEM.ITEMID = ITEMDETAIL.ITEMID
    INNER JOIN idq_production_eks.unit_1 ON ITEMDETAIL.UNITID = UNIT.UNITID
    INNER JOIN idq_production_eks.translation_int_1 ON UNIT.SHORTDESCID = TRANSLATION_INT.TRANSLATIONID
  WHERE STMARA_EKS_ITEM.BITFLAG = NUMERIC '0'
;