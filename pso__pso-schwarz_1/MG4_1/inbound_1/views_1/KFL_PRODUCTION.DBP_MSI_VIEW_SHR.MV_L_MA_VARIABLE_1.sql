create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_MA_VARIABLE_1(
	MANDANT_ID,
	KJMO,
	BUCHUNGSKREIS_ID,
	DEF_VOLLZEIT_STUNDEN,
	KALENDERTAGE,
	SHR_FREIGABE_FG
) as
   SELECT
   v01.mandant_id, v01.kjmo, v01.buchungskreis_id, v01.def_vollzeit_stunden, v03.max_dat - v03.min_dat + 1 AS kalendertage, v01.shr_freigabe_fg
   FROM dbp_view.v_l_ma_variable_1 v01

   --JOIN dbp_view.v_shr_kennzahlen_1 v02
   --ON v01.mandant_id = v02.mandant_id
   --AND v01.kjmo = v02.kjmo

   JOIN
   dbp_view.v_monat_1 v03
   ON v01.kjmo = v03.kjmo

   GROUP BY
   v01.mandant_id
   , v01.kjmo
   , v01.buchungskreis_id
   , v01.def_vollzeit_stunden
   , v03.max_dat
   , v03.min_dat
   , v01.shr_freigabe_fg;