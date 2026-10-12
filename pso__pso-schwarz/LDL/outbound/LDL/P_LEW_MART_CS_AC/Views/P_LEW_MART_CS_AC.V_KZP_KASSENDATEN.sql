/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_KZP_KASSENDATEN
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.4  16.08.2021    Ross,Ulrich                  Erweiterung um LidlPlus Daten
#                                                  (sales_net_lp_val_ejr_asis,discount_net_lp_val_ejr_asis,piece_weight_lp_qty_ejr_asis)
#                                                  https://jira.schwarz/browse/DDLE-2558
#  1.5  30.03.2022    Ross, Ulrich                 Fix missing Filialbestand while stores closed; User Story 306764 (remove columns)
#----------------------------------------------------------------------------
*/



/* #DescStart#
#$Revision: 13869 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_kzp_kassendaten (client_id, country_iso_cd, cnt_discount_ejr_asis,
cnt_retail_ejr_asis, cnt_return_ejr_asis, dat_formdate, orig_item_nr, orig_store_nr, price_rtl_net_ejr_adjstd_asis,
price_rtl_ejr_asis, price_rtl_net_ejr_asis, qty_disc_piece_ejr_asis, qty_disc_weight_ejr_asis,
qty_disc_piece_weight_ejr_asis, qty_piece_ejr_asis, qty_return_ejr_asis, val_disc_rtl_gross_ejr_asis,
val_disc_rtl_net_ejr_asis, val_void_ejr_asis, val_void_net_ejr_asis, val_rtl_net_ejr_asis, val_return_net_ejr_asis,
qty_piece_weight_ejr_asis, qty_rt_piece_weight_ejr_asis, qty_rt_pc_wt_saleable_ejr_asis, sales_net_lp_val_ejr_asis,
discount_net_lp_val_ejr_asis, piece_weight_lp_qty_ejr_asis, currency_iso_cd) AS SELECT *
FROM ldl_p_lew_mart_cs.v_kzp_kassendaten;


