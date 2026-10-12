CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_FAKTURA_1
(
auftraggeber_id,
dat_faktura,
faktura_beleg_id,
faktura_status_id,
fakturaart_id,
kalk_schema_id,
mandant_id,
storno_fg,
verkaufsorganisation_id,
wrg_id,
dat_erstellung
)
AS
   SELECT
  CAST(TRY_TO_NUMBER(auftraggeber_id,38,0) AS VARCHAR (10)) AS auftraggeber_id, dat_faktura, faktura_beleg_id, faktura_status_id, fakturaart_id, kalk_schema_id, mandant_id, storno_fg, verkaufsorganisation_id, wrg_id, dat_erstellung
   FROM dbp_view.v_besch_faktura_1;