CREATE
	OR REPLACE VIEW P_LEW_MART_MSI.V_MAT1_BO_BASE_FLOP10_2
	------------------------------------------------------------------------------
	-- History:
	--  1.0  04.06.2018    Thole,Jens               Reengineering BO FLOP 10 - Stufe 1 der Basisdatenmaterialisierung
	--  1.1  26.06.2018    Thole,Jens               Bugfix: Hybrid-Ermittlung des Zielfeldes qty_disc_piece_weigth_sfo_asis (f?r WGI 1 aus SFO sonst aus EJR)
	--  1.2  17.07.2018    Thole,Jens               R?ckfall auf vor-Car; Einbau Einfachsumme; Verlagerung ITEM_MAP_KEY auf ITEMblock
	--  1.3  24.07.2018    Thole,Jens               Perfo: Ausbau des Joins auf ITEM_MAP_KEY, da nun als INNER JOIN auf V_MAT0 verlagert
	--  1.4  06.09.2018    Chandramani Kumbhale     Three new columns (val_rtl_net_sfo_mhd_break, val_rtl_net_sfo_other_stc_loss, val_rtl_net_sfo_str_deliv_qlty) added for report "Abschriften_2 - Gesamt"
	--                                              20180905_1820_Resns_Of_WTOF_For_FBO_Rep5
	--                                              https://jira-lidl-public.pixsoftware.de/browse/LEAD05-2535
	--                                              https://jira-lidl-public.pixsoftware.de/browse/IDMO-1015
	--  1.5 16.11.2018    Michael Strauch           20181113_1882_Differ_writeoff_reasons_FBO_Rep1 - extended by some columns to differenziate the values by pcwo_resons
	--  1.6 11.03.2021    Kiran Nagmote             20210311_2780_Frischfish_Changes_FBO 
	--                                              Frischfisch changes , extended WG ids 
	--  1.7 11.12.2024    Stefan Sockel             INC9229115 - Remove case for WGI 10 that used SFO instead of EJR for qty_disc_piece_weight_ejr_asis - only ejr should be used
	--  1.8 24.03.2025    Domoinik Pfarr            INC9229115 - Remove case for WGI 10 that used SFO instead of EJR for qty_disc_piece_weight_ejr_asis - only SFO should be used
	------------------------------------------------------------------------------
	AS

SELECT agg.client_id
	, agg.loc_sid_store
	, os.src_wh_id AS wh_id
	, os.loc_sid_wh
	, iia.orig_item_nr
	, iia.max_dat_valid_from
	, agg.abstract_time_unit
	, CASE 
		WHEN agg.time_range_fg = 1
			THEN TO_DATE(TO_CHAR(agg.abstract_time_unit), 'YYYYMMDD')
		END AS dat_formdate
	, CASE 
		WHEN agg.time_range_fg = 2
			THEN agg.abstract_time_unit
		END AS cy_week
	, CASE 
		WHEN agg.time_range_fg = 3
			THEN agg.abstract_time_unit
		END AS cy_month
	, agg.time_range_fg
	, MAX(iia.item_descr) AS item_desc
	, sig.itemhierarchy_cd
	, SUBSTR(sig.itemhierarchy_cd, 1, 1) AS hier_level_fg
	, SUBSTR(sig.itemhierarchy_cd, 2) AS itemhierarchy_id
	, agg.curr_cd AS currency_iso_cd
	, SUM(agg.val_rtl_rl_sfo) AS val_rtl_rl_sfo_store
	, SUM(agg.val_rtl_rl_net_sfo) AS val_rtl_rl_net_sfo_store
	, SUM(agg.val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break
	, SUM(agg.val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss
	, SUM(agg.val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty
	, SUM(agg.val_wrtoff_zero) AS val_wrtoff_zero_store
	, SUM(agg.val_wrtoff_zero_net) AS val_wrtoff_zero_store_net
	, Sum(agg.val_wrtoff_zero_net_mhd_break) AS val_wrtoff_zero_store_net_mhd_break
	, Sum(agg.val_wrtoff_zero_net_other_stc_loss) AS val_wrtoff_zero_store_net_other_stc_loss
	, Sum(agg.val_wrtoff_zero_net_deliv_qlty) AS val_wrtoff_zero_store_net_str_deliv_qlty
	, SUM(agg.qty_total_sfo) AS qty_total_sfo_store
	, Sum(agg.qty_total_sfo_mhd_break) AS qty_total_sfo_store_mhd_break
	, Sum(agg.qty_total_sfo_other_stc_loss) AS qty_total_sfo_store_other_stc_loss
	, Sum(agg.qty_total_sfo_str_deliv_qlty) AS qty_total_sfo_store_str_deliv_qlty
	, SUM(agg._val_discount_ejr) AS val_discount_ejr
	, SUM(agg._val_discount_net_ejr) AS val_discount_net_ejr
	, SUM(agg._val_rtl_ejr_adj) AS val_rtl_ejr_adj
	, SUM(agg._val_rtl_net_ejr_adj) AS val_rtl_net_ejr_adj
	, SUM(agg.qty_disc_piece_weigth_sfo_asis) AS qty_disc_piece_weigth_ejr_asis
	, CAST(CASE 
			WHEN hier_level_fg = 'S'
				AND time_range_fg = 1
				THEN 'sig_day'
			WHEN hier_level_fg = 'S'
				AND time_range_fg = 2
				THEN 'sig_week'
			WHEN hier_level_fg = 'S'
				AND time_range_fg = 3
				THEN 'sig_mth'
			WHEN hier_level_fg = 'I'
				AND time_range_fg = 1
				THEN 'wgi_day'
			WHEN hier_level_fg = 'I'
				AND time_range_fg = 2
				THEN 'wgi_week'
			WHEN hier_level_fg = 'I'
				AND time_range_fg = 3
				THEN 'wgi_mth'
			END AS VARCHAR(30)) AS target_type
	, CAST(CASE 
			WHEN hier_level_fg = 'S'
				AND time_range_fg = 1
				THEN 1
			WHEN hier_level_fg = 'S'
				AND time_range_fg = 2
				THEN 2
			WHEN hier_level_fg = 'S'
				AND time_range_fg = 3
				THEN 3
			WHEN hier_level_fg = 'I'
				AND time_range_fg = 1
				THEN 4
			WHEN hier_level_fg = 'I'
				AND time_range_fg = 2
				THEN 5
			WHEN hier_level_fg = 'I'
				AND time_range_fg = 3
				THEN 6
			END AS VARCHAR(30)) AS target_type_id
--select *	
FROM ------------BASIS---------------------	
	p_lew_mart_msi.v_mat0_bo_base_flop10_2 agg
INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS os ON os.client_id = agg.client_id
	AND os.loc_sid_store = agg.loc_sid_store
INNER JOIN (
	--- wir lassen im Gegensatz zu v_itm_item_2 im Mart den Rückgriff auf die WAWI-Kopie aus und habe damit einige Abweichungen.	
	--ABER: diese betreffen nur Case-Size(-1)Artikel_2 ohne Update auf WAWI-Seite - nach Update wird Klammer auf den richtigen Artikel_2 erzeugt -	
	--   und tote WAWI-Artikel_2 ohne historische Fortsetzung, damit sind diese uninteressant für den hier notwendigen Anwendungsfall.	
	SELECT i.client_id
		, i.item_sid
		, i.item_sid_config
		, descr.item_descr
		, i.src_matnr
		, TRY_CAST(Coalesce(i.src_orig_item_nr, i.config_item_cd, i.src_matnr) AS DECIMAL(18, 0)) AS orig_item_nr
		, COALESCE(i.src_dat_valid_from, MAX(i.src_dat_valid_from) OVER (
				PARTITION BY i.client_id
				, COALESCE(i.item_sid_config, i.item_sid)
				), MAX(i.src_dat_valid_from) OVER (
				PARTITION BY i.client_id
				, i.src_orig_item_nr
				)) max_dat_valid_from
		, itmfgh.sub_item_grp_sid
	FROM p_lew_core_ac.v_item_2 i
	INNER JOIN p_lew_core_ac.v_country_2 c ON c.country_sid = i.client_id
	INNER JOIN p_lew_core_ac.v_item_descr_2 descr ON descr.client_id = i.client_id
		AND descr.item_sid = i.item_sid
		AND descr.lang_sid = c.lang_sid
	INNER JOIN p_lew_core_ac.v_item_hist_2 ih ON i.client_id = ih.client_id
		AND i.item_sid = ih.item_sid
		AND CURRENT_DATE BETWEEN ih.dwh_valid_from
			AND ih.dwh_valid_to
	INNER JOIN p_lew_core_ac.v_item_familygroup_hist_2 AS itmfgh ON itmfgh.client_id = ih.client_id
		AND itmfgh.item_fam_grp_sid = ih.item_fam_grp_sid
		AND CURRENT_DATE BETWEEN itmfgh.dwh_valid_from
			AND itmfgh.dwh_valid_to
	) AS iia ON agg.client_id = iia.client_id
	AND agg.item_sid = iia.item_sid
INNER JOIN (
	--Dummy_2-WGIs werden allesamt auf CODE '0' geschlüsselt	
	SELECT sig.client_id
		, sig.sub_item_grp_sid
		, 'I' || CASE 
			WHEN TRY_CAST(sigh.item_grp_int_cd AS INTEGER) < 1
				THEN '0'
			ELSE TRIM(sigh.item_grp_int_cd)
			END itemhierarchy_cd
	FROM p_lew_core_ac.v_subitemgroup_2 sig
	INNER JOIN p_lew_core_ac.v_subitemgroup_hist_2 sigh ON sig.client_id = sigh.client_id
		AND sig.sub_item_grp_sid = sigh.sub_item_grp_sid
		AND CURRENT_DATE BETWEEN sigh.dwh_valid_from
			AND dwh_valid_to
	
	UNION ALL
	
	--Der WGI-Code '9' steht für Frischbrot etc. Nur dieser wird zusätzlich auf SIG aufgedröselt und in den SIG-Views bereitgestellt	
	SELECT sig.client_id
		, sig.sub_item_grp_sid
		, 'S' || TRIM(sig.src_subitemgrp_cd) itemhierarchy_cd
	FROM p_lew_core_ac.v_subitemgroup_2 sig
	INNER JOIN p_lew_core_ac.v_subitemgroup_hist_2 sigh ON sig.client_id = sigh.client_id
		AND sig.sub_item_grp_sid = sigh.sub_item_grp_sid
		AND CURRENT_DATE BETWEEN sigh.dwh_valid_from
			AND dwh_valid_to
		AND sigh.item_grp_int_cd IN ('9', '90')
	) AS sig ON iia.client_id = sig.client_id
	AND iia.sub_item_grp_sid = sig.sub_item_grp_sid
GROUP BY agg.client_id
	, agg.loc_sid_store
	, os.loc_sid_wh
	, os.src_wh_id
	, iia.orig_item_nr
	, iia.max_dat_valid_from
	, sig.itemhierarchy_cd
	, agg.curr_cd
	, agg.abstract_time_unit
	, agg.time_range_fg;