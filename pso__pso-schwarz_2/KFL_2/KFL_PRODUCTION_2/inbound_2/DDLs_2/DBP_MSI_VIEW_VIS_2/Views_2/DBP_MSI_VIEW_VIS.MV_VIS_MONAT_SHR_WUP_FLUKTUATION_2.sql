CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_SHR_WUP_FLUKTUATION_2 as
   -- FAKT-AGGREGAT
   -- Fluktuation / Anzahl MA pro Filiale/Monat_2 und Cluster  aus SHR + VIS Monat_2 Agg
   -- 2017.1109 ssch0611 : Intial. VIS Monat_2 Agg (Basis) ohne 13. Periode, mitarbeiterbew_2 Zeitflag, SHR Basisdaten
   -- 2018.0122 ssch0611 : wrg_id ergaenzt (fuer korrekten join mit restl. vis)

   SELECT
   sub_kstl.mandant_id, sub_kstl.nb_id, sub_kstl.wup_id, sub_kstl.wrg_id, sub_kstl.kjmo, COALESCE(sub_kstl.rank_kjmo, sub_kstl.akt_mo + 1) AS akt_mo_shr, COUNT(DISTINCT mitarbeiter_id) AS ma_count, SUM(ma_ein)                    AS ma_eintritt, SUM(ma_aus)                    AS ma_austritt, SUM(ma_knd)                    AS ma_kuendigung, ma_count - ma_austritt         AS ma_anzahl, SUM(aus_00_03)                 AS austritt_00_03, SUM(mo_00_03 - aus_00_03)      AS monate_00_03, SUM(aus_03_06)                 AS austritt_03_06, SUM(mo_03_06 - aus_03_06)      AS monate_03_06, SUM(aus_06_12)                 AS austritt_06_12, SUM(mo_06_12 - aus_06_12)      AS monate_06_12, SUM(aus_12_36)                 AS austritt_12_36, SUM(mo_12_36 - aus_12_36)      AS monate_12_36, SUM(aus_36x)                   AS austritt_36, SUM(mo_36x - aus_36x)          AS monate_36

   FROM ( -- Mapping wup_2 - Zeit_2 - kostenstelle
   SELECT
   vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.kjmo, vis.akt_mo, shr_mo.rank_kjmo, kstl.kostenstelle_id
   FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_2 vis
   LEFT JOIN ( -- Zeit_2/Berichtsmonat
   SELECT mabew.kjmo, 0 - (RANK() OVER (ORDER BY mabew.kjmo DESC NULLS LAST)) AS rank_kjmo
   FROM (SELECT DISTINCT kjmo FROM dbp_view.v_mitarbeiterbew_2) mabew
   ) shr_mo
   ON shr_mo.kjmo = vis.kjmo
   LEFT JOIN ( -- Kostenstelle
   SELECT
   mandant_id, kostenstelle_id, TO_NUMBER(geschaeftsbereich_id) gsb, TO_NUMBER(SUBSTRING(pc_id, 3, 4)) pc, COALESCE(gsb, pc, 0)::INTEGER AS wup_id
   FROM dbp_view.v_in_kostenstelle_per_2
   WHERE (mandant_id, krk_id, kostenstelle_id, dat_von)
   IN (SELECT mandant_id, krk_id, kostenstelle_id, MAX(dat_von) dat_von FROM dbp_view.v_in_kostenstelle_per_2 GROUP BY 1, 2, 3)
   ) kstl
   ON kstl.mandant_id = vis.mandant_id
   AND kstl.wup_id = vis.wup_id

   WHERE vis.nb_id IN (-1, 0)
   AND (MOD(vis.kjmo, 100)) <> 13 -- ohne 13. Periode
   ) sub_kstl
   LEFT JOIN ( -- MA Daten pro Kostenstelle
   SELECT
   mak.mandant_id, mak.kostenstelle_id, mak.kjmo, mak.mitarbeiter_id, ( ADD_MONTHS(mak.dat_von,1)-1 + 1) - mad.dat_von AS ma_tage_check, COALESCE( mahm.dat_von, ADD_MONTHS(mak.dat_von,1)-1 + 1) - mad.dat_von AS ma_tage, CASE WHEN mad.dat_von BETWEEN mak.dat_von AND ADD_MONTHS(mak.dat_von,1)-1 THEN 1 ELSE 0 end   AS ma_ein, CASE WHEN mad1.dat_von BETWEEN mak.dat_von AND ADD_MONTHS(mak.dat_von,1)-1 THEN 1 ELSE 0 end AS ma_knd, CASE WHEN hr_massnahme_id = '04' THEN 1 ELSE 0 end                           AS ma_aus, CASE WHEN ma_tage <   90 THEN 1 ELSE 0 END                AS mo_00_03, CASE WHEN ma_tage BETWEEN   90 AND  179 THEN 1 ELSE 0 END AS mo_03_06, CASE WHEN ma_tage BETWEEN  180 AND  359 THEN 1 ELSE 0 END AS mo_06_12, CASE WHEN ma_tage BETWEEN  360 AND 1079 THEN 1 ELSE 0 END AS mo_12_36, CASE WHEN ma_tage > 1079 THEN 1 ELSE 0 END                AS mo_36x, mo_00_03 * ma_aus                                         AS aus_00_03, mo_03_06 * ma_aus                                         AS aus_03_06, mo_06_12 * ma_aus                                         AS aus_06_12, mo_12_36 * ma_aus                                         AS aus_12_36, mo_36x * ma_aus                                           AS aus_36x, mak.dat_von                                               AS dat_von_mo, ADD_MONTHS(mak.dat_von,1)-1                               AS dat_bis_mo, mad.dat_von                                               AS dat_eintritt, mahm.dat_von                                              AS dat_austritt, mahm.hr_massnahme_grund_id, mahm.hr_massnahme_id, mad1.dat_von                                              AS dat_kuendigung
   FROM dbp_view.v_ma_kostenstelle_zu_per_2 mak
   LEFT JOIN ( -- MA Eintritt
   SELECT
   mad.mandant_id, mad.mitarbeiter_id, mad.kjmo, mad.datumsart_id, mad.dat_von, mad.dat_bis
   FROM dbp_view.v_ma_datumsart_zu_per_2 mad
   WHERE datumsart_id IN ('02') -- Eintritt
   ) mad
   ON mad.mandant_id = mak.mandant_id AND mad.mitarbeiter_id = mak.mitarbeiter_id
   AND mad.kjmo = mak.kjmo
   LEFT JOIN ( -- MA Austritt
   SELECT
   mahm.mandant_id, mahm.mitarbeiter_id, mahm.kjmo, mahm.hr_massnahme_grund_id, mahm.hr_massnahme_id, mahm.dat_von, mahm.dat_bis
   FROM dbp_view.v_ma_hr_massnahme_zu_per_2 mahm
   WHERE hr_massnahme_id IN ('04') -- Austritt
   ) mahm
   ON mahm.mandant_id = mak.mandant_id AND mahm.mitarbeiter_id = mak.mitarbeiter_id
   AND mahm.kjmo = mak.kjmo
   LEFT JOIN ( -- MA Kuendigung
   SELECT
   mad.mandant_id, mad.mitarbeiter_id, mad.kjmo, mad.datumsart_id, mad.dat_von, mad.dat_bis
   FROM dbp_view.v_ma_datumsart_zu_per_2 mad
   WHERE datumsart_id IN ('-1') -- Kuendigung
   ) mad1
   ON mad1.mandant_id = mak.mandant_id AND mad1.mitarbeiter_id = mak.mitarbeiter_id
   AND mad1.kjmo = mak.kjmo
   ) sub_ma
   ON sub_ma.mandant_id = sub_kstl.mandant_id
   AND sub_ma.kostenstelle_id =  sub_kstl.kostenstelle_id
   AND sub_ma.kjmo = sub_kstl.kjmo

   GROUP BY 1,2,3,4,5,6
   ;