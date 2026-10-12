create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_VERRECHFALL_1(
	MANDANT_ID,
	VERRECHFALL_ID,
	BELOS_VORGANG_ID,
	VERRECHFALLART_ID,
	BELOS_ADRESSE_EMPFAENGER_ID,
	WRG_ID,
	STORNO_FG,
	BETRAG_PAUSCHALFRACHT,
	BETRAG_FRACHT,
	VERRECHFALL_STATUS_ID,
	BELOS_LEISTUNGSART_ID,
	KUNDE_FG,
	FRACHT_SATZ_PRZ,
	FRACHT_SATZ_PRZ_PRO_EINH,
	BELOS_ADRESSE_RECHNUNG_ID,
	BELOS_ADRESSE_STEUERUNG_ID
) as
   SELECT
    mandant_id
   ,verrechfall_id
   ,belos_vorgang_id
   ,verrechfallart_id
   ,belos_adresse_empfaenger_id
   ,wrg_id
   ,storno_fg
   ,betrag_pauschalfracht
   ,betrag_fracht
   ,verrechfall_status_id
   ,belos_leistungsart_id
   ,kunde_fg
   ,fracht_satz_prz
   ,fracht_satz_prz_pro_einh
   ,belos_adresse_rechnung_id
   ,belos_adresse_steuerung_id

   FROM dbp_view.v_verrechfall_1
   WHERE
   
   belosart_fg = 0

   -- Berücksichtigt werden nur Verrechnungsfälle im Status_1 ""verrechnet"" (BC150), ""abgeglichen"" (BC151)und ""abgeschlossen"" (BC160)
   -- 01.07.10: für KW37 Anforderung 262654 auskommentiert
   -- verrechfall_status_id IN ('BC150', 'BC151', 'BC160')

   -- Eingeschränkt auf die Daten der Beschaffungslogistik;