CREATE OR REPLACE VIEW szd_fe_mstr_service_and_support.v_dim_ticket_type (ticket_type_id, ticket_type_name,
synonym_ticket_type_name) AS SELECT ticket_type_id,
 ticket_type_name,
 synonym_ticket_type_name
FROM szd_core.t_dim_ticket_type;