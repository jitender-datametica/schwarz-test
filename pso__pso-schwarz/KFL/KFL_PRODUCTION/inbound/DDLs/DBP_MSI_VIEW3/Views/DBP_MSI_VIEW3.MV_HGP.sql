CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_HGP
(
hgp_id
,hgp_name
,mandant_id
,zek_id
,einkaufsorganisation_id
)
AS
   SELECT
  DISTINCT gp_id, gp_name, mandant_id, zek_id, einkaufsorganisation_id FROM dbp_view.v_gp WHERE gp_id IN
   (SELECT CASE WHEN hgp_id = -1  OR hgp_id IS NULL THEN gp_id ELSE hgp_id END FROM dbp_view.v_gp  )
-- entfernt, 31.10.2012 lt. Mail M. Schauder
-- AND gp_id = -1 OR gp_id > 9999
;