CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_LIL_LIFT_DM_RETAILER_GD_SORT
(
      client_id
    , rtl_id
    , rtl_desc
    , rtl_desc_EN
    , rtl_tp_id
    , clnt_rtl_srt_cd
) AS
SELECT
      client_id
    , rtl_id
    , rtl_desc
    , rtl_desc_EN
    , rtl_tp_id
    , clnt_rtl_srt_cd
FROM P_LEW_PROCESS_MSTR.T_LIL_LIFT_DM_RETAILER_GD_SORT ;

