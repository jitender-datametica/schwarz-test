  CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_MARKTABSCHRIFTEN_2
   -- Angepasst Alex Lipkin
-- Join auf art_gp_zu_per_2 entfernt
-- 14.09.2011 A. Lipkin menge_abschrift   hinzugefuegt
-- 26.10.2011 system_id entfernt
-- 30.11.2011 MR Performance art_id Verbindung
-- 27.09.2013 twie: Abschriften_2 aus CZ, kommen aus anderer Tabelle
-- 07.10.2013 twie: Brutto in Nettobetrag umrechnen fuer CZ abschriftenbetrag
-- 16.10.2013 twie: Join auf in_kunde_2 vereinfacht ueber wup_id
-- 21.10.2013 twie: Join auf in_art_2 jetzt auf MV-VIEW, damit auch reine Retailartikel mitkommen
-- 19.11.2013: MCan: Performanceoptimierung --> Umstellung von UNION auf UNION ALL
-- 21.11.2013 twie: in CZ menge_erf statt menge_umbew als menge_abschrift nehmen und nicht durch 1000 teilen wie in DE
-- 29.01.2014 twie: Waehrungsumrechnung fuer Teil 1 mit CZ, bei Teil 2 DE nicht noetig, da eh immer Euro
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 26.08.2015 twie: fuer abschriftbetrag_netto in CZ nicht den vk_netto_neu, sondern diff_wert_bestand_netto nehmen
-- 23.06.2017 twie: SPEC0015191 Aufschriften fuer DE hinzufuegen, vk_netto_neu entfernt da nicht mehr benutzt
-- 11.07.2017 twie: SPEC0015191 Datentyp aufschriften auf decimal umgestellt
-- 15.11.2017 twie: NSR0027844 in DE sind Ab/aufschriften mit abschriftart_id -1 Werbeabschriften, die im Gegensatz zu normalen Abschriften_2 in KG - nicht in Gramm - erfasst werden, deshalb duerfen sie nicht durch 1000 geteilt werden
-- 22.07.2021 twie: SPEC0109216 ab/aufschriften_menge wird bei KG Artikeln nicht mehr ausschließlich in G erfassst (Division durch 1000) sondern teilweise direkt in KG, in diesem Fall entfällt /1000

 AS 
   SELECT v01.mandant_id, in_kunde_id, kunde_nr,
   kunde_name, dat, in_art_id, in_art_nr, abschriften_fg, aufschriften_fg
   ,  CAST(
   CASE WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.diff_wert_bestand_netto * -1,0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(v01.diff_wert_bestand_netto * -1,0) / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.diff_wert_bestand_netto * -1,0) * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(v01.diff_wert_bestand_netto * -1,0)
   END
   AS DECIMAL(18,2))
   AS abschriftbetrag_netto   -- * -1 da VZ in Fakt wieder gedreht wird
   , CAST (0 AS DECIMAL(18,2)) AS aufschriftbetrag_netto
   , CAST(v01.menge_erf AS DECIMAL(13,4)) AS menge_abschrift
   , CAST(0 AS DECIMAL(13,4)) AS menge_aufschrift
   , v01.preis_aend_grund_id AS abschriftart_id
   , v01.umbew_beleg_id
   ,  CAST(
   CASE WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.wert_bestand_brutto_alt,0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(v01.wert_bestand_brutto_alt,0) / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.wert_bestand_brutto_alt,0) * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(v01.wert_bestand_brutto_alt,0)
   END
   AS DECIMAL(18,2))
   AS wert_bestand_brutto_alt
   ,  CAST(
   CASE WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.diff_wert_bestand_brutto,0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(v01.diff_wert_bestand_brutto,0) / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.diff_wert_bestand_brutto,0) * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(v01.diff_wert_bestand_brutto,0)
   END
   AS DECIMAL(18,2))
   AS diff_wert_bestand_brutto
   ,  CAST(
   CASE WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.diff_wert_bestand_netto,0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(v01.diff_wert_bestand_netto,0) / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.diff_wert_bestand_netto,0) * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(v01.diff_wert_bestand_netto,0)
   END
   AS DECIMAL(18,2))
   AS diff_wert_bestand_netto
   ,  CAST(
   CASE WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.vk_brutto_alt,0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(v01.vk_brutto_alt,0) / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.vk_brutto_alt,0) * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(v01.vk_brutto_alt,0)
   END
   AS DECIMAL(18,2))
   AS vk_brutto_alt
   , v01.menge_erf, v01.menge_bestand_bme
   , v400.wrg_id
   FROM DBP_MSI_VIEW_FLW.TBL_MV_F_MARKTABSCHRIFTEN_2 v01 
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300

   JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs_2 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.dat BETWEEN v500.dat_von AND v500.dat_bis

   WHERE v01.mandant_id =2

   UNION ALL


   --- Abschriften_2 aus DE

   SELECT
   v01.mandant_id, 
   v07.flw_kunde_id AS in_kunde_id, 
   COLLATE(LTRIM(COLLATE(v07.kunde_nr,''),'0'), 'en-ci') AS kunde_nr,
   v07.kunde_name, 
   v01.dat, 
   v05.flw_art_id AS in_art_id, 
   v05.in_art_nr, 
   CASE WHEN v01.abschriftbetrag_netto > 0 THEN 1 ELSE NULL END AS abschriften_fg, 
   CASE WHEN v01.abschriftbetrag_netto < 0 THEN 1 ELSE NULL END AS aufschriften_fg, 
   v01.abschriftbetrag_netto * abschriften_fg AS abschriftbetrag_netto, 
   v01.abschriftbetrag_netto * aufschriften_fg AS aufschriftbetrag_netto, 
   CASE WHEN v04.gewart_id = 'KG' AND v01.abschrift_menge_einh_id = 'G' AND abschriftart_id <> -1 THEN ( CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000) * abschriften_fg
   ELSE CAST(v01.menge_abschrift AS DECIMAL(13,4)) * abschriften_fg
   END AS menge_abschrift, 
   CASE WHEN v04.gewart_id = 'KG' AND v01.abschrift_menge_einh_id = 'G' AND abschriftart_id <> -1 THEN ( CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000) * aufschriften_fg
   ELSE CAST(v01.menge_abschrift AS DECIMAL(13,4)) * aufschriften_fg
   END AS menge_aufschrift, 
   v01.abschriftart_id, 
   -1 AS umbew_beleg_id, 
   NULL AS wert_bestand_brutto_alt, 
   NULL AS diff_wert_bestand_brutto, 
   NULL AS diff_wert_bestand_netto, 
   NULL AS vk_brutto_alt, 
   NULL AS menge_erf, 
   NULL AS menge_bestand_bme, 
   v01.wrg_id

   FROM dbp_view.v_marktabschriften_2 v01
   INNER JOIN
   (
   SELECT
   art_id, gewart_id
   FROM dbp_view.v_art_2
   WHERE mandant_id = 1
   ) v03
   ON v01.art_id = v03.art_id
   INNER JOIN dbp_view.v_art_2 v04
   ON v01.art_id = v04.art_id
   AND v01.mandant_id = v04.mandant_id
   AND v01.dat BETWEEN v04.dat_von AND v04.dat_bis
   INNER JOIN dbp_msi_view_flw.mv_l_in_art_2 v05     -- MARA_2 + Retailartikel

   ON v05.art_id = v04.art_id
   AND v05.mandant_id = v04.mandant_id
   LEFT JOIN dbp_view.v_flw_kunde_2 v07
   ON v01.wup_id = v07.wup_id
   AND v01.mandant_id = v07.mandant_id

   WHERE v01.mandant_id=1;