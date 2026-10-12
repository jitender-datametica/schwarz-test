CREATE
	OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_BO_BASE_FLOP10_2 COMMENT = 'Top level view for processing data for lew_mart_msi.t_bo_base_flop10_2'
	----------------------------------------------------------------------------
	-- History:
	--  1.0  04.06.2018    Thole,Jens               Reengineering BO FLOP 10 - Endstufe der Basisdatenmaterialisierung
	--  1.1  25.07.2018    Thole,Jens               Umstellung auf logisches BIL-Objekt v_location_organization_2
	--  1.2  06.09.2018    Chandramani Kumbhale     Three new columns (val_rtl_net_sfo_mhd_break, val_rtl_net_sfo_other_stc_loss, val_rtl_net_sfo_str_deliv_qlty) added for report "Abschriften_2 - Gesamt"
	--                                              20180905_1820_Resns_Of_WTOF_For_FBO_Rep5
	--                                              https://jira-lidl-public.pixsoftware.de/browse/LEAD05-2535
	--                                              https://jira-lidl-public.pixsoftware.de/browse/IDMO-1015
	--  1.3 16.11.2018    Michael Strauch           20181113_1882_Differ_writeoff_reasons_FBO_Rep1 - extended by some columns to differenziate the values by pcwo_resons
	--  1.4 05.02.2019    Michael Mzyk              20190204_1948_Modification_Flop_10_Report_Rep1 - modification of order login in fields rank_abs and rank_rel
	--  1.5 11.03.2021    Kiran Nagmote             20210311_2780_Frischfish_Changes_FBO
	--                                              Frischfisch changes , extended WG ids 
	--  1.6 11.12.2024    Stefan Sockel             INC9229115 - Remove case for WGI 10 that used SFO instead of EJR for val_rtl_net_sfo_mhd_break_discount - only ejr should be used  
	--  1.7 24.03.2025	  Dominik Pfarr             INC9229115 - Remove case for WGI 10 that used SFO instead of EJR for val_rtl_net_sfo_mhd_break_discount - only SFO should be used 
	--  1.8 09.05.2025	  Stefan Sockel             INC10730738 - Change to use EJR for val_rtl_net_sfo_mhd_break_discount to correct flop 10 selection and sorting in Item_2 and SIG
	----------------------------------------------------------------------------
	AS

SELECT ag2.target_type
	, ag2.target_type_id
	, COALESCE(sam.account_manager_id, - 1) AS account_manager_id
	, COALESCE(sam.account_manager_name, 'Vertriebsleiter') AS account_manager_name
	, COALESCE(sam.sales_manager_id, - 100) AS sales_manager_id
	, COALESCE(sam.sales_manager_name, 'Bezirksleiter') AS sales_manager_name
	, osc.city
	, rct.country_id
	, rct.country_desc
	, rct.country_iso_cd
	, osa.src_orig_store_nr AS orig_store_nr
	, COALESCE(osa.loc_name2, osa.loc_name) AS store_desc
	, COALESCE(owh.loc_name2, owh.loc_name) AS wh_desc
	, ag2.client_id
	, ag2.loc_sid_store AS store_id
	, ag2.wh_id
	, ag2.orig_item_nr
	, ag2.dat_valid_from
	, ag2.item_desc
	, ag2.subitemgroup_id
	, ag2.item_wgi_id
	, ag2.dat_formdate
	, ag2.cy_week
	, ag2.cy_month
	, ag2.currency_iso_cd
	, ag2.val_rtl_rl_sfo_store
	, ag2.val_rtl_rl_net_sfo_store
	, ag2.val_rtl_net_sfo_mhd_break
	, ag2.val_rtl_net_sfo_other_stc_loss
	, ag2.val_rtl_net_sfo_str_deliv_qlty
	, ag2.val_wrtoff_zero_store
	, ag2.val_wrtoff_zero_store_net
	, ag2.val_wrtoff_zero_store_net_mhd_break
	, ag2.val_wrtoff_zero_store_net_other_stc_loss
	, ag2.val_wrtoff_zero_store_net_str_deliv_qlty
	, ag2.qty_total_sfo_store
	, ag2.qty_total_sfo_store_mhd_break
	, ag2.qty_total_sfo_store_other_stc_loss
	, ag2.qty_total_sfo_store_str_deliv_qlty
	, ag2.qty_disc_piece_weigth_ejr_asis
	, ag2.val_discount_ejr AS val_discount_sfo
	, ag2.val_discount_net_ejr AS val_discount_net_sfo
	, ag2.val_rtl_ejr_adj
	, ag2.val_rtl_net_ejr_adj
	, ag2.sfo_to_val_retail_pct
	, ag2.sfo_to_val_retail_net_pct
	, ag2.wrtoff_zero_to_val_retail_pct
	, ag2.wrtoff_zero_to_val_retail_net_pct
	, ag2.discount_sfo_to_val_retail_pct
	, ag2.discount_sfo_to_val_retail_net_pct
	, ROW_NUMBER() OVER (
		PARTITION BY ag2.client_id
		, ag2.loc_sid_store
		, ag2.wh_id
		, ag2.abstract_item_hierarchy_id
		, ag2.abstract_time_unit
		, ag2.currency_iso_cd
		, ag2.target_type ORDER BY COALESCE(val_rtl_net_sfo_mhd_break_discount, 0) ASC
			, orig_item_nr
		) AS rank_abs
	, ROW_NUMBER() OVER (
		PARTITION BY ag2.client_id
		, ag2.loc_sid_store
		, ag2.wh_id
		, ag2.abstract_item_hierarchy_id
		, ag2.abstract_time_unit
		, ag2.currency_iso_cd
		, ag2.target_type ORDER BY COALESCE(sfo_to_val_retail_mhd_break_discount_pct, 0) ASC
			, orig_item_nr
		) AS rank_rel
/* sfo_to_val_retail_mhd_break_discount_pct  (Definition siehe unten) ersetzt das frühere Rankingkriterium: sfo_to_val_retail_pct.	
                                      Dieses neue Rankingkriterium steht für die Nettosumme aus Abschriften_2 Filiale und Rabattierung in Relation zum Gesamtnettoumsatz (relative Wertebetrachtung).	
                                      Fachlicher Hintergrund ist wie bei rank_abs, dass auch stark rabattierte Artikel_2 mit ansonsten niedrigeren Abs Fil im Ranking berücksichtigt werden sollen.	
                                   */
FROM (
	SELECT ag1.target_type
		, ag1.target_type_id
		, ag1.client_id
		, ag1.loc_sid_store
		, ag1.loc_sid_wh
		, ag1.wh_id
		, ag1.orig_item_nr
		, ag1.max_dat_valid_from AS dat_valid_from
		, ag1.item_desc
		, ag1.itemhierarchy_cd abstract_item_hierarchy_id
		, CASE 
			WHEN hier_level_fg = 'S'
				THEN CAST(ag1.itemhierarchy_id AS INTEGER)
			END AS subitemgroup_id
		, CASE 
			WHEN hier_level_fg = 'I'
				THEN CAST(ag1.itemhierarchy_id AS INTEGER)
			END AS item_wgi_id
		, ag1.abstract_time_unit
		, ag1.dat_formdate
		, ag1.cy_week
		, ag1.cy_month
		, ag1.currency_iso_cd
		, ag1.val_rtl_rl_sfo_store
		, ag1.val_rtl_rl_net_sfo_store
		, ag1.val_rtl_net_sfo_mhd_break
		, ag1.val_rtl_net_sfo_other_stc_loss
		, ag1.val_rtl_net_sfo_str_deliv_qlty
		, ag1.val_wrtoff_zero_store
		, ag1.val_wrtoff_zero_store_net
		, ag1.val_wrtoff_zero_store_net_mhd_break
		, ag1.val_wrtoff_zero_store_net_other_stc_loss
		, ag1.val_wrtoff_zero_store_net_str_deliv_qlty
		, ag1.qty_total_sfo_store
		, ag1.qty_total_sfo_store_mhd_break
		, ag1.qty_total_sfo_store_other_stc_loss
		, ag1.qty_total_sfo_store_str_deliv_qlty
		, ag1.val_discount_ejr
		, ag1.val_discount_net_ejr
		, ag1.val_rtl_ejr_adj
		, ag1.val_rtl_net_ejr_adj
		, ag1.qty_disc_piece_weigth_ejr_asis
		, CAST(COALESCE(COALESCE(ag1.val_wrtoff_zero_store, 0) / NULLIFZERO(ag1.val_rtl_ejr_adj), 0) * 100 AS DECIMAL(36, 10)) AS sfo_to_val_retail_pct
		, CAST(COALESCE(COALESCE(ag1.val_wrtoff_zero_store_net, 0) / NULLIFZERO(ag1.val_rtl_net_ejr_adj), 0) * 100 AS DECIMAL(36, 10)) AS sfo_to_val_retail_net_pct
		, CAST(COALESCE(COALESCE(ag1.val_wrtoff_zero_store, 0) / NULLIFZERO(ag1.val_rtl_ejr_adj), 0) * 100 AS DECIMAL(36, 10)) AS wrtoff_zero_to_val_retail_pct
		, CAST(COALESCE(COALESCE(ag1.val_wrtoff_zero_store_net, 0) / NULLIFZERO(ag1.val_rtl_net_ejr_adj), 0) * 100 AS DECIMAL(36, 10)) AS wrtoff_zero_to_val_retail_net_pct
		, CAST(COALESCE(COALESCE(ag1.val_discount_ejr, 0) / NULLIFZERO(ag1.val_rtl_ejr_adj), 0) * 100 AS DECIMAL(36, 10)) AS discount_sfo_to_val_retail_pct
		, CAST(COALESCE(COALESCE(ag1.val_discount_net_ejr, 0) / NULLIFZERO(ag1.val_rtl_net_ejr_adj), 0) * 100 AS DECIMAL(36, 10)) AS discount_sfo_to_val_retail_net_pct
		, CASE 
			WHEN hier_level_fg = 'S'
				THEN CAST (ag1.val_rtl_net_sfo_mhd_break + ag1.val_discount_net_ejr AS DECIMAL(36, 10))
			WHEN hier_level_fg = 'I'
				THEN 
                    CAST (ag1.val_rtl_net_sfo_mhd_break + ag1.val_discount_net_ejr AS DECIMAL(36, 10))	
			    END AS val_rtl_net_sfo_mhd_break_discount
		, CAST(COALESCE(val_rtl_net_sfo_mhd_break_discount, 0) / CASE 
				WHEN COALESCE(ag1.val_rtl_net_ejr_adj, 0) = 0
					THEN NULL
				ELSE ag1.val_rtl_net_ejr_adj
				END * 100 AS DECIMAL(36, 10)) AS sfo_to_val_retail_mhd_break_discount_pct
	FROM ---------------BASIS--------------------------------	
		p_lew_mart_msi.v_mat1_bo_base_flop10_2 AS ag1
		----------------------------------------------------	
	) AS ag2
INNER JOIN p_lew_core_ac.v_wawi_ref_country_act_2 AS rct ON ag2.client_id = rct.country_id
	AND ag2.client_id = rct.language_id
INNER JOIN p_lew_core_ac.v_location_2 AS osa ON ag2.client_id = osa.client_id
	AND ag2.loc_sid_store = osa.loc_sid
INNER JOIN p_lew_core_ac.v_location_hist_2 AS lh ON ag2.client_id = lh.client_id
	AND ag2.loc_sid_store = lh.loc_sid
	AND CURRENT_DATE BETWEEN lh.dwh_valid_from
		AND lh.dwh_valid_to
LEFT OUTER JOIN p_lew_core_ac.v_address_2 AS osc ON lh.client_id = osc.client_id
	AND lh.addr_sid = osc.addr_sid
INNER JOIN p_lew_core_ac.v_location_2 AS owh ON ag2.client_id = owh.client_id
	AND ag2.loc_sid_wh = owh.loc_sid
LEFT OUTER JOIN p_lew_bil_ac.v_location_organization_2 AS sam ON ag2.client_id = sam.client_id
	AND ag2.loc_sid_store = sam.loc_sid_store
	AND ag2.loc_sid_wh = sam.loc_sid_wh;