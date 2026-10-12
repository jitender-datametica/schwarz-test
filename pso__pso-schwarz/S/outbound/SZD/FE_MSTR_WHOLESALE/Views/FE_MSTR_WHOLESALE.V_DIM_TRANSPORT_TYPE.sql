CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_transport_type (transport_type_cd, transport_route_type_cd,
wholesale_cd, wholesale_label_descr, foreigntrade_id, foreigntrade_label_descr, dwh_created_tmsp, dwh_updated_tmsp,
dwh_src_file_name, dwh_src_1_tmsp) AS SELECT transport_type_cd,
 transport_route_type_cd,
 wholesale_cd,
 wholesale_label_descr,
 foreigntrade_id,
 foreigntrade_label_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_src_file_name,
 dwh_src_1_tmsp
FROM szd_core.t_dim_transport_type;