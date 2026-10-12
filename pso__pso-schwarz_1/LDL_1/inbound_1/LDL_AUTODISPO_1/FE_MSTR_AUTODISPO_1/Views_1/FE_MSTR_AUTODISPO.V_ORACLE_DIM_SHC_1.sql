-- LDL_AUTODISPO_DEVELOPMENT.FE_MSTR_AUTODISPO.V_ORACLE_DIM_SHC_1 source

CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_ORACLE_DIM_SHC_1 AS
SELECT *,  
(CASE WHEN coalesce(sh_qty_aoc,-1) <> -1 THEN sh_aoc_shc_unit_id ELSE sh_wawi_shc_unit_id END) sh_unit_id,
coalesce(sh_qty_aoc,sh_qty_wawi) sh_quantity
FROM CORE.T_ORACLE_V_DIM_SHC_1;