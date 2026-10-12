CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_zzz_pack_cont_uom_fromxtt006upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_2 SET
    zzz_pack_cont_uom = sr.zzz_pack_cont_uomnew FROM idq_production_eks_calculation.srmara_eks_zzz_pack_cont_uom_fromxtt006updsel_2 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
