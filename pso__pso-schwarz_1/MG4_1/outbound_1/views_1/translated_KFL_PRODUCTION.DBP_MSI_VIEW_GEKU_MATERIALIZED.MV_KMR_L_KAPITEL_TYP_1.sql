-- 03.08.2022 twie: SPEC0155060 Kapiteltyp für die Spezialview MV_KMR_L_KAPITEL_1, um zu erkennen, welcher Inhalt im Attribut Kapitel steckt (Prüfprogramm, Haupt-, Teil-, oder Unterbereich)

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_l_kapitel_typ_1 (kapitel_typ_id, kapitel_typ_bez) AS SELECT
 kapitel_typ_id,
 kapitel_typ_bez
FROM kfl_production_dbp_view.v_amx_l_kapitel_typ_1
WHERE amx_system_id = 2;