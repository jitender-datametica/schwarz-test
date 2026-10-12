CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_MES_PRODFEHLER_1

(
mandant_id
,werk_id
,dat_schicht
,schicht_id
,mes_prodzeittyp_id
,fehler_katalog_id
,fehler_code_gruppe_id
,fehler_code_id
,dat_anfang
,zeit_anfang
,dat_ende
,zeit_ende
,ist_fehler_dauer
,ist_fehler_einh
)

AS

--27.07.2022 TWIE: SPEC0148993 neue Fakttabelle
--da werk_id und Tag_1 fehlt, müssen diese über die Schicht ermittelt werden
--schicht_id ist hierfür eindeutig, weitere Schlüsselfelder in flw_mes_schicht_1 wurden aus SAP übernommen, aber sind nicht notwendig

SELECT

v01.mandant_id
,v02.flw_werk_id AS werk_id
,v02.dat_schicht
,v01.schicht_id
,v01.mes_prodzeittyp_id
,v01.fehler_katalog_id
,v01.fehler_code_gruppe_id
,v01.fehler_code_id
,TO_DATE(v01.datzeit_anfang) AS dat_anfang
,TO_TIME(v01.datzeit_anfang) AS zeit_anfang
,TO_DATE(v01.datzeit_ende) AS dat_ende
,TO_TIME(v01.datzeit_ende) AS zeit_ende
,v01.ist_fehler_dauer
,v01.ist_fehler_einh

FROM dbp_view.v_flw_mes_prodfehler_1 v01

JOIN dbp_view.v_flw_mes_schicht_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.schicht_id = v02.schicht_id
;
