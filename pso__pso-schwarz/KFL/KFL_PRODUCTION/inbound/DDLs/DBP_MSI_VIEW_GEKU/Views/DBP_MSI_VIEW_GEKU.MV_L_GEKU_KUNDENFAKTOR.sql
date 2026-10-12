CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_GEKU_KUNDENFAKTOR
(
kundenfaktor_id
,markt_fg
,fach_fg
)
AS
   SELECT
   kundenfaktor_id
   , markt_fg
   , fach_fg
   FROM dbp_view.v_l_geku_kundenfaktor;