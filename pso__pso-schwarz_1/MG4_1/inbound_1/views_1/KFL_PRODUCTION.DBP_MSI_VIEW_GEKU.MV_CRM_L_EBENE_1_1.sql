create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_L_EBENE_1_1(
	EBENE_1_ID,
	NUMBER_LEVEL_1
) as
-- 23.07.2019 twie: SPEC0059158 Lookup CRM Ebene 1 (oberste Stufe)
-- Tabelle crm_l_themenbaum_lv2_1 ist denormalisiert und enthält Ebene 1 + 2  + 3. Jeder Datensatz hat mit crm_themenbaum_lv2_id einen eindeutigen Schlüssel, der in MSI aber nicht relevant ist.

   SELECT

   ebene_1_id
   , MAX(number_level_1) AS number_level_1

   FROM dbp_view.v_crm_l_themenbaum_lv2_1

   GROUP BY ebene_1_id;