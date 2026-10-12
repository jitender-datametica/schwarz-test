CREATE OR REPLACE VIEW DBP_VIEW.V_MARKTMERKMAL_WERT_SPR_ZU_1
AS
SELECT
marktmerkmal_id,
marktmerkmal_wert,
spr_id,
marktmerkmal_wert_bez,
marktmerkmal_wert_kbez
FROM dbp_data.marktmerkmal_wert_spr_zu_1;


