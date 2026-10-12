CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_KONDITIONSART_SPR_ZU_CZ_2
(
system_id
,mandant_id
,spr_id
,KSCHL
,KSCHL_BEZ
)
AS
   SELECT
   system_id, mandant_id, spr_id, konditionsart_id AS KSCHL, konditionsart_bez AS KSCHL_BEZ
   FROM dbp_view.v_konditionsart_spr_zu_2
   WHERE spr_id = 124;