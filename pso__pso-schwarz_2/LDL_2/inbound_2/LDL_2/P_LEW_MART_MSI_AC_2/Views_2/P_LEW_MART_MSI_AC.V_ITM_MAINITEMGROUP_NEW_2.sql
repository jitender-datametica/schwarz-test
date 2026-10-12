CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_MAINITEMGROUP_NEW_2
(
    mainitemgroup_id
    , mainitemgroup_desc
    , mainitemgroup_short_desc
    , mainitemgroup_sortterm
    , language_id
)
AS
SELECT
mainitemgroup_id,
mainitemgroup_desc,
mainitemgroup_short_desc,
mainitemgroup_sortterm,
language_id
FROM p_lew_mart_msi.v_itm_mainitemgroup_new_2
;


