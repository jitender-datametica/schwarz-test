CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FWWS_WUP_GP(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	GP_ID,
	KJMO,
	GJ,
	MO_KJ,
	AKT_MO,
	AKT_GJ,
	ANZ_BUCHUNG_MASCH,
	ANZ_VORGANG_OHNE,
	ANZ_WA_NICHT_GEMELDET,
	ANZ_BUCHUNG_GS,
	ANZ_WE_NICHT_GEMELDET,
	ANZ_BUCHUNG_RECH,
	ANZ_RECH_POS,
	SUM_BUCHUNG_MASCH,
	SUM_VORGANG_OHNE,
	SUM_WA_NICHT_GEMELDET,
	SUM_BUCHUNG_GS,
	SUM_WE_NICHT_GEMELDET,
	SUM_BUCHUNG_RECH,
	ANZ_BUCHUNG_MASCH_KUM,
	ANZ_VORGANG_OHNE_KUM,
	ANZ_WA_NICHT_GEMELDET_KUM,
	ANZ_BUCHUNG_GS_KUM,
	ANZ_WE_NICHT_GEMELDET_KUM,
	ANZ_BUCHUNG_RECH_KUM,
	ANZ_RECH_POS_KUM,
	SUM_BUCHUNG_MASCH_KUM,
	SUM_VORGANG_OHNE_KUM,
	SUM_WA_NICHT_GEMELDET_KUM,
	SUM_BUCHUNG_GS_KUM,
	SUM_WE_NICHT_GEMELDET_KUM,
	SUM_BUCHUNG_RECH_KUM
) AS

   -- FAKT-AGGREGAT FWWS Buchungen/Vorgaenge RPW (Rechnungen/Gutschriften) pro Monat - Markt/Lieferant
   -- Datenumfang:
   -- 2010KW42PU Erweiterung Lieferant
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 																AS wup_id
 , v01.gp_id
 , v01.kjmo
 , v01.gj
 , v01.mo_kj
 , v01.akt_mo
 , v01.akt_gj
 , v01.anz_buchung_masch
 , v01.anz_vorgang_ohne
 , v01.anz_wa_nicht_gemeldet
 , v01.anz_buchung_gs
 , v01.anz_we_nicht_gemeldet
 , v01.anz_buchung_rech
 , v01.anz_rech_pos
 , v01.sum_buchung_masch
 , v01.sum_vorgang_ohne
 , v01.sum_wa_nicht_gemeldet
 , v01.sum_buchung_gs
 , v01.sum_we_nicht_gemeldet
 , v01.sum_buchung_rech
 , v01.anz_buchung_masch_kum
 , v01.anz_vorgang_ohne_kum 
 , v01.anz_wa_nicht_gemeldet_kum
 , v01.anz_buchung_gs_kum
 , v01.anz_we_nicht_gemeldet_kum
 , v01.anz_buchung_rech_kum
 , v01.anz_rech_pos_kum
 , v01.sum_buchung_masch_kum
 , v01.sum_vorgang_ohne_kum
 , v01.sum_wa_nicht_gemeldet_kum
 , v01.sum_buchung_gs_kum
 , v01.sum_we_nicht_gemeldet_kum
 , v01.sum_buchung_rech_kum
FROM dbp_msi_v_view.v_vis_monat_fwws_wup  v01

INNER JOIN dbp_view.v_wup wup
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;