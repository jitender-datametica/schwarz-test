CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_PREIS_AENDERUNG_2
(
mandant_id,
preis_aend_grund_id
)
AS
   SELECT
   v01.mandant_id,
   v01.preis_aend_grund_id

   FROM dbp_view.v_l_preis_aenderung_2 v01
   WHERE
   v01.mandant_id <> 1
   AND NOT
   (v01.preis_aend_grund_id = 7
   AND v01.mandant_id  in (3,6) );