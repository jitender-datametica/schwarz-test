CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_L_EBENE_2
AS
-- 23.07.2019 twie: SPEC0059158 Lookup CRM Ebene 2 (mittlere Stufe)
-- Tabelle crm_l_themenbaum_lv2 ist denormalisiert und enthält Ebene 1 + 2  + 3. Jeder Datensatz hat mit crm_themenbaum_lv2_id einen eindeutigen Schlüssel, der in MSI aber nicht relevant ist.

   SELECT

   ebene_2_id
   , MAX(number_level_2) AS number_level_2
   --Ebene 1 ist Elternteil zu Ebene 2, deshalb müssen gleiche ebene_2_id immer die gleiche ebene_1_id haben, sonst Hierarchie in der Tabelle von der Quelle nicht richtig hinterlegt
   , MAX(ebene_1_id) AS ebene_1_id

   FROM dbp_view.v_crm_l_themenbaum_lv2

   GROUP BY ebene_2_id;