CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_DISPOMERKMAL
(
mandant_id
,DISMM
,mandant_kbez
)
AS
   SELECT
   v01.mandant_id, v01.dispomerkmal AS DISMM, v02.mandant_kbez
   FROM dbp_view.v_l_dispomerkmal v01
   INNER JOIN dbp_view.v_mandant v02
   ON v01.mandant_id = v02.mandant_id
   WHERE v01.mandant_id <> 1
   ;