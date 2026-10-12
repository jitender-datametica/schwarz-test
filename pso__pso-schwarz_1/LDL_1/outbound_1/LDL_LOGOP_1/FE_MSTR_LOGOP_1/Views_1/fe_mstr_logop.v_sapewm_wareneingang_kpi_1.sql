CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_wareneingang_kpi_1 (client_id
OPTIONS(description='Client id (PK)'), lidl_ctry OPTIONS(description='Country_1 code'), wh_id
OPTIONS(description='Warehouse ID (PK)'), wh_task_nr OPTIONS(description='Warehouse Task (PK)'), wh_proc_cat
OPTIONS(description='Warehouse Process Category - Technical name: TRART - Component Type: /SCWM/LVS_TRART'), doc_nr
OPTIONS(description='Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT'), doc_cat
OPTIONS(description='Document Category for Document-Related Stocks - Technical name: QDOCCAT - Component Type: /SCWM/DE_UI_QDOCCAT'),
prod_nr OPTIONS(description='Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'), prod_desc
OPTIONS(description='Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX'), conf_dt
OPTIONS(description='Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'),
conf_tm
OPTIONS(description='Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'),
conf_ts OPTIONS(description='Confirmation timestamp'), conf_hr OPTIONS(description='Confirmation hour'), confirmed_by
OPTIONS(description='Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY'), src_hu
OPTIONS(description='Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'), src_strg_type
OPTIONS(description='Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP'), dest_hu
OPTIONS(description='Destination Handling Unit_1 - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR'),
dest_strg_type
OPTIONS(description='Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), act_qty_dest_buom
OPTIONS(description='Destination Actual Quantity in Stockkeeping Unit_1 - Technical name: NISTM - Component Type: /SCWM/DE_UI_NISTM'),
auom
OPTIONS(description='Alternative Unit_1 of Measure for Stockkeeping Unit_1 - Technical name: ALTME - Component Type: /SCWM/DE_AUNIT'),
act_dest_qnty_auom
OPTIONS(description='Actual Destination Quantity in Alternative Unit_1 - Technical name: NISTA - Component Type: /SCWM/DE_UI_NISTA'),
receipt_fg OPTIONS(description='Receipt flag for counted pallets')) AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_sapewm_wareneingang_add_1;