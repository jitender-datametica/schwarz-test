CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_BUERGSCHAFT_TYP_2 as
                    -- 2013-04-11
                    -- LOOKUP/SPRACHE Buergschaftstyp (Mietsicherheiten)
                    -- 2013-04-11 : Redesign Offene Posten + Mietsicherheiten

                    SELECT
                    lbt.buergschaft_typ_id,
                    lbt.buergschaft_typ_bez
             FROM dbp_view.v_l_buergschaft_typ_2  lbt;