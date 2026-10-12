CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_01_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_2 SET
    zitem_ba = SR.zitem_banew FROM eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_01_updsel_2 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




