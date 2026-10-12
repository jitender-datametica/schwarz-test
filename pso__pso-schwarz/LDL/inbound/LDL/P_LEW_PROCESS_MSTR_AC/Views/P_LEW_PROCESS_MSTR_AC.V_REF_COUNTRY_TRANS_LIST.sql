CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_COUNTRY_TRANS_LIST
(   client_id
    ,iso_code
    ,lang_postfix
)
AS
SELECT
    client_id
    ,iso_code
    ,lang_postfix
  FROM P_LEW_PROCESS_MSTR.V_REF_COUNTRY_TRANS_LIST;