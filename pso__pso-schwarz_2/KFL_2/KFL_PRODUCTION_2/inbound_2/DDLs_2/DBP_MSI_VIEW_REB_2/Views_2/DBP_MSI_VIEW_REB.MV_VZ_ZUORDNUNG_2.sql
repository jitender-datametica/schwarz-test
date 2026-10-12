CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_VZ_ZUORDNUNG_2
(
mandant_id
, vz_wup_id
, wup_plz
, zu_id
, wup_id
, nb_id
)
AS
   SELECT
   v01.mandant_id, v01.vz_wup_id, v01.wup_plz, CASE WHEN v01.wup_plz <20000 OR v01.vz_wup_id=6907 THEN '1'
   WHEN v01.wup_plz BETWEEN 20000 AND 59999 THEN '3' ELSE '2'
   END AS zu_id, v02.wup_id, v02.nb_id

   FROM
   (
   SELECT
   v01.mandant_id, v01.vz_wup_id, v01.wup_plz, CASE WHEN v01.wup_plz <20000 OR v01.vz_wup_id=6907 THEN '1'
   WHEN v01.wup_plz BETWEEN 20000 AND 59999 THEN '3' ELSE '2'
   END AS zu_id
   FROM dbp_view.v_wup_2 v01
   WHERE vz_wup_id = wup_id
   AND v01.wup_typ_id = 2
   AND v01.nb_id = -111
   AND v01.mandant_id = 1
   ) v01
   LEFT OUTER JOIN dbp_view.v_wup_2 v02
   ON v01.vz_wup_id = v02.vz_wup_id
   AND v01.mandant_id = v02.mandant_id
   ;