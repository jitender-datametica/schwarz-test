CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_excluded_2 AS SELECT *
FROM ldl_autodispo_core.t_oracle_v_fk_excluded_2
WHERE deleted = 0;