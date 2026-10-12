CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zz_pack_cont_uom_article_type_ea_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    zlegacyzz_pack_cont_uom = SR.zlegacyzz_pack_cont_uomnew FROM eks_calculation.srmara_eks_item_zz_pack_cont_uom_article_type_ea_updsel_1 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




