CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_ziseahasskhasba_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    ziseahasskhasba = srmara_eks_item_ziseahasskhasba_updsel.ziseahasskhasbanew FROM eks_calculation.srmara_eks_item_ziseahasskhasba_updsel
WHERE stmara_eks_item.itemid = srmara_eks_item_ziseahasskhasba_updsel.itemid;
END;




