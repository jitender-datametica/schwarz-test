CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_L_KUNDENFAKTOR
(
kundenfaktor_id
,markt_fg
,fach_fg
)
AS
   SELECT
   kundenfaktor_id, CASE WHEN markt_fg = 1
   THEN 'links00.gif'
   ELSE 'leer.gif'
   END::VARCHAR(200)       zentrale_fg  -- Verweis auf Pfeil-Image ("->")
   , CASE WHEN fach_fg = 1
   THEN 'rechts00.gif'
   ELSE 'leer.gif'
   END::VARCHAR(200)       filiale_fg   -- Verweis auf Pfeil-Image ("<-")
   FROM dbp_view.v_l_geku_kundenfaktor;