/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_inbdlvhdr_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-05      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM inbound delivery header
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_inbdlvhdr_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila'
	,src_sys COMMENT 'Source system'
	,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
	,wh_id COMMENT 'Warehouse ID'
	,doc_nr COMMENT 'Document - Technical name: DOCNO_H - Component Type: /SCWM/SP_DOCNO_INT'
	,ship_from_nr COMMENT 'Ship-from - Technical name: SHIP_FROM_PARTY - Component Type: /SCWM/DE_SHIP_FROM'
	,vehicle_nr COMMENT 'Vehicle - Technical name: TRANSMEANS_ID - Component Type: /SCWM/DE_VEH_NUM_EXT'
	,transport_unit COMMENT 'Transportation Unit_2 - Technical name: TU - Component Type: /SCWM/DE_TU_NUM_EXT'
	,adv_ship_notif COMMENT 'Advanced Shipping Notification - Technical name: REFDOCNO_EXTASN - Component Type: /SCWM/SP_DOCNO_ASN'
	,lia_nr COMMENT 'LIA Number - Technical name: ZZ_EXREF - Component Type: ZEWM_E_EXREF'
	,wh_door_nr COMMENT 'Warehouse Door - Technical name: DOOR - Component Type: /SCWM/DE_DOOR'
	,item_cnt COMMENT 'Number of Items - Technical name: NO_ITEM - Component Type: /SCWM/DE_WIP_WHRHEAD_NOITM'
	,prod_cnt COMMENT 'Number of Products - Technical name: NO_PRODUCT - Component Type: /SCWM/DE_WIP_WHRHEAD_NOPROD'
	,plnd_dlv_dt COMMENT 'Delivery Date (Planned) - Technical name: DLV_DATE - Component Type: /SCWM/SP_DELDATE'
	,plnd_dlv_tm COMMENT 'Delivery Time (Planned) - Technical name: DLV_TIME - Component Type: /SCWM/SP_DELTIME'
	,crtd_on_dt COMMENT 'Created On - Technical name: TDELIVERY_CRE_DATE - Component Type: /SCWM/SP_CREDAT'
	,crtd_at_tm COMMENT 'Created At - Technical name: TDELIVERY_CRE_TIME - Component Type: /SCWM/SP_CRETIM'
	,pur_ord_nr COMMENT 'Purchase Order - Technical name: PO_NUMBER - Component Type: /SCWM/DE_WIP_DOCNO_PO'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
) COMMENT = 'SAP EWM inbound delivery header (materialized view based on table t_logop_sapewm_inbdlvhdr_2)'
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_nr
	,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
	,doc_nr
	,ship_from_nr
	,vehicle_nr
	,transport_unit
	,adv_ship_notif
	,lia_nr
	,wh_door_nr
	,item_cnt
	,product_cnt AS prod_cnt
	,planned_dlv_dt AS plnd_dlv_dt
	,planned_dlv_tm AS plnd_dlv_tm
	,crtd_on_dt
	,crtd_at_tm
	,purchase_order_nr AS pur_ord_nr
	,dwh_load_id
	,dwh_created
	,dwh_updated
FROM DATA.t_logop_sapewm_inbdlvhdr_2
;
