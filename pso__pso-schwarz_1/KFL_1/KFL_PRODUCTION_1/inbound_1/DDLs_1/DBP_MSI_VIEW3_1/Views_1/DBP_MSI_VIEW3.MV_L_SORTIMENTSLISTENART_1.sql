CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_SORTIMENTSLISTENART_1
(
mandant_id ,
sortimentslistenart_id
)
AS
   SELECT
   mandant_id,
   sortimentslistenart_id
   FROM dbp_view.v_L_sortimentslistenart_1;