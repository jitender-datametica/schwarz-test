CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_transport_route_type_1 (transport_route_type_cd, dwh_created_tmsp,
dwh_updated_tmsp, dwh_src_file_name, dwh_src_1_tmsp) AS SELECT transport_route_type_cd,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_src_file_name,
 dwh_src_1_tmsp
FROM szd_core.t_dim_transport_route_type_1;