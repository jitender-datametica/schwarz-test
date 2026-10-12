-- 20230207| SPEC0185076 | richternic | umbenennung der Spalten
 -- 20210916| SPEC0093956 | mayko | Initial view |

-- 20220719| SPEC0158746 | richternic | zwei neue Spalten

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_ts_wbs_aktion_non_std_weights_2 (mandant_id,
werbe_typ_id, kjwo, dat_quelle, dat_ziel, dat_von_orig, dat_bis_orig, gewichtung_prz) AS SELECT mandant_id,
 werbe_typ_id,
 kjwo,
 dat_quelle,
 dat_ziel,
 dat_von_orig,
 dat_bis_orig,
 gewichtung_prz
FROM kfl_production_dbp_msi_data.ts_wbs_aktion_non_std_weights_2 AS V01;