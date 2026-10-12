CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_teku_wup_sperre_1 (mandant_id, wup_id, hausleiter_sperr_fg,
vkl_sperr_fg, gf_gbl_vertrieb_sperr_fg, user_id, hierarchie_ebene_id) AS SELECT T01.mandant_id,
 T01.wup_id,
 T01.hausleiter_sperr_fg,
 T01.vkl_sperr_fg,
 T01.gf_gbl_vertrieb_sperr_fg,
 t02.user_id,
 t02.hierarchie_ebene_id
FROM kfl_production_dbp_msi_v_view.v_wup_denorm_per_1 AS T01
 INNER JOIN (SELECT V02_1.mandant_id,
   V02_1.user_id,
   V02_1.hierarchie_element_id,
   V02_1.hierarchie_ebene_id,
   V02_2.wup_id
  FROM kfl_production_dbp_msi_v_view.v_user_vis_benchmark_zu_1 AS V02_1
   INNER JOIN kfl_production_dbp_msi_v_view.v_user_wup_zu_1 AS V02_2 ON V02_1.mandant_id = V02_2.mandant_id AND V02_1.user_id
      = V02_2.user_id) AS t02 ON T01.mandant_id = t02.mandant_id AND T01.wup_id = t02.wup_id
WHERE STRPOS(T01.dat_von_bis, 'CURRENT_DATE') <> 0;