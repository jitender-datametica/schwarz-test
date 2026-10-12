CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_WE_STATISTIK_2
(
	MANDANT_ID,
	BELEG_KONDITION_ID,
	BELEG_KONDITION_POS_ID,
	BELEG_KONDITIONSART_ID,
	WERK_ID,
	DAT_BUCH,
	IN_ART_ID,
	IN_ART_NR,
	ARTIKELART_ID,
	LAGERORT_ID,
	IN_LIEF_ID,
	LAGER_BEWART_ID,
	NETTOGEW,
	MENGE_LAGERBEW_BME,
	BASISMENGE_EINH_ID,
	DME_EINH_ID,
	MENGE_DME,
	BETRAG_BELEG_KONDITION_KG,
	WRG_ID_09,
	DEFAULT_WRG,
	BETRAG_BELEG_KONDITION,
	KONDITION_PREIS_EINH_ID,
	UMRECH_FAKTOR,
	PREIS_STEUER_KZ,
	WRG_ID_02,
	BETRAG_LAGERBEW,
	BETRAG_LAGERBEW_ALTNV
) AS
  SELECT
   v01.mandant_id, 
   v09.beleg_kondition_id, 
   v09.beleg_kondition_pos_id, 
   v08.beleg_konditionsart_id,
   v02.werk_id, 
   v01.dat_buch, 
   v02.flw_art_id AS in_art_id, 
   v06.flw_art_nr AS in_art_nr, 
   v06.artikelart_id, 
   v02.lagerort_id, 
   v02.flw_lief_id AS in_lief_id, 
   v02.lager_bewart_id, 
   v03.nettogew, 
   v02.menge_lagerbew_bme, 
   v06.basismenge_einh_id, 
   v03.dme_einh_id, 
   v03.menge_dme, 
   CAST ((CASE
   -- Umrechnung ST > KG
     WHEN v06.basismenge_einh_id = 'KG'
     THEN betrag_beleg_kondition
     WHEN v06.basismenge_einh_id = 'ST' THEN CAST((v09.betrag_beleg_kondition / v07.umrech_faktor) AS DECIMAL(18,6))
     END / COALESCE (CASE WHEN v09.kondition_preis_einh_id = 0 THEN NULL ELSE v09.kondition_preis_einh_id END , 1)) AS  DECIMAL(18,6))
   AS betrag_beleg_kondition_kg,
   v09.wrg_id AS wrg_id_09,
   v100.default_wrg,
   v09.betrag_beleg_kondition,
   v09.kondition_preis_einh_id,
   v07.umrech_faktor,
   v05.preis_steuer_kz,
   v02.wrg_id AS wrg_id_02,
   v02.betrag_lagerbew,v02.betrag_lagerbew_altnv

   FROM dbp_view.v_flw_lagerbew_2 v01

   JOIN
   (
   SELECT
   mandant_id
   , werk_id
   , best_beleg_id
   , best_beleg_pos_id
   , lagerbew_beleg_id
   , lagerort_id, kj
   , flw_art_id
   , SUM(menge_lagerbew_bme) AS menge_lagerbew_bme
   , SUM(betrag_lagerbew) AS betrag_lagerbew
   , SUM(betrag_lagerbew_altnv) AS betrag_lagerbew_altnv
   , MAX(flw_lief_id) AS flw_lief_id, MAX(lager_bewart_id) AS lager_bewart_id
   , MAX(wrg_id) AS wrg_id

   FROM

   (
   SELECT
   mandant_id
   , werk_id
   , best_beleg_id
   , best_beleg_pos_id
   , lagerbew_beleg_id
   , lagerort_id
   , kj
   , flw_art_id
   , wrg_id
   , CASE
   -- Ausweisung Positiv
   WHEN lager_bewart_id IN ('101','501','521','202','162','262','552','602','644','912','531','Y30') THEN  1
   -- Ausweisung Negativ
   WHEN lager_bewart_id IN ('102','502','522','201','161','261','551','601','643','911','532','Y29') THEN -1
   -- Ausweisung Position 1 Negativ, Position 2 Positiv
   WHEN lager_bewart_id IN ('309','311')AND soll_haben_kz = 'H'THEN -1
   WHEN lager_bewart_id IN ('309','311')AND soll_haben_kz = 'S'THEN  1
   -- Ausweisung Position 1 Positiv, Position 2 Negativ
   WHEN lager_bewart_id IN ('310','312')AND soll_haben_kz = 'H'THEN -1
   WHEN lager_bewart_id IN ('310','312')AND soll_haben_kz = 'S'THEN  1
   END
   AS vorzeichen, 
   menge_lagerbew_bme * vorzeichen AS menge_lagerbew_bme, 
   betrag_lagerbew * vorzeichen AS betrag_lagerbew, 
   betrag_lagerbew_altnv * vorzeichen AS betrag_lagerbew_altnv, 
   flw_lief_id, 
   lager_bewart_id

   FROM dbp_view.v_flw_lagerbew_det_2

   WHERE mandant_id IN (1,2)
   ) v22

   GROUP BY
   mandant_id
   , werk_id
   , best_beleg_id
   , best_beleg_pos_id
   , lagerbew_beleg_id
   , lagerort_id
   , kj
   , flw_art_id
   ) v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.lagerbew_beleg_id = v02.lagerbew_beleg_id
   AND v01.kj = v02.kj

   LEFT OUTER JOIN
   (
   SELECT
   mandant_id
   , werk_id
   , best_beleg_id
   , best_beleg_pos_id
   , lagerbew_beleg_id
   , flw_art_id
   , SUM(nettogew) AS nettogew
   , MAX(dme_einh_id) AS dme_einh_id
   , SUM(menge_dme) AS menge_dme

   FROM
   (
   SELECT
   mandant_id
   , werk_id
   , best_beleg_id
   , best_beleg_pos_id
   , lagerbew_beleg_id
   , flw_art_id, CASE
   WHEN storno_fg <> 1 AND retourenpos_fg <> 1 THEN 1
   WHEN storno_fg = 1 OR retourenpos_fg = 1 THEN -1
   END
   AS vorzeichen
   , nettogew * vorzeichen AS nettogew
   , dme_einh_id
   , menge_dme * vorzeichen AS menge_dme

   FROM dbp_view.v_flw_bew_2

   WHERE flw_beleg_typ_id = 'WE'
   AND beleg_gruppe_id = 'B'
   AND status_mb IN ('A','B','C')
   AND loesch_fg <> 1
   AND mandant_id IN (1,2)
   ) v33

   GROUP BY
   mandant_id
   , werk_id
   , best_beleg_id
   , best_beleg_pos_id
   , lagerbew_beleg_id
   , flw_art_id
   ) v03
   ON v02.mandant_id = v03.mandant_id
   AND v02.best_beleg_id = v03.best_beleg_id
   AND v02.best_beleg_pos_id = v03.best_beleg_pos_id
   AND v02.lagerbew_beleg_id = v03.lagerbew_beleg_id
   AND v02.flw_art_id = v03.flw_art_id

   -- Ermittlung der Zuordnung werk_id zu wup_id, zur Aufloesung fuer bewertungskreis_id aus in_art_bewertungkreis_per
   JOIN dbp_view.v_flw_werk_2 v04
   ON v02.werk_id = v04.werk_id
   AND v02.mandant_id = v04.mandant_id

   -- Ermittlung Standardpreis oder GLD aus MBEW
   LEFT OUTER JOIN dbp_view.v_flw_art_bewertungskreis_per_2 v05
   ON v01.mandant_id = v05.mandant_id
   AND v02.flw_art_id = v05.flw_art_id
   AND v01.dat_buch BETWEEN v05.dat_von AND v05.dat_bis
   AND v04.werk_nr = v05.bewertungskreis_id

   JOIN dbp_view.v_flw_art_2 v06
   ON v02.mandant_id = v06.mandant_id
   AND v02.flw_art_id = v06.flw_art_id

   -- Umrechnung BME(ST/KG)
   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per_2 v07
   ON v06.flw_art_id = v07.flw_art_id
   AND v06.mandant_id = v07.mandant_id
   AND (CASE 
        WHEN v06.basismenge_einh_id = 'ST' THEN 'KG'
        WHEN v06.basismenge_einh_id = 'KG' THEN 'ST'
   END) = v07.altnv_menge_einh_id

   LEFT OUTER JOIN dbp_view.v_flw_besch_best_kondit_zu_2 v08
   ON v02.mandant_id = v08.mandant_id
   AND v02.best_beleg_id = v08.best_beleg_id
   AND v02.best_beleg_pos_id = v08.best_beleg_pos_id
   AND v08.beleg_konditionsart_id IN ('PB00', 'PBXX') --Filtern, um Vervielfaeltigungen zu verhinden. Ein Beleg/Pos darf immer nur eine_2 von beiden Arte haben

   LEFT OUTER JOIN dbp_view.v_flw_kondit_vorgang_2 v09
   ON v08.mandant_id  = v09.mandant_id
   AND v08.beleg_kondition_id = v09.beleg_kondition_id
   AND v08.best_beleg_pos_id = v09.beleg_kondition_pos_id-- S. Hoger noch zu klaeren: sind die Belegpositionen = Konditionspositionen
   AND v09.beleg_konditionsart_id IN ('PB00', 'PBXX')

   -- Ermittlung der default Waehrung
   JOIN dbp_view.v_mandant_2 v100
   ON v01.mandant_id = v100.mandant_id

   WHERE v01.mandant_id IN (1,2);