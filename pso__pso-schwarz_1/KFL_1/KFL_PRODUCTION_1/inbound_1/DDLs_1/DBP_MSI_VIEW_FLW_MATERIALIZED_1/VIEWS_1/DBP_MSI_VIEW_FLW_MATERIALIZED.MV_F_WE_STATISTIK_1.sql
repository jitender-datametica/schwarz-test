create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_WE_STATISTIK_1(
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
	BETRAG_BELEG_KONDITION,
	BETRAG_BELEG_KONDITION_KG,
	EKN_GESAMT,
	WRG_ID
) as
SELECT
   v01.mandant_id, 
   beleg_kondition_id, 
   beleg_kondition_pos_id,
   beleg_konditionsart_id,
   werk_id, 
   v01.dat_buch, 
   in_art_id, 
   in_art_nr, 
   artikelart_id, 
   lagerort_id, 
   in_lief_id, 
   lager_bewart_id, 
   nettogew, 
   menge_lagerbew_bme, 
   basismenge_einh_id, 
   dme_einh_id, 
   menge_dme
   , CAST ((CASE
   -- Landesbeleg in Euro wird in Euro angezeigt
   WHEN wrg_id_09 <> v01.default_wrg AND v200.wrg_typ_id = 0-- 0 = Euro
   THEN v01.betrag_beleg_kondition
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN wrg_id_09 <> v01.default_wrg AND v200.wrg_typ_id = 1-- 1 = Landeswaehrung
   THEN ( v01.betrag_beleg_kondition / v500.umrechnungskurs)
   --Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN wrg_id_09 = v01.default_wrg AND v200.wrg_typ_id = 0-- 0 = Euro
   THEN v01.betrag_beleg_kondition * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN wrg_id_09 = v01.default_wrg AND v200.wrg_typ_id = 1-- 1 = Landeswaehrung
   THEN v01.betrag_beleg_kondition
   END / COALESCE (CASE WHEN v01.kondition_preis_einh_id = 0 THEN NULL ELSE v01.kondition_preis_einh_id END , 1)) AS  DECIMAL(18,6))
   AS betrag_beleg_kondition
   , CAST ((CASE
   -- Umrechnung ST > KG
   WHEN v01.basismenge_einh_id = 'KG'
   THEN betrag_beleg_kondition
   WHEN v01.basismenge_einh_id = 'ST' THEN CAST((v01.betrag_beleg_kondition / v01.umrech_faktor) AS DECIMAL(18,6))
   END / COALESCE (CASE WHEN v01.kondition_preis_einh_id = 0 THEN NULL ELSE v01.kondition_preis_einh_id END , 1)) AS  DECIMAL(18,6))
   AS betrag_beleg_kondition_kg
   -- Währungseinstellung und Umrechnung Kurs_1
   -- GLD---------------------------------------------------------------------------------
   , CAST(
   CASE
   -- Landesbeleg in Euro wird in Euro angezeigt
   WHEN v01.preis_steuer_kz = 'V'AND wrg_id_02 <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.betrag_lagerbew,0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.preis_steuer_kz = 'V'AND wrg_id_02 <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN  COALESCE(v01.betrag_lagerbew,0) / v600.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.preis_steuer_kz = 'V'AND wrg_id_02 = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.betrag_lagerbew,0) * v600.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.preis_steuer_kz = 'V'AND wrg_id_02 = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(v01.betrag_lagerbew,0)
   -- Standardpreis-------------------------------------------------------------------------
   -- Landesbeleg in Euro wird in Euro angezeigt
   WHEN v01.preis_steuer_kz = 'S'AND wrg_id_02 <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.betrag_lagerbew_altnv,0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.preis_steuer_kz = 'S'AND wrg_id_02 <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(v01.betrag_lagerbew_altnv,0) / v600.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.preis_steuer_kz = 'S'AND wrg_id_02 = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.betrag_lagerbew_altnv,0) * v600.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.preis_steuer_kz = 'S'AND wrg_id_02= v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(v01.betrag_lagerbew_altnv,0)
   END AS DECIMAL(18,6)) AS ekn_gesamt
   , v400.wrg_id AS wrg_id

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.tbl_mv_f_we_statistik_1 v01

   -- Ermittlung der eingestellter Währung
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200

   -- Ermittlung ob Tageskurs / Kaufland Kurs_1
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_1 v300

   -- Aufloesung eingestellte Waehrung nach Kurstyp(0 = Euro,1 = Landeswaehrung)
   JOIN dbp_view.v_mandant_wrg_typ_zu_1 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id

   -- Umrechnung Standardkurs, Tageskurs  für die Konditionswerte betrag_beleg_kondition
   LEFT OUTER JOIN dbp_view.v_kurs_1 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND wrg_id_09 = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.dat_buch BETWEEN v500.dat_von AND v500.dat_bis

   -- Umrechnung Standardkurs, Tageskurs  fuer die Mseg Werte
   JOIN dbp_view.v_kurs_1 v600
   ON v300.kurstyp_id = v600.kurstyp_id
   AND wrg_id_02 =  v600.von_wrg_id
   AND v600.nach_wrg_id ='EUR'
   AND v01.dat_buch BETWEEN v600.dat_von AND v600.dat_bis;