create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_IN_BESCH_FAKTURA_DET(
	FAKTURA_BELEG_ID,
	FAKTURA_BELEG_POS_ID,
	MANDANT_ID,
	WERK_ID,
	LIEF_POS_TYP_ID,
	IN_ART_ID,
	VORLAGE_BELEG_ID,
	MENGE_FAKTURA_VKME,
	MENGE_FAKTURA_LME,
	VERK_MENGE_FAKTURA_EINH_ID,
	GEWICHT_NETTO,
	DAT_PREISFINDUNG,
	DAT_LEIST_ERSTELLUNG,
	WRG_ID,
	WERT_EK_NETTO,
	VKPN_GESAMT,
	NPB,
	VKPN,
	VKPB_GESAMT,
	NPN,
	NPN_KG,
	NPN_GESAMT
) as 
-- 13.11.2011 AL Anpassung der View mit der Beruecksichtigung der Denormalisierung von Preisen
--                    in der Tabelle in_besch_faktura_det
-- 08.05.2012 TWIE: negatives Vorzeichen fuer Fakturaart S1
-- 12.09.2012 TWIE: negatives Vorzeichen fuer Fakturaart ZG24
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 04.03.2013 TWIE: neue Spalte dat_leist_erstellung
-- 26.03.2013 TWIE: negatives Vorzeichen fuer Fakturaart ZG25
-- 05.11.2013 TWIE: Vorzeichen fuer Fakturaart ZFG6 nicht mehr umdrehen, passiert bei dieser schon in SAP
-- 17.01.2014 TWIE: Aussage vom 05.11.2013 stimmt nur bei Preisen, Mengen muessen weiterhin bei ZFG6 umgedreht werden
--                               Deshalb Aufteilung der Vorzeichenlogik in vorzeichen_mengen und vorzeichen_preise
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 18.02.2015 TWIE: vkpb_gesamt berechnen
-- 24.09.2015 TWIE: nicht benoetigte Bruttokennzahlen entfernt, VKPN auf neues Feld zwsum_2_betrag
-- 23.11.2015 TWIE: Korrektur, da zwsum_2_betrag nicht vkpn sondern vkpn_gesamt liefert
-- 07.09.2016 TWIE: SPEC0014089 Filter auf Fakturaarten erweitern
-- 21.06.2017 twie: RITM0372799 Erweiterung um artikelart_id REWO
-- 04.03.2019 srom, AP0020745, SPEC0047687 Anpassung Artikelart-ID ZHAW
-- 07.03.2019 twie: nicht mehr benoetigte Felder entfernt (siehe 24.09.2015)
-- 13.05.2019 pjan, AP0043250, SPEC0054321 Anpassung Artikelart-ID ZFLV
-- 25.09.2019 naku,  Eerweiterung die fakturaart_id mit 'ZFS3''
   SELECT
   faktura_beleg_id, 
   faktura_beleg_pos_id, 
   v01.mandant_id, 
   werk_id, 
   lief_pos_typ_id, 
   in_art_id, 
   vorlage_beleg_id, 
   menge_faktura_vkme_tmp AS menge_faktura_vkme, 
   menge_faktura_lme_tmp  AS menge_faktura_lme, 
   verk_menge_faktura_einh_id, 
   gewicht_netto, 
   dat_preisfindung, 
   dat_leist_erstellung,
   v400.wrg_id              AS wrg_id,
   CAST(
     CASE
     WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0-- 0 = Euro
     THEN v01.wert_ek_netto
     -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
     WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1-- 1 = Landeswaehrung
     THEN ( v01.wert_ek_netto / v500.umrechnungskurs)
     -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
     WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
     THEN v01.wert_ek_netto * v500.umrechnungskurs
     -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
     WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
     THEN v01.wert_ek_netto
     ELSE 0
     END
   AS DECIMAL(18,6)) * vorzeichen_preise
   AS wert_ek_netto
   , CAST(
     CASE
     WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0-- 0 = Euro
     THEN v01.zwsum_2_betrag
     -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
     WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1-- 1 = Landeswaehrung
     THEN ( v01.zwsum_2_betrag / v500.umrechnungskurs)
     -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
     WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
     THEN v01.zwsum_2_betrag * v500.umrechnungskurs
     -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
     WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
     THEN v01.zwsum_2_betrag
     ELSE 0
     END
   AS DECIMAL(18,6)) * vorzeichen_preise
   AS vkpn_gesamt
   , CAST(
     CASE
     -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
     WHEN v200.wrg_typ_id = 0
     THEN v01.vk_brutto * v500.umrechnungskurs
     -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
     WHEN  v200.wrg_typ_id = 1
     THEN v01.vk_brutto
   END AS DECIMAL (18,6))* vorzeichen_preise
   AS npb
   , ((vkpn_gesamt / (CASE WHEN v01.menge_faktura_lme = 0 THEN NULL ELSE v01.menge_faktura_lme END))) AS vkpn -- pro BME
   , vkpn_gesamt *  (1+ (v01.mwst/100)) AS vkpb_gesamt
   , ( npb / (1+ (v01.mwst/100))) AS npn
   , CAST((npn /
       CAST(
       CASE
       WHEN v01.basismenge_einh_id = 'KG' THEN 1
       WHEN v01.basismenge_einh_id = 'ST' THEN v01.umrech_faktor
       END
       AS DECIMAL(18,6)))
   AS DECIMAL(18,6)) AS npn_kg --zum weiterrechnen
   , (npn_kg * v01.gewicht_netto_v02 * v01.zaehler / v01.nenner)  AS npn_gesamt

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.tbl_MV_F_IN_BESCH_FAKTURA_DET v01 
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300

   JOIN dbp_view.v_mandant_wrg_typ_zu v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.default_wrg = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.dat_preisfindung BETWEEN v500.dat_von AND v500.dat_bis;