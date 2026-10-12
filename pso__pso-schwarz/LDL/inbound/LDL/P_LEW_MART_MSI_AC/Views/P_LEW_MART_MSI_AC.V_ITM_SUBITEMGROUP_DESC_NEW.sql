CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_SUBITEMGROUP_DESC_NEW
(
    subitemgroup_id
    , subitemgroup_desc
    , subitemgroup_short_desc
)
AS
SELECT
subitemgroup_id,
subitemgroup_desc,
subitemgroup_short_desc
FROM p_lew_mart_msi.v_itm_subitemgroup_desc_new
;


