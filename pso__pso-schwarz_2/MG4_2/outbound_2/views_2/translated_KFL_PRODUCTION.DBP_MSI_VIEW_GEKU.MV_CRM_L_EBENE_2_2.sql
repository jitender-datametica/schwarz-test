-- Tabelle crm_l_themenbaum_lv2_2 ist denormalisiert und enthält Ebene 1 + 2  + 3. Jeder Datensatz hat mit crm_themenbaum_lv2_id einen eindeutigen Schlüssel, der in MSI aber nicht relevant ist.

-- 23.07.2019 twie: SPEC0059158 Lookup CRM Ebene 2 (mittlere Stufe)

-- Ebene 1 ist Elternteil zu Ebene 2, deshalb müssen gleiche ebene_2_id immer die gleiche ebene_1_id haben, sonst Hierarchie in der Tabelle von der Quelle nicht richtig hinterlegt

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_l_ebene_2_2 (ebene_2_id, number_level_2, ebene_1_id) AS SELECT ebene_2_id
 ,
 MAX(number_level_2) AS number_level_2,
 MAX(ebene_1_id) AS ebene_1_id
FROM kfl_production_dbp_view.v_crm_l_themenbaum_lv2_2
GROUP BY ebene_2_id;