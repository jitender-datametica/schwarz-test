/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_wms_wamas_prod
Description		|	LPV source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lpv_wms_wamas_prod (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'),
auftrag STRING(12) NOT NULL OPTIONS(description='Task number. Original name - auftrag'),
tanr BIGNUMERIC(38,0) OPTIONS(description='Task number in WAMAS. Original name - tanr'),
status STRING(6) OPTIONS(description='Task status. Original name - status'),
typ STRING(4) OPTIONS(description='Task type. Original name - typ'),
artikelnr STRING(20) OPTIONS(description='Item number. FK: References LPV.AST.ANR. Original name - artikelnr'),
prio BIGNUMERIC(38,0) OPTIONS(description='Priority. Original name - prio'),
quelle STRING(16) OPTIONS(description='N/A. Original name - quelle'),
anlagezeit DATETIME OPTIONS(description='Time stamp of the record creation. Original name - anlagezeit'),
aenderungskz BIGNUMERIC(38,0) OPTIONS(description='Change flag. Original name - aenderungskz'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, auftrag, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='LPV - Table shows all open and active replenishment tasks and putaway tasks for non-LPV items (bulk). The data shown here is live.');