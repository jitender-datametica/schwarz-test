CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_ART_WUP_STATUS
-- AL 03.08.2011  Spalten tiergattung_id, beschaffungsart_id hinzugefügt
-- 26.10.2011 system_id entfernt
-- 01.12.2011 AL zerlege_gruppe_id Spalte aufgenommen
-- 23.01.2013 twie: Filterung auf Mandant und Werk, weil Tabelle für Projekt SAKO erweitert
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 12.08.2016 twie: SPEC0007420 neue Felder loesch_id und dat_von_loesch_id
-- 18.09.2017 TUTS: SPEC0019330 indentifikation_fg, tierkategorie_id, herkunftsnachweis_fg, herkunft_id, hackfleischpruef_fg hinzugefügt
-- 25.11.2019 TWIE: SPEC0054374 prozent_toleranz_ueber, prozent_toleranz_unter hinzugefügt

(
mandant_id
,in_art_id
,werk_id
,dme_einh_id
,tiergattung_id
,beschaffungsart_id
,zerlege_gruppe_id
,loesch_id
,dat_von_loesch_id
,indentifikation_fg
,tierkategorie_id
,herkunftsnachweis_fg
,herkunft_id
,hackfleischpruef_fg
,toleranz_unter_prozent
,toleranz_ueber_prozent
)
AS
SELECT
v01.mandant_id,
v01.flw_art_id AS in_art_id,
v01.werk_id,
v01.dme_einh_id,
v01.tiergattung_id,
v01.beschaffungsart_id,
v01.zerlege_gruppe_id,
COALESCE(v01.loesch_id, '')  AS loesch_id,
v01.dat_von_loesch_id,
v01.indentifikation_fg,
v01.tierkategorie_id,
v01.herkunftsnachweis_fg,
v01.herkunft_id,
v01.hackfleischpruef_fg,
v01.toleranz_unter_prozent,
v01.toleranz_ueber_prozent
FROM dbp_view.v_flw_art_wup_status v01

JOIN dbp_view.v_flw_werk v02
ON v01.werk_id = v02.werk_id
AND v01.mandant_id = v02.mandant_id

WHERE v01.mandant_id in (1,2)
AND v02.flw_fg = 1;