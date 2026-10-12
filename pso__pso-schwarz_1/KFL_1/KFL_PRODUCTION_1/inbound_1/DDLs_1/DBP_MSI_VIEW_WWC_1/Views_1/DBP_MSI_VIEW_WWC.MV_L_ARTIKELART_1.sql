CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_ARTIKELART_1
(
mandant_id
,mandant_kbez
,MTART
)
AS
   SELECT
   v01.mandant_id, v02.mandant_kbez, v01.artikelart_id  AS MTART
   FROM dbp_view.v_l_artikelart_1 v01
   INNER JOIN dbp_view.v_mandant_1 v02
   ON v01.mandant_id = v02.mandant_id;