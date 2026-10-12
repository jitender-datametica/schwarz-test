CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_KOSTENSTELLE_PER_2
(
mandant_id
, kostenstelle_id
, kostenstellenart_id
, krk_id
, kostenstelle_bez
, wup_id
, standort
, kjmo_von
, kjmo_bis
)
AS
   SELECT
   v01.mandant_id, v01.kostenstelle_id, v01.kostenstellenart_id, v01.krk_id, v02.kostenstelle_bez, v03.wup_id, v03.wup_stadt, v01.kjmo_von, v01.kjmo_bis

   FROM (
   SELECT

   mandant_id, kostenstelle_id, kostenstellenart_id, krk_id, CASE WHEN  (SUBSTRING(kostenstelle_id, 1, 4)) BETWEEN '0000' AND '9999'  THEN (SUBSTRING(kostenstelle_id, 1, 4))    END AS wup_id, SUBSTRING(dat_von, 1, 4)  || SUBSTRING(dat_von, 6, 2) AS kjmo_von, SUBSTRING(dat_bis, 1, 4)  || SUBSTRING(dat_bis, 6, 2) AS kjmo_bis
   from dbp_view.v_in_kostenstelle_per_2 ) v01
   LEFT OUTER JOIN dbp_view.v_in_kostenstelle_spr_zu_per_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.kostenstelle_id = v02.kostenstelle_id
   AND v02.dat_bis = '9999-12-31'
   AND v02.spr_id = 22
   LEFT OUTER JOIN dbp_view.v_wup_2 v03
   ON v01.mandant_id = v03.mandant_id
   --AND v03.dat_von < DATE
   --AND v03.dat_bis  > DATE
   AND v01.wup_id
   = v03.wup_id

   JOIN dbp_view.v_tag_2 v04
   ON v04.dat = CURRENT_DATE
   --AND v03.dat_von < DATE
   --AND v03.dat_bis  > DATE

   WHERE v04.kjmo BETWEEN kjmo_von AND kjmo_bis;