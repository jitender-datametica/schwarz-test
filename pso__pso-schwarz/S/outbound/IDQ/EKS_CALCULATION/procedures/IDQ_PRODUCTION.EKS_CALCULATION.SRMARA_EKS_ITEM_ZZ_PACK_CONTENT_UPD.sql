CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zz_pack_content_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    zzz_pack_content = CAST(SR.zzz_pack_contentnew AS NUMERIC) FROM eks_calculation.srmara_eks_item_zz_pack_content_updsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




