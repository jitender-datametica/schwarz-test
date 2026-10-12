/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_forklift_exception_kpi
Description		|	SAP EWM Forklift Exception - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_forklift_exception_kpi (client_id
OPTIONS(description='Client id (PK)'), wh_id OPTIONS(description='Warehouse ID (PK)'), wh_task_nr
OPTIONS(description='Warehouse Task (PK)'), conf_dt
OPTIONS(description='Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'),
conf_tm
OPTIONS(description='Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'),
src_hu OPTIONS(description='Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'),
movement_type OPTIONS(description='Movement type'), rsrc_type OPTIONS(description='Resource type'), wh_area
OPTIONS(description='Warehouse area'), exc_cd
OPTIONS(description='Exception Code - Technical name: EXCCODE - Component Type: /SCWM/DE_EXCCODE'), except_fg
OPTIONS(description='Flag to indicate if the exception occurred'), dwh_created OPTIONS(description='Record created at'),
dwh_updated OPTIONS(description='Record updated at'))
OPTIONS(DESCRIPTION = `SAP EWM FORKLIFT REPORT EXCEPTION HANDLING - KPI VIEW (BASED ON V_SAPEWM_FORKLIFT_EXCEPTION_ADD)`)
AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_sapewm_forklift_exception_add;