CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_VZ_2
(
vz_wup_id
,mandant_id
,nb_id
,wup_typ_id
,wup_standort
,zu_id
)
AS
   SELECT
  v01.wup_id, v01.mandant_id, v01.nb_id, wup_typ_id, CASE WHEN v01.wup_id=-1 THEN 'ZENTRAL GENERELL'
   WHEN v01.wup_id=-2 THEN 'DEZENTRAL' ELSE wup_standort
   END AS wup_standort, CAST(zu_id AS INTEGER)
   FROM dbp_view.v_wup_2 v01
   LEFT OUTER JOIN dbp_msi_view2.mv_vz_zuordnung_2 v02
   ON
   v01.vz_wup_id=v02.wup_id
   WHERE wup_typ_id IN (-1,2)
   AND v01.mandant_id = 1;