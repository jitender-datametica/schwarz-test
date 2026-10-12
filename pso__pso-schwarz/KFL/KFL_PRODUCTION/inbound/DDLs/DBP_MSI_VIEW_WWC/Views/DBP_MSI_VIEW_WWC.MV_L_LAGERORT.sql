CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_LAGERORT
(
mandant_id
,mandant_kbez
,LGORT
,WERKS
,nb_id
,lagernummer_id
)
AS
   SELECT
   v01.mandant_id, v02.mandant_kbez, v01.lagerort_id AS LGORT, v01.wup_id      AS WERKS, v01.nb_id, v01.lagernummer_id

   FROM dbp_view.v_l_lagerort v01
   INNER JOIN dbp_view.v_mandant v02
   ON v01.mandant_id = v02.mandant_id;