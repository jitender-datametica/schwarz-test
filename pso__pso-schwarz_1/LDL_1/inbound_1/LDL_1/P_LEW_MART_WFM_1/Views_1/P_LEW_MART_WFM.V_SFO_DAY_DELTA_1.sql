/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_SFO_DAY_DELTA_1
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-12    Ulrich ross          Remove eLWIS logic
#                                          https://dev.azure.com/schwarzit/schwarzit.biaid/_boards/board/t/Data%20Extraction%20And%20Export/Stories/?workitem=488527
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_SFO_DAY_DELTA_1
AS

SELECT
   client_id
  ,src_country_lidl_cd AS country_lidl_cd
  ,src_orig_store_nr   AS store
  ,dat_formdate        AS receiptdate
  ,derived_item_nr     AS item_1
  ,sfo_pieces_130_140
  ,sfo_pieces_131_141
  ,sfo_pieces_132_142
  ,sfo_pieces_133_143
  ,sfo_pieces_134_144
  ,sfo_pieces_135_145
  ,sfo_pieces_136_146
  ,sfo_pieces_137_147_0pv
  ,sfo_pieces_137_147_pv
  ,sfo_pieces_138_148
  ,sfo_pieces_139_149
  ,sfo_pieces_150_160
  ,sfo_pieces_151_161
  ,sfo_pieces_152_162
  ,sfo_value_130_140
  ,sfo_value_131_141
  ,sfo_value_132_142
  ,sfo_value_133_143
  ,sfo_value_134_144
  ,sfo_value_135_145
  ,sfo_value_136_146
  ,sfo_value_137_147_0pv
  ,sfo_value_137_147_pv
  ,sfo_value_138_148
  ,sfo_value_139_149
  ,sfo_value_150_160
  ,sfo_value_151_161
  ,sfo_value_152_162
  ,(SELECT
    MAX(dwh_load_id)
    FROM p_lew_core_ac.v_store_form_1) load_id
FROM
  (SELECT
     client_id
    ,src_country_lidl_cd
    ,src_orig_store_nr
    ,dat_formdate
    ,derived_item_nr
    ,CAST(SUM(CASE WHEN sfotype_id = 130 OR sfotype_id = 140 THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_130_140
    ,CAST(SUM(CASE WHEN sfotype_id = 131 OR sfotype_id = 141 THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_131_141
    ,CAST(SUM(CASE WHEN sfotype_id = 132 OR sfotype_id = 142 THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_132_142
    ,CAST(SUM(CASE WHEN sfotype_id = 133 OR sfotype_id = 143 THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_133_143
    ,CAST(SUM(CASE WHEN sfotype_id = 134 OR sfotype_id = 144 THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_134_144
    ,CAST(SUM(CASE WHEN sfotype_id = 135 OR sfotype_id = 145 THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_135_145
    ,CAST(SUM(CASE WHEN sfotype_id = 136 OR sfotype_id = 146 THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_136_146
    ,CAST(SUM(CASE WHEN (sfotype_id = 137 OR sfotype_id = 147) AND ((price_wh_net_sfo <> 0 AND price_new_net_sfo = 0) OR (price_wh_net_sfo = 0 AND price_new_net_sfo <> 0)) THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_137_147_0pv
    ,CAST(SUM(CASE WHEN (sfotype_id = 137 OR sfotype_id = 147) AND NOT ((price_wh_net_sfo <> 0 AND price_new_net_sfo = 0) OR (price_wh_net_sfo = 0 AND price_new_net_sfo <> 0)) THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_137_147_pv
    ,CAST(SUM(CASE WHEN sfotype_id = 138 OR sfotype_id = 148 THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_138_148
    ,CAST(SUM(CASE WHEN sfotype_id = 139 OR sfotype_id = 149 THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_139_149
    ,CAST(SUM(CASE WHEN sfotype_id = 150 OR sfotype_id = 160 THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_150_160
    ,CAST(SUM(CASE WHEN sfotype_id = 151 OR sfotype_id = 161 THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_151_161
    ,CAST(SUM(CASE WHEN sfotype_id = 152 OR sfotype_id = 162 THEN qty_total_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_pieces_152_162
    ,CAST(SUM(CASE WHEN sfotype_id = 130 OR sfotype_id = 140 THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_130_140
    ,CAST(SUM(CASE WHEN sfotype_id = 131 OR sfotype_id = 141 THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_131_141
    ,CAST(SUM(CASE WHEN sfotype_id = 132 OR sfotype_id = 142 THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_132_142
    ,CAST(SUM(CASE WHEN sfotype_id = 133 OR sfotype_id = 143 THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_133_143
    ,CAST(SUM(CASE WHEN sfotype_id = 134 OR sfotype_id = 144 THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_134_144
    ,CAST(SUM(CASE WHEN sfotype_id = 135 OR sfotype_id = 145 THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_135_145
    ,CAST(SUM(CASE WHEN sfotype_id = 136 OR sfotype_id = 146 THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_136_146
    ,CAST(SUM(CASE WHEN (sfotype_id = 137 OR sfotype_id = 147) AND ((price_wh_net_sfo <> 0 AND price_new_net_sfo = 0) OR (price_wh_net_sfo = 0 AND price_new_net_sfo <> 0)) THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_137_147_0pv
    ,CAST(SUM(CASE WHEN (sfotype_id = 137 OR sfotype_id = 147) AND NOT ((price_wh_net_sfo <> 0 AND price_new_net_sfo = 0) OR (price_wh_net_sfo = 0 AND price_new_net_sfo <> 0)) THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_137_147_pv
    ,CAST(SUM(CASE WHEN sfotype_id = 138 OR sfotype_id = 148 THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_138_148
    ,CAST(SUM(CASE WHEN sfotype_id = 139 OR sfotype_id = 149 THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_139_149
    ,CAST(SUM(CASE WHEN sfotype_id = 150 OR sfotype_id = 160 THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_150_160
    ,CAST(SUM(CASE WHEN sfotype_id = 151 OR sfotype_id = 161 THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_151_161
    ,CAST(SUM(CASE WHEN sfotype_id = 152 OR sfotype_id = 162 THEN val_retail_receiptline_net_sfo_agg ELSE 0 END) AS DECIMAL(20,4)) AS sfo_value_152_162
  FROM
    (SELECT
       itm_mov.sfo_type_id AS sfotype_id
      ,itm_mov.client_id
      ,clnt.src_country_lidl_cd
      ,loc.src_orig_store_nr
      ,itm_mov.dwh_cal_dt AS dat_formdate
      ,CAST(itm.src_orig_item_nr AS BIGINT) AS derived_item_nr
      ,itm.src_case_size
      ,itm_mov.wh_net_price AS price_wh_net_sfo
      ,itm_mov.new_net_price AS price_new_net_sfo
      ,SUM(itm_mov.case_qty) AS qty_case_sfo_agg
      ,SUM(CASE WHEN (itm_mov.piece_qty IS NULL) THEN 0 ELSE itm_mov.piece_qty END) AS qty_piece_sfo_agg
      ,(qty_case_sfo_agg * itm.src_case_size)  + qty_piece_sfo_agg AS calculated_total
      ,SUM(itm_mov.total_qty) AS  qty_total_sfo_agg
      ,SUM(itm_mov.receipt_line_net_val) AS val_retail_receiptline_net_sfo_agg
    FROM p_lew_core_ac.v_store_form_1 itm_mov

    INNER JOIN
      (SELECT
       itm_mov.client_id
      ,itm_mov.loc_sid_store
      ,itm_mov.dwh_cal_dt
      FROM p_lew_core_ac.v_store_form_1 itm_mov

      INNER JOIN p_lew_process_ac.v_wfm_last_export_1 last_expo
      ON itm_mov.dwh_updated > last_expo.last_export_tmsp
        AND last_expo.process_name = 'export_wfm_sfo_day'
        AND last_expo.process_specification = 'delta'

      INNER JOIN p_lew_process_ac.v_wfm_export_specification_1 expo_spec
      ON last_expo.export_specification = expo_spec.export_specification
        AND itm_mov.client_id = expo_spec.client_id
        AND itm_mov.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
        AND itm_mov.sfo_type_id IN (130,131,132,133,134,135,136,137,138,139,150,151,152,140,141,142,143,144,145,146,147,148,149,160,161,162)

      GROUP BY
         itm_mov.client_id
        ,itm_mov.loc_sid_store
        ,itm_mov.dwh_cal_dt
      ) AS delta_filter
    ON itm_mov.client_id = delta_filter.client_id
    AND itm_mov.loc_sid_store = delta_filter.loc_sid_store
    AND itm_mov.dwh_cal_dt = delta_filter.dwh_cal_dt
    AND itm_mov.sfo_type_id IN (130,131,132,133,134,135,136,137,138,139,150,151,152,140,141,142,143,144,145,146,147,148,149,160,161,162)

    INNER JOIN p_lew_core_ac.v_location_1 loc
    ON itm_mov.client_id = loc.client_id
    AND itm_mov.loc_sid_store = loc.loc_sid
    AND loc.wh_store_mark = 'A'

    INNER JOIN p_lew_core_ac.v_item_1 itm
    ON itm_mov.client_id = itm.client_id
    AND itm_mov.item_sid = itm.item_sid

    INNER JOIN p_lew_core_ac.v_client_1 clnt
    ON itm_mov.client_id = clnt.client_id

    WHERE itm.src_orig_item_nr IS NOT NULL

    GROUP BY
       itm_mov.sfo_type_id
      ,itm_mov.client_id
      ,clnt.src_country_lidl_cd
      ,loc.src_orig_store_nr
      ,itm_mov.dwh_cal_dt
      ,CAST(itm.src_orig_item_nr AS BIGINT)
      ,itm.src_case_size
      ,itm_mov.wh_net_price
      ,itm_mov.new_net_price
    ) subselect
  GROUP BY
     client_id
    ,src_country_lidl_cd
    ,src_orig_store_nr
    ,dat_formdate
    ,derived_item_nr
  ) subselect
;
