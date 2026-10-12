-- FE_MSTR_LOGOP.V_LU_WAMAS_LAZK source


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_wamas_lazk (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), lazid_lazmr
OPTIONS(description='Warehouse Area number'), lazid_laztyp OPTIONS(description='Warehouse Area type'), lagerzone_desc
OPTIONS(description='Description of warehouse area')) OPTIONS(DESCRIPTION = `LOOKUP VIEW FOR WAREHOUSE AREA OF WAMAS`)
AS SELECT client_id,
 wh_id,
 lazid_laznr AS lazid_lazmr,
 lazid_laztyp,
 lagerzone_desc
FROM ldl_logop_data.t_wamas_lazk
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND lazid_laztyp IN ('KOM')
 AND NOT deleted_fg;