CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_KUNDENPROGRAMM_SPR_ZU_1
--mcie1607, 04/02/2020, adding german language as default after english as there is no english translation at the moment.
AS
SELECT
crm_kundenprogramm_id
, MAX(CASE WHEN spr_id =  22 THEN crm_kundenprogramm_bez END) AS crm_kundenprogramm_bez   --standard
, MAX(CASE WHEN spr_id = 22   THEN crm_kundenprogramm_bez END) AS crm_kundenprogramm_bez_de --DE (for coalesce only)
, COALESCE(Max(CASE WHEN spr_id = 24   THEN crm_kundenprogramm_bez END), crm_kundenprogramm_bez_de) AS crm_kundenprogramm_bez_en -- EN
, COALESCE(COALESCE(MAX(CASE WHEN spr_id = 124   THEN crm_kundenprogramm_bez END),crm_kundenprogramm_bez_en ), crm_kundenprogramm_bez_de) AS crm_kundenprogramm_bez_cz -- CZ
, COALESCE(COALESCE(MAX(CASE WHEN spr_id = 108 THEN crm_kundenprogramm_bez END),crm_kundenprogramm_bez_en ), crm_kundenprogramm_bez_de) AS crm_kundenprogramm_bez_sk -- SK
, COALESCE(COALESCE(MAX(CASE WHEN spr_id = 65   THEN crm_kundenprogramm_bez END),crm_kundenprogramm_bez_en ), crm_kundenprogramm_bez_de) AS crm_kundenprogramm_bez_hr -- HR
, COALESCE(COALESCE(MAX(CASE WHEN spr_id = 90   THEN crm_kundenprogramm_bez END), crm_kundenprogramm_bez_en ),crm_kundenprogramm_bez_de) AS crm_kundenprogramm_bez_pl -- PL
, COALESCE(COALESCE(MAX(CASE WHEN spr_id = 95   THEN crm_kundenprogramm_bez END),crm_kundenprogramm_bez_en ),crm_kundenprogramm_bez_de) AS crm_kundenprogramm_bez_ro -- RO
, COALESCE(COALESCE(MAX(CASE WHEN spr_id = 18   THEN crm_kundenprogramm_bez END),crm_kundenprogramm_bez_en ),crm_kundenprogramm_bez_de) AS crm_kundenprogramm_bez_bg -- BG
FROM dbp_view.v_crm_kundenprogramm_spr_zu_1
GROUP BY
crm_kundenprogramm_id
;