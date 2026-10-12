CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_ITEM_1 (
	NFPO_ITEM_SID 									COMMENT 'Surrogate Key NFPO ITEM_1 INSTANCE.
			CBX: CNT_ITEM.REF_NO
			LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID
			CORE_REL:t_nfpo_item.nfpo_item_sid',
	NFPO_ITEM_NR 									COMMENT 'NFPO item_1 instance reference in the source (CBX).
			CBX: CNT_ITEM.REF_NO
			LDL: P_LEW_CORE.T_MDM_ITEM.SRC_ITEM_DOC_REF
			CORE_REL:t_nfpo_item.nfpo_item_nr',
	NFPO_ITEM_NAME 									COMMENT 'NFPO item_1 name.
			CBX: CNT_ITEM.ITEM_DESC, SHORT_DESC
			LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_NAME
			CORE_REL:t_nfpo_item.nfpo_item_name',
	NFPO_ITEM_CREATED_DT 							COMMENT 'Create timestamp of NFPO item_1 instance record in the source system.
			CBX: CNT_ITEM.CREATED_ON
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CBX_ITEM_CREATED_TMSP',
	NFPO_ITEM_DISPLAY_NAME,
	NFPO_ITEM_S_IMAGE_TAG_TXT,
	NFPO_ITEM_XS_IMAGE_TAG_TXT,
	NFPO_ITEM_S_IMAGE_URL_TXT,
	NFPO_ITEM_M_IMAGE_TAG_TXT,
	NFPO_ITEM_M_IMAGE_URL_TXT,
	LDL_ITEM_IAN_NR 								COMMENT 'Lidl International Item_1 Number (not necessarily unique in this table - numbers can be reused if an item_1 is cancelled, or multiple item_1 instances will be created for catalog items).
			CBX: CNT_ITEM.ITEM_NO
			LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_IAN
			CORE_REL:t_nfpo_item.ldl_item_ian_nr',
	NFPO_ITEM_RANGE_PLAN_NR 						COMMENT 'Range selection number (Ausmusterungsnummer), initially assigned to the item_1 instance. Can be different from the range plan number that comes via the advertising theme or the initial range plan number.
			CBX: CNT_ITEM.LDL_LOT_NO
			LDL: P_LEW_CORE.T_MDM_ITEM.RANGE_PLAN_CD
			CORE_REL: T_NFPO_ITEM.NFPO_RANGE_PLAN_NR',
	NFPO_ITEM_SEL_NR 								COMMENT 'NFPO source system (alternative) internal identifier for an article, constituting of a left part representing the range selection quarter in the year and the right the increment number of the counting number sequence of articles present in this range selection.
			CBX: CNT_ITEM.LDL_SELECTION_NO
			LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_SELECTION_NR
			CORE_REL:t_nfpo_item.nfpo_item_sel_nr',
	NFPO_MARKET_REL_ITEM_SID 						COMMENT 'Surrogate Key related NFPO ITEM_1 INSTANCE between US item_1 and non-US item. Between certain markets_1 like US and non-US there are different NFPO_ITEM_SIDs for the same article.
			CBX: CNT_ITEM_RELATED.RELATED_ITEM_REF
			LDL: P_LEW_CORE.T_MDM_ITEM_RELATED_ITEM_HIST.MDM_ITEM_SID_RELATED
			CORE_REL:t_nfpo_item_related_item_hist.nfpo_rel_item_sid',
	NFPO_ITEM_ORIGIN_COUNTRY_SID 					COMMENT 'Foreign Key POLITICAL COUNTRY_1, the manufacturing country_1 of the item.
			CBX: CNT_ITEM.LDL_COUNTRY_OF_ORIGIN
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.COUNTRY_POL_SID_ORIGIN
			CORE_REL: t_nfpo_item_hist.nfpo_item_origin_country_sid',
	NFPO_ITEM_ORIGIN_COUNTRY_CD 					COMMENT 'Item_1 manufacturing political country_1 character ISO code.
			CBX:cnt_codelist.code
			LDL: P_LEW_CORE.t_country_political.src_land1
			core_rel: t_nfpo_country.nfpo_country_cd',
	NFPO_ITEM_ORIGIN_COUNTRY_NAME 					COMMENT 'Item_1 manufacturing political country_1 name.
			CBX: cnt_codelist.name;
			LDL: P_LEW_CORE.t_country_political.country_pol_name
			CORE_REL:t_nfpo_county.nfpo_country_name',
	NFPO_ITEM_STATUS_CD 							COMMENT 'Technical status_1 of the NFPO item_1 in the source system (active, inactive, cancelled).
			CBX: CNT_ITEM.DOC_STATUS
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CBX_ITEM_DOC_STATUS
			CORE_REL:t_nfpo_item_hist.nfpo_item_status_cd',
	NFPO_DEFAULT_CASE_SIZE_QTY						COMMENT 'Predefined number of items in the sort boxes of the item. It is possible that some organizations get packing lists using deviating case sizes.
			CBX: CNT_ITEM.LDL_UNIT_OF_CARTON
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CASE_SIZE_QTY
			CORE_REL: T_NFPO_ITEM_HIST.NFPO_CASE_SIZE_QTY',
	NFPO_SUP_SID 									COMMENT 'Foreign Key NFPO SUPPLIER.
			CBX: CNT_ITEM.LDL_DEFAULT_VENDOR_REF
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_SUP_SID
			CORE_REL:t_nfpo_item_hist.nfpo_sup_sid',
	NFPO_SUP_NR 									COMMENT 'NFPO supplier_1 identifier from the source (CBX).
			CBX: CNT_VENDOR.REF_NO
			LDL: P_LEW_CORE.T_MDM_SUPPLIER.SRC_VENDOR_DOC_REF
			CORE_REL:t_nfpo_supplier.nfpo_sup_nr',
	NFPO_SUP_NAME 									COMMENT 'Name of the NFPO supplier.
			CBX: CNT_VENDOR.BUSINESS_NAME
			LDL: P_LEW_CORE.T_MDM_SUPPLIER.SUP_NAME
			CORE_REL:t_nfpo_supplier.nfpo_sup_name',
	NFPO_GTIN_OWNERSHIP_CD 							COMMENT 'NFPO GTIN assignment responsibility code.
			CBX: CTM_VENDOR.CUST_CODELIST1
			LDL: P_LEW_CORE.t_mdm_item_hist.EAN_OWNERSHIP_CD
			CORE_REL:t_nfpo_item_hist.nfpo_gtin_ownership_cd',
	NFPO_GTIN_OWNERSHIP_DESCR 						COMMENT 'NFPO GTIN assignment responsibility descriptions.
			CBX: CNT_CODELIST.NAME (code list "LIDL_GTIN_OUTPUT")
			LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP.EAN_OWNERSHIP
			CORE: t_dim_nfpo_gtin_ownership.nfpo_gtin_ownership_descr',
	NFPO_SUP_COUNTRY_SID 							COMMENT 'Surrogate Key of the country_1 where the address_1 of the main supplier_1 subsidiary is located in.
			CBX: cnt_vendor_address.country_1
			LDL:p_lew_core.t_address.country_pol_sid
			CORE_REL:t_nfpo_address.nfpo_country_sid',
	NFPO_SUP_COUNTRY_CD 							COMMENT 'The country_1 code where the address_1 of the main supplier_1 subsidiary is located in.
			CBX: cnt_vendor_address.country_1
			CORE_REL:t_nfpo_address.nfpo_country_cd
			LDL:p_lew_core.t_address.country_pol_cd',
	NFPO_SUP_COUNTRY_NAME 							COMMENT 'The country_1 name where the address_1 of the main supplier_1 subsidiary is located in.
			CBX: cnt_codelist.name;
			LDL: P_LEW_CORE.t_country_political.country_pol_name
			CORE_REL:t_nfpo_country.nfpo_country_name',
	NFPO_SUP_STREET_NAME 							COMMENT 'The street name where the address_1 of the main supplier_1 subsidiary is located in.
			CBX: cnt_vendor_address.address1
			LDL:t_address.street
			CORE_REL:t_nfpo_address.street_name',
	NFPO_SUP_CITY_NAME 								COMMENT 'The city name where the address_1 of the main supplier_1 subsidiary is located in.
			CBX: cnt_vendor_address.city
			LDL:t_address.city
			CORE_REL:t_nfpo_address.city_name',
	NFPO_SUP_ZIP 									COMMENT 'The zip code of the address_1 of the main supplier_1 subsidiary.
			CBX: Vendor.postalCode
			LDL:t_address.zip_code
			CORE_REL:t_nfpo_address.zip',
	EKS_SUP_NR 										COMMENT 'Identifier of this subsidiary in EKS.
			CBX: CNT_VENDOR_ADDRESS.LDL_EKS_NO
			LDL: P_LEW_CORE.T_MDM_SUPPLIER_SUBSIDIARY_HIST.EKS_SUP_NR
			CORE_REL:t_nfpo_supplier_subsidiary_hist.eks_sup_nr',
	NFPO_FINAL_SUP_FG 								COMMENT 'Indicates whether the supplier_1 is finally fixed.
			CBX: CNT_ITEM.LDL_FINAL_VENDOR
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.SUP_FINAL_FG
			CORE_REL:t_nfpo_item_hist.nfpo_final_sup_fg',
	NFPO_RFQ_SUP_LIST_TXT 							COMMENT 'List of NFPO supplier_1 identifiers of RFQ suppliers (request for quote: poteantial supplier_1 for an item_1, who were requested for an estimation of costs).
			CBX: CNT_ITEM_SLN.REF_REF (field_id = "ldlRFQVendors")
			LDL: P_LEW_CORE.T_MDM_ITEM_RFQ_SUPPLIER_HIST.MDM_RFQ_SUP_SID
			CORE_REL:t_nfpo_item_rfq_supplier_hist.nfpo_rfq_sup_sid and t_nfpo_supplier.nfpo_sup_nr via nfpo_rfq_sup_sid',
	NFPO_RFQ_SUP_NAME_LIST_TXT 						COMMENT 'List of NFPO supplier_1 names of RFQ suppliers (request for quote: poteantial supplier_1 for an item_1, who were requested for an estimation of costs).
			CBX: CNT_ITEM_SLN.REF_REF (field_id = "ldlRFQVendors")
			LDL: P_LEW_CORE.T_MDM_ITEM_RFQ_SUPPLIER_HIST.MDM_RFQ_SUP_SID
			CORE_REL:t_nfpo_item_rfq_supplier_hist.nfpo_rfq_sup_sid and t_nfpo_supplier.nfpo_sup_name via nfpo_rfq_sup_sid',
	NFPO_MARKET_SID 								COMMENT 'Surrogate Key NFPO MARKET (EU, INT, US).
			CBX: CNT_ITEM.LDL_CONTINENT_TYPE
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MARKET_SID
			CORE_REL:t_nfpo_item_hist.nfpo_market_sid',
	NFPO_MARKET_CD 									COMMENT 'NFPO market code (EU, INT, US).
			CBX: CNT_CODELIST.CODE (code list "LIDL_CONTINENT_TYPE")
			LDL: P_LEW_CORE.T_MDM_MARKET.MARKET_CD
			CORE_REL:t_nfpo_market.nfpo_market_cd',
	NFPO_MARKET_NAME 								COMMENT 'NFPO market name (EU, INT, US).
			CBX: CNT_CODELIST.NAME (code list "LIDL_CONTINENT_TYPE")
			LDL: P_LEW_CORE.T_MDM_MARKET.MARKET
			CORE_REL:t_nfpo_market.nfpo_market_name',
	NFPO_EU_COMPLETION_TYPE_CD 						COMMENT 'NFPO completion type code that defines where the logistics chain ends in EU. (FH or OWIM).
			CBX: CNT_ITEM.LDL_COMPLETION_TYPE, LDL_COMPLETION_TYPE_US
			LDL: P_LEW_CORE.T_MDM_ITEM_MARKET_HIST.MDM_COMPLETION_TYPE_CD
			CORE_REL:t_nfpo_item_market_hist.nfpo_completion_type_cd',
	NFPO_EU_COMPLETION_TYPE_NAME 					COMMENT 'NFPO completion type name that defines where the logistics chain ends in EU. 
			CBX: CNT_CODELIST.NAME (code list "LIDL_OWIMFH" and "LIDL_COMPLTYPE_US")
			LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.MDM_COMPLETION_TYPE_NAME
			CORE_REL:t_nfpo_completion_type.nfpo_completion_type_name',
	NFPO_US_COMPLETION_TYPE_CD 						COMMENT 'NFPO completion type code that defines where the logistics chain ends in US (LEXI).
			CBX: CNT_ITEM.LDL_COMPLETION_TYPE, LDL_COMPLETION_TYPE_US
			LDL: P_LEW_CORE.T_MDM_ITEM_MARKET_HIST.MDM_COMPLETION_TYPE_CD
			CORE_REL:t_nfpo_item_market_hist.nfpo_completion_type_cd',
	NFPO_US_COMPLETION_TYPE_NAME 					COMMENT 'NFPO completion type name that defines where the logistics chain ends in US (LEXI). 
			CBX: CNT_CODELIST.NAME (code list "LIDL_OWIMFH" and "LIDL_COMPLTYPE_US")
			LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.MDM_COMPLETION_TYPE_NAME
			CORE_REL:t_nfpo_completion_type.nfpo_completion_type_name',
	NFPO_EU_INCOTERM_CD 							COMMENT 'NFPO incoterm codes for EU, similar to the terms defined by the International Chamber of Commerce.
			CBX: CNT_ITEM.LDL_INCOTERMS, LDL_INCOTERM_US
			LDL: P_LEW_CORE.T_MDM_ITEM_MARKET_HIST.MDM_INCOTERM_CD
			CORE_REL:t_nfpo_item_market_hist.nfpo_incoterm_cd',
	NFPO_EU_INCOTERM_NAME 							COMMENT 'NFPO incoterm names for  EU, similar to the terms defined by the International Chamber of Commerce.
			CBX: CNT_CODELIST.NAME (code list "INCOTERM" and "LIDL_INCOTERM_US")
			LDL: P_LEW_CORE.T_REF_MDM_INCOTERM.MDM_INCOTERM_NAME
			CORE_REL:t_nfpo_incoterm.nfpo_incoterm_name',
	NFPO_US_INCOTERM_CD 							COMMENT 'NFPO incoterm codes for US, similar to the terms defined by the International Chamber of Commerce.
			CBX: CNT_ITEM.LDL_INCOTERMS, LDL_INCOTERM_US
			LDL: P_LEW_CORE.T_MDM_ITEM_MARKET_HIST.MDM_INCOTERM_CD
			CORE_REL:t_nfpo_item_market_hist.nfpo_incoterm_cd',
	NFPO_US_INCOTERM_NAME 							COMMENT 'NFPO incoterm names for US, similar to the terms defined by the International Chamber of Commerce.
			CBX: CNT_CODELIST.NAME (code list "INCOTERM" and "LIDL_INCOTERM_US")
			LDL: P_LEW_CORE.T_REF_MDM_INCOTERM.MDM_INCOTERM_NAME
			CORE_REL:t_nfpo_incoterm.nfpo_incoterm_name',
	NFPO_ORG_ORDER_STATUS_CD 						COMMENT 'NFPO status_1 code related to the order quantity definition process for the local NFPO of items.
			CBX: CNT_ITEM.LDL_COUNTRY_ORDER_STATUS
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.BUY_STATUS_CD
			CORE_REL:t_nfpo_item_hist.nfpo_org_order_status_cd',
	NFPO_ORG_ORDER_STATUS_DESCR_DE 					COMMENT 'NFPO status_1 name related to the order quantity definition process for the local NFPO of items.
			CBX: CNT_CODELIST.NAME
			LDL: P_LEW_CORE.T_REF_MDM_BUY_STATUS.BUY_STATUS
			CORE_REL:t_nfpo_organization_order_status.nfpo_org_order_status_descr_de',
	NFPO_ITEM_WORKFLOW_STATUS_ID 					COMMENT 'Identifier of the NFPO item_1 workflow status. The workflow is about the item_1 definition, from creation to clearance.
			CBX: CNT_ITEM.STATUS_1 (substring after "customStatus")
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_WORKFLOW_STATUS_ID
			CORE_REL:t_nfpo_item_hist.nfpo_item_workflow_status_id',
	NFPO_ITEM_WORKFLOW_STATUS_DESCR 				COMMENT 'Assigned name of the NFPO item_1 workflow status.The workflow is about the item_1 definition, from creation to clearance.
			CBX:cnt_item.status_1
			LDL: P_LEW_CORE.T_REF_MDM_ITEM_WORKFLOW_STATUS.WORKFLOW_STATUS
			CORE_REL::t_nfpo_item_workflow_status.nfpo_item_workflow_status_descr',
	NFPO_ITEM_CREATION_CLASS_CD 					COMMENT 'NFPO item_1 classification code related to item_1 creation and usage over time.
			The item_1 creation class indicates the item_1 creation process from which the article came, e.g. a range selection that applies to all organizations, or from a local selection process that only applies to the country_1, etc.
			CBX: CNT_ITEM.LDL_ARTICLE_TYPE
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_CLASS_CD
			CORE_REL:t_nfpo_item_hist.nfpo_item_creation_class_cd',
	NFPO_ITEM_CREATION_CLASS_NAME 					COMMENT 'NFPO item_1 classification description related to item_1 creation and usage over time.
			The item_1 creation class indicates the item_1 creation process from which the article came, e.g. a range selection that applies to all organizations, or from a local selection process that only applies to the country_1, etc.
			CBX: CTM_CODELIST_BOOK.CUST_TEXT1 (code list "LIDL_ARTICLETYPE")
			LDL: P_LEW_CORE.T_REF_MDM_ITEM_CLASS.ITEM_CLASS
			CORE_REL:t_nfpo_item_creation_class.nfpo_item_creation_class_name',
	NFPO_ITEM_QUALITY_CLASS_CD 						COMMENT 'NFPO item_1 quality classification code.
			CBX: CNT_ITEM.LDL_ARTICLE_CLASS
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_QUALITY_CLASS_CD
			CORE_REL:t_nfpo_item_hist.nfpo_item_quality_class_cd',
	NFPO_ITEM_QUALITY_CLASS_DESCR 					COMMENT 'NFPO item_1 quality classification description.
			CBX: CNT_CODELIST.NAME (code list "LDL_Article_Class")
			LDL: P_LEW_CORE.T_REF_MDM_ITEM_QUALITY_CLASS.ITEM_QUALITY_CLASS_DESCR
			CORE_REL:t_nfpo_item_quality_class.nfpo_item_quality_class_descr',
	NFPO_DISPLAY_TYPE_CD 							COMMENT 'NFPO display type code.
			CBX: CNT_ITEM.LDL_DISPLAY_TYPE
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DISPLAY_TYPE_CD
			CORE_REL:t_nfpo_item_hist.nfpo_display_type_cd',
	NFPO_DISPLAY_TYPE_NAME 							COMMENT 'NFPO display type description.
			CBX: CNT_CODELIST.NAME (code list "LIDL_DISPLAYTYPE")
			LDL: P_LEW_CORE.T_REF_MDM_DISPLAY_TYPE.DISPLAY_TYPE
			CORE_REL:t_nfpo_display_type.nfpo_display_type_name',
	NFPO_ITEM_PURCH_COMMENT_TXT 					COMMENT'Free text remark related to the NFPO item_1 from the purchasing team point of view.
			CBX: CNT_ITEM.LDL_REMARK_EK
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.PURCH_COMMENT_TXT
			CORE_REL:t_nfpo_item_hist.nfpo_item_purch_comment_txt',
	NFPO_ITEM_QUALITY_COMMENT_TXT 					COMMENT'Free text remark related to the NFPO item_1 from the quality development team point of view.
			CBX: CNT_ITEM.LDL_REMARK_QE
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.QUALITY_COMMENT_TXT
			CORE_REL:t_nfpo_item_hist.nfpo_item_quality_comment_txt',
	NFPO_ITEM_HIGHLIGHT_FG 							COMMENT'Indicates whether the item_1 should be placed prominently during the internal trade show
			CBX: CNT_ITEM.LDL_BRIEF_HIGHLIGHT
			LDL:t_mdm_item_hist.item_highlight_fg
			CORE_REL: t_nfpo_item_hist.nfpo_item_highlight_fg',
	NFPO_ITEM_INIT_ORDER_FG 						COMMENT'Indicator for the initial item_1 instance order of a catalog item.
			CBX: CNT_ITEM.LDL_INITIAL_ORDER
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.INITIAL_ORDER_FG
			CORE_REL:t_nfpo_item_hist.nfpo_item_init_order_fg',
	NFPO_ITEM_UNIT_UOM_NR 							COMMENT'Technical identifier of the unit_1 of measurement.
			CBX:cnt_codelist.code
			LDL: p_lew_core.t_unit_of_measurement.src_msehi
			CORE_REL:t_nfpo_unit_of_measurement.nfpo_uom_nr',
	NFPO_ITEM_UNIT_UOM_CD 							COMMENT'ISO Code of the unit_1 of measurement
			CBX: cnt_codelist.name
			LDL: p_lew_core.t_unit_of_measurement.uom_iso_cd
			CORE_REL:t_nfpo_unit_of_measurement.nfpo_uom_cd',
	NFPO_ITEM_UNIT_UOM_NAME 						COMMENT'Full name of the unit_1 measurement
			CBX: ctm_codelist_book.cust_text1
			LDL: p_lew_core.t_unit_of_measurement.uom_name
			CORE_REL:t_nfpo_unit_of_measurement.nfpo_uom_name',
	NFPO_ITEM_UNIT_QTY 								COMMENT'Indicator in the item_1 planning process: quantity of the content of units of the item. Interpretation depends on the overall composition of the item.
			CBX: CNT_ITEM.LDL_CONTAINER_VOLUME
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_UNIT_QTY
			CORE_REL:t_nfpo_item_hist.nfpo_item_unit_qty',
	NFPO_ITEM_UNIT_CNT 								COMMENT'Indicator in the item_1 planning process: number of units the item_1 consists of for the main variant. Interpretation depends on the overall composition of the item.
			CBX: CNT_ITEM.LDL_NUMBER_OF_CONTAINER
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_UNIT_CNT
			CBX:t_nfpo_item_hist.nfpo_item_unit_cnt',
	NFPO_ITEM_MIN_ORDER_QTY 						COMMENT'Minimum of the order quantity for a catalog item.
			CBX: CNT_ITEM.LDL_MOQ
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MINIMAL_ORDER_QTY
			CORE_REL: T_NFPO_ITEM_HIST.NFPO_ITEM_MIN_ORDER_QTY',
	NFPO_ITEM_VARIANT_CNT 							COMMENT'Indicator in the item_1 planning process: number of relevant variants the item_1 has from the design point of view. Interpretation depends on the overall composition of the item.
			CBX: CNT_ITEM.LDL_NUM_OF_UNITS
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_VARIANT_CNT
			CORE_REL:t_nfpo_item_hist.nfpo_item_variant_cnt',
	NFPO_PACK_TYPE_CD 								COMMENT'NFPO outer package_1 type codes for items.
			CBX: CNT_ITEM.LDL_PACKING_TYPE
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.PACKAGE_TYPE_CD
			CORE_REL:t_nfpo_item_hist.nfpo_pack_type_cd',
	NFPO_PACK_TYPE_NAME 							COMMENT'NFPO outer package_1 type names for items (NETZ/TOPF/BOX usw.).
			CBX: CNT_CODELIST.NAME (code list "LIDL_PACKAGETYPE")
			LDL: P_LEW_CORE.T_REF_MDM_PACKAGE_TYPE.PACKAGE_TYPE_NAME
			CORE_REL: t_nfpo_package_type.nfpo_pack_type_name',
	NFPO_ITEM_COMPOSITION_CD 						COMMENT'Indicator in the item_1 planning process: indicates whether an item_1 has relevant variants or consists of certain sub parts. Interpretation depends on the overall composition of the item_1 (assort or assemble: (x)fach sortiert oder (x)teilig).
			CBX: CNT_ITEM.LDL_ASSORTMENT
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_ITEM_COMPOSITION_CD
			CORE_REL:t_nfpo_item_hist.nfpo_item_composition_cd',
	NFPO_ITEM_COMPOSITION_TXT 						COMMENT'Text of the indicator in the item_1 planning process: indicates whether an item_1 has relevant variants or consists of certain sub parts. Interpretation depends on the overall composition of the item_1 (assort or assemble: (x)fach sortiert oder (x)teilig).
			CBX: CNT_CODELIST.NAME (code list "LIDL_ASSORTMENT")
			LDL: P_LEW_CORE.T_REF_MDM_ITEM_COMPOSITION.MDM_ITEM_COMPOSITION_TXT
			CORE_REL:t_nfpo_item_composition.nfpo_item_composition_txt',
	NFPO_LIST_TYPE_CD 								COMMENT'NFPO codes for list types of items.
			CBX: CNT_CODELIST.CODE (code list "LIDL_ASSORTMENT_TYPE")
			LDL: P_LEW_CORE.T_REF_MDM_LIST_TYPE.MDM_LIST_TYPE_CD
			CORE_REL:t_nfpo_item_hist.nfpo_list_type_cd',
	NFPO_LIST_TYPE_NAME 							COMMENT'NFPO names for list types of items.
			CBX: CNT_CODELIST.NAME (code list "LIDL_ASSORTMENT_TYPE")
			LDL: P_LEW_CORE.T_REF_MDM_LIST_TYPE.MDM_LIST_TYPE_NAME
			CORE_REL:t_nfpo_list_type.nfpo_list_type_name',
	NFPO_INIT_RANGE_PLAN_NR 						COMMENT'Initial batch of the item.
			CBX: CNT_ITEM.LDL_INITIAL_LOT_NO
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.INITIAL_RANGE_PLAN_CD
			CORE_REL:t_nfpo_item_hist.nfpo_init_range_plan_nr',
	NFPO_CATALOG_ITEM_FG 							COMMENT'Indicator whether an item_1 is a catalog item_1 or not. Catalog items will get extra item_1 instances for every range selection where they are valid. The conditions and properties remain unchanged.
			CBX: CNT_ITEM.LDL_CAT_INDICATOR
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CATALOG_FG
			CORE_REL:t_nfpo_item_hist.nfpo_catalog_item_fg',
	NFPO_ORDER_MONTH_LIST_TXT 						COMMENT'Representing month for the quarter in which NFPO catalog item_1 can be ordered.
			CBX: CNT_ITEM_SLN. REF_REF (field_id = "ldlBZP")
			LDL: P_LEW_CORE.T_MDM_CATALOG_ITEM_ORDER_PERIOD_HIST.ORDER_MONTH_ID
			core_rel: t_nfpo_catalog_item_order_period_hist.nfpo_order_month',
	NFPO_ORDER_MONTH_NAME_LIST_TXT 					COMMENT'Representing month name for the quarter in which NFPO catalog item_1 can be ordered.
			CBX: CNT_ITEM_SLN. REF_REF (field_id = "ldlBZP")
			LDL: P_LEW_CORE.T_MDM_CATALOG_ITEM_ORDER_PERIOD_HIST.ORDER_MONTH_ID
			core_rel: t_nfpo_catalog_item_order_period_hist.nfpo_order_month',
	NFPO_ITEM_INITIATING_ORG_SID 					COMMENT'Organization which initiates the item_1 due to competitor items.
			CBX: CNT_ITEM.LDL_STORE_CHECK_NAME
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_INITIATING_INT_ORG_SID
			CORE_REL:t_nfpo_item_hist.nfpo_item_initiating_org_sid',
	NFPO_ITEM_INITIATING_ORG_NR 					COMMENT'Identifier of the internal organization in the source system.
			CBX:cnt_codelist.name
			LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_NR
			CORE_REL:t_nfpo_organization.nfpo_org_nr',
	NFPO_ITEM_INITIATING_ORG_DESCR 					COMMENT'Description of the internal organization.
			CBX:ctm_codelist_book.cust_text2
			LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_DESCR
			CORE_REL:t_nfpo_organization.nfpo_org_descr',
	NFPO_ITEM_PROPOSING_ORG_SID 					COMMENT'Surrogate key internal organization, which proposed this item.
			CBX: CNT_ITEM.LDL_COUNTRY_PROPOSAL
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_PROPOSING_INT_ORG_SID
			CORE_REL:t_nfpo_item_hist.nfpo_item_proposing_org_sid',
	NFPO_ITEM_PROPOSING_ORG_NR 						COMMENT'Identifier of the internal organization in the source system,which proposed this item.
			CBX:cnt_codelist.name
			LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_NR
			CORE_REL:t_nfpo_organization.nfpo_org_nr',
	NFPO_ITEM_PROPOSING_ORG_NR_KDE,
	NFPO_ITEM_PROPOSING_ORG_DESCR 					COMMENT'Description of the internal organizatio, which proposed this item_1
			CBX:ctm_codelist_book.cust_text2
			LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_DESCR
			CORE_REL:t_nfpo_organization.nfpo_org_descr',
	CONTROLLED_PRICE_FG 							COMMENT'Indicates whether the price is controlled outside NFPO.
			CBX: CNT_ITEM.LDL_BINDING_PRICE
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CONTROLLED_PRICE_FG
			CORE_REL:t_nfpo_item_hist.controlled_price_fg',
	NFPO_LDL_BRAND_SID 								COMMENT'Foreign Key BRAND.
			CBX: CNT_ITEM.LDL_BRAND
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.BRAND_SID
			CORE_REL:t_nfpo_item_hist.nfpo_ldl_brand_sid',
	NFPO_LDL_BRAND_NR 								COMMENT'Lidl brands code
			CBX: CNT_ITEM.LDL_BRAND
			LDL: P_LEW_CORE.T_BRAND.SRC_BRAND_CD
			CORE_REL:t_nfpo_ldl_brand.nfpo_ldl_brand_nr',
	NFPO_LDL_BRAND_NAME 							COMMENT'Name of brands used in CBX for sales_1 in the Lidl line of business.
			CBX: CNT_CODELIST.NAME for CNT_CODELIST_BOOK.NAME = "LIDL_BRAND"
			LDL:p_lew_core.t_brand.brand_name
			CORE_REL:t_nfpo_ldl_brand.nfpo_ldl_brand_name',
	NFPO_LDL_BRAND_TYPE_CD 							COMMENT'Brand_1 type code for home brands of Lidl or Kaufland and brands of certain suppliers.
			CBX:ctm_codelist_book.cust_text1  for cnt_codelist_book.name="LIDL_BRAND" 
			LDL: P_LEW_CORE.T_BRAND.BRAND_TYPE_CD
			CORE_REL:t_nfpo_ldl_brand.nfpo_brand_type_cd',
	NFPO_LDL_BRAND_TYPE_NAME 						COMMENT'Brand_1 type name.
			CBX:
			LDL: P_LEW_CORE.T_REF_BRAND_TYPE.BRAND_TYPE
			CORE_REL:t_nfpo_brand_type.nfpo_brand_type_name',
	NFPO_KFL_BRAND_SID 								COMMENT'Surrogate Key KFL BRAND_1, identifies the brand_1 in case of being sold in a Kaufland country.
			CBX: CNT_ITEM.LDL_BRAND_KL
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.KFL_BRAND_SID
			CORE_REL:t_nfpo_item_hist.nfpo_kfl_brand_sid',
	NFPO_KFL_BRAND_NAME 							COMMENT'Name of Kaufland home brands used in CBX.
			CBX: CNT_ITEM.LDL_BRAND_KL
			LDL: P_LEW_CORE.T_KFL_BRAND.KFL_BRAND_NAME
			CORE_REL:t_nfpo_kfl_brand.nfpo_kfl_brand_name',
	NFPO_PILLAR_SID 								COMMENT'Surrogate Key NFPO PILLAR. Identifier of the pillar in NFPO source system. Alternative item_1 grouping for non food items in addition to the standard grouping based on item_1 families.
			CBX: CNT_ITEM.LDL_PILLAR
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_PILLAR_SID
			CORE_REL:t_nfpo_item_hist.nfpo_pillar_sid',
	NFPO_PILLAR_NAME 								COMMENT'name for the identifier of the pillar in CBX, alternative item_1 grouping, groups item_1 family groups
			CBX: CNT_ITEM.LDL_PILLAR
			LDL: P_LEW_CORE.T_REF_MDM_PILLAR.MDM_PILLAR_NAME
			CORE_REL: t_nfpo_pillar.nfpo_pillar_name',
	NFPO_MAIN_PILLAR_CD 							COMMENT'code of the main pillar
			Main pillar code (TX/HG).
			CBX: CNT_ITEM.PRODUCT_CATEGORY_VALUE
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MAIN_PILLAR_CD
			CORE_REL:t_nfpo_item_hist.nfpo_main_pillar_cd',
	NFPO_MAIN_PILLAR_NAME 							COMMENT'Name of the main pillar.
			CBX: CNT_CODELIST.NAME (code list "PRODUCT_CATEGORY")
			LDL: P_LEW_CORE.T_REF_MAIN_PILLAR.MAIN_PILLAR_NAME
			CORE_REL:t_nfpo_main_pillar.nfpo_main_pillar_name',
	NFPO_CUST_NEED_TYPE_CD 							COMMENT'Code to classify the assortment by general customer needs.
			CBX: CNT_ITEM.LDL_FOCUS_CATEGORY
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_CUST_NEED_TYPE_CD
			CORE_REL: T_NFPO_ITEM_HIST.NFPO_CUST_NEED_TYPE_CD',
	NFPO_CUST_NEED_TYPE_NAME 						COMMENT'Name of the general customer need.
			CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")
			LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE.MDM_CUST_NEED_TYPE_NAME
			CORE: T_NFPO_CUSTOMER_NEED_TYPE.NFPO_CUST_NEED_TYPE_NAME',
    NFPO_CUST_NEED_SUBTYPE_CD						COMMENT'Code to classify the assortment by detailed customer needs.
			CBX: CNT_ITEM.LDL_CATEGORY_NEEDS
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_CUST_NEED_SUBTYPE_CD
			CORE_REL.T_NFPO_ITEM_HIST.NFPO_CUST_NEED_SUBTYPE_CD
			If cust_need_subtype was NULL in the CBX item_1 table, then a dummy_1 value will be created based on 
			CBX: CNT_ITEM.LDL_FOCUS_CATEGORY
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_CUST_NEED_TYPE_CD
			CORE_REL: T_NFPO_ITEM_HIST.NFPO_CUST_NEED_TYPE_CD',
    NFPO_CUST_NEED_SUBTYPE_NAME						COMMENT'Name of the customer need subtype.
			CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")
			LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE.MDM_CUST_NEED_TYPE_SUBNAME
			CORE: T_NFPO_CUSTOMER_NEED_SUBTYPE.NFPO_CUST_NEED_SUBTYPE_NAME',
	NFPO_ASSORT_PROFILE_TYPE_CD 					COMMENT'Code to indicate the importance profile of the item_1 in the assortment (Pflicht, Profilierung, Ergaenzung).
			CBX: CNT_ITEM.LDL_FMS_ASSORTMENT
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ASSORT_PROFILE_TYPE_CD
			CORE_REL: T_NFPO_ITEM_HIST.NFPO_ASSORT_PROFILE_TYPE_CD',
	NFPO_ASSORT_PROFILE_TYPE_NAME 					COMMENT'Name of the profile type of the assortment (Pflicht, Profilierung, Ergaenzung).
			CBX: CNT_CODELIST.NAME (code list "LIDL_FMS_ASSORTMENT")
			LDL: P_LEW_CORE.T_REF_ASSORTMENT_PROFILE_TYPE.ASSORT_PROFILE_TYPE_NAME
			CORE: T_DIM_NFPO_ASSORTMENT_PROFILE_TYPE.NFPO_ASSORT_PROFILE_TYPE_NAME',
    LDL_CORE_ASSORT_TYPE_GRP_CD						COMMENT'Code of the group of types of the overall Lidl core assortment defined by business.',
    LDL_CORE_ASSORT_TYPE_GRP_NAME					COMMENT'Name of the group of types of the overall Lidl core assortment defined by business.',
	NFPO_ITEM_FAM_GRP_SID 							COMMENT'Identifier of ITEM_1 FAMILY GROUP.
			CBX: CNT_ITEM.LDL_ARTICLE_GROUP
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_FAM_GRP_SID
			core_rel:T_NFPO_ITEM_HIST.nfpo_item_fam_grp_sid',
	NFPO_ITEM_FAM_GRP_NR 							COMMENT'identifiying code of the item_1 family group, consists of the code of the sub itemgroup_1 and the code of the item_1 family in the sub itemgroup_1
			WAWI Code
			CBX: ctm_codelist_book.custText1;
			LDL: p_lew_core.t_item_familygroup.src_familygrp_cd
			CORE_REL: t_nfpo_item_family_group.nfpo_item_fam_grp_nr',
	NFPO_ITEM_FAM_GRP_NAME 							COMMENT'name of the item_1 family group
			CBX: Item.ctm_codelist_book.custText3
			LDL: p_lew_core.t_item_familygroup.item_fam_grp_name
			CORE_REL: t_nfpo_item_family_group.nfpo_item_fam_grp_name',
	NFPO_ASSORTMENT_AREA_ID 						COMMENT'code of the NFPO assortment area
			CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT5  (code list "REPORT_AF_PILLAR_PRODUCTCATEGORY")
			LDL: P_LEW_CORE.T_ITEM_FAMILYGROUP_HIST.MDM_ASSORTMENT_AREA_ID
			CORE_REL:t_nfpo_item_family_group_hist.nfpo_assortment_area_id',
	NFPO_ASSORTMENT_AREA_NAME 						COMMENT'name of the NFPO asortment area
			CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT3  (code list "REPORT_AF_PILLAR_PRODUCTCATEGORY")
			LDL: P_LEW_CORE.T_REF_MDM_ASSORTMENT_AREA.MDM_ASSORTMENT_AREA_NAME
			CORE_REL:t_nfpo_assortment_area.nfpo_assortment_area_name',
	NFPO_ITEM_PROPERTY_LIST_TXT 					COMMENT'Property of the item.
			CBX: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY
			LDL: P_LEW_CORE.T_MDM_ITEM_PROPERTY_ITEM_HIST.MDM_ITEM_PROPERTY_TXT
			CORE_REL:t_nfpo_item_property_item_hist.nfpo_item_property_txt',
	NFPO_CATALOG_ITEM_CONTRACT_EXPIRY_DT 			COMMENT'For catalog items, this field stores the expiry date of the contract.
			CBX: CNT_ITEM.LDL_CONTRACT_EXPIRY_DATE
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CONTRACT_EXPIRY_DT
			CORE_REL:t_nfpo_item_hist.nfpo_catalog_item_contract_expiry_dt',
	NFPO_WARRANTY_DUR_CD                			COMMENT 'NFPO warranty duration code.
            CBX: CNT_ITEM.LDL_GUARANTEE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.GUARANTEE_CD
            CORE_REL: T_NFPO_ITEM.NFPO_WARRANTY_DUR_CD',
	NFPO_WARRANTY_DUR_NAME              			COMMENT 'NFPO warranty duration name.
            CBX: CNT_CODELIST.NAME (code list "LIDL_WARRANTY")
            LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE.GUARANTEE_DESCR
            CORE_REL: T_NFPO_WARRANTY_DURATION.NFPO_WARRANTY_DUR_NAME',
	NFPO_WARRANTY_TYPE_CD							COMMENT 'NFPO warranty type code.
			CBX: CNT_ITEM.LDL_WARRANTY_ART_TYPE
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.GUARANTEE_TYPE_CD
			CORE_REL:T_NFPO_ITEM_HIST.NFPO_WARRANTY_TYPE_CD',
	NFPO_WARRANTY_TYPE_NAME                  		COMMENT 'NFPO warranty type name.
			CBX: CNT_CODELIST.NAME (code list "LIDL_WARRANTY_ART")
			LDL: P_LEW_CORE.T_REF_MDM_GUARANTEE_TYPE.GUARANTEE_TYPE_DESCR
			CORE_REL: T_NFPO_WARRANTY_TYPE.NFPO_WARRANTY_TYPE_NAME',
	NFPO_WARRANTY_DESCR                      		COMMENT 'NFPO warranty (type) long description.
			CBX: CNT_ITEM.LDL_ART
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.GUARANTEE_ART
			CORE_REL: T_NFPO_ITEM_HIST.NFPO_WARRANTY_TYPE_DESCR',			
			
	NFPO_ITEM_NOTE_TXT                  			COMMENT 'Item_1 procurement notes.
            CBX: CNT_ITEM.LDL_EK_NOTE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_NOTES
            CORE_REL: T_NFPO_ITEM_HIST.NFPO_ITEM_NOTE_TXT',
	NFPO_CASE_COMPOSITION_CD            			COMMENT 'Indicator in the item_1 planning process: indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items. Interpretation depends on the overall composition of the item.
            CBX: CNT_ITEM.LDL_PACK_TYPE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_CASE_COMPOSITION_CD
            CORE_REL: T_NFPO_ITEM.NFPO_CASE_COMPOSITION_CD',
	NFPO_CASE_COMPOSITION_TXT           			COMMENT 'Text of options to put items in the case. Indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX: CNT_CODELIST.NAME (code list "LIDL_NUMBEROFSET")
            LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.MDM_CASE_COMPOSITION_TXT
            CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_CASE_COMPOSITION_TXT',
	NFPO_SUBCASE_SIZE_QTY               			COMMENT 'Predefined number of items in the text of options to put items in the case when the case will be filled by subcases which contain a predefined number of items.
            CBX: CNT_CODELIST.NAME (code list "LIDL_NUMBEROFSET")
            LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.SUBCASE_SIZE_QTY
            CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_SUBCASE_SIZE_QTY',
	NFPO_CASE_COMPOSITION_NAME          			COMMENT 'Text of options to put items in the case without the predefined number of items in possible sub cases. Indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX: CNT_CODELIST.NAME (code list "LIDL_NUMBEROFSET")
            LDL: P_LEW_CORE.T_REF_MDM_CASE_COMPOSITION.MDM_CASE_COMPOSITION_NAME
            CORE_REL: T_NFPO_CASE_COMPOSITION.NFPO_CASE_COMPOSITION_NAME',
	NFPO_SMART_ITEM_FG                     			COMMENT 'The flag indicates whether an item_1 is regarded to be a smart item_1 or not.
			The definition of a smart item_1 is not standardized. It can be an IOT item_1 or have connectivity / networking capabilities. Items whose networking capability is a central component of their use, like a printer, may not be considered smart items.
			CBX: CNT_ITEM.LDL_IOT
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_SMART_ITEM_FG
			CORE_REL: T_NFPO_ITEM_HIST.NFPO_SMART_ITEM_FG',
	NFPO_LOGISTICS_CLASS_CD                  	    COMMENT 'Code to classify the way the items will be transported from the central warehouse of OWIM into the countries.
			CBX: CNT_ITEM.LDL_DELIVERY_TYPE
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_LOGISTICS_CLASS_CD
			CORE_REL: T_NFPO_ITEM_HIST.NFPO_LOGISTICS_CLASS_CD',
	NFPO_LOGISTICS_CLASS_NAME                		COMMENT 'Name to classify the way the items will be transported from the central warehouse of OWIM into the countries.
			CBX: CNT_CODELIST.NAME (code list "LIDL_DELIVERYTYPE")
			LDL: P_LEW_CORE.T_REF_MDM_LOGISTICS_CLASS.MDM_LOGISTICS_CLASS_NAME
			CORE_REL: T_NFPO_LOGISTICS_CLASS.NFPO_LOGISTICS_CLASS_NAME',
	NFPO_LDL_SALES_PACKAGING_TYPE_CD         		COMMENT 'Code of the sales_1 packaging type to be used for sales_1 in the line of business Lidl.
			CBX: CNT_ITEM.LDL_RETAIL_PACKAGING
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_LDL_SALES_PACKAGING_TYPE_CD
			CORE_REL: T_NFPO_ITEM_HIST.NFPO_LDL_SALES_PACKAGING_TYPE_CD',
	NFPO_LDL_SALES_PACKAGING_TYPE_NAME       		COMMENT 'Name of the LDL sales_1 packaging types.
			CBX: CNT_CODELIST.NAME (code lists "LIDL_RETAILPACK")
			LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE.MDM_SALES_PACKAGING_TYPE_NAME
			CORE_REL: T_NFPO_MDM_SALES_PACKAGING_TYPE.NFPO_SALES_PACKAGING_TYPE_NAME',
	NFPO_KFL_SALES_PACKAGING_TYPE_CD         		COMMENT 'Code of the sales_1 packaging type to be used for sales_1 in the line of business Kaufland.
			CBX: CNT_ITEM.LDL_RETAIL_PACKAGING_KL
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_KFL_SALES_PACKAGING_TYPE_CD
			CORE_REL: T_NFPO_ITEM_HIST.NFPO_KFL_SALES_PACKAGING_TYPE_CD',
	NFPO_KFL_SALES_PACKAGING_TYPE_NAME       		COMMENT 'Name of the KFL sales_1 packaging types.
			CBX: CNT_CODELIST.NAME ( "LIDL_RETAILPACK_KL")
			LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE.MDM_SALES_PACKAGING_TYPE_NAME
			CORE_REL: T_NFPO_SALES_PACKAGING_TYPE.NFPO_SALES_PACKAGING_TYPE_NAME',
	NFPO_ITEM_STANDARD_PROPERTY_CLASS_CD     		COMMENT 'Class of the standardized item_1 properties: So far "TX" for textile item_1 properties and "HG" for hard goods item_1 properties.
			LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.MDM_ITEM_STANDARD_PROPERTY_CLASS_CD
			CORE_REL: T_NFPO_ITEM_STANDARD_PROPERTY_ITEM_HIST_1,NFPO_ITEM_STANDARD_PROPERTY_CLASS_CD',
	NFPO_ITEM_STANDARD_PROPERTY_LIST_TXT     		COMMENT 'Text containing names, abbreviations and descriptions of the standardized item_1 property.It is the concatenation of all standard properties that belongs to an article.
			CBX: CNT_CODELIST.NAME (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)
			LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY.MDM_ITEM_STANDARD_PROPERTY_TXT
			CORE_REL: T_NFPO_ITEM_STANDARD_PROPERTY.NFPO_ITEM_STANDARD_PROPERTY_TXT',
	NFPO_SHIPPING_CONTAINER_20FT_QTY         		COMMENT 'Quantity of standard 20 foot shipping containers to be used to deliver the items. Only the value for which the quotation was used by LIDL is considered.
			CBX: CNT_VQ.FT20_QTY
			LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST.SHIPPING_CONTAINER_20FT_QTY
			CORE_REL: T_NFPO_ITEM_QUOTATION_HIST.NFPO_SHIPPING_CONTAINER_20FT_QTY',
	NFPO_SHIPPING_CONTAINER_40FT_QTY         		COMMENT 'Quantity of standard 40 foot shipping containers to be used to deliver the items.Only the value for which the quotation was used by LIDL is considered.
			CBX: CNT_VQ.FT40_QTY
			LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST.SHIPPING_CONTAINER_40FT_QTY
			CORE_REL: T_NFPO_ITEM_QUOTATION_HIST.NFPO_SHIPPING_CONTAINER_40FT_QTY',
	NFPO_SHIPPING_CONTAINER_40FT_HC_QTY      		COMMENT 'Quantity of standard 40 foot high cube shipping containers to be used to deliver the items.Only the value for which the quotation was used by LIDL is considered.
			CBX: CNT_VQ.FT40_HC_QTY
			LDL: P_LEW_CORE.T_MDM_ITEM_QUOTATION_HIST.SHIPPING_CONTAINER_40FT_HC_QTY
			CORE_REL: T_NFPO_ITEM_QUOTATION_HIST.NFPO_.SHIPPING_CONTAINER_40FT_HC_QTY',
	EU_DATA_ACT_RELEVANT_FG                  		COMMENT 'The flag indicates whether an item_1 is relevant for EU Data act or not.
			CBX:CNT_ITEM.LDL_EU_DATA_ACT
			LDL:  P_LEW_CORE.T_MDM_ITEM_HIST.EU_DATA_ACT_RELEVANT_FG
			CORE_REL: T_NFPO_ITEM_HIST.EU_DATA_ACT_RELEVANT_FG',
	NFPO_COMPETITOR_1_SID 							COMMENT'Surrogate Key COMPETITOR.
			CBX: CNT_ITEM.LDL_COMPETITOR, LDL_COMPETITOR2
			LDL: P_LEW_CORE.T_MDM_COMPETITOR.COMPETITOR_SID
			CORE_REL:t_nfpo_item_competitor_hist.nfpo_competitor_sid',
	NFPO_COMPETITOR_1_CD 							COMMENT'Unified abbreviation of the competitor.
			CBX: CNT_ITEM.LDL_COMPETITOR, LDL_COMPETITOR2
			LDL: P_LEW_CORE.T_MDM_COMPETITOR.SRC_COMPETITOR_CD
			CORE_REL:t_nfpo_competitor.nfpo_competitor_cd',
	NFPO_COMPETITOR_1_NAME 							COMMENT'Competitor name.
			CBX: CTM_CODELIST.CUST_TEXT1 (code list "LIDL_COMPET")
			LDL: P_LEW_CORE.T_MDM_COMPETITOR.COMPETITOR_NAME
			CORE_REL:t_nfpo_competitor.nfpo_competitor_name',
	NFPO_COMPETITOR_1_ABBR_NAME 					COMMENT'Abbreviated competitor name.
			CBX: CNT_CODELIST.NAME (code list "LIDL_COMPET")
			LDL: P_LEW_CORE.T_MDM_COMPETITOR.COMPETITOR_SHORT_NAME
			CORE_REL:t_nfpo_competitor.nfpo_competitor_abbr_name',
	NFPO_COMPETITOR_1_SALE_PRICE 					COMMENT'Competitor sales_1 price.
			CBX: CNT_ITEM.LDL_COMPETITOR_PRICE
			LDL: P_LEW_CORE.T_MDM_ITEM_COMPETITOR_HIST.SALE_PRICE
			CORE_REL:t_nfpo_item_competitor_hist.nfpo_competitor_sale_price',
	NFPO_COMPETITOR_1_SELL_FROM_DT 					COMMENT'Competitor sales_1 start date.
			CBX: CNT_ITEM.LDL_COMPETITOR_SELL_DATE
			LDL: P_LEW_CORE.T_MDM_ITEM_COMPETITOR_HIST.SELL_FROM_DT
			CORE_REL:t_nfpo_item_competitor_hist.nfpo_competitor_sell_from_dt',
	NFPO_COMPETITOR_2_SID 							COMMENT'Surrogate Key COMPETITOR.
			CBX: CNT_ITEM.LDL_COMPETITOR, LDL_COMPETITOR2
			LDL: P_LEW_CORE.T_MDM_COMPETITOR.COMPETITOR_SID
			CORE_REL:t_nfpo_item_competitor_hist_1,nfpo_competitor_sid',
	NFPO_COMPETITOR_2_CD 							COMMENT'Unified abbreviation of the competitor.
			CBX: CNT_ITEM.LDL_COMPETITOR, LDL_COMPETITOR2
			LDL: P_LEW_CORE.T_MDM_COMPETITOR.SRC_COMPETITOR_CD
			CORE_REL:t_nfpo_item_competitor.nfpo_competitor_cd',
	NFPO_COMPETITOR_2_NAME 							COMMENT'Competitor name.
			CBX: CTM_CODELIST.CUST_TEXT1 (code list "LIDL_COMPET")
			LDL: P_LEW_CORE.T_MDM_COMPETITOR.COMPETITOR_NAME
			CORE_REL:t_nfpo_item_competitor.nfpo_competitor_name',
	NFPO_COMPETITOR_2_ABBR_NAME 					COMMENT'Abbreviated competitor name.
			CBX: CNT_CODELIST.NAME (code list "LIDL_COMPET")
			LDL: P_LEW_CORE.T_MDM_COMPETITOR.COMPETITOR_SHORT_NAME
			CORE_REL:t_nfpo_item_competitor.nfpo_competitor_abbr_name',
	NFPO_COMPETITOR_2_SALE_PRICE 					COMMENT'Competitor sales_1 price.
			CBX: CNT_ITEM.LDL_COMPETITOR_PRICE
			LDL: P_LEW_CORE.T_MDM_ITEM_COMPETITOR_HIST.SALE_PRICE
			CORE_REL:t_nfpo_item_competitor_hist.nfpo_competitor_sale_price',
	NFPO_COMPETITOR_2_SELL_FROM_DT 					COMMENT'Competitor sales_1 start date.
			CBX: CNT_ITEM.LDL_COMPETITOR_SELL_DATE
			LDL: P_LEW_CORE.T_MDM_ITEM_COMPETITOR_HIST.SELL_FROM_DT
			CORE_REL:t_nfpo_item_competitor_hist.nfpo_competitor_sell_from_dt',
	NFPO_ITEM_DELIV_1_CAL_WEEK 						COMMENT'Initially planned delivery weeks for NFPO items.
			CBX: CNT_ITEM.LDL_DELIVERY_DATE, LDL2ND_DELIVERY_DATE_NAME, LDL3RD_DELIVERY_DATE_NAME
			LDL: P_LEW_CORE.T_MDM_ITEM_DELIVERY_HIST.CY_WEEK_ITEM_DEL
			CORE_REL:t_nfpo_item_delivery_hist.nfpo_item_deliv_cal_week',
	NFPO_ITEM_DELIV_2_CAL_WEEK 						COMMENT'Initially planned delivery weeks for NFPO items.
			CBX: CNT_ITEM.LDL_DELIVERY_DATE, LDL2ND_DELIVERY_DATE_NAME, LDL3RD_DELIVERY_DATE_NAME
			LDL: P_LEW_CORE.T_MDM_ITEM_DELIVERY_HIST.CY_WEEK_ITEM_DEL
			CORE_REL:t_nfpo_item_delivery_hist.nfpo_item_deliv_cal_week',
	NFPO_ITEM_DELIV_3_CAL_WEEK 						COMMENT'Initially planned delivery weeks for NFPO items.
			CBX: CNT_ITEM.LDL_DELIVERY_DATE, LDL2ND_DELIVERY_DATE_NAME, LDL3RD_DELIVERY_DATE_NAME
			LDL: P_LEW_CORE.T_MDM_ITEM_DELIVERY_HIST.CY_WEEK_ITEM_DEL
			CORE_REL:t_nfpo_item_delivery_hist.nfpo_item_deliv_cal_week',
	NFPO_ITEM_ADV_1_CAL_WEEK 						COMMENT'Initially planned advertisings weeks for NFPO items.
			CBX: CNT_ITEM.LDL_ADVERTISEMENT_DATE_NAME, LDL_ADVERTISEMENT_DATE2_NAME, LDL_ADVERTISEMENT_DATE3_NAME
			LDL: P_LEW_CORE.T_MDM_ITEM_ADVERTISE_HIST.CY_WEEK_ITEM_ADV
			CORE_REL:t_nfpo_item_advertise_hist.nfpo_item_adv_cal_week',
	NFPO_ITEM_ADV_2_CAL_WEEK 						COMMENT'Initially planned advertisings weeks for NFPO items.
			CBX: CNT_ITEM.LDL_ADVERTISEMENT_DATE_NAME, LDL_ADVERTISEMENT_DATE2_NAME, LDL_ADVERTISEMENT_DATE3_NAME
			LDL: P_LEW_CORE.T_MDM_ITEM_ADVERTISE_HIST.CY_WEEK_ITEM_ADV
			CORE_REL:t_nfpo_item_advertise_hist.nfpo_item_adv_cal_week',
	NFPO_ITEM_ADV_3_CAL_WEEK 						COMMENT'Initially planned advertisings weeks for NFPO items.
			CBX: CNT_ITEM.LDL_ADVERTISEMENT_DATE_NAME, LDL_ADVERTISEMENT_DATE2_NAME, LDL_ADVERTISEMENT_DATE3_NAME
			LDL: P_LEW_CORE.T_MDM_ITEM_ADVERTISE_HIST.CY_WEEK_ITEM_ADV
			CORE_REL:t_nfpo_item_advertise_hist.nfpo_item_adv_cal_week',
	NFPO_ADV_THEME_SID 								COMMENT'Surrogate Key NFPO ADVERTISING THEME.
			CBX: cnt_item.ldl_theme_ref
			LDL: P_LEW_CORE.t_mdm_ad_theme_item_hist.mdm_ad_theme_sid
			CORE_REL:t_nfpo_advertise_theme_item_hist.nfpo_adv_theme_sid',
	NFPO_ADV_THEME_NR 								COMMENT'NFPO adv theme reference.
			CBX: CNT_PROJECT.REF_NO
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.SRC_PROJ_DOC_REF
			CORE_REL:t_nfpo_advertise_theme.nfpo_adv_theme_nr',
	NFPO_ADV_THEME_DISPLAY_NAME,
	NFPO_ADV_THEME_NAME 							COMMENT'NFPO adv theme name.
			CBX: CNT_PROJECT.SHORT_DESC
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.AD_THEME_NAME
			CORE_REL:t_nfpo_advertise_theme.nfpo_adv_theme_name',
	NFPO_ADV_THEME_WEEK_CD 							COMMENT'NFPO adv theme number (derived from advertising week): WW.N;
			CBX: CNT_PROJECT.PROJECT_NO
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.AD_THEME_CD
			CORE_REL: t_nfpo_advertise_theme.nfpo_adv_theme_week_cd',
	NFPO_ADV_THEME_STATUS_CD 						COMMENT'Technical status_1 of the NFPO adv theme in the source system (active, inactive, cancelled).
			CBX: CNT_PROJECT.DOC_STATUS
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.CBX_PROJ_DOC_STATUS
			CORE_REL:t_nfpo_advertise_theme_hist.nfpo_adv_theme_status_cd',
	NFPO_ADV_THEME_DELIV_1_CAL_WEEK 				COMMENT'Planned delivery weeks for NFPO advertising themes.
			CBX: CTM_PROJECT.CUST_CODELIST1_NAME, CUST_CODELIST5_NAME, CUST_CODELIST6_NAME
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_DELIVER_HIST.CY_WEEK_THEME_DEL 
			CORE_REL:t_nfpo_advertise_theme_delivery_hist.nfpo_adv_theme_deliv_cal_week',
	NFPO_ADV_THEME_DELIV_2_CAL_WEEK 				COMMENT'Planned delivery weeks for NFPO advertising themes.
			CBX: CTM_PROJECT.CUST_CODELIST1_NAME, CUST_CODELIST5_NAME, CUST_CODELIST6_NAME
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_DELIVER_HIST.CY_WEEK_THEME_DEL
			CORE_REL:t_nfpo_advertise_theme_delivery_hist.nfpo_adv_theme_deliv_cal_week',
	NFPO_ADV_THEME_DELIV_3_CAL_WEEK 				COMMENT'Planned delivery weeks for NFPO advertising themes.
			CBX: CTM_PROJECT.CUST_CODELIST1_NAME, CUST_CODELIST5_NAME, CUST_CODELIST6_NAME
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_DELIVER_HIST.CY_WEEK_THEME_DEL
			CORE_REL:t_nfpo_advertise_theme_delivery_hist.nfpo_adv_theme_deliv_cal_week',
	NFPO_ADV_THEME_ADV_1_CAL_WEEK 					COMMENT'Planned advertising weeks for NFPO advertising themes.
			CBX: CTM_PROJECT.CUST_CODELIST2_NAME, CUST_CODELIST7_NAME, CUST_CODELIST10_NAME
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_ADVERTISE_HIST.CY_WEEK_THEME_ADV
			CORE_REL:t_nfpo_advertise_theme_advertise_hist.nfpo_adv_theme_adv_cal_week',
	NFPO_ADV_THEME_ADV_2_CAL_WEEK 					COMMENT'Planned advertising weeks for NFPO advertising themes.
			CBX: CTM_PROJECT.CUST_CODELIST2_NAME, CUST_CODELIST7_NAME, CUST_CODELIST10_NAME
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_ADVERTISE_HIST.CY_WEEK_THEME_ADV
			CORE_REL:t_nfpo_advertise_theme_advertise_hist.nfpo_adv_theme_adv_cal_week',
	NFPO_ADV_THEME_ADV_3_CAL_WEEK 					COMMENT'Planned advertising weeks for NFPO advertising themes.
			CBX: CTM_PROJECT.CUST_CODELIST2_NAME, CUST_CODELIST7_NAME, CUST_CODELIST10_NAME
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_ADVERTISE_HIST.CY_WEEK_THEME_ADV
			CORE_REL:t_nfpo_advertise_theme_advertise_hist.nfpo_adv_theme_adv_cal_week',
	NFPO_RANGE_SEL_SID 								COMMENT'Foreign Key NFPO RANGE SELECTION.
			CBX: CNT_PROJECT.PROGRAM_REF
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.MDM_RANGE_SEL_SID
			CORE_REL:t_nfpo_advertise_theme_hist.nfpo_range_sel_sid',
	NFPO_RANGE_SEL_NR 								COMMENT'Identifier of the NFPO range selection.
			CBX: CNT_PROGRAM.REF_NO
			LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION.SRC_PROG_DOC_REF
			CORE_REL:t_nfpo_range_selection.nfpo_range_sel_nr',
	NFPO_RANGE_PLAN_NR 								COMMENT'Logical identifier of the NFPO range selection: sometimes technically 2 records for a logical range selection exist, but only one is active.
			CBX: CNT_PROGRAM.PROGRAM_NO
			LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION.RANGE_PLAN_CD
			CORE_REL:t_nfpo_range_selection.nfpo_range_plan_nr',
	NFPO_RANGE_SEL_CAL_MONTH 						COMMENT'Range selection month.
			CBX: CNT_PROGRAM.YEAR, PERIOD
			LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_MONTH_RANGE_SELECTION
			CORE_REL:t_nfpo_range_selection_hist.nfpo_range_sel_cal_month',
	NFPO_RANGE_SEL_CAL_YEAR 						COMMENT'Range selection year.
			Derived from range selection month.
			CBX: CNT_PROGRAM.YEAR, PERIOD
			LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_MONTH_RANGE_SELECTION
			CORE_REL:t_nfpo_range_selection_hist.nfpo_range_sel_cal_month',
	NFPO_RANGE_SEL_DELIV_FROM_CAL_WEEK 				COMMENT'Range selection deliver-from calendar_1 week.
			CBX: CTM_PROGRAM.CUST_CODELIST1
			LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_DELIVER_FROM
			CORE_REL:t_nfpo_range_selection_hist.nfpo_range_sel_deliv_from_cal_week',
	NFPO_RANGE_SEL_DELIV_TO_CAL_WEEK 				COMMENT'Range selection deliver-to calendar_1 week.
			CBX: CTM_PROGRAM.CUST_CODELIST2
			LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_DELIVER_TO
			CORE_REL:t_nfpo_range_selection_hist.nfpo_range_sel_deliv_to_cal_week',
	NFPO_RANGE_SEL_ADV_FROM_CAL_WEEK 				COMMENT'Range selection advertise-from calendar_1 week.
			CBX: CTM_PROGRAM.CUST_CODELIST3
			LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_ADVERTISE_FROM
			CORE_REL:t_nfpo_range_selection_hist.nfpo_range_sel_adv_from_cal_week',
	NFPO_RANGE_SEL_ADV_TO_CAL_WEEK 					COMMENT'Range selection advertise-to calendar_1 week.
			CBX: CTM_PROGRAM.CUST_CODELIST4
			LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_ADVERTISE_TO
			CORE_REL:t_nfpo_range_selection_hist.nfpo_range_sel_adv_to_cal_week',
	NFPO_EKL_USER_SID 								COMMENT'Foreign Key to represent the NFPO source system user.
			CBX: CNT_ITEM.LDL_BUYER_REF, LDL_SE_REF, LDL_RESPONSIBLE_PERSON_REF, LDL_CONTRACT_APPROVAL_EMP_REF
			LDL: P_LEW_CORE.T_MDM_ITEM_BUYER_ROLE_HIST.BUYER_SID
			CORE_REL:t_nfpo_item_user_role_hist.nfpo_user_sid',
	NFPO_EKL_USER_ACCT_NAME 						COMMENT'NFPO source system user reference.
			CBX: CNT_USER.REF_NO
			LDL: P_LEW_CORE.T_MDM_BUYER.SRC_USER_DOC_REF
			CORE_REL:t_nfpo_user.nfpo_user_acct_name',
	NFPO_EKL_USER_FIRST_NAME 						COMMENT'Forename of the NFPO source system user.
			CBX: CNT_USER.FIRST_NAME
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_FORENAME
			CORE_REL:t_nfpo_user.nfpo_user_first_name',
	NFPO_EKL_USER_LAST_NAME 						COMMENT'Surname of the NFPO source system user.
			CBX: CNT_USER.LAST_NAME
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_SURNAME
			CORE_REL:t_nfpo_user.nfpo_user_last_name',
	NFPO_EKL_USER_ABBR_NAME 						COMMENT'Buyer code (derived from name) of the NFPO source system user if he is a responsible buyer, common across systems.
			CBX: CNT_USER.SHORT_CODE
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_CD
			CORE_REL:t_nfpo_user.nfpo_user_abbr_name',
	NFPO_EKL_USER_MGR_ABBR_NAME 					COMMENT'Coded name of the manager of the NFPO source system user.
			CBX: CTM_USER.CUST_TEXT2
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_MANAGER_ABBR_NAME
			CORE_REL:t_nfpo_user.nfpo_user_mgr_abbr_name',
	NFPO_EKL_USER_DISPLAY_NAME,
	NFPO_SE_USER_SID 								COMMENT'Foreign Key to represent the NFPO source system user.
			CBX: CNT_ITEM.LDL_BUYER_REF, LDL_SE_REF, LDL_RESPONSIBLE_PERSON_REF, LDL_CONTRACT_APPROVAL_EMP_REF
			LDL: P_LEW_CORE.T_MDM_ITEM_BUYER_ROLE_HIST.BUYER_SID
			CORE_REL:t_nfpo_item_user_role_hist.nfpo_user_sid',
	NFPO_SE_USER_ACCT_NAME 							COMMENT'NFPO source system user reference.
			CBX: CNT_USER.REF_NO
			LDL: P_LEW_CORE.T_MDM_BUYER.SRC_USER_DOC_REF
			CORE_REL:t_nfpo_user.nfpo_user_acct_name',
	NFPO_SE_USER_FIRST_NAME 						COMMENT'Forename of the NFPO source system user.
			CBX: CNT_USER.FIRST_NAME
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_FORENAME
			CORE_REL:t_nfpo_user.nfpo_user_first_name',
	NFPO_SE_USER_LAST_NAME 							COMMENT'Surname of the NFPO source system user.
			CBX: CNT_USER.LAST_NAME
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_SURNAME
			CORE_REL:t_nfpo_user.nfpo_user_last_name',
	NFPO_SE_USER_ABBR_NAME 							COMMENT'Buyer code (derived from name) of the NFPO source system user if he is a responsible buyer, common across systems.
			CBX: CNT_USER.SHORT_CODE
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_CD
			CORE_REL:t_nfpo_user.nfpo_user_abbr_name',
	NFPO_SE_USER_MGR_ABBR_NAME 						COMMENT'Coded name of the manager of the NFPO source system user.
			CBX: CTM_USER.CUST_TEXT2
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_MANAGER_ABBR_NAME
			CORE_REL:t_nfpo_user.nfpo_user_mgr_abbr_name',
	NFPO_THEME_RESP_USER_SID 						COMMENT'Responsible person for the advertising theme.
			CBX: CNT_PROJECT.THEME_OWNER
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.AD_THEME_RESP_BUYER_SID
			CORE_REL:t_nfpo_advertise_theme_hist.nfpo_resp_user_sid',
	NFPO_THEME_RESP_USER_ACCT_NAME 					COMMENT'NFPO source system user reference.
			CBX: CNT_USER.REF_NO
			LDL: P_LEW_CORE.T_MDM_BUYER.SRC_USER_DOC_REF
			CORE_REL:t_nfpo_user.nfpo_user_acct_name',
	NFPO_THEME_RESP_USER_FIRST_NAME 				COMMENT'Forename of the NFPO source system user.
			CBX: CNT_USER.FIRST_NAME
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_FORENAME
			CORE_REL:t_nfpo_user.nfpo_user_first_name',
	NFPO_THEME_RESP_USER_LAST_NAME 					COMMENT'Surname of the NFPO source system user.
			CBX: CNT_USER.LAST_NAME
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_SURNAME
			CORE_REL:t_nfpo_user.nfpo_user_last_name',
	NFPO_THEME_RESP_USER_ABBR_NAME 					COMMENT'Buyer code (derived from name) of the NFPO source system user if he is a responsible buyer, common across systems.
			CBX: CNT_USER.SHORT_CODE
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_CD
			CORE_REL:t_nfpo_user.nfpo_theme_resp_user_abbr_name',
	NFPO_THEME_RESP_USER_MGR_ABBR_NAME 				COMMENT'Coded name of the manager of the NFPO source system user.
			CBX: CTM_USER.CUST_TEXT2
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_MANAGER_ABBR_NAME
			CORE_REL:t_nfpo_user.nfpo_user_mgr_abbr_name',
	NFPO_ITEM_ORG_RELEASE_LIST_TXT				    COMMENT 'List of organizations (NFPO ORG NRs) which are officially allowed to order the item.
            CBX: CNT_ITEM.LDL_ORDERABLE
            LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_RELEASE.INT_ORG_SID
            CORE_REL: T_NFPO_ITEM_ORGANIZATION_RELEASE_HIST.NFPO_ORG_SID',
	NFPO_PREV_ITEM_1_SID 							COMMENT'Surrogate Key NFPO ITEM_1 INSTANCE.
			CBX: CNT_ITEM_RELATED.RELATED_ITEM_REF
			LDL: P_LEW_CORE.T_MDM_ITEM_RELATED_ITEM_HIST.MDM_ITEM_SID_RELATED
			CORE_REL:t_nfpo_item_related_item_hist.nfpo_rel_item_sid',
	NFPO_PREV_ITEM_1_NR 							COMMENT'NFPO item_1 instance reference.
			CBX: CNT_ITEM.REF_NO
			LDL: P_LEW_CORE.T_MDM_ITEM.SRC_ITEM_DOC_REF
			CORE_REL:t_nfpo_item.nfpo_item_nr',
	NFPO_PREV_ITEM_1_NAME 							COMMENT'NFPO item_1 name.
			CBX: CNT_ITEM.ITEM_DESC, SHORT_DESC
			LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_NAME
			CORE_REL:t_nfpo_item.nfpo_item_name',
	NFPO_PREV_ITEM_1_LDL_ITEM_IAN_NR 				COMMENT'Lidl International Item_1 Number (not necessarily unique in this table - numbers can be reused if an item_1 is cancelled, or multiple item_1 instances will be created for catalog items).
			CBX: CNT_ITEM.ITEM_NO
			LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_IAN
			CORE_REL:t_nfpo_item.ldl_item_ian_nr',
	NFPO_PREV_ITEM_1_SEL_NR 						COMMENT'NFPO source system internal identifier for an article.
			CBX: CNT_ITEM.LDL_SELECTION_NO
			LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_SELECTION_NR
			CORE_REL:t_nfpo_item.nfpo_item_sel_nr',
	NFPO_PREV_ITEM_1_MARKET_REL_ITEM_SID 			COMMENT'Foreign Key related NFPO ITEM_1 INSTANCE.
			CBX: CNT_ITEM_RELATED.RELATED_ITEM_REF
			LDL: P_LEW_CORE.T_MDM_ITEM_RELATED_ITEM_HIST.MDM_ITEM_SID_RELATED
			CORE_REL:t_nfpo_item_related_item_hist.nfpo_rel_item_sid',
	NFPO_PREV_ITEM_1_STATUS_CD 						COMMENT'Technical status_1 of the NFPO item_1 in the source system (active, inactive, cancelled).
			CBX: CNT_ITEM.DOC_STATUS
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CBX_ITEM_DOC_STATUS
			CORE_REL:t_nfpo_item_hist.nfpo_item_status_cd',
	NFPO_PREV_ITEM_1_SUP_SID 						COMMENT'Foreign Key NFPO SUPPLIER.
			CBX: CNT_ITEM.LDL_DEFAULT_VENDOR_REF
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_SUP_SID
			CORE_REL:t_nfpo_item_hist.nfpo_sup_sid',
	NFPO_PREV_ITEM_1_SUP_NR 						COMMENT'NFPO supplier_1 identifier.
			CBX: CNT_VENDOR.REF_NO
			LDL: P_LEW_CORE.T_MDM_SUPPLIER.SRC_VENDOR_DOC_REF
			CORE_REL:t_nfpo_supplier.nfpo_sup_nr',
	NFPO_PREV_ITEM_1_SUP_NAME 						COMMENT'Name of the NFPO supplier.
			CBX: CNT_VENDOR.BUSINESS_NAME
			LDL: P_LEW_CORE.T_MDM_SUPPLIER.SUP_NAME
			CORE_REL:t_nfpo_supplier.nfpo_sup_name',
	NFPO_PREV_ITEM_1_GTIN_OWNERSHIP_CD 				COMMENT'NFPO GTIN assignment responsibility code.
			CBX: CTM_VENDOR.CUST_CODELIST1
			LDL: P_LEW_CORE.T_MDM_SUPPLIER_HIST.EAN_OWNERSHIP_CD
			CORE_REL:t_nfpo_supplier_hist.nfpo_gtin_ownership_cd',
	NFPO_PREV_ITEM_1_GTIN_OWNERSHIP_DESCR 			COMMENT'NFPO GTIN assignment responsibility descriptions.
			CBX: CNT_CODELIST.NAME (code list "LIDL_GTIN_OUTPUT")
			LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP.EAN_OWNERSHIP
			CORE_REL: t_nfpo_gtin_ownership.nfpo_gtin_ownership_descr',
	NFPO_PREV_ITEM_1_SUP_COUNTRY_SID 				COMMENT'Surrogate Key country_1 the address_1 is located in 
			CBX: cnt_vendor_address.country_1
			LDL: p_lew_core.t_address.country_pol_sid
			CORE_REL:t_nfpo_address.nfpo_country_sid',
	NFPO_PREV_ITEM_1_SUP_COUNTRY_CD 				COMMENT'character ISO code of country_1 the address_1 is located in; 
			CBX: cnt_vendor_address.country_1
			LDL: p_lew_core.t_address.country_pol_cd
			CORE_REL:t_nfpo_address.nfpo_country_cd',
	NFPO_PREV_ITEM_1_SUP_COUNTRY_NAME 				COMMENT'Name of the political country_1
			CBX: cnt_codelist.name;
			LDL: P_LEW_CORE.t_country_political.country_pol_name
			CORE_REL:t_nfpo_country.nfpo_country_name',
	NFPO_PREV_ITEM_1_SUP_STREET_NAME 				COMMENT'The street name the address_1 is located in
			CBX: cnt_vendor_address.address1
			LDL: p_lew_core.t_address.street
			CORE_REL:t_nfpo_address.street_name',
	NFPO_PREV_ITEM_1_SUP_CITY_NAME 					COMMENT'City name the address_1 is located in
			CBX: cnt_vendor_address.city
			LDL: p_lew_core.t_address.city
			CORE_REL:t_nfpo_address.city_name',
	NFPO_PREV_ITEM_1_SUP_ZIP 						COMMENT'Zip code of the address.
			CBX: cnt_vendor_address.postal_code
			LDL: p_lew_core.t_address.zip_code
			CORE_REL:t_nfpo_address.zip',
	NFPO_PREV_ITEM_1_EKS_SUP_NR 					COMMENT'Identifier of this subsidiary in EKS.
			CBX: CNT_VENDOR_ADDRESS.LDL_EKS_NO
			LDL: P_LEW_CORE.T_MDM_SUPPLIER_SUBSIDIARY_HIST.EKS_SUP_NR
			CORE_REL:t_nfpo_supplier_subsidiary_hist.eks_sup_nr',
	NFPO_PREV_ITEM_1_EU_COMPLETION_TYPE_CD 			COMMENT'NFPO completion types.
			CBX: CNT_ITEM.LDL_COMPLETION_TYPE, LDL_COMPLETION_TYPE_US
			LDL: P_LEW_CORE.T_MDM_ITEM_MARKET_HIST.MDM_COMPLETION_TYPE_CD
			CORE_REL:t_nfpo_item_market_hist.nfpo_completion_type_cd',
	NFPO_PREV_ITEM_1_EU_COMPLETION_TYPE_NAME 		COMMENT'NFPO completion type name.
			CBX: CNT_CODELIST.NAME (code list "LIDL_OWIMFH" and "LIDL_COMPLTYPE_US")
			LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.MDM_COMPLETION_TYPE_NAME
			CORE_REL:t_nfpo_completion_type.nfpo_completion_type_name',
	NFPO_PREV_ITEM_1_LDL_BRAND_SID 					COMMENT'Foreign Key BRAND.
			CBX: CNT_ITEM.LDL_BRAND
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.BRAND_SID
			CORE_REL:t_nfpo_item_hist.nfpo_ldl_brand_sid',
	NFPO_PREV_ITEM_1_LDL_BRAND_NR 					COMMENT'Natural key in the source system for Lidl brands.
			CBX: CNT_ITEM.LDL_BRAND
			LDL: P_LEW_CORE.T_BRAND.SRC_BRAND_CD
			CORE_REL:t_nfpo_ldl_brand.nfpo_ldl_brand_nr',
	NFPO_PREV_ITEM_1_LDL_BRAND_NAME 				COMMENT'Name of brands used in CBX for sales_1 in the Lidl line of business.
			CBX: CNT_CODELIST.NAME for CNT_CODELIST_BOOK.NAME = "LIDL_BRAND"
			LDL:p_lew_core.t_brand.brand_name
			CORE_REL:t_nfpo_ldl_brand.nfpo_ldl_brand_name',
	NFPO_PREV_ITEM_1_LDL_BRAND_TYPE_CD 				COMMENT'Brand_1 type code for home brands of Lidl or Kaufland and brands of certain suppliers.
			CBX:ctm_codelist_book.cust_text1  for cnt_codelist_book.name = "LIDL_BRAND" 
			LDL: P_LEW_CORE.T_BRAND.BRAND_TYPE_CD
			CORE_REL:t_nfpo_ldl_brand.nfpo_brand_type_cd',
	NFPO_PREV_ITEM_1_LDL_BRAND_TYPE_NAME 			COMMENT'Brand_1 type name.
			LDL: P_LEW_CORE.T_REF_BRAND_TYPE.BRAND_TYPE
			CORE_REL:t_nfpo_brand_type.nfpo_brand_type_name',
	NFPO_PREV_ITEM_1_ITEM_FAM_GRP_SID 				COMMENT'Foreign Key ITEM_1 FAMILY GROUP.
			CBX: CNT_ITEM.LDL_ARTICLE_GROUP
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_FAM_GRP_SID
			CORE_REL:t_nfpo_item_hist.nfpo_item_fam_grp_sid',
	NFPO_PREV_ITEM_1_ITEM_FAM_GRP_NR 				COMMENT'identifiying code of the item_1 family group, consists of the code of the sub itemgroup_1 and the code of the item_1 family in the sub itemgroup_1
			WAWI Code;
			CBX: ctm_codelist_book.custText1;
			LDL: p_lew_core.t_item_familygroup.src_familygrp_cd
			CORE_REL:t_nfpo_item_family_group.nfpo_item_fam_grp_nr',
	NFPO_PREV_ITEM_1_ITEM_FAM_GRP_NAME 				COMMENT'name of the item_1 family group
			CBX: ctm_codelist_book.custText3;
			LDL: p_lew_core.t_item_familygroup.item_fam_grp_name
			CORE_REL:t_nfpo_item_family_group.nfpo_item_fam_grp_name',
	NFPO_PREV_ITEM_1_ADV_THEME_SID 					COMMENT'Surrogate Key NFPO ADVERTISING THEME.
			CBX: CNT_ITEM.LDL_THEME_REF
			LDL: P_LEW_CORE.T_MDM_AD_THEME_ITEM_HIST.MDM_AD_THEME_SID
			CORE_REL:t_nfpo_advertise_theme_item_hist.nfpo_adv_theme_sid',
	NFPO_PREV_ITEM_1_ADV_THEME_NR 					COMMENT'NFPO adv theme reference.
			CBX: CNT_PROJECT.REF_NO
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.SRC_PROJ_DOC_REF
			CORE_REL: t_nfpo_advertise_theme.nfpo_adv_theme_nr',
	NFPO_PREV_ITEM_1_ADV_THEME_NAME 				COMMENT'NFPO adv theme name.
			CBX: CNT_PROJECT.SHORT_DESC
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.AD_THEME_NAME
			CORE_REL:t_nfpo_advertise_theme.nfpo_adv_theme_name',
	NFPO_PREV_ITEM_1_ADV_THEME_WEEK_CD 				COMMENT 'NFPO adv theme ID (20-digit code).
			CBX: CTM_PROJECT.CUST_TEXT5
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.AD_THEME_ID
			CORE_REL:t_nfpo_advertise_theme.nfpo_adv_theme_week_cd',
	NFPO_PREV_ITEM_1_ADV_THEME_STATUS_CD 			COMMENT 'Technical status_1 of the NFPO adv theme in the source system (active, inactive, cancelled).
			CBX: CNT_PROJECT.DOC_STATUS
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.CBX_PROJ_DOC_STATUS
			CORE_REL:t_nfpo_advertise_theme_hist.nfpo_adv_theme_status_cd',
	NFPO_PREV_ITEM_1_RANGE_SEL_SID 					COMMENT 'Foreign Key NFPO RANGE SELECTION.
			CBX: CNT_PROJECT.PROGRAM_REF
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.MDM_RANGE_SEL_SID
			CORE_REL:t_nfpo_advertise_theme_hist.nfpo_range_sel_sid',
	NFPO_PREV_ITEM_1_RANGE_SEL_NR 					COMMENT 'Identifier of the NFPO range selection.
			CBX: CNT_PROGRAM.REF_NO
			LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION.SRC_PROG_DOC_REF
			CORE_REL:t_nfpo_range_selection.nfpo_range_sel_nr',
	NFPO_PREV_ITEM_1_RANGE_PLAN_NR 					COMMENT 'Logical identifier of the NFPO range selection: sometimes technically 2 records for a logical range selection exist, but only one is active.
			CBX: CNT_PROGRAM.PROGRAM_NO
			LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION.RANGE_PLAN_CD 
			CORE_REL:t_nfpo_range_selection.nfpo_range_plan_nr',
	NFPO_PREV_ITEM_1_RANGE_SEL_CAL_MONTH 			COMMENT 'Range selection month.
			CBX: CNT_PROGRAM.YEAR, PERIOD
			LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_MONTH_RANGE_SELECTION
			CORE_REL:t_nfpo_range_selection_hist.nfpo_range_sel_cal_month',
	NFPO_PREV_ITEM_1_RANGE_SEL_CAL_YEAR 			COMMENT 'Range selection year.
			Derived from range selection month.
			CBX: CNT_PROGRAM.YEAR, PERIOD
			LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_MONTH_RANGE_SELECTION
			CORE_REL:t_nfpo_range_selection_hist.nfpo_range_sel_cal_month',
	NFPO_PREV_ITEM_1_EKL_USER_SID 					COMMENT 'Foreign Key to represent the NFPO source system user.
			CBX: CNT_ITEM.LDL_BUYER_REF, LDL_SE_REF, LDL_RESPONSIBLE_PERSON_REF, LDL_CONTRACT_APPROVAL_EMP_REF
			LDL: P_LEW_CORE.T_MDM_ITEM_BUYER_ROLE_HIST.BUYER_SID
			CORE_REL:t_nfpo_item_user_role_hist.nfpo_user_sid',
	NFPO_PREV_ITEM_1_EKL_USER_ACCT_NAME 			COMMENT 'NFPO source system user reference.
			CBX: CNT_USER.REF_NO
			LDL: P_LEW_CORE.T_MDM_BUYER.SRC_USER_DOC_REF
			CORE_REL:t_nfpo_user.nfpo_user_acct_name',
	NFPO_PREV_ITEM_1_EKL_USER_FIRST_NAME 			COMMENT 'Forename of the NFPO source system user.
			CBX: CNT_USER.FIRST_NAME
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_FORENAME
			CORE_REL:t_nfpo_user.nfpo_user_first_name',
	NFPO_PREV_ITEM_1_EKL_USER_LAST_NAME 			COMMENT 'Surname of the NFPO source system user.
			CBX: CNT_USER.LAST_NAME
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_SURNAME
			CORE_REL:t_nfpo_user.nfpo_user_last_name',
	NFPO_PREV_ITEM_1_EKL_USER_ABBR_NAME 			COMMENT 'Buyer code (derived from name) of the NFPO source system user if he is a responsible buyer, common across systems.
			CBX: CNT_USER.SHORT_CODE
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_CD
			CORE_REL:t_nfpo_user.nfpo_user_abbr_name',
	NFPO_PREV_ITEM_1_EKL_USER_MGR_ABBR_NAME 		COMMENT 'Coded name of the manager of the NFPO source system user.
			CBX: CTM_USER.CUST_TEXT2
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_MANAGER_ABBR_NAME
			CORE_REL:t_nfpo_user.nfpo_user_mgr_abbr_name',
	NFPO_PREV_ITEM_1_THEME_RESP_USER_SID 			COMMENT 'Responsible person for the advertising theme.
			CBX: CNT_PROJECT.THEME_OWNER
			LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.AD_THEME_RESP_BUYER_SID
			CORE_REL:t_nfpo_advertise_theme_hist.nfpo_resp_user_sid',
	NFPO_PREV_ITEM_1_THEME_RESP_USER_ACCT_NAME 		COMMENT 'NFPO source system user reference.
			CBX: CNT_USER.REF_NO
			LDL: P_LEW_CORE.T_MDM_BUYER.SRC_USER_DOC_REF
			CORE_REL:t_nfpo_user.nfpo_user_acct_name',
	NFPO_PREV_ITEM_1_THEME_RESP_USER_FIRST_NAME 	COMMENT 'Forename of the NFPO source system user.
			CBX: CNT_USER.FIRST_NAME
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_FORENAME
			CORE_REL:t_nfpo_user.nfpo_user_first_name',
	NFPO_PREV_ITEM_1_THEME_RESP_USER_LAST_NAME 		COMMENT 'Surname of the NFPO source system user.
			CBX: CNT_USER.LAST_NAME
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_SURNAME
			CORE_REL:t_nfpo_user.nfpo_user_last_name',
	NFPO_PREV_ITEM_1_THEME_RESP_USER_ABBR_NAME 		COMMENT 'Buyer code (derived from name) of the NFPO source system user if he is a responsible buyer, common across systems.
			CBX: CNT_USER.SHORT_CODE
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_CD
			CORE_REL:t_nfpo_user.nfpo_user_abbr_name',
	NFPO_PREV_ITEM_1_THEME_RESP_USER_MGR_ABBR_NAME 	COMMENT 'Coded name of the manager of the NFPO source system user.
			CBX: CTM_USER.CUST_TEXT2
			LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_MANAGER_ABBR_NAME
			CORE_REL:t_nfpo_user.nfpo_user_mgr_abbr_name',
	NFPO_PREV_ITEM_2_SID 							COMMENT 'Surrogate Key NFPO ITEM_1 INSTANCE.
			CBX: CNT_ITEM_RELATED.RELATED_ITEM_REF
			LDL: P_LEW_CORE.T_MDM_ITEM_RELATED_ITEM_HIST.MDM_ITEM_SID_RELATED
			CORE_REL:t_nfpo_item_related_item_hist.nfpo_rel_item_sid',
	NFPO_PREV_ITEM_2_NR 							COMMENT 'NFPO item_1 instance reference.
			CBX: CNT_ITEM.REF_NO
			LDL: P_LEW_CORE.T_MDM_ITEM.SRC_ITEM_DOC_REF
			CORE_REL:t_nfpo_item.nfpo_item_nr',
	NFPO_PREV_ITEM_2_NAME 							COMMENT 'NFPO item_1 name.
			CBX: CNT_ITEM.ITEM_DESC, SHORT_DESC
			LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_NAME
			CORE_REL:t_nfpo_item.nfpo_item_name',
	NFPO_PREV_ITEM_2_LDL_ITEM_IAN_NR 				COMMENT 'Lidl International Item_1 Number (not necessarily unique in this table - numbers can be reused if an item_1 is cancelled, or multiple item_1 instances will be created for catalog items).
			CBX: CNT_ITEM.ITEM_NO
			LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_IAN
			CORE_REL:t_nfpo_item.ldl_item_ian_nr',
	NFPO_PREV_ITEM_2_SEL_NR 						COMMENT 'NFPO source system internal identifier for an article.
			CBX: CNT_ITEM.LDL_SELECTION_NO
			LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_SELECTION_NR
			CORE_REL:t_nfpo_item.nfpo_item_sel_nr',
	NFPO_PREV_ITEM_2_MARKET_REL_ITEM_SID 			COMMENT 'Surrogate Key related NFPO ITEM_1 INSTANCE between US item_1 and non-US item. Between certain markets_1 like US and non-US there are different NFPO_ITEM_SIDs for the same article.
			CBX: CNT_ITEM_RELATED.RELATED_ITEM_REF
			LDL: P_LEW_CORE.T_MDM_ITEM_RELATED_ITEM_HIST.MDM_ITEM_SID_RELATED
			CORE_REL:t_nfpo_item_related_item_hist.nfpo_rel_item_sid',
	NFPO_PREV_ITEM_2_STATUS_CD 						COMMENT 'Technical status_1 of the NFPO item_1 in the source system (active, inactive, cancelled).
			CBX: CNT_ITEM.DOC_STATUS
			LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CBX_ITEM_DOC_STATUS
			CORE_REL:t_nfpo_item_hist.nfpo_item_status_cd',
	NFPO_PREV_ITEM_2_EU_COMPLETION_TYPE_CD			COMMENT 'NFPO completion types.
            CBX: CNT_ITEM.LDL_COMPLETION_TYPE, LDL_COMPLETION_TYPE_US
            LDL: P_LEW_CORE.T_MDM_ITEM_MARKET_HIST.MDM_COMPLETION_TYPE_CD
            CORE_REL: T_NFPO_ITEM_MARKET_HIST.NFPO_COMPLETION_TYPE_CD',
	NFPO_PREV_ITEM_2_EU_COMPLETION_TYPE_NAME	    COMMENT 'NFPO completion type name.
            CBX: CNT_CODELIST.NAME (code list "LIDL_OWIMFH" and "LIDL_COMPLTYPE_US")
            LDL: P_LEW_CORE.T_REF_MDM_COMPLETION_TYPE.MDM_COMPLETION_TYPE_NAME
            CORE_REL: T_NFPO_COMPLETION_TYPE.NFPO_COMPLETION_TYPE_NAME',
	NFPO_PREV_ITEM_3_SID                			COMMENT 'Surrogate Key NFPO ITEM_1 INSTANCE.
            CBX: CNT_ITEM_RELATED.RELATED_ITEM_REF
            LDL: P_LEW_CORE.T_MDM_ITEM_RELATED_ITEM_HIST.MDM_ITEM_SID_RELATED
            CORE_REL: T_NFPO_ITEM_RELATED_ITEM_HIST.NFPO_REL_ITEM_SID',
	NFPO_PREV_ITEM_3_NR                 			COMMENT 'NFPO item_1 instance reference.
            CBX: CNT_ITEM.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.SRC_ITEM_DOC_REF
            CORE_REL: T_NFPO_ITEM.NFPO_ITEM_NR',
	NFPO_PREV_ITEM_3_NAME               			COMMENT 'NFPO item_1 name.
            CBX: CNT_ITEM.ITEM_DESC, SHORT_DESC
            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_NAME
            CORE_REL: T_NFPO_ITEM.NFPO_ITEM_NAME',
	NFPO_PREV_ITEM_3_LDL_ITEM_IAN_NR    			COMMENT 'Lidl International Item_1 Number (not necessarily unique in this table - numbers can be reused if an item_1 is cancelled, or multiple item_1 instances will be created for catalog items).
            CBX: CNT_ITEM.ITEM_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_IAN
            CORE_REL: T_NFPO_ITEM.LDL_ITEM_IAN_NR',
	NFPO_PREV_ITEM_4_SID							COMMENT 'Surrogate Key NFPO ITEM_1 INSTANCE.
            CBX: CNT_ITEM_RELATED.RELATED_ITEM_REF
            LDL: P_LEW_CORE.T_MDM_ITEM_RELATED_ITEM_HIST.MDM_ITEM_SID_RELATED
            CORE_REL: T_NFPO_ITEM_RELATED_ITEM_HIST.NFPO_REL_ITEM_SID',
	NFPO_PREV_ITEM_4_NR                 			COMMENT 'NFPO item_1 instance reference.
            CBX: CNT_ITEM.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.SRC_ITEM_DOC_REF
            CORE_REL: T_NFPO_ITEM.NFPO_ITEM_NR',
	NFPO_PREV_ITEM_4_NAME							COMMENT 'NFPO item_1 name.
            CBX: CNT_ITEM.ITEM_DESC, SHORT_DESC
            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_NAME
            CORE_REL: T_NFPO_ITEM.NFPO_ITEM_NAME',
	NFPO_PREV_ITEM_4_LDL_ITEM_IAN_NR				COMMENT 'Lidl International Item_1 Number (not necessarily unique in this table - numbers can be reused if an item_1 is cancelled, or multiple item_1 instances will be created for catalog items).
            CBX: CNT_ITEM.ITEM_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_IAN
            CORE_REL: T_NFPO_ITEM.LDL_ITEM_IAN_NR',
	DWH_CREATED_TMSP 								COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED_TMSP 								COMMENT 'Timestamp of the last update of the record in the DWH.',
	DWH_SRC_TMSP 									COMMENT 'Timestamp of source extraction.'
) COMMENT = 'NFPO item_1 dimension.'
AS
SELECT
   nfpo_item_sid
  ,nfpo_item_nr
  ,nfpo_item_name
  ,nfpo_item_created_dt
  ,ldl_item_ian_nr || ' ' ||nfpo_item_name || ' [' ||  nfpo_range_plan_nr || ']' AS nfpo_item_display_name
  ,CASE
        WHEN current_database()='NFPOW_PRODUCTION' THEN '<img src=' || '''https://se1-pnf-p003.ads.schwarz/images/Share/small/' || SUBSTR(ldl_item_ian_nr, 1,3) || '/' || ldl_item_ian_nr || '.JPG''' || '>' 
        ELSE                                            '<img src=' || '''https://se1-pnf-q005.ads.schwarz/images/small/' || SUBSTR(ldl_item_ian_nr, 1,3) || '/' || ldl_item_ian_nr || '.JPG''' || '>' 
        END AS nfpo_item_s_image_tag_txt
  ,CASE
        WHEN current_database()='NFPOW_PRODUCTION' THEN '<img src=' || '''https://se1-pnf-p003.ads.schwarz/images/Share/small/' || SUBSTR(ldl_item_ian_nr, 1,3) || '/' || ldl_item_ian_nr || '.JPG''' || 'height="50px" width="73,5px">'
        ELSE                                            '<img src=' || '''https://se1-pnf-q005.ads.schwarz/images/small/' || SUBSTR(ldl_item_ian_nr, 1,3) || '/' || ldl_item_ian_nr || '.JPG''' || 'height="50px" width="73,5px">'
        END AS nfpo_item_xs_image_tag_txt
  ,CASE
        WHEN current_database()='NFPOW_PRODUCTION' THEN 'https://se1-pnf-p003.ads.schwarz/images/Share/small/' || SUBSTR(ldl_item_ian_nr, 1,3) || '/' || ldl_item_ian_nr || '.JPG'
        ELSE                                            'https://se1-pnf-q005.ads.schwarz/images/small/' || SUBSTR(ldl_item_ian_nr, 1,3) || '/' || ldl_item_ian_nr || '.JPG'
        END AS nfpo_item_s_image_url_txt
  ,CASE
        WHEN current_database()='NFPOW_PRODUCTION' THEN '<img src=' || '''https://se1-pnf-p003.ads.schwarz/images/Share/medium/' || SUBSTR(ldl_item_ian_nr, 1,3) || '/' || ldl_item_ian_nr || '.JPG''' || '>'
        ELSE                                            '<img src=' || '''https://se1-pnf-q005.ads.schwarz/images/medium/' || SUBSTR(ldl_item_ian_nr, 1,3) || '/' || ldl_item_ian_nr || '.JPG''' || '>'
        END AS nfpo_item_m_image_tag_txt
  ,CASE
        WHEN current_database()='NFPOW_PRODUCTION' THEN 'https://se1-pnf-p003.ads.schwarz/images/Share/medium/' || SUBSTR(ldl_item_ian_nr, 1,3) || '/' || ldl_item_ian_nr || '.JPG'
        ELSE                                            'https://se1-pnf-q005.ads.schwarz/images/medium/' || SUBSTR(ldl_item_ian_nr, 1,3) || '/' || ldl_item_ian_nr || '.JPG' 
        END AS nfpo_item_m_image_url_txt
  ,ldl_item_ian_nr
  ,nfpo_item_range_plan_nr
  ,nfpo_item_sel_nr
  ,nfpo_market_rel_item_sid
  ,nfpo_item_origin_country_sid
  ,nfpo_item_origin_country_cd
  ,nfpo_item_origin_country_name
  ,nfpo_item_status_cd
  ,nfpo_default_case_size_qty
  ,nfpo_sup_sid
  ,nfpo_sup_nr
  ,nfpo_sup_name
  ,nfpo_gtin_ownership_cd
  ,nfpo_gtin_ownership_descr
  ,nfpo_sup_country_sid
  ,nfpo_sup_country_cd
  ,nfpo_sup_country_name
  ,nfpo_sup_street_name
  ,nfpo_sup_city_name
  ,nfpo_sup_zip
  ,eks_sup_nr
  ,nfpo_final_sup_fg
  ,nfpo_rfq_sup_list_txt
  ,nfpo_rfq_sup_name_list_txt
  ,nfpo_market_sid
  ,nfpo_market_cd
  ,nfpo_market_name
  ,nfpo_eu_completion_type_cd
  ,nfpo_eu_completion_type_name
  ,nfpo_us_completion_type_cd
  ,nfpo_us_completion_type_name
  ,nfpo_eu_incoterm_cd
  ,nfpo_eu_incoterm_name
  ,nfpo_us_incoterm_cd
  ,nfpo_us_incoterm_name
  ,nfpo_org_order_status_cd
  ,nfpo_org_order_status_descr_de
  ,nfpo_item_workflow_status_id
  ,nfpo_item_workflow_status_descr
  ,nfpo_item_creation_class_cd
  ,nfpo_item_creation_class_name
  ,nfpo_item_quality_class_cd
  ,nfpo_item_quality_class_descr
  ,nfpo_display_type_cd
  ,nfpo_display_type_name
  ,nfpo_item_purch_comment_txt
  ,nfpo_item_quality_comment_txt
  ,nfpo_item_highlight_fg
  ,nfpo_item_init_order_fg
  ,nfpo_item_unit_uom_nr
  ,nfpo_item_unit_uom_cd
  ,nfpo_item_unit_uom_name
  ,nfpo_item_unit_qty
  ,nfpo_item_unit_cnt
  ,nfpo_item_min_order_qty
  ,nfpo_item_variant_cnt
  ,nfpo_pack_type_cd
  ,nfpo_pack_type_name
  ,nfpo_item_composition_cd
  ,nfpo_item_composition_txt
  ,nfpo_list_type_cd
  ,nfpo_list_type_name
  ,nfpo_init_range_plan_nr
  ,nfpo_catalog_item_fg
  ,nfpo_order_month_list_txt
  ,nfpo_order_month_name_list_txt
  ,nfpo_item_initiating_org_sid
  ,nfpo_item_initiating_org_nr
  ,nfpo_item_initiating_org_descr
  ,nfpo_item_proposing_org_sid
  ,nfpo_item_proposing_org_nr
  ,CASE
		WHEN nfpo_item_proposing_org_nr = 'KDE' THEN 'TRUE'
		ELSE 'FALSE'
		END AS nfpo_item_proposing_org_nr_kde
  ,nfpo_item_proposing_org_descr
  ,controlled_price_fg
  ,nfpo_ldl_brand_sid
  ,nfpo_ldl_brand_nr
  ,nfpo_ldl_brand_name
  ,nfpo_ldl_brand_type_cd
  ,nfpo_ldl_brand_type_name
  ,nfpo_kfl_brand_sid
  ,nfpo_kfl_brand_name
  ,nfpo_pillar_sid
  ,nfpo_pillar_name
  ,nfpo_main_pillar_cd
  ,nfpo_main_pillar_name
  ,nfpo_cust_need_type_cd
  ,nfpo_cust_need_type_name
  ,nfpo_cust_need_subtype_cd
  ,nfpo_cust_need_subtype_name
  ,nfpo_assort_profile_type_cd
  ,nfpo_assort_profile_type_name
  ,ldl_core_assort_type_grp_cd
  ,ldl_core_assort_type_grp_name
  ,nfpo_item_fam_grp_sid
  ,nfpo_item_fam_grp_nr
  ,nfpo_item_fam_grp_name
  ,nfpo_assortment_area_id
  ,nfpo_assortment_area_name
  ,nfpo_item_property_list_txt
  ,nfpo_catalog_item_contract_expiry_dt
  ,nfpo_warranty_dur_cd
  ,nfpo_warranty_dur_name
  ,nfpo_warranty_type_cd
  ,nfpo_warranty_type_name
  ,nfpo_warranty_descr
  ,nfpo_item_note_txt
  ,nfpo_case_composition_cd
  ,nfpo_case_composition_txt
  ,nfpo_subcase_size_qty
  ,nfpo_case_composition_name
  ,nfpo_smart_item_fg
  ,nfpo_logistics_class_cd
  ,nfpo_logistics_class_name
  ,nfpo_ldl_sales_packaging_type_cd
  ,nfpo_ldl_sales_packaging_type_name
  ,nfpo_kfl_sales_packaging_type_cd
  ,nfpo_kfl_sales_packaging_type_name
  ,nfpo_item_standard_property_class_cd
  ,nfpo_item_standard_property_list_txt
  ,nfpo_shipping_container_20ft_qty
  ,nfpo_shipping_container_40ft_qty
  ,nfpo_shipping_container_40ft_hc_qty
  ,eu_data_act_relevant_fg
  ,nfpo_competitor_1_sid
  ,nfpo_competitor_1_cd
  ,nfpo_competitor_1_name
  ,nfpo_competitor_1_abbr_name
  ,nfpo_competitor_1_sale_price
  ,nfpo_competitor_1_sell_from_dt
  ,nfpo_competitor_2_sid
  ,nfpo_competitor_2_cd
  ,nfpo_competitor_2_name
  ,nfpo_competitor_2_abbr_name
  ,nfpo_competitor_2_sale_price
  ,nfpo_competitor_2_sell_from_dt
  ,nfpo_item_deliv_1_cal_week
  ,nfpo_item_deliv_2_cal_week
  ,nfpo_item_deliv_3_cal_week
  ,nfpo_item_adv_1_cal_week
  ,nfpo_item_adv_2_cal_week
  ,nfpo_item_adv_3_cal_week
  ,nfpo_adv_theme_sid
  ,nfpo_adv_theme_nr
  ,nfpo_adv_theme_week_cd || ' - ' || nfpo_adv_theme_name || ' [' ||  nfpo_range_plan_nr || ']'  AS nfpo_adv_theme_display_name
  ,nfpo_adv_theme_name
  ,nfpo_adv_theme_week_cd
  ,nfpo_adv_theme_status_cd
  ,nfpo_adv_theme_deliv_1_cal_week
  ,nfpo_adv_theme_deliv_2_cal_week
  ,nfpo_adv_theme_deliv_3_cal_week
  ,nfpo_adv_theme_adv_1_cal_week
  ,nfpo_adv_theme_adv_2_cal_week
  ,nfpo_adv_theme_adv_3_cal_week
  ,nfpo_range_sel_sid
  ,nfpo_range_sel_nr
  ,nfpo_range_plan_nr
  ,nfpo_range_sel_cal_month
  ,nfpo_range_sel_cal_year
  ,nfpo_range_sel_deliv_from_cal_week
  ,nfpo_range_sel_deliv_to_cal_week
  ,nfpo_range_sel_adv_from_cal_week
  ,nfpo_range_sel_adv_to_cal_week
  ,nfpo_ekl_user_sid
  ,nfpo_ekl_user_acct_name
  ,nfpo_ekl_user_first_name
  ,nfpo_ekl_user_last_name
  ,nfpo_ekl_user_abbr_name
  ,nfpo_ekl_user_mgr_abbr_name
  ,nfpo_ekl_user_first_name || ' ' || nfpo_ekl_user_first_name || ' (' || nfpo_ekl_user_abbr_name ||')' AS nfpo_ekl_user_display_name
  ,nfpo_se_user_sid
  ,nfpo_se_user_acct_name
  ,nfpo_se_user_first_name
  ,nfpo_se_user_last_name
  ,nfpo_se_user_abbr_name
  ,nfpo_se_user_mgr_abbr_name
  ,nfpo_theme_resp_user_sid
  ,nfpo_theme_resp_user_acct_name
  ,nfpo_theme_resp_user_first_name
  ,nfpo_theme_resp_user_last_name
  ,nfpo_theme_resp_user_abbr_name
  ,nfpo_theme_resp_user_mgr_abbr_name
  ,nfpo_item_org_release_list_txt
  ,nfpo_prev_item_1_sid
  ,nfpo_prev_item_1_nr
  ,nfpo_prev_item_1_name
  ,nfpo_prev_item_1_ldl_item_ian_nr
  ,nfpo_prev_item_1_sel_nr
  ,nfpo_prev_item_1_market_rel_item_sid
  ,nfpo_prev_item_1_status_cd
  ,nfpo_prev_item_1_sup_sid
  ,nfpo_prev_item_1_sup_nr
  ,nfpo_prev_item_1_sup_name
  ,nfpo_prev_item_1_gtin_ownership_cd
  ,nfpo_prev_item_1_gtin_ownership_descr
  ,nfpo_prev_item_1_sup_country_sid
  ,nfpo_prev_item_1_sup_country_cd
  ,nfpo_prev_item_1_sup_country_name
  ,nfpo_prev_item_1_sup_street_name
  ,nfpo_prev_item_1_sup_city_name
  ,nfpo_prev_item_1_sup_zip
  ,nfpo_prev_item_1_eks_sup_nr
  ,nfpo_prev_item_1_eu_completion_type_cd
  ,nfpo_prev_item_1_eu_completion_type_name
  ,nfpo_prev_item_1_ldl_brand_sid
  ,nfpo_prev_item_1_ldl_brand_nr
  ,nfpo_prev_item_1_ldl_brand_name
  ,nfpo_prev_item_1_ldl_brand_type_cd
  ,nfpo_prev_item_1_ldl_brand_type_name
  ,nfpo_prev_item_1_item_fam_grp_sid
  ,nfpo_prev_item_1_item_fam_grp_nr
  ,nfpo_prev_item_1_item_fam_grp_name
  ,nfpo_prev_item_1_adv_theme_sid
  ,nfpo_prev_item_1_adv_theme_nr
  ,nfpo_prev_item_1_adv_theme_name
  ,nfpo_prev_item_1_adv_theme_week_cd
  ,nfpo_prev_item_1_adv_theme_status_cd
  ,nfpo_prev_item_1_range_sel_sid
  ,nfpo_prev_item_1_range_sel_nr
  ,nfpo_prev_item_1_range_plan_nr
  ,nfpo_prev_item_1_range_sel_cal_month
  ,nfpo_prev_item_1_range_sel_cal_year
  ,nfpo_prev_item_1_ekl_user_sid
  ,nfpo_prev_item_1_ekl_user_acct_name
  ,nfpo_prev_item_1_ekl_user_first_name
  ,nfpo_prev_item_1_ekl_user_last_name
  ,nfpo_prev_item_1_ekl_user_abbr_name
  ,nfpo_prev_item_1_ekl_user_mgr_abbr_name
  ,nfpo_prev_item_1_theme_resp_user_sid
  ,nfpo_prev_item_1_theme_resp_user_acct_name
  ,nfpo_prev_item_1_theme_resp_user_first_name
  ,nfpo_prev_item_1_theme_resp_user_last_name
  ,nfpo_prev_item_1_theme_resp_user_abbr_name
  ,nfpo_prev_item_1_theme_resp_user_mgr_abbr_name
  ,nfpo_prev_item_2_sid
  ,nfpo_prev_item_2_nr
  ,nfpo_prev_item_2_name
  ,nfpo_prev_item_2_ldl_item_ian_nr
  ,nfpo_prev_item_2_sel_nr
  ,nfpo_prev_item_2_market_rel_item_sid
  ,nfpo_prev_item_2_status_cd
  ,nfpo_prev_item_2_eu_completion_type_cd
  ,nfpo_prev_item_2_eu_completion_type_name
  ,nfpo_prev_item_3_sid
  ,nfpo_prev_item_3_nr
  ,nfpo_prev_item_3_name
  ,nfpo_prev_item_3_ldl_item_ian_nr
  ,nfpo_prev_item_4_sid
  ,nfpo_prev_item_4_nr
  ,nfpo_prev_item_4_name
  ,nfpo_prev_item_4_ldl_item_ian_nr
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
  
FROM CORE.T_DIM_NFPO_ITEM_1
;