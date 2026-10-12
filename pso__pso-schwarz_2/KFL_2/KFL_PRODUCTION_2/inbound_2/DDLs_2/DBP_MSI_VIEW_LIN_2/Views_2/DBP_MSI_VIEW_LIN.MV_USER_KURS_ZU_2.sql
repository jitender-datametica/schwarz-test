CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_USER_KURS_ZU_2
(
mandant_id
,lin_kurs_id
,kursverantwortung_fg
)
AS
   SELECT v01.mandant_id, v01.lin_kurs_id, CAST(1 AS BYTEINT) AS kursverantwortung_fg
   FROM dbp_view.v_l_lin_kurs_2 v01
   INNER JOIN
   (
   SELECT
   v021.mandant_id, v021.user_id, v021.lin_kurs_id
   FROM dbp_msi_view_lin.ts_lin_kurs_user_zu_2 v021
   JOIN dbp_msi_data.akt_msi_user_2 v022
   ON v021.user_id = v022.user_id
   ) v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.lin_kurs_id = v03.lin_kurs_id
   GROUP BY 1,2,3
   ;