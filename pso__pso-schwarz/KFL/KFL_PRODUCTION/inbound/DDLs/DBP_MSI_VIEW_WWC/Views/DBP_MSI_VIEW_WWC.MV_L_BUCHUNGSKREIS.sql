CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_BUCHUNGSKREIS
(
mandant_id
,mandant_kbez
,BUKRS
)
AS
   SELECT
   v01.mandant_id, v02.mandant_kbez, v01.buchungskreis_id AS BUKRS
   FROM dbp_view.v_l_buchungskreis v01
   INNER JOIN dbp_view.v_mandant v02
   ON v01.mandant_id = v02.mandant_id;