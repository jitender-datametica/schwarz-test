/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_forklift_exception_kpi_1
Description		|	SAP EWM Forklift Exception - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_forklift_exception_kpi_1(
	client_id COMMENT 'Client id (PK)',
	wh_id COMMENT 'Warehouse ID (PK)',
	wh_task_nr COMMENT 'Warehouse Task (PK)',
	conf_dt COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE',
	conf_tm COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME',
	src_hu COMMENT 'Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	movement_type COMMENT 'Movement type',
	rsrc_type COMMENT 'Resource type',
	wh_area COMMENT 'Warehouse area',
	exc_cd COMMENT 'Exception Code - Technical name: EXCCODE - Component Type: /SCWM/DE_EXCCODE',
	except_fg COMMENT 'Flag to indicate if the exception occurred',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at'
) COMMENT='SAP EWM forklift report exception handling - KPI view (based on v_sapewm_forklift_exception_add_1)'
 AS
 SELECT
 	 client_id
    , wh_id
    , wh_task_nr
    , conf_dt
    , conf_tm
    , src_hu
    , movement_type
    , rsrc_type
    , wh_area
    , exc_cd
    , except_fg
    , dwh_created
    , dwh_updated
 FROM fe_mstr_logop.v_sapewm_forklift_exception_add_1;