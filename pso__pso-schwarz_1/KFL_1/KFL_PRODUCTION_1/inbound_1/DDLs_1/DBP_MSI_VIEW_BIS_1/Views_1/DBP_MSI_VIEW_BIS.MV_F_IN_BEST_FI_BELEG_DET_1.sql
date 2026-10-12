CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_IN_BEST_FI_BELEG_DET_1
           AS 
           SELECT
            v01.mandant_id,
            v01.in_fi_beleg_id,
            v01.in_fi_beleg_pos_id,
            v01.best_beleg_id,
            v01.best_beleg_pos_id,
            v01.dat_buch,
            v01.bsak_bschl_id,
            v01.bseg_bschl_id,
            v01.ind_vz,
            v01.bestell_menge_fi_beleg,
            v01.in_art_id,
            v01.in_lief_id,
            v01.werk_id,
            v01.rech_werk_id,
            v01.rech_in_art_id,
            v01.bestellart_id,
            v01. rech_plan_id,
            v01.endrech_fg,
            v01.einkaufsorganisation_id,
            v01.buchungskreis_id,
            v01.dat_von_rb,
            CASE WHEN v04.wrg_typ_id = 1 THEN betrag_fi_beleg * ind_vz ELSE betrag_fi_beleg * ind_vz * umrechnungskurs END AS bestell_betrag_fi_beleg
            FROM dbp_msi_view_bis.TBL_MV_F_IN_BEST_FI_BELEG_DET_1 v01
            CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v04;