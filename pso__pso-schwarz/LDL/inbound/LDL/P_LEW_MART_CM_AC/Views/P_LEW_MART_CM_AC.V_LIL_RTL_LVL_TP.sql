CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_RTL_LVL_TP
(
    rtl_lvl
    , rtl_lvl_desc
    , rtl_lvl_desc_EN
    , rtl_tp_id
) AS
SELECT
    rtl_lvl
    , rtl_lvl_desc
    , rtl_lvl_desc_EN
    , rtl_tp_id
FROM P_LEW_MART_CM.v_lil_rtl_lvl_tp ;
