CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zlegacymatnrupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_2 SET
    zlegacymatnr = SUBSTR(CAST(SR.zlegacymatnrnew AS STRING), 1, 50) FROM eks_calculation.srmara_eks_item_zlegacymatnrupdsel_2 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




