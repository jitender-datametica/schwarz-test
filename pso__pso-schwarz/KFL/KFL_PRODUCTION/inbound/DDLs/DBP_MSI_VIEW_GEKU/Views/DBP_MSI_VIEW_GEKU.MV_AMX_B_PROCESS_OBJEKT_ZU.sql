CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_amx_b_process_objekt_zu
(
business_process_id
,amx_system_id
,business_unit_id
,risiko_wert
,pruef_feld_typ_id
,aktiv_fg
,planbar_fg
,vorgabe_pruef_intervall
,dat_vorgabe_naechst_pruef
,risiko_farbe
,risiko_code
)
AS
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20160516 twie: Risikofarbe entspr. letzter Stelle risiko_wert (nur temp, solange riskio_farbe nicht befüllt)
-- 20160902 twie: risiko_code entspricht letzter Stelle des risiko_wert, für Anzeige im Bericht
--                          risiko_farbe in Tabelle enthält HEX Code, mit dem der Code mittels Schwellwert eingefärbt werden soll.
--                          Da Schwellwert in MSI aber nur Zahlen zulässt, den HEX Code in eine Zahl umwandeln, im Schwellwert dann entsprechend einfärben, wie hier definiert mit zugehörigem RGB Wert
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

SELECT
v01.business_process_id,
v01.amx_system_id,
v01.business_unit_id,
v01.risiko_wert,
v01.pruef_feld_typ_id,
v01.aktiv_fg,
v01.planbar_fg,
v01.vorgabe_pruef_intervall,
v01.dat_vorgabe_naechst_pruef,
CASE
WHEN v02.risiko_farbe = '#7401DF' THEN 10 --RGB 116-1-223

WHEN v02.risiko_farbe = '#0000FF' THEN 11 --RGB 0-0-255

WHEN v02.risiko_farbe = '#FF0000' THEN 12 --RGB 255-0-0

WHEN v02.risiko_farbe = '#FFFF00' THEN 13 --RGB 255-255-0

WHEN v02.risiko_farbe = '#00FF00' THEN 14 --RGB 0-255-0

ELSE 0 END AS risiko_farbe,
SUBSTR(TRIM(v01.risiko_wert) , 3, 1) AS risiko_code
FROM dbp_view.v_amx_b_process_objekt_zu v01

LEFT OUTER JOIN dbp_view.v_amx_risiko_bewertung v02
ON v01.risiko_wert BETWEEN v02.risiko_wert_von AND v02.risiko_wert_bis
AND v01.amx_system_id = v02.amx_system_id;
