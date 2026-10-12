CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_GINFO_FLAECHE_IMMO_1
(
ginfo_flaeche_id
,ginfo_flaeche_typ_id
,mandant_id
,techn_platz_id
)
AS
   SELECT
   ginfo_flaeche_id, ginfo_flaeche_typ_id, mandant_id, techn_platz_id

   FROM dbp_view.v_l_ginfo_flaeche_1
   WHERE flaeche_quelle_id  in (2)
;