CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_AIS_MANDANT_WUP_1
-- 14.08.2012 A. Lipkin ergänzt um nb_1 ID
-- 30.01.2012 T.Bachmann erweitert um gp_id
(
mandant_id
,wup_id
,nb_id
,gp_id
,stat_bundesamt_wup_id
)
AS
   SELECT
  mandant_id, wup_id, CAST(0 AS SMALLINT) AS nb_id, gp_id, stat_bundesamt_wup_id
   FROM dbp_msi_v_view.v_ais_mandant_wup_1
   WHERE mandant_id = 1;