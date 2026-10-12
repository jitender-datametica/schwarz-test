CREATE OR REPLACE VIEW dbp_data_center.tv_zekp_1
AS
SELECT
mandant_id,
wup_id AS WERKS,
dat_von AS DATAB,
gp_id AS LIFNR,
ek_brutto AS ABRUT,
ek_mep AS MEPRE,
logistikkostenzuschlag AS LOKAU,
ek_netto_bnk AS AKNB
FROM dbp_view.v_art_gp_wup_zu_per_1
WHERE mandant_id = 1
AND dat_bis = '9999-12-31';