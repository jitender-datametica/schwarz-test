CREATE OR REPLACE VIEW DBP_VIEW.V_AUTODISPO_DIF_TAG_2
AS
SELECT
mandant_id,
kunde_id,
art_id,
dat,
dat_ausfuehrung,
dif_typ_id,
dif_status_id,
dif_wert,
dif_kommentar,
sap_returncode
FROM dbp_data.autodispo_dif_tag_2;