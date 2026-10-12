create or replace view KFL_PRODUCTION.DBP_SPEZIAL.V_ODS_COUPON_UNION_2(
	BON_ID,
	BON_ZEILE,
	COUPON_ID,
	COUPON_ZEILE,
	COUPON_MENGE,
	COUPON_BETRAG,
	COUPON_KZ,
	MANDANT_ID,
	WUP_ID,
	BON_DAT
) as
SELECT bon_id
,bon_zeile
,coupon_id
,coupon_zeile
,coupon_menge
,coupon_betrag
,coupon_kz
,mandant_id
,wup_id
,bon_dat
 FROM dbp_ods.ods_coupon_2
UNION ALL
SELECT bon_id
,bon_zeile
,coupon_id
,coupon_zeile
,coupon_menge
,coupon_betrag
,coupon_kz
,mandant_id
,wup_id
,bon_dat
 FROM dbp_ods_archiv.ods_coupon_2
;
