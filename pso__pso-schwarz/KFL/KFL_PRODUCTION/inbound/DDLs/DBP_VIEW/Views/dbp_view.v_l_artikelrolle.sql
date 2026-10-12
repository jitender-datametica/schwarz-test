CREATE OR REPLACE VIEW dbp_view.v_l_artikelrolle
AS
SELECT
mandant_id
,artikelrolle_id
,artikelrolle_bez
FROM dbp_data.l_artikelrolle;