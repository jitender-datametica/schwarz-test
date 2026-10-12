CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GP_KONDITIONSGRUPPE_SPR_ZU (
    mandant_id
    ,gp_id
    ,konditionsgruppe_id
    ,spr_id
    ,gp_konditionsgruppe_bez
) AS SELECT
    mandant_id
    ,gp_id
    ,konditionsgruppe_id
    ,spr_id
    ,gp_konditionsgruppe_bez
FROM dbp_view.v_gp_konditionsgruppe_spr_zu
WHERE mandant_id = 1;