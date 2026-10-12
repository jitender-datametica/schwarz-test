-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

-- separate Tabelle mit DE Daten:
 -- DE-Prüfungen werden ab 2023 ausschließlich im AMX-Core erfasst

-- 20160322 KKaiser, neu für AP0002158 Audimex

-- 20230316 twie: SPEC0190886 für DE Daten gibt es eigenständige Tabellen, die jeweils per Union ergänzt werden (enthalten nur Daten für amx_system_id = 1)

-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_b_process_pruefung_zu_2 (business_process_id, pruefung_id,
amx_system_id) AS SELECT business_process_id,
 pruefung_id,
 amx_system_id
FROM kfl_production_dbp_view.v_amx_b_process_pruefung_zu_2
UNION DISTINCT
SELECT business_process_id,
 pruefung_id,
 1 AS amx_system_id
FROM kfl_production_dbp_view.v_amx_de_b_process_pruefung_zu_2;