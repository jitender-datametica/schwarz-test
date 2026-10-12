CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_ARTKZ_POSTEN
-- 24.10.2013 twie neue Lookup von AIS_DE uebernommen, fuer DE und CZ
(
posten_id
, posten_bez
, mandant_id
)
AS
   SELECT
  posten_id, posten_bez, mandant_id
   FROM dbp_view.v_artkz_posten v01
   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id
   WHERE (posten_id IN ('PN', '')
   AND mandant_id = 1)
   OR
   (posten_id IN ('0','1')
   AND mandant_id = 2);