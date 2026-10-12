/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_whattr_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-09-30      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM warehouse attributes
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_whattr_2 (
    client_id COMMENT 'Client id - calculated based on the country_2 code'
    ,lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila'
    ,src_sys COMMENT 'Source system'
    ,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
    ,wh_id COMMENT 'Warehouse ID'
    ,prod_nr COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'
    ,prod_desc COMMENT 'Product Description - Technical name: MAKTX - Component Type: /SCMB/MDL_PRODUCT_TEXT'
    ,party_entitled_dispose COMMENT 'Party Entitled to Dispose - Technical name: ENTITLED - Component Type: /SCWM/DE_ENTITLED'
    ,buom COMMENT 'Base Unit_2 of Measure - Technical name: MEINS - Component Type: /SAPAPO/MEINS'
    ,mat_grp COMMENT 'Material Group - Technical name: MATKL - Component Type: /SAPAPO/MATKL'
    ,transp_grp COMMENT 'Transportation Group - Technical name: TRAGR - Component Type: /SAPAPO/TRAGR'
    ,strg_sec COMMENT 'Storage Section Indicator - Technical name: LGBKZ - Component Type: /SCWM/LVS_LGBKZ'
    ,paci COMMENT 'Putaway Control - Technical name: PUT_STRA - Component Type: /SCWM/DE_PUT_STRA'
    ,srci COMMENT 'Stock Removal Control - Technical name: REM_STRA - Component Type: /SCWM/DE_REM_STRA'
    ,staging_area COMMENT 'Staging Area/Door Determination Group - Technical name: DRDETGR - Component Type: /SCWM/DE_DRDETGR'
    ,dwh_load_id COMMENT 'Load id'
    ,dwh_created COMMENT 'Record created at'
    ,dwh_updated COMMENT 'Record updated at'
    ,dwh_valid_from COMMENT 'Valid from date'
    ,dwh_valid_to COMMENT 'Valid to date'
    ,deleted_fg COMMENT 'Flag if record is deleted'
) COMMENT = 'SAP EWM warehouse attributes (materialized view based on table t_logop_sapewm_warehouseattributes_2)'
AS
SELECT
    client_id
    ,lidl_country AS lidl_ctry
    ,source_system AS src_sys
    ,wh_nr
    ,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
    ,product_nr AS prod_nr
    ,product_desc AS prod_desc
    ,party_entitled_dispose
    ,buom
    ,mat_grp
    ,transp_grp
    ,strg_sec
    ,paci
    ,srci
    ,staging_area
    ,dwh_load_id
    ,dwh_created
    ,dwh_updated
    ,dwh_valid_from
    ,dwh_valid_to
    ,deleted_fg
FROM DATA.t_logop_sapewm_warehouseattributes_2
;
