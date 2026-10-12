CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GRUPPE_USER_MATRIX_LOESCH_1
(
gruppe_id
, user_id
, loesch_fg
)
AS

   SELECT
   v01.gruppe_id, v01.user_id, 0 AS  loesch_fg


   FROM dbp_security.gruppe_user_zu_1 v01

   --Ausschluss der DUMMY_1-ID 0
   WHERE v01.gruppe_id <> 0;