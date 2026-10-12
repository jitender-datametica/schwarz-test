create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_BACKPLAN_DENORM_1(
	MANDANT_ID,
	KL_ART_NR,
	ART_BACKEN_BEZ,
	ART_ID,
	WUP_ID,
	NB_ID,
	LOESCH_ID,
	LISTUNG_ID,
	AKTION_FG,
	ART_AKTION_ID,
	OFEN_TYP_ID,
	ANZ_OFEN,
	ANZ_BACKBLECH,
	BACK_PROGRAMM_ID,
	BACK_DAUER,
	BACK_HINWEIS_ID,
	BACK_HINWEIS_BEZ,
	BACK_AUFBEREITUNG_ID,
	BACK_AUFBEREITUNG_BEZ,
	BLECH_BELEGUNG,
	BB,
	DAT,
	MENGE_CHECK,
	MENGE_AVG,
	FAKTOR,
	MENGE_PROG_ORG,
	MENGE_PROG,
	MENGE_PROG01,
	MENGE_PROG02,
	MENGE_PROG03,
	MENGE_PROG04,
	MENGE_PROG12,
	BLECH_PROG01,
	BLECH_PROG02,
	BLECH_PROG03,
	BLECH_PROG12,
	BLECH_PROG,
	BLECH_RUND01,
	BLECH_RUND02,
	BLECH_RUND03,
	BLECH_RUND12,
	LANGSAM,
	STD,
	ULD,
	MIN_SICHERH_BESTAND,
	MIN_REST,
	REST01,
	BLECH01S,
	REST02,
	BLECH02S,
	REST03,
	BLECH03S,
	BLECH04S,
	REST12,
	BLECH01U,
	BLECH03U,
	BLECH01,
	BLECH02,
	BLECH03,
	BLECH04,
	MENGE01,
	MENGE02,
	MENGE03,
	MENGE04
) as
   -- Backplanung denormalisiert : Artikel_1 - Tag_1 - Filiale
   -- 2014-05-12 : Version05, Aggregat; Inner Join Backdaten; Logik verfeinert
   -- 2014-05-21 : Finetuning Logik; PROD-Version
   -- 2014-06-24 : Anpassung Join Backzeit/Lieferant
   -- 2014-06-27 : Korrektur Formel ULD
   -- 2015-06-19 2015KW26 : KMO. kl_art_nr 8stellig. Anpassung Mandant_1/Sprache/Joins. Join art_spr_zu_1 entfernt.
   -- 2016-06-07 : Korrektur Zahlenformat auf Decimal(18,3), Anpassung Formeln/Logik bei 'neuen' Artikeln (menge_avg=0)

   SELECT
   bp.mandant_id, TO_VARCHAR((CASE WHEN bp.mandant_id=1 THEN (bp.art_id/100) ELSE (bp.art_id/10) END), 'FM00000000')  AS kl_art_nr, absz.art_backen_bez, bp.art_id           -- VK_1-Artikel_1
   , bp.wup_id, bp.nb_id AS nb_id, ''::CHAR(1) AS loesch_id, bp.listung_id, bp.aktion_fg, bp.aktion_fg AS art_aktion_id -- ausbauen
   , back.ofen_typ_id, back.anz_ofen, back.anz_backblech, back.back_programm_id, back.back_dauer, back.back_hinweis_id, back.back_hinweis_bez, back.back_aufbereitung_id, COALESCE(back.back_aufbereitung_bez,'')                         AS back_aufbereitung_bez, back.blech_belegung                                                              -- Anzahl Artikel_1 pro Blech
   , COALESCE(back.blech_belegung, 1)                                AS bb            -- fuer Berechnung
   , bp.dat, bp.menge_check                                                  AS menge_check   -- durchschn. Menge/Abverkauf bis 16h
   , bp.anteil_01 + bp.anteil_02 + bp.anteil_03 + bp.anteil_04       AS menge_avg     -- durchschn. Menge/Abverkauf Tag_1
   , bp.menge_prognose / CASE WHEN menge_avg = 0 THEN null ELSE menge_avg END                       AS faktor        -- Faktor Prognose/Abverkauf
   , bp.menge_prognose::DECIMAL(18,3)                               AS menge_prog_org -- Prognose Tag_1 (wie gespeichert) FuR
   , 0.999 + bp.menge_prognose::INTEGER                             AS menge_prog    -- Prognose Tag_1 (aufgerundet) FuR
   , COALESCE(bp.anteil_01 * faktor, menge_prog_org)::DECIMAL(18,3) AS menge_prog01  -- Prognose Backintervall 01 (Tagswert wenn keine Verteilung)
   , COALESCE(bp.anteil_02 * faktor, 0)::DECIMAL(18,3)              AS menge_prog02  -- Prognose Backintervall 01 (0 wenn keine Verteilung)
   , COALESCE(bp.anteil_03 * faktor, 0)::DECIMAL(18,3)              AS menge_prog03  -- Prognose Backintervall 01 (0 wenn keine Verteilung)
   , COALESCE(bp.anteil_04 * faktor, 0)::DECIMAL(18,3)              AS menge_prog04  -- Prognose Backintervall 01 (0 wenn keine Verteilung)
   , menge_prog01 + menge_prog02                                     AS menge_prog12  -- Prognose Ultralangsam 1+2
   , menge_prog01 / bb::DECIMAL(18,3)                               AS blech_prog01, menge_prog02 / bb::DECIMAL(18,3)                             AS blech_prog02,  menge_prog03 / bb::DECIMAL(18,3)                              AS blech_prog03, menge_prog12 / bb::DECIMAL(18,3)                              AS blech_prog12, bp.menge_prognose / bb::DECIMAL(18,3)                         AS blech_prog, 0.999 + blech_prog01::INTEGER                                 AS blech_rund01, 0.999 + blech_prog02::INTEGER                                 AS blech_rund02, 0.999 + blech_prog03::INTEGER                                 AS blech_rund03, 0.999 + blech_prog12::INTEGER                                 AS blech_rund12, 4::BYTEINT                                                     AS langsam       -- Schwellwert Ultralangsamdreher (4 Bleche/Tag_1)
   , CASE WHEN blech_prog <= langsam THEN 0 ELSE 1 END::BYTEINT     AS STD           -- STanDard > 4 Blech
   , CASE WHEN blech_prog <= langsam THEN 1 ELSE 0 END::BYTEINT     AS ULD           -- UltraLangsamDreher <= 4 Blech
   , bp.min_sicherh_bestand                                                           -- Mindestbestand >> aktuell nicht verwendet
   , blech_prog - (bp.min_sicherh_bestand / bb)                      AS min_rest      -- aktuell nicht verwendet
   , (blech_prog - blech_rund01) AS rest01, CASE
   WHEN menge_avg = 0 THEN menge_prog / bb  -- Ausnahme_1 bei fehlender Historie
   WHEN rest01 >= blech_rund01 THEN blech_rund01
   WHEN rest01 >= blech_prog01 THEN blech_prog01
   ELSE rest01
   END AS blech01s, (blech_prog - blech01s) AS rest02, CASE
   WHEN menge_avg = 0 THEN 0.000  -- Ausnahme_1 bei fehlender Historie
   WHEN rest02 >= blech_rund02 THEN blech_rund02
   WHEN rest02 >= blech_prog02 THEN blech_prog02
   ELSE rest02 END AS blech02s, (blech_prog - (blech01s + blech02s)) AS rest03, CASE
   WHEN menge_avg = 0 THEN 0.000  -- Ausnahme_1 bei fehlender Historie
   WHEN rest03 >= blech_rund03 THEN blech_rund03
   WHEN rest03 >= blech_prog03 THEN blech_prog03
   ELSE rest03 END AS blech03s, CASE
   WHEN menge_avg = 0 THEN 0.000  -- Ausnahme_1 bei fehlender Historie
   ELSE (blech_prog - (blech01s + blech02s + blech03s))
   END AS blech04s, (blech_prog - blech_rund12) AS rest12, CASE
   WHEN blech_rund12 <= blech_prog THEN blech_rund12
   WHEN blech_prog12 <= blech_prog12 THEN blech_prog12
   ELSE 0 END AS blech01u, (blech_prog - blech01u) AS blech03u, STD * blech01s + ULD * blech01u  AS blech01, STD * blech02s                   AS blech02, STD * blech03s + ULD * blech03u  AS blech03, STD * blech04s                   AS blech04, 0.999 + (blech01 * bb)::INTEGER AS menge01, 0.999 + (blech02 * bb)::INTEGER AS menge02, CASE
   WHEN menge_prog - (menge01 + menge02 + (blech03 * bb)) < 0 THEN 0
   ELSE 0.999
   END + (blech03 * bb)::INTEGER AS menge03 -- Rundungskorrektur
   , 0.999 + menge_prog - (menge01 + menge02 + menge03)::INTEGER AS menge04
   FROM dbp_msi_v_view.v_backshop_prognose_1 bp

   JOIN dbp_view.v_art_backen_spr_zu_1 absz  -- Bezeichnung Backartikel

   ON bp.art_id = absz.art_id
   AND bp.mandant_id = absz.mandant_id
   AND ((absz.mandant_id=1 AND absz.spr_id=22) OR (absz.mandant_id<>1 AND absz.spr_id<>22))

   JOIN
   ( -- Backshop-Ofen-Artikel_1
   SELECT
   wbp.mandant_id, wbp.wup_id, wbp.anz_ofen, aoz.art_id, aoz.ofen_typ_id, lo.anz_backblech, aoz.blech_belegung, abz.back_programm_id, lb.back_dauer, lb.gp_backen_bez -- NEU Lieferant (nur bei manchen Programmen)
   , abhz.back_hinweis_id, bhsz.back_hinweis_bez, abaz.back_aufbereitung_id, basz.back_aufbereitung_bez
   FROM dbp_view.v_wup_backshop_per_1 wbp

   JOIN dbp_view.v_art_ofentyp_zu_1 aoz
   ON wbp.mandant_id = aoz.mandant_id
   AND wbp.ofen_typ_id = aoz.ofen_typ_id

   JOIN dbp_view.v_l_ofentyp_1 lo
   ON wbp.mandant_id = lo.mandant_id
   AND wbp.ofen_typ_id = lo.ofen_typ_id

   JOIN dbp_view.v_art_backprogramm_zu_1 abz
   ON aoz.mandant_id = abz.mandant_id
   AND aoz.art_id = abz.art_id

   JOIN dbp_view.v_l_backzeit_1 lb
   ON wbp.mandant_id = lb.mandant_id
   AND wbp.ofen_typ_id = lb.ofen_typ_id
   AND abz.back_programm_id = lb.back_programm_id
   AND (wbp.gp_backen_bez = lb.gp_backen_bez OR lb.gp_backen_bez = '') -- NEU Lieferantenabhaengig

   JOIN dbp_view.v_art_back_aufbereitung_zu_1 abaz
   ON aoz.mandant_id = abaz.mandant_id
   AND aoz.art_id = abaz.art_id
   JOIN dbp_view.v_back_aufbereitung_spr_zu_1 basz
   ON aoz.mandant_id = basz.mandant_id
   AND abaz.back_aufbereitung_id = basz.back_aufbereitung_id

   JOIN dbp_view.v_art_back_hinweis_zu_1 abhz
   ON aoz.mandant_id = abhz.mandant_id
   AND aoz.art_id = abhz.art_id
   JOIN dbp_view.v_back_hinweis_spr_zu_1 bhsz
   ON aoz.mandant_id = bhsz.mandant_id
   AND abhz.back_hinweis_id = bhsz.back_hinweis_id

   WHERE wbp.nb_id = 0
   AND wbp.dat_bis = '9999-12-31'
   ) back
   ON  bp.art_id = back.art_id
   AND bp.mandant_id = back.mandant_id
   AND bp.wup_id = back.wup_id;
