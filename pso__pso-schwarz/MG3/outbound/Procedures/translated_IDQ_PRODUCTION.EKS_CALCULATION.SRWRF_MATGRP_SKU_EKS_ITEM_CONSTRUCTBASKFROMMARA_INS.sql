CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_constructbaskfrommara_ins()
BEGIN
INSERT INTO idq_production_eks_calculation.stwrf_matgrp_sku_eks_item (itemid, bitflag)
(SELECT itemid, bitflag
    FROM idq_production_eks.item);
INSERT INTO idq_production_eks_calculation.stwrf_matgrp_sku_eks_item (itemid, bitflag, constructed, constructedfrom)
(SELECT itemid, bitflag, CAST(constructed AS NUMERIC) AS constructed, constructedfrom
    FROM idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_constructbaskfrommara_inssel);
END;
