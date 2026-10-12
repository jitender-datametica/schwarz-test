CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_PACKING_TYPE_1(
	PACKING_TYPE_CD COMMENT 'The code identifying the way, how a product is packed.',
	PACKING_TYPE_DESCR COMMENT 'A textual description for the way how a product is packed in group language, i.e. in German.',
	PACKING_TYPE_DESCR_DE COMMENT 'A textual description for the way how a product is packed in German.',
	PACKING_TYPE_DESCR_EN COMMENT 'A textual description for the way how a product is packed in English.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor dimension defines the ways how a product (item_1) can be packed. E.g. box, bag, tin, ...'
 AS SELECT 
     main.packing_type_cd 
   , main.packing_type_descr 
   , main.packing_type_descr_de 
   , main.packing_type_descr_en 
   , main.dwh_created_tmsp 
   , main.dwh_updated_tmsp 
   , main.dwh_load_id 
   , main.dwh_node_cd
 FROM CORE_DIM.T_DIM_PACKING_TYPE_1 main;