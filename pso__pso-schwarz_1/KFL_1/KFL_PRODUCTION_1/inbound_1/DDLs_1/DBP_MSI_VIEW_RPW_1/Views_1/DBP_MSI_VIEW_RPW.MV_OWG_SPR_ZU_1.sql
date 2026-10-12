CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_OWG_SPR_ZU_1
    (
    owg_id
    ,spr_id
    ,arthiertyp_id
    ,mandant_id
    ,owg_bez
    ,system_id
    )
    AS
       SELECT
       owg_id,
       spr_id,
       arthiertyp_id,
       mandant_id,
       owg_bez,
       7
       FROM dbp_view.v_owg_spr_zu_1
       WHERE mandant_id = 1
       AND  spr_id = 22
       AND  arthiertyp_id = 2
       --17.07.10: Filterung der Korrektur- WG aus VIS/MIS
       AND owg_id >= -3;