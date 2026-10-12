CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_MAX_LISTUNG_MARKT_KW_2
(
mandant_id
,art_id
,wg_id
,wup_id
,nb_id
,kjwo
,listung
)
AS
   SELECT
   v01.mandant_id,
   v01.art_id,
   v01.wg_id,
   v01.wup_id,
   v01.nb_id,
   v01. kjwo,
   v01.listung_id

   FROM dbp_view.v_art_wup_listung_kjwo_2 v01

   WHERE v01.mandant_id > 1;