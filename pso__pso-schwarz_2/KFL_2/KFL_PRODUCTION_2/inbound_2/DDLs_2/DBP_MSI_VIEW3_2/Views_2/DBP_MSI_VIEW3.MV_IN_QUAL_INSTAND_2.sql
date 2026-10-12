CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_QUAL_INSTAND_2
(
mandant_id
,qual_meldung_id
,ausfall_fg
,ausfallzeit_sekunden
)
AS
   SELECT
   mandant_id, qual_meldung_id, ausfall_fg, ausfallzeit_sekunden
   FROM dbp_view.v_in_qual_instand_2;