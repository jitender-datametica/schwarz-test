CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_02_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    zitem_ba = SR.zitem_banew FROM eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_02_updsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




