create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_MARKTABSCHRIFTEN(
	MANDANT_ID,
	IN_KUNDE_ID,
	KUNDE_NR,
	KUNDE_NAME,
	DAT,
	IN_ART_ID,
	IN_ART_NR,
	ABSCHRIFTEN_FG,
	AUFSCHRIFTEN_FG,
	ABSCHRIFTBETRAG_NETTO,
	AUFSCHRIFTBETRAG_NETTO,
	MENGE_ABSCHRIFT,
	MENGE_AUFSCHRIFT,
	ABSCHRIFTART_ID,
	UMBEW_BELEG_ID,
	WERT_BESTAND_BRUTTO_ALT,
	DIFF_WERT_BESTAND_BRUTTO,
	DIFF_WERT_BESTAND_NETTO,
	VK_BRUTTO_ALT,
	MENGE_ERF,
	MENGE_BESTAND_BME,
	WRG_ID
) as 
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
   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_MARKTABSCHRIFTEN v01 
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300

   JOIN dbp_view.v_mandant_wrg_typ_zu v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.dat BETWEEN v500.dat_von AND v500.dat_bis

   WHERE v01.mandant_id =2

   UNION ALL


   --- Abschriften aus DE

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

   FROM dbp_view.v_marktabschriften v01
   INNER JOIN
   (
   SELECT
   art_id, gewart_id
   FROM dbp_view.v_art
   WHERE mandant_id = 1
   ) v03
   ON v01.art_id = v03.art_id
   INNER JOIN dbp_view.v_art v04
   ON v01.art_id = v04.art_id
   AND v01.mandant_id = v04.mandant_id
   AND v01.dat BETWEEN v04.dat_von AND v04.dat_bis
   INNER JOIN DBP_MSI_VIEW_FLW_MATERIALIZED.mv_l_in_art v05     -- MARA + Retailartikel

   ON v05.art_id = v04.art_id
   AND v05.mandant_id = v04.mandant_id
   LEFT JOIN dbp_view.v_flw_kunde v07
   ON v01.wup_id = v07.wup_id
   AND v01.mandant_id = v07.mandant_id

   WHERE v01.mandant_id=1;