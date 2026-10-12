CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_ewmps_lazk_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), lazid_laznr
OPTIONS(description='Warehouse Area number'), lazbez OPTIONS(description='Description of warehouse area'))
OPTIONS(DESCRIPTION = `LOOKUP VIEW FOR WAREHOUSE AREA OF EWM PS`) AS SELECT client_id,
 wh_id,
 lazid_laznr,
 lazbez
FROM ldl_logop_data.t_ewmps_lazk_2
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND NOT deleted_fg;