CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_OBJEKTART as
                             -- 2008-12-15
                             -- LOOKUP Objektart
                             -- NEU strukturiert

                             SELECT
                             mandant_id,
                             objektart_id
                             FROM dbp_view.v_ivs_l_objektart;