CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_BELOS_LEISTUNGSART_1
(

mandant_id
,belos_leistungsart_id
)
AS
   SELECT

   mandant_id, belos_leistungsart_id

   FROM dbp_view.v_l_belos_leistungsart_1;