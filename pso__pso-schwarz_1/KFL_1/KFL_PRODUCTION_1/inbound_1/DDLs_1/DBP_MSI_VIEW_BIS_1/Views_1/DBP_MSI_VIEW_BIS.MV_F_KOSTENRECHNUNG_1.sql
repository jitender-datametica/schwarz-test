CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_KOSTENRECHNUNG_1
-- 22.08.2016 twie: SPEC0008548 Kosten summiert pro Land_1, Monat_1 für Management Cockpits, umgerechnet in Euro
--                            Kosten für 'Land_1' INT kommen aus dt. Profit Centern, werden aber unter Mandant_1 99 ausgeben
-- 09.11.2016 twie: SPEC0016203 Filtung und Berechnung angepasst, vorige Logik war nicht korrekt

(
kj_ker_mo_id
,mandant_id
,betrag_gesamtkosten
,betrag_verrechnung_int
,kostenrechnung_betrag
)
AS
   SELECT
   v01.kj_ker_mo_id,
   CASE WHEN v01.pc_id IN ('DE9611-0', 'DE9611-0B', 'DE9611-0DL') THEN 99 ELSE v01.mandant_id END AS mandant_id,
   SUM(CASE WHEN v02.ka_lv4 = 'UGK' THEN  v01.kostenrechnung_betrag * v05.umrechnungskurs END) AS betrag_gesamtkosten,
   SUM(CASE WHEN v02.ka_lv7 = 'U323-4' THEN  v01.kostenrechnung_betrag * v05.umrechnungskurs END) AS betrag_verrechnung_int,
   (COALESCE(betrag_gesamtkosten,0) - COALESCE(betrag_verrechnung_int,0)) * -1 AS kostenrechnung_betrag

  FROM dbp_view.v_kostenrechnung_1 v01
   INNER JOIN dbp_msi_v_view.v_ka_ka_grp_denorm_1 v02
   ON v01.kostenart_id = v02.ka_lv11
   INNER JOIN dbp_view.v_mandant_1 v03
   ON v01.mandant_id=v03.mandant_id
   INNER JOIN
   (
   SELECT
   MAX(dat) AS max_dat,
   kjmo
   FROM dbp_view.v_tag_1
   GROUP BY kjmo
   ) v04
   ON  v01.kj_ker_mo_id = v04.kjmo
   INNER JOIN dbp_view.v_kurs_1 AS v05
   ON   v05.von_wrg_id = v03.default_wrg
   AND v04.max_dat BETWEEN v05.dat_von AND v05.dat_bis
   AND v05.kurstyp_id = 9
   AND v05.nach_wrg_id = 'EUR'

   WHERE

   --Filter auf relevante Profit Center -> 1 pro Land_1 und die letzten 3 DE für INT
   v01.pc_id IN ('DE9111-0', 'CZ9531-0', 'SK9531-0', 'HR9531-0', 'PL9531-0', 'RO9531-0', 'BG9531-0', 'DE9611-0', 'DE9611-0B', 'DE9611-0DL')

   AND v01.plan_fg = 0

   GROUP BY 1,2
;