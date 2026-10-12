/*
===================================================================================================================================
Division		|	Lidl
Solution		|	Enterprise Logistics
DB schema		|	p_lew_mart_lead
DB view			|	v_edi_desadv_agg
Description		|	View with aggregated facts - MIS Lead / 02 Prozesse / 021103 Ware umschlagen / EDI/DESADV Kennzahlen
===================================================================================================================================
*/

/* 
The aggregation level for all data is client_id, loc_sid_wh, sup_sid and date of processing.
*/ 
CREATE OR REPLACE VIEW p_lew_mart_lead.v_edi_desadv_agg (
	CLIENT_ID COMMENT 'Client ID',
	CTRY_GRP_ID COMMENT 'Country group ID',
	ASPECT_ID COMMENT 'Aspect ID (1=Betriebsgesellschaft, 2=Vertriebsgesellschaft)',
	WH_ID COMMENT 'Warehouse ID',
	WH_LOC_SID COMMENT 'Location surrogate ID',
	SUP_SID COMMENT 'Supplier surrogate ID',
	DELIV_GR_RCPT_DT COMMENT 'Delivery date or goods receipt date or goods receipt document date',
	BYR COMMENT 'Business year',
	CY_MONTH COMMENT 'Month of calendar year',
	CY_WEEK COMMENT 'Week of calendar year',
	BYR_SEQ COMMENT 'Sequence for current business year',
	DESP_ADV_CNT COMMENT 'Number of despatch advices',
	USABLE_DESP_ADV_CNT COMMENT 'Number of usable despatch advices',
	WH_RCVG_ALL_CNT COMMENT 'Number of warehouse receivings',
	WH_RCVG_EDI_CNT_TMP COMMENT 'Number of warehouse receivings for EDI suppliers before EDI identification',
	WH_RCVG_EDI_CNT COMMENT 'Number of warehouse receivings for EDI suppliers',
	ITEM_RCVG_CNT COMMENT 'Number of item receiving countings',
	CONT_ACT_FG COMMENT 'Flag for valid supplier contact information',
	CONT_MED_CD COMMENT 'Code for supplier contact medium type',
	CONT_PURPOSE_SID COMMENT 'Surrogate ID for supplier contact purpose',
	CONT_LAST_CHGD_DT COMMENT 'Date of last contact change',
	CONT_DWH_VALID_FROM COMMENT 'Valid from date for supplier contact',
	CONT_DWH_VALID_TO COMMENT 'Valid to date for supplier contact'
	)
COMMENT = 'View with aggregated facts - MIS Lead / 02 Prozesse / 021103 Ware umschlagen / EDI/DESADV Kennzahlen'
AS
WITH 
/* 
Preselection of relevant time period for early limitation of fact data amount  
*/
limitation_period AS 
	(SELECT cal_dt
		, busyear
		--, cy
		, cy_month
		, cy_week
		, busyear_seq -- sequence for current business year 
		, cy_month_seq -- sequence for current month 
		, cy_week_seq -- sequence for current week 
		--, cy_day_seq 
		--, last_day_week_fg
		--, last_day_month_fg
		--, last_day_year_fg
	FROM p_lew_core_ac.v_cal_calendarday 
	WHERE busyear_seq BETWEEN -2 AND 0 -- last two and current business year but the oldest year will be filtered out later because of empty previous year values
		--AND cy_month_seq <= 0 -- whole current month that might include despatch advices with upcoming deliveries 
	),
/* 
Preselection of relevant time period for early limitation of fact data amount  
*/
limitation_countries AS 
	(SELECT client_id
		, country_iso_cd
		, country_desc
		, country_group_id -- 1 Not Used, 2 Michal Lagunionek, 3 Georg Kröll, 4 Matthias Oppitz, 5 Maksymilian Braniecki, 99 Other 
	FROM p_lew_mart_msi.v_ref_client_lead
	WHERE client_id NOT IN (9, 21, 33, 34) -- Estland, Nordirland, USA, Serbien  
	),
/* 
Preselection of relevant warehouses for early limitation of fact data amount with additional lookup of warehouse location sid 
*/
limitation_warehouses AS 
	(SELECT w.client_id 
		, w.country_iso_cd 
		--, w.country_desc 
		, w.wh_id 
		--, w.company 
		, w.wh_desc
		, w.aspect_id 
		, l.loc_sid -- FK, is unique  
		--, l.client_id
		--, l.country_pol_cd
		--, l.src_wh_id
		--, l.loc_name  
		, l.wh_store_mark
		--, l.wh_store_label
	FROM p_lew_mart_msi_ac.v_org_wh_merge w 
		LEFT OUTER JOIN p_lew_core_ac.v_location l -- PK loc_sid 
			ON w.client_id = l.client_id 
				AND w.wh_id = l.src_wh_id
				AND l.wh_store_mark = 'B' -- A=store, B=warehouse -- important for join to only select warehouses and leave out stores 
				AND l.src_wh_id >= 1-- important for join to only select real warehouses 
	WHERE w.aspect_id = 1 -- 1=Betriebsgesellschaft, 2=Vertriebsgesellschaft
		AND w.wh_id >= 1 -- only real warehouses 
		AND (w.client_id, w.wh_id) NOT IN ((1,9), (8,6), (10,7), (10,96), (18,20), (25,96)) -- AT Grossebersdorf, DK Koge, ES ALC Alcala, ES NFA Alcala, IT Somaglia, PT Santo Tirso
	),
/*
Normalized lookup used to filter on EDI relevant receivings 
Supplier contact information per country and warehouse whereby EDI contact type is selected first if available per supplier 
There can be multiple records for one supsid. Therefore qualify filter 
*/
supplier_contacts AS
	(SELECT s.client_id
		, s.loc_sid_wh
		, s.sup_sid
		--, s.sup_contact_id -- one supsid can have more than one supcontactid! 
		, s.contact_active_fg
		, s.contact_medium_cd -- data type is varchar 
		, s.sup_contact_purpose_sid
		, s.contact_last_changed_dt
		, s.dwh_valid_from -- one supsid can have more than one validfrom!
		, s.dwh_valid_to
		--, m.contact_medium_descr
		--, p.sup_contact_purpose_descr
	FROM p_lew_core_ac.v_supplier_contact_hist s -- contains contact informaton for suppliers (source WAWI table t246_contact_supplier)
		--JOIN p_lew_core_ac.v_ref_contact_medium m -- types of contact medium (source WAWI table t007_description)
			--ON s.contact_medium_cd = m.contact_medium_cd
		--JOIN p_lew_core_ac.v_ref_supplier_contact_purpose p -- source WAWI table t244_contact_type
			--ON s.sup_contact_purpose_sid = p.sup_contact_purpose_sid
	WHERE s.contact_active_fg = 1
		AND CURRENT_DATE BETWEEN s.dwh_valid_from AND s.dwh_valid_to 
		AND (s.contact_medium_cd = 4 -- 'EDI'
				AND s.sup_contact_purpose_sid = 2 -- 'EDI-Lieferavis'
			OR s.contact_medium_cd <> 4 -- Email, Fax, Telefon, Post
			)
	QUALIFY ROW_NUMBER() OVER (PARTITION BY s.client_id, s.loc_sid_wh, s.sup_sid ORDER BY IFF(s.contact_medium_cd = 4 AND s.sup_contact_purpose_sid = 2, 1, 2) ASC, s.contact_last_changed_dt DESC, s.sup_contact_id DESC) = 1 -- PK of suppliercontacthist (sup_contact_id, loc_sid_wh, dwh_valid_from)
	-- Qualify instead of Group by because there can be more than one row per supsid with different dwhvalidfrom or contactchangedate and mediumcd and purposesid is needed in later joins.
	-- Qualify sorting order selects primarily the EDI contact row (code 4 and sid 2), that means the supplier contact can be used to check if a supplier is EDI 
	),
/* 
Facts 1
Aggregated base data for despatch advices from suppliers for deliveries to warehouses (WAWI original table t0020_despatch_advice).
These are the delivery notifications that have arrived. (formerly for avis_cnt)
*/
despatch_advices AS
	(SELECT da.client_id
		, da.loc_sid_wh
		, da.sup_sid
		--, despatch_advice_id -- row number of the WAWI source table T0020_DESPATCH_ADVICE in the locasl WAWI system, pk together with client and warehouse
		, da.est_deliv_dt
		--, shipping_dt
		--, despatch_advice_dt
		, COUNT(DISTINCT da.despatch_advice_id) AS desp_adv_cnt
	FROM p_lew_core_ac.v_despatch_advice da -- PK (despatch_advice_id, loc_sid_wh)
		JOIN limitation_period p
			ON da.est_deliv_dt = p.cal_dt 
		JOIN limitation_countries c
			ON da.client_id = c.client_id
		JOIN limitation_warehouses w
			ON da.client_id = w.client_id
				AND da.loc_sid_wh = w.loc_sid
	GROUP BY da.client_id
		, da.loc_sid_wh
		, da.sup_sid
		, da.est_deliv_dt
	),
usable_despatch_advices AS 
(SELECT 
    a.client_id
   ,a.loc_sid_wh
   ,a.sup_sid
   ,a.est_deliv_dt
   ,COUNT(DISTINCT a.despatch_advice_id) AS usable_desp_adv_cnt
FROM P_LEW_CORE.T_DESPATCH_ADVICE a 
INNER JOIN P_LEW_CORE.T_DESPATCH_ADVICE_STATUS_HIST b 
ON a.client_id=b.client_id 
AND a.loc_sid_wh=b.wh_loc_sid 
AND a.despatch_advice_id=b.despatch_advice_id 
AND CURRENT_DATE() BETWEEN b.dwh_valid_from AND b.dwh_valid_to 
LEFT OUTER JOIN P_LEW_CORE.T_DESPATCH_ADVICE_DIFFERENCE c 
ON a.client_id = c.client_id 
AND a.loc_sid_wh = c.wh_loc_sid 
AND a.despatch_advice_id=c.despatch_advice_id
LEFT OUTER JOIN P_LEW_CORE.T_DESPATCH_ADVICE_DIFFERENCE_HIST g 
ON c.client_id=g.client_id 
AND c.wh_loc_sid =g.wh_loc_sid 
AND c.despatch_advice_diff_sid=g.despatch_advice_diff_sid 
AND CURRENT_DATE() BETWEEN g.dwh_valid_from AND g.dwh_valid_to
LEFT OUTER JOIN (
    SELECT *
    FROM (
    SELECT 
        e.* EXCLUDE(deleted_fg,dwh_created, dwh_load_id, dwh_updated, dwh_valid_from,   
        dwh_valid_to,despatch_advice_check_type_fg,despatch_advice_check_type_id)
        ,f.field_name 
    FROM P_LEW_CORE.T_DESPATCH_ADVICE_DIFFERENCE_CHECK_HIST e 
    LEFT OUTER JOIN (
    SELECT 
        REPLACE(SPLIT_PART(despatch_advice_check_type_descr,' ',1),'C0025_') AS field_name
        ,despatch_advice_check_type_id 
    FROM p_lew_core.t_ref_despatch_advice_check_type) f 
    ON e.despatch_advice_check_type_id = f.despatch_advice_check_type_id 
    WHERE CURRENT_DATE() BETWEEN dwh_valid_from AND dwh_valid_to)
   PIVOT( MAX(despatch_advice_check_type_value_id) FOR field_name IN ('MISMATCH_BBD', 'MISSING_BBD', 'UNKNOWN_GTIN', 'UNKNOWN_GLN', 'DIFF_QTY', 'MISSING_ITEM', 'DIFF_DEL_DATE', 'DIFF_CASE_SIZE', 'UNEXPECTED_DESADV', 'NOT_ORDERED_ITEM', 'UNKNOWN_CONSIGNOR'))) d 
   ON c.client_id = d.client_id 
   AND c.wh_loc_sid=d.wh_loc_sid 
   AND c.despatch_advice_diff_sid = d.despatch_advice_diff_sid
WHERE 1=1
AND ((b.despatch_advice_status_id = 2) 
OR (b.despatch_advice_status_id = 8 AND NOT(( g.despatch_advice_diff_status_id != 2) 
OR ( g.despatch_advice_diff_status_id = 2 AND IFNULL(g.diff_accepted_fg,0) = 0 AND IFNULL(g.remark_fg,0)=1 AND IFNULL(d."'DIFF_QTY'",'0')='0' AND IFNULL(d."'MISSING_ITEM'",'0')='0') 
OR ( g.despatch_advice_diff_status_id = 2 AND IFNULL(g.diff_accepted_fg,0) = 0 AND IFNULL(g.remark_fg,0)=0 AND IFNULL(d."'DIFF_QTY'",'0')!='2' AND IFNULL(d."'MISSING_ITEM'",'0')='0') 
OR ( g.despatch_advice_diff_status_id = 2 AND IFNULL(g.diff_accepted_fg,0) = 0 AND IFNULL(g.remark_fg,0)=0 AND IFNULL(d."'DIFF_QTY'",'0')='0' AND IFNULL(d."'MISSING_ITEM'",'0')!='2'))) 
OR (b.despatch_advice_status_id = 8 AND c.despatch_advice_id IS NULL) 
OR b.client_id IS NULL) 
GROUP BY 1,2,3,4),
/* 
Facts 2
Aggregated base data for booked item receipts at a warehouse (formerly for we_cnt_ges)
Info: A receipt has one dat_formdate but can be split into multiple positions with different deliveries that probably is dat_entry_rcv.
Info: In some cases one orig_receipt_id_rcv can contain multiple receipt_id_rcv, inversely there are relatively few cases. Thus receipt_id_rcv seems to be more granular.
*/
wh_receivings_all AS
	(SELECT ra.client_id
		, ra.wh_loc_sid
		, ra.sup_sid
		--, dat_formdate -- not null -- Datum des Belegs
		, ra.dat_entry_rcv	
		--, receipt_id_rcv -- not null and always integer
		--, orig_receipt_id_rcv -- not always integer, this can also contain characters 
		--, receipttype_id
		--, receipt_pos_nr_rcv -- receipt position in receipt_id_rcv that is receipt header 
		--, position_nr_rcv -- aligns with orig_receipt_id_rcv 
		, COUNT(DISTINCT ra.orig_receipt_id_rcv) AS wh_rcvg_all_cnt 
	FROM p_lew_core_ac.v_wawi_mov_item_wh_receiving ra
		JOIN limitation_period p
			ON ra.dat_entry_rcv = p.cal_dt 
		JOIN limitation_countries c
			ON ra.client_id = c.client_id 
		JOIN limitation_warehouses w
			ON ra.client_id = w.client_id
				AND ra.wh_loc_sid = w.loc_sid 
	WHERE ra.receipttype_id = 1
	GROUP BY ra.client_id
		, ra.wh_loc_sid
		, ra.sup_sid
		, ra.dat_entry_rcv
	),
/* 
Facts 3
Aggregated base data for item receipts at a warehouse 
These are booked receipts but the contact medium will be limited to EDI. (formerly for we_cnt_edi)
Info: A receipt has one dat_formdate but can be split into multiple positions with different deliveries that probably is dat_entry_rcv.
Info: In some cases one orig_receipt_id_rcv can contain multiple receipt_id_rcv, inversely there are relatively few cases. Thus receipt_id_rcv seems to be more granular.
*/
wh_receivings_edi AS
	(SELECT re.client_id
		, re.wh_loc_sid
		, re.sup_sid
		, re.dat_formdate -- not null -- Datum des Belegs
		--, dat_entry_rcv	
		--, receipt_id_rcv -- not null and always integer
		--, orig_receipt_id_rcv -- not always integer, this can also contain characters 
		--, receipttype_id
		--, receipt_pos_nr_rcv -- receipt position in receipt_id_rcv that is receipt header 
		--, position_nr_rcv -- aligns with orig_receipt_id_rcv 
		, COUNT(DISTINCT re.receipt_id_rcv) AS wh_rcvg_edi_cnt_tmp -- This is the delivery receipt like in item_receivings. It will be filtered for EDI later. 
	FROM p_lew_core_ac.v_wawi_mov_item_wh_receiving re
		JOIN limitation_period p
			ON re.dat_formdate = p.cal_dt 
		JOIN limitation_countries c
			ON re.client_id = c.client_id
		JOIN limitation_warehouses w
			ON re.client_id = w.client_id
				AND re.wh_loc_sid = w.loc_sid 
	WHERE re.receipttype_id = 1
		AND re.receipt_id_rcv < 5000000
	GROUP BY re.client_id
		, re.wh_loc_sid
		, re.sup_sid
		, re.dat_formdate
	),
/* 
Facts 4
Aggregated base data for item receiving countings with a referenced used despatch advice (formerly for avis_used)
These are pallet counts from the get in process for stock delivered from suppliers to warehouses (WAWI table t174_gincount).
Info: T174 - Die Tabelle enthaelt die einzelnen Positionen, die mit eGIN in der Gesellschaft erfasst wurden
Info: eGIN - Diese Tabelle enthaelt alle Artikel, die gezaehlt werden muessen, bzw. gezaehlt wurden. Es gibt keine Loeschungen (ausser aus der Maske Torvergabe).
*/
item_receivings AS 
	(SELECT ir.client_id
		, ir.loc_sid_wh
		, ir.sup_sid
		, da.est_deliv_dt
		--, rcv_receipt_id -- ID of the generated item receiving record (if an item receiving record has been created)
		--, item_cnt_id -- row number of the source table from WAWI (t174_gincount)
		--, item_sid
		--, despatch_advice_id 
		--, task_create_dt -- date when the counting task has been created
		, COUNT(DISTINCT ir.rcv_receipt_id) AS item_rcvg_cnt -- This is the delivery receipt like in wh_receivings
	FROM p_lew_core_ac.v_item_receiving_count ir
	LEFT OUTER JOIN p_lew_core.t_despatch_advice da
	ON ir.client_id = da.client_id
	AND ir.loc_sid_wh = da.loc_sid_wh
	AND ir.despatch_advice_id = da.despatch_advice_id
	JOIN limitation_period p
	ON ir.item_rcv_dt = p.cal_dt 
	JOIN limitation_countries c
	ON ir.client_id = c.client_id
	JOIN limitation_warehouses w
	ON ir.client_id = w.client_id
	AND ir.loc_sid_wh = w.loc_sid 
	WHERE ir.rcv_receipt_id < 5000000 
	AND ir.despatch_advice_id IS NOT NULL -- reference to a despatch advice, if a despatch advice technically has been used in the counting process
	GROUP BY ir.client_id
		, ir.loc_sid_wh
		, ir.sup_sid
		, da.est_deliv_dt
	QUALIFY ROW_NUMBER() OVER(PARTITION BY ir.client_id, ir.loc_sid_wh,ir.sup_sid,da.est_deliv_dt ORDER BY da.est_deliv_dt) = 1
	),
/*
 * join of despatch advices and usable despatch advices
 */
all_despatch_advices AS
	(SELECT 
		COALESCE (da.client_id,uda.client_id) AS client_id
		,COALESCE(da.loc_sid_wh,uda.loc_sid_wh) AS loc_sid_wh
		,COALESCE(da.sup_sid, uda.sup_sid) AS sup_sid
		,COALESCE(da.est_deliv_dt,uda.est_deliv_dt) AS est_deliv_dt
		,da.desp_adv_cnt
		,uda.usable_desp_adv_cnt
	FROM despatch_advices da
	FULL OUTER JOIN usable_despatch_advices uda
	ON da.client_id = uda.client_id
	AND da.loc_sid_wh = uda.loc_sid_wh
	AND da.sup_sid = uda.sup_sid
	AND da.est_deliv_dt = uda.est_deliv_dt),
/* 
First join of all despatch advices with wh receivings which is facts 1&2&3
*/
despatch_advices_wh_receivings AS 
	(SELECT COALESCE(da.client_id, wra.client_id, wre.client_id) AS client_id
		, COALESCE(da.loc_sid_wh, wra.wh_loc_sid, wre.wh_loc_sid) AS wh_loc_sid
		, COALESCE(da.sup_sid, wra.sup_sid, wre.sup_sid) AS sup_sid
		, COALESCE(da.est_deliv_dt, wra.dat_entry_rcv, wre.dat_formdate) AS deliv_gr_rcpt_dt -- delivery date or goods receipt date or goods receipt document date! 
		, da.desp_adv_cnt
		, da.usable_desp_adv_cnt
		, wra.wh_rcvg_all_cnt
		, wre.wh_rcvg_edi_cnt_tmp
	FROM all_despatch_advices da
		FULL OUTER JOIN wh_receivings_all wra
			ON da.client_id = wra.client_id
				AND da.loc_sid_wh = wra.wh_loc_sid
				AND da.sup_sid = wra.sup_sid
				AND da.est_deliv_dt = wra.dat_entry_rcv
		FULL OUTER JOIN wh_receivings_edi wre -- receiving edi is mostly a subset of receiving all but it can differ because of the different date fields, therefore full join is needed 
			ON wra.client_id = wre.client_id
				AND wra.wh_loc_sid = wre.wh_loc_sid
				AND wra.sup_sid = wre.sup_sid
				AND wra.dat_entry_rcv = wre.dat_formdate
	),
/* 
Second join with item receivings which is fact 4 and supplier contacts 
*/
despatch_advices_wh_receivings_item_receivings AS 
	(SELECT dawr.client_id
		, c.country_group_id 
		, w.aspect_id
		, w.wh_id
		, dawr.wh_loc_sid
		, dawr.sup_sid
		, dawr.deliv_gr_rcpt_dt -- delivery date or goods receipt date or goods receipt document date! 
		, p.busyear
		, p.cy_month
		, p.cy_week
		, p.busyear_seq 
		--, p.cy_month_seq 
		--, p.cy_week_seq 
		, dawr.desp_adv_cnt
		, dawr.usable_desp_adv_cnt
		, dawr.wh_rcvg_all_cnt
		, dawr.wh_rcvg_edi_cnt_tmp
		, IFF(s.contact_medium_cd = 4 
				AND s.sup_contact_purpose_sid = 2 
				AND dawr.deliv_gr_rcpt_dt >= s.contact_last_changed_dt,
			dawr.wh_rcvg_edi_cnt_tmp,
			NULL) AS wh_rcvg_edi_cnt -- This is the amount of receipts for EDI 
		, ir.item_rcvg_cnt
		, s.contact_active_fg 
		, s.contact_medium_cd 
		, s.sup_contact_purpose_sid 
		, s.contact_last_changed_dt 
		, s.dwh_valid_from  -- one supsid can have more than one validfrom
		, s.dwh_valid_to 
	--	, ROW_NUMBER() OVER (PARTITION BY dawr.client_id, wh_id, dawr.sup_sid, bus_yr, cal_wk ORDER BY deliv_gr_rcpt_dt DESC) AS grp_wk_end_fg -- to identify the last row with the latest date within every week of a group (client_id, wh_id, sup_sid, bus_yr) 
	--	, ROW_NUMBER() OVER (PARTITION BY dawr.client_id, wh_id, dawr.sup_sid, bus_yr, cal_mth ORDER BY deliv_gr_rcpt_dt DESC) AS grp_mth_end_fg -- to identify the last row with the latest date within every month of a group (client_id, wh_id, sup_sid, bus_yr) 
	--	, ROW_NUMBER() OVER (PARTITION BY dawr.client_id, wh_id, dawr.sup_sid, bus_yr ORDER BY deliv_gr_rcpt_dt DESC) AS grp_byr_end_fg -- to identify the last row with the latest date within every group (client_id, wh_id, sup_sid, bus_yr) 
	FROM despatch_advices_wh_receivings dawr
		LEFT OUTER JOIN item_receivings ir
			ON dawr.client_id = ir.client_id
				AND dawr.wh_loc_sid = ir.loc_sid_wh
				AND dawr.sup_sid = ir.sup_sid
				AND dawr.deliv_gr_rcpt_dt = ir.est_deliv_dt
		LEFT OUTER JOIN supplier_contacts s
			ON dawr.client_id = s.client_id
				AND dawr.wh_loc_sid = s.loc_sid_wh
				AND dawr.sup_sid = s.sup_sid
		LEFT OUTER JOIN limitation_countries c -- joining again at the end instead of previous fact selects because one final join is more performant to add columns 
			ON dawr.client_id = c.client_id
		LEFT OUTER JOIN limitation_warehouses w -- joining again at the end instead of previous fact selects because one final join is more performant to add columns  
			ON dawr.client_id = w.client_id
				AND dawr.wh_loc_sid = w.loc_sid 
		LEFT OUTER JOIN limitation_period p -- joining again at the end instead of previous fact selects because one final join is more performant to add columns  
			ON dawr.deliv_gr_rcpt_dt = p.cal_dt
	WHERE NOT (desp_adv_cnt IS NULL 
		AND wh_rcvg_all_cnt IS NULL 
		AND wh_rcvg_edi_cnt IS NULL -- Because the original facts for WH receivings EDI (wh_rcvg_edi_cnt_tmp) contains a condition, the leading fact is now wh_rcvg_edi_cnt. 
		AND item_rcvg_cnt IS NULL) -- Therefore, this filter ensures that facts with no count values for the whole data row are filtered out (those with wh_rcvg_edi_cnt_tmp containing values while others are null). 
	)
SELECT 
	client_id
	, country_group_id AS ctry_grp_id
	, aspect_id
	, wh_id
	, wh_loc_sid
	, sup_sid
	, deliv_gr_rcpt_dt
	, busyear AS byr
	, cy_month
	, cy_week
	, busyear_seq AS byr_seq
	--, cy_month_seq
	--, cy_week_seq
	, desp_adv_cnt
	, usable_desp_adv_cnt
	, wh_rcvg_all_cnt
	, wh_rcvg_edi_cnt_tmp
	, wh_rcvg_edi_cnt
	, item_rcvg_cnt
	, contact_active_fg AS cont_act_fg
	, contact_medium_cd AS cont_med_cd
	, sup_contact_purpose_sid AS cont_purpose_sid
	, contact_last_changed_dt AS cont_last_chgd_dt
	, dwh_valid_from AS cont_dwh_valid_from
	, dwh_valid_to AS cont_dwh_valid_to
FROM despatch_advices_wh_receivings_item_receivings;