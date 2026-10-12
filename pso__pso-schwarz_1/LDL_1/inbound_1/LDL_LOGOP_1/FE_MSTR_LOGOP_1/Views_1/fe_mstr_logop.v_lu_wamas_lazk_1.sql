-- FE_MSTR_LOGOP.V_LU_WAMAS_LAZK_1 source 

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LU_WAMAS_LAZK_1(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code',
	WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	LAZID_LAZMR COMMENT 'Warehouse Area number',
	LAZID_LAZTYP COMMENT 'Warehouse Area type',
	LAGERZONE_DESC COMMENT 'Description of warehouse area'
) COMMENT='Lookup view for warehouse area of wamas'
 AS
SELECT 
	client_id
   ,wh_id
   ,lazid_laznr
   ,lazid_laztyp
   ,lagerzone_desc
FROM "DATA".T_WAMAS_LAZK_1 
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
AND deleted_fg = FALSE
AND lazid_laztyp IN ('KOM');