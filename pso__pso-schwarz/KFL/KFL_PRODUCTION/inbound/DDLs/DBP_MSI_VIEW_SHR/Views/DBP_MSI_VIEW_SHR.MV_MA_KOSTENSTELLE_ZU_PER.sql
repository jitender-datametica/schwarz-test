CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MA_KOSTENSTELLE_ZU_PER
-- K.Kaiser 20140829 -- Änderung: KST_Wechsel wird nur noch über mitarbeiterbew geprüft
--
(
mandant_id
, mitarbeiter_id
, kjmo
, kostenstelle_id
, kostenstelle_id_alt
, haupt_kst_fg
, stunden_lohnart_2704
, kst_wechsel
, austritt_intern
)
AS
   -- K.Kaiser 20140827 -- hier werden die normalen Kostenstellen_ids pro MA und Monat ermittelt
   --                                     mit Lohnart 2704

   SELECT

   z1.mandant_id, z1.mitarbeiter_id, z1.kjmo, z1.kostenstelle_id_ AS kostenstelle_id, z1.kostenstelle_id_alt, haupt_kst_fg_ as haupt_kst_fg, stunden_lohnart_2704, kst_wechsel, 0 AS austritt_intern

   FROM
   (
   SELECT
   v01.mandant_id, v01.mitarbeiter_id, COALESCE(v02.kjmo, v01.kjmo) AS kjmo, COALESCE(v02.kostenstelle_id, v01.kostenstelle_id, '0000-000') AS kostenstelle_id_, COALESCE(v04.kostenstelle_id, '0000-000') AS kostenstelle_id_alt, COALESCE(v02.haupt_kst_fg,1) AS haupt_kst_fg_, SUM(v02.stunden_lohnart_2704) AS stunden_lohnart_2704, CASE WHEN v04.kostenstelle_id IS NOT NULL
   AND haupt_kst_fg_ = 1
   AND v99.ma_austritt_kz in (1,3)
   AND V99.ma_eintritt_kz = 1
   THEN 1 ELSE 0 END AS kst_wechsel
   --,CASE WHEN SUBSTR(v04.kostenstelle_id,1,4) <> SUBSTR(kostenstelle_id_ ,1,4)
   --AND v04.kostenstelle_id IS NOT NULL
   --AND haupt_kst_fg_ = 1
   --AND v99.ma_austritt_kz in (1,3)
   --AND V99.ma_eintritt_kz = 1
   --THEN 1 ELSE 0 END AS kst_wechsel

   FROM
   dbp_view.v_ma_kostenstelle_zu_per v01
   LEFT OUTER JOIN
   (
   SELECT
   v11.mandant_id, v11.mitarbeiter_id, v11.kjmo, v11.kostenstelle_id, v11.stunden_lohnart AS stunden_lohnart_2704, 0 AS haupt_kst_fg

   FROM dbp_view.v_ma_lohnart_zu_per v11
   WHERE v11.lohnart_id = '2704'

   UNION ALL

   SELECT
   v01.mandant_id, v01.mitarbeiter_id, v01.kjmo, v02.kostenstelle_id, SUM(v01.stunden_lohnart * -1) AS stunden_lohnart_2704, 1 AS haupt_kst_fg

   FROM dbp_view.v_ma_lohnart_zu_per v01
   LEFT OUTER JOIN dbp_view.v_ma_kostenstelle_zu_per v02
   ON V01.mandant_id = V02.mandant_id
   AND V01.mitarbeiter_id = V02.mitarbeiter_id
   AND V01.kjmo = V02.kjmo

   WHERE v01.lohnart_id = '2704'
   GROUP BY 1,2,3,4,6
   )  v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.mitarbeiter_id = v02.mitarbeiter_id
   AND v01.kjmo = v02.kjmo

   JOIN dbp_msi_view_shr.mv_monat v03
   ON     v01.kjmo              = v03.kjmo
   LEFT JOIN dbp_view.v_ma_kostenstelle_zu_per v04
   ON     v01.mitarbeiter_id = v04.mitarbeiter_id
   AND   v03.kjmo_vm        = v04.kjmo
   AND   v01.mandant_id    = v04.mandant_id
   LEFT JOIN dbp_view.v_mitarbeiterbew v99
   ON     v01.mitarbeiter_id = v99.mitarbeiter_id
   AND   v03.kjmo               = v99.kjmo
   AND   v01.mandant_id    = v99.mandant_id

   GROUP BY
   1,2,3,4,5,6,8
   ) z1

   UNION ALL
   -- K.Kaiser 20140827 -- hier werden nur die Austritte intern pro MA und Monat ermittelt
   --                                     (falls vorhanden) mit der alten Kostenstelle_id
   SELECT
   v05. mandant_id, v05.mitarbeiter_id, v05.kjmo, v05.kostenstelle_id,  '9999-999' AS kostenstelle_id_alt, 0 AS haupt_kst_fg, NULL AS stunden_lohnart_2704, 1 AS kst_wechsel, v05.austritt_intern

   FROM dbp_msi_view_shr.mv_ma_kostenstelle_austr_int v05

   GROUP BY
   1,2,3,4,5,6,8,9
   ;