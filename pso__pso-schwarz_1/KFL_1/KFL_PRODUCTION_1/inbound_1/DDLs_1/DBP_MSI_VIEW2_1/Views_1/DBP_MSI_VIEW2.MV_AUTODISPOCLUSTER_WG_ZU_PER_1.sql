CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_AUTODISPOCLUSTER_WG_ZU_PER_1 as
   SELECT
   mandant_id, wg_hierarchie_id  AS wg_id, wg_hierarchie_mutter_id AS autodispo_id
   FROM dbp_view.v_wg_hierarchie_zu_per_1
   WHERE arthiertyp_id = 9
   AND mandant_id = 1
   AND wg_hierarchie_ebene_id = 0
   AND CURRENT_DATE BETWEEN dat_von AND dat_bis
;