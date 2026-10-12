CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_IN_FI_BELEG_DET_2
AS 
SELECT
                     v01.mandant_id,
                     v01.buchungskreis_id,
                     v01.in_fi_beleg_id,
                     v01.in_fi_beleg_pos_id,
                     v01.best_beleg_id,
                     v01.best_beleg_pos_id,
                     bsak_bschl_id,
                     bseg_bschl_id,
                     v01.werk_id,
                     CASE WHEN soll_haben_kz ='S' THEN +1 ELSE  -1 END ind_vz,
                     CASE WHEN v04.wrg_typ_id = 1 THEN betrag_fi_beleg * ind_vz ELSE betrag_fi_beleg * ind_vz * umrechnungskurs  END AS betrag_fi_beleg,
                     CASE WHEN  bsak_bschl_id IN ('21', '32')  AND v04.wrg_typ_id = 1 THEN betrag_fi_beleg * ind_vz
                    WHEN  bsak_bschl_id IN ('21', '32')  AND v04.wrg_typ_id = 0 THEN betrag_fi_beleg * ind_vz  * umrechnungskurs
                    ELSE NULL END AS gutschrift_betrag,
                     CASE WHEN  bsak_bschl_id IN ('22', '31') AND v04.wrg_typ_id = 1 THEN betrag_fi_beleg * ind_vz
                    WHEN  bsak_bschl_id IN ('22', '31') AND v04.wrg_typ_id = 0 THEN betrag_fi_beleg * ind_vz * umrechnungskurs
                    ELSE NULL END AS rechnung_betrag,
                     menge_fi_beleg * ind_vz AS menge_fi_beleg,
                     v01.in_art_id,
                     v01.in_lief_id,
                     menge_einh_id,
                     v01.dat_buch

                    FROM dbp_msi_view_bis.tbl_MV_F_IN_FI_BELEG_DET_2 v01
                    CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v04;