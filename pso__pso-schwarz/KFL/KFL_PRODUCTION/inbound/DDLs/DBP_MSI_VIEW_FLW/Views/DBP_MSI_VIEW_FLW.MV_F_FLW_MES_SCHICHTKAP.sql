CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_MES_SCHICHTKAP

(
mandant_id
,schicht_id
,dat_schicht
,werk_id
,kapa_dauer
,kapa_einh
)

AS

--19.07.2022 TWIE: SPEC0148992 neue Fakttabelle
--da werk_id fehlt, muss diese über die Schicht ermittelt werden
--schicht_id ist hierfür eindeutig, weitere Schlüsselfelder in flw_mes_schicht wurden aus SAP übernommen, aber sind nicht notwendig
--auch Schlüsselfelder kapatyp_id und schichttyp_id in flw_mes_schichtkap sind laut Fachbereich nicht relevant für eindeutige Datensätze

SELECT

v01.mandant_id
,v01.schicht_id
,v01.dat_schicht
,v02.flw_werk_id AS werk_id
,v01.kapa_dauer
,v01.kapa_einh


FROM dbp_view.v_flw_mes_schichtkap v01

JOIN dbp_view.v_flw_mes_schicht v02
ON v01.mandant_id = v02.mandant_id
AND v01.schicht_id = v02.schicht_id

;