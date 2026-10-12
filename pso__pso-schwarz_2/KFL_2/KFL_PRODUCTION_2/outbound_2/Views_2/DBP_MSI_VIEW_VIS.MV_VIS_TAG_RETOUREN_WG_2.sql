CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_retouren_wg_2 (mandant_id, nb_id, wup_id, wrg_id,
arthiertyp_id, abt_id, wg_id, dat, kjwo, kjmo, gj, reklamationsgrund_id, vk_menge_re, vk_netto_re) AS SELECT V01.mandant_id
 ,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.wrg_id,
 V01.arthiertyp_id,
 V01.abt_id,
 V01.wg_id,
 V01.dat,
 V01.kjwo,
 V01.kjmo,
 V01.gj,
 V01.reklamationsgrund_id,
 V01.vk_menge_re,
 V01.vk_netto_re
FROM kfl_production_dbp_msi_v_view.v_vis_tag_retouren_wg_2 AS V01
 INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;