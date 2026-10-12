create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_AMX_B_PROCESS_PRUEFUNG_ZU_2(
	BUSINESS_PROCESS_ID,
	PRUEFUNG_ID,
	AMX_SYSTEM_ID
) as
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK
-- 20230316 twie: SPEC0190886 für DE Daten gibt es eigenständige Tabellen, die jeweils per Union ergänzt werden (enthalten nur Daten für amx_system_id = 1)

SELECT
 business_process_id
,pruefung_id
,amx_system_id

FROM dbp_view.v_amx_b_process_pruefung_zu_2

--separate Tabelle mit DE Daten:
UNION

SELECT 
 business_process_id
,pruefung_id
,1 AS amx_system_id  -- DE-Prüfungen werden ab 2023 ausschließlich im AMX-Core erfasst

FROM dbp_view.v_amx_de_b_process_pruefung_zu_2
;