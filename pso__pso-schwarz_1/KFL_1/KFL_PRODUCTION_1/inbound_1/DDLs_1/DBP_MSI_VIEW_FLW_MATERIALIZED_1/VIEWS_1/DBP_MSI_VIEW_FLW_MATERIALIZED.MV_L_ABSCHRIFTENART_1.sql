create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_ABSCHRIFTENART_1(
	ABSCHRIFTART_ID,
	ABSCHRIFTART_BEZ,
	MANDANT_ID,
	SPR_ID
) as
   SELECT
  v01.abschriftart_id, v01.abschriftart_bez, v01.mandant_id, v01.spr_id
   FROM dbp_view.v_abschriftart_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id=1


   -- Abschriftenarten aus CZ
   UNION

   SELECT
   v01.preis_aend_grund_id AS abschriftart_id, v01.preis_aend_grund_bez AS abschriftart_bez, v01.mandant_id, v01.spr_id
   FROM dbp_view.v_preis_aenderung_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id=2;