CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zitem_ba_article_type_baupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    zitem_ba = SR.zitem_banew FROM eks_calculation.srmara_eks_item_zitem_ba_article_type_baupdsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




