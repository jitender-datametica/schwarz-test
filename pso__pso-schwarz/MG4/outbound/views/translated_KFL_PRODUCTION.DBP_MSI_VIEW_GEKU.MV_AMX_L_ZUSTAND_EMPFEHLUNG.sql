-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen

-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

-- 20160324 twie: Zustand der Empfehlung unabhängig von Zustand der Prüfung

-- 20160322 KKaiser, neu für AP0002158 Audimex
 -- deshalb 2 Views + Attribute, nur die Quelltabelle ist die gleiche

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_l_zustand_empfehlung (zustand_id, amx_system_id,
zustand_bez) AS SELECT zustand_id,
 amx_system_id,
 zustand_bez
FROM kfl_production_dbp_view.v_amx_l_zustand;