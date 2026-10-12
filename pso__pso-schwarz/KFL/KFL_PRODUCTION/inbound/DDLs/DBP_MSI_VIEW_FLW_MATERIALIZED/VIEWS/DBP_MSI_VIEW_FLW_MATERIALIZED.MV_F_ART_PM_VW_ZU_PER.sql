create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_ART_PM_VW_ZU_PER(
	ART_ID,
	PM_ID,
	VW_ID,
	MANDANT_ID,
	DAT_BIS,
	DAT_VON,
	PREISTYP_ID,
	VK_BRUTTO
) as
   SELECT -- alle mit preistyp_id = 0
   --zu jedem moeglichen pm.dat_von pruefen ob es einen gueltigen datensatz pro pm gibt, in dem man testet, ob er zwischen dat_von und dat_bis liegt

   v01.art_id, v01.pm_id, v01.vw_id, v01.mandant_id, pm.dat_von AS dat_bis -- nicht benoetigt
   , pm.dat_von, v01.preistyp_id, CAST(
   CASE
   -- Tabelle liefert immer Landeswaehrung, User will aber Euro -> umrechnen
   WHEN  v200.wrg_typ_id = 0
   THEN v01.vk_brutto * v500.umrechnungskurs
   -- Tabelle liefert immer Landeswaehrung, User will auch Landeswaehrung -> passt
   WHEN  v200.wrg_typ_id = 1
   THEN v01.vk_brutto
   END
   AS DECIMAL(15,3))
   AS vk_brutto

   FROM dbp_view.v_art_pm_vw_zu_per v01

   JOIN
   (
   SELECT --pro artikel alle dat_von mit preistyp 0 ermitteln unabhaengig von pm und vw, ohne duplikate.
   v01.art_id, v01.mandant_id, v01.dat_von
   FROM dbp_view.v_art_pm_vw_zu_per v01
   WHERE v01.preistyp_id = 0
   --      AND art_id = 5107800  -- TEST
   GROUP BY 1,2,3
   ) pm
   ON  v01.art_id = pm.art_id
   AND v01.mandant_id = pm.mandant_id
   AND pm.dat_von BETWEEN v01.dat_von AND v01.dat_bis

   JOIN dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300
   LEFT OUTER JOIN dbp_view.v_kurs v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v100.default_wrg = v500.von_wrg_id -- Von WRG ist immer Landeswrg in dieser Tabelle
   AND v500.nach_wrg_id ='EUR'
   AND v01.dat_von BETWEEN v500.dat_von AND v500.dat_bis

   WHERE v01.preistyp_id = 0
   AND v01.vk_brutto IS NOT NULL
   --         AND v01.art_id = 5107800 --  AND v01.vw_id = 1  -- TEST



   UNION ALL



   SELECT -- preistyp_id = 1 aber in Zeitintervallen von preistyp_id = 0

   v01.art_id, v01.pm_id, v01.vw_id, v01.mandant_id, pm.dat_bis, pm.dat_von, v02.preistyp_id, MAX( CAST(
   CASE
   -- Tabelle liefert immer Landeswaehrung, User will aber Euro -> umrechnen
   WHEN  v200.wrg_typ_id = 0
   THEN v02.vk_brutto * v500.umrechnungskurs
   -- Tabelle liefert immer Landeswaehrung, User will auch Landeswaehrung -> passt
   WHEN  v200.wrg_typ_id = 1
   THEN v02.vk_brutto
   END
   AS DECIMAL(15,3)))
   AS vk_brutto

   FROM dbp_view.v_art_pm_vw_zu_per v01
   INNER JOIN -- die Datensaetze aus v01 mit preistyp 0 mit allen moeglichen dat_von kombinieren, unabhaengig von pm oder vw
   (
   SELECT -- alle moeglichen dat_von mit preistyp 0 ermitteln (entspricht dem subselect), hier noch das dat_bis ermitteln. dieses ist immer einen Tag vor dem letzten dat_von des folgenden Datensatzes.
   -- nur beim letzten Datensatz wird dann per coalesce das tatsaechliche dat_bis aus der Tabelle ausgegeben (als dat_letzter)
   datum.art_id,
   datum.mandant_id,
   datum.dat_von,
   COALESCE(     -- dat_bis = dat_von -1 vom Folgesatz chronologisch geordnet
   MAX(datum.dat_von) OVER (PARTITION BY datum.art_id,  datum.mandant_id ORDER BY datum.dat_von ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) -1,  datum.dat_letzter
   ) AS dat_bis
   FROM
   (
   SELECT --pro artikel alle dat_von mit preistyp 0 ermitteln unabhaengig von pm und vw, ohne duplikate. (dat_letzter nur informativ fuer letzten Datensatz)
   v01.art_id, v01.mandant_id, v01.dat_von, MAX(v01.dat_bis) AS dat_letzter -- nur fuer letzten Datensatz
   FROM dbp_view.v_art_pm_vw_zu_per v01
   WHERE v01.preistyp_id = 0                                                                               --    AND art_id = 5107800 -- TEST
   GROUP BY 1,2,3
   ) datum
   ) pm
   ON  v01.art_id = pm.art_id
   AND v01.mandant_id = pm.mandant_id
   AND pm.dat_von BETWEEN v01.dat_von AND v01.dat_bis
   INNER JOIN -- die Datensaetze mit preistyp 1 auf jeden Tag vervielfaeltigen und pruefen, ob sie in einem Intervall von preistyp 0 liegen.
   -- am Ende Group by, damit trotz Tagesebene am Schluss nur ein Datensatz pro Intervall uebrig bleibt.
   (
   SELECT
   z01.art_id, z01.pm_id, z01.vw_id, z01.mandant_id, z01.dat_bis, z01.dat_von, t.dat, z01.preistyp_id, z01.vk_brutto
   FROM dbp_view.v_art_pm_vw_zu_per z01
   JOIN dbp_view.v_tag t
   ON t.dat BETWEEN z01.dat_von AND z01.dat_bis
   WHERE  z01.preistyp_id = 1             --  AND art_id = 5107800 -- TEST
   AND vk_brutto IS NOT NULL
   ) v02
   ON v01.art_id = v02.art_id
   AND v01.pm_id = v02.pm_id
   AND v01.vw_id = v02.vw_id
   AND v01.mandant_id = v02.mandant_id
   AND v02.dat BETWEEN pm.dat_von AND pm.dat_bis


   JOIN dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300
   LEFT OUTER JOIN dbp_view.v_kurs v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v100.default_wrg = v500.von_wrg_id -- Von WRG ist immer Landeswrg in dieser Tabelle
   AND v500.nach_wrg_id ='EUR'
   AND v01.dat_von BETWEEN v500.dat_von AND v500.dat_bis

   WHERE v01.preistyp_id = 0             --          AND v01.art_id = 5107800 -- TEST

   GROUP BY 1,2,3,4,5,6,7



   UNION ALL



   SELECT -- preistyp_id = 2 aber in Zeitintervallen von preistyp_id = 0 (entspricht genau dem oberen Block nur mit anderer Filterung auf preistyp_id)

   v01.art_id, v01.pm_id, v01.vw_id, v01.mandant_id, pm.dat_bis, pm.dat_von, v02.preistyp_id, MAX( CAST(
   CASE
   -- Tabelle liefert immer Landeswaehrung, User will aber Euro -> umrechnen
   WHEN  v200.wrg_typ_id = 0
   THEN v02.vk_brutto * v500.umrechnungskurs
   -- Tabelle liefert immer Landeswaehrung, User will auch Landeswaehrung -> passt
   WHEN  v200.wrg_typ_id = 1
   THEN v02.vk_brutto
   END
   AS DECIMAL(15,3)))
   AS vk_brutto

   FROM dbp_view.v_art_pm_vw_zu_per v01
   INNER JOIN -- die Datensaetze aus v01 mit preistyp 0 mit allen moeglichen dat_von kombinieren, unabhaengig von pm oder vw
   (
   SELECT -- alle moeglichen dat_von mit preistyp 0 ermitteln (entspricht dem subselect), hier noch das dat_bis ermitteln. dieses ist immer einen Tag vor dem letzten dat_von des folgenden Datensatzes.
   -- nur beim letzten Datensatz wird dann per coalesce das tatsaechliche dat_bis aus der Tabelle ausgegeben (als dat_letzter)
   datum.art_id,
   datum.mandant_id,
   datum.dat_von,
   COALESCE(     -- dat_bis = dat_von -1 vom Folgesatz chronologisch geordnet
   MAX(datum.dat_von) OVER (PARTITION BY datum.art_id,  datum.mandant_id ORDER BY datum.dat_von ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) -1,  datum.dat_letzter
   ) AS dat_bis
   FROM
   (
   SELECT --pro artikel alle dat_von mit preistyp 0 ermitteln unabhaengig von pm und vw, ohne duplikate. (dat_letzter nur informativ fuer letzten Datensatz)
   v01.art_id, v01.mandant_id, v01.dat_von, MAX(v01.dat_bis) AS dat_letzter -- nur fuer letzten Datensatz
   FROM dbp_view.v_art_pm_vw_zu_per v01
   WHERE v01.preistyp_id = 0                                                                               --    AND art_id = 5107800 -- TEST
   GROUP BY 1,2,3
   ) datum
   ) pm
   ON  v01.art_id = pm.art_id
   AND v01.mandant_id = pm.mandant_id
   AND pm.dat_von BETWEEN v01.dat_von AND v01.dat_bis
   INNER JOIN -- die Datensaetze mit preistyp 2 auf jeden Tag vervielfaeltigen und pruefen, ob sie in einem Intervall von preistyp 0 liegen.
   -- am Ende Group by, damit trotz Tagesebene am Schluss nur ein Datensatz pro Intervall uebrig bleibt.
   (
   SELECT
   z01.art_id, z01.pm_id, z01.vw_id, z01.mandant_id, z01.dat_bis, z01.dat_von, t.dat, z01.preistyp_id, z01.vk_brutto
   FROM dbp_view.v_art_pm_vw_zu_per z01
   JOIN dbp_view.v_tag t
   ON t.dat BETWEEN z01.dat_von AND z01.dat_bis
   WHERE  z01.preistyp_id = 2             --  AND art_id = 5107800 -- TEST
   AND vk_brutto IS NOT NULL
   ) v02
   ON v01.art_id = v02.art_id
   AND v01.pm_id = v02.pm_id
   AND v01.vw_id = v02.vw_id
   AND v01.mandant_id = v02.mandant_id
   AND v02.dat BETWEEN pm.dat_von AND pm.dat_bis


   JOIN dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300
   LEFT OUTER JOIN dbp_view.v_kurs v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v100.default_wrg = v500.von_wrg_id -- Von WRG ist immer Landeswrg in dieser Tabelle
   AND v500.nach_wrg_id ='EUR'
   AND v01.dat_von BETWEEN v500.dat_von AND v500.dat_bis

   WHERE v01.preistyp_id = 0             --          AND v01.art_id = 5107800 -- TEST

   GROUP BY 1,2,3,4,5,6,7;