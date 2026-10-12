CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_PREIS_AENDERUNG
(
mandant_id
,mandant_kbez
,PV_GRUND
)
AS
   SELECT
   v01.mandant_id, v02.mandant_kbez, v01.preis_aend_grund_id AS PV_GRUND
   FROM dbp_view.v_l_preis_aenderung v01
   INNER JOIN dbp_view.v_mandant v02
   ON v01.mandant_id = v02.mandant_id;