CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GRUPPE_USER_MATRIX_NEU_2
(
gruppe_id
, user_id
)
AS

   SELECT v01.gruppe_id, CAST ('' AS VARCHAR (10))  user_id

   FROM dbp_security.gruppe_2 v01;