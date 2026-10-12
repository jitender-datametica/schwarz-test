create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BELOS_LADUNG_2(
	MANDANT_ID,
	BELOS_LADUNG_ID,
	SPEDITION_HUB_ID,
	GEWICHT_GESAMT,
	ANZAHL_AUFTRAG
) as
   SELECT
  mandant_id, belos_ladung_id, coalesce(spedition_hub_id , -1), gewicht_gesamt, anzahl_auftrag

   FROM dbp_view.v_belos_ladung_2;