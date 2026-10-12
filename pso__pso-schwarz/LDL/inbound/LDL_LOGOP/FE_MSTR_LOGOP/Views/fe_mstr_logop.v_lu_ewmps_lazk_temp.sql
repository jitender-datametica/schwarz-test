-- ETL_PROCESS.T_EWMPS_LAZK_TEMPFE_MSTR_LOGOP.V_LU_EWMPS_LAZK source

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LU_EWMPS_LAZK_TEMP(
	CLIENT_ID COMMENT 'Client id - calculated based on the country code',
	WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	LAZID_LAZNR COMMENT 'Warehouse Area number',
	LAZID_LAZTYP COMMENT 'Warehouse Area type',
	LAGERZONE_DESC COMMENT 'Description of warehouse area'
) COMMENT='Lookup view for warehouse area of EWM PS'
 AS
SELECT 
	client_id
   ,wh_id
   ,lazid_laznr
   ,lazid_laztyp
   ,lagerzone_desc
FROM "ETL_PROCESS".T_EWMPS_LAZK_TEMP;