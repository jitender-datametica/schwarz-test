CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_KONDITIONSGRUPPE_SPR_ZU_2
             (
             system_id
             ,mandant_id
             ,konditionsgruppe_id
             ,spr_id
             ,konditionsgruppe_bez
             )
             AS
                SELECT
                7,
                mandant_id,
                konditionsgruppe_id,
                spr_id,
                konditionsgruppe_bez
                FROM dbp_view.v_konditionsgruppe_spr_zu
                WHERE mandant_id = 1
                AND  spr_id = 22;