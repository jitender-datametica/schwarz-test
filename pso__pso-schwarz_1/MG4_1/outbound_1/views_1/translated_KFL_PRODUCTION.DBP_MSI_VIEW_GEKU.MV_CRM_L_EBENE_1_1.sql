-- 23.07.2019 twie: SPEC0059158 Lookup CRM Ebene 1 (oberste Stufe)

-- Tabelle crm_l_themenbaum_lv2_1 ist denormalisiert und enthält Ebene 1 + 2  + 3. Jeder Datensatz hat mit crm_themenbaum_lv2_id einen eindeutigen Schlüssel, der in MSI aber nicht relevant ist.

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_l_ebene_1_1 (ebene_1_id, number_level_1) AS SELECT ebene_1_id,
 MAX(number_level_1) AS number_level_1
FROM kfl_production_dbp_view.v_crm_l_themenbaum_lv2_1
GROUP BY ebene_1_id;