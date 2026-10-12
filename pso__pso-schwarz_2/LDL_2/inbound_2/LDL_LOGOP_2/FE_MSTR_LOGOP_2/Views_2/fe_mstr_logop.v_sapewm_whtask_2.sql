/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_whtask_2
Description		|	SAP EWM - base view
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_whtask_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code',
	lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila',
	src_sys COMMENT 'Source system',
	wh_id COMMENT 'Warehouse ID. Subset of Warehouse Number',
	mandt COMMENT 'Client of the EWM system. Source column name: MANDT',
	wh_nr COMMENT 'Warehouse Number/Warehouse Complex. Source column name: LGNUM',
	wh_task_nr COMMENT 'Warehouse Task. Source column name: TANUM',
	wh_task_item COMMENT 'Warehouse Task Item. Source column name: TAPOS',
	hu_fg COMMENT 'Handling Unit_2 Warehouse Task. Source column name: FLGHUTO',
	wh_proc_type COMMENT 'Warehouse Process Type. Source column name: PROCTY',
	wh_proc_cat COMMENT 'Warehouse Process Category. Source column name: TRART',
	wh_proc_cat_desc COMMENT 'Warehouse Process Category Description. Source column name: TRART_TXT',
	act_type COMMENT 'Activity. Source column name: ACT_TYPE',
	strg_proc COMMENT 'Storage Process.Source column name: PRCES',
	strg_proc_step COMMENT 'External Storage Process Step. Source column name: PROCS',
	wh_task_stat COMMENT 'Warehouse Task Status. Source column name: TOSTAT',
	crtd_by COMMENT 'Created By. Source column name: CREATED_BY',
	crtd_on_dt COMMENT 'Created On. Source column name: CREATED_DATE',
	crtd_at_tm COMMENT 'Created At. Source column name: CREATED_TIME',
	conf_by COMMENT 'Confirmed by. Source column name: CONFIRMED_BY',
	conf_dt COMMENT 'Confirmation Date. Source column name: CONFIRMED_DATE',
	conf_tm COMMENT 'Confirmation Time. Source column name: CONFIRMED_TIME',
	exec_rsrc COMMENT 'Executing Resource (Means of Transport or User). Source column name: PRSRC',
	reason COMMENT 'Reason for Movements in the Warehouse. Source column name: REASON',
	exc_cd COMMENT 'Exception Code. Source column name: EXCCODE',
	start_dt COMMENT 'Start Date. Source column name: STARTED_DATE',
	start_tm COMMENT 'Start Time. Source column name: STARTED_TIME',
	prod_nr COMMENT 'Product. Source column name: MATNR',
	prod_desc COMMENT 'Product Short Description. Source column name: MAKTX',
	batch COMMENT 'Batch. Source column name: CHARG',
	stk_type COMMENT 'Stock Type. Source column name: CAT',
	stk_type_desc COMMENT 'Description of Stock Type. Source column name: CAT_TXT',
	stk_doc_cat COMMENT 'Type: Sales_2 Order Stock or Project Stock. Source column name: STOCK_DOCCAT',
	stk_doc_nr COMMENT 'Number of the Sales_2 Order or Project for Special Stock. Source column name: STOCK_DOCNO',
	stk_item_nr COMMENT 'Sales_2 Order Item_2 for Sales_2 Order Stock. Source column name: STOCK_ITMNO',
	doc_cat COMMENT 'Doc. Category for Doc. Reference and Doc.-Related Stocks. Source column name: DOCCAT',
	stk_usage COMMENT 'Stock Usage. Source column name: STOCK_USAGE',
	OWNER COMMENT 'Owner. Source column name: OWNER',
	owner_role COMMENT 'Partner Role of Owner. Source column name: OWNER_ROLE',
	entitled COMMENT 'Party Entitled to Dispose. Source column name: ENTITLED',
	entitled_role COMMENT 'Partner Role of Party Entitled to Dispose. Source column name: ENTITLED_ROLE',
	src_tgt_qty_buom COMMENT 'Source Target Quantity in Base Unit_2 of Measure. Source column name: VSOLM',
	act_dest_qty_buom COMMENT 'Destination Actual Quantity in Stockkeeping Unit. Source column name: NISTM',
	dest_diff_qty_buom COMMENT 'Destination Difference Quantity in Base Unit_2 of Measure. Source column name: DMENG',
	buom COMMENT 'Base Unit_2 of Measure. Source column name: MEINS',
	src_tgt_qty_auom COMMENT 'Source Target Quantity in Alternate Unit_2 of Measure. Source column name: VSOLA',
	act_dest_qty_auom COMMENT 'Actual Destination Quantity in Alternative Unit. Source column name: NISTA',
	dest_diff_qty_auom COMMENT 'Destination Difference Qty in Alternative Unit. Source column name: DMENA',
	auom COMMENT 'Alternative Unit_2 of Measure for Stockkeeping Unit. Source column name: ALTME',
	act_dest_qty_vuom COMMENT 'Destination Actual Quantity in Valuation Unit_2 of Measure. Source column name: CWQUAN',
	qty_unit_vuom COMMENT 'Unit_2 for Valuation Quantity. Source column name: CWUNIT',
	qty_stat_vuom COMMENT 'Status_2 of Valuation Quantity. Source column name: CWEXACT',
	dest_diff_qty_vuom COMMENT 'Destination Difference Quantity in Valuation Unit_2 of Measure. Source column name: CWQUAN_DIFF',
	catch_wt_qty_diff COMMENT 'Status_2 of Difference in Catch Weight Quantity. Source column name: CWQEXACT_DIFF',
	comb_grp COMMENT 'Combination Group. Source column name: COMBINATION_GRP',
	hu_type COMMENT 'Handling Unit_2 Type. Source column name: LETYP',
	hazard_rat_1 COMMENT 'Hazard Rating 1. Source column name: STOKEY1',
	hazard_rat_2 COMMENT 'Hazard Rating 2. Source column name: STOKEY2',
	net_wt COMMENT 'Loading or Net Weight. Source column name: WEIGHT',
	wt_unit COMMENT 'Weight Unit. Source column name: UNIT_W',
	net_vol COMMENT 'Loading or Net Volume. Source column name: VOLUM',
	vol_unit COMMENT 'Volume Unit. Source column name: UNIT_V',
	cap_consumption COMMENT 'Capacity Consumption. Source column name: CAPA',
	plnd_proc_tm COMMENT 'Planned Proc. Time in Warehouse Task. Source column name: SOLPO',
	tm_unit COMMENT 'Time Unit. Source column name: ZEIEI',
	putaway_plnd COMMENT 'Putaway Physical Inventory Planned. Source column name: PLACE_INV_P',
	putaway_performed COMMENT 'Inventory on Putaway Performed. Source column name: PLACE_INV',
	low_stk_chk_plnd COMMENT 'Low Stock Check Planned. Source column name: LOWCHK_INV_P',
	low_stk_chk_executed COMMENT 'Low Stock Check Executed. Source column name: LOWCHK_INV',
	shelf_life_exp_dt COMMENT 'Shelf Life Expiration Date. Source column name: VFDAT',
	gr_dt COMMENT 'Goods Receipt Date. Source column name: GRDATE',
	gr_proc_tm COMMENT 'Goods Receipt Processing Time. Source column name: GRTIME',
	orig_ctry COMMENT 'Country_2 of Origin. Source column name: COO',
	hazard_substance COMMENT 'Hazardous Substance. Source column name: HAZMAT',
	insp_type COMMENT 'Inspection ID Type. Source column name: INSPTYP',
	insp_doc_nr COMMENT 'QIE Entity: External Identification. Source column name: INSPDOCNO',
	stk_id COMMENT 'Stock Identification of Warehouse Task. Source column name: IDPLATE',
	src_strg_type COMMENT 'Source Storage Type. Source column name: VLTYP',
	src_strg_sect COMMENT 'Source Storage Section. Source column name: VLBER',
	src_strg_bin COMMENT 'Source Storage Bin. Source column name: VLPLA',
	src_log_pos COMMENT 'Source Logical Position of Handling Unit_2 in Storage Bin. Source column name: SLOGPOS',
	src_rsrc COMMENT 'Source Resource (Means of Transport or User). Source column name: SRSRC',
	src_trans_unit_int COMMENT 'Source Transportation Unit_2 (Internal). Source column name: STU_NUM',
	src_trans_unit_ext COMMENT 'Source Transportation Unit. Source column name: STU_NUM_EXT',
	src_carrier COMMENT 'Source Carrier. Source column name: STSP',
	src_loc_type COMMENT 'Source Location_2 Type. Source column name: SLOC_TYPE',
	src_hu COMMENT 'Source Handling Unit. Source column name: VLENR',
	ret_qty COMMENT 'Retention Quantity. Source column name: KQUAN',
	dest_strg_type COMMENT 'Destination Storage Type. Source column name: NLTYP',
	dest_strg_sec COMMENT 'Destination Storage Section. Source column name: NLBER',
	dest_strg_bin COMMENT 'Destination Storage Bin. Source column name: NLPLA',
	dest_log_pos COMMENT 'Destination Logical Position of Handling Unit_2 in Storage Bin,. Source column name: DLOGPOS',
	dest_hu_pos COMMENT 'Handling Unit_2 Position. Source column name: DLOGPOS_EXT_WT',
	dest_rsrc COMMENT 'Destination Resource (Means of Transport or User). Source column name: DRSRC',
	dest_trans_unit_int COMMENT 'Destination Transportation Unit_2 (Internal). Source column name: DTU_NUM',
	dest_trans_unit_ext COMMENT 'Destination Transportation Unit. Source column name: DTU_NUM_EXT',
	dest_carrier COMMENT 'Destination Carrier. Source column name: DTSP',
	dest_loc_type COMMENT 'Destination Loction Type. Source column name: DLOC_TYPE',
	dest_hu COMMENT 'Destination Handling Unit. Source column name: NLENR',
	dest_strg_bin_orig COMMENT 'Original Destination Storage Bin. Source column name: ORIG_NLPLA',
	stk_removal COMMENT 'Stock Removal of Whole, Homogenous Handling Unit. Source column name: HOMVE',
	wht_pass_ind COMMENT 'Indicator: Pass on Warehouse Task to Subsystem. Source column name: KZSUB',
	pick_all COMMENT 'Withdraw All Stock from Storage Bin. Source column name: PICK_ALL',
	doc_cat_ref COMMENT 'Document Category for Document Reference. Source column name: RDOCCAT',
	doc_nr COMMENT 'Document. Source column name: DOCNO',
	doc_item_nr COMMENT 'Document Item_2 for Document-Related Stocks. Source column name: ITEMNO',
	whcount COMMENT 'Count Request. Source column name: WHCOUNT',
	wave COMMENT 'Wave. Source column name: WAVE',
	wave_item COMMENT 'Wave Item. Source column name: WAVE_ITM',
	two_step_pick_type COMMENT 'Warehouse Task Type Within Two-Step Picking. Source column name: L2SKA',
	two_step_pick_rel COMMENT 'Relevance for Two-Step Picking. Source column name: L2SKR',
	stk_doc_cat_q COMMENT 'Document Category for Document-Related Stocks. Source column name: QDOCCAT',
	stk_doc_nr_q COMMENT 'Document Number for Stock Reference. Source column name: QDOCNO',
	stk_item_nr_q COMMENT 'Item_2 Number of Stock Reference. Source column name: QITEMNO',
	stk_id_q COMMENT 'Identification Number of Stock. Source column name: QIDPLATE',
	plnd_comp_dt COMMENT 'Planned Completion Date. Source column name: PICK_COMP_DATE',
	plnd_comp_tm COMMENT 'Planned Completion Time. Source column name: PICK_COMP_TIME',
	wh_doc_canc COMMENT 'Cancelled Warehouse Document. Source column name: ORIG_TO',
	act_area COMMENT 'Activity Area. Source column name: AAREA',
	who_act_area COMMENT 'Warehouse Order Activity Area. Source column name: AREAWHO',
	wh_ord_crt_rule COMMENT 'Warehouse Order Creation Rule. Source column name: WCR',
	sort_seq COMMENT 'Sort Sequence. Source column name: PATHSEQ',
	QUEUE COMMENT 'Queue. Source column name: QUEUE',
	hu_type_grp COMMENT 'Handling Unit_2 Type Group. Source column name: HUTYPGRP',
	wave_cat COMMENT 'Wave Category. Source column name: WAVECAT',
	route COMMENT 'Route Name (Identification). Source column name: ROUTE',
	cons_grp COMMENT 'Consolidation Group. Source column name: DSTGRP',
	wh_ord_nr COMMENT 'Warehouse Order Number. Source column name: WHO',
	wh_ord_seq COMMENT 'Internal Sequence of Warehouse Order. Source column name: WHOSEQ ',
	wht_log_nr COMMENT 'Warehouse Task: Log Number. Source column name: TOLOGNO',
	prod_supply_area COMMENT 'Production Supply Area. Source column name: PSA',
	prod_ord COMMENT 'Manufacturing Order. Source column name: PROD_ORDER',
	kanban COMMENT 'Unique Kanban ID. Source column name: KANBAN',
	jit_rel COMMENT 'Relevance for JIT Process. Source column name: JIT_RELEVANCE',
	ordim_dummy COMMENT 'Dummy_2 function in length 1. Source column name: ORDIM_DUMMY',
	cert_nr COMMENT 'Certificate Number. Source column name: ZEUGN',
	seq_nr COMMENT 'Sequence Number. Source column name: ZZCAP_SEQNO',
	superstruct_fg COMMENT 'EEW: LIDL Superstructure flag. Source column name: ZZ_SUPERSTRUCT_F',
	capa_fg COMMENT 'Capacity Consumption. Source column name: ZZ_FCAPA',
	zz_hu_type COMMENT 'Handling Unit_2 Type. Source column name: ZZ_SETTYPE',
	zz_hu_id_1 COMMENT 'Handling Unit_2 Identification. Source column name: ZZ_SETHU_1',
	zz_hu_id_2 COMMENT 'Handling Unit_2 Identification. Source column name: ZZ_SETHU_2',
	zz_hu_id_3 COMMENT 'Handling Unit_2 Identification. Source column name: ZZ_SETHU_3',
	zz_hu_id_4 COMMENT 'Handling Unit_2 Identification. Source column name: ZZ_SETHU_4',
	promo_stk_fg COMMENT 'Flag for promotional stock. Source column name: ZZ_PROMOTIONKNZ',
	mvmt_grp COMMENT 'Movement Group (SRM). Source column name: ZZMVGRP',
	grp_id COMMENT 'Group ID. Source column name: ZZ_GRP_ID',
	grp_type COMMENT 'Group Type. Source column name: ZZ_GRP_TYP',
	virtual_bin_pass COMMENT 'Virtual Bin passed. Source column name: ZZ_VB_PASSED',
	grp_id_pass COMMENT 'Group ID passed. Source column name: ZZ_GRP_PASSED',
	rep_sort COMMENT 'REPL Sort/Prio. Source column name: ZZ_REPL_SORT',
	src_tgt_qty_auom_vsola_pc COMMENT 'Source Target Quantity in Alternative UoM for RF Display PC. Source column name: ZZ_VSOLA_PC_CHR',
	char_based_qty_auom_nista_pc COMMENT 'RF Character Based Quantity Input Field for NISTA PC. Source column name: ZZ_NISTA_PC_VERIF',
	act_qty_auom_nista_pc COMMENT 'Actual Quantity in Alternative Unit_2 of Measure PC. Source column name: ZZ_NISTA_PC',
	auom_altme_pc COMMENT 'Alternative Unit_2 of Measure PC. Source column name: ZZ_ALTME_PC',
	src_tgt_qty_auom_vsola_case COMMENT 'Source Target Quantity in Alternative UoM for RF Display Cas. Source column name: ZZ_VSOLA_CASE_CHR',
	char_based_qty_auom_nista_case COMMENT 'RF Character Based Quantity Input Field for NISTA Case. Source column name: ZZ_NISTA_CASE_VERIF',
	act_qty_auom_nista_case COMMENT 'Actual Quantity in Alternative Unit_2 of Measure Case. Source column name: ZZ_NISTA_CASE',
	auom_altme_case COMMENT 'Alternative Unit_2 of Measure Case. Source column name: ZZ_ALTME_CASE',
	canc_by_repack COMMENT 'Canceled by Repack Function. Source column name: ZZ_CANC_REPACK',
	act_qty_auom_case COMMENT 'Actual Quantity in Alternative Unit_2 of Measure Case. Source column name: ZZ_QTY_CASE',
	auom_case COMMENT 'Alternative Unit_2 of Measure Case. Source column name: ZZ_AUOM_CASE',
	store_nr COMMENT 'Store Number. Source column name: ZZ_SHIP_TO',
	store_name COMMENT 'Store Name. Source column name: ZZ_SHIP_TO_NAME',
	prod_vlenr COMMENT 'Product. Source column name: ZZ_VLENR_PMAT_GUID',
	prod_nlenr COMMENT 'Product. Source column name: ZZ_NLENR_PMAT_GUID',
	priority COMMENT 'Priority. Source column name: PRIORITY',
	mat_doc_nr COMMENT 'Number of Material Document. Source column name: MMIM_MBLNR',
	mat_doc_year COMMENT 'Material Document Year. Source column name: MMIM_MJAHR',
	mat_doc_item COMMENT 'Item_2 in Material Document. Source column name: MMIM_ZEILE',
	mig_post_dt COMMENT 'Posting Date in Inventory Management for Migration to EWM. Source column name: MMIM_BUDAT_MIGRATION',
	acc_cat COMMENT 'Account_2 Assignment Category. Source column name: ACC_CAT',
	acc_obj COMMENT 'Account_2 Assignment Object. Source column name: ACC_OBJ_EXT',
	acc_obj_sub COMMENT 'Account_2 Assignment Subobject. Source column name: ACC_OBJ_SUB_EXT',
	pas_ind COMMENT 'Warehouse Task Relevant to Preallocated Stock. Source column name: PAS_IND',
	dwh_load_id COMMENT 'Load id',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at'
) COMMENT = 'SAP EWM - base view for warehouse tasks'
AS
SELECT
	client_id
	, lidl_country AS lidl_ctry
	, source_system AS src_sys
	, wh_id
	, mandt
	, lgnum AS wh_nr
	, tanum AS wh_task_nr
	, tapos AS wh_task_item
	, flghuto AS hu_fg
	, procty AS wh_proc_type
	, trart AS wh_proc_cat
	, trart_txt AS wh_proc_cat_desc
	, act_type
	, prces AS strg_proc
	, procs AS strg_proc_step
	, tostat AS wh_task_stat
	, created_by AS crtd_by
	, created_date AS crtd_on_dt
	, created_time AS crtd_at_tm
	, confirmed_by AS conf_by
	, confirmed_date AS conf_dt
	, confirmed_time AS conf_tm
	, prsrc AS exec_rsrc
	, reason
	, exccode AS exc_cd
	, started_date AS start_dt
	, started_time AS start_tm
	, matnr AS prod_nr
	, maktx AS prod_desc
	, charg AS batch
	, cat AS stk_type
	, cat_txt AS stk_type_desc
	, stock_doccat AS stk_doc_cat
	, stock_docno AS stk_doc_nr
	, stock_itmno AS stk_item_nr
	, doccat AS doc_cat
	, stock_usage AS stk_usage
	, OWNER
	, owner_role
	, entitled
	, entitled_role
	, vsolm AS src_tgt_qty_buom
	, nistm AS act_dest_qty_buom
	, dmeng AS dest_diff_qty_buom
	, meins AS buom
	, vsola AS src_tgt_qty_auom
	, nista AS act_dest_qty_auom
	, dmena AS dest_diff_qty_auom
	, altme AS auom
	, cwquan AS act_dest_qty_vuom
	, cwunit AS qty_unit_vuom
	, cwexact AS qty_stat_vuom
	, cwquan_diff AS dest_diff_qty_vuom
	, cwqexact_diff AS catch_wt_qty_diff
	, combination_grp AS comb_grp
	, letyp AS hu_type
	, stokey1 AS hazard_rat_1
	, stokey2 AS hazard_rat_2
	, weight AS net_wt
	, unit_w AS wt_unit
	, volum AS net_vol
	, unit_v AS vol_unit
	, capa AS cap_consumption
	, solpo AS plnd_proc_tm
	, zeiei AS tm_unit
	, place_inv_p AS putaway_plnd
	, place_inv AS putaway_performed
	, lowchk_inv_p AS low_stk_chk_plnd
	, lowchk_inv AS low_stk_chk_executed
	, vfdat AS shelf_life_exp_dt
	, grdate AS gr_dt
	, grtime AS gr_proc_tm
	, coo AS orig_ctry
	, hazmat AS hazard_substance
	, insptyp AS insp_type
	, inspdocno AS insp_doc_nr
	, idplate AS stk_id
	, vltyp AS src_strg_type
	, vlber AS src_strg_sect
	, vlpla AS src_strg_bin
	, slogpos AS src_log_pos
	, srsrc AS src_rsrc
	, stu_num AS src_trans_unit_int
	, stu_num_ext AS src_trans_unit_ext
	, stsp AS src_carrier
	, sloc_type AS src_loc_type
	, vlenr AS src_hu
	, kquan AS ret_qty
	, nltyp AS dest_strg_type
	, nlber AS dest_strg_sec
	, nlpla AS dest_strg_bin
	, dlogpos AS dest_log_pos
	, dlogpos_ext_wt AS dest_hu_pos
	, drsrc AS dest_rsrc
	, dtu_num AS dest_trans_unit_int
	, dtu_num_ext AS dest_trans_unit_ext
	, dtsp AS dest_carrier
	, dloc_type AS dest_loc_type
	, nlenr AS dest_hu
	, orig_nlpla AS dest_strg_bin_orig
	, homve AS stk_removal
	, kzsub AS wht_pass_ind
	, pick_all
	, rdoccat AS doc_cat_ref
	, docno AS doc_nr
	, itemno AS doc_item_nr
	, whcount
	, wave
	, wave_itm AS wave_item
	, l2ska AS two_step_pick_type
	, l2skr AS two_step_pick_rel
	, qdoccat AS stk_doc_cat_q
	, qdocno AS stk_doc_nr_q
	, qitemno AS stk_item_nr_q
	, qidplate AS stk_id_q
	, pick_comp_date AS plnd_comp_dt
	, pick_comp_time AS plnd_comp_tm
	, orig_to AS wh_doc_canc
	, aarea AS act_area
	, areawho AS who_act_area
	, wcr AS wh_ord_crt_rule
	, pathseq AS sort_seq
	, QUEUE
	, hutypgrp AS hu_type_grp
	, wavecat AS wave_cat
	, route
	, dstgrp AS cons_grp
	, who AS wh_ord_nr
	, whoseq AS wh_ord_seq
	, tologno AS wht_log_nr
	, psa AS prod_supply_area
	, prod_order AS prod_ord
	, kanban
	, jit_relevance AS jit_rel
	, ordim_dummy
	, zeugn AS cert_nr
	, zzcap_seqno AS seq_nr
	, zz_superstruct_f AS superstruct_fg
	, zz_fcapa AS capa_fg
	, zz_settype AS zz_hu_type
	, zz_sethu_1 AS zz_hu_id_1
	, zz_sethu_2 AS zz_hu_id_2
	, zz_sethu_3 AS zz_hu_id_3
	, zz_sethu_4 AS zz_hu_id_4
	, zz_promotionknz AS promo_stk_fg
	, zzmvgrp AS mvmt_grp
	, zz_grp_id AS grp_id
	, zz_grp_typ AS grp_type
	, zz_vb_passed AS virtual_bin_pass 
	, zz_grp_passed AS grp_id_pass
	, zz_repl_sort AS rep_sort
	, zz_vsola_pc_chr AS src_tgt_qty_auom_vsola_pc
	, zz_nista_pc_verif AS char_based_qty_auom_nista_pc
	, zz_nista_pc AS act_qty_auom_nista_pc
	, zz_altme_pc AS auom_altme_pc
	, zz_vsola_case_chr AS src_tgt_qty_auom_vsola_case 
	, zz_nista_case_verif AS char_based_qty_auom_nista_case
	, zz_nista_case AS act_qty_auom_nista_case
	, zz_altme_case AS auom_altme_case
	, zz_canc_repack AS canc_by_repack
	, zz_qty_case AS act_qty_auom_case
	, zz_auom_case AS auom_case
	, zz_ship_to AS store_nr
	, zz_ship_to_name AS store_name
	, zz_vlenr_pmat_guid AS prod_vlenr
	, zz_nlenr_pmat_guid AS prod_nlenr
	, priority
	, mmim_mblnr AS mat_doc_nr
	, mmim_mjahr AS mat_doc_year
	, mmim_zeile AS mat_doc_item
	, mmim_budat_migration AS mig_post_dt
	, acc_cat
	, acc_obj_ext AS acc_obj
	, acc_obj_sub_ext AS acc_obj_sub
	, pas_ind
	, dwh_load_id
	, dwh_created
	, dwh_updated 
FROM DATA.t_sapewm_warehousetask_2 -- PK (client_id, lgnum, tanum, tapos)
;
