CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_BO_BASE_FLOP10_1 (
	CLIENT_ID
	,LOC_SID_STORE
	,ITEM_SID
	,ABSTRACT_TIME_UNIT
	,TIME_RANGE_FG
	,CURR_CD
	,VAL_RTL_RL_SFO
	,VAL_RTL_RL_NET_SFO
	,VAL_RTL_NET_SFO_MHD_BREAK
	,VAL_RTL_NET_SFO_OTHER_STC_LOSS
	,VAL_RTL_NET_SFO_STR_DELIV_QLTY
	,VAL_WRTOFF_ZERO
	,VAL_WRTOFF_ZERO_NET
	,VAL_WRTOFF_ZERO_NET_MHD_BREAK
	,VAL_WRTOFF_ZERO_NET_OTHER_STC_LOSS
	,VAL_WRTOFF_ZERO_NET_DELIV_QLTY
	,QTY_TOTAL_SFO
	,QTY_TOTAL_SFO_MHD_BREAK
	,QTY_TOTAL_SFO_OTHER_STC_LOSS
	,QTY_TOTAL_SFO_STR_DELIV_QLTY
	,_VAL_DISCOUNT_EJR
	,_VAL_DISCOUNT_NET_EJR
	,_VAL_RTL_EJR_ADJ
	,_VAL_RTL_NET_EJR_ADJ
	,QTY_DISC_PIECE_WEIGTH_EJR_ASIS
	,QTY_DISC_PIECE_WEIGTH_SFO_ASIS
	) AS


/* Grundgesamtheit der zu berücksichtigenden Zeilen aus SFO-Aggregat und Umsätzen (EJR) für alle Länder und alle für FLOP10 relevanten Zeiträume
  Das Logikparadigma wurde aus dem WAWI-Paradigma abstrahiert und stimmt für alle WAWI-Länder mit der Altstreckeüberein
  - Tests hierzu vollumfänglich erfolgreich am 02.06.2018 durch Jens Thole
  Da die Daten aus dem BIL-Layer stammen, erfolgt hierbei auch die notwendige Korrektur in der Vergangenheit falsch zugeordneter
  ITEM_SIDs wegen des bekannten Fehlers des WAWI-Transportweges und dessen automatischer Anlage_1 von unbekannten Artikeln mit CS=-1.
  Es wird der Klammer-Artikel_1 der Keyintegration verwendet um somit immer den aktuellsten Stand evtl vorgenommener ITEM_SID-Korrekturen zu liefern

  Die View ist die unterste Basis zur Ziel-View v_mat_bo_base_flop10_1 und deren Materialisierung
  v_mat0_bo_base_flop10_1 ---> v_mat1_bo_base_flop10_1 ---> v_mat_bo_base_flop10_1 ---> t_bo_base_flop10_1

  2022-10-14   Michael Morris    INC4885339, User Story: 343128 - Added pcwo_reason_id 152 for force majeure.
  2025-03-24   Dominik Pfarr	 INC9229115: Adjust calculation of qty_disc_piece_weigth_sfo_asis to match with LEAD logic
*/
SELECT mT.client_id
	,mT.loc_sid_store
	,imapk.item_sid_map AS item_sid
	,mT.abstract_time_unit
	,mT.time_range_fg
	,mT.curr_cd
	,mT.val_rtl_rl_sfo
	,mT.val_rtl_rl_net_sfo
	,mT.val_rtl_net_sfo_mhd_break
	,mT.val_rtl_net_sfo_other_stc_loss
	,mT.val_rtl_net_sfo_str_deliv_qlty
	,mT.val_wrtoff_zero
	,mT.val_wrtoff_zero_net
	,mT.val_wrtoff_zero_net_mhd_break
	,mT.val_wrtoff_zero_net_other_stc_loss
	,mT.val_wrtoff_zero_net_deliv_qlty
	,mT.qty_total_sfo
	,mT.qty_total_sfo_mhd_break
	,mT.qty_total_sfo_other_stc_loss
	,mT.qty_total_sfo_str_deliv_qlty
	,mT._val_discount_ejr
	,mT._val_discount_net_ejr
	,mT._val_rtl_ejr_adj
	,mT._val_rtl_net_ejr_adj
	,mT.qty_disc_piece_weigth_ejr_asis
	,mT.qty_disc_piece_weigth_sfo_asis
FROM (
	SELECT a11.client_id
		,a11.loc_sid_store
		,a11.item_sid
		,a17.abstract_time_unit
		,a17.time_range_fg
		,curr_cd
		,SUM(a11.sfo_total_rtl_rl_val_asis) AS val_rtl_rl_sfo
		,SUM(CAST(a11.sfo_total_rtl_rl_net_val_asis AS DECIMAL(18, 5))) AS val_rtl_rl_net_sfo
		,SUM(CAST(CASE 
					WHEN a11.pcwo_reason_id IN (
							1, 127, 134, 135 --mhd
							, 2, 128 --break
							) --in total store writeoffs
						THEN a11.sfo_total_rtl_rl_net_val_asis
					ELSE CAST(0 AS DECIMAL(18, 5))
					END AS DECIMAL(18, 5))) AS val_rtl_net_sfo_mhd_break --writeoffs for mhd and break of stores
		,SUM(CAST(CASE 
					WHEN a11.pcwo_reason_id IN (
							3, 136, 137, 152 --force majeure
							, 4, 101, 102, 110, 111, 129 --Warenentnahme Filiale
							, 7, 130, 131 --Spenden Filiale
							) --in total ""other stock losses""
						THEN a11.sfo_total_rtl_rl_net_val_asis
					ELSE CAST(0 AS DECIMAL(18, 5))
					END AS DECIMAL(18, 5))) AS val_rtl_net_sfo_other_stc_loss --writeoffs for other stock losses of stores
		,SUM(CAST(CASE 
					WHEN a11.pcwo_reason_id IN (8) --store delivery quality
						THEN a11.sfo_total_rtl_rl_net_val_asis
					ELSE CAST(0 AS DECIMAL(18, 5))
					END AS DECIMAL(18, 5))) AS val_rtl_net_sfo_str_deliv_qlty --store delivery quality
		,SUM(a11.sfo_wrtoff_zero_rtl_rl_val_asis) AS val_wrtoff_zero
		,SUM(CAST(a11.sfo_wrtoff_zero_rtl_rl_net_val_asis AS DECIMAL(18, 5))) AS val_wrtoff_zero_net
		,SUM(CAST(CASE 
					WHEN a11.pcwo_reason_id IN (
							1, 127, 134, 135 --mhd
							, 2, 128 --break
							) --in total store writeoffs
						THEN a11.sfo_wrtoff_zero_rtl_rl_net_val_asis
					ELSE CAST(0 AS DECIMAL(18, 5))
					END AS DECIMAL(18, 5))) AS val_wrtoff_zero_net_mhd_break --writeoffs for mhd and break of stores
		,SUM(CAST(CASE 
					WHEN a11.pcwo_reason_id IN (
							3, 136, 137, 152 --force majeure
							, 4, 101, 102, 110, 111, 129 --Warenentnahme Filiale
							, 7, 130, 131 --Spenden Filiale
							) --in total ""other stock losses""
						THEN a11.sfo_wrtoff_zero_rtl_rl_net_val_asis
					ELSE CAST(0 AS DECIMAL(18, 5))
					END AS DECIMAL(18, 5))) AS val_wrtoff_zero_net_other_stc_loss --writeoffs for other stock losses of stores
		,SUM(CAST(CASE 
					WHEN a11.pcwo_reason_id IN (8) --store delivery quality
						THEN a11.sfo_wrtoff_zero_rtl_rl_net_val_asis
					ELSE CAST(0 AS DECIMAL(18, 5))
					END AS DECIMAL(18, 5))) AS val_wrtoff_zero_net_deliv_qlty --store delivery quality
		,SUM(a11.sfo_total_qty_asis) AS qty_total_sfo
		,SUM(CASE 
				WHEN a11.pcwo_reason_id IN (
						1, 127, 134, 135 --mhd
						, 2, 128 --break
						) --in total store writeoffs
					THEN a11.sfo_total_qty_asis
				ELSE CAST(0 AS DECIMAL(18, 5))
				END) AS qty_total_sfo_mhd_break --writeoffs for mhd and break of stores
		,SUM(CASE 
				WHEN a11.pcwo_reason_id IN (
						3, 136, 137, 152 --force majeure
						, 4, 101, 102, 110, 111, 129 --Warenentnahme Filiale
						, 7, 130, 131 --Spenden Filiale
						) --in total ""other stock losses""
					THEN a11.sfo_total_qty_asis
				ELSE CAST(0 AS DECIMAL(18, 5))
				END) AS qty_total_sfo_other_stc_loss --writeoffs for other stock losses of stores
		,SUM(CASE 
				WHEN a11.pcwo_reason_id IN (8) --store delivery quality
					THEN a11.sfo_total_qty_asis
				ELSE CAST(0 AS DECIMAL(18, 5))
				END) AS qty_total_sfo_str_deliv_qlty --store delivery quality
		,SUM(CASE 
				WHEN a11.pcwo_reason_id IN (5) --discount
					THEN a11.sfo_total_rtl_rl_val_asis
				ELSE CAST(0 AS DECIMAL(18, 5))
				END) AS _val_discount_ejr
		,SUM(CASE 
				WHEN a11.pcwo_reason_id IN (5) --discount
					THEN a11.sfo_total_rtl_rl_net_val_asis
				ELSE CAST(0 AS DECIMAL(18, 5))
				END) AS _val_discount_net_ejr
		,CAST(NULL AS DECIMAL(38, 10)) AS _val_rtl_ejr_adj
		,CAST(NULL AS DECIMAL(38, 10)) AS _val_rtl_net_ejr_adj
		,CAST(NULL AS DECIMAL(18, 5)) AS qty_disc_piece_weigth_ejr_asis
		,SUM(CASE 
				WHEN a11.sfotype_id IN (137, 147)
					AND a11.pcwo_reason_id IN (5) --discount
					THEN a11.sfo_total_qty_asis
				ELSE CAST(0 AS DECIMAL(18, 5))
				END) AS qty_disc_piece_weigth_sfo_asis
	FROM p_lew_bil_ac.v_agg_store_day_item_sfo_asis_1 AS a11
	INNER JOIN p_lew_process_ac.v_bo_flop10_client_status_1 AS todo
		ON todo.client_id = a11.client_id
	INNER JOIN (
		SELECT cal_dt
			,cal_dt_int AS abstract_time_unit
			,cy_week
			,cy_month
			,cy_week_seq
			,cy_month_seq
			,1 AS time_range_fg
		FROM p_lew_mart_msi.v_bo_flop10_cal_list_day_1
		WHERE day_range_fg = 1
		
		UNION ALL
		
		SELECT cal_dt
			,cy_week AS abstract_time_unit
			,cy_week
			,cy_month
			,cy_week_seq
			,cy_month_seq
			,2 AS time_range_fg
		FROM p_lew_mart_msi.v_bo_flop10_cal_list_day_1
		WHERE week_range_fg = 1
		
		UNION ALL
		
		SELECT cal_dt
			,cy_month AS abstract_time_unit
			,cy_week
			,cy_month
			,cy_week_seq
			,cy_month_seq
			,3 AS time_range_fg
		FROM p_lew_mart_msi.v_bo_flop10_cal_list_day_1
		WHERE month_range_fg = 1
		) AS a17
		ON a11.booking_dat = a17.cal_dt
	WHERE a11.sfotype_id IN (137, 147)
	GROUP BY 1
		,2
		,3
		,4
		,5
		,6
	
	UNION ALL
	
	SELECT mT.client_id
		,mT.st_loc_sid
		,mT.item_sid
		,mT.abstract_time_unit
		,mT.time_range_fg
		,c.curr_cd
		,CAST(NULL AS DECIMAL(18, 5)) AS val_rtl_rl_sfo
		,CAST(NULL AS DECIMAL(18, 5)) AS val_rtl_rl_net_sfo
		,CAST(NULL AS DECIMAL(18, 5)) AS val_rtl_net_sfo_mhd_break
		,CAST(NULL AS DECIMAL(18, 5)) AS val_rtl_net_sfo_other_stc_loss
		,CAST(NULL AS DECIMAL(18, 5)) AS val_rtl_net_sfo_str_deliv_qlty
		,CAST(NULL AS DECIMAL(38, 5)) AS val_wrtoff_zero
		,CAST(NULL AS DECIMAL(38, 5)) AS val_wrtoff_zero_net
		,CAST(NULL AS DECIMAL(18, 5)) AS val_wrtoff_zero_net_mhd_break
		,CAST(NULL AS DECIMAL(18, 5)) AS val_wrtoff_zero_net_other_stc_loss
		,CAST(NULL AS DECIMAL(18, 5)) AS val_wrtoff_zero_net_deliv_qlty
		,CAST(NULL AS DECIMAL(18, 5)) AS qty_total_sfo
		,CAST(NULL AS DECIMAL(18, 5)) AS qty_total_sfo_mhd_break
		,CAST(NULL AS DECIMAL(18, 5)) AS qty_total_sfo_other_stc_loss
		,CAST(NULL AS DECIMAL(18, 5)) AS qty_total_sfo_str_deliv_qlty
		,CAST(NULL AS DECIMAL(38, 5)) AS _val_discount_ejr
		,CAST(NULL AS DECIMAL(38, 5)) AS _val_discount_net_ejr
		,mT._val_rtl_ejr_adj
		,mT._val_rtl_net_ejr_adj
		,mT.qty_disc_piece_weigth_ejr_asis
		,CAST(NULL AS DECIMAL(18, 5)) AS qty_disc_piece_weigth_sfo_asis
	FROM (
		SELECT a11.client_id
			,a11.loc_sid_store AS st_loc_sid
			,a11.item_sid
			,a17.cal_dt_int AS abstract_time_unit
			,1 AS time_range_fg
			,SUM(ZEROIFNULL(a11.return_gross_val) + ZEROIFNULL(a11.sales_gross_val)) AS _val_rtl_ejr_adj
			,SUM(ZEROIFNULL(a11.return_net_val) + ZEROIFNULL(a11.sales_net_val)) AS _val_rtl_net_ejr_adj
			,- SUM(ZEROIFNULL(CASE 
						WHEN a11.discount_sid > - 1
							AND a11.discount_weight_qty <> 0
							THEN a11.sales_piece_qty
						ELSE 0
						END)) - SUM(ZEROIFNULL(CASE 
						WHEN a11.discount_sid > - 1
							AND a11.discount_weight_qty <> 0
							THEN a11.sales_weight_qty
						ELSE 0
						END)) AS qty_disc_piece_weigth_ejr_asis
		FROM p_lew_bil_ac.v_agg_pos_store_item_day_1 AS a11
		INNER JOIN p_lew_process_ac.v_bo_flop10_client_status_1 AS todo
			ON todo.client_id = a11.client_id
		INNER JOIN p_lew_mart_msi.v_bo_flop10_cal_list_day_1 AS a17
			ON a11.dwh_cal_dt = a17.cal_dt
				AND a17.day_range_fg = 1
		GROUP BY 1
			,2
			,3
			,4
		
		UNION ALL
		
		SELECT a11.client_id
			,a11.loc_sid_store AS st_loc_sid
			,a11.item_sid
			,a17.cy_week AS abstract_time_unit
			,2 AS time_range_fg
			,SUM(ZEROIFNULL(a11.return_gross_val) + ZEROIFNULL(a11.sales_gross_val)) AS _val_rtl_ejr_adj
			,SUM(ZEROIFNULL(a11.return_net_val) + ZEROIFNULL(a11.sales_net_val)) AS _val_rtl_net_ejr_adj
			,- SUM(ZEROIFNULL(CASE 
						WHEN a11.discount_sid > - 1
							AND a11.discount_weight_qty <> 0
							THEN a11.sales_piece_qty
						ELSE 0
						END)) - SUM(ZEROIFNULL(CASE 
						WHEN a11.discount_sid > - 1
							AND a11.discount_weight_qty <> 0
							THEN a11.sales_weight_qty
						ELSE 0
						END)) AS qty_disc_piece_weigth_ejr_asis
		FROM p_lew_bil_ac.v_agg_pos_store_item_day_1 AS a11
		INNER JOIN p_lew_process_ac.v_bo_flop10_client_status_1 AS todo
			ON todo.client_id = a11.client_id
		INNER JOIN p_lew_mart_msi.v_bo_flop10_cal_list_day_1 AS a17
			ON a11.dwh_cal_dt = a17.cal_dt
				AND a17.week_range_fg = 1
		GROUP BY 1
			,2
			,3
			,4
		
		UNION ALL
		
		SELECT a11.client_id
			,a11.loc_sid_store AS st_loc_sid
			,a11.item_sid
			,a17.cy_month AS abstract_time_unit
			,3 AS time_range_fg
			,SUM(ZEROIFNULL(a11.return_gross_val) + ZEROIFNULL(a11.sales_gross_val)) AS _val_rtl_ejr_adj
			,SUM(ZEROIFNULL(a11.return_net_val) + ZEROIFNULL(a11.sales_net_val)) AS _val_rtl_net_ejr_adj
			,- SUM(ZEROIFNULL(CASE 
						WHEN a11.discount_sid > - 1
							AND a11.discount_weight_qty <> 0
							THEN a11.sales_piece_qty
						ELSE 0
						END)) - SUM(ZEROIFNULL(CASE 
						WHEN a11.discount_sid > - 1
							AND a11.discount_weight_qty <> 0
							THEN a11.sales_weight_qty
						ELSE 0
						END)) AS qty_disc_piece_weigth_ejr_asis
		FROM p_lew_bil_ac.v_agg_pos_store_item_day_1 AS a11
		INNER JOIN p_lew_process_ac.v_bo_flop10_client_status_1 AS todo
			ON todo.client_id = a11.client_id
		INNER JOIN p_lew_mart_msi.v_bo_flop10_cal_list_day_1 AS a17
			ON a11.dwh_cal_dt = a17.cal_dt
				AND a17.month_range_fg = 1
		GROUP BY 1
			,2
			,3
			,4
		) AS mT
	INNER JOIN p_lew_core_ac.v_client_1 AS c
		ON c.client_id = mT.client_id
	) AS mT
INNER JOIN p_lew_core_ac.v_item_map_key_1 AS imapk
	ON imapk.client_id = mT.client_id
		AND imapk.item_sid = mT.item_sid;