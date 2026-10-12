/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_itm_price_buying_day_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  12.01.2018    Martin Murtenthaler      Natural wh key used for comparision with 0
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_1 mit V_WAREHOUSE_1 ersetzt
#  1.5  10.11.2020    Torsten Bachmann         join P_LEW_TMP.to  v_supplier_map_key_1 added
#                                              PatchNo: 2652, REP3-7579
#  1.6  17.03.2021    Torsten Bachmann         Transall shutdown, repointing v_wawi_cal -> v_cal
#                                              PatchNo: 2790, REP3-8380
#----------------------------------------------------------------------------
*/


/*
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_PRICE_BUYING_DAY_1 COMMENT = '$Revision: 16816 $  '
AS
/*
DescStart
$Revision: 16816 $, $LastChangedBy: tbachmann $
SubjectAreas: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
DescEnd
*/
SELECT
a.client_id
, a.item_sid AS item_id
, c.cal_dt           AS dat_calendar
, wh.src_wh_id AS wh_id
, supmap.sup_sid_map AS supplier_id
, Coalesce(crs.unit_currency_exchange * bp.price_buying_special / crs.rate_currency_exchange / cry.rate_currency_exchange, cr.unit_currency_exchange * bp.price_buying / cr.rate_currency_exchange / cry.rate_currency_exchange) AS price_buying
, Coalesce(crs.unit_currency_exchange * bp.price_buying_special / crs.rate_currency_exchange / cry.rate_currency_exchange, cr.unit_currency_exchange * bp.price_buying / cr.rate_currency_exchange / cry.rate_currency_exchange)
  + Coalesce(Sum(crsc.unit_currency_exchange * sp.val_special_condition / crsc.rate_currency_exchange / crys.rate_currency_exchange * sp.sign_fg) ,0) AS price_buying_sp_cond
, a.orig_item_nr
, cry.currency_iso_cd

FROM P_LEW_CORE_AC.v_wawi_itm_item_skey_act_1 AS a

INNER JOIN P_LEW_CORE_AC.v_wawi_itm_sup_wh_buying_price_1 AS bp
ON  a.item_sid  =  bp.item_sid
AND a.client_id = bp.client_id

/* Aufloesung WH */
INNER JOIN P_LEW_BIL_AC.v_warehouse_1 AS wh
ON wh.client_id =  bp.client_id
AND wh.loc_sid_wh =  bp.wh_loc_sid
AND wh.dwh_actual_fg = 1

INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_1 AS c
ON  c.cal_dt BETWEEN bp.dat_valid_from AND bp.dat_valid_until

INNER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act_1 AS iia
ON  a.item_sid  =  iia.item_sid
AND a.client_id = iia.client_id

INNER JOIN P_LEW_CORE_AC.v_wawi_ref_wawi_currency_rate_1 AS cr
ON  bp.client_id   = cr.client_id
AND bp.currency_nr = cr.currency_nr
AND c.cal_dt BETWEEN cr.dat_valid_from AND cr.dat_valid_until

LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_ref_wawi_currency_rate_1 AS crs
ON  bp.client_id   = crs.client_id
AND bp.currency_nr_special = crs.currency_nr
AND c.cal_dt BETWEEN crs.dat_valid_from AND crs.dat_valid_until

INNER JOIN P_LEW_CORE_AC.v_wawi_ref_client_currency_rate_1 AS cry
ON  bp.client_id = cry.client_id
AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end

/* wh und hq-Konditionen */
LEFT OUTER JOIN
(
  SELECT
    sp1.client_id
   ,sp1.orig_item_nr
   ,sp1.case_size
   ,sp1.dat_valid_from_item
   ,sp1.wh_loc_sid
   ,sp1.sup_sid
   ,sp1.include_margin_fg
   ,sp1.dat_valid_from
   ,sp1.dat_valid_until
   ,sp1.currency_nr
   ,sp1.val_special_condition
   ,sp1.sign_fg
   ,wh.src_wh_id
  FROM P_LEW_CORE_AC.v_wawi_itm_sup_wh_spcondition_1 sp1
  /* Aufloesung WH */
  LEFT OUTER JOIN P_LEW_BIL_AC.v_warehouse_1 AS wh
  ON wh.client_id = sp1.client_id
  AND wh.loc_sid_wh =  sp1.wh_loc_sid
  AND wh.dwh_actual_fg = 1
) AS sp
ON  a.client_id = sp.client_id
AND a.orig_item_nr = sp.orig_item_nr
AND (a.case_size = sp.case_size OR sp.case_size IS NULL )
AND iia.dat_valid_from = sp.dat_valid_from_item
AND (bp.wh_loc_sid  =  sp.wh_loc_sid OR sp.src_wh_id = 0)
AND bp.sup_sid  =  sp.sup_sid
AND sp.include_margin_fg = 1
AND c.cal_dt BETWEEN sp.dat_valid_from AND sp.dat_valid_until

LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_ref_wawi_currency_rate_1 AS crsc
ON  sp.client_id   = crsc.client_id
AND sp.currency_nr = crsc.currency_nr
AND c.cal_dt BETWEEN crsc.dat_valid_from AND crsc.dat_valid_until

LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_ref_client_currency_rate_1 AS crys
ON  sp.client_id = crys.client_id
AND Current_Date BETWEEN crys.dat_rec_start AND crys.dat_rec_end
AND cry.currency_iso_cd = crys.currency_iso_cd

INNER JOIN P_LEW_CORE_AC.v_supplier_map_key_1 supmap
  ON bp.client_id = supmap.client_id
 AND bp.sup_sid   = supmap.sup_sid

WHERE c.cy_month_seq <= 0
AND c.cal_dt >= TO_DATE('2007-01-01','YYYY-MM_1-DD')

GROUP BY a.client_id
, a.item_sid
, c.cal_dt
, wh.src_wh_id
, supmap.sup_sid_map
, Coalesce(crs.unit_currency_exchange * bp.price_buying_special / crs.rate_currency_exchange / cry.rate_currency_exchange, cr.unit_currency_exchange * bp.price_buying / cr.rate_currency_exchange / cry.rate_currency_exchange)
, a.orig_item_nr
, cry.currency_iso_cd
;

