CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_BON_GF_2 as
               SELECT
               msi.gf_id,
               msi.mandant_id,
               gf_name
               FROM (SELECT DISTINCT
               mandant_id,
               nb_id,
               gf_id
               FROM dbp_bda_msi_view.mv_l_bon_wup
               ) msi
               INNER JOIN dbp_view.v_gf_2 vw
               ON msi.gf_id = vw.gf_id
               AND msi.mandant_id = vw.mandant_id
               AND ek_fg = 0;