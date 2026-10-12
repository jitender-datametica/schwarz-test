/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_adv_orig_item_advertising_std_only_1
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
# History:
#  1.0  14.04.2018    Thole,Jens               initial erstellt zur Prodsetzungssupport f�r INT-B-112 und vergleichbare
#  1.1  18.09.2020    Bachmann, Torsten        Add additional CROSS JOIN condition
#                                              INC2245738 - REP3-7325
#  1.2  29.09.2020    Bachmann, Torsten        View was materialized in t_adv_orig_item_advertising_std_only. Changing to 1:1 View
#                                              REP3-7336, PatchNo: 2602
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_adv_orig_item_advertising_std_only_1
OPTIONS(DESCRIPTION = `NUR WAWI! WERBETERMINE AUSSCHLIESSLICH AUS STD FUER MIS BERICHTE OHNE KOMPATIBILITAET. $Revision: 15945 $`)
AS SELECT client_id,
 wh_id,
 orig_item_nr,
 dat_valid_from,
 dat_adv,
 week_adv,
 repeat_fg,
 currency_iso_cd,
 rec_src_fg_std,
 rec_src_fg_apt
FROM ldl_p_lew_mart_msi.t_adv_orig_item_advertising_std_only_1;