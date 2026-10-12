CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_zzz_pack_cont_uom_fromxtt006upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    zzz_pack_cont_uom = sr.zzz_pack_cont_uomnew FROM idq_production_eks_calculation.srmara_eks_zzz_pack_cont_uom_fromxtt006updsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
