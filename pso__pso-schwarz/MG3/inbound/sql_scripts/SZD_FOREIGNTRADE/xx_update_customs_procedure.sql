insert into  core_rel.t_customs_procedure
(customs_procedure_cd, requested_procedure_cd,
additional_procedure_cd, approved_fg, dwh_created_tmsp,
dwh_updated_tmsp, dwh_src_file_name, dwh_src_1_tmsp)
select customs_procedure_cd, requested_procedure_cd,
additional_procedure_cd, approved_fg, dwh_created_tmsp,
dwh_updated_tmsp, dwh_src_file_name, dwh_src_1_tmsp 
from etl.t_cache_customs_procedure
where customs_procedure_cd not in (select distinct customs_procedure_cd
from core_rel.t_customs_procedure);
