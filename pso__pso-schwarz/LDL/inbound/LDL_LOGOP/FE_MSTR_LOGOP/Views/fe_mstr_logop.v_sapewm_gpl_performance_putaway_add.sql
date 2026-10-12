/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_gpl_performance_putaway_add
Description		|	SAP EWM Gruppenleiter Dahsboard Putaway - view with additional columns
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_gpl_performance_putaway_add(
	client_id COMMENT 'Client id (PK)',
	lidl_ctry COMMENT 'Country code (PK)',
	wh_id COMMENT 'Warehouse ID',
	wh_task_nr COMMENT 'Warehouse Task (PK)',
	wh_task_item COMMENT 'Warehouse Task Item (PK)',
	wh_task_stat COMMENT 'Warehouse Task Status - Technical name: TOSTAT - Component Type: /SCWM/DE_TOSTAT',
	wh_proc_type COMMENT 'Warehouse Process Type - Technical name: PROCTY - Component Type: /SCWM/DE_PROCTY',
	wh_proc_cat COMMENT 'Warehouse Process Category - Technical name: TRART - Component Type: /SCWM/LVS_TRART',
	doc_nr COMMENT 'Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT',
	doc_cat COMMENT 'Document Category for Document-Related Stocks - Technical name: QDOCCAT - Component Type: /SCWM/DE_UI_QDOCCAT',
	prod_nr COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR',
	prod_desc COMMENT 'Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX',
	conf_dt COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE',
	conf_tm COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME',
	curr_tm COMMENT 'Matches the current hour',
	conf_ts COMMENT 'Confirmation timestamp',
	conf_hr COMMENT 'Confirmation hour',
	hu_fg COMMENT 'Handling Unit Warehouse Task - Technical name: FLGHUTO - Component Type: /SCWM/FLGHUTO',
	src_strg_bin COMMENT 'Source Storage Bin - Technical name: VLPLA - Component Type: /SCWM/LTAP_VLPLA',
	src_hu COMMENT 'Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	hu_type COMMENT 'Type of HU',
	hu_size COMMENT 'EP value of HU',
	rsrc_type COMMENT 'Type of resource',
	QUEUE COMMENT 'Queue',
	src_strg_type COMMENT 'Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP',
	src_rsrc COMMENT 'Source Resource (Means of Transport or User) - Technical name: SRSRC - Component Type: /SCWM/DE_SRSRC',
	dest_strg_bin COMMENT 'Destination Storage Bin - Technical name: NLPLA - Component Type: /SCWM/LTAP_NLPLA',
	dest_hu COMMENT 'Destination Handling Unit - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR',
	OWNER COMMENT 'Owner - Technical name: OWNER - Component Type: /SCWM/DE_OWNER',
	dest_strg_type COMMENT 'Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP',
	dest_rsrc COMMENT 'Destination Resource (Means of Transport or User) - Technical name: DRSRC - Component Type: /SCWM/DE_DRSRC',
	gr_dt COMMENT 'Goods Receipt Date - Technical name: GRDATE - Component Type: /SCWM/DE_GR_DATE',
	gr_proc_tm COMMENT 'Goods Receipt Processing Time - Technical name: GRTIME - Component Type: /SCWM/DE_GR_TIME',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at',
	receipt_fg COMMENT 'Receipt flag for counted pallets',
	putaway_fg COMMENT 'Putaway flag for picked up palltes',
	tm_on_lane_sec COMMENT 'Time of pallets on lane between receipt and putaway in seconds for average and median time',
	cum_pallets_counted COMMENT 'Amount of pallets in receipts cumulated per group of client, warehouse, day, hour and destination storage type',
	cum_pallets_pickedup COMMENT 'Amount of pallets in putaways cumulated per group of client, warehouse, day, hour and destination storage type',
	cum_pallets_on_lane COMMENT 'Amount of pallets on lane cumulated per group of client, warehouse, day, hour and destination storage type',
	open_ptwy COMMENT 'Open_ptwy KPI (placeholder)',
	open_ptwy_per_hour COMMENT 'Open_ptwy KPI per Hour (placeholder)',
	nums COMMENT 'Amount of hours since the start of the day (placeholder)',
	time_on_lane_m_h COMMENT 'Average time of lane per minute (based on this day, placeholder)'
) COMMENT='SAP EWM Performance Putaway view (based on v_sapewm_whtask)'
 AS
WITH
-- Received deliveries
whtrec AS (
	SELECT
		client_id
		,lidl_country AS lidl_ctry
        ,wh_id
		,tanum AS wh_task_nr
		,tapos AS wh_task_item
		,tostat AS wh_task_stat 
		,procty AS wh_proc_type
		,trart AS wh_proc_cat
		,docno AS doc_nr
		,qdoccat AS doc_cat
		,matnr AS prod_nr
		,maktx AS prod_desc
		,confirmed_date AS conf_dt
		,confirmed_time AS conf_tm
		,TIMESTAMPFROMPARTS(conf_dt, conf_tm) AS conf_ts
		,DATE_TRUNC(HOUR, conf_tm) AS conf_hr
		,flghuto AS hu_fg
		,vlpla AS src_strg_bin
		,vlenr AS src_hu
        ,zz_settype AS hu_type
        ,DECODE(LEFT(zz_settype, 2), 
        	'EP', TO_NUMBER(1,10,5), 
        	'DD', TO_NUMBER(0.5,10,5), 
        	'QP', TO_NUMBER(0.25,10,5), 
        	'IP', TO_NUMBER(1,10,5), 
        	'AE', TO_NUMBER(1,10,5), 
        	'SG', TO_NUMBER (1,10,5),
        	'HG', TO_NUMBER (0.5, 10,5),
        	'QG', TO_NUMBER (0.25, 10,5)
        	,TO_NUMBER(0,10,5)) AS hu_size
        ,drsrc AS dest_rsrc
        ,srsrc AS src_rsrc
        ,COALESCE(dest_rsrc, src_rsrc) AS rsrc -- destination resource is the resource at start of task, source resource is the resource at end of task
        ,DECODE(LEFT(rsrc, 1), '1', 'FAMO', '2', 'FORK', '3', 'FAMO', '', 'No Resource', 'Unknown') AS rsrc_type
        ,QUEUE
		,vltyp AS src_strg_type
		,nlpla AS dest_strg_bin
		,nlenr AS dest_hu
    	,IFF(client_id = 10 AND wh_id = 7, OWNER, 'Not Applicable') AS OWNER --? owner vs. owner_id (old)
		,nltyp AS dest_strg_type
		,grdate AS gr_dt
		,grtime AS gr_proc_tm
		,dwh_created
		,dwh_updated
	FROM "DATA".t_sapewm_warehousetask 
	WHERE wh_proc_cat = 5 -- Goods Receipt Posting
		AND wh_task_stat = 'C' -- null = Open, 'A' = Canceled , 'B' = Waiting , 'C' = Confirmed
		AND doc_nr IS NOT NULL
		AND dest_hu IS NOT NULL
        AND conf_dt >= DATEADD(MONTH, -1, GETDATE())
),
-- Reversed deliveries
whtrev AS (
	SELECT
		client_id
		,lidl_country AS lidl_ctry
		,wh_id
		,tostat AS wh_task_stat
		,trart AS wh_proc_cat
		,qdoccat AS doc_cat
		,docno AS doc_nr
		,confirmed_date AS conf_dt
		,vlenr AS src_hu
        ,zz_settype AS hu_type
        ,DECODE(LEFT(hu_type, 2), 
        	'EP', TO_NUMBER(1,10,5), 
        	'DD', TO_NUMBER(0.5,10,5), 
        	'QP', TO_NUMBER(0.25,10,5), 
        	'IP', TO_NUMBER(1,10,5), 
        	'AE', TO_NUMBER(1,10,5), 
        	'SG', TO_NUMBER (1,10,5),
        	'HG', TO_NUMBER (0.5, 10,5),
        	'QG', TO_NUMBER (0.25, 10,5)
        ,TO_NUMBER(0,10,5)) AS hu_size
        ,drsrc AS dest_rsrc
        ,srsrc AS src_rsrc
        ,COALESCE(dest_rsrc, src_rsrc) AS rsrc -- destination resource is the resource at start of task, source resource is the resource at end of task
        ,DECODE(LEFT(rsrc, 1), '1', 'FAMO', '2', 'FORK', '3', 'FAMO', '', 'No Resource', 'Unknown') AS rsrc_type
        ,QUEUE
		,confirmed_time AS conf_tm
	FROM "DATA".t_sapewm_warehousetask 
	WHERE wh_proc_cat = 6 -- Goods Issue Posting
		AND wh_task_stat = 'C' -- confirmed
		AND doc_cat = 'PDI'
		AND doc_nr IS NOT NULL
		AND src_hu IS NOT NULL
        AND conf_dt >= DATEADD(MONTH, -1, GETDATE())
),
-- receipts with latest timestamp per day and handling unit
receipts AS (
	SELECT
		r.client_id
		,r.lidl_ctry
		,r.wh_id
		,r.wh_task_nr
		,r.wh_task_item
		,r.wh_task_stat
		,r.wh_proc_type
		,r.wh_proc_cat
		,r.doc_nr
		,r.doc_cat
		,r.prod_nr
		,r.prod_desc
		,r.conf_dt
		,r.conf_tm
		,r.conf_ts
		,r.conf_hr
		,r.hu_fg
		,r.src_strg_bin
		,r.src_hu
        ,r.hu_type
        ,r.hu_size
        ,r.rsrc
        ,r.rsrc_type
        ,r.QUEUE
		,r.src_strg_type
		,r.src_rsrc
		,r.dest_strg_bin
		,r.dest_hu
		,r.OWNER
		,r.dest_strg_type
		,r.dest_rsrc
		,r.gr_dt
		,r.gr_proc_tm
		,r.dwh_created
		,r.dwh_updated
	FROM whtrec r
	    LEFT JOIN whtrev rev
			ON r.client_id = rev.client_id
				AND r.wh_id = rev.wh_id
				AND r.dest_hu = rev.src_hu
				AND r.conf_dt <= rev.conf_dt
				AND r.conf_tm <= rev.conf_tm
	WHERE rev.conf_dt IS NULL -- not reversed
	AND r.dest_strg_type <> '9996'
	QUALIFY ROW_NUMBER() OVER (PARTITION BY r.client_id, r.wh_id, r.conf_dt, r.dest_hu ORDER BY r.conf_tm DESC) = 1 -- most recent record per handling unit
),
-- putaways with the earliest timestamp per day and handling unit
putaways AS (
	SELECT
		client_id
		,lidl_country AS lidl_ctry
		,wh_id
		,tanum AS wh_task_nr
		,tapos AS wh_task_item
		,tostat AS wh_task_stat
		,procty AS wh_proc_type
		,trart AS wh_proc_cat
		,docno AS doc_nr
		,qdoccat AS doc_cat
		,matnr AS prod_nr
		,maktx AS prod_desc
		,confirmed_date AS conf_dt
		,confirmed_time AS conf_tm
		,TIMESTAMPFROMPARTS(conf_dt, conf_tm) AS conf_ts
		,DATE_TRUNC(HOUR, conf_tm) AS conf_hr
		,flghuto AS hu_fg
		,vlpla AS src_strg_bin
		,vlenr AS src_hu
        ,zz_settype AS hu_type
        ,DECODE(LEFT(hu_type, 2), 
        	'EP', TO_NUMBER(1,10,5), 
        	'DD', TO_NUMBER(0.5,10,5), 
        	'QP', TO_NUMBER(0.25,10,5), 
        	'IP', TO_NUMBER(1,10,5), 
        	'AE', TO_NUMBER(1,10,5), 
        	'SG', TO_NUMBER (1,10,5),
        	'HG', TO_NUMBER (0.5, 10,5),
        	'QG', TO_NUMBER (0.25, 10,5)
        ,TO_NUMBER(0,10,5)) AS hu_size
        ,drsrc AS dest_rsrc
        ,srsrc AS src_rsrc
        ,COALESCE(dest_rsrc, src_rsrc) AS rsrc -- destination resource is the resource at start of task, source resource is the resource at end of task
        ,DECODE(LEFT(rsrc, 1), '1', 'FAMO', '2', 'FORK', '3', 'FAMO', '', 'No Resource', 'Unknown') AS rsrc_type
        ,QUEUE
		,vltyp AS src_strg_type
		,nlpla AS dest_strg_bin
		,nlenr AS dest_hu
		,IFF(client_id = 10 AND wh_id = 7, OWNER, 'Not Applicable') AS OWNER
		,nltyp AS dest_strg_type
		,grdate AS gr_dt
		,grtime AS gr_proc_tm
		,dwh_created
		,dwh_updated
	FROM "DATA".t_sapewm_warehousetask 
	WHERE wh_task_stat = 'C' -- C = confirmed
		AND ((wh_proc_cat = 1) OR (wh_proc_cat = 3 AND wh_proc_type IN ('3050', '9999'))) -- WH process category 1 = putaway 
		AND NVL(doc_cat, '') <> 'PDO'
		AND LEFT(src_strg_type, 1) IN ('9', 'D', 'W')
		AND LEFT(NVL(dest_strg_type, ''), 1) <> 'W'
		AND dest_hu IS NOT NULL
        AND conf_dt >= DATEADD(MONTH, -1, GETDATE())
	QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id, wh_id, conf_dt, src_hu ORDER BY conf_tm DESC) = 1 --oldest putaway task that occurs immediately after the goods receiving
),
cons AS(
-- consolidation of receipts and putaways
SELECT
	r.client_id
	,r.lidl_ctry
	,r.wh_id
	,r.wh_task_nr
	,r.wh_task_item
	,r.wh_task_stat
	,r.wh_proc_type
	,r.wh_proc_cat
	,r.doc_nr
	,r.doc_cat
	,r.prod_nr
	,r.prod_desc
	,r.conf_dt
	,r.conf_tm
	,r.conf_ts
	,r.conf_hr
	,r.hu_fg
	,r.src_strg_bin
	,r.src_hu
    ,r.hu_type
    ,r.hu_size
    ,r.rsrc
    ,r.rsrc_type
    ,r.QUEUE
	,r.src_strg_type
	,r.src_rsrc
	,r.dest_strg_bin
	,r.dest_hu
	,r.OWNER
	,r.dest_strg_type
	,r.dest_rsrc
	,r.gr_dt
	,r.gr_proc_tm
	,r.dwh_created
	,r.dwh_updated
	,1 AS receipt_fg
	,0 AS putaway_fg
FROM receipts r
UNION ALL -- consolidation of data for aggregation on hour LEVEL in FE
SELECT
	p.client_id
	,p.lidl_ctry
	,p.wh_id
	,p.wh_task_nr
	,p.wh_task_item
	,p.wh_task_stat
	,p.wh_proc_type
	,p.wh_proc_cat
	,p.doc_nr
	,p.doc_cat
	,p.prod_nr
	,p.prod_desc
	,p.conf_dt
	,p.conf_tm
	,p.conf_ts
	,p.conf_hr
	,p.hu_fg
	,p.src_strg_bin
	,p.src_hu
    ,p.hu_type
    ,p.hu_size
    ,p.rsrc
    ,p.rsrc_type
    ,p.QUEUE
	,p.src_strg_type
	,p.src_rsrc
	,p.dest_strg_bin
	,p.dest_hu
	,p.OWNER
	,p.dest_strg_type -- Original destination storage type from received pallets
	,p.dest_rsrc
	,p.gr_dt
	,p.gr_proc_tm
	,p.dwh_created
	,p.dwh_updated
	,0 AS receipt_fg
	,1 AS putaway_fg
FROM receipts r
	 JOIN putaways p 
		ON r.client_id = p.client_id
			AND r.wh_id = p.wh_id
			AND r.dest_hu = p.src_hu
			-- the product match is to avoid a mismatch because there can be same hus but with different products at an earlier point of time (pallet numbers / labels are printed and used twice)  
			-- nvl is to avoid a missing match because some prod nrs from receipts can be empty which have a prod nr DSP* in the putaway  
			AND NVL(r.prod_nr, p.prod_nr) = NVL(p.prod_nr, r.prod_nr)
			AND r.gr_dt = p.gr_dt
			AND r.conf_ts <= p.conf_ts -- putaways can and must happen anytime after the receipt 
			--AND r.conf_dt = p.conf_dt
			--AND r.conf_tm <= p.conf_tm --conf_ts not needed because conf_dt already is equal
QUALIFY ROW_NUMBER() OVER (PARTITION BY p.client_id, p.wh_id, p.src_hu, p.prod_nr, p.gr_dt ORDER BY p.conf_dt, p.conf_tm) = 1
),
cte_prop AS (
SELECT 
	client_id
	,lidl_ctry
	,wh_id
	,wh_task_nr
	,wh_task_item
	,wh_task_stat
	,wh_proc_type
	,wh_proc_cat
	,doc_nr
	,doc_cat
	,prod_nr
	,prod_desc
	,conf_dt
	,conf_tm
	,conf_ts
	,conf_hr
	,hu_fg
	,src_strg_bin
	,src_hu
    ,hu_type
    ,hu_size
    ,rsrc_type
    ,QUEUE
	,src_strg_type
	,src_rsrc
	,dest_strg_bin
	,dest_hu
	,OWNER
	,dest_strg_type
	,dest_rsrc
	,gr_dt
	,gr_proc_tm
	,dwh_created
	,dwh_updated
	,receipt_fg
	,putaway_fg
	,IFF (putaway_fg = 1
		,TIMEDIFF (SECOND
			,FIRST_VALUE(conf_tm) OVER (PARTITION BY client_id, wh_id, conf_dt, dest_hu ORDER BY conf_tm)
			,LAST_VALUE(conf_tm) OVER (PARTITION BY client_id, wh_id, conf_dt, dest_hu ORDER BY conf_tm)
			)
		,NULL) AS tm_on_lane_sec -- duration of pallets on lane in seconds
	,IFF (RANK() OVER (PARTITION BY client_id, wh_id, conf_dt, conf_hr, dest_strg_type ORDER BY conf_tm DESC, gr_proc_tm DESC, wh_task_nr) = 1
		,SUM(receipt_fg) OVER (PARTITION BY client_id, wh_id, conf_dt, dest_strg_type ORDER BY conf_tm ASC ROWS UNBOUNDED PRECEDING) 
		,NULL
		) AS cum_pallets_counted -- amount of pallets cumulated per client, warehouse, day, hour and destination storage type for receipts
	,IFF (RANK() OVER (PARTITION BY client_id, wh_id, conf_dt, conf_hr, dest_strg_type ORDER BY conf_tm DESC, gr_proc_tm DESC, wh_task_nr) = 1
		,SUM(putaway_fg) OVER (PARTITION BY client_id, wh_id, conf_dt, dest_strg_type ORDER BY conf_tm, gr_proc_tm ROWS UNBOUNDED PRECEDING) 
		,NULL
		) AS cum_pallets_pickedup -- amount of pallets cumulated per client, warehouse, day, hour and destination storage type for putaways
	,cum_pallets_counted - cum_pallets_pickedup AS cum_pallets_on_lane
    ,SUM(receipt_FG) OVER(PARTITION BY client_id, wh_id ORDER BY conf_hr) - SUM(putaway_FG) OVER(PARTITION BY client_id, wh_id ORDER BY conf_hr) AS Open_ptwy
	,HOUR(GETDATE()) AS nums
FROM cons)
SELECT
    client_id
	,lidl_ctry
	,wh_id
	,wh_task_nr
	,wh_task_item
	,wh_task_stat
	,wh_proc_type
	,wh_proc_cat
	,doc_nr
	,doc_cat
	,prod_nr
	,prod_desc
	,conf_dt
	,conf_tm
	,IFF(SUBSTRING(CONF_TM,2,1) = SUBSTRING(HOUR(GETDATE()),1,1),0,1) curr_tm
	,conf_ts
	,conf_hr
	,hu_fg
	,src_strg_bin
	,src_hu
    ,hu_type
    ,hu_size
    ,rsrc_type
    ,CASE 
        WHEN QUEUE IN ('INB_AMB','INB_BULK','INB_NF','INB1_AMB','INB1_CHAMB','INB1_PROMO','INB2_AMB','INB2_CHAMB','INB2_NF','INB2_PROMO','INB3_AMB') THEN 'Ambient'
        WHEN QUEUE IN ('INB_CHL','INB_CHLBK','INB_MILK','INB1_CHL','INB2_CHL') THEN 'Chiller'
        WHEN QUEUE IN ('INB_F+V','INB1_F+V','INB1_PRD','INB3_F+V') THEN 'Fruit and Veg'
        WHEN QUEUE IN ('INB_FRZ','INB_FRZBK','INB1_FRZ','INB2_FRZ') THEN 'Freezer'
        WHEN QUEUE IN ('INB_MPF','INB1_MPF','INB3_MPF') THEN 'Meat,Poultry & Fish'
    END AS QUEUE
	,src_strg_type
	,src_rsrc
	,dest_strg_bin
	,dest_hu
	,OWNER
	,dest_strg_type -- Area for Gruppenleiter KPI calc
	,dest_rsrc
	,gr_dt
	,gr_proc_tm
	,dwh_created
	,dwh_updated
	,receipt_fg
	,putaway_fg
    ,tm_on_lane_sec
    ,cum_pallets_counted
    ,cum_pallets_pickedup
    ,cum_pallets_on_lane
    ,open_ptwy
    ,open_ptwy / nums AS open_ptwy_per_hour
    ,nums
    ,((SUM(TM_ON_LANE_SEC) OVER())/60)/nums Time_on_lane_m_h -- opt
FROM cte_prop;