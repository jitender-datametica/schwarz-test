-- Ebene 2 ist Elternteil zu Ebene 3, deshalb müssen gleiche ebene_3_id immer die gleiche ebene_2_id haben, sonst Hierarchie in der Tabelle von der Quelle nicht richtig hinterlegt

-- 22.07.2019 twie: SPEC0059158 Lookup CRM Ebene 3 (unterste Stufe)

-- Tabelle crm_l_themenbaum_lv2_2 ist denormalisiert und enthält Ebene 1 + 2  + 3. Jeder Datensatz hat mit crm_themenbaum_lv2_id einen eindeutigen Schlüssel, der in MSI aber nicht relevant ist.

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_l_ebene_3_2 (ebene_3_id, number_level_3, ebene_2_id) AS SELECT ebene_3_id
 ,
 MAX(number_level_3) AS number_level_3,
 MAX(ebene_2_id) AS ebene_2_id
FROM kfl_production_dbp_view.v_crm_l_themenbaum_lv2_2
GROUP BY ebene_3_id;