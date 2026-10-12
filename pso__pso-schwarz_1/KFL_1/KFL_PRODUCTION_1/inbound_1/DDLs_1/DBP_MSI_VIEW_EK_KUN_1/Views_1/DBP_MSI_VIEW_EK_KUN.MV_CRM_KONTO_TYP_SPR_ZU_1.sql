CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_KONTO_TYP_SPR_ZU_1
AS
SELECT
crm_konto_typ_id
, MAX(CASE WHEN v01.spr_id =  24 THEN v01.crm_konto_typ_bez END) AS crm_konto_typ_bez_en      --EN
, COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.crm_konto_typ_bez END), crm_konto_typ_bez_en) AS crm_konto_typ_bez      --DE (Standard)
, COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.crm_konto_typ_bez END), crm_konto_typ_bez_en) AS crm_konto_typ_bez_cz    -- CZ
, COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.crm_konto_typ_bez END), crm_konto_typ_bez_en) AS crm_konto_typ_bez_sk    -- SK
, COALESCE(MAX(CASE WHEN v01.spr_id = 65 THEN v01.crm_konto_typ_bez END), crm_konto_typ_bez_en) AS crm_konto_typ_bez_hr    -- HR
, COALESCE(MAX(CASE WHEN v01.spr_id = 90 THEN v01.crm_konto_typ_bez END), crm_konto_typ_bez_en) AS crm_konto_typ_bez_pl    -- PL
, COALESCE(MAX(CASE WHEN v01.spr_id = 95 THEN v01.crm_konto_typ_bez END), crm_konto_typ_bez_en) AS crm_konto_typ_bez_ro    -- RO
, COALESCE(MAX(CASE WHEN v01.spr_id = 18 THEN v01.crm_konto_typ_bez END), crm_konto_typ_bez_en) AS crm_konto_typ_bez_bg    -- BG
FROM dbp_view.v_crm_l_konto_typ_spr_zu_1 v01
GROUP BY
crm_konto_typ_id
;