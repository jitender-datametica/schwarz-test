/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_msi_ac.v_agg_store_day_turnover_ext.
#----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber.Harald            Release 1.1
#  1.1  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.2  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.3  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.6  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.7  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.8  03.05.2018    Wieber.Harald            Release 3.6
#  1.9  17.05.2018    Wieber,Harald            Update Release 3.8
#
#  2.0  09.06.2021    Cione, Rodrigo           Flags added: open_store_fg, bereinigt_fg, bereinigt_VJW_fg AND bereinigt_VJM_fg
#                                              Patch: 20210608_2858_New_fgs_store_day_turnover_ext
#  2.1  16.11.2021    Jaroslaw Syrokosz        added column cnt_customer_extrapol - https://jira.schwarz/browse/REP2-10713
#  2.2  24.02.2022    Jaroslaw Syrokosz        B-0011292A-AP0120280 - new VVJ and VVVJ flags and change in joins for store details for optimization
#  2.3  13.01.2023    Marcin Malec             User Story 402025: BE | Bereinigter Umsatz gem. SDL-Logik
#                                              adding bereinigt LJ, VJW, VJM flags for store open/close weeks
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_agg_store_day_turnover_ext_1 (client_id
OPTIONS(description='Landeskennzeichen'), orig_store_nr OPTIONS(description='Original Filiall-Nr.'), dat_formdate
OPTIONS(description='Aenderungsdatum'), currency_iso_cd
OPTIONS(description='Waehrungsbezeichnung, wird vom Vorsystem Wawi geliefert'), store_id
OPTIONS(description='Filial-Nr.'), cy_month OPTIONS(description='Monat_1 des Geschaeftsjahres im Format "JJJJMM"'),
cnt_customer OPTIONS(description='Anzahl Kunden'), cnt_customer_extrapol
OPTIONS(description='Customer Count extrapolation'), val_rtl OPTIONS(description='Retail value'), val_rtl_net,
val_rtl_extrapol, val_rtl_net_extrapol, val_rtl_kpges, val_rtl_net_kpges, val_rtl_wawi
OPTIONS(description='((Nettowert der Fakturaposition in Belegwaehrung; SAP-BW: t_bw_2lis_13_vditm.netwr) plus (Steuerbetrag in Belegwaehrung; SAP-BW : t_bw_2lis_13_vditm.mwsbp)) * (-1) oder wenn cond_type_cd = ZPRA AND src_mtart in (ZVM,ZKM) AND sales_type_cd = ZFPU dann 0'),
val_rtl_net_wawi
OPTIONS(description='Nettowert der Fakturaposition in Belegwaehrung; SAP-BW: t_bw_2lis_13_vditm.netwr * (-1) oder wenn cond_type_cd = ZPRA AND src_mtart in (ZVM,ZKM) AND sales_type_cd = ZFPU dann 0'),
val_rtl_txj, val_rtl_net_txj, val_rtl_ejr, val_rtl_net_ejr, open_store_fg OPTIONS(description='Open store flag'),
bereinigt_fg OPTIONS(description='Bereinigt flag'), bereinigt_vjw_fg
OPTIONS(description='Bereinigt VJ same week day flag'), bereinigt_vjm_fg
OPTIONS(description='Bereinigt VJ same calendar_1 day flag'), bereinigt_excl_opn_cls_wk_fg
OPTIONS(description='Bereinigt flag excluding open/close week'), bereinigt_excl_opn_cls_wk_vjw_fg
OPTIONS(description='Bereinigt VJ same week day flag excluding open/close week'), bereinigt_excl_opn_cls_wk_vjm_fg
OPTIONS(description='Bereinigt VJ same calendar_1 day flag excluding open/close week'), bereinigt_vvj_fg
OPTIONS(description='Bereinigt VVJ flag'), bereinigt_vvjw_fg OPTIONS(description='Bereinigt VVJ same week day flag'),
bereinigt_vvjm_fg OPTIONS(description='Bereinigt VVJ same calendar_1 day flag'), bereinigt_vvvj_fg
OPTIONS(description='Bereinigt VVVJ flag'), bereinigt_vvvjw_fg OPTIONS(description='Bereinigt VVVJ same week day flag'),
bereinigt_vvvjm_fg OPTIONS(description='Bereinigt VVVJ same calendar_1 day flag')) AS SELECT *
FROM ldl_p_lew_mart_msi.v_agg_store_day_turnover_ext_1;