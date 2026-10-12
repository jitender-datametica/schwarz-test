create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_IN_AUFTRAG(
	MANDANT_ID,
	AUFTRAG_ID,
	AUFTRAGSART_ID,
	AUFTRAG_BEZ,
	DAT_START
) as
   SELECT
   v01.mandant_id, v01.auftrag_id, v01.auftragsart_id, v03.art_bez AS auftrag_bez, v02.dat_start

   FROM dbp_view.v_flw_auftrag v01-- AUFK

   JOIN dbp_view.v_flw_auftrag_pps v02--AFKO

   ON v01.mandant_id = v02.mandant_id
   AND v01.auftrag_id = v02.auftrag_id
   LEFT OUTER JOIN dbp_view.v_flw_art_spr_zu v03-- MARM fuer MPA Texte

   ON v01.mandant_id = v03.mandant_id
   AND v02.flw_art_id = v03.flw_art_id

   JOIN dbp_msi.akt_msi_user_spr_zu v04
   ON v03.spr_id = v04.spr_id

   WHERE v01.auftragsart_id IN ('FL02','FL04')
   AND v01.mandant_id IN (1,2)

   UNION ALL

   --TRENN Auftraege
   SELECT
   v01.mandant_id, v01.auftrag_id, v02.auftragsart_id, v03.auftrag_bez AS auftrag_bez, v01.dat_start

   FROM dbp_view.v_flw_auftrag_pps v01--AFKO statt COKO

   JOIN dbp_view.v_flw_auftrag v02-- AUFK

   ON v01.mandant_id = v02.mandant_id
   AND v01.auftrag_id = v02.auftrag_id

   JOIN dbp_view.v_flw_trenn_auftrag v03-- COKO fuer TPA Texte

   ON v01.mandant_id = v03.mandant_id
   AND v01.auftrag_id = v03.auftrag_id

   WHERE v02.auftragsart_id IN ('ZPP1','-1')
   AND v01.mandant_id IN (1,2);