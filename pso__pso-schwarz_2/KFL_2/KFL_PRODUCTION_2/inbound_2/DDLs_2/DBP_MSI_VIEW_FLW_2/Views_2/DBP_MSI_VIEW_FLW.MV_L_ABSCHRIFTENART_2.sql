CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_ABSCHRIFTENART_2
-- 27.09.2013 twie: Abschriftenarten aus CZ dazugenommen
(
abschriftart_id
,abschriftart_bez
,mandant_id
,spr_id
)
AS
   SELECT
  v01.abschriftart_id, v01.abschriftart_bez, v01.mandant_id, v01.spr_id
   FROM dbp_view.v_abschriftart_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id=1


   -- Abschriftenarten aus CZ
   UNION

   SELECT
   v01.preis_aend_grund_id AS abschriftart_id, v01.preis_aend_grund_bez AS abschriftart_bez, v01.mandant_id, v01.spr_id
   FROM dbp_view.v_preis_aenderung_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id=2;