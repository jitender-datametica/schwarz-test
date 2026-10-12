CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_capacity AS SELECT *
FROM ldl_autodispo_core.t_oracle_v_dim_capacity
WHERE deleted = 0;