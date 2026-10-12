CREATE OR REPLACE VIEW idq_production_dwh.ref_rule_sys_check_1 (ref_rule_id, ref_rule_id_de, ref_rule_id_en,
ref_rule_type_id, catalog_id, ref_field_id, rule_technical_name, rule_short_description, rule_short_description_de,
rule_short_description_en, rule_description, rule_description_de, rule_description_en, ref_criticality_id,
ref_dimension_id, error_text, error_text_de, error_text_en, version, ref_status_id, first_idq_release,
ref_source_system_type_id, sdc_object_id, sdc_object_info, rule_docu, solution) AS SELECT rr.id AS ref_rule_id,
 rr.id AS ref_rule_id_de,
 rr.id AS ref_rule_id_en,
 rr.rule_type_id AS ref_rule_type_id,
 rr.catalog_id,
 rr.field_id AS ref_field_id,
 rr.name AS rule_technical_name,
 rr.short_description_de AS rule_short_description,
 rr.short_description_de AS rule_short_description_de,
 rr.short_description_en AS rule_short_description_en,
 rr.description_de AS rule_description,
 rr.description_de AS rule_description_de,
 rr.description_en AS rule_description_en,
 rr.criticality_id AS ref_criticality_id,
 rr.dimension_id AS ref_dimension_id,
 rr.error_text_de AS error_text,
 rr.error_text_de,
 rr.error_text_en,
 rr.version,
 rr.status_id AS ref_status_id,
 rr.first_idq_release,
 rf.source_system_type_id AS ref_source_system_type_id,
  'https://sdc-prod.sys.schwarz/MH-SDC/dg/index.jsp#/abvdl-component?objectViewType=DETAILS&objID=' || CAST(rr.sdc_object_id AS STRING)
   AS sdc_object_id,
      '<a href=""' || 'https://sdc-prod.sys.schwarz/MH-SDC/dg/index.jsp#/abvdl-component?objectViewType=DETAILS&objID='
     || CAST(rr.sdc_object_id AS STRING) || '"" target=""_blank""><img src=""' ||
   'https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">'
    || '</img></a>' AS sdc_object_info,
  CASE
  WHEN rf.source_system_type_id = 2
  THEN '<A HREF=""' || 'https://confluence.schwarz/download/attachments/238783555/' || CAST(rr.id AS STRING) || '_' ||
     rr.short_description_de ||
    '.pdf?api=v2"" target=""_blank""><img src=""https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">'
     || '</img></A>'
  WHEN rf.source_system_type_id = 3
  THEN '<A HREF=""' || 'https://confluence.schwarz/download/attachments/70145386/' || CAST(rr.id AS STRING) || '_' || rr
     .short_description_de ||
    '.docx?api=v2"" target=""_blank""><img src=""https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">'
     || '</img></A>'
  WHEN rf.source_system_type_id = 1
  THEN '<A HREF=""' || 'https://confluence.schwarz/download/attachments/98451080/' || CAST(rr.id AS STRING) ||
    '.pdf?api=v2"" target=""_blank""><img src=""https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">'
     || '</img></A>'
  WHEN rf.source_system_type_id = 8
  THEN '<A HREF=""' || 'https://confluence.schwarz/download/attachments/76855933/' || CAST(rr.id AS STRING) || '_' || rr
     .short_description_de ||
    '.docx?api=v2"" target=""_blank""><img src=""https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">'
     || '</img></A>'
  WHEN rf.source_system_type_id = 14
  THEN '<A HREF=""""' || CAST(rr.id AS STRING) ||
    '"" target=""_blank""> <img src=""https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2"" width=""24"" height=""24"">'
     || '</img></A>'
  ELSE NULL
  END AS rule_docu,
 rr.solution
FROM idq_production_idq_results.ref_rule_1 AS rr
 INNER JOIN idq_production_idq_results.ref_field_1 AS rf ON rr.field_id = rf.id
WHERE rr.rule_type_id = 1;