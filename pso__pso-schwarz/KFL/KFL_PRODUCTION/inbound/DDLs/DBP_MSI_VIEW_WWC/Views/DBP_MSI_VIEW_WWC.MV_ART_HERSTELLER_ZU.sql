CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_HERSTELLER_ZU
(
mandant_id
,art_id
,herst_id
,gp_art_id
,mhd_zeitraum_dz
)
AS
   --12.09.2023, SPEC0171511, Alle Mandaten in die View aufnehmen
   SELECT mandant_id, art_id, herst_id, gp_art_id, mhd_zeitraum_dz
   FROM dbp_view.v_art_gp_zu_per
   --alle Mandanten in View aufnehmen
   --WHERE mandant_id = 1
   WHERE dat_bis = '9999-12-31';