CREATE OR REPLACE VIEW idq_production_dwh.idq_wawi_zsm_sst_supplier (regel_id, catalog_id, regelkurzbeschreibung,
fehlermeldung, regelgruppename, kritikalitaet, score, objekt_id, liefnr, lieferant, statuslieferant, kontengruppe,
eksnummer, land, m, nf, em, o_g, b_p, imp, verhandelndesland, umsatzsteueridnr, weitereustid, prueffeld,
gepruefterinhalt, zusaetzlinfo, ekorg, fehlerhaftseit, faehligkeitsdatum, ref_calculation_time) AS SELECT ctr.ref_rule_id
  AS regel_id,
 rrl.catalog_id,
 rrl.short_description_de AS regelkurzbeschreibung,
 rrl.error_text_de AS fehlermeldung,
 rrg.name_de AS regelgruppename,
 rcr.name_de AS kritikalitaet,
 ito.score,
 ctr.idq_test_object_id AS objekt_id,
 ito.source_system_primary_key AS liefnr,
 ito.name AS lieferant,
 adi.statuslieferant,
 adi.kontengruppe,
 adi.eks_nummer AS eksnummer,
 adi.land,
 adi.m,
 adi.nf,
 adi.em,
 adi.o_g,
 adi.b_p,
 adi.imp,
 adi.verhandelndesland,
 adi.umsatzsteuer_idnr AS umsatzsteueridnr,
 adi.weitereustid,
 rf.name_de AS prueffeld,
 cei.invalid_content AS gepruefterinhalt,
 cei.additional_info_de AS zusaetzlinfo,
 SUBSTR(cei.additional_info_de, 8, 4) AS ekorg,
 MAX(ctr.first_negative_test) AS fehlerhaftseit,
 MAX(ctr.due_date) AS faehligkeitsdatum,
 MAX(crbcs.check_rule_by_country_calculation_time) AS ref_calculation_time
FROM idq_production_dwh.check_test_result AS ctr
 INNER JOIN idq_production_dwh.idq_test_object AS ito ON ctr.idq_test_object_id = ito.idq_test_object_id
 INNER JOIN idq_production_idq_results.idq_addinfo_zsm_supplier_sst AS adi ON ito.idq_test_object_id = adi.test_object_id
  
 INNER JOIN idq_production_idq_results.ref_rule AS rrl ON ctr.ref_rule_id = rrl.id
 INNER JOIN idq_production_idq_results.ref_rel_rule_group_rule AS rgr ON rrl.id = rgr.rule_id
 INNER JOIN idq_production_idq_results.ref_rule_group AS rrg ON rgr.rule_group_id = rrg.id
 INNER JOIN idq_production_idq_results.ref_criticality AS rcr ON rrl.criticality_id = rcr.id
 INNER JOIN idq_production_idq_results.ref_field AS rf ON rrl.field_id = rf.id
 INNER JOIN idq_production_idq_results.check_error_info_current AS cei ON ito.idq_test_object_id = cei.test_object_id
  AND rrl.id = cei.rule_id
 INNER JOIN idq_production_dwh.check_rule_by_country_summary AS crbcs ON ctr.ref_rule_id = crbcs.ref_rule_id
WHERE ctr.ref_rule_id = 383
 AND ctr.is_error_detected = 1
GROUP BY regel_id,
 rrl.catalog_id,
 regelkurzbeschreibung,
 fehlermeldung,
 regelgruppename,
 kritikalitaet,
 ito.score,
 objekt_id,
 liefnr,
 lieferant,
 adi.statuslieferant,
 adi.kontengruppe,
 eksnummer,
 adi.land,
 adi.m,
 adi.nf,
 adi.em,
 adi.o_g,
 adi.b_p,
 adi.imp,
 adi.verhandelndesland,
 umsatzsteueridnr,
 adi.weitereustid,
 prueffeld,
 gepruefterinhalt,
 zusaetzlinfo,
 ekorg;