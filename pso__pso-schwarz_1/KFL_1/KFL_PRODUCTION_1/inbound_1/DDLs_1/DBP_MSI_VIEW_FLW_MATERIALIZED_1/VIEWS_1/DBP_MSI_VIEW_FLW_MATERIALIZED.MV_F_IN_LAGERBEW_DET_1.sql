create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_IN_LAGERBEW_DET_1(
	LAGERBEW_BELEG_ID,
	LAGERBEW_BELEG_POS_ID,
	MANDANT_ID,
	KJ,
	WERK_ID,
	DAT_BUCH,
	IN_ART_ID,
	IN_ART_NR,
	ARTIKELART_ID,
	LAGER_BEWART_ID,
	AUTO_ID,
	IN_LIEF_ID,
	CHARGE_ID,
	SOLL_HABEN_KZ,
	EMPFAENGER_ID,
	MENGE_LAGERBEW_BME,
	MENGE_BSTMG,
	BEST_MENGE_EINH_ID,
	MENGE_ST,
	MENGE_KG,
	ERFSNGS_MENGE_EINH_ID,
	MENGE_ERF,
	MENGE_LAGERBEW_AME,
	UMRECH_FAKTOR,
	DME_EINH_ID,
	LAGERORT_ID,
	KOSTENSTELLE_ID,
	AUFTRAG_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	MENGE_BESTELLPREIS,
	PREIS_STEUER_KZ,
	PJWO,
	NETTOPREIS,
	WRG_ID,
	BETRAG_LAGERBEW,
	BETRAG_LAGERBEW_ALTNV,
	EKN_KG,
	MENGE_BASIS,
	KOMPONENTENMENGE
) as
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 14.03.2013 twieder: Join zu mv_f_in_besch_best_det_1 zur Ermittlung nettopreis (für DB-Rechnung IWV)
-- 17.04.2013 twieder: Umrechnung Nettopreis von BME in KG
-- 22.07.2013 twieder: Bew.art_1 531 und 532 hinzu
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO
-- 10.07.2017 twie: SPEC0025417 lager_bewart_id Y29 + Y30 ergänzt, Filterung auf CHAR statt INT
-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW
-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV
-- 17.03.2022 twie: SPEC0133190 menge_basis und komponentenmenge aus Stückliste ergänzt um Sollmenge zu ermitteln

SELECT
  lagerbew_beleg_id,
  lagerbew_beleg_pos_id,
  v01.mandant_id,
  kj,
  werk_id,
  dat_buch,
  in_art_id,
  in_art_nr,
  artikelart_id,
  lager_bewart_id,
  auto_id,
  in_lief_id,
  charge_id,
  soll_haben_kz,
  empfaenger_id,
  menge_lagerbew_bme,
  menge_bstmg,
  best_menge_einh_id,
  menge_st,
  menge_kg_tmp AS menge_kg,
  erfsngs_menge_einh_id,
  menge_erf,
  menge_lagerbew_ame,
  umrech_faktor,
  dme_einh_id,
  lagerort_id,
  kostenstelle_id,
  auftrag_id,
  best_beleg_id,
  best_beleg_pos_id,
  menge_bestellpreis,
  preis_steuer_kz,
  pjwo,
  nettopreis,
  v400.wrg_id AS wrg_id,
  CASE
    -- Landesbeleg in Euro wird in Euro angezeigt
    WHEN v01.wrg_id <> v01.default_wrg
    AND v200.wrg_typ_id = 0 -- 0 = Euro
    THEN v01.betrag_lagerbew * vorzeichen 
    -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
    WHEN v01.wrg_ID <> v01.default_wrg
    AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
    THEN (
      v01.betrag_lagerbew * vorzeichen / v500.umrechnungskurs
    ) --Landesbeleg in Landeswaehrung wird in Euro angezeigt
    WHEN v01.wrg_id = v01.default_wrg
    AND v200.wrg_typ_id = 0 -- 0 = Euro
    THEN v01.betrag_lagerbew * vorzeichen * v500.umrechnungskurs 
    -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
    WHEN v01.wrg_id = v01.default_wrg
    AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
    THEN v01.betrag_lagerbew * vorzeichen
  END AS betrag_lagerbew,
  CASE
    -- Landesbeleg in Euro wird in Euro angezeigt
    WHEN v01.wrg_id <> v01.default_wrg
    AND v200.wrg_typ_id = 0 -- 0 = Euro
    THEN v01.betrag_lagerbew_altnv * vorzeichen 
    -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
    WHEN v01.wrg_id <> v01.default_wrg
    AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
    THEN (
      v01.betrag_lagerbew_altnv * vorzeichen / v500.umrechnungskurs
    ) --Landesbeleg in Landeswaehrung wird in Euro angezeigt
    WHEN v01.wrg_id = v01.default_wrg
    AND v200.wrg_typ_id = 0 -- 0 = Euro
    THEN v01.betrag_lagerbew_altnv * vorzeichen * v500.umrechnungskurs 
    -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
    WHEN v01.wrg_id = v01.default_wrg
    AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
    THEN v01.betrag_lagerbew_altnv * vorzeichen
  END AS betrag_lagerbew_altnv,
  (
    CASE
      WHEN betrag_lagerbew = 0 THEN NULL
      ELSE betrag_lagerbew
    END / CASE
      WHEN menge_kg_tmp = 0 THEN NULL
      ELSE menge_kg_tmp
    END
  ) AS ekn_kg,
  v01.menge_basis,
  v01.komponentenmenge

  FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_IN_LAGERBEW_DET_1 v01

  -- Ermittlung der eingestellter Währung
  CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200

  -- Ermittlung ob Tageskurs / Kaufland Kurs_1
  CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_1 v300 
  
  -- Aufloesung eingestellte Waehrung nach Kurstyp(0 = Euro,1 = Landeswaehrung)
  JOIN dbp_view.v_mandant_wrg_typ_zu_1 v400 
  ON v01.mandant_id = v400.mandant_id
  AND v200.wrg_typ_id = v400.wrg_typ_id 
  
  -- Umrechnung Standardkurs, Tageskurs
  JOIN dbp_view.v_kurs_1 v500 
  ON v300.kurstyp_id = v500.kurstyp_id
  AND v01.wrg_id = v500.von_wrg_id
  AND v500.nach_wrg_id = 'EUR'
  AND v01.dat_buch BETWEEN v500.dat_von AND v500.dat_bis;