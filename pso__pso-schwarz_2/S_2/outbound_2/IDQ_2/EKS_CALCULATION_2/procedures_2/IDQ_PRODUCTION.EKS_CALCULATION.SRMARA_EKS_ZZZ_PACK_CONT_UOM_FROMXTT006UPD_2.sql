CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_zzz_pack_cont_uom_fromxtt006upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_2 SET
    zzz_pack_cont_uom = SR.zzz_pack_cont_uomnew FROM eks_calculation.srmara_eks_zzz_pack_cont_uom_fromxtt006updsel_2 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




