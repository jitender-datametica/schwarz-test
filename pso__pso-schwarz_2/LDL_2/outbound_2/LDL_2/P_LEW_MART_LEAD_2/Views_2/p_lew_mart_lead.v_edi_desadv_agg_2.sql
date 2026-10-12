/*
===================================================================================================================================
Division		|	Lidl
Solution		|	Enterprise Logistics
DB schema		|	p_lew_mart_lead
DB view			|	v_edi_desadv_agg_2
Description		|	View with aggregated facts - MIS Lead / 02 Prozesse / 021103 Ware umschlagen / EDI/DESADV Kennzahlen
===================================================================================================================================
*/

/* 
The aggregation level for all data is client_id, loc_sid_wh, sup_sid and date of processing.
*/



-- , despatch_advice_id
 -- , task_create_dt -- date when the counting task has been created

-- , item_cnt_id -- row number of the source table from WAWI (t174_gincount_2)
 -- , item_sid

-- , rcv_receipt_id -- ID of the generated item_2 receiving record (if an item_2 receiving record has been created)

CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_edi_desadv_agg_2 (client_id OPTIONS(description='Client ID'), ctry_grp_id
OPTIONS(description='Country_2 group ID'), aspect_id
OPTIONS(description='Aspect ID (1=Betriebsgesellschaft, 2=Vertriebsgesellschaft)'), wh_id
OPTIONS(description='Warehouse ID'), wh_loc_sid OPTIONS(description='Location_2 surrogate ID'), sup_sid
OPTIONS(description='Supplier_2 surrogate ID'), deliv_gr_rcpt_dt
OPTIONS(description='Delivery date or goods receipt date or goods receipt document date'), byr
OPTIONS(description='Business year'), cy_month OPTIONS(description='Month of calendar_2 year'), cy_week
OPTIONS(description='Week of calendar_2 year'), byr_seq OPTIONS(description='Sequence for current business year'),
desp_adv_cnt OPTIONS(description='Number of despatch advices'), usable_desp_adv_cnt
OPTIONS(description='Number of usable despatch advices'), wh_rcvg_all_cnt
OPTIONS(description='Number of warehouse receivings'), wh_rcvg_edi_cnt_tmp
OPTIONS(description='Number of warehouse receivings for EDI suppliers before EDI identification'), wh_rcvg_edi_cnt
OPTIONS(description='Number of warehouse receivings for EDI suppliers'), item_rcvg_cnt
OPTIONS(description='Number of item_2 receiving countings'), cont_act_fg
OPTIONS(description='Flag for valid supplier_2 contact_2 information'), cont_med_cd
OPTIONS(description='Code for supplier_2 contact_2 medium type'), cont_purpose_sid
OPTIONS(description='Surrogate ID for supplier_2 contact_2 purpose'), cont_last_chgd_dt
OPTIONS(description='Date of last contact_2 change'), cont_dwh_valid_from
OPTIONS(description='Valid from date for supplier_2 contact_2'), cont_dwh_valid_to
OPTIONS(description='Valid to date for supplier_2 contact_2'))
OPTIONS(DESCRIPTION = 'VIEW WITH AGGREGATED FACTS - MIS LEAD / 02 PROZESSE / 021103 WARE UMSCHLAGEN / EDI/DESADV KENNZAHLEN')
AS WITH LIMITATION_PERIOD AS (SELECT cal_dt,
   busyear -- , cy
,
   cy_month,
   cy_week,
   busyear_seq -- sequence for current business year
,
   cy_month_seq -- sequence for current month
,
   cy_week_seq -- sequence for current week
 -- , cy_day_seq
 -- , last_day_week_fg
 -- , last_day_month_fg

   -- , last_day_year_fg

  FROM ldl_p_lew_core_ac.v_cal_calendarday_2
  WHERE busyear_seq BETWEEN - 2 AND 0
    -- last two and current business year but the oldest year will be filtered out later because of empty previous year values

    -- AND cy_month_seq <= 0 -- whole current month that might include despatch advices with upcoming deliveries
),
 LIMITATION_COUNTRIES AS (SELECT client_id,
   country_iso_cd,
   country_desc,
   country_group_id
   -- 1 Not Used, 2 Michal Lagunionek, 3 Georg Kröll, 4 Matthias Oppitz, 5 Maksymilian Braniecki, 99 Other

  FROM ldl_p_lew_mart_msi.v_ref_client_lead_2
  WHERE client_id NOT IN (9, 21, 33, 34) -- Estland, Nordirland, USA, Serbien
), LIMITATION_WAREHOUSES AS (SELECT W.client_id
   ,
   W.country_iso_cd -- , w.country_desc
,
   W.wh_id -- , w.company
,
   W.wh_desc,
   W.aspect_id,
   L.loc_sid -- FK, is unique
 -- , l.client_id
 -- , l.country_pol_cd
 -- , l.src_wh_id
 -- , l.loc_name
,
   L.wh_store_mark -- , l.wh_store_label

  FROM ldl_p_lew_mart_msi_ac.v_org_wh_merge_2 AS W
   LEFT JOIN ldl_p_lew_core_ac.v_location_2 AS L ON W.client_id = L.client_id AND W.wh_id = L.src_wh_id AND L.wh_store_mark
       = 'B' -- A=store, B=warehouse -- important for CROSS JOIN to only select warehouses and leave out stores
 AND L.src_wh_id
      >= 1 -- important for CROSS JOIN to only select real warehouses

  WHERE W.aspect_id = 1 -- 1=Betriebsgesellschaft, 2=Vertriebsgesellschaft

   AND W.wh_id >= 1 -- only real warehouses

   AND (W.client_id, W.wh_id) NOT IN ((1, 9), (8, 6), (10, 7), (10, 96), (18, 20), (25, 96))), DESPATCH_ADVICES AS (SELECT
   DA.client_id,
   DA.loc_sid_wh,
   DA.sup_sid
   -- , despatch_advice_id -- row number of the WAWI source table T0020_DESPATCH_ADVICE_2 in the locasl WAWI system, pk together with client and warehouse

   ,
   DA.est_deliv_dt -- , shipping_dt
 -- , despatch_advice_dt
,
   COUNT(DISTINCT DA.despatch_advice_id) AS desp_adv_cnt
  FROM ldl_p_lew_core_ac.v_despatch_advice_2 AS DA
   INNER JOIN LIMITATION_PERIOD AS p ON DA.est_deliv_dt = p.cal_dt
   INNER JOIN LIMITATION_COUNTRIES AS c ON DA.client_id = c.client_id
   INNER JOIN LIMITATION_WAREHOUSES AS w ON DA.client_id = w.client_id AND DA.loc_sid_wh = w.loc_sid
  GROUP BY DA.client_id,
   DA.loc_sid_wh,
   DA.sup_sid,
   DA.est_deliv_dt), USABLE_DESPATCH_ADVICES AS (SELECT A.client_id,
   A.loc_sid_wh,
   A.sup_sid,
   A.est_deliv_dt,
   COUNT(DISTINCT A.despatch_advice_id) AS usable_desp_adv_cnt
  FROM ldl_p_lew_core.t_despatch_advice_2 AS A
   INNER JOIN ldl_p_lew_core.t_despatch_advice_status_hist_2 AS B ON A.client_id = B.client_id AND A.loc_sid_wh = B.wh_loc_sid
        AND A.despatch_advice_id = B.despatch_advice_id AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
   LEFT JOIN ldl_p_lew_core.t_despatch_advice_difference_2 AS C ON A.client_id = C.client_id AND A.loc_sid_wh = C.wh_loc_sid
       AND A.despatch_advice_id = C.despatch_advice_id
   LEFT JOIN ldl_p_lew_core.t_despatch_advice_difference_hist_2 AS G ON C.client_id = G.client_id AND C.wh_loc_sid = G.wh_loc_sid
        AND C.despatch_advice_diff_sid = G.despatch_advice_diff_sid AND CURRENT_DATE BETWEEN G.dwh_valid_from AND G.dwh_valid_to
     
   LEFT JOIN (SELECT client_id,
     wh_loc_sid,
     despatch_advice_diff_sid,
     MISMATCH_BBD,
     MISSING_BBD,
     UNKNOWN_GTIN,
     UNKNOWN_GLN,
     DIFF_QTY,
     MISSING_ITEM,
     DIFF_DEL_DATE,
     DIFF_CASE_SIZE,
     UNEXPECTED_DESADV,
     NOT_ORDERED_ITEM,
     UNKNOWN_CONSIGNOR
    FROM (SELECT E.client_id,
       E.wh_loc_sid,
       E.despatch_advice_diff_sid,
       E.despatch_advice_check_type_value_id,
       f.field_name
      FROM ldl_p_lew_core.t_despatch_advice_difference_check_hist_2 AS E
       LEFT JOIN (SELECT REPLACE(CASE
           WHEN despatch_advice_check_type_descr IS NOT NULL
           THEN IFNULL(SPLIT(despatch_advice_check_type_descr, ' ')[SAFE_OFFSET(0)], '')
           ELSE NULL
           END, 'C0025_', '') AS field_name,
         despatch_advice_check_type_id
        FROM ldl_p_lew_core.t_ref_despatch_advice_check_type_2) AS f ON E.despatch_advice_check_type_id = f.despatch_advice_check_type_id
        
      WHERE CURRENT_DATE BETWEEN E.dwh_valid_from AND E.dwh_valid_to) PIVOT (MAX(despatch_advice_check_type_value_id)
      FOR FIELD_NAME IN ('MISMATCH_BBD', 'MISSING_BBD', 'UNKNOWN_GTIN', 'UNKNOWN_GLN', 'DIFF_QTY', 'MISSING_ITEM',
       'DIFF_DEL_DATE', 'DIFF_CASE_SIZE', 'UNEXPECTED_DESADV', 'NOT_ORDERED_ITEM', 'UNKNOWN_CONSIGNOR'))) AS d ON C.client_id
       = d.client_id AND C.wh_loc_sid = d.wh_loc_sid AND C.despatch_advice_diff_sid = d.despatch_advice_diff_sid
  WHERE B.despatch_advice_status_id = 2
   OR B.despatch_advice_status_id = 8 AND G.despatch_advice_diff_status_id = 2 AND (G.despatch_advice_diff_status_id <>
            2 OR IFNULL(G.diff_accepted_fg, 0) <> 0 OR IFNULL(G.remark_fg, 0) <> 1 OR IFNULL(d.diff_qty, 0) <> 0 OR
         IFNULL(d.missing_item, 0) <> 0) AND (G.despatch_advice_diff_status_id <> 2 OR IFNULL(G.diff_accepted_fg, 0
            ) <> 0 OR IFNULL(G.remark_fg, 0) <> 0 OR IFNULL(d.diff_qty, 0) = 2 OR IFNULL(d.missing_item, 0) <> 0
        ) AND (G.despatch_advice_diff_status_id <> 2 OR IFNULL(G.diff_accepted_fg, 0) <> 0 OR IFNULL(G.remark_fg, 0) <>
         0 OR IFNULL(d.diff_qty, 0) <> 0 OR IFNULL(d.missing_item, 0) = 2)
   OR B.despatch_advice_status_id = 8 AND C.despatch_advice_id IS NULL
   OR B.client_id IS NULL
  GROUP BY A.client_id,
   A.loc_sid_wh,
   A.sup_sid,
   A.est_deliv_dt), ALL_DESPATCH_ADVICES AS (SELECT COALESCE(da.client_id, uda.client_id) AS client_id,
   COALESCE(da.loc_sid_wh, uda.loc_sid_wh) AS loc_sid_wh,
   COALESCE(da.sup_sid, uda.sup_sid) AS sup_sid,
   COALESCE(da.est_deliv_dt, uda.est_deliv_dt) AS est_deliv_dt,
   da.desp_adv_cnt,
   uda.usable_desp_adv_cnt
  FROM DESPATCH_ADVICES AS da
   FULL JOIN USABLE_DESPATCH_ADVICES AS uda ON da.client_id = uda.client_id AND da.loc_sid_wh = uda.loc_sid_wh AND da.sup_sid
       = uda.sup_sid AND da.est_deliv_dt = uda.est_deliv_dt), WH_RECEIVINGS_ALL AS (SELECT RA.client_id,
   RA.wh_loc_sid,
   RA.sup_sid -- , dat_formdate -- not null -- Datum des Belegs
,
   RA.dat_entry_rcv -- , receipt_id_rcv -- not null and always integer

   -- , orig_receipt_id_rcv -- not always integer, this can also contain characters
 -- , receipttype_id

   -- , receipt_pos_nr_rcv -- receipt position in receipt_id_rcv that is receipt header

   -- , position_nr_rcv -- aligns with orig_receipt_id_rcv
,
   COUNT(DISTINCT RA.orig_receipt_id_rcv) AS wh_rcvg_all_cnt
  FROM ldl_p_lew_core_ac.v_wawi_mov_item_wh_receiving_2 AS RA_2
   INNER JOIN LIMITATION_PERIOD AS p ON RA.dat_entry_rcv = p.cal_dt
   INNER JOIN LIMITATION_COUNTRIES AS c ON RA.client_id = c.client_id
   INNER JOIN LIMITATION_WAREHOUSES AS w ON RA.client_id = w.client_id AND RA.wh_loc_sid = w.loc_sid
  WHERE RA.receipttype_id = 1
  GROUP BY RA.client_id,
   RA.wh_loc_sid,
   RA.dat_entry_rcv,
   RA.sup_sid), WH_RECEIVINGS_EDI AS (SELECT RE.client_id,
   RE.wh_loc_sid,
   RE.sup_sid,
   RE.dat_formdate -- not null -- Datum des Belegs
 -- , dat_entry_rcv

   -- , receipt_id_rcv -- not null and always integer

   -- , orig_receipt_id_rcv -- not always integer, this can also contain characters
 -- , receipttype_id

   -- , receipt_pos_nr_rcv -- receipt position in receipt_id_rcv that is receipt header

   -- , position_nr_rcv -- aligns with orig_receipt_id_rcv
,
   COUNT(DISTINCT RE.receipt_id_rcv) AS wh_rcvg_edi_cnt_tmp
  FROM ldl_p_lew_core_ac.v_wawi_mov_item_wh_receiving_2 AS RE_2
   INNER JOIN LIMITATION_PERIOD AS p ON RE.dat_formdate = p.cal_dt
   INNER JOIN LIMITATION_COUNTRIES AS c ON RE.client_id = c.client_id
   INNER JOIN LIMITATION_WAREHOUSES AS w ON RE.client_id = w.client_id AND RE.wh_loc_sid = w.loc_sid
  WHERE RE.receipttype_id = 1
   AND RE.receipt_id_rcv < 5000000
  GROUP BY RE.client_id,
   RE.wh_loc_sid,
   RE.dat_formdate,
   RE.sup_sid), DESPATCH_ADVICES_WH_RECEIVINGS AS (SELECT COALESCE(da.client_id, wra.client_id, wre.client_id) AS
   client_id,
   COALESCE(da.loc_sid_wh, wra.wh_loc_sid, wre.wh_loc_sid) AS wh_loc_sid,
   COALESCE(da.sup_sid, wra.sup_sid, wre.sup_sid) AS sup_sid,
   COALESCE(da.est_deliv_dt, wra.dat_entry_rcv, wre.dat_formdate) AS deliv_gr_rcpt_dt,
   da.desp_adv_cnt,
   da.usable_desp_adv_cnt,
   wra.wh_rcvg_all_cnt,
   wre.wh_rcvg_edi_cnt_tmp
  FROM ALL_DESPATCH_ADVICES AS da
   FULL JOIN WH_RECEIVINGS_ALL AS wra ON da.client_id = wra.client_id AND da.loc_sid_wh = wra.wh_loc_sid AND da.sup_sid
      = wra.sup_sid AND da.est_deliv_dt = wra.dat_entry_rcv
   FULL JOIN WH_RECEIVINGS_EDI AS wre ON wra.client_id = wre.client_id AND wra.wh_loc_sid = wre.wh_loc_sid AND wra.sup_sid
       = wre.sup_sid AND wra.dat_entry_rcv = wre.dat_formdate
     -- receiving edi is mostly a subset of receiving all but it can differ because of the different date fields, therefore full join is needed

     ), ITEM_RECEIVINGS AS (SELECT IR.client_id,
   IR.loc_sid_wh,
   IR.sup_sid,
   DA0.est_deliv_dt,
   COUNT(DISTINCT IR.rcv_receipt_id) AS item_rcvg_cnt
  FROM ldl_p_lew_core_ac.v_item_receiving_count_2 AS IR
   LEFT JOIN ldl_p_lew_core.t_despatch_advice_2 AS DA0 ON IR.client_id = DA0.client_id AND IR.loc_sid_wh = DA0.loc_sid_wh
    AND IR.despatch_advice_id = DA0.despatch_advice_id
   INNER JOIN LIMITATION_PERIOD AS p ON IR.item_rcv_dt = p.cal_dt
   INNER JOIN LIMITATION_COUNTRIES AS c ON IR.client_id = c.client_id
   INNER JOIN LIMITATION_WAREHOUSES AS w ON IR.client_id = w.client_id AND IR.loc_sid_wh = w.loc_sid
  WHERE IR.rcv_receipt_id < 5000000
   AND IR.despatch_advice_id IS NOT NULL
  GROUP BY IR.client_id,
   IR.loc_sid_wh,
   IR.sup_sid,
   DA0.est_deliv_dt
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(IR.client_id AS STRING), CAST(IR.loc_sid_wh AS STRING), CAST(IR.sup_sid AS STRING)
        , DA0.est_deliv_dt ORDER BY DA0.est_deliv_dt IS NULL, DA0.est_deliv_dt)) = 1), SUPPLIER_CONTACTS AS (SELECT
   client_id,
   loc_sid_wh,
   sup_sid -- , s.sup_contact_id -- one supsid can have more than one supcontactid!
,
   contact_active_fg,
   contact_medium_cd -- data type is STRING
,
   sup_contact_purpose_sid,
   contact_last_changed_dt,
   dwh_valid_from -- one supsid can have more than one validfrom!
,
   dwh_valid_to -- , m.contact_medium_descr
 -- , p.sup_contact_purpose_descr

  FROM ldl_p_lew_core_ac.v_supplier_contact_hist_2 AS S
  WHERE contact_active_fg = 1
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND (CAST(contact_medium_cd AS FLOAT64) = 4 -- 'EDI'
 AND sup_contact_purpose_sid = 2 -- 'EDI-Lieferavis'
 OR CAST(contact_medium_cd AS FLOAT64)
      <> 4 -- Email, Fax, Telefon, Post
)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_wh AS STRING), CAST(sup_sid AS STRING)
        ORDER BY IF(SAFE_CAST(contact_medium_cd as FLOAT64) = 4 AND sup_contact_purpose_sid = 2, 1, 2) IS NULL, IF(SAFE_CAST(contact_medium_cd
            as FLOAT64) = 4 AND sup_contact_purpose_sid = 2, 1, 2), contact_last_changed_dt IS NULL DESC,
        contact_last_changed_dt DESC, sup_contact_id IS NULL DESC, sup_contact_id DESC)) = 1
    -- PK of suppliercontacthist (sup_contact_id, loc_sid_wh, dwh_valid_from)

    -- Qualify instead of Group by because there can be more than one row per supsid with different dwhvalidfrom or contactchangedate and mediumcd and purposesid is needed in later joins.

    -- Qualify sorting order selects primarily the EDI contact_2 row (code 4 and sid 2), that means the supplier_2 contact_2 can be used to check if a supplier_2 is EDI

    ), DESPATCH_ADVICES_WH_RECEIVINGS_ITEM_RECEIVINGS AS (SELECT dawr.client_id,
   c.country_group_id,
   w.aspect_id,
   w.wh_id,
   dawr.wh_loc_sid,
   dawr.sup_sid,
   dawr.deliv_gr_rcpt_dt -- delivery date or goods receipt date or goods receipt document date!
,
   p.busyear,
   p.cy_month,
   p.cy_week,
   p.busyear_seq -- , p.cy_month_seq
 -- , p.cy_week_seq
,
   dawr.desp_adv_cnt,
   dawr.usable_desp_adv_cnt,
   dawr.wh_rcvg_all_cnt,
   dawr.wh_rcvg_edi_cnt_tmp,
   IF(SAFE_CAST(s.contact_medium_cd as FLOAT64) = 4 AND s.sup_contact_purpose_sid = 2 AND dawr.deliv_gr_rcpt_dt >= s.contact_last_changed_dt
      , dawr.wh_rcvg_edi_cnt_tmp, NULL) AS wh_rcvg_edi_cnt,
   t47.item_rcvg_cnt,
   s.contact_active_fg,
   s.contact_medium_cd,
   s.sup_contact_purpose_sid,
   s.contact_last_changed_dt,
   s.dwh_valid_from -- one supsid can have more than one validfrom
,
   s.dwh_valid_to
   -- , ROW_NUMBER() OVER (PARTITION BY dawr.client_id, wh_id, dawr.sup_sid, bus_yr, cal_wk ORDER BY deliv_gr_rcpt_dt DESC) AS grp_wk_end_fg -- to identify the last row with the latest date within every week of a group (client_id, wh_id, sup_sid, bus_yr)

   -- , ROW_NUMBER() OVER (PARTITION BY dawr.client_id, wh_id, dawr.sup_sid, bus_yr, cal_mth ORDER BY deliv_gr_rcpt_dt DESC) AS grp_mth_end_fg -- to identify the last row with the latest date within every month of a group (client_id, wh_id, sup_sid, bus_yr)

   -- , ROW_NUMBER() OVER (PARTITION BY dawr.client_id, wh_id, dawr.sup_sid, bus_yr ORDER BY deliv_gr_rcpt_dt DESC) AS grp_byr_end_fg -- to identify the last row with the latest date within every group (client_id, wh_id, sup_sid, bus_yr)

   
  FROM DESPATCH_ADVICES_WH_RECEIVINGS AS dawr
   LEFT JOIN ITEM_RECEIVINGS AS t47 ON dawr.client_id = t47.client_id AND dawr.wh_loc_sid = t47.loc_sid_wh AND dawr.sup_sid
       = t47.sup_sid AND dawr.deliv_gr_rcpt_dt = t47.est_deliv_dt
   LEFT JOIN SUPPLIER_CONTACTS AS s ON dawr.client_id = s.client_id AND dawr.wh_loc_sid = s.loc_sid_wh AND dawr.sup_sid
     = s.sup_sid
   LEFT JOIN LIMITATION_COUNTRIES AS c ON dawr.client_id = c.client_id
    -- joining again at the end instead of previous fact selects because one final CROSS JOIN is more performant to add columns

    
   LEFT JOIN LIMITATION_WAREHOUSES AS w ON dawr.client_id = w.client_id AND dawr.wh_loc_sid = w.loc_sid
     -- joining again at the end instead of previous fact selects because one final CROSS JOIN is more performant to add columns

     
   LEFT JOIN LIMITATION_PERIOD AS p ON dawr.deliv_gr_rcpt_dt = p.cal_dt
    -- joining again at the end instead of previous fact selects because one final CROSS JOIN is more performant to add columns

    
  WHERE dawr.desp_adv_cnt IS NOT NULL
   OR dawr.wh_rcvg_all_cnt IS NOT NULL
   OR IF(SAFE_CAST(s.contact_medium_cd as FLOAT64) = 4 AND s.sup_contact_purpose_sid = 2 AND dawr.deliv_gr_rcpt_dt >= s
      .contact_last_changed_dt, dawr.wh_rcvg_edi_cnt_tmp, NULL) IS NOT NULL
   OR t47.item_rcvg_cnt IS NOT NULL) (/* Preselection of relevant time period for early limitation of fact data amount */
  /* Preselection of relevant time period for early limitation of fact data amount */
  /* Preselection of relevant warehouses for early limitation of fact data amount with additional lookup of warehouse location_2 sid */
  -- PK loc_sid
 -- AT Grossebersdorf, DK Koge, ES ALC Alcala, ES NFA Alcala, IT Somaglia, PT Santo Tirso

  /* Normalized lookup used to filter on EDI relevant receivings 
Supplier_2 contact_2 information per country_2 and warehouse whereby EDI contact_2 type is selected first if available per supplier_2 
There can be multiple records for one supsid. Therefore qualify filter */
  -- contains contact_2 informaton for suppliers (source WAWI table t246_contact_supplier_2)

  -- CROSS JOIN LDL.p_lew_core_ac.v_ref_contact_medium_2 m -- types of contact_2 medium (source WAWI table t007_description)

  -- ON s.contact_medium_cd = m.contact_medium_cd

  -- CROSS JOIN LDL.p_lew_core_ac.v_ref_supplier_contact_purpose_2 p -- source WAWI table t244_contact_type_2

  -- ON s.sup_contact_purpose_sid = p.sup_contact_purpose_sid

  /* Facts 1
Aggregated base data for despatch advices from suppliers for deliveries to warehouses (WAWI original table t0020_despatch_advice_2).
These are the delivery notifications that have arrived. (formerly for avis_cnt) */
  -- PK (despatch_advice_id, loc_sid_wh)

  /* Facts 2
Aggregated base data for booked item_2 receipts at a warehouse (formerly for we_cnt_ges)
Info: A receipt has one dat_formdate but can be split into multiple positions with different deliveries that probably is dat_entry_rcv.
Info: In some cases one orig_receipt_id_rcv can contain multiple receipt_id_rcv, inversely there are relatively few cases. Thus receipt_id_rcv seems to be more granular. */
  /* Facts 3
Aggregated base data for item_2 receipts at a warehouse 
These are booked receipts but the contact_2 medium will be limited to EDI. (formerly for we_cnt_edi)
Info: A receipt has one dat_formdate but can be split into multiple positions with different deliveries that probably is dat_entry_rcv.
Info: In some cases one orig_receipt_id_rcv can contain multiple receipt_id_rcv, inversely there are relatively few cases. Thus receipt_id_rcv seems to be more granular. */
  -- This is the delivery receipt like in item_receivings. It will be filtered for EDI later.

  /* Facts 4
Aggregated base data for item_2 receiving countings with a referenced used despatch advice (formerly for avis_used)
These are pallet counts from the get in process for stock delivered from suppliers to warehouses (WAWI table t174_gincount_2).
Info: T174 - Die Tabelle enthaelt die einzelnen Positionen, die mit eGIN in der Gesellschaft erfasst wurden
Info: eGIN - Diese Tabelle enthaelt alle Artikel_2, die gezaehlt werden muessen, bzw. gezaehlt wurden. Es gibt keine Loeschungen (ausser aus der Maske Torvergabe). */
  -- This is the delivery receipt like in wh_receivings

  -- reference to a despatch advice, if a despatch advice technically has been used in the counting process

  /* * CROSS JOIN of despatch advices and usable despatch advices */
  /* First CROSS JOIN of all despatch advices with wh receivings which is facts 1&2&3 */
  -- delivery date or goods receipt date or goods receipt document date!

  /* Second CROSS JOIN with item_2 receivings which is fact 4 and supplier_2 contacts */
  -- This is the amount of receipts for EDI

  -- Because the original facts for WH receivings EDI (wh_rcvg_edi_cnt_tmp) contains a condition, the leading fact is now wh_rcvg_edi_cnt.

  -- Therefore, this filter ensures that facts with no count values for the whole data row are filtered out (those with wh_rcvg_edi_cnt_tmp containing values while others are null).

  -- , cy_month_seq
 -- , cy_week_seq
 SELECT client_id,
   country_group_id AS ctry_grp_id,
   aspect_id,
   wh_id,
   wh_loc_sid,
   sup_sid,
   deliv_gr_rcpt_dt,
   busyear AS byr,
   cy_month,
   cy_week,
   busyear_seq AS byr_seq,
   desp_adv_cnt,
   usable_desp_adv_cnt,
   wh_rcvg_all_cnt,
   wh_rcvg_edi_cnt_tmp,
   wh_rcvg_edi_cnt,
   item_rcvg_cnt,
   contact_active_fg AS cont_act_fg,
   contact_medium_cd AS cont_med_cd,
   sup_contact_purpose_sid AS cont_purpose_sid,
   contact_last_changed_dt AS cont_last_chgd_dt,
   dwh_valid_from AS cont_dwh_valid_from,
   dwh_valid_to AS cont_dwh_valid_to
  FROM DESPATCH_ADVICES_WH_RECEIVINGS_ITEM_RECEIVINGS);