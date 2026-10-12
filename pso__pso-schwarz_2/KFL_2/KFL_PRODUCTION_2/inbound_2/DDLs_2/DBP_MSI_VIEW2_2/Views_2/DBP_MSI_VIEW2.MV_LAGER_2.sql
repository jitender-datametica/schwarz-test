CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_LAGER_2
(
  lager_id
 ,mandant_id
 ,nb_id
 ,wup_typ_id
 ,wup_standort
 ,vz_wup_id
 ,zu_id
)
AS
   SELECT
    v01.wup_id, v01.mandant_id, v01.nb_id, wup_typ_id, wup_standort, v01.vz_wup_id, CAST(zu_id AS INTEGER)
   FROM dbp_view.v_wup_2 v01
   LEFT OUTER JOIN dbp_msi_view2.mv_vz_zuordnung_2 v02
   ON
   v01.wup_id=v02.wup_id
   WHERE wup_typ_id =1
   AND
   v01.mandant_id=1;