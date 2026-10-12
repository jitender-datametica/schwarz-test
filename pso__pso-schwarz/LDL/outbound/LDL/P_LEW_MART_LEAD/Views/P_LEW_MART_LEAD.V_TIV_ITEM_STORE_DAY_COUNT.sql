CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_tiv_item_store_day_count (dat_formdate
OPTIONS(description='DATUM DER INVENTURANFORDERUNG'), client_id OPTIONS(description='MIS CLIENT ID'), request_id
OPTIONS(description='ANFORDERUNGS ID'), loc_sid_wh OPTIONS(description='S-KEY DER LOCATION HIER DER GESELLSCHAFT'),
move_to_store_id OPTIONS(description='S-KEY DER LOCATION HIER DER FILIALE'), aspect_id
OPTIONS(description='GESELLSCHAFTSFORM (1 = BETRIEBS- 2 = VERTRIEBSGESELLSCHAFT)'), currency_iso_cd
OPTIONS(description='3 STELLIGER WÄHRUNGS-CODE'), curr_tot_id OPTIONS(description='INTERNER WÄHRUNGS-CODE'),
request_list_id OPTIONS(description='ANFORDERUNGS LITE ID'), inv_type_id OPTIONS(description='INVENTURTYP'),
stock_corr_req_status_id OPTIONS(description='STATUS DER INVENTURANFORDERUNG'), item_sid
OPTIONS(description='S-KEY DER ARTIKEL'), cnt_reason_id OPTIONS(description='GRUND DER INVENTURANFORDERUNG'),
act_item_cnt OPTIONS(description='GEZÄHLTE MENGE'), soll_bestand OPTIONS(description='SOLLMENGE'), korrekturmenge
OPTIONS(description='KORREKTURMENGE'), price_retail_netto, korrekturwert, inv_cnt
OPTIONS(description='REPORTING-ZÄHLER'), qty_stc_calc OPTIONS(description='STC SOLLBESTAND'), korrekturmenge_dynamisch
OPTIONS(description='KORREKTURMENGE_DYNAMISCH'), korrekturwert_dynamisch OPTIONS(description='KORREKTURWERT_DYNAMISCH'))
AS WITH RELEVANT_SCOPE AS (SELECT DISTINCT requested_cnt_dt,
   client_id,
   item_sid,
   move_to_store_id,
   aspect_id
  FROM ldl_p_lew_mart_lead.t_tiv_item_store_day_count
  WHERE requested_cnt_dt <= CURRENT_DATE
   AND client_id < 41), STC_AGGREGATED AS (SELECT SLI.client_id,
   MRG.move_to_store_id,
   MRG.aspect_id,
   SLI.item_sid,
   SLI.dwh_cal_dt AS dat_formdate,
   SUM(SLI.stock_calc_qty) AS qty_stc_calc
  FROM ldl_p_lew_bil_ac.v_stock_location_item AS SLI
   INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge AS MRG ON SLI.client_id = MRG.client_id AND SLI.loc_sid = MRG.store_id
         AND MRG.mis_store_active_fg = 1 AND MRG.test_store_fg = 0 AND SLI.dwh_cal_dt BETWEEN MRG.dat_opening_ovis AND (COALESCE(MRG
       .dat_closing_ovis, DATE '9999-12-31'))
   INNER JOIN RELEVANT_SCOPE AS rel ON SLI.client_id = rel.client_id AND SLI.item_sid = rel.item_sid AND SLI.dwh_cal_dt
       = rel.requested_cnt_dt AND MRG.move_to_store_id = rel.move_to_store_id AND MRG.aspect_id = rel.aspect_id
  GROUP BY SLI.client_id,
   MRG.move_to_store_id,
   MRG.aspect_id,
   SLI.item_sid,
   dat_formdate) (SELECT TIV.requested_cnt_dt AS dat_formdate,
   TIV.client_id,
   TIV.request_id,
   TIV.loc_sid_wh,
   TIV.move_to_store_id,
   TIV.aspect_id,
   TIV.currency_iso_cd,
   TIV.curr_tot_id,
   TIV.request_list_id,
   TIV.inv_type_id,
   TIV.stock_corr_req_status_id,
   TIV.item_sid,
   TIV.cnt_reason_id,
   TIV.act_item_cnt,
   TIV.soll_bestand,
   TIV.korrekturmenge,
   TIV.price_retail_netto,
   TIV.korrekturwert,
   TIV.inv_cnt,
   IFNULL(stc.qty_stc_calc, 0) AS qty_stc_calc,
   ROUND(CAST(TIV.act_item_cnt - IFNULL(stc.qty_stc_calc, 0) AS NUMERIC), 4) AS korrekturmenge_dynamisch,
   ROUND(CAST((TIV.act_item_cnt - IFNULL(stc.qty_stc_calc, 0)) * TIV.price_retail_netto AS NUMERIC), 4) AS
   korrekturwert_dynamisch
  FROM ldl_p_lew_mart_lead.t_tiv_item_store_day_count AS TIV
   LEFT JOIN STC_AGGREGATED AS stc ON TIV.client_id = stc.client_id AND TIV.move_to_store_id = stc.move_to_store_id AND
       TIV.aspect_id = stc.aspect_id AND TIV.requested_cnt_dt = stc.dat_formdate AND TIV.item_sid = stc.item_sid);