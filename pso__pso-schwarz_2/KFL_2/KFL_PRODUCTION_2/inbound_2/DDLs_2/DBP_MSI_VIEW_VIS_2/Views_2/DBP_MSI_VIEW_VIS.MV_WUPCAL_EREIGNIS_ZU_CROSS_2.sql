CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUPCAL_EREIGNIS_ZU_CROSS_2
(
dat
,wup_id
,nb_id
,mandant_id
,ereignistyp_id
,ereignis_id
,offen
)
AS
   --
   SELECT
   v01.dat, v03.wup_id, v03.nb_id, v03.mandant_id, v03.ereignistyp_id AS ereignistyp_id, v03.ereignis_id AS ereignis_id, v03.offen AS offen
   FROM dbp_view.v_tag_2 v01
   INNER JOIN dbp_view.v_wupcal_ereignis_zu_2 v03
   ON v01.dat = v03.dat
   AND v01.akt_mo BETWEEN -2 AND 0


   UNION

   -- Für die Standard Umsatzkommentare (Typ 100) wird für jeden Tag_2 ein Ereigniseintrag vorgehalten
   -- damit Transaction Service für jeden Tag_2 im Umsatzbericht clickbar wird
   SELECT
   v01.dat, v01.wup_id, v01.nb_id, v01.mandant_id, 100 AS ereignistyp_id, -1 AS ereignis_id, COALESCE(v01.offen,0) offen
   FROM dbp_view.v_wupcal_2 v01
   INNER JOIN dbp_view.v_tag_2 v02
   ON v01.dat = v02.dat
   AND v02.akt_mo BETWEEN -2 AND 0
   WHERE (v01.dat, v01.wup_id, v01.mandant_id) NOT IN

   (SELECT v03.dat, v03.wup_id, v03.mandant_id
   FROM dbp_view.v_wupcal_ereignis_zu_2 v03
   INNER JOIN dbp_view.v_tag_2 v04
   ON v03.dat = v04.dat
   AND v04.akt_mo BETWEEN -2 AND 0
   AND v03.ereignistyp_id = 100
   )

   UNION


   -- Für die Freitext Umsatzkommentare (Typ 101) wird für jeden Tag_2 ein Ereigniseintrag vorgehalten
   -- damit Transaction Service für jeden Tag_2 im Umsatzbericht clickbar wird
   SELECT
   v01.dat, v01.wup_id, v01.nb_id, v01.mandant_id, 101 AS ereignistyp_id, -1 AS ereignis_id, COALESCE(v01.offen,0) offen
   FROM dbp_view.v_wupcal_2 v01
   INNER JOIN dbp_view.v_tag_2 v02
   ON v01.dat = v02.dat
   AND v02.akt_mo BETWEEN -2 AND 0
   WHERE (v01.dat, v01.wup_id, v01.mandant_id) NOT IN

   (SELECT v03.dat, v03.wup_id, v03.mandant_id
   FROM dbp_view.v_wupcal_ereignis_zu_2 v03
   INNER JOIN dbp_view.v_tag_2 v04
   ON v03.dat = v04.dat
   AND v04.akt_mo BETWEEN -2 AND 0
   AND v03.ereignistyp_id = 101
   );