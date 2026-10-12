CREATE OR REPLACE VIEW dbp_view.v_flw_art_wup_status_2
 AS
 SELECT
 mandant_id
,flw_art_id
,werk_id
,dme_einh_id
,system_id
,beschaffungsart_id
,zerlege_gruppe_id
,mat_gruppe_id
,loesch_id
,dat_von_loesch_id
,indentifikation_fg
,herkunftsnachweis_fg
,hackfleischpruef_fg
,herkunft_id
,tiergattung_id
,tierkategorie_id
,toleranz_ueber_prozent
,toleranz_unter_prozent
 FROM dbp_data.flw_art_wup_status_2;