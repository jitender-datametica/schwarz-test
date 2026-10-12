CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VERRECHFALL_2
-- 13.04.2010 AL Eingeschränkt auf die Daten der Beschaffungslogistik
-- 01.07.2010: Awol: für KW37 Anforderung 262654 Einschränkung auf verrechfall_status_id auskommentiert
--21-06-2021, AP0091617, SPEC0113162, adding belos_adresse_steuerung_id and belos_adresse_rechnung_id, dknop

(
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
)
AS
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

   FROM dbp_view.v_verrechfall_2
   WHERE
   
   belosart_fg = 0

   -- Berücksichtigt werden nur Verrechnungsfälle im Status_2 "verrechnet" (BC150), "abgeglichen" (BC151)und "abgeschlossen" (BC160)
   -- 01.07.10: für KW37 Anforderung 262654 auskommentiert
   -- verrechfall_status_id IN ('BC150', 'BC151', 'BC160')

   -- Eingeschränkt auf die Daten der Beschaffungslogistik
  
;