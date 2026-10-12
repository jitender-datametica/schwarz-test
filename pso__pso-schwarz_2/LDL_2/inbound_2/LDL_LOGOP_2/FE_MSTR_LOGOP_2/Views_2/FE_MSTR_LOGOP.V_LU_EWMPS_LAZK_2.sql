CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LU_EWMPS_LAZK_2(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_2 code'
	,WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)'
	,LAZID_LAZNR COMMENT 'Warehouse Area number'
	,LAZBEZ COMMENT 'Description of warehouse area'
) COMMENT='Lookup view for warehouse area of EWM PS'
 AS
 SELECT 
	client_id
   ,wh_id
   ,lazid_laznr
   ,lazbez
FROM "DATA".T_EWMPS_LAZK_2
WHERE CURRENT_DATE BETWEEN DWH_VALID_FROM AND DWH_VALID_TO AND DELETED_FG = FALSE
;