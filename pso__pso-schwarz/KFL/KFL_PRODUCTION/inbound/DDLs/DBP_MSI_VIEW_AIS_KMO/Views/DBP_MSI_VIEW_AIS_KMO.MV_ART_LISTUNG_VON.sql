CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ART_LISTUNG_VON
(
mandant_id
, art_id
, dat_aenderung_listung
, dat_erst_listung
)
AS

   SELECT v01.mandant_id,
   v01.art_id,
   MIN(v01.dat_von) dat_aenderung_listung,
   MIN(v01.dat_erst_listung) dat_erst_listung

  FROM dbp_view.v_art_vw_listung_von v01

   WHERE v01.mandant_id <> 1

   GROUP BY 1, 2;