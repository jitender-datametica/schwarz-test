-- 20160322 KKaiser, neu für AP0002158 Audimex

-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK

-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_l_frage_typ_2 (frage_typ_id, amx_system_id, frage_typ_bez)
AS SELECT frage_typ_id,
 amx_system_id,
 frage_typ_bez
FROM kfl_production_dbp_view.v_amx_l_frage_typ_2;