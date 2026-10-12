CREATE OR REPLACE VIEW idq_production_dwh.idq_wawi_zsm_sst_supplier_1 (regel_id, catalog_id, regelkurzbeschreibung,
fehlermeldung, regelgruppename, kritikalitaet, score, objekt_id, liefnr, lieferant, statuslieferant, kontengruppe,
eksnummer, land_1, m, nf, em, o_g, b_p, imp, verhandelndesland, umsatzsteueridnr, weitereustid, prueffeld,
gepruefterinhalt, zusaetzlinfo, ekorg, fehlerhaftseit, faehligkeitsdatum, ref_calculation_time) AS SELECT CTR.ref_rule_id
  AS regel_id,
 RRL.catalog_id,
 RRL.short_description_de AS regelkurzbeschreibung,
 RRL.error_text_de AS fehlermeldung,
 RRG.name_de AS regelgruppename,
 RCR.name_de AS kritikalitaet,
 ITO.score,
 CTR.idq_test_object_id AS objekt_id,
 ITO.source_system_primary_key AS liefnr,
 ITO.name AS lieferant,
 ADI.statuslieferant,
 ADI.kontengruppe,
 ADI.eks_nummer AS eksnummer,
 ADI.land_1,
 ADI.m,
 ADI.nf,
 ADI.em,
 ADI.o_g,
 ADI.b_p,
 ADI.imp,
 ADI.verhandelndesland,
 ADI.umsatzsteuer_idnr AS umsatzsteueridnr,
 ADI.weitereustid,
 RF.name_de AS prueffeld,
 CEI.invalid_content AS gepruefterinhalt,
 CEI.additional_info_de AS zusaetzlinfo,
 SUBSTR(CEI.additional_info_de, 8, 4) AS ekorg,
 MAX(CTR.first_negative_test) AS fehlerhaftseit,
 MAX(CTR.due_date) AS faehligkeitsdatum,
 MAX(CRBCS.check_rule_by_country_calculation_time) AS ref_calculation_time
FROM idq_production_dwh.check_test_result_1 AS CTR
 INNER JOIN idq_production_dwh.idq_test_object_1 AS ITO ON CTR.idq_test_object_id = ITO.idq_test_object_id
 INNER JOIN idq_production_idq_results.idq_addinfo_zsm_supplier_sst_1 AS ADI ON ITO.idq_test_object_id = ADI.test_object_id
  
 INNER JOIN idq_production_idq_results.ref_rule_1 AS RRL ON CTR.ref_rule_id = RRL.id
 INNER JOIN idq_production_idq_results.ref_rel_rule_group_rule_1 AS RGR ON RRL.id = RGR.rule_id
 INNER JOIN idq_production_idq_results.ref_rule_group_1 AS RRG ON RGR.rule_group_id = RRG.id
 INNER JOIN idq_production_idq_results.ref_criticality_1 AS RCR ON RRL.criticality_id = RCR.id
 INNER JOIN idq_production_idq_results.ref_field_1 AS RF ON RRL.field_id = RF.id
 INNER JOIN idq_production_idq_results.check_error_info_current_1 AS CEI ON ITO.idq_test_object_id = CEI.test_object_id
  AND RRL.id = CEI.rule_id
 INNER JOIN idq_production_dwh.check_rule_by_country_summary_1 AS CRBCS ON CTR.ref_rule_id = CRBCS.ref_rule_id
WHERE CTR.ref_rule_id = 383
 AND CTR.is_error_detected = 1
GROUP BY regel_id,
 RRL.catalog_id,
 regelkurzbeschreibung,
 fehlermeldung,
 regelgruppename,
 kritikalitaet,
 ITO.score,
 objekt_id,
 liefnr,
 lieferant,
 ADI.statuslieferant,
 ADI.kontengruppe,
 eksnummer,
 ADI.land_1,
 ADI.m,
 ADI.nf,
 ADI.em,
 ADI.o_g,
 ADI.b_p,
 ADI.imp,
 ADI.verhandelndesland,
 umsatzsteueridnr,
 ADI.weitereustid,
 prueffeld,
 gepruefterinhalt,
 zusaetzlinfo,
 ekorg;