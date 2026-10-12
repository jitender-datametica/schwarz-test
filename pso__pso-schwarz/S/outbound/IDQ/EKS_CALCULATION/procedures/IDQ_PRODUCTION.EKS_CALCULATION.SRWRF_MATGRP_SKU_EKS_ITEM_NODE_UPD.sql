CREATE OR REPLACE PROCEDURE eks_calculation.srwrf_matgrp_sku_eks_item_node_upd()
BEGIN
UPDATE eks_calculation.stwrf_matgrp_sku_eks_item SET
    znode = SR.znodenew FROM eks_calculation.srwrf_matgrp_sku_eks_item_node_updsel AS SR
WHERE stwrf_matgrp_sku_eks_item.itemid = SR.itemid;
END;




