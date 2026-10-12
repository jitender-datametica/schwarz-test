INSERT INTO szd_production_core_rel.t_customs_procedure (customs_procedure_cd, requested_procedure_cd,
 additional_procedure_cd, approved_fg, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, dwh_src_1_tmsp)
(SELECT customs_procedure_cd,
  requested_procedure_cd,
  additional_procedure_cd,
  approved_fg,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_src_file_name,
  dwh_src_1_tmsp
 FROM szd_production_etl.t_cache_customs_procedure
 WHERE customs_procedure_cd NOT IN (SELECT DISTINCT customs_procedure_cd
    FROM szd_production_core_rel.t_customs_procedure));