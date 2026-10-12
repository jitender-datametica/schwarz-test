create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_AMX_FRAGE_KATALOG(
	AMX_FRAGE_KATALOG_ID,
	AMX_SYSTEM_ID,
	KMR_QUELLE_ID,
	HAUPTBEREICH_ID,
	TEILBEREICH_ID,
	FRAGE_NR,
	INT_FRAGE_ID,
	AMX_FRAGE_BEZ,
	AMX_HANDLUNG_TYP_ID
) as
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20171204 twie: NSR0048153 neues Feld int_frage_id schneidet erste 5 Zeichen der frage_nr ab
-- 20180607 twie: SPEC0038139 PK um kmr_quelle_id ergänzt für Zusammenführung Hierarchie
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

   SELECT
    amx_frage_katalog_id
   ,amx_system_id
   ,1 AS kmr_quelle_id
   ,hauptbereich_id
   ,teilbereich_id
   ,frage_nr
   ,SUBSTR(frage_nr, 6, 25) AS int_frage_id
   ,amx_frage_bez
   ,amx_handlung_typ_id

   FROM dbp_view.v_amx_frage_katalog;