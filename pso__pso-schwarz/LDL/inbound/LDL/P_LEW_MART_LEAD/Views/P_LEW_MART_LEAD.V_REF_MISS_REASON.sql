CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_MISS_REASON
AS
   SELECT TRY_CAST(code AS INTEGER)                      AS reason_id,
   MAX(DECODE(client_id, 23, description, NULL)) AS reason_desc,
   MAX(DECODE(client_id,  1, description, NULL)) AS reason_desc_AT,
   MAX(DECODE(client_id,  2, description, NULL)) AS reason_desc_BE,
   MAX(DECODE(client_id,  3, description, NULL)) AS reason_desc_BG,
   MAX(DECODE(client_id,  4, description, NULL)) AS reason_desc_CH,
   MAX(DECODE(client_id,  5, description, NULL)) AS reason_desc_CY,
   MAX(DECODE(client_id,  6, description, NULL)) AS reason_desc_CZ,
   MAX(DECODE(client_id, 23, description, NULL)) AS reason_desc_DE,
   MAX(DECODE(client_id,  8, description, NULL)) AS reason_desc_DK,
   MAX(DECODE(client_id, 10, description, NULL)) AS reason_desc_ES,
   MAX(DECODE(client_id, 11, description, NULL)) AS reason_desc_FI,
   MAX(DECODE(client_id, 12, description, NULL)) AS reason_desc_FR,
   MAX(DECODE(client_id, 13, description, NULL)) AS reason_desc_GB,
   MAX(DECODE(client_id, 14, description, NULL)) AS reason_desc_GR,
   MAX(DECODE(client_id, 15, description, NULL)) AS reason_desc_HR,
   MAX(DECODE(client_id, 16, description, NULL)) AS reason_desc_HU,
   MAX(DECODE(client_id, 17, description, NULL)) AS reason_desc_IE,
   MAX(DECODE(client_id, 18, description, NULL)) AS reason_desc_IT,
   MAX(DECODE(client_id, 19, description, NULL)) AS reason_desc_LT,
   MAX(DECODE(client_id, 20, description, NULL)) AS reason_desc_LV,
   MAX(DECODE(client_id, 21, description, NULL)) AS reason_desc_NI,
   MAX(DECODE(client_id, 22, description, NULL)) AS reason_desc_NL,
   MAX(DECODE(client_id, 24, description, NULL)) AS reason_desc_PL,
   MAX(DECODE(client_id, 25, description, NULL)) AS reason_desc_PT,
   MAX(DECODE(client_id, 26, description, NULL)) AS reason_desc_RO,
   MAX(DECODE(client_id, 27, description, NULL)) AS reason_desc_SE,
   MAX(DECODE(client_id, 28, description, NULL)) AS reason_desc_SI,
   MAX(DECODE(client_id, 29, description, NULL)) AS reason_desc_SK,
   MAX(DECODE(client_id, 31, description, NULL)) AS reason_desc_CS,
   MAX(DECODE(client_id, 32, description, NULL)) AS reason_desc_MT,
   MAX(DECODE(client_id, 33, description, NULL)) AS reason_desc_US
   FROM p_lew_core_ac.v_wawi_ref_description
   WHERE desc_type = 'T178'
   AND   read_only = 1
   AND   language_id = client_id
   GROUP BY reason_id
   HAVING reason_id IS NOT NULL;