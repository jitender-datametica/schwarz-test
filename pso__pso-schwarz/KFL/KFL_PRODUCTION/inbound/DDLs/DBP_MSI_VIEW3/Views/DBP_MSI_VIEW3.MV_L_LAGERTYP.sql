CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LAGERTYP
(
lagernummer_id
,lagertyp_id
,lagertyp_typ_id
,lagerzone_id
,mandant_id
,nb_id
,wup_id
,griffzone_typ_id
)
AS
   SELECT
   lagernummer_id, lagertyp_id, lagertyp_typ_id, lagerzone_id, mandant_id, nb_id, wup_id, griffzone_typ_id

   FROM dbp_view.v_l_lagertyp;