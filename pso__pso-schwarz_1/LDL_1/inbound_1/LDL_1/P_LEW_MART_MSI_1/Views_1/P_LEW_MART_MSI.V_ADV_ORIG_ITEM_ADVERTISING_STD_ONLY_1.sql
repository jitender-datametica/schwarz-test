/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_adv_orig_item_advertising_std_only_1
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
# History:
#  1.0  14.04.2018    Thole,Jens               initial erstellt zur Prodsetzungssupport f�r INT-B-112 und vergleichbare
#  1.1  18.09.2020    Bachmann, Torsten        Add additional join condition
#                                              INC2245738 - REP3-7325
#  1.2  29.09.2020    Bachmann, Torsten        View was materialized in t_adv_orig_item_advertising_std_only. Changing to 1:1 View
#                                              REP3-7336, PatchNo: 2602
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.v_adv_orig_item_advertising_std_only_1 COMMENT = 'Nur Wawi! Werbetermine ausschliesslich aus STD fuer MIS Berichte ohne Kompatibilitaet. $Revision: 15945 $'
AS
SELECT
          client_id
        , wh_id
        , orig_item_nr
        , dat_valid_from
        , dat_adv
        , week_adv
        , repeat_fg
        , currency_iso_cd
        , rec_src_fg_std
        , rec_src_fg_apt
FROM P_LEW_MART_MSI.t_adv_orig_item_advertising_std_only_1
;
