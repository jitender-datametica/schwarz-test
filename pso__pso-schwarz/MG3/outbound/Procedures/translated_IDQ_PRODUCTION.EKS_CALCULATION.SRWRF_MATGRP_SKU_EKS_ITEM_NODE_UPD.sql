CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_node_upd()
BEGIN
UPDATE idq_production_eks_calculation.stwrf_matgrp_sku_eks_item SET
    znode = sr.znodenew FROM idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_node_updsel AS sr
WHERE stwrf_matgrp_sku_eks_item.itemid = sr.itemid;
END;
