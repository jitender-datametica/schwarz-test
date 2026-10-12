CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_L_EBENE_3_1
AS
-- 22.07.2019 twie: SPEC0059158 Lookup CRM Ebene 3 (unterste Stufe)
-- Tabelle crm_l_themenbaum_lv2_1 ist denormalisiert und enthält Ebene 1 + 2  + 3. Jeder Datensatz hat mit crm_themenbaum_lv2_id einen eindeutigen Schlüssel, der in MSI aber nicht relevant ist.

   SELECT

   ebene_3_id
   , MAX(number_level_3) AS number_level_3
   --Ebene 2 ist Elternteil zu Ebene 3, deshalb müssen gleiche ebene_3_id immer die gleiche ebene_2_id haben, sonst Hierarchie in der Tabelle von der Quelle nicht richtig hinterlegt
   , MAX(ebene_2_id) AS ebene_2_id

   FROM dbp_view.v_crm_l_themenbaum_lv2_1

   GROUP BY ebene_3_id;