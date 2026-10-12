CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_RECH_ERFASSUNG_SPR_ZU_1
                               (
                               mandant_id
                               ,erfassung_id
                               ,spr_id
                               ,erfassung_bez
                               ,system_id
                               )
                               AS
                                  SELECT
                                  mandant_id,
                                  erfassung_id,
                                  spr_id,
                                  erfassung_bez,
                                  7
                                  FROM dbp_view.v_rech_erfassung_spr_zu_1
                                  WHERE mandant_id = 1
                                  AND spr_id=22
 ;