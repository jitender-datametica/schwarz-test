CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_PLANTYP as
                 SELECT
                 plantyp_id,
                 plantyp_bez,
                 dat_extrakt
                 FROM dbp_view.v_ivs_l_plantyp;