CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LAGER_BEWART
-- AP0014173, srom0404, neu erstellt anstelle von mv_lager_bewart (Namenskonvention)
(
lager_bewart_id
,mandant_id
,system_id
)
AS
   SELECT
   lager_bewart_id, mandant_id, system_id
   FROM dbp_view.v_l_lager_bewart;