CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_L_AUFTRAGSART_1
(
mandant_id
,system_id
,auftragsart_id
)
AS
   SELECT
   mandant_id, system_id, auftragsart_id
   FROM dbp_view.v_in_l_auftragsart_1;