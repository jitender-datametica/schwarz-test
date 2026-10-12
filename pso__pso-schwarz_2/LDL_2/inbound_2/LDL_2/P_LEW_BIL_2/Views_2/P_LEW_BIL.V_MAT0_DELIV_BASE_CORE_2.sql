/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_MAT0_DELIV_BASE_CORE_2
#----------------------------------------------------------------------------
# History:
#  1.0  17.01.2018    Wieber.Harald            Update Release 2.2
#  1.0  02.03.2018    Michael Ueding           Logik aus mat_deliv_base_core
#  1.2  19.03.2018    Martin Murtenthaler      Comment von column src_fg geaendert
#  1.3  26.03.2018    Martin Murtenthaler      Columns WH_ID and Subitemgroup changed
#  1.4  04.04.2018    Arnold.Arne              X_LEW_BIL.V_STORE_2 fuer Store-Informationen aufgenommen und WH Bestimmung auf Last-Known umgestellt.
#  1.5  06.04.2018    Martin Murtenthaler      ASIS-Sicht auch fuer Foodaction Flag
#  1.6  19.04.2018    Knopp.Timo               Modification of access to core table lew_core.t_map_mis_move_type_2 / map_mis_move_type_deliv after renaming core-Table
#  1.7  19.04.2018    Knopp.Timo               Modification of access to core table lew_core.t_map_mis_move_type_2 / map_mis_move_type_deliv after renaming core-Table
#  1.8  19.04.2018    Knopp.Timo               Modification of access to core table lew_core.t_map_mis_move_type_2 / map_mis_move_type_deliv after renaming core-Table
#  1.9  19.04.2018    Knopp,Timo               Modification of access to core table lew_core.t_map_mis_move_type_2 / map_mis_move_type_deliv after renaming core-Table
#  2.0  19.02.2021    Prasanna Ranjan          REP2-9080 - Include item_2 types ZKM and ZVM from USA and Serbia
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT0_DELIV_BASE_CORE_2 COMMENT = 'Ladeview Basistabelle Delivery Quelle DWH2.0 Core'
(
  client_id               COMMENT 'Landeskennzeichen'
  ,item_sid               COMMENT 'Surrogate Key Item_2'
  ,dat_formdate           COMMENT 'Bezugsdatum'
  ,loc_sid_store          COMMENT 'enthaelt surrogate Key des Stores'
  ,loc_sid_wh             COMMENT 'dem Store zugeordnetes Warehouse'
  ,deliverytype_id        COMMENT 'Konstanten: 1 = Zuteilungen / 2 = Kommisionierlisten / 3 = Direktlieverungen / 4 = FV / DEL 1 oder 2 / DIR 3 / FV 4 / CORE 1, 2 oder 3'
  ,orig_store_nr          COMMENT 'WAWI Quellsystemschluessel'
  ,cy_month               COMMENT 'Monat_2 des Geschaeftsjahres im Format "JJJJMM"'
  ,sub_item_grp_sid       COMMENT 'Subitemgroup'
  ,foodaction_fg          COMMENT 'Foodactionflag'
  ,qty_total_del          COMMENT 'DEL (qty_case_del + qty_case_order) * COALESCE(case_size_dec, case_size) + qty_piece_del / DIR qty_case_del * COALESCE(case_size_dec, case_size) + qty_piece_del / FV qty_case_del * case_size_real / CORE MSEG.MENGE  * COALESCE(STPO.MENGE,1)'
  ,val_rtl_rl_del         COMMENT 'DEL price_str_del * qty_total_del / DIR price_wh_del * qty_total_del / FV price_str_del * qty_total_del / CORE COALESCE(Effektiver Bruttopreis Store * qty_total_del, 1)'
  ,val_rtl_rl_net_del     COMMENT 'DEL price_str_net_del * qty_total_del / DIR price_wh_net_del * qty_total_del / FV price_str_net_del * qty_total_del / CORE COALESCE(Effektiver Nettopreis Store * qty_total_del, 1)'
  ,qty_piece_del_agg      COMMENT 'DEL qty_case_del * COALESCE(case_size_dec, case_size) + qty_piece_del / DIR qty_total_del / FV qty_total_del / CORE immer 0'
  ,val_piece_del          COMMENT 'DEL price_str_del * qty_piece_del_agg / DIR price_wh_del * qty_piece_del_agg / FV price_str_del * qty_piece_del_agg / CORE immer 0'
  ,val_piece_net_del      COMMENT 'DEL price_str_net_del * qty_piece_del_agg / DIR price_wh_net_del * qty_piece_del_agg / FV price_str_net_del * qty_piece_del_agg / CORE immer 0'
  ,val_pr_diff_del        COMMENT 'DEL / DIR / FV (price_str_del - price_wh_del) * qty_total_del / CORE (Effektiver Bruttopreis Store - Effektiver Bruttopreis Warehouse) * qty_total_del'
  ,val_pr_diff_net_del    COMMENT 'DEL / DIR / FV (price_str_net_del - price_wh_net_del) * qty_total_del / CORE (Effektiver Nettopreis Store - Effektiver Nettopreis Warehouse) * qty_total_del'
  ,src_fg                 COMMENT 'immer 1 bedeutend "aus SAP"'
)

AS

SELECT to_number(b.client_id) AS client_id
  ,Coalesce(c.item_sid, b.item_sid) AS item_sid
  ,b.dwh_cal_dt AS dat_formdate
  ,b.loc_sid AS loc_sid_store
  ,st2w.loc_sid_wh
  ,q.mis_deliv_type_id AS deliverytype_id
  ,st.src_orig_store_nr     AS orig_store_nr
  ,to_number(to_char(b.dwh_cal_dt,'YYYYMM')) AS cy_month
  ,n.sub_item_grp_sid
  ,CASE WHEN r.item_sid IS NOT NULL THEN 1 ELSE 0 END AS foodaction_fg
  ,to_number((b.ship_qty * Coalesce(c.component_qty, 1)), 18, 4) AS qty_total_del
  ,to_number(Coalesce(l.cond_val_eff_calc * qty_total_del, 1), 18, 4) AS val_rtl_rl_del
  ,to_number(Coalesce(l.net_val_eff_calc * qty_total_del, 1), 19, 5) AS val_rtl_rl_net_del
  ,to_number(0, 18, 4) AS qty_piece_del_agg
  ,to_number(0, 18, 4) AS val_piece_del
  ,to_number(0, 19, 5) AS val_piece_net_del
  ,to_number(NULL, 18, 8) AS val_pr_diff_del
  ,to_number(NULL, 38, 10) AS val_pr_diff_net_del
  ,1 AS src_fg
FROM P_LEW_CORE_AC.V_ITEM_MOVEMENT_RECORD_POS_2 AS b
    LEFT OUTER JOIN (
        SELECT ca.client_id
            ,ca.item_sid
            ,ca.item_bom_sid
        FROM P_LEW_CORE_AC.V_ITEM_BOM_2 AS ca
            LEFT OUTER JOIN  P_LEW_CORE_AC.V_ITEM_BOM_2 AS cb
                ON cb.client_id = ca.client_id
                AND cb.item_sid = ca.item_sid
                AND cb.src_werks = '@ALL'
                AND cb.deleted_fg = 0
                AND (cb.src_stlnr > ca.src_stlnr OR (cb.src_stlnr = ca.src_stlnr AND cb.item_bom_sid > ca.item_bom_sid))
        WHERE ca.src_werks = '@ALL'
            AND ca.deleted_fg = 0
            AND cb.client_id IS NULL
    ) c0
        ON c0.client_id = b.client_id
        AND c0.item_sid=b.item_sid
    LEFT OUTER JOIN P_LEW_CORE_AC.V_ITEM_BOM_POS_HIST_2 AS c
        ON c.client_id = c0.client_id
        AND c.item_bom_sid=c0.item_bom_sid
        AND Current_Date BETWEEN c.dwh_valid_from AND c.dwh_valid_to
        AND c.deleted_fg = 0
    /* LKP WH*/
    LEFT OUTER JOIN P_LEW_CORE_AC.V_LOCATION_2 AS f
        ON f.client_id = b.client_id
        AND f.loc_sid=b.loc_sid_counterparty
        AND f.wh_store_mark='B'
    /* Keine Teststores*/
    INNER JOIN P_LEW_BIL.V_STORE_2 AS st
        ON b.client_id = st.client_id
        AND b.loc_sid = st.loc_sid_store
        AND st.test_store_fg = 0
        AND st.dwh_actual_fg = 1
    /* LKP letzte, bekannte WH-Zuordnung*/
    INNER JOIN P_LEW_BIL.V_STORE_TO_WAREHOUSE_LASTKNOWN_2 AS st2w
        ON b.client_id = st2w.client_id
        AND b.loc_sid = st2w.loc_sid_store
    INNER JOIN P_LEW_CORE_AC.V_ITEM_HIST_2 AS k
        ON k.client_id = b.client_id
        AND k.item_sid=Coalesce(c.item_sid, b.item_sid)
        AND Current_Date BETWEEN k.dwh_valid_from AND k.dwh_valid_to
    LEFT OUTER JOIN P_LEW_BIL.V_ITEM_LOC_SALES_COND_DENORM_2 AS l
        ON l.client_id = k.client_id
        AND l.item_sid = k.item_sid
        AND l.uom_sid_cond = k.uom_sid_base
        AND l.loc_sid = b.loc_sid
        AND b.dwh_cal_dt BETWEEN l.dwh_valid_from AND l.dwh_valid_to
    LEFT OUTER JOIN P_LEW_BIL.V_ITEM_LOC_SALES_COND_DENORM_2 AS m
        ON m.client_id = k.client_id
        AND m.item_sid = k.item_sid
        AND m.uom_sid_cond = k.uom_sid_base
        AND m.loc_sid = st2w.loc_sid_wh
        AND b.dwh_cal_dt BETWEEN m.dwh_valid_from AND m.dwh_valid_to
    LEFT OUTER JOIN P_LEW_CORE_AC.V_ITEM_FAMILYGROUP_HIST_2 AS n
        ON n.client_id = k.client_id
        AND n.item_fam_grp_sid=k.item_fam_grp_sid
        AND Current_Date BETWEEN n.dwh_valid_from AND n.dwh_valid_to
    INNER JOIN P_LEW_CORE_AC.V_ORDER_RECORD_2 AS p
        ON p.client_id = b.client_id
        AND p.order_record_id=b.order_record_id
    INNER JOIN P_LEW_CORE_AC.V_MAP_MIS_MOVE_TYPE_DELIV_2 AS q
        ON q.client_id = p.client_id
        AND q.order_type_cd = p.order_type_cd
        AND q.move_type_cd = b.move_type_cd
    LEFT OUTER JOIN P_LEW_BIL.V_ITEM_FOODACTION_HIST_2 AS r
        ON r.client_id = k.client_id
        AND r.item_sid = k.item_sid
        AND CURRENT_DATE BETWEEN r.dwh_valid_from AND r.dwh_valid_to
    /* Zu ignorierende Artikelarten */
    LEFT OUTER JOIN P_LEW_PROCESS_AC.V_ITEM_TYPE_IGNORE_2 AS iti
        ON k.client_id = iti.client_id
        AND k.item_type_sid = iti.item_type_sid
        AND 
          (
            (
             iti.client_id IN (33, 34) 
             AND iti.item_type_cd  NOT IN ('ZKM', 'ZVM')
            )
            OR iti.client_id NOT IN (33, 34)
          ) 
        AND iti.item_type_grp_cd = 'ANL'
WHERE CASE WHEN (q.mis_deliv_type_id / 10) = 1 AND f.client_id IS NULL /* Auswertung 10er-Stelle (Resultat Division ist Integer ungerundet)*/
                        THEN 0
                        ELSE 1
                    END = 1
    AND iti.item_type_cd IS NULL /* Ungefilterte Artikelarten */
;