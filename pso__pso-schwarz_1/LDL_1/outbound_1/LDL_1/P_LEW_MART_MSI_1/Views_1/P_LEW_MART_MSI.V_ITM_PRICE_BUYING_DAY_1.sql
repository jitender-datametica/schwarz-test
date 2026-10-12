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
#  1.5  10.11.2020    Torsten Bachmann         CROSS JOIN LDL.P_LEW_TMP.to  v_supplier_map_key_1 added
#                                              PatchNo: 2652, REP3-7579
#  1.6  17.03.2021    Torsten Bachmann         Transall shutdown, repointing v_wawi_cal -> v_cal
#                                              PatchNo: 2790, REP3-8380
#----------------------------------------------------------------------------
*/


/*
#----------------------------------------------------------------------------
*/


/* DescStart
$Revision: 16816 $, $LastChangedBy: tbachmann $
SubjectAreas: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
DescEnd */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_price_buying_day_1 OPTIONS(DESCRIPTION = `REVISION__DM: 16816 $  `) AS
/* Aufloesung WH */ SELECT t2.client_id,
 t2.item_id,
 t2.dat_calendar,
 t2.wh_id,
 t2.supplier_id,
 t2.price_buying,
  t2.price_buying + COALESCE(t2.a0, 0) AS price_buying_sp_cond,
 t2.orig_item_nr,
 t2.currency_iso_cd
FROM (SELECT A.client_id,
   A.item_sid AS item_id,
   C.cal_dt AS dat_calendar,
   WH.src_wh_id AS wh_id,
   SUPMAP.sup_sid_map AS supplier_id,
   COALESCE(CRS.unit_currency_exchange * BP.price_buying_special / CRS.rate_currency_exchange / CRY.rate_currency_exchange
     , CR.unit_currency_exchange * BP.price_buying / CR.rate_currency_exchange / CRY.rate_currency_exchange) AS
   price_buying,
   A.orig_item_nr,
   CRY.currency_iso_cd,
   SUM(CRSC.unit_currency_exchange * sp.val_special_condition / CRSC.rate_currency_exchange / CRYS.rate_currency_exchange
       * sp.sign_fg) AS a0
  FROM ldl_p_lew_core_ac.v_wawi_itm_item_skey_act_1 AS A
   INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_sup_wh_buying_price_1 AS BP ON A.item_sid = BP.item_sid AND A.client_id = BP.client_id
     /* Aufloesung WH */
   INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON BP.client_id = WH.client_id AND BP.wh_loc_sid = WH.loc_sid_wh AND WH
     .dwh_actual_fg = 1
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS C ON C.cal_dt BETWEEN BP.dat_valid_from AND BP.dat_valid_until
   INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_1 AS IIA ON A.item_sid = IIA.item_sid AND A.client_id = IIA.client_id
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_currency_rate_1 AS CR ON BP.client_id = CR.client_id AND BP.currency_nr =
      CR.currency_nr AND C.cal_dt BETWEEN CR.dat_valid_from AND CR.dat_valid_until
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_currency_rate_1 AS CRS ON BP.client_id = CRS.client_id AND BP.currency_nr_special
       = CRS.currency_nr AND C.cal_dt BETWEEN CRS.dat_valid_from AND CRS.dat_valid_until
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON BP.client_id = CRY.client_id AND CURRENT_DATE
     BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end /* wh und hq-Konditionen */
   LEFT JOIN (SELECT SP1.client_id,
     SP1.orig_item_nr,
     SP1.case_size,
     SP1.dat_valid_from_item,
     SP1.wh_loc_sid,
     SP1.sup_sid,
     SP1.include_margin_fg,
     SP1.dat_valid_from,
     SP1.dat_valid_until,
     SP1.currency_nr,
     SP1.val_special_condition,
     SP1.sign_fg,
     WH0.src_wh_id
    FROM ldl_p_lew_core_ac.v_wawi_itm_sup_wh_spcondition_1 AS SP1
     LEFT JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH0 ON SP1.client_id = WH0.client_id AND SP1.wh_loc_sid = WH0.loc_sid_wh
      AND WH0.dwh_actual_fg = 1) AS sp ON A.client_id = sp.client_id AND A.orig_item_nr = sp.orig_item_nr AND (sp.case_size
           IS NULL OR A.case_size = sp.case_size) AND IIA.dat_valid_from = sp.dat_valid_from_item AND (BP.wh_loc_sid =
          sp.wh_loc_sid OR sp.src_wh_id = 0) AND BP.sup_sid = sp.sup_sid AND sp.include_margin_fg = 1 AND C.cal_dt
     BETWEEN sp.dat_valid_from AND sp.dat_valid_until
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_currency_rate_1 AS CRSC ON sp.client_id = CRSC.client_id AND sp.currency_nr
       = CRSC.currency_nr AND C.cal_dt BETWEEN CRSC.dat_valid_from AND CRSC.dat_valid_until
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRYS ON sp.client_id = CRYS.client_id AND CURRENT_DATE
      BETWEEN CRYS.dat_rec_start AND CRYS.dat_rec_end AND CRY.currency_iso_cd = CRYS.currency_iso_cd
   INNER JOIN ldl_p_lew_core_ac.v_supplier_map_key_1 AS SUPMAP ON BP.client_id = SUPMAP.client_id AND BP.sup_sid = SUPMAP
     .sup_sid
  WHERE C.cy_month_seq <= 0
   AND C.cal_dt >= PARSE_DATE('%F', '2007-01-01')
  GROUP BY A.client_id,
   item_id,
   dat_calendar,
   wh_id,
   supplier_id,
   price_buying,
   A.orig_item_nr,
   CRY.currency_iso_cd) AS t2;