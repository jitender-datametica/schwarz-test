CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS_DT.MV_F_IST_PLAN_ABGRENZUNG_2
(
	MANDANT_ID,
	PSP_ID,
	GJMO,
	DAT_BAUBEGINN,
	DAT_BEGINN_EINRICHTUNG,
	DAT_BEGINN_KAELTE,
	DAT_STILLE_EROEFFNUNG,
	DAT_BAUABNAHME,
	ANZ_TAGE_MASSNAHME_GESAMT,
	ANZ_TAGE_MASSNAHME_BIS_GJMO,
	SPARTE_ID,
	PLAN_ABGRENZUNG_WERT,
	PLAN_ABGRENZUNG_WERT_GESAMT,
	PLAN_ABGRENZUNG_WERT_BIS_GJMO,
	BETRAG_IST_BIS_GJMO
)
AS
-- 30.08.2013 AL Init
-- 17.09.2013 AL sparte_id aufgenommen
-- 05.04.14 AL Anpassung DatenbankName auf dbp_msi_v_view.v_ims_plan_abgrenzung_2 anstatt dbe_data_fed_ims
-- 21.04.16 twie: AP0001938 Umstellung von Ebene in_projekt_id auf psp_id
-- 23.05.17 twie: SPEC0023806 neue Datumsattribute und Metrikspalten in Tabelle

   SELECT
   v01.mandant_id,
   v01.psp_id,
   v01.gjmo,
   dat_baubeginn,
   dat_beginn_einrichtung,
   dat_beginn_kaelte,
   dat_stille_eroeffnung,
   dat_bauabnahme,
   anz_tage_massnahme_gesamt,
   anz_tage_massnahme_bis_gjmo,
   sparte_id,
   
   CASE WHEN v400.wrg_typ_id = 1
   THEN v01.plan_abgrenzung_wert_gesamt
   ELSE v01.plan_abgrenzung_wert_gesamt * umrechnungskurs
   END AS plan_abgrenzung_wert,
  
   CASE WHEN v400.wrg_typ_id = 1
   THEN v01.plan_abgrenzung_wert_gesamt
   ELSE v01.plan_abgrenzung_wert_gesamt * umrechnungskurs
   END AS plan_abgrenzung_wert_gesamt,
   
   CASE WHEN v400.wrg_typ_id = 1
   THEN v01.plan_abgrenzung_wert_bis_gjmo
   ELSE v01.plan_abgrenzung_wert_bis_gjmo * umrechnungskurs
   END AS plan_abgrenzung_wert_bis_gjmo,
   
   CASE WHEN v400.wrg_typ_id = 1
   THEN v01.betrag_ist_bis_gjmo
   ELSE v01.betrag_ist_bis_gjmo * umrechnungskurs
   END AS betrag_ist_bis_gjmo

   FROM DBP_MSI_VIEW_IMS_DT.TBL_MV_F_IST_PLAN_ABGRENZUNG_2   v01
   
   -- Ermittlung der eingestellter Währung
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200

   -- Ermittlung Kurstyp
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300

   JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id

   -- Umrechnung Standardkurs, Tageskurs
   JOIN dbp_view.v_kurs_2 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND CURRENT_DATE BETWEEN v500.dat_von AND v500.dat_bis
   ;