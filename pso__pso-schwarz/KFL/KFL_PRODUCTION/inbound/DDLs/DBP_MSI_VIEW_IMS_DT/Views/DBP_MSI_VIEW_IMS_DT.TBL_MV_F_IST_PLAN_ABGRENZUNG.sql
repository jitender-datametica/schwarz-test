CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS_DT.TBL_MV_F_IST_PLAN_ABGRENZUNG
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
	PLAN_ABGRENZUNG_WERT_GESAMT,
	PLAN_ABGRENZUNG_WERT_BIS_GJMO,
	BETRAG_IST_BIS_GJMO,
	WRG_ID
)
AS
-- 30.08.2013 AL Init
-- 17.09.2013 AL sparte_id aufgenommen
-- 05.04.14 AL Anpassung DatenbankName auf dbp_msi_v_view.v_ims_plan_abgrenzung anstatt dbe_data_fed_ims
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
   --Zusammenfassen Werbung, KIS, KI zu Zentrale
   CASE WHEN v04.sparte_id IN (4,6,8) THEN 5 ELSE v04.sparte_id END sparte_id,
   v01.plan_abgrenzung_wert_gesamt,
   v01.plan_abgrenzung_wert_bis_gjmo,
   v01.betrag_ist_bis_gjmo,
   v01.wrg_id

   FROM dbp_msi_v_view.v_ims_plan_abgrenzung   v01

   INNER JOIN dbp_view.v_in_psp_element v02
   ON v01.psp_id = v02.psp_id AND
   v01.mandant_id = v02.mandant_id

   INNER JOIN dbp_view.v_in_projekt v03
   ON v02.in_projekt_id = v03.in_projekt_id AND
   v02.mandant_id = v03.mandant_id

   INNER JOIN dbp_view.v_ims_standort v04
   ON v03.standort_id = v04.standort_id AND
   v03.mandant_id = v04.mandant_id
   ;