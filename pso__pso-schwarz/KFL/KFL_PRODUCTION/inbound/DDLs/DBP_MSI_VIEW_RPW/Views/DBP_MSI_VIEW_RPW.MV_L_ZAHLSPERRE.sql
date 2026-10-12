CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_ZAHLSPERRE
(
mandant_id
,zahlsperre_id
,system_id
)
AS
   SELECT
   mandant_id,
   zahlsperre_id,
   7
   FROM dbp_view.v_l_zahlsperre
   WHERE mandant_id = 1
 ;