CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_FRAGE_KATALOG_2
--- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20171204 twie: NSR0048153 neues Feld int_frage_id schneidet erste 5 Zeichen der frage_nr ab
-- 20180607 twie: SPEC0038139 PK um kmr_quelle_id ergänzt für Zusammenführung Hierarchie
-- 20190828 twie: SPEC0059325 Nur relevante Fragen für das Cockpit anzeigen, dafür Substrings der Fragenr. (int_frage_id) aus Filtertabelle ausschließen
-- 20200326 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
(
amx_frage_katalog_id
,kmr_quelle_id
,hauptbereich_id
,teilbereich_id
,frage_nr
,int_frage_id
,amx_frage_bez
,amx_handlung_typ_id
)
AS 
SELECT 
v01.amx_frage_katalog_id
,1 AS kmr_quelle_id
,v01.hauptbereich_id
,v01.teilbereich_id
,v01.frage_nr
,SUBSTR(v01.frage_nr, 6, 25)  AS int_frage_id
,v01.amx_frage_bez
,v01.amx_handlung_typ_id
FROM dbp_view.v_amx_frage_katalog_2 v01
WHERE int_frage_id NOT IN
(
SELECT platzhalter_string FROM dbp_view.v_amx_filter_benutzeroberflaeche_2
WHERE amx_filter_typ_id = 3 --Typ 3 steht für Fragekatalog
AND amx_system_id=1
)
AND v01.amx_system_id=1;