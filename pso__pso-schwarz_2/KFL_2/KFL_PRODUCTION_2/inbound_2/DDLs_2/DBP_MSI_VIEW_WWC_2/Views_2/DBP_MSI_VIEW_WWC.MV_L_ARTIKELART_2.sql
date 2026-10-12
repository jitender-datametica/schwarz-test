CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_ARTIKELART_2
(
mandant_id
,mandant_kbez
,MTART
)
AS
   SELECT
   v01.mandant_id, v02.mandant_kbez, v01.artikelart_id  AS MTART
   FROM dbp_view.v_l_artikelart_2 v01
   INNER JOIN dbp_view.v_mandant_2 v02
   ON v01.mandant_id = v02.mandant_id;