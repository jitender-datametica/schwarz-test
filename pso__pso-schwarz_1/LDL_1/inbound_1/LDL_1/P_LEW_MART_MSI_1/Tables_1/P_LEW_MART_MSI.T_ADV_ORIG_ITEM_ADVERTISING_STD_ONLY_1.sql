/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for d_lew_mart_msi.t_adv_orig_item_advertising_std_only_1
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
# History:
#  1.0  23.09.2020    Bachmann, Torsten        Initial version, Materialize view v_adv_orig_item_advertising_std_only_1
#                                              Loading logic included in v_mat_adv_orig_item_advertising_std_only_1
#                                              REP3-7336, PatchNo: 2602
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_MSI.T_ADV_ORIG_ITEM_ADVERTISING_STD_ONLY_1 cluster by (client_id, dat_adv)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Client des Datawarehous - aktuell synonym fuer LIDL-Land_1',
	WH_ID NUMBER(38,0) NOT NULL COMMENT 'Gesellschafts-Nr.',
	ORIG_ITEM_NR NUMBER(18,0) NOT NULL COMMENT 'WAWI Artikelnummer (ohne Kolli)',
	DAT_VALID_FROM DATE COMMENT 'Gueltig ab, wird vom Vorsystem Wawi geliefert',
	DAT_ADV DATE NOT NULL COMMENT 'Werbetermin',
	WEEK_ADV VARCHAR(15) COMMENT 'Werbetermin in Wochennotation',
	REPEAT_FG NUMBER(38,0) COMMENT 'Repeat_k Artikel_1 erneut beworben (Wiederholer)',
	CURRENCY_ISO_CD VARCHAR(3) COMMENT 'Waehrungsbezeichnung, wird vom Vorsystem Wawi geliefert',
	REC_SRC_FG_STD NUMBER(38,0) COMMENT 'Flag 1/0: 1= Werbetermin stammt aus STD-Werbeterminerfassung, 0= stammt nicht aus STD-Werbeterminerfassung - Werbetemine koennen auch in beiden Systemen redundant erfasst sein',
	REC_SRC_FG_APT NUMBER(38,0) COMMENT 'Flag 1/0: 1= Werbetermin stammt aus APT, 0= stammt nicht aus APT - Werbetemine koennen auch in beiden Systemen redundant erfasst sein'
)COMMENT='Nur Wawi! Werbetermine ausschliesslich aus STD fuer MIS Berichte ohne Kompatibilitaet. $Revision: 15945 $'
;
