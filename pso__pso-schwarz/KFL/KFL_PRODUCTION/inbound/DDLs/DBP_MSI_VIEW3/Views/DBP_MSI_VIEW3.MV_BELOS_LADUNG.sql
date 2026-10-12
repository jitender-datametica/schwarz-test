CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_LADUNG
(
mandant_id
,belos_ladung_id
,spedition_hub_id
,gewicht_gesamt
,anzahl_auftrag
)
AS
   SELECT
  mandant_id, belos_ladung_id, coalesce(spedition_hub_id , -1), gewicht_gesamt, anzahl_auftrag

   FROM dbp_view.v_belos_ladung;