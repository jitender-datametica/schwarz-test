CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_MAGICWORD_SPR_ZU_2
(
	CRM_MAGICWORD_ID,
	CRM_MAGICWORD_BEZ

) AS
-- 10.05.2022 twie: SPEC0145413 Sprachview CRM Zauberwort
-- 26.01.2023 twie: SPEC0181015 wenn crm_magicword_id = 0 dann crm_magicword_bez leer
-- 08.03.2023 twie: SPEC0181015 Bedingung geändert auf -1 statt 0
-- 28.11.2024 twie: SPEC0251592 Obwohl Tabelle mehrsprachig angelegt ist, wird nur eine_2 Sprache pro ID gepflegt, deshalb View nicht mehr mehrsprachig

   SELECT

   v01.crm_magicword_id
   ,MAX(CASE WHEN v01.crm_magicword_id <> '-1' THEN v01.crm_magicword_bez  ELSE NULL END)  AS crm_magicword_bez

   FROM dbp_view.v_crm_magicword_spr_zu_2 v01

   GROUP BY v01.crm_magicword_id
   ;