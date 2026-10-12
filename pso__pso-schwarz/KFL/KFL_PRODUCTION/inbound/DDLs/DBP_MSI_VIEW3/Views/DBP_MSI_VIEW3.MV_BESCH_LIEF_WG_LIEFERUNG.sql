CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_LIEF_WG_LIEFERUNG(
	WUP_ID,
	NB_ID,
	ART_ID,
	WG_ID,
	OWG_ID,
	ARTHIERTYP_ID,
	LAGERNUMMER_ID,
	MANDANT_ID,
	DAT_LIEF_SOLL,
	WERBEWARE_ID,
	BESTELLART_ID,
	LIEF_TYP_ID,
	LIEF_PAL_TYP_ID,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	LIEF_BELEG_ID,
	LIEF_BELEG_POS_ID,
	KJ,
	AUSLIEFERUNGSGRUPPE_ID,
	MENGE_LIEF_SOLL_KOLLI,
	MENGE_LIEF_IST_KOLLI
) 
--04.08.2021, AP0101988, SPEC0121842, dknop, initial based on logic from nwagner
--06.09.2021,  AP0101988, SPEC0121842, dknop, updating kunde_id
--18.10.2021, AP0101988, SPEC0121842, dknop, left join and COLAESCE for auslieferungsgruppe_id
--22.10.2021, AP0101988, SPEC0121842, dknop, likp.mandant_id_kunde=marc.mandant_id
--25.10.2021, AP0101988, SPEC0121842, dknop, removing duplicated rows from wup_kunde_wg_disporhythmus_lft_zu_per
--26.10.2021,AP0101988, SPEC0121842, dknop, adding missing join to dat_lief_soll for dbp_view.v_wg_per
-- 2022-03-22, AP0101988, dknop, New way to determine Ausliefergruppe 
-- 2024-01-31, INC7963291, dknop, change kunde_id
--2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-09-09, dknop, change to left join with dbp_view.v_wup
AS
SELECT 
 lips.wup_id
,lips.nb_id
,marc.art_id
,wg.wg_id
,wg.owg_id
,wg.arthiertyp_id
,likp.lagernummer_id
,lips.mandant_id
,likp.dat_lief_soll
,likp.werbeware_id
,lips.bestellart_id
,likp.lief_typ_id
,likp.lief_pal_typ_id
,likp.mandant_id_kunde
--,CASE WHEN TRY_CAST(likp.kunde_id AS INTEGER) IS NULL THEN -3 ELSE TRY_CAST(likp.kunde_id AS INTEGER) END AS kunde_id
,CASE WHEN TRY_CAST(likp.kunde_id AS INTEGER) IS NULL THEN -3 ELSE w.aktuell_wup_id END  AS kunde_id
,lips.lief_beleg_id
,lips.lief_beleg_pos_id
,lips.kj
,COALESCE(art_ausl.auslieferungsgruppe_id,COALESCE( wg_ausl.auslieferungsgruppe_id,'-1')) AS auslieferungsgruppe_id 
,lips.menge_lief_soll_kolli
,lips.menge_lief_ist_kolli

FROM dbp_view.v_besch_lief_det lips

JOIN dbp_view.v_besch_lief likp 
ON  lips.mandant_id=likp.mandant_id
AND lips.lief_beleg_id=likp.lief_beleg_id
AND lips.dat_lief_soll=likp.dat_lief_soll

LEFT JOIN dbp_view.v_wup w
   ON w.mandant_id = CASE WHEN likp.mandant_id_kunde IS NULL OR likp.mandant_id_kunde = 0 THEN likp.mandant_id ELSE likp.mandant_id_kunde END
   AND w.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))

JOIN dbp_view.v_art_wup_status_per marc
ON  likp.mandant_id_kunde=marc.mandant_id
AND lips.art_id=marc.art_id
AND TRY_CAST(likp.kunde_id AS INT) = marc.wup_id
AND likp.dat_lief_soll BETWEEN marc.dat_von AND marc.dat_bis

JOIN dbp_view.v_art_vorschlagswert_per maw1  
ON  lips.mandant_id = maw1.mandant_id 
AND lips.art_id = maw1.art_id 
AND lips.dat_lief_soll BETWEEN maw1.dat_von AND maw1.dat_bis 

JOIN dbp_view.v_art_wg_zu_per awg  
ON lips.mandant_id = awg.mandant_id 
AND lips.art_id = awg.art_id 
AND lips.dat_lief_soll BETWEEN awg.dat_von AND awg.dat_bis 
AND awg.arthiertyp_id=2 

LEFT JOIN dbp_view.v_art_auslieferungsgruppe_per art_ausl 
ON lips.mandant_id = art_ausl.mandant_id 
AND lips.art_id = art_ausl.art_id 
AND lips.dat_lief_soll BETWEEN art_ausl.dat_von AND art_ausl.dat_bis 

LEFT JOIN dbp_view.v_wg_auslieferungsgruppe_per wg_ausl 
ON lips.mandant_id = wg_ausl.mandant_id 
AND awg.wg_id = wg_ausl.wg_id 
AND CASE WHEN wg_ausl.sortimentslistenart_id = '' THEN '' ELSE maw1.sortimentslistenart_id END =wg_ausl.sortimentslistenart_id 
AND lips.dat_lief_soll BETWEEN wg_ausl.dat_von AND wg_ausl.dat_bis 

JOIN dbp_view.v_wg_per wg
ON awg.wg_id=wg.wg_id
AND awg.mandant_id=wg.mandant_id
AND likp.dat_lief_soll BETWEEN wg.dat_von AND wg.dat_bis

/*LEFT JOIN (SELECT  v01_1.mandant_id
    ,v01_1.wup_id
    ,v01_1.nb_id
    ,v01_1.mandant_id AS mandant_id_kunde
    ,v01_1.kunde_id
    ,v01_1.auslieferungsgruppe_id
    ,v01_1.terminierungsgruppe_1_id
    ,v01_1.terminierungsgruppe_2_id
    ,v01_1.terminierungsgruppe_3_id
    ,v01_1.disposition_rhythmus_ltf_id
    ,v01_1.wg_id
    ,v01_1.arthiertyp_id
    ,v01_1.dat_von
    ,v01_1.dat_bis
  FROM dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per v01_1
  QUALIFY ROW_NUMBER() OVER (PARTITION BY v01_1.mandant_id
         ,v01_1.wup_id
         ,v01_1.nb_id
         ,v01_1.kunde_id
         ,v01_1.wg_id
         ,v01_1.arthiertyp_id
         ,v01_1.terminierungsgruppe_1_id
         ,v01_1.terminierungsgruppe_2_id
         ,v01_1.terminierungsgruppe_3_id
         --,v01_1.dat_bis
      ORDER BY v01_1.sortimentslistenart_id DESC, v01_1.dat_bis DESC) = 1
      ) dispo
ON marc.mandant_id=dispo.mandant_id
AND TRY_CAST(likp.kunde_id AS INT) = dispo.kunde_id
AND lips.wup_id = dispo.wup_id
AND wg.wg_id = dispo.wg_id
AND marc.terminierungsgruppe_1_id=dispo.terminierungsgruppe_1_id
AND marc.terminierungsgruppe_2_id=dispo.terminierungsgruppe_2_id
AND marc.terminierungsgruppe_3_id=dispo.terminierungsgruppe_3_id
AND likp.dat_lief_soll BETWEEN dispo.dat_von AND dispo.dat_bis*/

--where likp.dat_lief_soll='2022-03-11' and marc.art_id=104045900 and lips.wup_id=6906
;