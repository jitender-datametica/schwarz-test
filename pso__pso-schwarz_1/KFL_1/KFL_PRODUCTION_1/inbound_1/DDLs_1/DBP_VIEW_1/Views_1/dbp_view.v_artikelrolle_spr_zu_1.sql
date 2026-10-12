CREATE OR REPLACE VIEW dbp_view.v_artikelrolle_spr_zu_1
AS
SELECT
mandant_id
,artikelrolle_id
,spr_id
,artikelrolle_bez
FROM dbp_data.artikelrolle_spr_zu_1;