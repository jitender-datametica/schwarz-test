CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VERRECHFALL_DL
-- 13.04.2010 Alex Lipkin neu erstellt
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


   FROM dbp_view.v_verrechfall
   WHERE
   belosart_fg =1

;