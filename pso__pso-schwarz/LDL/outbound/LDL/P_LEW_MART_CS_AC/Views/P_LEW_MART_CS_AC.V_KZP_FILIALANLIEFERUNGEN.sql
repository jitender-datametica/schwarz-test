/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_KZP_FILIALANLIEFERUNGEN
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  30.03.2022    Ross, Ulrich                 Fix missing Filialbestand while stores closed; User Story 306764 (remove columns)
#----------------------------------------------------------------------------
*/



/* #DescStart#
#$Revision: 14194 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_kzp_filialanlieferungen (client_id, country_iso_cd, dat_formdate, cy_month
, deliverytype_id, orig_item_nr, src_orig_store_nr, qty_total_del_asis, val_rtl_rl_del_asis, val_rtl_rl_net_del_asis,
qty_piece_del_asis, val_piece_del_asis, val_piece_net_del_asis, val_pr_diff_del, val_pr_diff_net_del, currency_iso_cd)
AS SELECT *
FROM ldl_p_lew_mart_cs.v_kzp_filialanlieferungen;

