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

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_AGG_STORE_DAY_TURNOVER_EXT_1
( 
   client_id                        COMMENT 'Landeskennzeichen'
 , orig_store_nr                    COMMENT 'Original Filiall-Nr.'
 , dat_formdate                     COMMENT 'Aenderungsdatum'
 , currency_iso_cd                  COMMENT 'Waehrungsbezeichnung, wird vom Vorsystem Wawi geliefert' 
 , store_id                         COMMENT 'Filial-Nr.'
 , cy_month                         COMMENT 'Monat_1 des Geschaeftsjahres im Format "JJJJMM"'
 , cnt_customer                     COMMENT 'Anzahl Kunden'
 , cnt_customer_extrapol            COMMENT 'Customer Count extrapolation'
 , val_rtl                          COMMENT 'Retail value'
 , val_rtl_net                      
 , val_rtl_extrapol                 
 , val_rtl_net_extrapol             
 , val_rtl_kpges                    
 , val_rtl_net_kpges                
 , val_rtl_wawi                     COMMENT '((Nettowert der Fakturaposition in Belegwaehrung; SAP-BW: t_bw_2lis_13_vditm.netwr) plus (Steuerbetrag in Belegwaehrung; SAP-BW : t_bw_2lis_13_vditm.mwsbp)) * (-1) oder wenn cond_type_cd = ZPRA AND src_mtart in (ZVM,ZKM) AND sales_type_cd = ZFPU dann 0'
 , val_rtl_net_wawi                 COMMENT 'Nettowert der Fakturaposition in Belegwaehrung; SAP-BW: t_bw_2lis_13_vditm.netwr * (-1) oder wenn cond_type_cd = ZPRA AND src_mtart in (ZVM,ZKM) AND sales_type_cd = ZFPU dann 0'
 , val_rtl_txj
 , val_rtl_net_txj 
 , val_rtl_ejr 
 , val_rtl_net_ejr 
 , open_store_fg                    COMMENT 'Open store flag'
 , bereinigt_fg                     COMMENT 'Bereinigt flag'
 , bereinigt_VJW_fg                 COMMENT 'Bereinigt VJ same week day flag'
 , bereinigt_VJM_fg                 COMMENT 'Bereinigt VJ same calendar_1 day flag'
 , bereinigt_excl_opn_cls_wk_fg     COMMENT 'Bereinigt flag excluding open/close week'
 , bereinigt_excl_opn_cls_wk_VJW_fg COMMENT 'Bereinigt VJ same week day flag excluding open/close week'
 , bereinigt_excl_opn_cls_wk_VJM_fg COMMENT 'Bereinigt VJ same calendar_1 day flag excluding open/close week'
 , bereinigt_VVJ_fg                 COMMENT 'Bereinigt VVJ flag'
 , bereinigt_VVJW_fg                COMMENT 'Bereinigt VVJ same week day flag'
 , bereinigt_VVJM_fg                COMMENT 'Bereinigt VVJ same calendar_1 day flag'
 , bereinigt_VVVJ_fg                COMMENT 'Bereinigt VVVJ flag'
 , bereinigt_VVVJW_fg               COMMENT 'Bereinigt VVVJ same week day flag'
 , bereinigt_VVVJM_fg               COMMENT 'Bereinigt VVVJ same calendar_1 day flag'
) AS
   SELECT
   client_id
 , orig_store_nr
 , dat_formdate
 , currency_iso_cd
 , store_id
 , cy_month
 , cnt_customer
 , cnt_customer_extrapol AS cnt_customer_extrapol
 , val_rtl
 , val_rtl_net
 , val_rtl_extrapol
 , val_rtl_net_extrapol
 , val_rtl_kpges
 , val_rtl_net_kpges
 , val_rtl_wawi
 , val_rtl_net_wawi
 , val_rtl_txj
 , val_rtl_net_txj
 , val_rtl_ejr
 , val_rtl_net_ejr
 , open_store_fg
 , bereinigt_fg
 , bereinigt_VJW_fg
 , bereinigt_VJM_fg
 , bereinigt_excl_opn_cls_wk_fg     
 , bereinigt_excl_opn_cls_wk_VJW_fg 
 , bereinigt_excl_opn_cls_wk_VJM_fg 
 , bereinigt_VVJ_fg          
 , bereinigt_VVJW_fg       
 , bereinigt_VVJM_fg       
 , bereinigt_VVVJ_fg      
 , bereinigt_VVVJW_fg       
 , bereinigt_VVVJM_fg
   FROM p_lew_mart_msi.v_agg_store_day_turnover_ext_1
;
