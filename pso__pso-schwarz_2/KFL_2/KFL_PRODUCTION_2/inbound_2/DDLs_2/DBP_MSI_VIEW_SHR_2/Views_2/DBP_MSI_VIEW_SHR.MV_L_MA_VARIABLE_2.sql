CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_MA_VARIABLE_2
(
mandant_id
, kjmo
, buchungskreis_id
, def_vollzeit_stunden
, kalendertage
, shr_freigabe_fg
)
AS
   SELECT
   v01.mandant_id, v01.kjmo, v01.buchungskreis_id, v01.def_vollzeit_stunden, v03.max_dat - v03.min_dat + 1 AS kalendertage, v01.shr_freigabe_fg
   FROM dbp_view.v_l_ma_variable_2 v01

   --JOIN dbp_view.v_shr_kennzahlen_2 v02
   --ON v01.mandant_id = v02.mandant_id
   --AND v01.kjmo = v02.kjmo

   JOIN
   dbp_view.v_monat_2 v03
   ON v01.kjmo = v03.kjmo

   GROUP BY
   v01.mandant_id
   , v01.kjmo
   , v01.buchungskreis_id
   , v01.def_vollzeit_stunden
   , v03.max_dat
   , v03.min_dat
   , v01.shr_freigabe_fg;