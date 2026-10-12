create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LAGERBEW(
	BELEG_USER_NAME,
	DAT_BELEG,
	DAT_BUCH,
	DAT_ERFASST,
	KJ,
	LAGERBEW_BELEG_ID,
	MANDANT_ID,
	REF_LAGERBEW_BELEG_ID,
	VORGANGSART_ID,
	BELEGKOPFTEXT,
	REF_LAGERBEW_BELEG_ID_NUM,
	KJ_LIEF_BELEG
) as
   SELECT
   v01.beleg_user_name, v01.dat_beleg, v01.dat_buch, v01.dat_erfasst, v01.kj, v01.lagerbew_beleg_id, v01.mandant_id, v01.ref_lagerbew_beleg_id, v01.vorgangsart_id, v01.belegkopftext, v01.ref_lagerbew_beleg_id_num, v02.kj

   FROM dbp_view.v_lagerbew v01
   LEFT join dbp_view.v_besch_lief v02
   ON
   v01.ref_lagerbew_beleg_id_num=v02.lief_beleg_id
   and v01.mandant_id=v02.mandant_id
   and extract(year from v01.dat_buch) between v02.kj-1 and v02.kj+1
   AND extract(year from v01.dat_buch) >= year(current_timestamp) - 2;