-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen

-- 20160322 KKaiser, neu für AP0002158 Audimex

-- 20180607 twie: SPEC0038139 Schlüssel für Fragekatalog um kmr_quelle_id ergänzg für Zusammenführung Hierarchie

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_frage_katalog_typ_zu_2 (amx_frage_katalog_id, amx_system_id
, kmr_quelle_id, frage_typ_id) AS SELECT amx_frage_katalog_id,
 amx_system_id,
 1 AS kmr_quelle_id,
 frage_typ_id
FROM kfl_production_dbp_view.v_amx_frage_katalog_typ_zu_2;