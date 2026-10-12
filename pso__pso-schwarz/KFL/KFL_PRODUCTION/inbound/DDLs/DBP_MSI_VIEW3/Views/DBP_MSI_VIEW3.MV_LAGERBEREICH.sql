CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAGERBEREICH
(
lagerbereich_id
,lagernummer_id
,lagertyp_id
,mandant_id
,nb_id
,wup_id
)
AS
   SELECT
   lagerbereich_id, lagernummer_id, lagertyp_id, mandant_id, nb_id, wup_id
   FROM dbp_view.v_l_lagerbereich;