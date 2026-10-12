

/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_APT_BUYPRICE
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  14.04.2021    Ulrich, Ross                 Remove "AND s2.sup_name IS NOT NULL" to get more supplier from AT 
#                                                  https://jira.schwarz/browse/DDLE-2086
#  1.2  23.01.2025    Ulrich, Ross                 Add column price_special_cond Special Conditions like Zoll, Entsorgung Papier/Kunststoff...
#                                                  https://dev.azure.com/schwarzit/schwarzit.biaid/_workitems/edit/704040
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_MAT_APT_BUYPRICE
(
    client_id
  , country_iso_cd
  , wh_id
  , org_item_nr
  , valid_from_item
  , case_size
  , org_supplier_nr
  , valid_from
  , valid_until
  , price_buying
  , price_special_cond
  , currency_iso_code
  , dwh_updated
  , dwh_created
  , dwh_load_id
  , load_id
  , src_id
)
AS
SELECT  
   bp.client_id
  ,bp.country_iso_cd
  ,bp.wh_id
  ,bp.org_item_nr
  ,bp.valid_from_item
  ,bp.case_size
  ,bp.org_supplier_nr
  ,bp.valid_from
  ,bp.valid_until
  ,bp.price_buying
  ,CASE WHEN bp.currency_iso_code = 'EUR' THEN sc.price_special_cond_eur ELSE sc.price_special_cond END AS price_special_cond
  ,bp.currency_iso_code
  ,bp.dwh_updated
  ,bp.dwh_created
  ,bp.dwh_load_id
  ,bp.load_id
  ,bp.src_id
FROM 
(
  SELECT
     ibp.client_id                                           AS client_id
    ,i.src_country_lidl_cd                                   AS country_iso_cd
    ,COALESCE(loc.src_wh_id, loc.loc_sid)                    AS wh_id
    ,i.orig_item_nr                                          AS org_item_nr
    ,ibp.dat_valid_from                                      AS valid_from_item
    ,COALESCE(i.case_size, 0)                                AS case_size
    ,COALESCE(s.orig_supplier_nr, -1)                        AS org_supplier_nr
    ,ibp.dat_valid_from                                      AS valid_from
    ,ibp.dat_valid_until                                     AS valid_until
    ,ibp.price_buying                                        AS price_buying
    ,c.curr_iso_cd                                           AS currency_iso_code
    ,TIMESTAMP '1900-01-01 00:00:00'                         AS dwh_updated
    ,TIMESTAMP '1900-01-01 00:00:00'                         AS dwh_created
    ,ibp.load_id                                             AS dwh_load_id
    ,CAST(-1 AS INTEGER)                                     AS load_id
    ,2                                                       AS src_id
  FROM p_lew_bil_ac.v_itm_sup_wh_buying_price AS ibp

  INNER JOIN
    ( SELECT
       client_id
      ,sup_sid
      ,COALESCE(sup_sid, -1) AS orig_supplier_nr
      FROM p_lew_bil_ac.v_supplier
      WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
      GROUP BY 1,2
    ) s
  ON ibp.client_id  = s.client_id
  AND ibp.sup_sid = s.sup_sid

  INNER JOIN p_lew_core_ac.v_supplier s2
  ON ibp.client_id = s2.client_id
  AND ibp.sup_sid = s2.sup_sid

  INNER JOIN p_lew_mart_cs.v_gen_item_asis i
  ON ibp.client_id = i.client_id
  AND ibp.item_sid = i.item_sid

  INNER JOIN P_LEW_CORE_AC.v_location AS loc
  ON loc.client_id = ibp.client_id
  AND loc.loc_sid = ibp.wh_loc_sid
  AND loc.wh_store_mark = 'B'

  INNER JOIN p_lew_core_ac.v_currency c
  ON ibp.client_id = c.client_id
  AND ibp.curr_sid = c.curr_sid

  WHERE ibp.item_sid > 0
    AND ibp.sup_sid   > 0
    AND ibp.price_buying IS NOT NULL
    AND c.curr_iso_cd  IS NOT NULL
    AND CURRENT_DATE BETWEEN ibp.dat_rec_start AND ibp.dat_rec_end
    AND i.itemstatus_cd > 3
    AND i.itemstatus_cd < 10
    AND i.buying_list_type_id IS NOT NULL
    AND i.buying_list_type_id > 0  

  GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
  QUALIFY ROW_NUMBER () OVER (PARTITION BY ibp.client_id, COALESCE(loc.src_wh_id, loc.loc_sid), i.orig_item_nr, ibp.dat_valid_from, COALESCE(i.case_size, 0), COALESCE(s.orig_supplier_nr, -1) ORDER BY ibp.dat_valid_from, ibp.dat_valid_until, ibp.price_buying DESC NULLS LAST) = 1
) AS bp

LEFT JOIN
(
  SELECT  
     ir.client_id
    ,COALESCE(c.src_wh_id, ir.wh_loc_sid)   AS wh_id
    ,TRY_TO_NUMBER (d.src_orig_item_nr)     AS org_item_nr
    ,ir.sup_sid                             AS org_supplier_nr
    ,ir.case_size_dec                       AS case_size
    ,ir.dat_formdate                        AS dat_formdate
    ,ir.receipt_id_rcv                      AS receipt_id_rcv
    ,SUM(ir.price_buying_rcv)               AS price_special_cond
    ,SUM(ir.price_buying_euro_rcv)          AS price_special_cond_eur
      
  FROM p_lew_core.t_wawi_mov_item_wh_receiving AS ir
  LEFT JOIN p_lew_core.t_wawi_itm_sup_spcond_type b
    ON ir.receipt_special_con_fg = b.spcond_type_id
    AND ir.client_id = b.client_id
  LEFT JOIN p_lew_core.t_wawi_itm_sup_spcond_subtype bb
    ON ir.client_id = bb.client_id
    AND b.spcond_subtype_id = bb.spcond_subtype_id
    AND CURRENT_DATE - 1 BETWEEN bb.dat_rec_start AND bb.dat_rec_end
  LEFT JOIN p_lew_core.t_location c
      ON ir.client_id = c.client_id
      AND ir.wh_loc_sid = c.loc_sid
      AND c.wh_store_mark = 'B'
  LEFT JOIN p_lew_core.t_item d
      ON ir.client_id = d.client_id
      AND ir.item_sid = d.item_sid
  WHERE ir.receipt_pos_stock_relevant_fg = 0 --keine eingelagerte Ware
    AND ir.receipt_special_con_fg <> 0    --nur Sonderkonditionen
    AND ir.link_receipt_pos_nr_rcv = 0 --damit berechnung price_buying_rcv korrekt ist
    AND ir.val_buying_euro > 0

  GROUP BY 1,2,3,4,5,6,7

  QUALIFY ROW_NUMBER () OVER (PARTITION BY ir.client_id, COALESCE(c.src_wh_id, ir.wh_loc_sid), TRY_TO_NUMBER (d.src_orig_item_nr), COALESCE(ir.case_size_dec, 0), COALESCE(ir.sup_sid, -1) ORDER BY ir.dat_formdate, ir.receipt_id_rcv DESC NULLS LAST) = 1
) AS sc
ON bp.client_id = sc.client_id
  AND bp.wh_id = sc.wh_id
  AND bp.org_item_nr = sc.org_item_nr
  AND bp.org_supplier_nr = sc.org_supplier_nr
  AND bp.case_size = sc.case_size
  AND bp.valid_from_item <= sc.dat_formdate
  ;