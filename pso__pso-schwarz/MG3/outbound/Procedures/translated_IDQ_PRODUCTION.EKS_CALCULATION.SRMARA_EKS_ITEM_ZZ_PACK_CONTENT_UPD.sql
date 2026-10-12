CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zz_pack_content_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    zzz_pack_content = CAST(sr.zzz_pack_contentnew AS NUMERIC) FROM idq_production_eks_calculation.srmara_eks_item_zz_pack_content_updsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
