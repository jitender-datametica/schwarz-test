/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for d_lew_mart_msi.t_adv_orig_item_advertising_std_only
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
# History:
#  1.0  23.09.2020    Bachmann, Torsten        Initial version, Materialize view v_adv_orig_item_advertising_std_only
#                                              Loading logic included in v_mat_adv_orig_item_advertising_std_only
#                                              REP3-7336, PatchNo: 2602
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_adv_orig_item_advertising_std_only (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client des Datawarehous - aktuell synonym fuer LIDL-Land'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschafts-Nr.'),
orig_item_nr INTEGER NOT NULL OPTIONS(description='WAWI Artikelnummer (ohne Kolli)'),
dat_valid_from DATE OPTIONS(description='Gueltig ab, wird vom Vorsystem Wawi geliefert'),
dat_adv DATE NOT NULL OPTIONS(description='Werbetermin'),
week_adv STRING(15) OPTIONS(description='Werbetermin in Wochennotation'),
repeat_fg BIGNUMERIC(38,0) OPTIONS(description='Repeat_k Artikel erneut beworben (Wiederholer)'),
currency_iso_cd STRING(3) OPTIONS(description='Waehrungsbezeichnung, wird vom Vorsystem Wawi geliefert'),
rec_src_fg_std BIGNUMERIC(38,0)
OPTIONS(description='Flag 1/0: 1= Werbetermin stammt aus STD-Werbeterminerfassung, 0= stammt nicht aus STD-Werbeterminerfassung - Werbetemine koennen auch in beiden Systemen redundant erfasst sein'),
rec_src_fg_apt BIGNUMERIC(38,0)
OPTIONS(description='Flag 1/0: 1= Werbetermin stammt aus APT, 0= stammt nicht aus APT - Werbetemine koennen auch in beiden Systemen redundant erfasst sein')
) CLUSTER BY client_id, dat_adv
OPTIONS(description='Nur Wawi! Werbetermine ausschliesslich aus STD fuer MIS Berichte ohne Kompatibilitaet. $Revision: 15945 $');