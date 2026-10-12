CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_TS_LIN_KURS_USER_ZU
(
mandant_id
,lin_kurs_id
,user_id
,loesch_fg
)
AS
   SELECT
   mandant_id, lin_kurs_id, user_id, 0 AS loesch_fg
   FROM dbp_msi_view_lin.ts_lin_kurs_user_zu
;